Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 224432F266D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Jan 2021 03:55:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E1D9100EBBBE;
	Mon, 11 Jan 2021 18:55:43 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 4046C100EBBA0
	for <linux-nvdimm@lists.01.org>; Mon, 11 Jan 2021 18:55:40 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400";
   d="scan'208";a="103383793"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jan 2021 10:55:38 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id C0A054CE602D;
	Tue, 12 Jan 2021 10:55:35 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 10:55:36 +0800
Subject: Re: [PATCH 04/10] mm, fsdax: Refactor memory-failure handler for dax
 mapping
To: Jan Kara <jack@suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
 <20210106154132.GC29271@quack2.suse.cz>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <75164044-bfdf-b2d6-dff0-d6a8d56d1f62@cn.fujitsu.com>
Date: Tue, 12 Jan 2021 10:55:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106154132.GC29271@quack2.suse.cz>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: C0A054CE602D.AADE7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: F2RWEM4YHOLNUHMFC53HUDQYGADGQ3B6
X-Message-ID-Hash: F2RWEM4YHOLNUHMFC53HUDQYGADGQ3B6
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F2RWEM4YHOLNUHMFC53HUDQYGADGQ3B6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMS82IOS4i+WNiDExOjQxLCBKYW4gS2FyYSB3cm90ZToNCj4gT24gVGh1IDMx
LTEyLTIwIDAwOjU1OjU1LCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+PiBUaGUgY3VycmVudCBtZW1v
cnlfZmFpbHVyZV9kZXZfcGFnZW1hcCgpIGNhbiBvbmx5IGhhbmRsZSBzaW5nbGUtbWFwcGVkDQo+
PiBkYXggcGFnZSBmb3IgZnNkYXggbW9kZS4gIFRoZSBkYXggcGFnZSBjb3VsZCBiZSBtYXBwZWQg
YnkgbXVsdGlwbGUgZmlsZXMNCj4+IGFuZCBvZmZzZXRzIGlmIHdlIGxldCByZWZsaW5rIGZlYXR1
cmUgJiBmc2RheCBtb2RlIHdvcmsgdG9nZXRoZXIuICBTbywNCj4+IHdlIHJlZmFjdG9yIGN1cnJl
bnQgaW1wbGVtZW50YXRpb24gdG8gc3VwcG9ydCBoYW5kbGUgbWVtb3J5IGZhaWx1cmUgb24NCj4+
IGVhY2ggZmlsZSBhbmQgb2Zmc2V0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVh
biA8cnVhbnN5LmZuc3RAY24uZnVqaXRzdS5jb20+DQo+IA0KPiBPdmVyYWxsIHRoaXMgbG9va3Mg
T0sgdG8gbWUsIGEgZmV3IGNvbW1lbnRzIGJlbG93Lg0KPiANCj4+IC0tLQ0KPj4gICBmcy9kYXgu
YyAgICAgICAgICAgIHwgMjEgKysrKysrKysrKysNCj4+ICAgaW5jbHVkZS9saW51eC9kYXguaCB8
ICAxICsNCj4+ICAgaW5jbHVkZS9saW51eC9tbS5oICB8ICA5ICsrKysrDQo+PiAgIG1tL21lbW9y
eS1mYWlsdXJlLmMgfCA5MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRp
b25zKC0pDQoNCi4uLg0KDQo+PiAgIA0KPj4gQEAgLTM0NSw5ICszNDgsMTIgQEAgc3RhdGljIHZv
aWQgYWRkX3RvX2tpbGwoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHN0cnVjdCBwYWdlICpwLA0K
Pj4gICAJfQ0KPj4gICANCj4+ICAgCXRrLT5hZGRyID0gcGFnZV9hZGRyZXNzX2luX3ZtYShwLCB2
bWEpOw0KPj4gLQlpZiAoaXNfem9uZV9kZXZpY2VfcGFnZShwKSkNCj4+IC0JCXRrLT5zaXplX3No
aWZ0ID0gZGV2X3BhZ2VtYXBfbWFwcGluZ19zaGlmdChwLCB2bWEpOw0KPj4gLQllbHNlDQo+PiAr
CWlmIChpc196b25lX2RldmljZV9wYWdlKHApKSB7DQo+PiArCQlpZiAoaXNfZGV2aWNlX2ZzZGF4
X3BhZ2UocCkpDQo+PiArCQkJdGstPmFkZHIgPSB2bWEtPnZtX3N0YXJ0ICsNCj4+ICsJCQkJCSgo
cGdvZmYgLSB2bWEtPnZtX3Bnb2ZmKSA8PCBQQUdFX1NISUZUKTsNCj4gDQo+IEl0IHNlZW1zIHN0
cmFuZ2UgdG8gdXNlICdwZ29mZicgZm9yIGRheCBwYWdlcyBhbmQgbm90IGZvciBhbnkgb3RoZXIg
cGFnZS4NCj4gV2h5PyBJJ2QgcmF0aGVyIHBhc3MgY29ycmVjdCBwZ29mZiBmcm9tIGFsbCBjYWxs
ZXJzIG9mIGFkZF90b19raWxsKCkgYW5kDQo+IGF2b2lkIHRoaXMgc3BlY2lhbCBjYXNpbmcuLi4N
Cg0KQmVjYXVzZSBvbmUgZnNkYXggcGFnZSBjYW4gYmUgc2hhcmVkIGJ5IG11bHRpcGxlIHBnb2Zm
cy4gIEkgaGF2ZSB0byBwYXNzIA0KZWFjaCBwZ29mZiBpbiBlYWNoIGl0ZXJhdGlvbiB0byBjYWxj
dWxhdGUgdGhlIGFkZHJlc3MgaW4gdm1hIChmb3IgDQp0ay0+YWRkcikuICBPdGhlciBraW5kcyBv
ZiBwYWdlcyBkb24ndCBuZWVkIHRoaXMuICBUaGV5IGNhbiBnZXQgdGhlaXIgDQp1bmlxdWUgYWRk
cmVzcyBieSBjYWxsaW5nICJwYWdlX2FkZHJlc3NfaW5fdm1hKCkiLg0KDQpTbywgSSBhZGRlZCB0
aGlzIGZzZGF4IGNhc2UgaGVyZS4gIFRoaXMgcGF0Y2hzZXQgb25seSBpbXBsZW1lbnRlZCB0aGUg
DQpmc2RheCBjYXNlLCBvdGhlciBjYXNlcyBhbHNvIG5lZWQgdG8gYmUgYWRkZWQgaGVyZSBpZiB0
byBiZSBpbXBsZW1lbnRlZC4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0KDQo+IA0K
Pj4gKwkJdGstPnNpemVfc2hpZnQgPSBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KHAsIHZtYSwg
dGstPmFkZHIpOw0KPj4gKwl9IGVsc2UNCj4+ICAgCQl0ay0+c2l6ZV9zaGlmdCA9IHBhZ2Vfc2hp
ZnQoY29tcG91bmRfaGVhZChwKSk7DQo+PiAgIA0KPj4gICAJLyoNCj4+IEBAIC00OTUsNyArNTAx
LDcgQEAgc3RhdGljIHZvaWQgY29sbGVjdF9wcm9jc19hbm9uKHN0cnVjdCBwYWdlICpwYWdlLCBz
dHJ1Y3QgbGlzdF9oZWFkICp0b19raWxsLA0KPj4gICAJCQlpZiAoIXBhZ2VfbWFwcGVkX2luX3Zt
YShwYWdlLCB2bWEpKQ0KPj4gICAJCQkJY29udGludWU7DQo+PiAgIAkJCWlmICh2bWEtPnZtX21t
ID09IHQtPm1tKQ0KPj4gLQkJCQlhZGRfdG9fa2lsbCh0LCBwYWdlLCB2bWEsIHRvX2tpbGwpOw0K
Pj4gKwkJCQlhZGRfdG9fa2lsbCh0LCBwYWdlLCBOVUxMLCAwLCB2bWEsIHRvX2tpbGwpOw0KPj4g
ICAJCX0NCj4+ICAgCX0NCj4+ICAgCXJlYWRfdW5sb2NrKCZ0YXNrbGlzdF9sb2NrKTsNCj4+IEBA
IC01MDUsMjQgKzUxMSwxOSBAQCBzdGF0aWMgdm9pZCBjb2xsZWN0X3Byb2NzX2Fub24oc3RydWN0
IHBhZ2UgKnBhZ2UsIHN0cnVjdCBsaXN0X2hlYWQgKnRvX2tpbGwsDQo+PiAgIC8qDQo+PiAgICAq
IENvbGxlY3QgcHJvY2Vzc2VzIHdoZW4gdGhlIGVycm9yIGhpdCBhIGZpbGUgbWFwcGVkIHBhZ2Uu
DQo+PiAgICAqLw0KPj4gLXN0YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3NfZmlsZShzdHJ1Y3QgcGFn
ZSAqcGFnZSwgc3RydWN0IGxpc3RfaGVhZCAqdG9fa2lsbCwNCj4+IC0JCQkJaW50IGZvcmNlX2Vh
cmx5KQ0KPj4gK3N0YXRpYyB2b2lkIGNvbGxlY3RfcHJvY3NfZmlsZShzdHJ1Y3QgcGFnZSAqcGFn
ZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsDQo+PiArCQlwZ29mZl90IHBnb2ZmLCBz
dHJ1Y3QgbGlzdF9oZWFkICp0b19raWxsLCBpbnQgZm9yY2VfZWFybHkpDQo+PiAgIHsNCj4+ICAg
CXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KPj4gICAJc3RydWN0IHRhc2tfc3RydWN0ICp0
c2s7DQo+PiAtCXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gcGFnZS0+bWFwcGluZzsN
Cj4+IC0JcGdvZmZfdCBwZ29mZjsNCj4+ICAgDQo+PiAgIAlpX21tYXBfbG9ja19yZWFkKG1hcHBp
bmcpOw0KPj4gICAJcmVhZF9sb2NrKCZ0YXNrbGlzdF9sb2NrKTsNCj4+IC0JcGdvZmYgPSBwYWdl
X3RvX3Bnb2ZmKHBhZ2UpOw0KPj4gICAJZm9yX2VhY2hfcHJvY2Vzcyh0c2spIHsNCj4+ICAgCQlz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnQgPSB0YXNrX2Vhcmx5X2tpbGwodHNrLCBmb3JjZV9lYXJseSk7
DQo+PiAtDQo+PiAgIAkJaWYgKCF0KQ0KPj4gICAJCQljb250aW51ZTsNCj4+IC0JCXZtYV9pbnRl
cnZhbF90cmVlX2ZvcmVhY2godm1hLCAmbWFwcGluZy0+aV9tbWFwLCBwZ29mZiwNCj4+IC0JCQkJ
ICAgICAgcGdvZmYpIHsNCj4+ICsJCXZtYV9pbnRlcnZhbF90cmVlX2ZvcmVhY2godm1hLCAmbWFw
cGluZy0+aV9tbWFwLCBwZ29mZiwgcGdvZmYpIHsNCj4+ICAgCQkJLyoNCj4+ICAgCQkJICogU2Vu
ZCBlYXJseSBraWxsIHNpZ25hbCB0byB0YXNrcyB3aGVyZSBhIHZtYSBjb3ZlcnMNCj4+ICAgCQkJ
ICogdGhlIHBhZ2UgYnV0IHRoZSBjb3JydXB0ZWQgcGFnZSBpcyBub3QgbmVjZXNzYXJpbHkNCj4+
IEBAIC01MzEsNyArNTMyLDcgQEAgc3RhdGljIHZvaWQgY29sbGVjdF9wcm9jc19maWxlKHN0cnVj
dCBwYWdlICpwYWdlLCBzdHJ1Y3QgbGlzdF9oZWFkICp0b19raWxsLA0KPj4gICAJCQkgKiB0byBi
ZSBpbmZvcm1lZCBvZiBhbGwgc3VjaCBkYXRhIGNvcnJ1cHRpb25zLg0KPj4gICAJCQkgKi8NCj4+
ICAgCQkJaWYgKHZtYS0+dm1fbW0gPT0gdC0+bW0pDQo+PiAtCQkJCWFkZF90b19raWxsKHQsIHBh
Z2UsIHZtYSwgdG9fa2lsbCk7DQo+PiArCQkJCWFkZF90b19raWxsKHQsIHBhZ2UsIG1hcHBpbmcs
IHBnb2ZmLCB2bWEsIHRvX2tpbGwpOw0KPj4gICAJCX0NCj4+ICAgCX0NCj4+ICAgCXJlYWRfdW5s
b2NrKCZ0YXNrbGlzdF9sb2NrKTsNCj4+IEBAIC01NTAsNyArNTUxLDggQEAgc3RhdGljIHZvaWQg
Y29sbGVjdF9wcm9jcyhzdHJ1Y3QgcGFnZSAqcGFnZSwgc3RydWN0IGxpc3RfaGVhZCAqdG9raWxs
LA0KPj4gICAJaWYgKFBhZ2VBbm9uKHBhZ2UpKQ0KPj4gICAJCWNvbGxlY3RfcHJvY3NfYW5vbihw
YWdlLCB0b2tpbGwsIGZvcmNlX2Vhcmx5KTsNCj4+ICAgCWVsc2UNCj4+IC0JCWNvbGxlY3RfcHJv
Y3NfZmlsZShwYWdlLCB0b2tpbGwsIGZvcmNlX2Vhcmx5KTsNCj4+ICsJCWNvbGxlY3RfcHJvY3Nf
ZmlsZShwYWdlLCBwYWdlLT5tYXBwaW5nLCBwYWdlX3RvX3Bnb2ZmKHBhZ2UpLA0KPiANCj4gV2h5
IG5vdCB1c2UgcGFnZV9tYXBwaW5nKCkgaGVscGVyIGhlcmU/IEl0IHdvdWxkIGJlIHNhZmVyIGZv
ciBUSFBzIGlmIHRoZXkNCj4gZXZlciBnZXQgaGVyZS4uLg0KPiANCj4gCQkJCQkJCQlIb256YQ0K
PiANCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
