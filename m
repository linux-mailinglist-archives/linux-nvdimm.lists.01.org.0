Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9028EC5B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Oct 2020 06:46:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0A507159E6B71;
	Wed, 14 Oct 2020 21:46:36 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 94A97159E6B70
	for <linux-nvdimm@lists.01.org>; Wed, 14 Oct 2020 21:46:33 -0700 (PDT)
IronPort-SDR: ufJ8hGBaf4g7GeszI3I4r7up/TnyGvnIehh0pr/gw+oTdJD4kM/Psm76emGtzVvW2xXaQyr1s6
 RcaKU1T8BmOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="145564991"
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="145564991"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:46:32 -0700
IronPort-SDR: okZevJNyFoB0pDRj0graDCFAGBe85RU4H4aY8F5klmxXZx1X/fo3dQRhH8k0J0Lzctn9GCjeCZ
 aeWfHIgGHVcw==
X-IronPort-AV: E=Sophos;i="5.77,377,1596524400";
   d="scan'208";a="531105799"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 21:46:32 -0700
Date: Wed, 14 Oct 2020 21:46:32 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH RFC V3 9/9] x86/pks: Add PKS test code
Message-ID: <20201015044632.GT2046448@iweiny-DESK2.sc.intel.com>
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-10-ira.weiny@intel.com>
 <3f9ebe3b-5c1c-6a69-3779-6f90d66227bd@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3f9ebe3b-5c1c-6a69-3779-6f90d66227bd@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: JBXA5N3526LGC2JT76QTSV5GFHICXUP3
X-Message-ID-Hash: JBXA5N3526LGC2JT76QTSV5GFHICXUP3
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JBXA5N3526LGC2JT76QTSV5GFHICXUP3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 13, 2020 at 12:02:07PM -0700, Dave Hansen wrote:
> On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> >  #ifdef CONFIG_X86_32
> >  	/*
> >  	 * We can fault-in kernel-space virtual memory on-demand. The
> > diff --git a/include/linux/pkeys.h b/include/linux/pkeys.h
> > index cc3510cde64e..f9552bd9341f 100644
> > --- a/include/linux/pkeys.h
> > +++ b/include/linux/pkeys.h
> > @@ -47,7 +47,6 @@ static inline bool arch_pkeys_enabled(void)
> >  static inline void copy_init_pkru_to_fpregs(void)
> >  {
> >  }
> > -
> >  #endif /* ! CONFIG_ARCH_HAS_PKEYS */
> 
> ^ Whitespace damage

Done.

> 
> >  #ifndef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 0c781f912f9f..f015c09ba5a1 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2400,6 +2400,18 @@ config HYPERV_TESTING
> >  	help
> >  	  Select this option to enable Hyper-V vmbus testing.
> >  
> > +config PKS_TESTING
> > +	bool "PKey(S)upervisor testing"
> 
> Seems like we need a space in there somewhere.

heheh...  yea...

> 
> > +	pid = fork();
> > +	if (pid == 0) {
> > +		fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
> > +		if (fd < 0) {
> > +			printf("cannot open file\n");
> > +			return -1;
> > +		}
> > +
> 
> Will this return code make anybody mad?  Should we have a nicer return
> code for when this is running on non-PKS hardware?

I'm not sure it will matter much but I think it is better to report the missing
file.[1]

> 
> I'm not going to be too picky about this.  I'll just ask one question:
> Has this found real bugs for you?

Many, especially regressions as things have changed.

> 
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> 

Thanks,
Ira

[1]

diff --git a/tools/testing/selftests/x86/test_pks.c b/tools/testing/selftests/x86/test_pks.c
index 8037a2a9ff5f..11be4e212d54 100644
--- a/tools/testing/selftests/x86/test_pks.c
+++ b/tools/testing/selftests/x86/test_pks.c
@@ -11,6 +11,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
+#define PKS_TEST_FILE "/sys/kernel/debug/x86/run_pks"
+
 int main(void)
 {
        cpu_set_t cpuset;
@@ -25,9 +27,9 @@ int main(void)
 
        pid = fork();
        if (pid == 0) {
-               fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+               fd = open(PKS_TEST_FILE, O_RDWR);
                if (fd < 0) {
-                       printf("cannot open file\n");
+                       printf("cannot open %s\n", PKS_TEST_FILE);
                        return -1;
                }
 
@@ -45,9 +47,9 @@ int main(void)
        } else {
                sleep(2);
 
-               fd = open("/sys/kernel/debug/x86/run_pks", O_RDWR);
+               fd = open(PKS_TEST_FILE, O_RDWR);
                if (fd < 0) {
-                       printf("cannot open file\n");
+                       printf("cannot open %s\n", PKS_TEST_FILE);
                        return -1;
                }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
