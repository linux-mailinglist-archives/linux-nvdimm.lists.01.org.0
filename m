Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8B201925
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Jun 2020 19:15:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B46DC10FC6C8E;
	Fri, 19 Jun 2020 10:15:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gustavoars@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CCA810FC6C8D
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 10:15:48 -0700 (PDT)
Received: from embeddedor (unknown [189.207.59.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 1E1372083B;
	Fri, 19 Jun 2020 17:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592586947;
	bh=+FyC0mh1S4XX7z9Bu1BeiFerSfQCPVxis2shYUF8fQw=;
	h=Date:From:To:Cc:Subject:From;
	b=QDZweeUl/sMm1oC/exF1AxZFPz74hmvE1UK3P4+gxKBOfxa3YpcvC5ZTRrP1a3ZaE
	 knb8+kpYwMt3g2MvH33Jm+9s+NBPWxSSl4pOzYZVIJ97dO/3hPjb7MAYA+wCcFDvWW
	 BxpG75TKZIRbLQx3YwutyPixN7BDC5sVe70wanO4=
Date: Fri, 19 Jun 2020 12:21:12 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH][next] nvdimm/region: Use struct_size() in kzalloc()
Message-ID: <20200619172112.GA31702@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Message-ID-Hash: DGNOSSRH3FJI4M4BVES7JAZP2MENS6JL
X-Message-ID-Hash: DGNOSSRH3FJI4M4BVES7JAZP2MENS6JL
X-MailFrom: gustavoars@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DGNOSSRH3FJI4M4BVES7JAZP2MENS6JL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvdimm/region_devs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4502f9c4708d..8365fb1a9114 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1063,8 +1063,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		struct nd_blk_region *ndbr;
 
 		ndbr_desc = to_blk_region_desc(ndr_desc);
-		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
-				* ndr_desc->num_mappings,
+		ndbr = kzalloc(struct_size(ndbr, nd_region.mapping, ndr_desc->num_mappings),
 				GFP_KERNEL);
 		if (ndbr) {
 			nd_region = &ndbr->nd_region;
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
