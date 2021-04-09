Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9059B3591C5
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 03:58:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1ED72100EAAEE;
	Thu,  8 Apr 2021 18:58:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=123.126.96.3; helo=mail-m963.mail.126.com; envelope-from=wangyingjie55@126.com; receiver=<UNKNOWN> 
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8C406100EAAED
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 18:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=6myTYJ/6oXihRxGonF
	RwbGYMjlu+sduVYchFyN3kgEE=; b=lVV9+qH2cvtcwzftgpjy0OFDmU8X4IcPAV
	jmiTDormglV8wUc5vMlkm298Kr2w8AUwd6BC3vvrRZWc62SQml5zxwbghLHDgvM5
	I9Clx0AKwNOXQcjMWXD6hI0Kr8bcHeH/f3C4fW9kAWsK5aQLWKdqQvCl3EiaPWa6
	cnOgjP66E=
Received: from localhost.localdomain (unknown [116.162.2.189])
	by smtp8 (Coremail) with SMTP id NORpCgCX06PFtG9gAtgdHQ--.10140S2;
	Fri, 09 Apr 2021 09:58:31 +0800 (CST)
From: wangyingjie55@126.com
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	linux-nvdimm@lists.01.org
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date: Thu,  8 Apr 2021 18:58:26 -0700
Message-Id: <1617933506-13684-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgCX06PFtG9gAtgdHQ--.10140S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFykKr4rJFyxArykKFy5XFb_yoWfKFbEkF
	y7Zr929Fy0krnayr42vr1fu34vyrn29r1kur4jgw13Ar4j9r13GrWkur9Ikrsagr4xZr1D
	urnFqFnxuF15ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeVnQUUUUUU==
X-Originating-IP: [116.162.2.189]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiGAdvp1pEC2HqHgAAsX
Message-ID-Hash: RVO3QKHHOP2VEKBRBECZ47V6GBD2NGEM
X-Message-ID-Hash: RVO3QKHHOP2VEKBRBECZ47V6GBD2NGEM
X-MailFrom: wangyingjie55@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: wangyingjie55@126.com, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RVO3QKHHOP2VEKBRBECZ47V6GBD2NGEM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe(), 'nd_dax' is allocated by nd_dax_alloc().
nd_dax_alloc() may fail and return NULL, so we should better check
it's return value to avoid a NULL pointer dereference
a bit later in the code.

Fixes: c5ed9268643c ("libnvdimm, dax: autodetect support")
Signed-off-by: Yingjie Wang <wangyingjie55@126.com>
---
 drivers/nvdimm/dax_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/dax_devs.c b/drivers/nvdimm/dax_devs.c
index 99965077bac4..b1426ac03f01 100644
--- a/drivers/nvdimm/dax_devs.c
+++ b/drivers/nvdimm/dax_devs.c
@@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namespace_common *ndns)
 
 	nvdimm_bus_lock(&ndns->dev);
 	nd_dax = nd_dax_alloc(nd_region);
+	if (!nd_dax)
+		return -ENOMEM;
 	nd_pfn = &nd_dax->nd_pfn;
 	dax_dev = nd_pfn_devinit(nd_pfn, ndns);
 	nvdimm_bus_unlock(&ndns->dev);
-- 
2.7.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
