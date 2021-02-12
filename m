Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BC31A352
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Feb 2021 18:11:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 844DF100EA103;
	Fri, 12 Feb 2021 09:11:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:67c:670:201:290:27ff:fe1d:cc33; helo=metis.ext.pengutronix.de; envelope-from=ukl@pengutronix.de; receiver=<UNKNOWN> 
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 856D4100EA2DF
	for <linux-nvdimm@lists.01.org>; Fri, 12 Feb 2021 09:11:01 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1lAbxx-0005xN-S7; Fri, 12 Feb 2021 18:10:49 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1lAbxx-0000Wx-Bw; Fri, 12 Feb 2021 18:10:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/2] libnvdimm: simplify nvdimm_remove()
Date: Fri, 12 Feb 2021 18:10:42 +0100
Message-Id: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nvdimm@lists.01.org
Message-ID-Hash: DJ4NDOERVJ2WVVCGZP4SKNKXLAJOGF2L
X-Message-ID-Hash: DJ4NDOERVJ2WVVCGZP4SKNKXLAJOGF2L
X-MailFrom: ukl@pengutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DJ4NDOERVJ2WVVCGZP4SKNKXLAJOGF2L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

bnZkaW1tX3JlbW92ZSBpcyBvbmx5IGV2ZXIgY2FsbGVkIGFmdGVyIG52ZGltbV9wcm9iZSgpIHJl
dHVybmVkDQpzdWNjZXNzZnVsbHkuIEluIHRoaXMgY2FzZSBkcml2ZXIgZGF0YSBpcyBhbHdheXMg
c2V0IHRvIGEgbm9uLU5VTEwgdmFsdWUNCnNvIHRoZSBjaGVjayBmb3IgZHJpdmVyIGRhdGEgYmVp
bmcgTlVMTCBjYW4gZ28gYXdheSBhcyBpdCdzIGFsd2F5cyBmYWxzZS4NCg0KU2lnbmVkLW9mZi1i
eTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4NCi0t
LQ0KIGRyaXZlcnMvbnZkaW1tL2RpbW0uYyB8IDMgLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgZGVs
ZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9kaW1tLmMgYi9kcml2ZXJz
L252ZGltbS9kaW1tLmMNCmluZGV4IDdkNGRkYzRkOTMyMi4uOTRiZTNhZTFkMjlmIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9udmRpbW0vZGltbS5jDQorKysgYi9kcml2ZXJzL252ZGltbS9kaW1tLmMN
CkBAIC0xMTcsOSArMTE3LDYgQEAgc3RhdGljIGludCBudmRpbW1fcmVtb3ZlKHN0cnVjdCBkZXZp
Y2UgKmRldikNCiB7DQogCXN0cnVjdCBudmRpbW1fZHJ2ZGF0YSAqbmRkID0gZGV2X2dldF9kcnZk
YXRhKGRldik7DQogDQotCWlmICghbmRkKQ0KLQkJcmV0dXJuIDA7DQotDQogCW52ZGltbV9idXNf
bG9jayhkZXYpOw0KIAlkZXZfc2V0X2RydmRhdGEoZGV2LCBOVUxMKTsNCiAJbnZkaW1tX2J1c191
bmxvY2soZGV2KTsNCg0KYmFzZS1jb21taXQ6IDVjOGZlNTgzY2NlNTQyYWEwYjg0YWRjOTM5Y2U4
NTI5M2RlMzZlNWUNCi0tIA0KMi4yOS4yDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
