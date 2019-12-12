Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C441A11CD47
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 13:35:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A35E1011363B;
	Thu, 12 Dec 2019 04:38:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E943210113639
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 04:38:49 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCTpGa128359;
	Thu, 12 Dec 2019 12:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=n1JBRyyfCwsCHYv3CHqoGwd85kLedGZ22Wnm/zj+jG0=;
 b=OT/1j1tK0abiy5wwnE5NhUn83CiDA9dfgm1NfceOVUHSKUPTBAcIbhrXPAXH9jRLaP5L
 sEeIBsq33bMGm5iaRBN3uIHjy/67+I+GDiHF46ySgbH4ClSK4DurTiNi/FT9gr/SHq2/
 8j5f7gtDq5k/Wbqs4mpz9JC29JEqEBSR6bgOaHZ3QO2BjkthdbIDYafAGTVdNwpnKVd5
 8/kuWWFDeL/tFVS2aZLaQeXw89An+FXsY/Gk+MiTtbNXlJCiyEkZAOOfVKgUaYeSE7wd
 wsBk/hW/fociplvOOdTgHM8eFK2D7gYK5AWqEJRaKrKCtUpV8B7ahVz0voPx6UD/o02b tg==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2wr4qrtn4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 12:34:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCCYBjl123101;
	Thu, 12 Dec 2019 12:34:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2wumvy3ffe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 12:34:20 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCCXhC4029770;
	Thu, 12 Dec 2019 12:33:43 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 04:33:42 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191211213207.215936-3-brho@google.com>
