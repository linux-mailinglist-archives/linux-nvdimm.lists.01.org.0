Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E36C411D634
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:49:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83CD610113672;
	Thu, 12 Dec 2019 10:52:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDCFC10113671
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:52:47 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCInLfG071241;
	Thu, 12 Dec 2019 18:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=N7OiLiDxfNSz8gMex3+M5cE14OOq9s6Ys8OUR2rcXG0=;
 b=h4+/GDMX/2KD7HPS7BFf5+6UKN6o+9IWmTFi+k9Z6KG9JJbhOewEUD7LrywEX0LB4p23
 c5eapsksQpZi9Z36/2MoZXDsrHTfHydK7mQcOhlQ5TlcMoBs8JR5n4hX3oZ6H+g4WTL8
 +P60cHjiyp64AxjiAlfzM9g4DDqOL7SeryuvFwMcfrT5U+5nSr8OkkNIpuiVtYghHTOu
 BEgYZa/HboQBJQ6ZaA/vwRg5RVB8JbbJL/LHOsMSNNHtEbvfCUa2NvRyruO9HrRuVguq
 Xpaq4DGvC/ViSZN5kEGxdr/fkNUJMZBdMETE753mmiudW7D2bDVb5GSo161AnxwLK9Ag Dw==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2wr4qrvtsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:49:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCIiCUX192075;
	Thu, 12 Dec 2019 18:47:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 2wumu4htc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:47:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCIlIhc002062;
	Thu, 12 Dec 2019 18:47:19 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 10:47:18 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191212182238.46535-3-brho@google.com>
