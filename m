Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6CFD1DC
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Nov 2019 01:11:41 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF6FD100DC3D2;
	Thu, 14 Nov 2019 16:13:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.65; helo=hqemgate16.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A128E100DC3CB
	for <linux-nvdimm@lists.01.org>; Thu, 14 Nov 2019 16:13:03 -0800 (PST)
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dcded000002>; Thu, 14 Nov 2019 16:10:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 14 Nov 2019 16:11:36 -0800
X-PGP-Universal: processed;
	by hqpgpgate102.nvidia.com on Thu, 14 Nov 2019 16:11:36 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Nov
 2019 00:11:35 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 15 Nov 2019 00:11:35 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
	id <B5dcded370002>; Thu, 14 Nov 2019 16:11:35 -0800
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for ZONE_DEVICE pages
Date: Thu, 14 Nov 2019 16:11:34 -0800
Message-ID: <20191115001134.2489505-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115001134.2489505-1-jhubbard@nvidia.com>
References: <20191115001134.2489505-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1573776640; bh=OEnwZ2pSOFUNQcV1LOpiequ14+DMiNnpojwFAjOdr0c=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
	 Content-Type:Content-Transfer-Encoding;
	b=hB9h9gjW0c3C08FCy3+gLp9voBujaR83KWrC5mU8KXeWrya1Pb61/u+edL6Ezc/TZ
	 MSTb687YTiPx8+d/I6LC2ni+dF3upNUCHWqhGjH8nCVCpHbVNWkSc+U3cXB6qyo+fV
	 xnEBn86LqfvRH4ka47Iu8zoXZhpu/Mwfjl2Nb/jszi6dqbKs6NBRkF2duwqIIH5Gv3
	 wU0ZLEMxWVwsKb0yhP5jLMfx9aT7nrVOCDpBGbbSglm4lxNPXuBumeOwiKMa9+qOnw
	 ms7a5lQlsByJ3OZqmP0+TxpCagQo2O2dNr4zgGaa52edg6t/z/ZL2Nmce4Jy/tZddE
	 Sl8ZKwIxA78dA==
