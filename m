Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD611D437
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:39:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BBE1410113666;
	Thu, 12 Dec 2019 09:43:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A606710113665
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:43:15 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHYwVn025285;
	Thu, 12 Dec 2019 17:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=GZgjwmhgJteaBjf2zFdb4pvniK3k7AXpKNNZw7iTccY=;
 b=mdpZazkoBsoxr98lQVSyw7xF17N24a+flOtp+DrYxaJQvvsbfJq5mAhzix7rohiPK/cY
 f38m3wBvY7QE4/vCoF6teyEoE2E/dSz5DrQ6WlhRum0SNFcJObw1EDlHb0TLadjAEBr9
 xm2DnqW0ieCXFyJT9F+tz0uEUiWyiKV2vqA3Xqx7t27nncGq4LvS5dX7d/CkmD8FPop4
 MnsDr8YpV7vOVgA76OfE8/uBvdfJGA75p1KN8vnq5crKgsFU4H926Q5PTaiJUJTR0uD8
 /yUC75DM2wL84/NVhB5bDyGNP6o++4uu2KAUEG974+DHmARYu18iEQ42BATPn9KsoQYl ug==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 2wrw4nhcw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 17:39:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHdKjS179849;
	Thu, 12 Dec 2019 17:39:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 2wumu4et8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 17:39:46 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBCHdUmC012456;
	Thu, 12 Dec 2019 17:39:30 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 09:39:30 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
Date: Thu, 12 Dec 2019 19:39:25 +0200
Message-Id: <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
 <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120138
