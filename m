Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2BF223563
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 09:21:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C89A11EDD969;
	Fri, 17 Jul 2020 00:21:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D1DC411EB8DF8
	for <linux-nvdimm@lists.01.org>; Fri, 17 Jul 2020 00:21:06 -0700 (PDT)
IronPort-SDR: OLVdE9MDNkZgw7DezLNAiRwj6ycmzTYjIJ04JpXNmQKXZiOuxm4ucoBZ21CaNvSA1vgLc4tvXm
 KY6Bpj5SP5Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="147535672"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="147535672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:06 -0700
IronPort-SDR: SpuOyWqnLmOe+gy1lr8SUmikVFfb6NOmjlt8qmzgs7esLkKOTHHgnMN1Tf86OkViIwr3GcIVrE
 LFTaSVYSpZYw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800";
   d="scan'208";a="460761744"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 00:21:05 -0700
From: ira.weiny@intel.com
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC V2 09/17] memremap: Convert devmap static branch to {inc,dec}
Date: Fri, 17 Jul 2020 00:20:48 -0700
Message-Id: <20200717072056.73134-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20200717072056.73134-1-ira.weiny@intel.com>
References: <20200717072056.73134-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 4UXMOP3PTIRGY2JDA7CBF6UZEEQVB2DN
X-Message-ID-Hash: 4UXMOP3PTIRGY2JDA7CBF6UZEEQVB2DN
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4UXMOP3PTIRGY2JDA7CBF6UZEEQVB2DN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Ira Weiny <ira.weiny@intel.com>

While reviewing Protection Key Supervisor support it was pointed out
that using a counter to track static branch enable was an anti-pattern
which was better solved using the provided static_branch_{inc,dec}
functions.[1]

Fix up devmap_managed_key to work the same way.  Also this should be
safer because there is a very small (very unlikely) race when multiple
callers try to enable at the same time.

[1] https://lore.kernel.org/lkml/20200714194031.GI5523@worktop.programming.kicks-ass.net/

To: Dan Williams <dan.j.williams@intel.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 mm/memremap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 03e38b7a38f1..9fb9ad500e78 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -40,12 +40,10 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
 #ifdef CONFIG_DEV_PAGEMAP_OPS
 DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
 EXPORT_SYMBOL(devmap_managed_key);
-static atomic_t devmap_managed_enable;
 
 static void devmap_managed_enable_put(void)
 {
-	if (atomic_dec_and_test(&devmap_managed_enable))
-		static_branch_disable(&devmap_managed_key);
+	static_branch_dec(&devmap_managed_key);
 }
 
 static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
@@ -56,8 +54,7 @@ static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
 		return -EINVAL;
 	}
 
-	if (atomic_inc_return(&devmap_managed_enable) == 1)
-		static_branch_enable(&devmap_managed_key);
+	static_branch_inc(&devmap_managed_key);
 	return 0;
 }
 #else
-- 
2.28.0.rc0.12.gb6a658bd00c9
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
