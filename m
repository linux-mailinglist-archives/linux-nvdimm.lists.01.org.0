Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381F4258A5C
	for <lists+linux-nvdimm@lfdr.de>; Tue,  1 Sep 2020 10:33:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B0E0139DE898;
	Tue,  1 Sep 2020 01:33:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.145.142; helo=esa1.hc3370-68.iphmx.com; envelope-from=roger.pau@citrix.com; receiver=<UNKNOWN> 
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 419F1139DE897
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598949219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6iM96sKC3C3LFxia9GepOmTF8WrPh0TXy/mfmfh0JwA=;
  b=FUK+n5r1lfcarAhLXc5VkjPV6a2jeqJalm9P/Rixhc2Qew1FmnzR9ot5
   dfwwLiNSr/2A1zgwo0FcWiKIlrgABHRZPihEbxGV/tDh/1bYkzJI069xC
   qoOy97oUGIgzDAQz5LHw66WXUaFnjo8LXMqsqC1VNrUMXPwbFern2o9m9
   s=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: vRg+LZIhKqLHKOzIxg/UtuKM3UO+ewPtHYKtiaBQiVZ3/RbjmNoq9zMilEk72NCOOEj+tvMJS5
 Vwf39QCUkFYl6ahM6kmVJWAMG3QbkTMv48Uvnuws2K1TqKJFtkz9qIE+VbhtvPWIhXmR46ozLx
 5SmQHK+oH6exmvf2mOPf9HxfaAZQTLcPzuoQPra/lFiQZ8biOLFvWA0yfokf4Wv+F9m2l2GuTD
 jCtRqQdlxUxD+3BYmfTLPjwKMAU604YPHv95HoBkxmiYe7Rsnl5RCid02c07hWiYkpfvVZqmya
 Ftw=
X-SBRS: 2.7
X-MesageID: 26050349
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,378,1592884800";
   d="scan'208";a="26050349"
