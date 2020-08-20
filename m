Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6662E24B902
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Aug 2020 13:37:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 74A721353296C;
	Thu, 20 Aug 2020 04:37:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.71.145.142; helo=esa1.hc3370-68.iphmx.com; envelope-from=roger.pau@citrix.com; receiver=<UNKNOWN> 
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C3EE31353296A
	for <linux-nvdimm@lists.01.org>; Thu, 20 Aug 2020 04:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1597923470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZAirrqoSKLQOVqqJWBpKueJlrlW7WlH8PvguimBoqcg=;
  b=USgWkIUa7F4+BEqsBiUuWl8Ky2/SRO+RkRMBNd1B8xwhlWeo/jjUm5Sa
   Up9mPHwu33dnpjz09eKVzNIMJ7yeylSn9iXidQINTH+00MIEsHTZzmPY3
   pgCKphBTBN1Ypod3YZs8whiOY7hEPzofDUMprdyLMskMp9jRxXMQRRTaE
   8=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: 4nBaFLnRpBD3ly5eX58Un7Lg/gZ5xsv5/Atyb5KJyqp4Du0CE2K9eo3l0sHk6/iSuj0LcBplRs
 py/XsJnWH7CdQGPSyE9v0yfz1MTNlSBZRIqxId7A4BgJJP378Gr9g+yK8exusIK58eq7+ig1yE
 VMXT2qTxtvv93zngpqJ42vMERlxiMlDzOz7+ksKh5LNya7cBceZYtkNHTRCz2Wl8K1LVGTgB08
 DLgsy5wuMhnM/QCgRFDIz9M8mSd0hyZIKVqkd/EUnPb0uRZumstAnrPk+F9aHn+BCzwywOcY8+
 faw=
X-SBRS: 2.7
X-MesageID: 25271840
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,332,1592884800";
   d="scan'208";a="25271840"
Date: Thu, 20 Aug 2020 13:37:41 +0200
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
Message-ID: <20200820113741.GV828@Air-de-Roger>
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
 <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Message-ID-Hash: LVZDD3HDCVTBRSKXBZ3WTKQPL6DKXN4O
X-Message-ID-Hash: LVZDD3HDCVTBRSKXBZ3WTKQPL6DKXN4O
X-MailFrom: roger.pau@citrix.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, "Logan Gunthorpe  <logang@deltatee.com>, <linux-nvdimm@lists.01.org>," <xen-devel@lists.xenproject.org>, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVZDD3HDCVTBRSKXBZ3WTKQPL6DKXN4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

