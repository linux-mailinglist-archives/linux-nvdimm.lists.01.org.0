Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8527FBD21
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 01:42:07 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD4C5100DC437;
	Wed, 13 Nov 2019 16:43:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.228.121.64; helo=hqemgate15.nvidia.com; envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN> 
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2AB0100DC436
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 16:43:38 -0800 (PST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5dcca2da0000>; Wed, 13 Nov 2019 16:42:02 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Nov 2019 16:42:03 -0800
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Wed, 13 Nov 2019 16:42:03 -0800
Received: from [10.2.160.107] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 Nov
 2019 00:42:02 +0000
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To: Dan Williams <dan.j.williams@intel.com>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
Date: Wed, 13 Nov 2019 16:39:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1573692122; bh=nHBqKFuyS3Jqi47A+b+7bCsdLPkBjyfHLHVyQVlH5s4=;
	h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=mfj+mls9Md6loxbYBg0RKUGTHWE83J7r/HTza4FSYS/5NJpTEpg2CWpo40dqRX44+
	 ajl43OHTFYsQowjpTzBH7ZG1pTO8SEok2b2z6W9HC0AEQFF5y+7ki4ZiCjuAmJhSUr
	 9145t48pXQ16RpzNBRlEsbqImCl8QHDCSXJVmguYGxAxx7q3iSEy9ByUVyfDVBNq71
	 aqkHuqQyRRpBigl9VkMvUrwWr/3fmaRqMIns6aKSWPne9X5LHUJKn05kH8ejTwpgaC
	 UQKKSqa3O0YFIGHAms67s2H1FHY6cwFQ/zBsA72LKnaD5bDaMSzkNvOJRvU456t2A+
	 JWCL34W+vVxBA==
Message-ID-Hash: NGI5NMGLCDYV2ZLUHMUB4JDLOMSUOQXV
X-Message-ID-Hash: NGI5NMGLCDYV2ZLUHMUB4JDLOMSUOQXV
X-MailFrom: jhubbard@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NGI5NMGLCDYV2ZLUHMUB4JDLOMSUOQXV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTEvMTMvMTkgNDowNyBQTSwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiBBZnRlciB0aGUgcmVt
b3ZhbCBvZiB0aGUgZGV2aWNlLXB1YmxpYyBpbmZyYXN0cnVjdHVyZSB0aGVyZSBhcmUgb25seSAy
DQo+IC0+cGFnZV9mcmVlKCkgY2FsbCBiYWNrcyBpbiB0aGUga2VybmVsLiBPbmUgb2YgdGhvc2Ug
aXMgYSBkZXZpY2UtcHJpdmF0ZQ0KPiBjYWxsYmFjayBpbiB0aGUgbm91dmVhdSBkcml2ZXIsIHRo
ZSBvdGhlciBpcyBhIGdlbmVyaWMgd2FrZXVwIG5lZWRlZCBpbg0KPiB0aGUgREFYIGNhc2UuIElu
IHRoZSBob3BlcyB0aGF0IGFsbCAtPnBhZ2VfZnJlZSgpIGNhbGxiYWNrcyBjYW4gYmUNCj4gbWln
cmF0ZWQgdG8gY29tbW9uIGNvcmUga2VybmVsIGZ1bmN0aW9uYWxpdHksIG1vdmUgdGhlIGRldmlj
ZS1wcml2YXRlDQo+IHNwZWNpZmljIGFjdGlvbnMgaW4gX19wdXRfZGV2bWFwX21hbmFnZWRfcGFn
ZSgpIHVuZGVyIHRoZQ0KPiBpc19kZXZpY2VfcHJpdmF0ZV9wYWdlKCkgY29uZGl0aW9uYWwsIGlu
Y2x1ZGluZyB0aGUgLT5wYWdlX2ZyZWUoKQ0KPiBjYWxsYmFjay4gRm9yIHRoZSBvdGhlciBwYWdl
IHR5cGVzIGp1c3Qgb3Blbi1jb2RlIHRoZSBnZW5lcmljIHdha2V1cC4NCj4gDQo+IFllcywgdGhl
IHdha2V1cCBpcyBvbmx5IG5lZWRlZCBpbiB0aGUgTUVNT1JZX0RFVklDRV9GU0RBWCBjYXNlLCBi
dXQgaXQNCj4gZG9lcyBubyBoYXJtIGluIHRoZSBNRU1PUllfREVWSUNFX0RFVkRBWCBhbmQgTUVN
T1JZX0RFVklDRV9QQ0lfUDJQRE1BDQo+IGNhc2UuDQo+IA0KPiBDYzogSmFuIEthcmEgPGphY2tA
c3VzZS5jej4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBDYzogSXJh
IFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiBDYzogSsOpcsO0bWUgR2xpc3NlIDxqZ2xp
c3NlQHJlZGhhdC5jb20+DQo+IENjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gSGkgSm9obiwNCj4gDQo+IFRoaXMgYXBwbGllcyBvbiB0b3Agb2YgdG9kYXkn
cyBsaW51eC1uZXh0IGFuZCBwYXNzZXMgbXkgbnZkaW1tIHVuaXQNCj4gdGVzdHMuIFRoYXQgdGVz
dGluZyBub3RpY2VkIHRoYXQgZGV2bWFwX21hbmFnZWRfZW5hYmxlX2dldCgpIG5lZWRlZCBhDQo+
IHNtYWxsIGZpeHVwIGFzIHdlbGwuDQoNCkdvdCBpdC4gVGhpcyB3aWxsIGFwcGVhciBpbiB0aGUg
bmV4dCBwb3N0ZWQgdmVyc2lvbiBvZiBteSAibW0vZ3VwOiB0cmFjaw0KZG1hLXBpbm5lZCBwYWdl
czogRk9MTF9QSU4sIEZPTExfTE9OR1RFUk0iIHBhdGNoc2V0Lg0KDQoNCj4gDQo+ICAgZHJpdmVy
cy9udmRpbW0vcG1lbS5jIHwgICAgNiAtLS0tLS0NCj4gICBtbS9tZW1yZW1hcC5jICAgICAgICAg
fCAgIDIyICsrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBpbmRleCBmOWY3NmY2YmEw
N2IuLjIxZGIxY2U4YzBhZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBAQCAtMzM4LDEzICszMzgsNyBAQCBzdGF0
aWMgdm9pZCBwbWVtX3JlbGVhc2VfZGlzayh2b2lkICpfX3BtZW0pDQo+ICAgCXB1dF9kaXNrKHBt
ZW0tPmRpc2spOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyB2b2lkIHBtZW1fcGFnZW1hcF9wYWdl
X2ZyZWUoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+IC17DQo+IC0Jd2FrZV91cF92YXIoJnBhZ2UtPl9y
ZWZjb3VudCk7DQo+IC19DQo+IC0NCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGRldl9wYWdlbWFw
X29wcyBmc2RheF9wYWdlbWFwX29wcyA9IHsNCj4gLQkucGFnZV9mcmVlCQk9IHBtZW1fcGFnZW1h
cF9wYWdlX2ZyZWUsDQo+ICAgCS5raWxsCQkJPSBwbWVtX3BhZ2VtYXBfa2lsbCwNCj4gICAJLmNs
ZWFudXAJCT0gcG1lbV9wYWdlbWFwX2NsZWFudXAsDQo+ICAgfTsNCj4gZGlmZiAtLWdpdCBhL21t
L21lbXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jDQo+IGluZGV4IDAyMmU3OGU2OGVhMC4uNmU2ZjNk
NmZkYjczIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1yZW1hcC5jDQo+ICsrKyBiL21tL21lbXJlbWFw
LmMNCj4gQEAgLTI3LDcgKzI3LDggQEAgc3RhdGljIHZvaWQgZGV2bWFwX21hbmFnZWRfZW5hYmxl
X3B1dCh2b2lkKQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgZGV2bWFwX21hbmFnZWRfZW5hYmxlX2dl
dChzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwKQ0KPiAgIHsNCj4gLQlpZiAoIXBnbWFwLT5vcHMg
fHwgIXBnbWFwLT5vcHMtPnBhZ2VfZnJlZSkgew0KPiArCWlmICghcGdtYXAtPm9wcyB8fCAocGdt
YXAtPnR5cGUgPT0gTUVNT1JZX0RFVklDRV9QUklWQVRFDQo+ICsJCQkJJiYgIXBnbWFwLT5vcHMt
PnBhZ2VfZnJlZSkpIHsNCg0KDQpPSywgc28gb25seSBNRU1PUllfREVWSUNFX1BSSVZBVEUgaGFz
IC5wYWdlX2ZyZWUgb3BzLiBUaGF0IGxvb2tzDQpjb3JyZWN0IHRvIG1lLCBiYXNlZCBvbiBsb29r
aW5nIGF0IHRoZSAucGFnZV9mcmVlIHNldHRlcnMtLUkNCm9ubHkgc2VlIE5vdXZlYXUgc2V0dGlu
ZyBpdC4NCg0KDQp0aGFua3MsDQotLSANCkpvaG4gSHViYmFyZA0KTlZJRElBCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
