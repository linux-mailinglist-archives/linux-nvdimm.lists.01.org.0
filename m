Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E55331D424
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 04:07:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C51BA100F2274;
	Tue, 16 Feb 2021 19:07:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 118E0100F2271
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:07:11 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800";
   d="scan'208";a="104561806"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Feb 2021 11:07:08 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 8C4954CE6F9B;
	Wed, 17 Feb 2021 11:07:02 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 17 Feb
 2021 11:06:55 +0800
Subject: Re: [PATCH 4/7] fsdax: Replace mmap entry in case of CoW
To: <dsterba@suse.cz>, <linux-kernel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-fsdevel@vger.kernel.org>, <darrick.wong@oracle.com>,
	<dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
	<viro@zeniv.linux.org.uk>, <linux-btrfs@vger.kernel.org>,
	<ocfs2-devel@oss.oracle.com>, <david@fromorbit.com>, <hch@lst.de>,
	<rgoldwyn@suse.de>, Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-5-ruansy.fnst@cn.fujitsu.com>
 <20210216131154.GN1993@twin.jikos.cz>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <4e9a79ed-aa99-c57b-6098-f55ef28cc535@cn.fujitsu.com>
Date: Wed, 17 Feb 2021 11:06:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210216131154.GN1993@twin.jikos.cz>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 8C4954CE6F9B.AD540
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: OE66F4YKCY4GDSQM3SCXSFYUWKKQLZGS
X-Message-ID-Hash: OE66F4YKCY4GDSQM3SCXSFYUWKKQLZGS
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OE66F4YKCY4GDSQM3SCXSFYUWKKQLZGS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi8xNiDkuIvljYg5OjExLCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+IE9uIE1v
biwgRmViIDA4LCAyMDIxIGF0IDAxOjA5OjIxQU0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90ZToN
Cj4+IFdlIHJlcGxhY2UgdGhlIGV4aXN0aW5nIGVudHJ5IHRvIHRoZSBuZXdseSBhbGxvY2F0ZWQg
b25lDQo+PiBpbiBjYXNlIG9mIENvVy4gQWxzbywgd2UgbWFyayB0aGUgZW50cnkgYXMgUEFHRUNB
Q0hFX1RBR19UT1dSSVRFDQo+PiBzbyB3cml0ZWJhY2sgbWFya3MgdGhpcyBlbnRyeSBhcyB3cml0
ZXByb3RlY3RlZC4gVGhpcw0KPj4gaGVscHMgdXMgc25hcHNob3RzIHNvIG5ldyB3cml0ZSBwYWdl
ZmF1bHRzIGFmdGVyIHNuYXBzaG90cw0KPj4gdHJpZ2dlciBhIENvVy4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBHb2xkd3luIFJvZHJpZ3VlcyA8cmdvbGR3eW5Ac3VzZS5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGNuLmZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+PiAgIGZzL2RheC5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZnMvZGF4LmMgYi9mcy9kYXguYw0KPj4gaW5kZXggYjIxOTVjYmRmMmRj
Li4yOTY5OGEzZDJlMzcgMTAwNjQ0DQo+PiAtLS0gYS9mcy9kYXguYw0KPj4gKysrIGIvZnMvZGF4
LmMNCj4+IEBAIC03MjIsNiArNzIyLDkgQEAgc3RhdGljIGludCBjb3B5X2Nvd19wYWdlX2RheChz
dHJ1Y3QgYmxvY2tfZGV2aWNlICpiZGV2LCBzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2QNCj4+ICAg
CXJldHVybiAwOw0KPj4gICB9DQo+PiAgIA0KPj4gKyNkZWZpbmUgREFYX0lGX0RJUlRZCQkoMVVM
TCA8PCAwKQ0KPj4gKyNkZWZpbmUgREFYX0lGX0NPVwkJKDFVTEwgPDwgMSkNCj4gDQo+IFRoZSBj
b25zdGFudHMgYXJlIFVMTCwgYnV0IEkgc2VlIG90aGVyIGZsYWdzIG9ubHkgJ3Vuc2lnbmVkIGxv
bmcnDQo+IA0KPj4gKw0KPj4gICAvKg0KPj4gICAgKiBCeSB0aGlzIHBvaW50IGdyYWJfbWFwcGlu
Z19lbnRyeSgpIGhhcyBlbnN1cmVkIHRoYXQgd2UgaGF2ZSBhIGxvY2tlZCBlbnRyeQ0KPj4gICAg
KiBvZiB0aGUgYXBwcm9wcmlhdGUgc2l6ZSBzbyB3ZSBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0
IGRvd25ncmFkaW5nIFBNRHMgdG8NCj4+IEBAIC03MzEsMTQgKzczNCwxNiBAQCBzdGF0aWMgaW50
IGNvcHlfY293X3BhZ2VfZGF4KHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIHN0cnVjdCBkYXhf
ZGV2aWNlICpkYXhfZA0KPj4gICAgKi8NCj4+ICAgc3RhdGljIHZvaWQgKmRheF9pbnNlcnRfZW50
cnkoc3RydWN0IHhhX3N0YXRlICp4YXMsDQo+PiAgIAkJc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1h
cHBpbmcsIHN0cnVjdCB2bV9mYXVsdCAqdm1mLA0KPj4gLQkJdm9pZCAqZW50cnksIHBmbl90IHBm
biwgdW5zaWduZWQgbG9uZyBmbGFncywgYm9vbCBkaXJ0eSkNCj4+ICsJCXZvaWQgKmVudHJ5LCBw
Zm5fdCBwZm4sIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIGJvb2wgaW5zZXJ0X2ZsYWdzKQ0KPiANCj4g
aW5zZXJ0X2ZsYWdzIGlzIGJvb2wNCj4gDQo+PiAgIHsNCj4+ICAgCXZvaWQgKm5ld19lbnRyeSA9
IGRheF9tYWtlX2VudHJ5KHBmbiwgZmxhZ3MpOw0KPj4gKwlib29sIGRpcnR5ID0gaW5zZXJ0X2Zs
YWdzICYgREFYX0lGX0RJUlRZOw0KPiANCj4gImluc2VydF9mbGFncyAmIERBWF9JRl9ESVJUWSIg
aXMgImJvb2wgJiBVTEwiLCB0aGlzIGNhbid0IGJlIHJpZ2h0DQoNClRoaXMgaXMgYSBtaXN0YWtl
IGNhdXNlZCBieSByZWJhc2luZyBteSBvbGQgdmVyc2lvbiBwYXRjaHNldC4gIFRoYW5rcyANCmZv
ciBwb2ludGluZyBvdXQuICBJJ2xsIGZpeCB0aGlzIGluIG5leHQgdmVyc2lvbi4NCj4gDQo+PiAr
CWJvb2wgY293ID0gaW5zZXJ0X2ZsYWdzICYgREFYX0lGX0NPVzsNCj4gDQo+IFNhbWUNCj4gDQo+
PiAgIA0KPj4gICAJaWYgKGRpcnR5KQ0KPj4gICAJCV9fbWFya19pbm9kZV9kaXJ0eShtYXBwaW5n
LT5ob3N0LCBJX0RJUlRZX1BBR0VTKTsNCj4+ICAgDQo+PiAtCWlmIChkYXhfaXNfemVyb19lbnRy
eShlbnRyeSkgJiYgIShmbGFncyAmIERBWF9aRVJPX1BBR0UpKSB7DQo+PiArCWlmIChjb3cgfHwg
KGRheF9pc196ZXJvX2VudHJ5KGVudHJ5KSAmJiAhKGZsYWdzICYgREFYX1pFUk9fUEFHRSkpKSB7
DQo+PiAgIAkJdW5zaWduZWQgbG9uZyBpbmRleCA9IHhhcy0+eGFfaW5kZXg7DQo+PiAgIAkJLyog
d2UgYXJlIHJlcGxhY2luZyBhIHplcm8gcGFnZSB3aXRoIGJsb2NrIG1hcHBpbmcgKi8NCj4+ICAg
CQlpZiAoZGF4X2lzX3BtZF9lbnRyeShlbnRyeSkpDQo+PiBAQCAtNzUwLDcgKzc1NSw3IEBAIHN0
YXRpYyB2b2lkICpkYXhfaW5zZXJ0X2VudHJ5KHN0cnVjdCB4YV9zdGF0ZSAqeGFzLA0KPj4gICAN
Cj4+ICAgCXhhc19yZXNldCh4YXMpOw0KPj4gICAJeGFzX2xvY2tfaXJxKHhhcyk7DQo+PiAtCWlm
IChkYXhfaXNfemVyb19lbnRyeShlbnRyeSkgfHwgZGF4X2lzX2VtcHR5X2VudHJ5KGVudHJ5KSkg
ew0KPj4gKwlpZiAoY293IHx8IGRheF9pc196ZXJvX2VudHJ5KGVudHJ5KSB8fCBkYXhfaXNfZW1w
dHlfZW50cnkoZW50cnkpKSB7DQo+PiAgIAkJdm9pZCAqb2xkOw0KPj4gICANCj4+ICAgCQlkYXhf
ZGlzYXNzb2NpYXRlX2VudHJ5KGVudHJ5LCBtYXBwaW5nLCBmYWxzZSk7DQo+PiBAQCAtNzc0LDYg
Kzc3OSw5IEBAIHN0YXRpYyB2b2lkICpkYXhfaW5zZXJ0X2VudHJ5KHN0cnVjdCB4YV9zdGF0ZSAq
eGFzLA0KPj4gICAJaWYgKGRpcnR5KQ0KPj4gICAJCXhhc19zZXRfbWFyayh4YXMsIFBBR0VDQUNI
RV9UQUdfRElSVFkpOw0KPj4gICANCj4+ICsJaWYgKGNvdykNCj4+ICsJCXhhc19zZXRfbWFyayh4
YXMsIFBBR0VDQUNIRV9UQUdfVE9XUklURSk7DQo+PiArDQo+PiAgIAl4YXNfdW5sb2NrX2lycSh4
YXMpOw0KPj4gICAJcmV0dXJuIGVudHJ5Ow0KPj4gICB9DQo+PiBAQCAtMTMxOSw2ICsxMzI3LDcg
QEAgc3RhdGljIHZtX2ZhdWx0X3QgZGF4X2lvbWFwX3B0ZV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQg
KnZtZiwgcGZuX3QgKnBmbnAsDQo+PiAgIAl2b2lkICplbnRyeTsNCj4+ICAgCXBmbl90IHBmbjsN
Cj4+ICAgCXZvaWQgKmthZGRyOw0KPj4gKwl1bnNpZ25lZCBsb25nIGluc2VydF9mbGFncyA9IDA7
DQo+PiAgIA0KPj4gICAJdHJhY2VfZGF4X3B0ZV9mYXVsdChpbm9kZSwgdm1mLCByZXQpOw0KPj4g
ICAJLyoNCj4+IEBAIC0xNDQ0LDggKzE0NTMsMTAgQEAgc3RhdGljIHZtX2ZhdWx0X3QgZGF4X2lv
bWFwX3B0ZV9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcGZuX3QgKnBmbnAsDQo+PiAgIA0K
Pj4gICAJCWdvdG8gZmluaXNoX2lvbWFwOw0KPj4gICAJY2FzZSBJT01BUF9VTldSSVRURU46DQo+
PiAtCQlpZiAod3JpdGUgJiYgaW9tYXAuZmxhZ3MgJiBJT01BUF9GX1NIQVJFRCkNCj4+ICsJCWlm
ICh3cml0ZSAmJiAoaW9tYXAuZmxhZ3MgJiBJT01BUF9GX1NIQVJFRCkpIHsNCj4+ICsJCQlpbnNl
cnRfZmxhZ3MgfD0gREFYX0lGX0NPVzsNCj4gDQo+IEhlcmUncyBhbiBleGFtcGxlIG9mICd1bnNp
Z25lZCBsb25nID0gdW5zaWduZWQgbG9uZyBsb25nJywgdGhvdWdoIGl0J2xsDQo+IHdvcmssIGl0
IHdvdWxkIGJlIGJldHRlciB0byB1bmlmeSBhbGwgdGhlIHR5cGVzLg0KDQpZZXMsIEknbGwgZml4
IGl0Lg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQo+IA0KPj4gICAJCQlnb3RvIGNv
dzsNCj4+ICsJCX0NCj4+ICAgCQlmYWxsdGhyb3VnaDsNCj4+ICAgCWNhc2UgSU9NQVBfSE9MRToN
Cj4+ICAgCQlpZiAoIXdyaXRlKSB7DQo+PiBAQCAtMTU1NSw2ICsxNTY2LDcgQEAgc3RhdGljIHZt
X2ZhdWx0X3QgZGF4X2lvbWFwX3BtZF9mYXVsdChzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgcGZuX3Qg
KnBmbnAsDQo+PiAgIAlpbnQgZXJyb3I7DQo+PiAgIAlwZm5fdCBwZm47DQo+PiAgIAl2b2lkICpr
YWRkcjsNCj4+ICsJdW5zaWduZWQgbG9uZyBpbnNlcnRfZmxhZ3MgPSAwOw0KPj4gICANCj4+ICAg
CS8qDQo+PiAgIAkgKiBDaGVjayB3aGV0aGVyIG9mZnNldCBpc24ndCBiZXlvbmQgZW5kIG9mIGZp
bGUgbm93LiBDYWxsZXIgaXMNCj4+IEBAIC0xNjcwLDE0ICsxNjgyLDE3IEBAIHN0YXRpYyB2bV9m
YXVsdF90IGRheF9pb21hcF9wbWRfZmF1bHQoc3RydWN0IHZtX2ZhdWx0ICp2bWYsIHBmbl90ICpw
Zm5wLA0KPj4gICAJCXJlc3VsdCA9IHZtZl9pbnNlcnRfcGZuX3BtZCh2bWYsIHBmbiwgd3JpdGUp
Ow0KPj4gICAJCWJyZWFrOw0KPj4gICAJY2FzZSBJT01BUF9VTldSSVRURU46DQo+PiAtCQlpZiAo
d3JpdGUgJiYgaW9tYXAuZmxhZ3MgJiBJT01BUF9GX1NIQVJFRCkNCj4+ICsJCWlmICh3cml0ZSAm
JiAoaW9tYXAuZmxhZ3MgJiBJT01BUF9GX1NIQVJFRCkpIHsNCj4+ICsJCQlpbnNlcnRfZmxhZ3Mg
fD0gREFYX0lGX0NPVzsNCj4+ICAgCQkJZ290byBjb3c7DQo+PiArCQl9DQo+PiAgIAkJZmFsbHRo
cm91Z2g7DQo+PiAgIAljYXNlIElPTUFQX0hPTEU6DQo+PiAtCQlpZiAoV0FSTl9PTl9PTkNFKHdy
aXRlKSkNCj4+ICsJCWlmICghd3JpdGUpIHsNCj4+ICsJCQlyZXN1bHQgPSBkYXhfcG1kX2xvYWRf
aG9sZSgmeGFzLCB2bWYsICZpb21hcCwgJmVudHJ5KTsNCj4+ICAgCQkJYnJlYWs7DQo+PiAtCQly
ZXN1bHQgPSBkYXhfcG1kX2xvYWRfaG9sZSgmeGFzLCB2bWYsICZpb21hcCwgJmVudHJ5KTsNCj4+
IC0JCWJyZWFrOw0KPj4gKwkJfQ0KPj4gKwkJZmFsbHRocm91Z2g7DQo+PiAgIAlkZWZhdWx0Og0K
Pj4gICAJCVdBUk5fT05fT05DRSgxKTsNCj4+ICAgCQlicmVhazsNCj4+IC0tIA0KPj4gMi4zMC4w
DQo+Pg0KPj4NCj4gDQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
