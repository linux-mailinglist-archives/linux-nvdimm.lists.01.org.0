Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEDA25772E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 12:19:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FFE1139915FB;
	Mon, 31 Aug 2020 03:19:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.155.144; helo=esa4.hc3370-68.iphmx.com; envelope-from=roger.pau@citrix.com; receiver=<UNKNOWN> 
Received: from esa4.hc3370-68.iphmx.com (esa4.hc3370-68.iphmx.com [216.71.155.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6090C13991501
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1598869157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LeOijzUwMXdvkDZh8ZExAKrzefOMcwxRYnkT30H6cak=;
  b=BHsS6ifiXDGDPhmSRFYFCRskfreHKWZZNXzDDPQ7zUgxReAs8f6lTbJk
   Xl6Fukg8Srp53QCEO8RtqW5uX2diVMVas02UgvKFJYX2m/5kUw1VFch65
   hn7a5QUnsFrg0nIhuwaPxa3aJaXtcMQqJ16Sy1qxxGnDJ9Dxw/jpicQqc
   Y=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: eWPQ8PRo6r0pd8QAR03BDDXV1YAGXcgVKaAT1jr7yslt/m/BRiG+ygAM5Hg5dng98CZbXgJIRL
 TrqSjrZy6HmI3tiTkKmcBWku337jv3S0EsUktgRx6C7cUgLduAaZtZg15fyRawmnG3RAqkgmb+
 ba0pRICuEAkuQK8+Anjdo7aw0WfwKjVCCyEcDz1JvJdrf3/sLX7mleER+GXLtaVO6OxW0oqVDb
 8HGx2ZOrPZoNphcY+W0vv75NhXZGU+B3oZz0hISUUplPeCmIdQ/npzPJPsL3Tv8Q3Rl0SESIyG
 yDg=
X-SBRS: 2.7
X-MesageID: 26582307
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,375,1592884800";
   d="scan'208";a="26582307"
Date: Mon, 31 Aug 2020 12:19:07 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Dan Williams <dan.j.williams@intel.com>, David Hildenbrand
	<david@redhat.com>
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
Message-ID: <20200831101907.GA753@Air-de-Roger>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
 <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
 <20200820113741.GV828@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200820113741.GV828@Air-de-Roger>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Message-ID-Hash: ERFIHR4LPZZYLC4UVXP2TNZVJGMYZJGN
X-Message-ID-Hash: ERFIHR4LPZZYLC4UVXP2TNZVJGMYZJGN
X-MailFrom: roger.pau@citrix.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ERFIHR4LPZZYLC4UVXP2TNZVJGMYZJGN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVGh1LCBBdWcgMjAsIDIwMjAgYXQgMDE6Mzc6NDFQTSArMDIwMCwgUm9nZXIgUGF1IE1vbm7D
qSB3cm90ZToNCj4gT24gVHVlLCBBdWcgMTEsIDIwMjAgYXQgMTE6MDc6MzZQTSArMDIwMCwgRGF2
aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+ID4gT24gMTEuMDguMjAgMTE6NDQsIFJvZ2VyIFBhdSBN
b25uZSB3cm90ZToNCj4gPiA+IFRoaXMgaXMgaW4gcHJlcGFyYXRpb24gZm9yIHRoZSBsb2dpYyBi
ZWhpbmQgTUVNT1JZX0RFVklDRV9ERVZEQVggYWxzbw0KPiA+ID4gYmVpbmcgdXNlZCBieSBub24g
REFYIGRldmljZXMuDQo+ID4gPiANCj4gPiA+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGludGVuZGVk
Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5w
YXVAY2l0cml4LmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVy
bWFAaW50ZWwuY29tPg0KPiA+ID4gQ2M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29t
Pg0KPiA+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+
ID4gPiBDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+ID4gPiBDYzogSXJhIFdl
aW55IDxpcmEud2VpbnlAaW50ZWwuY29tPg0KPiA+ID4gQ2M6ICJBbmVlc2ggS3VtYXIgSy5WIiA8
YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+DQo+ID4gPiBDYzogSm9oYW5uZXMgVGh1bXNoaXJu
IDxqdGh1bXNoaXJuQHN1c2UuZGU+DQo+ID4gPiBDYzogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdA
ZGVsdGF0ZWUuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCj4gPiA+
IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4gPiA+IENjOiBsaW51eC1tbUBr
dmFjay5vcmcNCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZGF4L2RldmljZS5jICAgICB8IDIg
Ky0NCj4gPiA+ICBpbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggfCA5ICsrKystLS0tLQ0KPiA+ID4g
IG1tL21lbXJlbWFwLmMgICAgICAgICAgICB8IDIgKy0NCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZGF4L2RldmljZS5jIGIvZHJpdmVycy9kYXgvZGV2aWNlLmMNCj4gPiA+IGlu
ZGV4IDRjMGFmMmViN2UxOS4uMWU4OTUxM2YzYzU5IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVy
cy9kYXgvZGV2aWNlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZGF4L2RldmljZS5jDQo+ID4gPiBA
QCAtNDI5LDcgKzQyOSw3IEBAIGludCBkZXZfZGF4X3Byb2JlKHN0cnVjdCBkZXZpY2UgKmRldikN
Cj4gPiA+ICAJCXJldHVybiAtRUJVU1k7DQo+ID4gPiAgCX0NCj4gPiA+ICANCj4gPiA+IC0JZGV2
X2RheC0+cGdtYXAudHlwZSA9IE1FTU9SWV9ERVZJQ0VfREVWREFYOw0KPiA+ID4gKwlkZXZfZGF4
LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklDRV9HRU5FUklDOw0KPiA+ID4gIAlhZGRyID0gZGV2
bV9tZW1yZW1hcF9wYWdlcyhkZXYsICZkZXZfZGF4LT5wZ21hcCk7DQo+ID4gPiAgCWlmIChJU19F
UlIoYWRkcikpDQo+ID4gPiAgCQlyZXR1cm4gUFRSX0VSUihhZGRyKTsNCj4gPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmggYi9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgN
Cj4gPiA+IGluZGV4IDVmNWIyZGYwNmU2MS4uZTU4NjI3NDY3NTFiIDEwMDY0NA0KPiA+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21l
bXJlbWFwLmgNCj4gPiA+IEBAIC00NiwxMSArNDYsMTAgQEAgc3RydWN0IHZtZW1fYWx0bWFwIHsN
Cj4gPiA+ICAgKiB3YWtldXAgaXMgdXNlZCB0byBjb29yZGluYXRlIHBoeXNpY2FsIGFkZHJlc3Mg
c3BhY2UgbWFuYWdlbWVudCAoZXg6DQo+ID4gPiAgICogZnMgdHJ1bmNhdGUvaG9sZSBwdW5jaCkg
dnMgcGlubmVkIHBhZ2VzIChleDogZGV2aWNlIGRtYSkuDQo+ID4gPiAgICoNCj4gPiA+IC0gKiBN
RU1PUllfREVWSUNFX0RFVkRBWDoNCj4gPiA+ICsgKiBNRU1PUllfREVWSUNFX0dFTkVSSUM6DQo+
ID4gPiAgICogSG9zdCBtZW1vcnkgdGhhdCBoYXMgc2ltaWxhciBhY2Nlc3Mgc2VtYW50aWNzIGFz
IFN5c3RlbSBSQU0gaS5lLiBETUENCj4gPiA+IC0gKiBjb2hlcmVudCBhbmQgc3VwcG9ydHMgcGFn
ZSBwaW5uaW5nLiBJbiBjb250cmFzdCB0bw0KPiA+ID4gLSAqIE1FTU9SWV9ERVZJQ0VfRlNfREFY
LCB0aGlzIG1lbW9yeSBpcyBhY2Nlc3MgdmlhIGEgZGV2aWNlLWRheA0KPiA+ID4gLSAqIGNoYXJh
Y3RlciBkZXZpY2UuDQo+ID4gPiArICogY29oZXJlbnQgYW5kIHN1cHBvcnRzIHBhZ2UgcGlubmlu
Zy4gVGhpcyBpcyBmb3IgZXhhbXBsZSB1c2VkIGJ5IERBWCBkZXZpY2VzDQo+ID4gPiArICogdGhh
dCBleHBvc2UgbWVtb3J5IHVzaW5nIGEgY2hhcmFjdGVyIGRldmljZS4NCj4gPiA+ICAgKg0KPiA+
ID4gICAqIE1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQToNCj4gPiA+ICAgKiBEZXZpY2UgbWVtb3J5
IHJlc2lkaW5nIGluIGEgUENJIEJBUiBpbnRlbmRlZCBmb3IgdXNlIHdpdGggUGVlci10by1QZWVy
DQo+ID4gPiBAQCAtNjAsNyArNTksNyBAQCBlbnVtIG1lbW9yeV90eXBlIHsNCj4gPiA+ICAJLyog
MCBpcyByZXNlcnZlZCB0byBjYXRjaCB1bmluaXRpYWxpemVkIHR5cGUgZmllbGRzICovDQo+ID4g
PiAgCU1FTU9SWV9ERVZJQ0VfUFJJVkFURSA9IDEsDQo+ID4gPiAgCU1FTU9SWV9ERVZJQ0VfRlNf
REFYLA0KPiA+ID4gLQlNRU1PUllfREVWSUNFX0RFVkRBWCwNCj4gPiA+ICsJTUVNT1JZX0RFVklD
RV9HRU5FUklDLA0KPiA+ID4gIAlNRU1PUllfREVWSUNFX1BDSV9QMlBETUEsDQo+ID4gPiAgfTsN
Cj4gPiA+ICANCj4gPiA+IGRpZmYgLS1naXQgYS9tbS9tZW1yZW1hcC5jIGIvbW0vbWVtcmVtYXAu
Yw0KPiA+ID4gaW5kZXggMDNlMzhiN2EzOGYxLi4wMDZkYWNlNjBiMWEgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9tbS9tZW1yZW1hcC5jDQo+ID4gPiArKysgYi9tbS9tZW1yZW1hcC5jDQo+ID4gPiBAQCAt
MjE2LDcgKzIxNiw3IEBAIHZvaWQgKm1lbXJlbWFwX3BhZ2VzKHN0cnVjdCBkZXZfcGFnZW1hcCAq
cGdtYXAsIGludCBuaWQpDQo+ID4gPiAgCQkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ID4g
PiAgCQl9DQo+ID4gPiAgCQlicmVhazsNCj4gPiA+IC0JY2FzZSBNRU1PUllfREVWSUNFX0RFVkRB
WDoNCj4gPiA+ICsJY2FzZSBNRU1PUllfREVWSUNFX0dFTkVSSUM6DQo+ID4gPiAgCQluZWVkX2Rl
dm1hcF9tYW5hZ2VkID0gZmFsc2U7DQo+ID4gPiAgCQlicmVhazsNCj4gPiA+ICAJY2FzZSBNRU1P
UllfREVWSUNFX1BDSV9QMlBETUE6DQo+ID4gPiANCj4gPiANCj4gPiBObyBzdHJvbmcgb3Bpbmlv
biAoQERhbj8pLCBJIGRvIHdvbmRlciBpZiBhIHNlcGFyYXRlIHR5cGUgd291bGQgbWFrZSBzZW5z
ZS4NCj4gDQo+IEdlbnRsZSBwaW5nLg0KDQpTb3JyeSB0byBwaW5nIGFnYWluLCBidXQgSSB3b3Vs
ZCByYXRoZXIgZ2V0IHRoaXMgb3V0IG9mIG15IHF1ZXVlIGlmDQpwb3NzaWJsZSwgc2VlaW5nIGFz
IHRoZSBvdGhlciBwYXRjaCBpcyBPSyB0byBnbyBpbiBidXQgZGVwZW5kcyBvbiB0aGlzDQpvbmUg
Z29pbmcgaW4gZmlyc3QuDQoNClRoYW5rcywgUm9nZXIuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
bnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