Message-ID-Hash: S5NMOKQGUMTG3UMGLJVCPXQNOLB4MYTQ
X-Message-ID-Hash: S5NMOKQGUMTG3UMGLJVCPXQNOLB4MYTQ
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S5NMOKQGUMTG3UMGLJVCPXQNOLB4MYTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDE4OjU0LCBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBUaHUsIERlYyAxMiwgMjAxOSBhdCA0OjM0
IEFNIExpcmFuIEFsb24gPGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+PiANCj4+IA0K
Pj4gDQo+Pj4gT24gMTEgRGVjIDIwMTksIGF0IDIzOjMyLCBCYXJyZXQgUmhvZGVuIDxicmhvQGdv
b2dsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IFRoaXMgY2hhbmdlIGFsbG93cyBLVk0gdG8gbWFw
IERBWC1iYWNrZWQgZmlsZXMgbWFkZSBvZiBodWdlIHBhZ2VzIHdpdGgNCj4+PiBodWdlIG1hcHBp
bmdzIGluIHRoZSBFUFQvVERQLg0KPj4+IA0KPj4+IERBWCBwYWdlcyBhcmUgbm90IFBhZ2VUcmFu
c0NvbXBvdW5kLiAgVGhlIGV4aXN0aW5nIGNoZWNrIGlzIHRyeWluZyB0bw0KPj4+IGRldGVybWlu
ZSBpZiB0aGUgbWFwcGluZyBmb3IgdGhlIHBmbiBpcyBhIGh1Z2UgbWFwcGluZyBvciBub3QuICBG
b3INCj4+PiBub24tREFYIG1hcHMsIGUuZy4gaHVnZXRsYmZzLCB0aGF0IG1lYW5zIGNoZWNraW5n
IFBhZ2VUcmFuc0NvbXBvdW5kLg0KPj4+IEZvciBEQVgsIHdlIGNhbiBjaGVjayB0aGUgcGFnZSB0
YWJsZSBpdHNlbGYuDQo+PiANCj4+IEZvciBodWdldGxiZnMgcGFnZXMsIHRkcF9wYWdlX2ZhdWx0
KCkgLT4gbWFwcGluZ19sZXZlbCgpIC0+IGhvc3RfbWFwcGluZ19sZXZlbCgpIC0+IGt2bV9ob3N0
X3BhZ2Vfc2l6ZSgpIC0+IHZtYV9rZXJuZWxfcGFnZXNpemUoKQ0KPj4gd2lsbCByZXR1cm4gdGhl
IHBhZ2Utc2l6ZSBvZiB0aGUgaHVnZXRsYmZzIHdpdGhvdXQgdGhlIG5lZWQgdG8gcGFyc2UgdGhl
IHBhZ2UtdGFibGVzLg0KPj4gU2VlIHZtYS0+dm1fb3BzLT5wYWdlc2l6ZSgpIGNhbGxiYWNrIGlt
cGxlbWVudGF0aW9uIGF0IGh1Z2V0bGJfdm1fb3BzLT5wYWdlc2l6ZSgpPT1odWdldGxiX3ZtX29w
X3BhZ2VzaXplKCkuDQo+PiANCj4+IE9ubHkgZm9yIHBhZ2VzIHRoYXQgd2VyZSBvcmlnaW5hbGx5
IG1hcHBlZCBhcyBzbWFsbC1wYWdlcyBhbmQgbGF0ZXIgbWVyZ2VkIHRvIGxhcmdlciBwYWdlcyBi
eSBUSFAsIHRoZXJlIGlzIGEgbmVlZCB0byBjaGVjayBmb3IgUGFnZVRyYW5zQ29tcG91bmQoKS4g
QWdhaW4sIGluc3RlYWQgb2YgcGFyc2luZyBwYWdlLXRhYmxlcy4NCj4+IA0KPj4gVGhlcmVmb3Jl
LCBpdCBzZWVtcyBtb3JlIGxvZ2ljYWwgdG8gbWUgdGhhdDoNCj4+IChhKSBJZiBEQVgtYmFja2Vk
IGZpbGVzIGFyZSBtYXBwZWQgYXMgbGFyZ2UtcGFnZXMgdG8gdXNlcnNwYWNlLCBpdCBzaG91bGQg
YmUgcmVmbGVjdGVkIGluIHZtYS0+dm1fb3BzLT5wYWdlX3NpemUoKSBvZiB0aGF0IG1hcHBpbmcu
IENhdXNpbmcga3ZtX2hvc3RfcGFnZV9zaXplKCkgdG8gcmV0dXJuIHRoZSByaWdodCBzaXplIHdp
dGhvdXQgdGhlIG5lZWQgdG8gcGFyc2UgdGhlIHBhZ2UtdGFibGVzLg0KPiANCj4gQSBnaXZlbiBk
YXgtbWFwcGVkIHZtYSBtYXkgaGF2ZSBtaXhlZCBwYWdlIHNpemVzIHNvIC0+cGFnZV9zaXplKCkN
Cj4gY2FuJ3QgYmUgdXNlZCByZWxpYWJseSB0byBlbnVtZXJhdGluZyB0aGUgbWFwcGluZyBzaXpl
Lg0KDQpOYWl2ZSBxdWVzdGlvbjogV2h5IGRvbuKAmXQgc3BsaXQgdGhlIFZNQSBpbiB0aGlzIGNh
c2UgdG8gbXVsdGlwbGUgVk1BcyB3aXRoIGRpZmZlcmVudCByZXN1bHRzIGZvciAtPnBhZ2Vfc2l6
ZSgpPw0KV2hhdCB5b3UgYXJlIGRlc2NyaWJpbmcgc291bmRzIGxpa2UgREFYIGlzIGJyZWFraW5n
IHRoaXMgY2FsbGJhY2sgc2VtYW50aWNzIGluIGFuIHVucHJlZGljdGFibGUgbWFubmVyLg0KDQo+
IA0KPj4gKGIpIElmIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFnZXMgY2FuIGJlIGxhdGVyIG1l
cmdlZCB0byBsYXJnZS1wYWdlcyBieSBUSFAsIHRoZW4gdGhlIOKAnHN0cnVjdCBwYWdl4oCdIG9m
IHRoZXNlIHBhZ2VzIHNob3VsZCBiZSBtb2RpZmllZCBhcyB1c3VhbCB0byBtYWtlIFBhZ2VUcmFu
c0NvbXBvdW5kKCkgcmV0dXJuIHRydWUgZm9yIHRoZW0uIEnigJltIG5vdCBoaWdobHkgZmFtaWxp
YXIgd2l0aCB0aGlzIG1lY2hhbmlzbSwgYnV0IEkgd291bGQgZXhwZWN0IFRIUCB0byBiZSBhYmxl
IHRvIG1lcmdlIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFnZXMgdG8gbGFyZ2UtcGFnZXMgaW4g
Y2FzZSBEQVggcHJvdmlkZXMg4oCcc3RydWN0IHBhZ2XigJ0gZm9yIHRoZSBEQVggcGFnZXMuDQo+
IA0KPiBEQVggcGFnZXMgZG8gbm90IHBhcnRpY2lwYXRlIGluIFRIUCBhbmQgZG8gbm90IGhhdmUg
dGhlDQo+IFBhZ2VUcmFuc0NvbXBvdW5kIGFjY291bnRpbmcuIFRoZSBvbmx5IG1lY2hhbmlzbSB0
aGF0IHJlY29yZHMgdGhlDQo+IG1hcHBpbmcgc2l6ZSBmb3IgZGF4IGlzIHRoZSBwYWdlIHRhYmxl
cyB0aGVtc2VsdmVzLg0KDQpXaGF0IGlzIHRoZSByYXRpb25hbCBiZWhpbmQgdGhpcz8gR2l2ZW4g
dGhhdCBEQVggcGFnZXMgY2FuIGJlIGRlc2NyaWJlZCB3aXRoIOKAnHN0cnVjdCBwYWdl4oCdIChp
LmUuIFpPTkVfREVWSUNFKSwgd2hhdCBwcmV2ZW50cyBUSFAgZnJvbSBtYW5pcHVsYXRpbmcgcGFn
ZS10YWJsZXMgdG8gbWVyZ2UgbXVsdGlwbGUgREFYIFBGTnMgdG8gYSBsYXJnZXIgcGFnZT8NCg0K
LUxpcmFuDQoNCj4gDQo+IA0KPj4gDQo+Pj4gDQo+Pj4gTm90ZSB0aGF0IEtWTSBhbHJlYWR5IGZh
dWx0ZWQgaW4gdGhlIHBhZ2UgKG9yIGh1Z2UgcGFnZSkgaW4gdGhlIGhvc3Qncw0KPj4+IHBhZ2Ug
dGFibGUsIGFuZCB3ZSBob2xkIHRoZSBLVk0gbW11IHNwaW5sb2NrLiAgV2UgZ3JhYmJlZCB0aGF0
IGxvY2sgaW4NCj4+PiBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kLCBiZWZv
cmUgY2hlY2tpbmcgdGhlIG1tdSBzZXEuDQo+Pj4gDQo+Pj4gU2lnbmVkLW9mZi1ieTogQmFycmV0
IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPg0KPj4+IC0tLQ0KPj4+IGFyY2gveDg2L2t2bS9tbXUv
bW11LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCj4+PiAxIGZp
bGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+PiANCj4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYyBiL2FyY2gveDg2L2t2bS9tbXUvbW11
LmMNCj4+PiBpbmRleCA2ZjkyYjQwZDc5OGMuLmNkMDdiYzRlNTk1ZiAxMDA2NDQNCj4+PiAtLS0g
YS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+Pj4gKysrIGIvYXJjaC94ODYva3ZtL21tdS9tbXUu
Yw0KPj4+IEBAIC0zMzg0LDYgKzMzODQsMzUgQEAgc3RhdGljIGludCBrdm1faGFuZGxlX2JhZF9w
YWdlKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgcGZuKQ0KPj4+
ICAgICAgcmV0dXJuIC1FRkFVTFQ7DQo+Pj4gfQ0KPj4+IA0KPj4+ICtzdGF0aWMgYm9vbCBwZm5f
aXNfaHVnZV9tYXBwZWQoc3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm4sIGt2bV9wZm5fdCBwZm4p
DQo+Pj4gK3sNCj4+PiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBmbik7
DQo+Pj4gKyAgICAgdW5zaWduZWQgbG9uZyBodmE7DQo+Pj4gKw0KPj4+ICsgICAgIGlmICghaXNf
em9uZV9kZXZpY2VfcGFnZShwYWdlKSkNCj4+PiArICAgICAgICAgICAgIHJldHVybiBQYWdlVHJh
bnNDb21wb3VuZE1hcChwYWdlKTsNCj4+PiArDQo+Pj4gKyAgICAgLyoNCj4+PiArICAgICAgKiBE
QVggcGFnZXMgZG8gbm90IHVzZSBjb21wb3VuZCBwYWdlcy4gIFRoZSBwYWdlIHNob3VsZCBoYXZl
IGFscmVhZHkNCj4+PiArICAgICAgKiBiZWVuIG1hcHBlZCBpbnRvIHRoZSBob3N0LXNpZGUgcGFn
ZSB0YWJsZSBkdXJpbmcgdHJ5X2FzeW5jX3BmKCksIHNvDQo+Pj4gKyAgICAgICogd2UgY2FuIGNo
ZWNrIHRoZSBwYWdlIHRhYmxlcyBkaXJlY3RseS4NCj4+PiArICAgICAgKi8NCj4+PiArICAgICBo
dmEgPSBnZm5fdG9faHZhKGt2bSwgZ2ZuKTsNCj4+PiArICAgICBpZiAoa3ZtX2lzX2Vycm9yX2h2
YShodmEpKQ0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+ICsNCj4+PiArICAg
ICAvKg0KPj4+ICsgICAgICAqIE91ciBjYWxsZXIgZ3JhYmJlZCB0aGUgS1ZNIG1tdV9sb2NrIHdp
dGggYSBzdWNjZXNzZnVsDQo+Pj4gKyAgICAgICogbW11X25vdGlmaWVyX3JldHJ5LCBzbyB3ZSdy
ZSBzYWZlIHRvIHdhbGsgdGhlIHBhZ2UgdGFibGUuDQo+Pj4gKyAgICAgICovDQo+Pj4gKyAgICAg
c3dpdGNoIChkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KGh2YSwgY3VycmVudC0+bW0pKSB7DQo+
PiANCj4+IERvZXNu4oCZdCBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KCkgZ2V0IOKAnHN0cnVj
dCBwYWdl4oCdIGFzIGZpcnN0IHBhcmFtZXRlcj8NCj4+IFdhcyB0aGlzIGNoYW5nZWQgYnkgYSBj
b21taXQgSSBtaXNzZWQ/DQo+PiANCj4+IC1MaXJhbg0KPj4gDQo+Pj4gKyAgICAgY2FzZSBQTURf
U0hJRlQ6DQo+Pj4gKyAgICAgY2FzZSBQVURfU0laRToNCj4+PiArICAgICAgICAgICAgIHJldHVy
biB0cnVlOw0KPj4+ICsgICAgIH0NCj4+PiArICAgICByZXR1cm4gZmFsc2U7DQo+Pj4gK30NCj4+
PiArDQo+Pj4gc3RhdGljIHZvaWQgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgKnBmbnAsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCAqbGV2ZWxwKQ0KPj4+IEBAIC0zMzk4LDggKzM0MjcsOCBAQCBzdGF0
aWMgdm9pZCB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3Qoc3RydWN0IGt2bV92Y3B1ICp2Y3B1
LA0KPj4+ICAgICAgICogaGVyZS4NCj4+PiAgICAgICAqLw0KPj4+ICAgICAgaWYgKCFpc19lcnJv
cl9ub3Nsb3RfcGZuKHBmbikgJiYgIWt2bV9pc19yZXNlcnZlZF9wZm4ocGZuKSAmJg0KPj4+IC0g
ICAgICAgICAha3ZtX2lzX3pvbmVfZGV2aWNlX3BmbihwZm4pICYmIGxldmVsID09IFBUX1BBR0Vf
VEFCTEVfTEVWRUwgJiYNCj4+PiAtICAgICAgICAgUGFnZVRyYW5zQ29tcG91bmRNYXAocGZuX3Rv
X3BhZ2UocGZuKSkgJiYNCj4+PiArICAgICAgICAgbGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZF
TCAmJg0KPj4+ICsgICAgICAgICBwZm5faXNfaHVnZV9tYXBwZWQodmNwdS0+a3ZtLCBnZm4sIHBm
bikgJiYNCj4+PiAgICAgICAgICAhbW11X2dmbl9scGFnZV9pc19kaXNhbGxvd2VkKHZjcHUsIGdm
biwgUFRfRElSRUNUT1JZX0xFVkVMKSkgew0KPj4+ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25n
IG1hc2s7DQo+Pj4gICAgICAgICAgICAgIC8qDQo+Pj4gQEAgLTYwMTUsOCArNjA0NCw3IEBAIHN0
YXRpYyBib29sIGt2bV9tbXVfemFwX2NvbGxhcHNpYmxlX3NwdGUoc3RydWN0IGt2bSAqa3ZtLA0K
Pj4+ICAgICAgICAgICAgICAgKiBtYXBwaW5nIGlmIHRoZSBpbmRpcmVjdCBzcCBoYXMgbGV2ZWwg
PSAxLg0KPj4+ICAgICAgICAgICAgICAgKi8NCj4+PiAgICAgICAgICAgICAgaWYgKHNwLT5yb2xl
LmRpcmVjdCAmJiAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pICYmDQo+Pj4gLSAgICAgICAgICAg
ICAgICAgIWt2bV9pc196b25lX2RldmljZV9wZm4ocGZuKSAmJg0KPj4+IC0gICAgICAgICAgICAg
ICAgIFBhZ2VUcmFuc0NvbXBvdW5kTWFwKHBmbl90b19wYWdlKHBmbikpKSB7DQo+Pj4gKyAgICAg
ICAgICAgICAgICAgcGZuX2lzX2h1Z2VfbWFwcGVkKGt2bSwgc3AtPmdmbiwgcGZuKSkgew0KPj4+
ICAgICAgICAgICAgICAgICAgICAgIHB0ZV9saXN0X3JlbW92ZShybWFwX2hlYWQsIHNwdGVwKTsN
Cj4+PiANCj4+PiAgICAgICAgICAgICAgICAgICAgICBpZiAoa3ZtX2F2YWlsYWJsZV9mbHVzaF90
bGJfd2l0aF9yYW5nZSgpKQ0KPj4+IC0tDQo+Pj4gMi4yNC4wLjUyNS5nOGYzNmEzNTRhZS1nb29n
DQo+Pj4gDQo+PiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
