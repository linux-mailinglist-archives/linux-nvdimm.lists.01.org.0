Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2B223566
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC6BA11EDD965;
	Fri, 17 Jul 2020 00:21:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E8DD11E9F62D
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:07 -0700 (PDT)
IronPort-SDR: qzdL7ouCz7WOdnmaP65MM7844aaPssvtkLsRytXKFtxNk7GPwLX3AjCLxljm07g0mO04ZqJK/E
 phumKoquU0rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129633006"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="129633006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:07 -0700
IronPort-SDR: d+rBzvIqgHnaR+GhYVSKdQJaqDgG6px7MwHBlQpAXhhFUwBpMJADWMQT0thDv3dy+A5eGuvTxT
 jexEd3Xx6KHQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="486880410"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:06 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 11/17] drivers/dax: Expand lock scope to cover the use of addresses
Date: Fri, 17 Jul 2020 00:20:50 -0700
Message-Id: <20200717072056.73134-12-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: AEZV7KSGYAITZKQEEL2ZHR7NSWIIFHSM
X-Message-ID-Hash: AEZV7KSGYAITZKQEEL2ZHR7NSWIIFHSM
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AEZV7KSGYAITZKQEEL2ZHR7NSWIIFHSM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

The addition of PKS protection to dax read lock/unlock will require that
the address returned by dax_direct_access() be protected by this lock.

While not technically necessary for this series, this corrects the
locking by ensuring that the use of kaddr and end_kaddr are covered by
the dax read lock/unlock.

Change the lock scope to cover the kaddr and end_kaddr use.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..021739768093 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -103,11 +103,11 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	id = dax_read_lock();
 	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
-	dax_read_unlock(id);
 
 	if (len < 1 || len2 < 1) {
 		pr_debug("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len < 1 ? len : len2);
+		dax_read_unlock(id);
 		return false;
 	}
 
@@ -137,6 +137,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		put_dev_pagemap(end_pgmap);
 
 	}
+	dax_read_unlock(id);
 
 	if (!dax_enabled) {
 		pr_debug("%s: error: dax support not enabled\n",
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
