Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DED2807DC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Oct 2020 21:38:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56B42156349BF;
	Thu,  1 Oct 2020 12:38:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D2BB0155D74E9
	for <linux-nvdimm@lists.01.org>; Thu,  1 Oct 2020 12:38:26 -0700 (PDT)
IronPort-SDR: E8Lq29IfNFzMTNlDPFdKZeZCkjt/X71xw9WI2jyIeiyXLziTg3x1wkynl2ctvWyT4pPPN8skpd
 5wWcyQ8obSDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="226944931"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400";
   d="scan'208";a="226944931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:38:23 -0700
IronPort-SDR: EaJqXmGt5JpOurRC0SA1mqsWyvOeuKAeeD1r9El4O+yaXt9i1xNAHzbC4gvxl+SL5Fuslyc6Vu
 Aty6llrqNvIA==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400";
   d="scan'208";a="351279749"
Received: from loppedah-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.30.3])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:38:22 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/2] libndctl: fix a potential buffer overflow
Date: Thu,  1 Oct 2020 13:38:15 -0600
Message-Id: <20201001193816.975987-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: ZMJO6ZCWLRAKSNZ3544FUVXG5OOWITF2
X-Message-ID-Hash: ZMJO6ZCWLRAKSNZ3544FUVXG5OOWITF2
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZMJO6ZCWLRAKSNZ3544FUVXG5OOWITF2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Static analysis points out that the 'buf' in ndctl_dimm_is_active was
inappropriately sized. We already have 'SYSFS_ATTR_SIZE' for such
buffers, and it looks like this was just an oversight.

Fixes: 0a4509d7de2f ("ndctl: enumerate interleave sets")
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 ndctl/lib/libndctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 6556b33..5546963 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -3675,8 +3675,8 @@ NDCTL_EXPORT int ndctl_dimm_is_active(struct ndctl_dimm *dimm)
 {
 	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
 	char *path = dimm->dimm_buf;
+	char buf[SYSFS_ATTR_SIZE];
 	int len = dimm->buf_len;
-	char buf[20];
 
 	if (snprintf(path, len, "%s/state", dimm->dimm_path) >= len) {
 		err(ctx, "%s: buffer too small!\n",
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
