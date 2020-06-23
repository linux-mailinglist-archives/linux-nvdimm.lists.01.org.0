Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785D2058CD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 19:35:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B289510FC447E;
	Tue, 23 Jun 2020 10:35:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0494410FC3C35
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 10:35:55 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 20C66207FB;
	Tue, 23 Jun 2020 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933755;
	bh=CEb9o2yL5eEnwlfJtCGk5Cdd+bLozxsyRisthU6Vmsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dO8GABJI3pI7o2Jr888VmVheluUi+cQko3lbmd1VVMc8De95Row5+8/s0XKNb2NMW
	 CLzy9wgHCaOCNdmrlZW8KQMbFdlFDOH7pkTTYPLbJUcFdvqGqWy7VRXbAGCrUHgzYL
	 9l5wZUenKWojRTvY+pwPzpsBI1esv/p97bP7vs4o=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 26/28] nvdimm/region: always show the 'align' attribute
Date: Tue, 23 Jun 2020 13:35:21 -0400
Message-Id: <20200623173523.1355411-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: S7UU6WIVIKCTDT6IUZVMAZHSKIFGEWBT
X-Message-ID-Hash: S7UU6WIVIKCTDT6IUZVMAZHSKIFGEWBT
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S7UU6WIVIKCTDT6IUZVMAZHSKIFGEWBT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Vishal Verma <vishal.l.verma@intel.com>

[ Upstream commit 543094e19c82b5d171e139d09a1a3ea0a7361117 ]

It is possible that a platform that is capable of 'namespace labels'
comes up without the labels properly initialized. In this case, the
region's 'align' attribute is hidden. Howerver, once the user does
initialize he labels, the 'align' attribute still stays hidden, which is
unexpected.

The sysfs_update_group() API is meant to address this, and could be
called during region probe, but it has entanglements with the device
'lockdep_mutex'. Therefore, simply make the 'align' attribute always
visible. It doesn't matter what it says for label-less namespaces, since
it is not possible to change their allocation anyway.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20200520225026.29426-1-vishal.l.verma@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/region_devs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ccbb5b43b8b2c..4502f9c4708d0 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -679,18 +679,8 @@ static umode_t region_visible(struct kobject *kobj, struct attribute *a, int n)
 		return a->mode;
 	}
 
-	if (a == &dev_attr_align.attr) {
-		int i;
-
-		for (i = 0; i < nd_region->ndr_mappings; i++) {
-			struct nd_mapping *nd_mapping = &nd_region->mapping[i];
-			struct nvdimm *nvdimm = nd_mapping->nvdimm;
-
-			if (test_bit(NDD_LABELING, &nvdimm->flags))
-				return a->mode;
-		}
-		return 0;
-	}
+	if (a == &dev_attr_align.attr)
+		return a->mode;
 
 	if (a != &dev_attr_set_cookie.attr
 			&& a != &dev_attr_available_size.attr)
-- 
2.25.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
