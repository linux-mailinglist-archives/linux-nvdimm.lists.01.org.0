Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4221A2D9
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 16:57:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5170111FF49B;
	Thu,  9 Jul 2020 07:57:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.96.170.134; helo=cloudserver094114.home.pl; envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN> 
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B8A8A111F370F
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jul 2020 07:57:17 -0700 (PDT)
Received: from 89-64-83-236.dynamic.chello.pl (89.64.83.236) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 6f4b9f3a7ac1aaf9; Thu, 9 Jul 2020 16:57:14 +0200
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and callback for firmware activation
Date: Thu, 09 Jul 2020 16:57:12 +0200
Message-ID: <23449996.3uVv1d17cZ@kreacher>
In-Reply-To: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com> <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-ID-Hash: 2VHFASE5UM36J7YPPACPO6ECXDSI7347
X-Message-ID-Hash: 2VHFASE5UM36J7YPPACPO6ECXDSI7347
X-MailFrom: rjw@rjwysocki.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2VHFASE5UM36J7YPPACPO6ECXDSI7347/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: 7bit

On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced", all processes and device-DMA
> frozen.
> 
> It is already required that invoking device ->freeze() callbacks is
> sufficient to cease DMA. A device that continues memory writes outside
> of user-direction violates expectations of the PM core to be to
> establish a coherent hibernation image.
> 
> That said, RDMA devices are an example of a device that access memory
> outside of user process direction. RDMA drivers also typically assume
> the system they are operating in will never be hibernated. A solution
> for RDMA collisions with firmware activation is outside the scope of
> this change and may need to rely on being able to survive the platform
> imposed memory controller quiesce period.

Thanks for following my suggestion to use the hibernation infrastructure
rather than the suspend one, but I think it would be better to go a bit
further with that.

Namely, after thinking about this a bit more I have come to the conclusion
that what is needed is an ability to execute a function, inside of the
kernel, in a "quiet" environment in which memory updates are unlikely.

While the hibernation infrastructure as is can be used for that, kind of, IMO
it would be cleaner to introduce a helper for that, like in the (untested)
patch below, so if the "quiet execution environment" is needed, whoever
needs it may simply pass a function to hibernate_quiet_exec() and provide
whatever user-space I/F is suitable on top of that.

Please let me know what you think.

Cheers!

---
 include/linux/suspend.h  |    6 ++
 kernel/power/hibernate.c |   97 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -795,6 +795,103 @@ int hibernate(void)
 	return error;
 }
 
+/**
+ * hibernate_quiet_exec - Execute a function with all devices frozen.
+ * @func: Function to execute.
+ * @data: Data pointer to pass to @func.
+ *
+ * Return the @func return value or an error code if it cannot be executed.
+ */
+int hibernate_quiet_exec(int (*func)(void *data), void *data)
+{
+	int error, nr_calls = 0;
+
+	lock_system_sleep();
+
+	if (!hibernate_acquire()) {
+		error = -EBUSY;
+		goto unlock;
+	}
+
+	pm_prepare_console();
+
+	error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
+	if (error) {
+		nr_calls--;
+		goto exit;
+	}
+
+	error = freeze_processes();
+	if (error)
+		goto exit;
+
+	lock_device_hotplug();
+
+	pm_suspend_clear_flags();
+
+	error = platform_begin(true);
+	if (error)
+		goto thaw;
+
+	error = freeze_kernel_threads();
+	if (error)
+		goto thaw;
+
+	error = dpm_prepare(PMSG_FREEZE);
+	if (error)
+		goto dpm_complete;
+
+	suspend_console();
+
+	error = dpm_suspend(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = dpm_suspend_end(PMSG_FREEZE);
+	if (error)
+		goto dpm_resume;
+
+	error = platform_pre_snapshot(true);
+	if (error)
+		goto skip;
+
+	error = func(data);
+
+skip:
+	platform_finish(true);
+
+	dpm_resume_start(PMSG_THAW);
+
+dpm_resume:
+	dpm_resume(PMSG_THAW);
+
+	resume_console();
+
+dpm_complete:
+	dpm_complete(PMSG_THAW);
+
+	thaw_kernel_threads();
+
+thaw:
+	platform_end(true);
+
+	unlock_device_hotplug();
+
+	thaw_processes();
+
+exit:
+	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
+
+	pm_restore_console();
+
+	hibernate_release();
+
+unlock:
+	unlock_system_sleep();
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(hibernate_quiet_exec);
 
 /**
  * software_resume - Resume from a saved hibernation image.
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -453,6 +453,8 @@ extern bool hibernation_available(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
+
+int hibernate_quiet_exec(int (*func)(void *data), void *data);
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
 static inline void register_nosave_region_late(unsigned long b, unsigned long e) {}
@@ -464,6 +466,10 @@ static inline void hibernation_set_ops(c
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+
+static inline hibernate_quiet_exec(int (*func)(void *data), void *data) {
+	return -ENOTSUPP;
+}
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