T24gVHVlLCBBdWcgMTEsIDIwMjAgYXQgMTE6MDc6MzZQTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDExLjA4LjIwIDExOjQ0LCBSb2dlciBQYXUgTW9ubmUgd3JvdGU6DQo+
ID4gVGhpcyBpcyBpbiBwcmVwYXJhdGlvbiBmb3IgdGhlIGxvZ2ljIGJlaGluZCBNRU1PUllfREVW
SUNFX0RFVkRBWCBhbHNvDQo+ID4gYmVpbmcgdXNlZCBieSBub24gREFYIGRldmljZXMuDQo+ID4g
DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQo+ID4gLS0tDQo+
ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+IENjOiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCj4gPiBDYzogRGF2ZSBKaWFu
ZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGlu
dXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNh
Pg0KPiA+IENjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4gQ2M6ICJBbmVl
c2ggS3VtYXIgSy5WIiA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+DQo+ID4gQ2M6IEpvaGFu
bmVzIFRodW1zaGlybiA8anRodW1zaGlybkBzdXNlLmRlPg0KPiA+IENjOiBMb2dhbiBHdW50aG9y
cGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+ID4gQ2M6IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcNCj4gPiBDYzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qub3JnDQo+ID4gQ2M6IGxpbnV4
LW1tQGt2YWNrLm9yZw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2RheC9kZXZpY2UuYyAgICAgfCAy
ICstDQo+ID4gIGluY2x1ZGUvbGludXgvbWVtcmVtYXAuaCB8IDkgKysrKy0tLS0tDQo+ID4gIG1t
L21lbXJlbWFwLmMgICAgICAgICAgICB8IDIgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZGF4L2RldmljZS5jIGIvZHJpdmVycy9kYXgvZGV2aWNlLmMNCj4gPiBpbmRleCA0YzBhZjJl
YjdlMTkuLjFlODk1MTNmM2M1OSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2RheC9kZXZpY2Uu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZGF4L2RldmljZS5jDQo+ID4gQEAgLTQyOSw3ICs0MjksNyBA
QCBpbnQgZGV2X2RheF9wcm9iZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAkJcmV0dXJuIC1F
QlVTWTsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZ
X0RFVklDRV9ERVZEQVg7DQo+ID4gKwlkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklD
RV9HRU5FUklDOw0KPiA+ICAJYWRkciA9IGRldm1fbWVtcmVtYXBfcGFnZXMoZGV2LCAmZGV2X2Rh
eC0+cGdtYXApOw0KPiA+ICAJaWYgKElTX0VSUihhZGRyKSkNCj4gPiAgCQlyZXR1cm4gUFRSX0VS
UihhZGRyKTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oIGIvaW5j
bHVkZS9saW51eC9tZW1yZW1hcC5oDQo+ID4gaW5kZXggNWY1YjJkZjA2ZTYxLi5lNTg2Mjc0Njc1
MWIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tZW1yZW1hcC5oDQo+ID4gKysrIGIv
aW5jbHVkZS9saW51eC9tZW1yZW1hcC5oDQo+ID4gQEAgLTQ2LDExICs0NiwxMCBAQCBzdHJ1Y3Qg
dm1lbV9hbHRtYXAgew0KPiA+ICAgKiB3YWtldXAgaXMgdXNlZCB0byBjb29yZGluYXRlIHBoeXNp
Y2FsIGFkZHJlc3Mgc3BhY2UgbWFuYWdlbWVudCAoZXg6DQo+ID4gICAqIGZzIHRydW5jYXRlL2hv
bGUgcHVuY2gpIHZzIHBpbm5lZCBwYWdlcyAoZXg6IGRldmljZSBkbWEpLg0KPiA+ICAgKg0KPiA+
IC0gKiBNRU1PUllfREVWSUNFX0RFVkRBWDoNCj4gPiArICogTUVNT1JZX0RFVklDRV9HRU5FUklD
Og0KPiA+ICAgKiBIb3N0IG1lbW9yeSB0aGF0IGhhcyBzaW1pbGFyIGFjY2VzcyBzZW1hbnRpY3Mg
YXMgU3lzdGVtIFJBTSBpLmUuIERNQQ0KPiA+IC0gKiBjb2hlcmVudCBhbmQgc3VwcG9ydHMgcGFn
ZSBwaW5uaW5nLiBJbiBjb250cmFzdCB0bw0KPiA+IC0gKiBNRU1PUllfREVWSUNFX0ZTX0RBWCwg
dGhpcyBtZW1vcnkgaXMgYWNjZXNzIHZpYSBhIGRldmljZS1kYXgNCj4gPiAtICogY2hhcmFjdGVy
IGRldmljZS4NCj4gPiArICogY29oZXJlbnQgYW5kIHN1cHBvcnRzIHBhZ2UgcGlubmluZy4gVGhp
cyBpcyBmb3IgZXhhbXBsZSB1c2VkIGJ5IERBWCBkZXZpY2VzDQo+ID4gKyAqIHRoYXQgZXhwb3Nl
IG1lbW9yeSB1c2luZyBhIGNoYXJhY3RlciBkZXZpY2UuDQo+ID4gICAqDQo+ID4gICAqIE1FTU9S
WV9ERVZJQ0VfUENJX1AyUERNQToNCj4gPiAgICogRGV2aWNlIG1lbW9yeSByZXNpZGluZyBpbiBh
IFBDSSBCQVIgaW50ZW5kZWQgZm9yIHVzZSB3aXRoIFBlZXItdG8tUGVlcg0KPiA+IEBAIC02MCw3
ICs1OSw3IEBAIGVudW0gbWVtb3J5X3R5cGUgew0KPiA+ICAJLyogMCBpcyByZXNlcnZlZCB0byBj
YXRjaCB1bmluaXRpYWxpemVkIHR5cGUgZmllbGRzICovDQo+ID4gIAlNRU1PUllfREVWSUNFX1BS
SVZBVEUgPSAxLA0KPiA+ICAJTUVNT1JZX0RFVklDRV9GU19EQVgsDQo+ID4gLQlNRU1PUllfREVW
SUNFX0RFVkRBWCwNCj4gPiArCU1FTU9SWV9ERVZJQ0VfR0VORVJJQywNCj4gPiAgCU1FTU9SWV9E
RVZJQ0VfUENJX1AyUERNQSwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL21tL21l
bXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jDQo+ID4gaW5kZXggMDNlMzhiN2EzOGYxLi4wMDZkYWNl
NjBiMWEgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtcmVtYXAuYw0KPiA+ICsrKyBiL21tL21lbXJl
bWFwLmMNCj4gPiBAQCAtMjE2LDcgKzIxNiw3IEBAIHZvaWQgKm1lbXJlbWFwX3BhZ2VzKHN0cnVj
dCBkZXZfcGFnZW1hcCAqcGdtYXAsIGludCBuaWQpDQo+ID4gIAkJCXJldHVybiBFUlJfUFRSKC1F
SU5WQUwpOw0KPiA+ICAJCX0NCj4gPiAgCQlicmVhazsNCj4gPiAtCWNhc2UgTUVNT1JZX0RFVklD
RV9ERVZEQVg6DQo+ID4gKwljYXNlIE1FTU9SWV9ERVZJQ0VfR0VORVJJQzoNCj4gPiAgCQluZWVk
X2Rldm1hcF9tYW5hZ2VkID0gZmFsc2U7DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAljYXNlIE1FTU9S
WV9ERVZJQ0VfUENJX1AyUERNQToNCj4gPiANCj4gDQo+IE5vIHN0cm9uZyBvcGluaW9uIChARGFu
PyksIEkgZG8gd29uZGVyIGlmIGEgc2VwYXJhdGUgdHlwZSB3b3VsZCBtYWtlIHNlbnNlLg0KDQpH
ZW50bGUgcGluZy4NCg0KVGhhbmtzLCBSb2dlci4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
