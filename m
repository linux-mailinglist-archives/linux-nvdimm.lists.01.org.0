Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7077F24B3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 02:57:58 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B376100DC2A7;
	Wed,  6 Nov 2019 18:00:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8852C100DC2A7
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 18:00:25 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:54 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="201272088"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 17:57:54 -0800
Subject: [PATCH v8 09/12] dax: Fix alloc_dax_region() compile warning
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@redhat.com
Date: Wed, 06 Nov 2019 17:43:37 -0800
Message-ID: <157309101783.1579826.6555129802030578776.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309097008.1579826.12818463304589384434.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: TDKT3E7INSWG56WAEVNMO42FPOZKYIPK
X-Message-ID-Hash: TDKT3E7INSWG56WAEVNMO42FPOZKYIPK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kbuild test robot <lkp@intel.com>, peterz@infradead.org, dave.hansen@linux.intel.com, ard.biesheuvel@linaro.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-efi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TDKT3E7INSWG56WAEVNMO42FPOZKYIPK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

PFN flags are (unsigned long long), fix the alloc_dax_region() calling
convention to fix warnings of the form:

>> include/linux/pfn_t.h:18:17: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define PFN_DEV (1ULL << (BITS_PER_LONG_LONG - 3))

Cc: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/bus.c         |    2 +-
 drivers/dax/bus.h         |    2 +-
 drivers/dax/dax-private.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 8fafbeab510a..eccdda1f7b71 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -227,7 +227,7 @@ static void dax_region_unregister(void *region)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align,
-		unsigned long pfn_flags)
+		unsigned long long pfn_flags)
 {
 	struct dax_region *dax_region;
 
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 8619e3299943..9e4eba67e8b9 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -11,7 +11,7 @@ struct dax_region;
 void dax_region_put(struct dax_region *dax_region);
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct resource *res, int target_node, unsigned int align,
-		unsigned long flags);
+		unsigned long long flags);
 
 enum dev_dax_subsys {
 	DEV_DAX_BUS,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 6ccca3b890d6..3107ce80e809 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -32,7 +32,7 @@ struct dax_region {
 	struct device *dev;
 	unsigned int align;
 	struct resource res;
-	unsigned long pfn_flags;
+	unsigned long long pfn_flags;
 };
 
 /**
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
