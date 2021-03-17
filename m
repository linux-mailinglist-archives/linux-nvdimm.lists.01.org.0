Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E805A33ED0F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Mar 2021 10:33:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC312100EB829;
	Wed, 17 Mar 2021 02:33:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=123.126.96.3; helo=mail-m963.mail.126.com; envelope-from=wangyingjie55@126.com; receiver=<UNKNOWN> 
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B536E100EB827
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 02:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7fLA8
	kcYxRJcVDBSuxgpwdomNhiK47IKlY7AxaYmZnw=; b=boyhAiveS/FGR1K4DYCET
	OJy/+vSPS9aTFQIruOFGuy85qOvceWj/MnmADCMNdwwcSe5s8waO7/Q6QXhuG6go
	ALWXN5q5KLhEQlnkXHNqXsjq3dk8756U/1f6NQisKgO7XeO+rD3pezwt02wX6pvU
	c3IZqmvMEx8hGF1t3NZAVA=
Received: from localhost.localdomain (unknown [116.162.2.6])
	by smtp8 (Coremail) with SMTP id NORpCgBHSz_LzFFgkSgYFw--.18768S2;
	Wed, 17 Mar 2021 17:32:59 +0800 (CST)
From: wangyingjie55@126.com
To: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH v1] libnvdimm, dax: Fix a missing check in nd_dax_probe()
Date: Wed, 17 Mar 2021 02:32:37 -0700
Message-Id: <1615973557-15889-1-git-send-email-wangyingjie55@126.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-CM-TRANSID: NORpCgBHSz_LzFFgkSgYFw--.18768S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU49YFUUUUU
X-Originating-IP: [116.162.2.6]
X-CM-SenderInfo: 5zdqw5xlqjyxrhvvqiyswou0bp/1tbiHQxYp1pEC+cFvAAAsl
Message-ID-Hash: 6XXC5OG6QWNXKRZCFCAIDFP37RKOAOHN
X-Message-ID-Hash: 6XXC5OG6QWNXKRZCFCAIDFP37RKOAOHN
X-MailFrom: wangyingjie55@126.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: wangyingjie55@126.com, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6XXC5OG6QWNXKRZCFCAIDFP37RKOAOHN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: multipart/mixed; boundary="===============4252062237833357365=="

--===============4252062237833357365==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable

From: Yingjie Wang <wangyingjie55@126.com>

In nd_dax_probe()=EF=BC=8C 'nd_dax' is allocated by nd_dax_alloc().
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
@@ -106,6 +106,8 @@ int nd_dax_probe(struct device *dev, struct nd_namesp=
ace_common *ndns)
=20
 	nvdimm_bus_lock(&ndns->dev);
 	nd_dax =3D nd_dax_alloc(nd_region);
+	if (!nd_dax)
+		return -ENOMEM;
 	nd_pfn =3D &nd_dax->nd_pfn;
 	dax_dev =3D nd_pfn_devinit(nd_pfn, ndns);
 	nvdimm_bus_unlock(&ndns->dev);
--=20
2.7.4

--===============4252062237833357365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--===============4252062237833357365==--
