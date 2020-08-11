Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC899241910
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Aug 2020 11:45:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B29E12F10E75;
	Tue, 11 Aug 2020 02:45:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.145.155; helo=esa3.hc3370-68.iphmx.com; envelope-from=roger.pau@citrix.com; receiver=<UNKNOWN> 
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17B8912F10D1C
	for <linux-nvdimm@lists.01.org>; Tue, 11 Aug 2020 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597139113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=21LnmuTUq2pHs9BEPTKLR7uvR8pjWH5GPd9gh/+wq5s=;
  b=XPVyTsCIi7ERlJvK6jizi2Gwd6Jq7ranaauMOUbU3U6gkl69e9ibVj6s
   SHxXHUEJmRrppjEj5gKoaYSi0euz5wGki48egFCVY1WaCjg3F8pFoeYc7
   UQdOa0whIIrSWiSYnEZ2K/5mTPcC7uary52wI8JcsL9hHU3UKltzNLttc
   s=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: VY5VVlCFQoEMbraTS/yrZS8UqVt0ps8DLejYExspGKQRXdGYHx6bGA2Os+p4H57m0KVTnf4ETo
 A58Ud1v5xBKk0UreNYyFdq6SOXG5m2ohZ6VYo+8IFfkxaK9rYzAj92qOdySbmyuAGHFC6CHXLu
 pXAvt/6qNEzVNM41g+QN7omxDcX9rY9EwY9KUczeMlcriiFjpFoZyR6P++og5Yj3lXRWZomi+9
 8ny1E/KACaSD//Ufem6d3bKnm3jAVxF0h5A6pbWvkWT6anOcvbn8mKJ39nPavZd99plNPTlG1/
 IjQ=
X-SBRS: 2.7
X-MesageID: 24242470
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,460,1589256000";
   d="scan'208";a="24242470"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
Date: Tue, 11 Aug 2020 11:44:46 +0200
Message-ID: <20200811094447.31208-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811094447.31208-1-roger.pau@citrix.com>
References: <20200811094447.31208-1-roger.pau@citrix.com>
MIME-Version: 1.0
Message-ID-Hash: 4GJSXVQJCAAKXCMMUCBEZQMRGPA3MX7M
X-Message-ID-Hash: 4GJSXVQJCAAKXCMMUCBEZQMRGPA3MX7M
X-MailFrom: roger.pau@citrix.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Roger Pau Monne <roger.pau@citrix.com>, "Dave Jiang  <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe" <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4GJSXVQJCAAKXCMMUCBEZQMRGPA3MX7M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

VGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIGxvZ2ljIGJlaGluZCBNRU1PUllfREVWSUNF
X0RFVkRBWCBhbHNvDQpiZWluZyB1c2VkIGJ5IG5vbiBEQVggZGV2aWNlcy4NCg0KTm8gZnVuY3Rp
b25hbCBjaGFuZ2UgaW50ZW5kZWQuDQoNClNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBhdSBNb25uw6kg
PHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KLS0tDQpDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxs
aWFtc0BpbnRlbC5jb20+DQpDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5j
b20+DQpDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQpDYzogQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0B6aWVwZS5jYT4NCkNjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQpDYzogIkFu
ZWVzaCBLdW1hciBLLlYiIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4NCkNjOiBKb2hhbm5l
cyBUaHVtc2hpcm4gPGp0aHVtc2hpcm5Ac3VzZS5kZT4NCkNjOiBMb2dhbiBHdW50aG9ycGUgPGxv
Z2FuZ0BkZWx0YXRlZS5jb20+DQpDYzogbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZw0KQ2M6IHhl
bi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZw0KLS0t
DQogZHJpdmVycy9kYXgvZGV2aWNlLmMgICAgIHwgMiArLQ0KIGluY2x1ZGUvbGludXgvbWVtcmVt
YXAuaCB8IDkgKysrKy0tLS0tDQogbW0vbWVtcmVtYXAuYyAgICAgICAgICAgIHwgMiArLQ0KIDMg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9kYXgvZGV2aWNlLmMgYi9kcml2ZXJzL2RheC9kZXZpY2UuYw0KaW5kZXgg
NGMwYWYyZWI3ZTE5Li4xZTg5NTEzZjNjNTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2RheC9kZXZp
Y2UuYw0KKysrIGIvZHJpdmVycy9kYXgvZGV2aWNlLmMNCkBAIC00MjksNyArNDI5LDcgQEAgaW50
IGRldl9kYXhfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAkJcmV0dXJuIC1FQlVTWTsNCiAJ
fQ0KIA0KLQlkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklDRV9ERVZEQVg7DQorCWRl
dl9kYXgtPnBnbWFwLnR5cGUgPSBNRU1PUllfREVWSUNFX0dFTkVSSUM7DQogCWFkZHIgPSBkZXZt
X21lbXJlbWFwX3BhZ2VzKGRldiwgJmRldl9kYXgtPnBnbWFwKTsNCiAJaWYgKElTX0VSUihhZGRy
KSkNCiAJCXJldHVybiBQVFJfRVJSKGFkZHIpOw0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bWVtcmVtYXAuaCBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KaW5kZXggNWY1YjJkZjA2ZTYx
Li5lNTg2Mjc0Njc1MWIgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCisr
KyBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KQEAgLTQ2LDExICs0NiwxMCBAQCBzdHJ1Y3Qg
dm1lbV9hbHRtYXAgew0KICAqIHdha2V1cCBpcyB1c2VkIHRvIGNvb3JkaW5hdGUgcGh5c2ljYWwg
YWRkcmVzcyBzcGFjZSBtYW5hZ2VtZW50IChleDoNCiAgKiBmcyB0cnVuY2F0ZS9ob2xlIHB1bmNo
KSB2cyBwaW5uZWQgcGFnZXMgKGV4OiBkZXZpY2UgZG1hKS4NCiAgKg0KLSAqIE1FTU9SWV9ERVZJ
Q0VfREVWREFYOg0KKyAqIE1FTU9SWV9ERVZJQ0VfR0VORVJJQzoNCiAgKiBIb3N0IG1lbW9yeSB0
aGF0IGhhcyBzaW1pbGFyIGFjY2VzcyBzZW1hbnRpY3MgYXMgU3lzdGVtIFJBTSBpLmUuIERNQQ0K
LSAqIGNvaGVyZW50IGFuZCBzdXBwb3J0cyBwYWdlIHBpbm5pbmcuIEluIGNvbnRyYXN0IHRvDQot
ICogTUVNT1JZX0RFVklDRV9GU19EQVgsIHRoaXMgbWVtb3J5IGlzIGFjY2VzcyB2aWEgYSBkZXZp
Y2UtZGF4DQotICogY2hhcmFjdGVyIGRldmljZS4NCisgKiBjb2hlcmVudCBhbmQgc3VwcG9ydHMg
cGFnZSBwaW5uaW5nLiBUaGlzIGlzIGZvciBleGFtcGxlIHVzZWQgYnkgREFYIGRldmljZXMNCisg
KiB0aGF0IGV4cG9zZSBtZW1vcnkgdXNpbmcgYSBjaGFyYWN0ZXIgZGV2aWNlLg0KICAqDQogICog
TUVNT1JZX0RFVklDRV9QQ0lfUDJQRE1BOg0KICAqIERldmljZSBtZW1vcnkgcmVzaWRpbmcgaW4g
YSBQQ0kgQkFSIGludGVuZGVkIGZvciB1c2Ugd2l0aCBQZWVyLXRvLVBlZXINCkBAIC02MCw3ICs1
OSw3IEBAIGVudW0gbWVtb3J5X3R5cGUgew0KIAkvKiAwIGlzIHJlc2VydmVkIHRvIGNhdGNoIHVu
aW5pdGlhbGl6ZWQgdHlwZSBmaWVsZHMgKi8NCiAJTUVNT1JZX0RFVklDRV9QUklWQVRFID0gMSwN
CiAJTUVNT1JZX0RFVklDRV9GU19EQVgsDQotCU1FTU9SWV9ERVZJQ0VfREVWREFYLA0KKwlNRU1P
UllfREVWSUNFX0dFTkVSSUMsDQogCU1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQSwNCiB9Ow0KIA0K
ZGlmZiAtLWdpdCBhL21tL21lbXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jDQppbmRleCAwM2UzOGI3
YTM4ZjEuLjAwNmRhY2U2MGIxYSAxMDA2NDQNCi0tLSBhL21tL21lbXJlbWFwLmMNCisrKyBiL21t
L21lbXJlbWFwLmMNCkBAIC0yMTYsNyArMjE2LDcgQEAgdm9pZCAqbWVtcmVtYXBfcGFnZXMoc3Ry
dWN0IGRldl9wYWdlbWFwICpwZ21hcCwgaW50IG5pZCkNCiAJCQlyZXR1cm4gRVJSX1BUUigtRUlO
VkFMKTsNCiAJCX0NCiAJCWJyZWFrOw0KLQljYXNlIE1FTU9SWV9ERVZJQ0VfREVWREFYOg0KKwlj
YXNlIE1FTU9SWV9ERVZJQ0VfR0VORVJJQzoNCiAJCW5lZWRfZGV2bWFwX21hbmFnZWQgPSBmYWxz
ZTsNCiAJCWJyZWFrOw0KIAljYXNlIE1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQToNCi0tIA0KMi4y
OC4wDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
