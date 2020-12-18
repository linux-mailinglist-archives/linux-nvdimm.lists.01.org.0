Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1316B2DDCEF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:33:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56BDC100EB324;
	Thu, 17 Dec 2020 18:33:56 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id B3BF3100EB322
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:33:52 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400";
   d="scan'208";a="102693910"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 10:33:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id ED9DA4CE601B;
	Fri, 18 Dec 2020 10:33:47 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 10:33:47 +0800
Subject: Re: [RFC PATCH v3 9/9] xfs: Implement ->corrupted_range() for XFS
To: "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <20201215121414.253660-10-ruansy.fnst@cn.fujitsu.com>
 <20201215204032.GA6918@magnolia>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <c216d87b-c1ab-48f5-e247-edbf943455c0@cn.fujitsu.com>
Date: Fri, 18 Dec 2020 10:31:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215204032.GA6918@magnolia>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: ED9DA4CE601B.A0131
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: XPMZXFPMCKAG4X72HQS5IGPIUUYJLHY3
X-Message-ID-Hash: XPMZXFPMCKAG4X72HQS5IGPIUUYJLHY3
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XPMZXFPMCKAG4X72HQS5IGPIUUYJLHY3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTYg5LiK5Y2INDo0MCwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBP
biBUdWUsIERlYyAxNSwgMjAyMCBhdCAwODoxNDoxNFBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3Jv
dGU6DQo+PiBUaGlzIGZ1bmN0aW9uIGlzIHVzZWQgdG8gaGFuZGxlIGVycm9ycyB3aGljaCBtYXkg
Y2F1c2UgZGF0YSBsb3N0IGluDQo+PiBmaWxlc3lzdGVtLiAgU3VjaCBhcyBtZW1vcnkgZmFpbHVy
ZSBpbiBmc2RheCBtb2RlLg0KPj4NCj4+IEluIFhGUywgaXQgcmVxdWlyZXMgInJtYXBidCIgZmVh
dHVyZSBpbiBvcmRlciB0byBxdWVyeSBmb3IgZmlsZXMgb3INCj4+IG1ldGFkYXRhIHdoaWNoIGFz
c29jaWF0ZWQgdG8gdGhlIGNvcnJ1cHRlZCBkYXRhLiAgVGhlbiB3ZSBjb3VsZCBjYWxsIGZzDQo+
PiByZWNvdmVyIGZ1bmN0aW9ucyB0byB0cnkgdG8gcmVwYWlyIHRoZSBjb3JydXB0ZWQgZGF0YS4o
ZGlkIG5vdA0KPj4gaW1wbGVtZW50ZWQgaW4gdGhpcyBwYXRjaHNldCkNCj4+DQo+PiBBZnRlciB0
aGF0LCB0aGUgbWVtb3J5IGZhaWx1cmUgYWxzbyBuZWVkcyB0byBub3RpZnkgdGhlIHByb2Nlc3Nl
cyB3aG8NCj4+IGFyZSB1c2luZyB0aG9zZSBmaWxlcy4NCj4+DQo+PiBPbmx5IHN1cHBvcnQgZGF0
YSBkZXZpY2UuICBSZWFsdGltZSBkZXZpY2UgaXMgbm90IHN1cHBvcnRlZCBmb3Igbm93Lg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAY24uZnVqaXRzdS5j
b20+DQo+PiAtLS0NCj4+ICAgZnMveGZzL3hmc19mc29wcy5jIHwgMTAgKysrKysNCj4+ICAgZnMv
eGZzL3hmc19tb3VudC5oIHwgIDIgKw0KPj4gICBmcy94ZnMveGZzX3N1cGVyLmMgfCA5MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMg
Y2hhbmdlZCwgMTA1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMveGZzL3hm
c19mc29wcy5jIGIvZnMveGZzL3hmc19mc29wcy5jDQo+PiBpbmRleCBlZjFkNWJiODhiOTMuLjBl
YzFiNDRiZmU4OCAxMDA2NDQNCj4+IC0tLSBhL2ZzL3hmcy94ZnNfZnNvcHMuYw0KPj4gKysrIGIv
ZnMveGZzL3hmc19mc29wcy5jDQo+PiBAQCAtNTAxLDYgKzUwMSwxNiBAQCB4ZnNfZG9fZm9yY2Vf
c2h1dGRvd24oDQo+PiAgICJDb3JydXB0aW9uIG9mIGluLW1lbW9yeSBkYXRhIGRldGVjdGVkLiAg
U2h1dHRpbmcgZG93biBmaWxlc3lzdGVtIik7DQo+PiAgIAkJaWYgKFhGU19FUlJMRVZFTF9ISUdI
IDw9IHhmc19lcnJvcl9sZXZlbCkNCj4+ICAgCQkJeGZzX3N0YWNrX3RyYWNlKCk7DQo+PiArCX0g
ZWxzZSBpZiAoZmxhZ3MgJiBTSFVURE9XTl9DT1JSVVBUX01FVEEpIHsNCj4+ICsJCXhmc19hbGVy
dF90YWcobXAsIFhGU19QVEFHX1NIVVRET1dOX0NPUlJVUFQsDQo+PiArIkNvcnJ1cHRpb24gb2Yg
b24tZGlzayBtZXRhZGF0YSBkZXRlY3RlZC4gIFNodXR0aW5nIGRvd24gZmlsZXN5c3RlbSIpOw0K
Pj4gKwkJaWYgKFhGU19FUlJMRVZFTF9ISUdIIDw9IHhmc19lcnJvcl9sZXZlbCkNCj4+ICsJCQl4
ZnNfc3RhY2tfdHJhY2UoKTsNCj4+ICsJfSBlbHNlIGlmIChmbGFncyAmIFNIVVRET1dOX0NPUlJV
UFRfREFUQSkgew0KPj4gKwkJeGZzX2FsZXJ0X3RhZyhtcCwgWEZTX1BUQUdfU0hVVERPV05fQ09S
UlVQVCwNCj4+ICsiQ29ycnVwdGlvbiBvZiBvbi1kaXNrIGZpbGUgZGF0YSBkZXRlY3RlZC4gIFNo
dXR0aW5nIGRvd24gZmlsZXN5c3RlbSIpOw0KPj4gKwkJaWYgKFhGU19FUlJMRVZFTF9ISUdIIDw9
IHhmc19lcnJvcl9sZXZlbCkNCj4+ICsJCQl4ZnNfc3RhY2tfdHJhY2UoKTsNCj4+ICAgCX0gZWxz
ZSBpZiAobG9nZXJyb3IpIHsNCj4+ICAgCQl4ZnNfYWxlcnRfdGFnKG1wLCBYRlNfUFRBR19TSFVU
RE9XTl9MT0dFUlJPUiwNCj4+ICAgCQkJIkxvZyBJL08gRXJyb3IgRGV0ZWN0ZWQuIFNodXR0aW5n
IGRvd24gZmlsZXN5c3RlbSIpOw0KPj4gZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfbW91bnQuaCBi
L2ZzL3hmcy94ZnNfbW91bnQuaA0KPj4gaW5kZXggZGZhNDI5Yjc3ZWUyLi5lMzZjMDc1NTM0ODYg
MTAwNjQ0DQo+PiAtLS0gYS9mcy94ZnMveGZzX21vdW50LmgNCj4+ICsrKyBiL2ZzL3hmcy94ZnNf
bW91bnQuaA0KPj4gQEAgLTI3NCw2ICsyNzQsOCBAQCB2b2lkIHhmc19kb19mb3JjZV9zaHV0ZG93
bihzdHJ1Y3QgeGZzX21vdW50ICptcCwgaW50IGZsYWdzLCBjaGFyICpmbmFtZSwNCj4+ICAgI2Rl
ZmluZSBTSFVURE9XTl9MT0dfSU9fRVJST1IJMHgwMDAyCS8qIHdyaXRlIGF0dGVtcHQgdG8gdGhl
IGxvZyBmYWlsZWQgKi8NCj4+ICAgI2RlZmluZSBTSFVURE9XTl9GT1JDRV9VTU9VTlQJMHgwMDA0
CS8qIHNodXRkb3duIGZyb20gYSBmb3JjZWQgdW5tb3VudCAqLw0KPj4gICAjZGVmaW5lIFNIVVRE
T1dOX0NPUlJVUFRfSU5DT1JFCTB4MDAwOAkvKiBjb3JydXB0IGluLW1lbW9yeSBkYXRhIHN0cnVj
dHVyZXMgKi8NCj4+ICsjZGVmaW5lIFNIVVRET1dOX0NPUlJVUFRfTUVUQQkweDAwMTAgIC8qIGNv
cnJ1cHQgbWV0YWRhdGEgb24gZGV2aWNlICovDQo+PiArI2RlZmluZSBTSFVURE9XTl9DT1JSVVBU
X0RBVEEJMHgwMDIwICAvKiBjb3JydXB0IGZpbGUgZGF0YSBvbiBkZXZpY2UgKi8NCj4gDQo+IFRo
aXMgc3ltYm9sIGlzbid0IHVzZWQgYW55d2hlcmUuICBJIGRvbid0IGtub3cgd2h5IHdlJ2Qgc2h1
dCBkb3duIHRoZSBmcw0KPiBmb3IgZGF0YSBsb3NzLCBhcyB3ZSBkb24ndCBkbyB0aGF0IGFueXdo
ZXJlIGVsc2UgaW4geGZzLg0KDQpJIHByZXBhcmVkIHRoaXMgZmxhZyBmb3IgdGhlIGxhdGVyIHVz
ZSBpZiBwb3NzaWJsZS4gIEJ1dCBzaW5jZSBpdCBzZWVtcyANCnVubmVjZXNzYXJ5LCBJIHdpbGwg
cmVtb3ZlIGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gDQo+PiAgIA0KPj4gICAvKg0KPj4g
ICAgKiBGbGFncyBmb3IgeGZzX21vdW50ZnMNCj4+IGRpZmYgLS1naXQgYS9mcy94ZnMveGZzX3N1
cGVyLmMgYi9mcy94ZnMveGZzX3N1cGVyLmMNCj4+IGluZGV4IGUzZTIyOWU1MjUxMi4uMzAyMDJk
ZTdlODlkIDEwMDY0NA0KPj4gLS0tIGEvZnMveGZzL3hmc19zdXBlci5jDQo+PiArKysgYi9mcy94
ZnMveGZzX3N1cGVyLmMNCj4+IEBAIC0zNSw2ICszNSwxMSBAQA0KPj4gICAjaW5jbHVkZSAieGZz
X3JlZmNvdW50X2l0ZW0uaCINCj4+ICAgI2luY2x1ZGUgInhmc19ibWFwX2l0ZW0uaCINCj4+ICAg
I2luY2x1ZGUgInhmc19yZWZsaW5rLmgiDQo+PiArI2luY2x1ZGUgInhmc19hbGxvYy5oIg0KPj4g
KyNpbmNsdWRlICJ4ZnNfcm1hcC5oIg0KPj4gKyNpbmNsdWRlICJ4ZnNfcm1hcF9idHJlZS5oIg0K
Pj4gKyNpbmNsdWRlICJ4ZnNfcnRhbGxvYy5oIg0KPj4gKyNpbmNsdWRlICJ4ZnNfYml0LmgiDQo+
PiAgIA0KPj4gICAjaW5jbHVkZSA8bGludXgvbWFnaWMuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4
L2ZzX2NvbnRleHQuaD4NCj4+IEBAIC0xMTAzLDYgKzExMDgsOTMgQEAgeGZzX2ZzX2ZyZWVfY2Fj
aGVkX29iamVjdHMoDQo+PiAgIAlyZXR1cm4geGZzX3JlY2xhaW1faW5vZGVzX25yKFhGU19NKHNi
KSwgc2MtPm5yX3RvX3NjYW4pOw0KPj4gICB9DQo+PiAgIA0KPj4gK3N0YXRpYyBpbnQNCj4+ICt4
ZnNfY29ycnVwdF9oZWxwZXIoDQo+PiArCXN0cnVjdCB4ZnNfYnRyZWVfY3VyCQkqY3VyLA0KPj4g
KwlzdHJ1Y3QgeGZzX3JtYXBfaXJlYwkJKnJlYywNCj4+ICsJdm9pZAkJCQkqZGF0YSkNCj4+ICt7
DQo+PiArCXN0cnVjdCB4ZnNfaW5vZGUJCSppcDsNCj4+ICsJaW50CQkJCXJjID0gMDsNCj4gDQo+
IE5vdGU6IHdlIHVzdWFsbHkgdXNlIHRoZSBuYW1lICJlcnJvciIsIG5vdCAicmMiLg0KDQpPSy4N
Cg0KPiANCj4+ICsJaW50CQkJCSpmbGFncyA9IGRhdGE7DQo+PiArDQo+PiArCWlmIChYRlNfUk1B
UF9OT05fSU5PREVfT1dORVIocmVjLT5ybV9vd25lcikpIHsNCj4gDQo+IFRoZXJlIGFyZSBhIGZl
dyBtb3JlIHRoaW5ncyB0byBjaGVjayBoZXJlIHRvIGRldGVjdCBpZiBtZXRhZGF0YSBoYXMgYmVl
bg0KPiBsb3N0LiAgVGhlIGZpcnN0IGlzIHRoYXQgYW55IGxvc3MgaW4gdGhlIGV4dGVuZGVkIGF0
dHJpYnV0ZSBpbmZvcm1hdGlvbg0KPiBpcyBjb25zaWRlcmVkIGZpbGVzeXN0ZW0gbWV0YWRhdGE7
IGFuZCB0aGUgc2Vjb25kIGlzIHRoYXQgbG9zcyBvZiBhbg0KPiBleHRlbnQgYnRyZWUgYmxvY2sg
aXMgYWxzbyBtZXRhZGF0YS4NCj4gDQo+IElPV3MsIHRoaXMgY2hlY2sgc2hvdWxkIGJlOg0KPiAN
Cj4gCWlmIChYRlNfUk1BUF9OT05fSU5PREVfT1dORVIocmVjLT5ybV9vd25lcikgfHwNCj4gCSAg
ICAocmVjLT5ybV9mbGFncyAmIChYRlNfUk1BUF9BVFRSX0ZPUksgfCBYRlNfUk1BUF9CTUJUX0JM
T0NLKSkpIHsNCj4gCQkvLyBUT0RPIGNoZWNrIGFuZCB0cnkgdG8gZml4IG1ldGFkYXRhDQo+IAkJ
cmV0dXJuIC1FRlNDT1JSVVBURUQ7DQo+IAl9DQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0Lg0K
DQo+IA0KPj4gKwkJLy8gVE9ETyBjaGVjayBhbmQgdHJ5IHRvIGZpeCBtZXRhZGF0YQ0KPj4gKwkJ
cmMgPSAtRUZTQ09SUlVQVEVEOw0KPj4gKwl9IGVsc2Ugew0KPj4gKwkJLyoNCj4+ICsJCSAqIEdl
dCBmaWxlcyB0aGF0IGluY29yZSwgZmlsdGVyIG91dCBvdGhlcnMgdGhhdCBhcmUgbm90IGluIHVz
ZS4NCj4+ICsJCSAqLw0KPj4gKwkJcmMgPSB4ZnNfaWdldChjdXItPmJjX21wLCBjdXItPmJjX3Rw
LCByZWMtPnJtX293bmVyLA0KPj4gKwkJCSAgICAgIFhGU19JR0VUX0lOQ09SRSwgMCwgJmlwKTsN
Cj4+ICsJCWlmIChyYyB8fCAhaXApDQo+PiArCQkJcmV0dXJuIHJjOw0KPj4gKwkJaWYgKCFWRlNf
SShpcCktPmlfbWFwcGluZykNCj4+ICsJCQlnb3RvIG91dDsNCj4+ICsNCj4+ICsJCWlmIChJU19E
QVgoVkZTX0koaXApKSkNCj4+ICsJCQlyYyA9IG1mX2RheF9tYXBwaW5nX2tpbGxfcHJvY3MoVkZT
X0koaXApLT5pX21hcHBpbmcsDQo+PiArCQkJCQkJICAgICAgIHJlYy0+cm1fb2Zmc2V0LCAqZmxh
Z3MpOw0KPiANCj4gSWYgdGhlIGZpbGUgaXNuJ3QgU19EQVgsIHNob3VsZCB3ZSBjYWxsIG1hcHBp
bmdfc2V0X2Vycm9yIGhlcmUgc28NCj4gdGhhdCB0aGUgbmV4dCBmc3luYygpIHdpbGwgYWxzbyBy
ZXR1cm4gRUlPPw0KDQpOaWNlIGlkZWEuICBJIHdpbGwgdHJ5Lg0KDQo+IA0KPj4gKw0KPj4gKwkJ
Ly8gVE9ETyB0cnkgdG8gZml4IGRhdGENCj4+ICtvdXQ6DQo+PiArCQl4ZnNfaXJlbGUoaXApOw0K
Pj4gKwl9DQo+PiArDQo+PiArCXJldHVybiByYzsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIGlu
dA0KPj4gK3hmc19mc19jb3JydXB0ZWRfcmFuZ2UoDQo+PiArCXN0cnVjdCBzdXBlcl9ibG9jawkq
c2IsDQo+PiArCXN0cnVjdCBibG9ja19kZXZpY2UJKmJkZXYsDQo+PiArCWxvZmZfdAkJCW9mZnNl
dCwNCj4+ICsJc2l6ZV90CQkJbGVuLA0KPj4gKwl2b2lkCQkJKmRhdGEpDQo+PiArew0KPj4gKwlz
dHJ1Y3QgeGZzX21vdW50CSptcCA9IFhGU19NKHNiKTsNCj4+ICsJc3RydWN0IHhmc190cmFucwkq
dHAgPSBOVUxMOw0KPj4gKwlzdHJ1Y3QgeGZzX2J0cmVlX2N1cgkqY3VyID0gTlVMTDsNCj4+ICsJ
c3RydWN0IHhmc19ybWFwX2lyZWMJcm1hcF9sb3csIHJtYXBfaGlnaDsNCj4+ICsJc3RydWN0IHhm
c19idWYJCSphZ2ZfYnAgPSBOVUxMOw0KPj4gKwl4ZnNfZnNibG9ja190CQlmc2JubyA9IFhGU19C
X1RPX0ZTQihtcCwgb2Zmc2V0KTsNCj4+ICsJeGZzX2ZpbGJsa3NfdAkJYmMgPSBYRlNfQl9UT19G
U0IobXAsIGxlbik7DQo+PiArCXhmc19hZ251bWJlcl90CQlhZ25vID0gWEZTX0ZTQl9UT19BR05P
KG1wLCBmc2Jubyk7DQo+PiArCXhmc19hZ2Jsb2NrX3QJCWFnYm5vID0gWEZTX0ZTQl9UT19BR0JO
TyhtcCwgZnNibm8pOw0KPj4gKwlpbnQJCQlyYyA9IDA7DQo+PiArDQo+PiArCWlmIChtcC0+bV9y
dGRldl90YXJncCAmJiBtcC0+bV9ydGRldl90YXJncC0+YnRfYmRldiA9PSBiZGV2KSB7DQo+PiAr
CQl4ZnNfd2FybihtcCwgInN0b3JhZ2UgbG9zdCBzdXBwb3J0IG5vdCBhdmFpbGFibGUgZm9yIHJl
YWx0aW1lIGRldmljZSEiKTsNCj4+ICsJCXJldHVybiAwOw0KPj4gKwl9DQo+IA0KPiBUaGlzIG91
Z2h0IHRvIGtpbGwgdGhlIGZzIHdoZW4gYW4gZXh0ZXJuYWwgbG9nIGRldmljZSBpcyBjb25maWd1
cmVkOg0KPiANCj4gCWlmIChtcC0+bV9sb2dkZXZfdGFyZ3AgJiYNCj4gCSAgICBtcC0+bV9sb2dk
ZXZfdGFyZ3AgIT0gbXAtPm1fZGRldl90YXJncCAmJg0KPiAJICAgIG1wLT5tX2xvZ2Rldl90YXJn
cC0+YnRfYmRldiA9PSBiZGV2KSB7DQo+IAkJeGZzX2Vycm9yKG1wLCAib25kaXNrIGxvZyBjb3Jy
dXB0LCBzaHV0dGluZyBkb3duIGZzISIpOw0KPiAJCXhmc19mb3JjZV9zaHV0ZG93bihtcCwgU0hV
VERPV05fQ09SUlVQVF9NRVRBKTsNCj4gCQlyZXR1cm4gMDsNCj4gCX0NCj4gDQo+IFRoZW4sIHdl
IG5lZWQgdG8gY2hlY2sgZXhwbGljaXRseSBmb3Igcm1hcCBzdXBwb3J0Og0KPiANCj4gCWlmICgh
eGZzX3NiX3ZlcnNpb25faGFzcm1hcGJ0KCZtcC0+bV9zYikpDQo+IAkJcmV0dXJuIDA7DQo+IA0K
PiBzbyB0aGF0IHdlIHNjcmVlbiBvdXQgZmlsZXN5c3RlbXMgdGhhdCBkb24ndCBoYXZlIHJtYXAg
ZW5hYmxlZC4NCg0KQWguLi4gIEkgd2FzIHRvbyBuZWdsaWdlbnQgdG8gdGhpbmsgb2YgdGhpcy4g
IFRoYXQncyB2ZXJ5IHRob3VnaHRmdWwgb2YgDQp5b3UuICBUaGFua3MuDQoNCj4gDQo+PiArCXJj
ID0geGZzX3RyYW5zX2FsbG9jX2VtcHR5KG1wLCAmdHApOw0KPj4gKwlpZiAocmMpDQo+PiArCQly
ZXR1cm4gcmM7DQo+PiArDQo+PiArCXJjID0geGZzX2FsbG9jX3JlYWRfYWdmKG1wLCB0cCwgYWdu
bywgMCwgJmFnZl9icCk7DQo+PiArCWlmIChyYykNCj4+ICsJCXJldHVybiByYzsNCj4+ICsNCj4+
ICsJY3VyID0geGZzX3JtYXBidF9pbml0X2N1cnNvcihtcCwgdHAsIGFnZl9icCwgYWdubyk7DQo+
PiArDQo+PiArCS8qIENvbnN0cnVjdCBhIHJhbmdlIGZvciBybWFwIHF1ZXJ5ICovDQo+PiArCW1l
bXNldCgmcm1hcF9sb3csIDAsIHNpemVvZihybWFwX2xvdykpOw0KPj4gKwltZW1zZXQoJnJtYXBf
aGlnaCwgMHhGRiwgc2l6ZW9mKHJtYXBfaGlnaCkpOw0KPj4gKwlybWFwX2xvdy5ybV9zdGFydGJs
b2NrID0gcm1hcF9oaWdoLnJtX3N0YXJ0YmxvY2sgPSBhZ2JubzsNCj4+ICsJcm1hcF9sb3cucm1f
YmxvY2tjb3VudCA9IHJtYXBfaGlnaC5ybV9ibG9ja2NvdW50ID0gYmM7DQo+PiArDQo+PiArCXJj
ID0geGZzX3JtYXBfcXVlcnlfcmFuZ2UoY3VyLCAmcm1hcF9sb3csICZybWFwX2hpZ2gsIHhmc19j
b3JydXB0X2hlbHBlciwgZGF0YSk7DQo+PiArCWlmIChyYyA9PSAtRUNBTkNFTEVEKQ0KPj4gKwkJ
cmMgPSAwOw0KPiANCj4gSSBkb24ndCB0aGluayBhbnl0aGluZyByZXR1cm5zIEVDQU5DRUxFRCBo
ZXJlLi4uDQoNClllcy4gIFdpbGwgcmVtb3ZlIGl0Lg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNo
aXlhbmcuDQo+IA0KPiAtLUQNCj4gDQo+PiArCWlmIChyYyA9PSAtRUZTQ09SUlVQVEVEKQ0KPj4g
KwkJeGZzX2ZvcmNlX3NodXRkb3duKG1wLCBTSFVURE9XTl9DT1JSVVBUX01FVEEpOw0KPj4gKw0K
Pj4gKwl4ZnNfYnRyZWVfZGVsX2N1cnNvcihjdXIsIHJjKTsNCj4+ICsJeGZzX3RyYW5zX2JyZWxz
ZSh0cCwgYWdmX2JwKTsNCj4+ICsJcmV0dXJuIHJjOw0KPj4gK30NCj4+ICsNCj4+ICAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBzdXBlcl9vcGVyYXRpb25zIHhmc19zdXBlcl9vcGVyYXRpb25zID0gew0K
Pj4gICAJLmFsbG9jX2lub2RlCQk9IHhmc19mc19hbGxvY19pbm9kZSwNCj4+ICAgCS5kZXN0cm95
X2lub2RlCQk9IHhmc19mc19kZXN0cm95X2lub2RlLA0KPj4gQEAgLTExMTYsNiArMTIwOCw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3VwZXJfb3BlcmF0aW9ucyB4ZnNfc3VwZXJfb3BlcmF0aW9u
cyA9IHsNCj4+ICAgCS5zaG93X29wdGlvbnMJCT0geGZzX2ZzX3Nob3dfb3B0aW9ucywNCj4+ICAg
CS5ucl9jYWNoZWRfb2JqZWN0cwk9IHhmc19mc19ucl9jYWNoZWRfb2JqZWN0cywNCj4+ICAgCS5m
cmVlX2NhY2hlZF9vYmplY3RzCT0geGZzX2ZzX2ZyZWVfY2FjaGVkX29iamVjdHMsDQo+PiArCS5j
b3JydXB0ZWRfcmFuZ2UJPSB4ZnNfZnNfY29ycnVwdGVkX3JhbmdlLA0KPj4gICB9Ow0KPj4gICAN
Cj4+ICAgc3RhdGljIGludA0KPj4gLS0gDQo+PiAyLjI5LjINCj4+DQo+Pg0KPj4NCj4gDQo+IA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
