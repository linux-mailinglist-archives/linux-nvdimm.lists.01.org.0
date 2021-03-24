Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 589A8347AC0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 15:33:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9969F100EB83F;
	Wed, 24 Mar 2021 07:33:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=weiyongjun1@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75B12100ED4BC
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 07:33:12 -0700 (PDT)
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F59dB1dRqznW2v;
	Wed, 24 Mar 2021 22:30:38 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 22:33:03 +0800
From: 'Wei Yongjun <weiyongjun1@huawei.com>
To: <weiyongjun1@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: [PATCH -next] libnvdimm/security: Make symbol '__nvdimm_security_overwrite_query' static
Date: Wed, 24 Mar 2021 14:42:57 +0000
Message-ID: <20210324144257.1014160-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Message-ID-Hash: GOFUJVK3H2MMUOORXTRMXIOGJNUIW5TU
X-Message-ID-Hash: GOFUJVK3H2MMUOORXTRMXIOGJNUIW5TU
X-MailFrom: weiyongjun1@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GOFUJVK3H2MMUOORXTRMXIOGJNUIW5TU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:



drivers/nvdimm/security.c:416:6: warning:
 symbol '__nvdimm_security_overwrite_query' was not declared. Should it be static?



This symbol is not used outside of security.c, so this

commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4b80150e4afa..d3e782662bf4 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 	return rc;
 }
 
-void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
+static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 {
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
 	int rc;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
