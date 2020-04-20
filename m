Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30C1B066A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 12:18:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB18D100A0279;
	Mon, 20 Apr 2020 03:18:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=106.10.244.82; helo=sonic309-19.consmr.mail.sg3.yahoo.com; envelope-from=roshanishrivastaw@yahoo.com; receiver=<UNKNOWN> 
Received: from sonic309-19.consmr.mail.sg3.yahoo.com (sonic309-19.consmr.mail.sg3.yahoo.com [106.10.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EE742100A0277
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587377899; bh=peyYmCtjljtWlLVt9nd7pAncy+qfy6U8NN3Z+m16P3I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=gXfFM/ryReiTkE2oNiQoqb+IJmFLNFaLNfJLfzaVi4z1NOUKh9jCHRAZ1uP1da4yJVz1oZDlucdwzHWpZbEXtNw5ZZt5GQfhm2cXSkGIEd+nhUvtVtGb5O8c3BdD0ru6d1iI+FYtXAqUWPY3g9d6xyoGgZiiTvqDfDWwxljlPcxDYSmxy7gkWJoXW9glOLaa5B/BGOKsZ1F56jgLQaHsuDVmS5WznPFoVkIvF+j7sCi2fWxmqoy/1Ues9dj/A/6XGOIGQg2BgBPtG+ateXH5rnu0EG4F/1wapc24UaNVr+Uqrpe3nKuQhOt7pceRj4Xffwr0mqyndmcbkOZHiEaD7w==
X-YMail-OSG: 3UEimxEVM1mXOD_rmIPgTPcuzfEk0mA440ciC_bBh06K_CY58uNAOCYRlVT2wfI
 WMWPaBqyTWmuQ1aRub7UHWIeSahL2WOYsuJFCFafwq9xZANqvGOtBUL8.Bx11m6w_HvHOXMDoAzO
 ziWnvK6AcYTW1x12CF3xGxsUjeljrop.XluB62iCdj1S1wrhe1g3bgrPyLnxrTRDz41MZZSPojI2
 KaiU7D5gvUnlFQ3UuG_z9XcVYYFYi__3NqdxDVMnsK1c5O1EY90Ysll73tAuogzwQIAkD00zlYuq
 _VLNS_2ud6PXxgcrlKiWdBFA0qUSkU_JNA4Xvwpu1uyO51DU1xXIDTmV3UAMuo0Rpb7pMOCn3P0j
 5hmW3GQS6yjjZNarXyOrIqeZipl4pEhX6.JG1ikGJdPfjXR3x_zr8jXXOa2.f1QIcPrT1QyInWFV
 JM1iDNnn__wFPJ_Qde8nphy2F8ICTVw_4ZQ8CKRFkCyDeN_jMc2JgQATRsCXHxd7lBVa1ryI.CgS
 4TiLmK8YeIzUa0lQnVeoYOkLRH3RDz0aiTxb.DK2YUIHEmq4EghGRqGisAGvx7dZLQha1W8DmXtm
 ingebvDUBsc5YQatYbJAYigt_nnTfkYpYU9sCst.iIWzfue5t3cKmh6sbz0KgIPg00nSmhsrId5B
 pbcibz5yiPthG5VI2kEC03L44KT9SQjOimnd1MIxa3AWpQwMRb3PqNGSG_NX_gm91rQZHjn27FdR
 2I0WJzKsbED3EwAMQtHEnnLjT5HitiPkoPMLlKNnGPxp54npJmy8xttnmYgtmE4I_jSAQXTuQ8Ih
 6iEM1sBCgfbtZjJt3acOFzqoqNZ.I0F3JwsOtjSLaQxw4ENAwiaKNEUsx1adfDkE6Gfy0q7rKIlY
 KfBzv1DpNbUE2u4kuIxmnU7aM3LblT41Qv1mv_XYip3MpbREFv5Sx.PwMIYcUUZPSDLS0.7O1T0n
 Ig5GuRbhhaY2zR.LpnjRQNxyKkUp53jTJPszX5c1s514lbL1jhtLqNGuuUHy9R0EDujK6p2r47qa
 w5bQ4Mr2i7SATYK5t.SlTS6tvI6s.zDtsmlbUp1z1WTDB9RpmEcV9KEcGdJFIH1btSaMQEEJS3wu
 ECFl4bICIjDPKhIU7iid45LMZb9EM.9QlA7MQhx_R1dIexaEOcPFHdo1CzxqeeK0Y_6TqloPzx78
 Z.8nIVMszwr1KPu33Lyd0MfiI8OEAFxUjM2qSYCRTLucRfPZ.lo_JdOOlLYVTIFMZIl3duJrZMlB
 xe7UcnPiya_LE4wXRCBwPXJcEs928YPzEF9IZ.LC6LWpxRecBCRWQsaNPQDptWEud4sOC.DHwgSG
 XVvzjLKzuPg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Mon, 20 Apr 2020 10:18:19 +0000
Date: Mon, 20 Apr 2020 10:18:14 +0000 (UTC)
From: Riya Goyal <roshanishrivastaw@yahoo.com>
Message-ID: <951256005.2233599.1587377894073@mail.yahoo.com>
Subject: Apps
MIME-Version: 1.0
References: <951256005.2233599.1587377894073.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNorrin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.113 Safari/537.36
Message-ID-Hash: 7G73QV7KVB6FUJIMSJ4M3MRKMOR4OFWH
X-Message-ID-Hash: 7G73QV7KVB6FUJIMSJ4M3MRKMOR4OFWH
X-MailFrom: roshanishrivastaw@yahoo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: Riya Goyal <roshanishrivastaw@yahoo.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7G73QV7KVB6FUJIMSJ4M3MRKMOR4OFWH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQpIaSwNCg0KR3JlZXRpbmdzIQ0KDQpEbyB5b3Ugd2FudCBhIE1vYmlsZSBBcHBzIChBbmRyb2lk
L2lPUyBhcHApZm9yIHlvdXIgQnVzaW5lc3M/DQoNCldlIGRldmVsb3AgbG93IGNvc3QgbW9iaWxl
IGFwcGxpY2F0aW9ucyBmb3JnbG9iYWwgZW50ZXJwcmlzZXMgdGhhdCBoZWxwIHRoZW0gZ3JvdyB0
aGVpciBidXNpbmVzcy4NCg0KwqBXZSBhcmUgYW4gSVQgY29tcGFueSwgd2hpY2ggZm9jdXNlc29u
wqBBcHAgZGV2ZWxvcG1lbnQsIGlPUyBhcHBkZXZlbG9wbWVudCwgQW5kcm9pZCBhcHAgZGV2ZWxv
cG1lbnQsIEhUTUw1IGFwcCwgTWFjIE9TWCBhcHAsIE1vYmlsZSBhcHBkZXZlbG9wbWVudCBhbmQg
Q3VzdG9tIFdlYiBhcHBzLg0KDQooQ3JlYXRlIGFwcCBmb3IgeW91ciBidXNpbmVzcykNCg0KSWYg
aW50ZXJlc3RlZCwgcGxlYXNlIHdyaXRlIG1lIGJhY2sgd2l0aCB5b3VycmVxdWlyZW1lbnQgYW5k
IGlkZWFzLMKgDQoNClJlZ2FyZHMsDQoNCihJbmRpYSkNCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
