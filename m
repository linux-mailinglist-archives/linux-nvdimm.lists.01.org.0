Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B46CA6C42A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Jul 2019 03:22:41 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1941212C01E3;
	Wed, 17 Jul 2019 18:25:08 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 575D0212C01CC
 for <linux-nvdimm@lists.01.org>; Wed, 17 Jul 2019 18:25:07 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 18:22:38 -0700
X-IronPort-AV: E=Sophos;i="5.64,276,1559545200"; d="scan'208";a="366754497"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2019 18:22:38 -0700
Subject: [PATCH v2 6/7] libnvdimm/bus: Fix wait_nvdimm_bus_probe_idle() ABBA
 deadlock
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 17 Jul 2019 18:08:21 -0700
Message-ID: <156341210094.292348.2384694131126767789.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156341206785.292348.1660822720191643298.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

A multithreaded namespace creation/destruction stress test currently
deadlocks with the following lockup signature:

    INFO: task ndctl:2924 blocked for more than 122 seconds.
          Tainted: G           OE     5.2.0-rc4+ #3382
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
    ndctl           D    0  2924   1176 0x00000000
    Call Trace:
     ? __schedule+0x27e/0x780
     schedule+0x30/0xb0
     wait_nvdimm_bus_probe_idle+0x8a/0xd0 [libnvdimm]
     ? finish_wait+0x80/0x80
     uuid_store+0xe6/0x2e0 [libnvdimm]
     kernfs_fop_write+0xf0/0x1a0
     vfs_write+0xb7/0x1b0
     ksys_write+0x5c/0xd0
     do_syscall_64+0x60/0x240

     INFO: task ndctl:2923 blocked for more than 122 seconds.
           Tainted: G           OE     5.2.0-rc4+ #3382
     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
     ndctl           D    0  2923   1175 0x00000000
     Call Trace:
      ? __schedule+0x27e/0x780
      ? __mutex_lock+0x489/0x910
      schedule+0x30/0xb0
      schedule_preempt_disabled+0x11/0x20
      __mutex_lock+0x48e/0x910
      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
      ? __lock_acquire+0x23f/0x1710
      ? nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
      nvdimm_namespace_common_probe+0x95/0x4d0 [libnvdimm]
      __dax_pmem_probe+0x5e/0x210 [dax_pmem_core]
      ? nvdimm_bus_probe+0x1d0/0x2c0 [libnvdimm]
      dax_pmem_probe+0xc/0x20 [dax_pmem]
      nvdimm_bus_probe+0x90/0x2c0 [libnvdimm]
      really_probe+0xef/0x390
      driver_probe_device+0xb4/0x100

In this sequence an 'nd_dax' device is being probed and trying to take
the lock on its backing namespace to validate that the 'nd_dax' device
indeed has exclusive access to the backing namespace. Meanwhile, another
thread is trying to update the uuid property of that same backing
namespace. So one thread is in the probe path trying to acquire the
lock, and the other thread has acquired the lock and tries to flush the
probe path.

Fix this deadlock by not holding the namespace device_lock over the
wait_nvdimm_bus_probe_idle() synchronization step. In turn this requires
the device_lock to be held on entry to wait_nvdimm_bus_probe_idle() and
subsequently dropped internally to wait_nvdimm_bus_probe_idle().

Cc: <stable@vger.kernel.org>
Fixes: bf9bccc14c05 ("libnvdimm: pmem label sets and namespace instantiation")
Cc: Vishal Verma <vishal.l.verma@intel.com>
Tested-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c         |   14 +++++++++-----
 drivers/nvdimm/region_devs.c |    4 ++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index a38572bf486b..df41f3571dc9 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -887,10 +887,12 @@ void wait_nvdimm_bus_probe_idle(struct device *dev)
 	do {
 		if (nvdimm_bus->probe_active == 0)
 			break;
-		nvdimm_bus_unlock(&nvdimm_bus->dev);
+		nvdimm_bus_unlock(dev);
+		device_unlock(dev);
 		wait_event(nvdimm_bus->wait,
 				nvdimm_bus->probe_active == 0);
-		nvdimm_bus_lock(&nvdimm_bus->dev);
+		device_lock(dev);
+		nvdimm_bus_lock(dev);
 	} while (true);
 }
 
@@ -1016,7 +1018,7 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		case ND_CMD_ARS_START:
 		case ND_CMD_CLEAR_ERROR:
 		case ND_CMD_CALL:
-			dev_dbg(&nvdimm_bus->dev, "'%s' command while read-only.\n",
+			dev_dbg(dev, "'%s' command while read-only.\n",
 					nvdimm ? nvdimm_cmd_name(cmd)
 					: nvdimm_bus_cmd_name(cmd));
 			return -EPERM;
@@ -1105,7 +1107,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		goto out;
 	}
 
-	nvdimm_bus_lock(&nvdimm_bus->dev);
+	device_lock(dev);
+	nvdimm_bus_lock(dev);
 	rc = nd_cmd_clear_to_send(nvdimm_bus, nvdimm, func, buf);
 	if (rc)
 		goto out_unlock;
@@ -1125,7 +1128,8 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 		rc = -EFAULT;
 
 out_unlock:
-	nvdimm_bus_unlock(&nvdimm_bus->dev);
+	nvdimm_bus_unlock(dev);
+	device_unlock(dev);
 out:
 	kfree(in_env);
 	kfree(out_env);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4fed9ce9c2fe..a15276cdec7d 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -422,10 +422,12 @@ static ssize_t available_size_show(struct device *dev,
 	 * memory nvdimm_bus_lock() is dropped, but that's userspace's
 	 * problem to not race itself.
 	 */
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	available = nd_region_available_dpa(nd_region);
 	nvdimm_bus_unlock(dev);
+	device_unlock(dev);
 
 	return sprintf(buf, "%llu\n", available);
 }
@@ -437,10 +439,12 @@ static ssize_t max_available_extent_show(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev);
 	unsigned long long available = 0;
 
+	device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
 	available = nd_region_allocatable_dpa(nd_region);
 	nvdimm_bus_unlock(dev);
+	device_unlock(dev);
 
 	return sprintf(buf, "%llu\n", available);
 }

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
