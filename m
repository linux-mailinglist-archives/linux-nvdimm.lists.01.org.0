Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6C41906
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 01:40:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 642FF21295B3A;
	Tue, 11 Jun 2019 16:40:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 265BF21290DEC
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 16:40:11 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jun 2019 16:40:11 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga005.fm.intel.com with ESMTP; 11 Jun 2019 16:40:10 -0700
Subject: [PATCH 2/6] libnvdimm/bus: Prevent duplicate device_unregister() calls
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Tue, 11 Jun 2019 16:25:54 -0700
Message-ID: <156029555412.419799.17084493871021141653.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156029554317.419799.1324389595953183385.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Erwin Tsaur <erwin.tsaur@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

A multithreaded namespace creation/destruction stress test currently
fails with signatures like the following:

    sysfs group 'power' not found for kobject 'dax1.1'
    RIP: 0010:sysfs_remove_group+0x76/0x80
    Call Trace:
     device_del+0x73/0x370
     device_unregister+0x16/0x50
     nd_async_device_unregister+0x1e/0x30 [libnvdimm]
     async_run_entry_fn+0x39/0x160
     process_one_work+0x23c/0x5e0
     worker_thread+0x3c/0x390

    BUG: kernel NULL pointer dereference, address: 0000000000000020
    RIP: 0010:klist_put+0x1b/0x6c
    Call Trace:
     klist_del+0xe/0x10
     device_del+0x8a/0x2c9
     ? __switch_to_asm+0x34/0x70
     ? __switch_to_asm+0x40/0x70
     device_unregister+0x44/0x4f
     nd_async_device_unregister+0x22/0x2d [libnvdimm]
     async_run_entry_fn+0x47/0x15a
     process_one_work+0x1a2/0x2eb
     worker_thread+0x1b8/0x26e

Use the kill_device() helper to atomically resolve the race of multiple
threads issuing kill, device_unregister(), requests.

Reported-by: Jane Chu <jane.chu@oracle.com>
Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Fixes: 4d88a97aa9e8 ("libnvdimm, nvdimm: dimm driver and base libnvdimm device-driver...")
Cc: <stable@vger.kernel.org>
Link: https://github.com/pmem/ndctl/issues/96
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/bus.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 2dca3034fee0..42713b210f51 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -547,13 +547,38 @@ EXPORT_SYMBOL(nd_device_register);
 
 void nd_device_unregister(struct device *dev, enum nd_async_mode mode)
 {
+	bool killed;
+
 	switch (mode) {
 	case ND_ASYNC:
+		/*
+		 * In the async case this is being triggered with the
+		 * device lock held and the unregistration work needs to
+		 * be moved out of line iff this is thread has won the
+		 * race to schedule the deletion.
+		 */
+		if (!kill_device(dev))
+			return;
+
 		get_device(dev);
 		async_schedule_domain(nd_async_device_unregister, dev,
 				&nd_async_domain);
 		break;
 	case ND_SYNC:
+		/*
+		 * In the sync case the device is being unregistered due
+		 * to a state change of the parent. Claim the kill state
+		 * to synchronize against other unregistration requests,
+		 * or otherwise let the async path handle it if the
+		 * unregistration was already queued.
+		 */
+		device_lock(dev);
+		killed = kill_device(dev);
+		device_unlock(dev);
+
+		if (!killed)
+			return;
+
 		nd_synchronize();
 		device_unregister(dev);
 		break;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