From: Roger Pau Monne <roger.pau@citrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] memremap: rename MEMORY_DEVICE_DEVDAX to MEMORY_DEVICE_GENERIC
Date: Tue, 1 Sep 2020 10:33:25 +0200
Message-ID: <20200901083326.21264-3-roger.pau@citrix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901083326.21264-1-roger.pau@citrix.com>
References: <20200901083326.21264-1-roger.pau@citrix.com>
MIME-Version: 1.0
Message-ID-Hash: PREEEEEIZ3GYHVJDARRTRRLLLZWZ7DJY
X-Message-ID-Hash: PREEEEEIZ3GYHVJDARRTRRLLLZWZ7DJY
X-MailFrom: roger.pau@citrix.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Roger Pau Monne <roger.pau@citrix.com>, Andrew Morton <akpm@linux-foundation.org>, "Dave Jiang  <dave.jiang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,  Aneesh Kumar K.V  <aneesh.kumar@linux.ibm.com>, Johannes Thumshirn <jthumshirn@suse.de>, Logan Gunthorpe" <logang@deltatee.com>, Juergen Gross <jgross@suse.com>, linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PREEEEEIZ3GYHVJDARRTRRLLLZWZ7DJY/>
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
PHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KUmV2aWV3ZWQtYnk6IElyYSBXZWlueSA8aXJhLndlaW55
QGludGVsLmNvbT4NCkFja2VkLWJ5OiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRp
b24ub3JnPg0KLS0tDQpDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+
DQpDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQpDYzogRGF2ZSBK
aWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCkNj
OiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQpDYzogIkFuZWVzaCBLdW1hciBLLlYi
IDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4NCkNjOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0
aHVtc2hpcm5Ac3VzZS5kZT4NCkNjOiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5j
b20+DQpDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KQ2M6IGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcNCkNjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCkNjOiBs
aW51eC1tbUBrdmFjay5vcmcNCi0tLQ0KIGRyaXZlcnMvZGF4L2RldmljZS5jICAgICB8IDIgKy0N
CiBpbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggfCA5ICsrKystLS0tLQ0KIG1tL21lbXJlbWFwLmMg
ICAgICAgICAgICB8IDIgKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2RldmljZS5jIGIvZHJpdmVy
cy9kYXgvZGV2aWNlLmMNCmluZGV4IDRjMGFmMmViN2UxOS4uMWU4OTUxM2YzYzU5IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9kYXgvZGV2aWNlLmMNCisrKyBiL2RyaXZlcnMvZGF4L2RldmljZS5jDQpA
QCAtNDI5LDcgKzQyOSw3IEBAIGludCBkZXZfZGF4X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikN
CiAJCXJldHVybiAtRUJVU1k7DQogCX0NCiANCi0JZGV2X2RheC0+cGdtYXAudHlwZSA9IE1FTU9S
WV9ERVZJQ0VfREVWREFYOw0KKwlkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklDRV9H
RU5FUklDOw0KIAlhZGRyID0gZGV2bV9tZW1yZW1hcF9wYWdlcyhkZXYsICZkZXZfZGF4LT5wZ21h
cCk7DQogCWlmIChJU19FUlIoYWRkcikpDQogCQlyZXR1cm4gUFRSX0VSUihhZGRyKTsNCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggYi9pbmNsdWRlL2xpbnV4L21lbXJlbWFw
LmgNCmluZGV4IDVmNWIyZGYwNmU2MS4uZTU4NjI3NDY3NTFiIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9saW51eC9tZW1yZW1hcC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCkBAIC00
NiwxMSArNDYsMTAgQEAgc3RydWN0IHZtZW1fYWx0bWFwIHsNCiAgKiB3YWtldXAgaXMgdXNlZCB0
byBjb29yZGluYXRlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UgbWFuYWdlbWVudCAoZXg6DQogICog
ZnMgdHJ1bmNhdGUvaG9sZSBwdW5jaCkgdnMgcGlubmVkIHBhZ2VzIChleDogZGV2aWNlIGRtYSku
DQogICoNCi0gKiBNRU1PUllfREVWSUNFX0RFVkRBWDoNCisgKiBNRU1PUllfREVWSUNFX0dFTkVS
SUM6DQogICogSG9zdCBtZW1vcnkgdGhhdCBoYXMgc2ltaWxhciBhY2Nlc3Mgc2VtYW50aWNzIGFz
IFN5c3RlbSBSQU0gaS5lLiBETUENCi0gKiBjb2hlcmVudCBhbmQgc3VwcG9ydHMgcGFnZSBwaW5u
aW5nLiBJbiBjb250cmFzdCB0bw0KLSAqIE1FTU9SWV9ERVZJQ0VfRlNfREFYLCB0aGlzIG1lbW9y
eSBpcyBhY2Nlc3MgdmlhIGEgZGV2aWNlLWRheA0KLSAqIGNoYXJhY3RlciBkZXZpY2UuDQorICog
Y29oZXJlbnQgYW5kIHN1cHBvcnRzIHBhZ2UgcGlubmluZy4gVGhpcyBpcyBmb3IgZXhhbXBsZSB1
c2VkIGJ5IERBWCBkZXZpY2VzDQorICogdGhhdCBleHBvc2UgbWVtb3J5IHVzaW5nIGEgY2hhcmFj
dGVyIGRldmljZS4NCiAgKg0KICAqIE1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQToNCiAgKiBEZXZp
Y2UgbWVtb3J5IHJlc2lkaW5nIGluIGEgUENJIEJBUiBpbnRlbmRlZCBmb3IgdXNlIHdpdGggUGVl
ci10by1QZWVyDQpAQCAtNjAsNyArNTksNyBAQCBlbnVtIG1lbW9yeV90eXBlIHsNCiAJLyogMCBp
cyByZXNlcnZlZCB0byBjYXRjaCB1bmluaXRpYWxpemVkIHR5cGUgZmllbGRzICovDQogCU1FTU9S
WV9ERVZJQ0VfUFJJVkFURSA9IDEsDQogCU1FTU9SWV9ERVZJQ0VfRlNfREFYLA0KLQlNRU1PUllf
REVWSUNFX0RFVkRBWCwNCisJTUVNT1JZX0RFVklDRV9HRU5FUklDLA0KIAlNRU1PUllfREVWSUNF
X1BDSV9QMlBETUEsDQogfTsNCiANCmRpZmYgLS1naXQgYS9tbS9tZW1yZW1hcC5jIGIvbW0vbWVt
cmVtYXAuYw0KaW5kZXggMDNlMzhiN2EzOGYxLi4wMDZkYWNlNjBiMWEgMTAwNjQ0DQotLS0gYS9t
bS9tZW1yZW1hcC5jDQorKysgYi9tbS9tZW1yZW1hcC5jDQpAQCAtMjE2LDcgKzIxNiw3IEBAIHZv
aWQgKm1lbXJlbWFwX3BhZ2VzKHN0cnVjdCBkZXZfcGFnZW1hcCAqcGdtYXAsIGludCBuaWQpDQog
CQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQogCQl9DQogCQlicmVhazsNCi0JY2FzZSBNRU1P
UllfREVWSUNFX0RFVkRBWDoNCisJY2FzZSBNRU1PUllfREVWSUNFX0dFTkVSSUM6DQogCQluZWVk
X2Rldm1hcF9tYW5hZ2VkID0gZmFsc2U7DQogCQlicmVhazsNCiAJY2FzZSBNRU1PUllfREVWSUNF
X1BDSV9QMlBETUE6DQotLSANCjIuMjguMA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
