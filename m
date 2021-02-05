Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51431152C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Feb 2021 23:30:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 19736100EA2DA;
	Fri,  5 Feb 2021 14:30:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:c0c:3a97::2; helo=antares.kleine-koenig.org; envelope-from=uwe@kleine-koenig.org; receiver=<UNKNOWN> 
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E169D100ED4BC
	for <linux-nvdimm@lists.01.org>; Fri,  5 Feb 2021 14:29:03 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
	id 95E15AEDEFF; Fri,  5 Feb 2021 23:29:02 +0100 (CET)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/5] dax-device: Drop an empty .remove callback
Date: Fri,  5 Feb 2021 23:28:41 +0100
Message-Id: <20210205222842.34896-5-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Message-ID-Hash: P3NFKV5XRBJ2JVHTZBYALVIOA5UPWCTW
X-Message-ID-Hash: P3NFKV5XRBJ2JVHTZBYALVIOA5UPWCTW
X-MailFrom: uwe@kleine-koenig.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P3NFKV5XRBJ2JVHTZBYALVIOA5UPWCTW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhlIGRheCBjb3JlIHByb3Blcmx5IGhhbmRsZXMgYSBkYXggZHJpdmVyIG5vdCBoYXZpbmcgYSBy
ZW1vdmUgY2FsbGJhY2suDQpTbyBkcm9wIGl0IHdpdGhvdXQgY2hhbmdpbmcgdGhlIGVmZmVjdGl2
ZSBiZWhhdmlvdXIuDQoNClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xl
aW5lLWtvZW5pZy5vcmc+DQotLS0NCiBkcml2ZXJzL2RheC9kZXZpY2UuYyB8IDggKy0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDcgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2RheC9kZXZpY2UuYyBiL2RyaXZlcnMvZGF4L2RldmljZS5jDQppbmRl
eCA1ZGEyOTgwYmIxNmIuLmRiOTI1NzNjOTRlOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZGF4L2Rl
dmljZS5jDQorKysgYi9kcml2ZXJzL2RheC9kZXZpY2UuYw0KQEAgLTQ1MiwxNSArNDUyLDkgQEAg
aW50IGRldl9kYXhfcHJvYmUoc3RydWN0IGRldl9kYXggKmRldl9kYXgpDQogfQ0KIEVYUE9SVF9T
WU1CT0xfR1BMKGRldl9kYXhfcHJvYmUpOw0KIA0KLXN0YXRpYyBpbnQgZGV2X2RheF9yZW1vdmUo
c3RydWN0IGRldl9kYXggKmRldl9kYXgpDQotew0KLQkvKiBhbGwgcHJvYmUgYWN0aW9ucyBhcmUg
dW53b3VuZCBieSBkZXZtICovDQotCXJldHVybiAwOw0KLX0NCi0NCiBzdGF0aWMgc3RydWN0IGRh
eF9kZXZpY2VfZHJpdmVyIGRldmljZV9kYXhfZHJpdmVyID0gew0KIAkucHJvYmUgPSBkZXZfZGF4
X3Byb2JlLA0KLQkucmVtb3ZlID0gZGV2X2RheF9yZW1vdmUsDQorCS8qIGFsbCBwcm9iZSBhY3Rp
b25zIGFyZSB1bndvdW5kIGJ5IGRldm0sIHNvIC5yZW1vdmUgaXNuJ3QgbmVjZXNzYXJ5ICovDQog
CS5tYXRjaF9hbHdheXMgPSAxLA0KIH07DQogDQotLSANCjIuMjkuMg0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