Date: Thu, 12 Dec 2019 20:47:13 +0200
Message-Id: <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
To: Barret Rhoden <brho@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120144
Message-ID-Hash: PVLPJBVA3VINRTFO567L2GTO6EBIE7KQ
X-Message-ID-Hash: PVLPJBVA3VINRTFO567L2GTO6EBIE7KQ
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PVLPJBVA3VINRTFO567L2GTO6EBIE7KQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDIwOjIyLCBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPiANCj4gVGhpcyBjaGFuZ2UgYWxsb3dzIEtWTSB0byBtYXAgREFYLWJh
Y2tlZCBmaWxlcyBtYWRlIG9mIGh1Z2UgcGFnZXMgd2l0aA0KPiBodWdlIG1hcHBpbmdzIGluIHRo
ZSBFUFQvVERQLg0KDQpUaGlzIGNoYW5nZSBpc27igJl0IG9ubHkgcmVsZXZhbnQgZm9yIFREUC4g
SXQgYWxzbyBhZmZlY3RzIHdoZW4gS1ZNIHVzZSBzaGFkb3ctcGFnaW5nLg0KU2VlIGhvdyBGTkFN
RShwYWdlX2ZhdWx0KSgpIGNhbGxzIHRyYW5zcGFyZW50X2h1Z2VwYWdlX2FkanVzdCgpLg0KDQo+
IA0KPiBEQVggcGFnZXMgYXJlIG5vdCBQYWdlVHJhbnNDb21wb3VuZC4gIFRoZSBleGlzdGluZyBj
aGVjayBpcyB0cnlpbmcgdG8NCj4gZGV0ZXJtaW5lIGlmIHRoZSBtYXBwaW5nIGZvciB0aGUgcGZu
IGlzIGEgaHVnZSBtYXBwaW5nIG9yIG5vdC4NCg0KSSB3b3VsZCByZXBocmFzZSDigJxUaGUgZXhp
c3RpbmcgY2hlY2sgaXMgdHJ5aW5nIHRvIGRldGVybWluZSBpZiB0aGUgcGZuDQppcyBtYXBwZWQg
YXMgcGFydCBvZiBhIHRyYW5zcGFyZW50IGh1Z2UtcGFnZeKAnS4NCg0KPiBGb3INCj4gbm9uLURB
WCBtYXBzLCBlLmcuIGh1Z2V0bGJmcywgdGhhdCBtZWFucyBjaGVja2luZyBQYWdlVHJhbnNDb21w
b3VuZC4NCg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byBodWdldGxiZnMgYnV0IHJhdGhlciBUSFAu
DQoNCj4gRm9yIERBWCwgd2UgY2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlIGl0c2VsZi4NCj4gDQo+
IE5vdGUgdGhhdCBLVk0gYWxyZWFkeSBmYXVsdGVkIGluIHRoZSBwYWdlIChvciBodWdlIHBhZ2Up
IGluIHRoZSBob3N0J3MNCj4gcGFnZSB0YWJsZSwgYW5kIHdlIGhvbGQgdGhlIEtWTSBtbXUgc3Bp
bmxvY2suICBXZSBncmFiYmVkIHRoYXQgbG9jayBpbg0KPiBrdm1fbW11X25vdGlmaWVyX2ludmFs
aWRhdGVfcmFuZ2VfZW5kLCBiZWZvcmUgY2hlY2tpbmcgdGhlIG1tdSBzZXEuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+DQoNCkkgZG9u4oCZdCB0
aGluayB0aGUgcmlnaHQgcGxhY2UgdG8gY2hhbmdlIGZvciB0aGlzIGZ1bmN0aW9uYWxpdHkgaXMg
dHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KCkNCndoaWNoIGlzIG1lYW50IHRvIGhhbmRsZSBQ
Rk5zIHRoYXQgYXJlIG1hcHBlZCBhcyBwYXJ0IG9mIGEgdHJhbnNwYXJlbnQgaHVnZS1wYWdlLg0K
DQpGb3IgZXhhbXBsZSwgdGhpcyB3b3VsZCBwcmV2ZW50IG1hcHBpbmcgREFYLWJhY2tlZCBmaWxl
IHBhZ2UgYXMgMUdCLg0KQXMgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KCkgb25seSBoYW5k
bGVzIHRoZSBjYXNlIChsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVMKS4NCg0KQXMgeW91IGFy
ZSBwYXJzaW5nIHRoZSBwYWdlLXRhYmxlcyB0byBkaXNjb3ZlciB0aGUgcGFnZS1zaXplIHRoZSBQ
Rk4gaXMgbWFwcGVkIGluLA0KSSB0aGluayB5b3Ugc2hvdWxkIGluc3RlYWQgbW9kaWZ5IGt2bV9o
b3N0X3BhZ2Vfc2l6ZSgpIHRvIHBhcnNlIHBhZ2UtdGFibGVzIGluc3RlYWQNCm9mIHJlbHkgb24g
dm1hX2tlcm5lbF9wYWdlc2l6ZSgpIChXaGljaCByZWxpZXMgb24gdm1hLT52bV9vcHMtPnBhZ2Vz
aXplKCkpIGluIGNhc2UNCm9mIGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4NClRoZSBtYWluIGNvbXBs
aWNhdGlvbiB0aG91Z2ggb2YgZG9pbmcgdGhpcyBpcyB0aGF0IGF0IHRoaXMgcG9pbnQgeW91IGRv
buKAmXQgeWV0IGhhdmUgdGhlIFBGTg0KdGhhdCBpcyByZXRyaWV2ZWQgYnkgdHJ5X2FzeW5jX3Bm
KCkuIFNvIG1heWJlIHlvdSBzaG91bGQgY29uc2lkZXIgbW9kaWZ5aW5nIHRoZSBvcmRlciBvZiBj
YWxscw0KaW4gdGRwX3BhZ2VfZmF1bHQoKSAmIEZOQU1FKHBhZ2VfZmF1bHQpKCkuDQoNCi1MaXJh
bg0KDQo+IC0tLQ0KPiBhcmNoL3g4Ni9rdm0vbW11L21tdS5jIHwgMzEgKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jIGIv
YXJjaC94ODYva3ZtL21tdS9tbXUuYw0KPiBpbmRleCA3MjY5MTMwZWE1ZTIuLmVhOGY2OTUxMzk4
YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYw0KPiArKysgYi9hcmNoL3g4
Ni9rdm0vbW11L21tdS5jDQo+IEBAIC0zMzI4LDYgKzMzMjgsMzAgQEAgc3RhdGljIHZvaWQgZGly
ZWN0X3B0ZV9wcmVmZXRjaChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIHU2NCAqc3B0ZXApDQo+IAlf
X2RpcmVjdF9wdGVfcHJlZmV0Y2godmNwdSwgc3AsIHNwdGVwKTsNCj4gfQ0KPiANCj4gK3N0YXRp
YyBib29sIHBmbl9pc19odWdlX21hcHBlZChzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwga3Zt
X3Bmbl90IHBmbikNCj4gK3sNCj4gKwlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBm
bik7DQo+ICsJdW5zaWduZWQgbG9uZyBodmE7DQo+ICsNCj4gKwlpZiAoIWlzX3pvbmVfZGV2aWNl
X3BhZ2UocGFnZSkpDQo+ICsJCXJldHVybiBQYWdlVHJhbnNDb21wb3VuZE1hcChwYWdlKTsNCj4g
Kw0KPiArCS8qDQo+ICsJICogREFYIHBhZ2VzIGRvIG5vdCB1c2UgY29tcG91bmQgcGFnZXMuICBU
aGUgcGFnZSBzaG91bGQgaGF2ZSBhbHJlYWR5DQo+ICsJICogYmVlbiBtYXBwZWQgaW50byB0aGUg
aG9zdC1zaWRlIHBhZ2UgdGFibGUgZHVyaW5nIHRyeV9hc3luY19wZigpLCBzbw0KPiArCSAqIHdl
IGNhbiBjaGVjayB0aGUgcGFnZSB0YWJsZXMgZGlyZWN0bHkuDQo+ICsJICovDQo+ICsJaHZhID0g
Z2ZuX3RvX2h2YShrdm0sIGdmbik7DQo+ICsJaWYgKGt2bV9pc19lcnJvcl9odmEoaHZhKSkNCj4g
KwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBPdXIgY2FsbGVyIGdyYWJiZWQg
dGhlIEtWTSBtbXVfbG9jayB3aXRoIGEgc3VjY2Vzc2Z1bA0KPiArCSAqIG1tdV9ub3RpZmllcl9y
ZXRyeSwgc28gd2UncmUgc2FmZSB0byB3YWxrIHRoZSBwYWdlIHRhYmxlLg0KPiArCSAqLw0KPiAr
CXJldHVybiBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KGh2YSwgY3VycmVudC0+bW0pID4gUEFH
RV9TSElGVDsNCj4gK30NCj4gKw0KPiBzdGF0aWMgdm9pZCB0cmFuc3BhcmVudF9odWdlcGFnZV9h
ZGp1c3Qoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiAJCQkJCWdmbl90IGdmbiwga3ZtX3Bmbl90
ICpwZm5wLA0KPiAJCQkJCWludCAqbGV2ZWxwKQ0KPiBAQCAtMzM0Miw4ICszMzY2LDggQEAgc3Rh
dGljIHZvaWQgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBrdm1fdmNwdSAqdmNw
dSwNCj4gCSAqIGhlcmUuDQo+IAkgKi8NCj4gCWlmICghaXNfZXJyb3Jfbm9zbG90X3BmbihwZm4p
ICYmICFrdm1faXNfcmVzZXJ2ZWRfcGZuKHBmbikgJiYNCj4gLQkgICAgIWt2bV9pc196b25lX2Rl
dmljZV9wZm4ocGZuKSAmJiBsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVMICYmDQo+IC0JICAg
IFBhZ2VUcmFuc0NvbXBvdW5kTWFwKHBmbl90b19wYWdlKHBmbikpKSB7DQo+ICsJICAgIGxldmVs
ID09IFBUX1BBR0VfVEFCTEVfTEVWRUwgJiYNCj4gKwkgICAgcGZuX2lzX2h1Z2VfbWFwcGVkKHZj
cHUtPmt2bSwgZ2ZuLCBwZm4pKSB7DQo+IAkJdW5zaWduZWQgbG9uZyBtYXNrOw0KPiANCj4gCQkv
Kg0KPiBAQCAtNTk1Nyw4ICs1OTgxLDcgQEAgc3RhdGljIGJvb2wga3ZtX21tdV96YXBfY29sbGFw
c2libGVfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sDQo+IAkJICogbWFwcGluZyBpZiB0aGUgaW5kaXJl
Y3Qgc3AgaGFzIGxldmVsID0gMS4NCj4gCQkgKi8NCj4gCQlpZiAoc3AtPnJvbGUuZGlyZWN0ICYm
ICFrdm1faXNfcmVzZXJ2ZWRfcGZuKHBmbikgJiYNCj4gLQkJICAgICFrdm1faXNfem9uZV9kZXZp
Y2VfcGZuKHBmbikgJiYNCj4gLQkJICAgIFBhZ2VUcmFuc0NvbXBvdW5kTWFwKHBmbl90b19wYWdl
KHBmbikpKSB7DQo+ICsJCSAgICBwZm5faXNfaHVnZV9tYXBwZWQoa3ZtLCBzcC0+Z2ZuLCBwZm4p
KSB7DQo+IAkJCXB0ZV9saXN0X3JlbW92ZShybWFwX2hlYWQsIHNwdGVwKTsNCj4gDQo+IAkJCWlm
IChrdm1fYXZhaWxhYmxlX2ZsdXNoX3RsYl93aXRoX3JhbmdlKCkpDQo+IC0tIA0KPiAyLjI0LjAu
NTI1Lmc4ZjM2YTM1NGFlLWdvb2cNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