Message-ID-Hash: D2HKY4ZRFVK5SMIODIOLOZ2EZEMIPHOV
X-Message-ID-Hash: D2HKY4ZRFVK5SMIODIOLOZ2EZEMIPHOV
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D2HKY4ZRFVK5SMIODIOLOZ2EZEMIPHOV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QW4gdXBjb21pbmcgcGF0Y2ggY2hhbmdlcyBhbmQgY29tcGxpY2F0ZXMgdGhlIHJlZmNvdW50aW5n
IGFuZA0KZXNwZWNpYWxseSB0aGUgInB1dCBwYWdlIiBhc3BlY3RzIG9mIGl0LiBJbiBvcmRlciB0
byBrZWVwDQpldmVyeXRoaW5nIGNsZWFuLCByZWZhY3RvciB0aGUgZGV2bWFwIHBhZ2UgcmVsZWFz
ZSByb3V0aW5lczoNCg0KKiBSZW5hbWUgcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2UoKSB0byBwYWdl
X2lzX2Rldm1hcF9tYW5hZ2VkKCksDQogIGFuZCBsaW1pdCB0aGUgZnVuY3Rpb25hbGl0eSB0byAi
cmVhZCBvbmx5IjogcmV0dXJuIGEgYm9vbCwNCiAgd2l0aCBubyBzaWRlIGVmZmVjdHMuDQoNCiog
QWRkIGEgbmV3IHJvdXRpbmUsIHB1dF9kZXZtYXBfbWFuYWdlZF9wYWdlKCksIHRvIGhhbmRsZSBj
aGVja2luZw0KICB3aGF0IGtpbmQgb2YgcGFnZSBpdCBpcywgYW5kIHdoYXQga2luZCBvZiByZWZj
b3VudCBoYW5kbGluZyBpdA0KICByZXF1aXJlcy4NCg0KKiBSZW5hbWUgX19wdXRfZGV2bWFwX21h
bmFnZWRfcGFnZSgpIHRvIGZyZWVfZGV2bWFwX21hbmFnZWRfcGFnZSgpLA0KICBhbmQgbGltaXQg
dGhlIGZ1bmN0aW9uYWxpdHkgdG8gdW5jb25kaXRpb25hbGx5IGZyZWVpbmcgYSBkZXZtYXANCiAg
cGFnZS4NCg0KVGhpcyBpcyBvcmlnaW5hbGx5IGJhc2VkIG9uIGEgc2VwYXJhdGUgcGF0Y2ggYnkg
SXJhIFdlaW55LCB3aGljaA0KYXBwbGllZCB0byBhbiBlYXJseSB2ZXJzaW9uIG9mIHRoZSBwdXRf
dXNlcl9wYWdlKCkgZXhwZXJpbWVudHMuDQpTaW5jZSB0aGVuLCBKw6lyw7RtZSBHbGlzc2Ugc3Vn
Z2VzdGVkIHRoZSByZWZhY3RvcmluZyBkZXNjcmliZWQgYWJvdmUuDQoNCkNjOiBKYW4gS2FyYSA8
amFja0BzdXNlLmN6Pg0KQ2M6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29tPg0K
Q2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KQ2M6IERhbiBXaWxsaWFtcyA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KU3VnZ2VzdGVkLWJ5OiBKw6lyw7RtZSBHbGlzc2UgPGpn
bGlzc2VAcmVkaGF0LmNvbT4NClNpZ25lZC1vZmYtYnk6IElyYSBXZWlueSA8aXJhLndlaW55QGlu
dGVsLmNvbT4NClNpZ25lZC1vZmYtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJhcmRAbnZpZGlhLmNv
bT4NCi0tLQ0KIGluY2x1ZGUvbGludXgvbW0uaCB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysr
Ky0tLQ0KIG1tL21lbXJlbWFwLmMgICAgICB8IDE2ICsrLS0tLS0tLS0tLS0tLS0NCiAyIGZpbGVz
IGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQppbmRleCBhMmFkZjk1
YjNmOWMuLjk2MjI4Mzc2MTM5YyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbW0uaA0KKysr
IGIvaW5jbHVkZS9saW51eC9tbS5oDQpAQCAtOTY3LDkgKzk2NywxMCBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgaXNfem9uZV9kZXZpY2VfcGFnZShjb25zdCBzdHJ1Y3QgcGFnZSAqcGFnZSkNCiAjZW5k
aWYNCiANCiAjaWZkZWYgQ09ORklHX0RFVl9QQUdFTUFQX09QUw0KLXZvaWQgX19wdXRfZGV2bWFw
X21hbmFnZWRfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSk7DQordm9pZCBmcmVlX2Rldm1hcF9tYW5h
Z2VkX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpOw0KIERFQ0xBUkVfU1RBVElDX0tFWV9GQUxTRShk
ZXZtYXBfbWFuYWdlZF9rZXkpOw0KLXN0YXRpYyBpbmxpbmUgYm9vbCBwdXRfZGV2bWFwX21hbmFn
ZWRfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCisNCitzdGF0aWMgaW5saW5lIGJvb2wgcGFnZV9p
c19kZXZtYXBfbWFuYWdlZChzdHJ1Y3QgcGFnZSAqcGFnZSkNCiB7DQogCWlmICghc3RhdGljX2Jy
YW5jaF91bmxpa2VseSgmZGV2bWFwX21hbmFnZWRfa2V5KSkNCiAJCXJldHVybiBmYWxzZTsNCkBA
IC05NzgsNyArOTc5LDYgQEAgc3RhdGljIGlubGluZSBib29sIHB1dF9kZXZtYXBfbWFuYWdlZF9w
YWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KIAlzd2l0Y2ggKHBhZ2UtPnBnbWFwLT50eXBlKSB7DQog
CWNhc2UgTUVNT1JZX0RFVklDRV9QUklWQVRFOg0KIAljYXNlIE1FTU9SWV9ERVZJQ0VfRlNfREFY
Og0KLQkJX19wdXRfZGV2bWFwX21hbmFnZWRfcGFnZShwYWdlKTsNCiAJCXJldHVybiB0cnVlOw0K
IAlkZWZhdWx0Og0KIAkJYnJlYWs7DQpAQCAtOTg2LDYgKzk4NiwyNyBAQCBzdGF0aWMgaW5saW5l
IGJvb2wgcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQogCXJldHVy
biBmYWxzZTsNCiB9DQogDQorc3RhdGljIGlubGluZSBib29sIHB1dF9kZXZtYXBfbWFuYWdlZF9w
YWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KK3sNCisJYm9vbCBpc19kZXZtYXAgPSBwYWdlX2lzX2Rl
dm1hcF9tYW5hZ2VkKHBhZ2UpOw0KKw0KKwlpZiAoaXNfZGV2bWFwKSB7DQorCQlpbnQgY291bnQg
PSBwYWdlX3JlZl9kZWNfcmV0dXJuKHBhZ2UpOw0KKw0KKwkJLyoNCisJCSAqIGRldm1hcCBwYWdl
IHJlZmNvdW50cyBhcmUgMS1iYXNlZCwgcmF0aGVyIHRoYW4gMC1iYXNlZDogaWYNCisJCSAqIHJl
ZmNvdW50IGlzIDEsIHRoZW4gdGhlIHBhZ2UgaXMgZnJlZSBhbmQgdGhlIHJlZmNvdW50IGlzDQor
CQkgKiBzdGFibGUgYmVjYXVzZSBub2JvZHkgaG9sZHMgYSByZWZlcmVuY2Ugb24gdGhlIHBhZ2Uu
DQorCQkgKi8NCisJCWlmIChjb3VudCA9PSAxKQ0KKwkJCWZyZWVfZGV2bWFwX21hbmFnZWRfcGFn
ZShwYWdlKTsNCisJCWVsc2UgaWYgKCFjb3VudCkNCisJCQlfX3B1dF9wYWdlKHBhZ2UpOw0KKwl9
DQorDQorCXJldHVybiBpc19kZXZtYXA7DQorfQ0KKw0KICNlbHNlIC8qIENPTkZJR19ERVZfUEFH
RU1BUF9PUFMgKi8NCiBzdGF0aWMgaW5saW5lIGJvb2wgcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2Uo
c3RydWN0IHBhZ2UgKnBhZ2UpDQogew0KZGlmZiAtLWdpdCBhL21tL21lbXJlbWFwLmMgYi9tbS9t
ZW1yZW1hcC5jDQppbmRleCBlODk5ZmE4NzZhNjIuLjJiYTc3Mzg1OTAzMSAxMDA2NDQNCi0tLSBh
L21tL21lbXJlbWFwLmMNCisrKyBiL21tL21lbXJlbWFwLmMNCkBAIC00MTEsMjAgKzQxMSw4IEBA
IHN0cnVjdCBkZXZfcGFnZW1hcCAqZ2V0X2Rldl9wYWdlbWFwKHVuc2lnbmVkIGxvbmcgcGZuLA0K
IEVYUE9SVF9TWU1CT0xfR1BMKGdldF9kZXZfcGFnZW1hcCk7DQogDQogI2lmZGVmIENPTkZJR19E
RVZfUEFHRU1BUF9PUFMNCi12b2lkIF9fcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2Uoc3RydWN0IHBh
Z2UgKnBhZ2UpDQordm9pZCBmcmVlX2Rldm1hcF9tYW5hZ2VkX3BhZ2Uoc3RydWN0IHBhZ2UgKnBh
Z2UpDQogew0KLQlpbnQgY291bnQgPSBwYWdlX3JlZl9kZWNfcmV0dXJuKHBhZ2UpOw0KLQ0KLQkv
KiBzdGlsbCBidXN5ICovDQotCWlmIChjb3VudCA+IDEpDQotCQlyZXR1cm47DQotDQotCS8qIG9u
bHkgdHJpZ2dlcmVkIGJ5IHRoZSBkZXZfcGFnZW1hcCBzaHV0ZG93biBwYXRoICovDQotCWlmIChj
b3VudCA9PSAwKSB7DQotCQlfX3B1dF9wYWdlKHBhZ2UpOw0KLQkJcmV0dXJuOw0KLQl9DQotDQog
CS8qIG5vdGlmeSBwYWdlIGlkbGUgZm9yIGRheCAqLw0KIAlpZiAoIWlzX2RldmljZV9wcml2YXRl
X3BhZ2UocGFnZSkpIHsNCiAJCXdha2VfdXBfdmFyKCZwYWdlLT5fcmVmY291bnQpOw0KQEAgLTQ2
MSw1ICs0NDksNSBAQCB2b2lkIF9fcHV0X2Rldm1hcF9tYW5hZ2VkX3BhZ2Uoc3RydWN0IHBhZ2Ug
KnBhZ2UpDQogCXBhZ2UtPm1hcHBpbmcgPSBOVUxMOw0KIAlwYWdlLT5wZ21hcC0+b3BzLT5wYWdl
X2ZyZWUocGFnZSk7DQogfQ0KLUVYUE9SVF9TWU1CT0woX19wdXRfZGV2bWFwX21hbmFnZWRfcGFn
ZSk7DQorRVhQT1JUX1NZTUJPTChmcmVlX2Rldm1hcF9tYW5hZ2VkX3BhZ2UpOw0KICNlbmRpZiAv
KiBDT05GSUdfREVWX1BBR0VNQVBfT1BTICovDQotLSANCjIuMjQuMA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