Date: Thu, 12 Dec 2019 14:33:36 +0200
Message-Id: <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
To: Barret Rhoden <brho@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9468 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120094
Message-ID-Hash: EPJ5IU3UBTLHEHSY7TAYL7NAAJX4ED6Y
X-Message-ID-Hash: EPJ5IU3UBTLHEHSY7TAYL7NAAJX4ED6Y
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EPJ5IU3UBTLHEHSY7TAYL7NAAJX4ED6Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTEgRGVjIDIwMTksIGF0IDIzOjMyLCBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPiANCj4gVGhpcyBjaGFuZ2UgYWxsb3dzIEtWTSB0byBtYXAgREFYLWJh
Y2tlZCBmaWxlcyBtYWRlIG9mIGh1Z2UgcGFnZXMgd2l0aA0KPiBodWdlIG1hcHBpbmdzIGluIHRo
ZSBFUFQvVERQLg0KPiANCj4gREFYIHBhZ2VzIGFyZSBub3QgUGFnZVRyYW5zQ29tcG91bmQuICBU
aGUgZXhpc3RpbmcgY2hlY2sgaXMgdHJ5aW5nIHRvDQo+IGRldGVybWluZSBpZiB0aGUgbWFwcGlu
ZyBmb3IgdGhlIHBmbiBpcyBhIGh1Z2UgbWFwcGluZyBvciBub3QuICBGb3INCj4gbm9uLURBWCBt
YXBzLCBlLmcuIGh1Z2V0bGJmcywgdGhhdCBtZWFucyBjaGVja2luZyBQYWdlVHJhbnNDb21wb3Vu
ZC4NCj4gRm9yIERBWCwgd2UgY2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlIGl0c2VsZi4NCg0KRm9y
IGh1Z2V0bGJmcyBwYWdlcywgdGRwX3BhZ2VfZmF1bHQoKSAtPiBtYXBwaW5nX2xldmVsKCkgLT4g
aG9zdF9tYXBwaW5nX2xldmVsKCkgLT4ga3ZtX2hvc3RfcGFnZV9zaXplKCkgLT4gdm1hX2tlcm5l
bF9wYWdlc2l6ZSgpDQp3aWxsIHJldHVybiB0aGUgcGFnZS1zaXplIG9mIHRoZSBodWdldGxiZnMg
d2l0aG91dCB0aGUgbmVlZCB0byBwYXJzZSB0aGUgcGFnZS10YWJsZXMuDQpTZWUgdm1hLT52bV9v
cHMtPnBhZ2VzaXplKCkgY2FsbGJhY2sgaW1wbGVtZW50YXRpb24gYXQgaHVnZXRsYl92bV9vcHMt
PnBhZ2VzaXplKCk9PWh1Z2V0bGJfdm1fb3BfcGFnZXNpemUoKS4NCg0KT25seSBmb3IgcGFnZXMg
dGhhdCB3ZXJlIG9yaWdpbmFsbHkgbWFwcGVkIGFzIHNtYWxsLXBhZ2VzIGFuZCBsYXRlciBtZXJn
ZWQgdG8gbGFyZ2VyIHBhZ2VzIGJ5IFRIUCwgdGhlcmUgaXMgYSBuZWVkIHRvIGNoZWNrIGZvciBQ
YWdlVHJhbnNDb21wb3VuZCgpLiBBZ2FpbiwgaW5zdGVhZCBvZiBwYXJzaW5nIHBhZ2UtdGFibGVz
Lg0KDQpUaGVyZWZvcmUsIGl0IHNlZW1zIG1vcmUgbG9naWNhbCB0byBtZSB0aGF0Og0KKGEpIElm
IERBWC1iYWNrZWQgZmlsZXMgYXJlIG1hcHBlZCBhcyBsYXJnZS1wYWdlcyB0byB1c2Vyc3BhY2Us
IGl0IHNob3VsZCBiZSByZWZsZWN0ZWQgaW4gdm1hLT52bV9vcHMtPnBhZ2Vfc2l6ZSgpIG9mIHRo
YXQgbWFwcGluZy4gQ2F1c2luZyBrdm1faG9zdF9wYWdlX3NpemUoKSB0byByZXR1cm4gdGhlIHJp
Z2h0IHNpemUgd2l0aG91dCB0aGUgbmVlZCB0byBwYXJzZSB0aGUgcGFnZS10YWJsZXMuDQooYikg
SWYgREFYLWJhY2tlZCBmaWxlcyBzbWFsbC1wYWdlcyBjYW4gYmUgbGF0ZXIgbWVyZ2VkIHRvIGxh
cmdlLXBhZ2VzIGJ5IFRIUCwgdGhlbiB0aGUg4oCcc3RydWN0IHBhZ2XigJ0gb2YgdGhlc2UgcGFn
ZXMgc2hvdWxkIGJlIG1vZGlmaWVkIGFzIHVzdWFsIHRvIG1ha2UgUGFnZVRyYW5zQ29tcG91bmQo
KSByZXR1cm4gdHJ1ZSBmb3IgdGhlbS4gSeKAmW0gbm90IGhpZ2hseSBmYW1pbGlhciB3aXRoIHRo
aXMgbWVjaGFuaXNtLCBidXQgSSB3b3VsZCBleHBlY3QgVEhQIHRvIGJlIGFibGUgdG8gbWVyZ2Ug
REFYLWJhY2tlZCBmaWxlcyBzbWFsbC1wYWdlcyB0byBsYXJnZS1wYWdlcyBpbiBjYXNlIERBWCBw
cm92aWRlcyDigJxzdHJ1Y3QgcGFnZeKAnSBmb3IgdGhlIERBWCBwYWdlcy4NCg0KPiANCj4gTm90
ZSB0aGF0IEtWTSBhbHJlYWR5IGZhdWx0ZWQgaW4gdGhlIHBhZ2UgKG9yIGh1Z2UgcGFnZSkgaW4g
dGhlIGhvc3Qncw0KPiBwYWdlIHRhYmxlLCBhbmQgd2UgaG9sZCB0aGUgS1ZNIG1tdSBzcGlubG9j
ay4gIFdlIGdyYWJiZWQgdGhhdCBsb2NrIGluDQo+IGt2bV9tbXVfbm90aWZpZXJfaW52YWxpZGF0
ZV9yYW5nZV9lbmQsIGJlZm9yZSBjaGVja2luZyB0aGUgbW11IHNlcS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJhcnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+IGFyY2gveDg2
L2t2bS9tbXUvbW11LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0N
Cj4gMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYyBiL2FyY2gveDg2L2t2bS9tbXUv
bW11LmMNCj4gaW5kZXggNmY5MmI0MGQ3OThjLi5jZDA3YmM0ZTU5NWYgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gveDg2L2t2bS9tbXUvbW11LmMNCj4gKysrIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYw0K
PiBAQCAtMzM4NCw2ICszMzg0LDM1IEBAIHN0YXRpYyBpbnQga3ZtX2hhbmRsZV9iYWRfcGFnZShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbiwga3ZtX3Bmbl90IHBmbikNCj4gCXJldHVy
biAtRUZBVUxUOw0KPiB9DQo+IA0KPiArc3RhdGljIGJvb2wgcGZuX2lzX2h1Z2VfbWFwcGVkKHN0
cnVjdCBrdm0gKmt2bSwgZ2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgcGZuKQ0KPiArew0KPiArCXN0cnVj
dCBwYWdlICpwYWdlID0gcGZuX3RvX3BhZ2UocGZuKTsNCj4gKwl1bnNpZ25lZCBsb25nIGh2YTsN
Cj4gKw0KPiArCWlmICghaXNfem9uZV9kZXZpY2VfcGFnZShwYWdlKSkNCj4gKwkJcmV0dXJuIFBh
Z2VUcmFuc0NvbXBvdW5kTWFwKHBhZ2UpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBEQVggcGFnZXMg
ZG8gbm90IHVzZSBjb21wb3VuZCBwYWdlcy4gIFRoZSBwYWdlIHNob3VsZCBoYXZlIGFscmVhZHkN
Cj4gKwkgKiBiZWVuIG1hcHBlZCBpbnRvIHRoZSBob3N0LXNpZGUgcGFnZSB0YWJsZSBkdXJpbmcg
dHJ5X2FzeW5jX3BmKCksIHNvDQo+ICsJICogd2UgY2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlcyBk
aXJlY3RseS4NCj4gKwkgKi8NCj4gKwlodmEgPSBnZm5fdG9faHZhKGt2bSwgZ2ZuKTsNCj4gKwlp
ZiAoa3ZtX2lzX2Vycm9yX2h2YShodmEpKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwkv
Kg0KPiArCSAqIE91ciBjYWxsZXIgZ3JhYmJlZCB0aGUgS1ZNIG1tdV9sb2NrIHdpdGggYSBzdWNj
ZXNzZnVsDQo+ICsJICogbW11X25vdGlmaWVyX3JldHJ5LCBzbyB3ZSdyZSBzYWZlIHRvIHdhbGsg
dGhlIHBhZ2UgdGFibGUuDQo+ICsJICovDQo+ICsJc3dpdGNoIChkZXZfcGFnZW1hcF9tYXBwaW5n
X3NoaWZ0KGh2YSwgY3VycmVudC0+bW0pKSB7DQoNCkRvZXNu4oCZdCBkZXZfcGFnZW1hcF9tYXBw
aW5nX3NoaWZ0KCkgZ2V0IOKAnHN0cnVjdCBwYWdl4oCdIGFzIGZpcnN0IHBhcmFtZXRlcj8NCldh
cyB0aGlzIGNoYW5nZWQgYnkgYSBjb21taXQgSSBtaXNzZWQ/DQoNCi1MaXJhbg0KDQo+ICsJY2Fz
ZSBQTURfU0hJRlQ6DQo+ICsJY2FzZSBQVURfU0laRToNCj4gKwkJcmV0dXJuIHRydWU7DQo+ICsJ
fQ0KPiArCXJldHVybiBmYWxzZTsNCj4gK30NCj4gKw0KPiBzdGF0aWMgdm9pZCB0cmFuc3BhcmVu
dF9odWdlcGFnZV9hZGp1c3Qoc3RydWN0IGt2bV92Y3B1ICp2Y3B1LA0KPiAJCQkJCWdmbl90IGdm
biwga3ZtX3Bmbl90ICpwZm5wLA0KPiAJCQkJCWludCAqbGV2ZWxwKQ0KPiBAQCAtMzM5OCw4ICsz
NDI3LDggQEAgc3RhdGljIHZvaWQgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwNCj4gCSAqIGhlcmUuDQo+IAkgKi8NCj4gCWlmICghaXNfZXJyb3Jfbm9z
bG90X3BmbihwZm4pICYmICFrdm1faXNfcmVzZXJ2ZWRfcGZuKHBmbikgJiYNCj4gLQkgICAgIWt2
bV9pc196b25lX2RldmljZV9wZm4ocGZuKSAmJiBsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVM
ICYmDQo+IC0JICAgIFBhZ2VUcmFuc0NvbXBvdW5kTWFwKHBmbl90b19wYWdlKHBmbikpICYmDQo+
ICsJICAgIGxldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwgJiYNCj4gKwkgICAgcGZuX2lzX2h1
Z2VfbWFwcGVkKHZjcHUtPmt2bSwgZ2ZuLCBwZm4pICYmDQo+IAkgICAgIW1tdV9nZm5fbHBhZ2Vf
aXNfZGlzYWxsb3dlZCh2Y3B1LCBnZm4sIFBUX0RJUkVDVE9SWV9MRVZFTCkpIHsNCj4gCQl1bnNp
Z25lZCBsb25nIG1hc2s7DQo+IAkJLyoNCj4gQEAgLTYwMTUsOCArNjA0NCw3IEBAIHN0YXRpYyBi
b29sIGt2bV9tbXVfemFwX2NvbGxhcHNpYmxlX3NwdGUoc3RydWN0IGt2bSAqa3ZtLA0KPiAJCSAq
IG1hcHBpbmcgaWYgdGhlIGluZGlyZWN0IHNwIGhhcyBsZXZlbCA9IDEuDQo+IAkJICovDQo+IAkJ
aWYgKHNwLT5yb2xlLmRpcmVjdCAmJiAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pICYmDQo+IC0J
CSAgICAha3ZtX2lzX3pvbmVfZGV2aWNlX3BmbihwZm4pICYmDQo+IC0JCSAgICBQYWdlVHJhbnND
b21wb3VuZE1hcChwZm5fdG9fcGFnZShwZm4pKSkgew0KPiArCQkgICAgcGZuX2lzX2h1Z2VfbWFw
cGVkKGt2bSwgc3AtPmdmbiwgcGZuKSkgew0KPiAJCQlwdGVfbGlzdF9yZW1vdmUocm1hcF9oZWFk
LCBzcHRlcCk7DQo+IA0KPiAJCQlpZiAoa3ZtX2F2YWlsYWJsZV9mbHVzaF90bGJfd2l0aF9yYW5n
ZSgpKQ0KPiAtLSANCj4gMi4yNC4wLjUyNS5nOGYzNmEzNTRhZS1nb29nDQo+IA0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
