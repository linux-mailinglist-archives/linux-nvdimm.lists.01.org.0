Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F175174957
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F225C10FC3596;
	Sat, 29 Feb 2020 12:39:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD37E10FC358D
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:36 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:44 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="232628958"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:44 -0800
Subject: [ndctl PATCH 29/36] ndctl/namespace: Update 'pfn' infoblock
 definition
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:39 -0800
Message-ID: <158300775957.2141307.2609326840825793142.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: GBAFP4UAHBQYLE72MT74FJMZY3OB2VC7
X-Message-ID-Hash: GBAFP4UAHBQYLE72MT74FJMZY3OB2VC7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GBAFP4UAHBQYLE72MT74FJMZY3OB2VC7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Grab the latest definition of the pfn infoblock in preparation for
creating a write-infoblock command, and update read-infoblock parsing.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |    2 ++
 ndctl/namespace.h |   12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index cfa0563f59a1..e38151430436 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1612,6 +1612,8 @@ static json_object *pfn_parse(struct pfn_sb *pfn_sb, struct ndctl_namespace *ndn
 	parse_hex(pfn_sb, start_pad, 32);
 	parse_hex(pfn_sb, end_trunc, 32);
 	parse_hex(pfn_sb, align, 32);
+	parse_hex(pfn_sb, page_size, 32);
+	parse_hex(pfn_sb, page_struct_size, 16);
 
 	return jblock;
 err:
diff --git a/ndctl/namespace.h b/ndctl/namespace.h
index 861dfbfa5127..0f17df20ca3a 100644
--- a/ndctl/namespace.h
+++ b/ndctl/namespace.h
@@ -209,6 +209,12 @@ struct arena_map {
 #define PFN_SIG "NVDIMM_PFN_INFO\0"
 #define DAX_SIG "NVDIMM_DAX_INFO\0"
 
+enum pfn_mode {
+	PFN_MODE_NONE,
+	PFN_MODE_RAM,
+	PFN_MODE_PMEM,
+};
+
 struct pfn_sb {
 	u8 signature[PFN_SIG_LEN];
 	u8 uuid[16];
@@ -224,7 +230,11 @@ struct pfn_sb {
 	le32 end_trunc;
 	/* minor-version-2 record the base alignment of the mapping */
 	le32 align;
-	u8 padding[4000];
+	/* minor-version-3 guarantee the padding and flags are zero */
+	/* minor-version-4 record the page size and struct page size */
+	le32 page_size;
+	le16 page_struct_size;
+	u8 padding[3994];
 	le64 checksum;
 };
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
