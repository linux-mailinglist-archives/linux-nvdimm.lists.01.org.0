Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED433ED1C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Mar 2021 10:37:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1865E100EB82B;
	Wed, 17 Mar 2021 02:37:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=123.126.96.3; helo=mail-m963.mail.126.com; envelope-from=wangyingjie55@126.com; receiver=<UNKNOWN> 
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 085A1100EB829
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=6myTYJ/6oXihRxGonF
	RwbGYMjlu+sduVYchFyN3kgEE=; b=FroKIg9E10IEsfVhExlbkntjUINapaat5x
	KmtHqtGmSyhSMwaMi9YsmULg6/DQO9fypijWXYcwbepEVEtVdNsuAIBWkgUeteP5
	nUJlRSslv5OKz3KgjRSz2qMfVwrVel0aMPPkEaXuIUWj1NtsESyYHOfo0/MZJyZ8
	xi1mrmqeQ=
Received: from localhost.localdomain (unknown [116.162.2.6])
	by smtp8 (Coremail) with SMTP id NORpCgDHqWiyzVFgW2EYFw--.6516S2;
	Wed, 17 Mar 2021 17:36:51 +0800 (CST)
From: wangyingjie55@126.com
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date: Wed, 17 Mar 2021 02:36:39 -0700
Message-Id: <1615973799-16077-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgDHqWiyzVFgW2EYFw--.6516S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFykKr4rJFyxArykKFy5XFb_yoWfKFbEkF
	y7Zr929Fy0krnayr42vr1fu34vyrn29r1kur4jgw13Ar4j9r13GrWkur9Ikrsagr4xZr1D
	urnFqFnxuF15ujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj-J57UUUUU==
X-Originating-IP: [116.162.2.6]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiWBRYp11w5leZjgABs5
Message-ID-Hash: W3CXPK26TVE7CHZOGZMUGSXAK62RRUHA
X-Message-ID-Hash: W3CXPK26TVE7CHZOGZMUGSXAK62RRUHA
X-MailFrom: wangyingjie55@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: wangyingjie55@126.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W3CXPK26TVE7CHZOGZMUGSXAK62RRUHA/>
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
