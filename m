Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EA231152A
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 23:29:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F31DE100EBBC1;
	Fri,  5 Feb 2021 14:29:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:c0c:3a97::2; helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org; receiver=<UNKNOWN> 
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D341100ED4BC
	for <linux-nvdimm@lists.01.org>; Fri,  5 Feb 2021 14:29:02 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
	id 37AB9AEDEFD; Fri,  5 Feb 2021 23:29:01 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/5] dax-device: Fix error path in dax_driver_register
Date: Fri,  5 Feb 2021 23:28:40 +0100
Message-Id: <20210205222842.34896-4-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Message-ID-Hash: FPW2Y54DCPUS3HFJMNUW752FQXMIIKYQ
X-Message-ID-Hash: FPW2Y54DCPUS3HFJMNUW752FQXMIIKYQ
X-MailFrom: uwe@kleine-koenig.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FPW2Y54DCPUS3HFJMNUW752FQXMIIKYQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIHN0YXRpYyB2YXJpYWJsZSBtYXRjaF9hbHdheXNfY291bnQgaXMgc3VwcG9zZWQgdG8gdHJh
Y2sgaWYgdGhlcmUgaXMNCmEgZHJpdmVyIHJlZ2lzdGVyZWQgdGhhdCBoYXMgLm1hdGNoX2Fsd2F5
cyBzZXQuIElmIGRyaXZlcl9yZWdpc3RlcigpDQpmYWlscywgdGhlIHByZXZpb3VzIGluY3JlbWVu
dCBtdXN0IGJlIHVuZG9uZS4NCg0KU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHV3
ZUBrbGVpbmUta29lbmlnLm9yZz4NCi0tLQ0KIGRyaXZlcnMvZGF4L2J1cy5jIHwgMTAgKysrKysr
KysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2J1cy5jIGIvZHJpdmVycy9kYXgvYnVzLmMNCmluZGV4
IDJjOWUzZjZmNjE1Zi4uYmM0MjVmMWM1MmJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9kYXgvYnVz
LmMNCisrKyBiL2RyaXZlcnMvZGF4L2J1cy5jDQpAQCAtMTQyMCw3ICsxNDIwLDE1IEBAIGludCBf
X2RheF9kcml2ZXJfcmVnaXN0ZXIoc3RydWN0IGRheF9kZXZpY2VfZHJpdmVyICpkYXhfZHJ2LA0K
IAltdXRleF91bmxvY2soJmRheF9idXNfbG9jayk7DQogCWlmIChyYykNCiAJCXJldHVybiByYzsN
Ci0JcmV0dXJuIGRyaXZlcl9yZWdpc3RlcihkcnYpOw0KKw0KKwlyYyA9IGRyaXZlcl9yZWdpc3Rl
cihkcnYpOw0KKwlpZiAocmMgJiYgZGF4X2Rydi0+bWF0Y2hfYWx3YXlzKSB7DQorCQltdXRleF9s
b2NrKCZkYXhfYnVzX2xvY2spOw0KKwkJbWF0Y2hfYWx3YXlzX2NvdW50IC09IGRheF9kcnYtPm1h
dGNoX2Fsd2F5czsNCisJCW11dGV4X3VubG9jaygmZGF4X2J1c19sb2NrKTsNCisJfQ0KKw0KKwly
ZXR1cm4gcmM7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKF9fZGF4X2RyaXZlcl9yZWdpc3Rlcik7
DQogDQotLSANCjIuMjkuMg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
