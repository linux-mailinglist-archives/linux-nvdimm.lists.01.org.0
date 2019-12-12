Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6B11D461
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:45:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5E53C10113669;
	Thu, 12 Dec 2019 09:48:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97EBB10113667
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:48:55 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHir5l016867;
	Thu, 12 Dec 2019 17:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=gQua6smOLP0Ap8OTragAs0MkFrsy/Ykvuffp+G43BKs=;
 b=NtRjRpL11/RyXPiKkIEAnV5dL5Q4UIGwnzyLWXRQrtE03BjvxPNc4KNOwMdEp58mipCD
 hFVqGRdBkgIJGCJ/BD7hIwVVl8aE+7vrQmOzM/RtgvWmG3uSzuWYooKVa6HvE+vvHVki
 OlH32s3L5UaDB7EfgwKHJMtD674O3NgnC3JdxVBPVCRH6YDiNu+pUhhejqsRqJnBiNSV
 spMH6ruJX6WABOsvba+lR2RO8wM8//+G+da8jX2eNnY6DyHrp9gQS3PLBJg0o8kPCKBo
 j7lubFioDlElvq2t+e3SxKB7YDkeVJe2ATWOht+moJr8kLX2d1FOSzTz/DJJE6zDTQhl Yw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 2wr4qrvg2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 17:45:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCHhebj177187;
	Thu, 12 Dec 2019 17:45:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3020.oracle.com with ESMTP id 2wumw0na7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 17:45:28 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCHjQYl006497;
	Thu, 12 Dec 2019 17:45:26 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 09:45:26 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191212173413.GC3163@linux.intel.com>
Date: Thu, 12 Dec 2019 19:45:21 +0200
Message-Id: <57D547EE-2627-475D-84AF-0B080433DC52@oracle.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120139
Message-ID-Hash: XMOSUET6N5RMO4ZMXZEENF63WWHGTN2F
X-Message-ID-Hash: XMOSUET6N5RMO4ZMXZEENF63WWHGTN2F
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XMOSUET6N5RMO4ZMXZEENF63WWHGTN2F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDE5OjM0LCBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
LmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgRGVjIDEx
LCAyMDE5IGF0IDA0OjMyOjA3UE0gLTA1MDAsIEJhcnJldCBSaG9kZW4gd3JvdGU6DQo+PiBUaGlz
IGNoYW5nZSBhbGxvd3MgS1ZNIHRvIG1hcCBEQVgtYmFja2VkIGZpbGVzIG1hZGUgb2YgaHVnZSBw
YWdlcyB3aXRoDQo+PiBodWdlIG1hcHBpbmdzIGluIHRoZSBFUFQvVERQLg0KPj4gDQo+PiBEQVgg
cGFnZXMgYXJlIG5vdCBQYWdlVHJhbnNDb21wb3VuZC4gIFRoZSBleGlzdGluZyBjaGVjayBpcyB0
cnlpbmcgdG8NCj4+IGRldGVybWluZSBpZiB0aGUgbWFwcGluZyBmb3IgdGhlIHBmbiBpcyBhIGh1
Z2UgbWFwcGluZyBvciBub3QuICBGb3INCj4+IG5vbi1EQVggbWFwcywgZS5nLiBodWdldGxiZnMs
IHRoYXQgbWVhbnMgY2hlY2tpbmcgUGFnZVRyYW5zQ29tcG91bmQuDQo+PiBGb3IgREFYLCB3ZSBj
YW4gY2hlY2sgdGhlIHBhZ2UgdGFibGUgaXRzZWxmLg0KPj4gDQo+PiBOb3RlIHRoYXQgS1ZNIGFs
cmVhZHkgZmF1bHRlZCBpbiB0aGUgcGFnZSAob3IgaHVnZSBwYWdlKSBpbiB0aGUgaG9zdCdzDQo+
PiBwYWdlIHRhYmxlLCBhbmQgd2UgaG9sZCB0aGUgS1ZNIG1tdSBzcGlubG9jay4gIFdlIGdyYWJi
ZWQgdGhhdCBsb2NrIGluDQo+PiBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5k
LCBiZWZvcmUgY2hlY2tpbmcgdGhlIG1tdSBzZXEuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IEJh
cnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4NCj4+IC0tLQ0KPj4gYXJjaC94ODYva3ZtL21t
dS9tbXUuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gMSBm
aWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vbW11L21tdS5jIGIvYXJjaC94ODYva3ZtL21tdS9tbXUu
Yw0KPj4gaW5kZXggNmY5MmI0MGQ3OThjLi5jZDA3YmM0ZTU5NWYgMTAwNjQ0DQo+PiAtLS0gYS9h
cmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+PiArKysgYi9hcmNoL3g4Ni9rdm0vbW11L21tdS5jDQo+
PiBAQCAtMzM4NCw2ICszMzg0LDM1IEBAIHN0YXRpYyBpbnQga3ZtX2hhbmRsZV9iYWRfcGFnZShz
dHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGdmbl90IGdmbiwga3ZtX3Bmbl90IHBmbikNCj4+IAlyZXR1
cm4gLUVGQVVMVDsNCj4+IH0NCj4+IA0KPj4gK3N0YXRpYyBib29sIHBmbl9pc19odWdlX21hcHBl
ZChzdHJ1Y3Qga3ZtICprdm0sIGdmbl90IGdmbiwga3ZtX3Bmbl90IHBmbikNCj4+ICt7DQo+PiAr
CXN0cnVjdCBwYWdlICpwYWdlID0gcGZuX3RvX3BhZ2UocGZuKTsNCj4+ICsJdW5zaWduZWQgbG9u
ZyBodmE7DQo+PiArDQo+PiArCWlmICghaXNfem9uZV9kZXZpY2VfcGFnZShwYWdlKSkNCj4+ICsJ
CXJldHVybiBQYWdlVHJhbnNDb21wb3VuZE1hcChwYWdlKTsNCj4+ICsNCj4+ICsJLyoNCj4+ICsJ
ICogREFYIHBhZ2VzIGRvIG5vdCB1c2UgY29tcG91bmQgcGFnZXMuICBUaGUgcGFnZSBzaG91bGQg
aGF2ZSBhbHJlYWR5DQo+PiArCSAqIGJlZW4gbWFwcGVkIGludG8gdGhlIGhvc3Qtc2lkZSBwYWdl
IHRhYmxlIGR1cmluZyB0cnlfYXN5bmNfcGYoKSwgc28NCj4+ICsJICogd2UgY2FuIGNoZWNrIHRo
ZSBwYWdlIHRhYmxlcyBkaXJlY3RseS4NCj4+ICsJICovDQo+PiArCWh2YSA9IGdmbl90b19odmEo
a3ZtLCBnZm4pOw0KPj4gKwlpZiAoa3ZtX2lzX2Vycm9yX2h2YShodmEpKQ0KPj4gKwkJcmV0dXJu
IGZhbHNlOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBPdXIgY2FsbGVyIGdyYWJiZWQgdGhlIEtW
TSBtbXVfbG9jayB3aXRoIGEgc3VjY2Vzc2Z1bA0KPj4gKwkgKiBtbXVfbm90aWZpZXJfcmV0cnks
IHNvIHdlJ3JlIHNhZmUgdG8gd2FsayB0aGUgcGFnZSB0YWJsZS4NCj4+ICsJICovDQo+PiArCXN3
aXRjaCAoZGV2X3BhZ2VtYXBfbWFwcGluZ19zaGlmdChodmEsIGN1cnJlbnQtPm1tKSkgew0KPj4g
KwljYXNlIFBNRF9TSElGVDoNCj4+ICsJY2FzZSBQVURfU0laRToNCj4gDQo+IEkgYXNzdW1lIHRo
aXMgbWVhbnMgREFYIGNhbiBoYXZlIDFHQiBwYWdlcz8gIEkgYXNrIGJlY2F1c2UgS1ZNJ3MgVEhQ
IGxvZ2ljDQo+IGhhcyBoaXN0b3JpY2FsbHkgcmVsaWVkIG9uIFRIUCBvbmx5IHN1cHBvcnRpbmcg
Mk1CLiAgSSBjbGVhbmVkIHRoaXMgdXAgaW4NCj4gYSByZWNlbnQgc2VyaWVzWypdLCB3aGljaCBp
cyBpbiBrdm0vcXVldWUsIGJ1dCBJIG9idmlvdXNseSBkaWRuJ3QgYWN0dWFsbHkNCj4gdGVzdCB3
aGV0aGVyIG9yIG5vdCBLVk0gd291bGQgY29ycmVjdGx5IGhhbmRsZSAxR0Igbm9uLWh1Z2V0bGJm
cyBwYWdlcy4NCg0KS1ZNIGRvZXNu4oCZdCBoYW5kbGUgMUdCIGNvcnJlY3RseSBmb3IgYWxsIHR5
cGVzIG9mIG5vbi1odWdldGxiZnMgcGFnZXMuDQpPbmUgZXhhbXBsZSB3ZSBoYXZlIG5vdGljZWQg
aW50ZXJuYWxseSBidXQgaGF2ZW7igJl0IHN1Ym1pdHRlZCBhbiB1cHN0cmVhbSBwYXRjaCB5ZXQg
aXMNCmZvciBwYWdlcyB3aXRob3V0IOKAnHN0cnVjdCBwYWdl4oCdLiBBcyBpbiB0aGlzIGNhc2Us
IGh2YV90b19wZm4oKSB3aWxsIG5vdGljZSB2bWEtPnZtX2ZsYWdzIGhhdmUgVk1fUEZOTUFQIHNl
dA0KYW5kIGNhbGwgaHZhX3RvX3Bmbl9yZW1hcHBlZCgpIC0+IGZvbGxvd19wZm4oKS4NCkhvd2V2
ZXIsIGZvbGxvd19wZm4oKSBjdXJyZW50bHkganVzdCBjYWxscyBmb2xsb3dfcHRlKCkgd2hpY2gg
dXNlIF9fZm9sbG93X3B0ZV9wbWQoKSB0aGF0IGRvZXNu4oCZdCBoYW5kbGUgYSBodWdlIFBVRCBl
bnRyeS4NCg0KPiANCj4gVGhlIGVhc2llc3QgdGhpbmcgaXMgcHJvYmFibHkgdG8gcmViYXNlIG9u
IGt2bS9xdWV1ZS4gIFlvdSdsbCBuZWVkIHRvIGRvDQo+IHRoYXQgYW55d2F5cywgYW5kIEkgc3Vz
cGVjdCBkb2luZyBzbyB3aWxsIGhlbHAgc2hha2Ugb3V0IGFueSBoaWNjdXBzLg0KPiANCj4gWypd
IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbGtt
bC5rZXJuZWwub3JnX3JfMjAxOTEyMDYyMzU3MjkuMjkyNjMtMkQxLTJEc2Vhbi5qLmNocmlzdG9w
aGVyc29uLTQwaW50ZWwuY29tJmQ9RHdJQkFnJmM9Um9QMVl1bUNYQ2dhV0h2bFpZUjhQWmg4QnY3
cUlyTVVCNjVlYXBJX0puRSZyPUprNlE4bk56a1E2TEo2ZzQycUFSa2c2cnlJREdRci15S1hQTkda
YnBUeDAmbT1May1QWEUxMjVXVTNHV0pPVjRVNGNyc1NFRng3ZjVBVW1SSmhrcmZJZUFFJnM9Qklv
NHRuTDRPZnN3UlEyUUtmVHM5VllTY0xVNWxCeTJwd3plUEJuSG93OCZlPSANCj4gDQo+PiArCQly
ZXR1cm4gdHJ1ZTsNCj4+ICsJfQ0KPj4gKwlyZXR1cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0KPj4g
c3RhdGljIHZvaWQgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBrdm1fdmNwdSAq
dmNwdSwNCj4+IAkJCQkJZ2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgKnBmbnAsDQo+PiAJCQkJCWludCAq
bGV2ZWxwKQ0KPj4gQEAgLTMzOTgsOCArMzQyNyw4IEBAIHN0YXRpYyB2b2lkIHRyYW5zcGFyZW50
X2h1Z2VwYWdlX2FkanVzdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQo+PiAJICogaGVyZS4NCj4+
IAkgKi8NCj4+IAlpZiAoIWlzX2Vycm9yX25vc2xvdF9wZm4ocGZuKSAmJiAha3ZtX2lzX3Jlc2Vy
dmVkX3BmbihwZm4pICYmDQo+PiAtCSAgICAha3ZtX2lzX3pvbmVfZGV2aWNlX3BmbihwZm4pICYm
IGxldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwgJiYNCj4+IC0JICAgIFBhZ2VUcmFuc0NvbXBv
dW5kTWFwKHBmbl90b19wYWdlKHBmbikpICYmDQo+PiArCSAgICBsZXZlbCA9PSBQVF9QQUdFX1RB
QkxFX0xFVkVMICYmDQo+PiArCSAgICBwZm5faXNfaHVnZV9tYXBwZWQodmNwdS0+a3ZtLCBnZm4s
IHBmbikgJiYNCj4+IAkgICAgIW1tdV9nZm5fbHBhZ2VfaXNfZGlzYWxsb3dlZCh2Y3B1LCBnZm4s
IFBUX0RJUkVDVE9SWV9MRVZFTCkpIHsNCj4+IAkJdW5zaWduZWQgbG9uZyBtYXNrOw0KPj4gCQkv
Kg0KPj4gQEAgLTYwMTUsOCArNjA0NCw3IEBAIHN0YXRpYyBib29sIGt2bV9tbXVfemFwX2NvbGxh
cHNpYmxlX3NwdGUoc3RydWN0IGt2bSAqa3ZtLA0KPj4gCQkgKiBtYXBwaW5nIGlmIHRoZSBpbmRp
cmVjdCBzcCBoYXMgbGV2ZWwgPSAxLg0KPj4gCQkgKi8NCj4+IAkJaWYgKHNwLT5yb2xlLmRpcmVj
dCAmJiAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pICYmDQo+PiAtCQkgICAgIWt2bV9pc196b25l
X2RldmljZV9wZm4ocGZuKSAmJg0KPj4gLQkJICAgIFBhZ2VUcmFuc0NvbXBvdW5kTWFwKHBmbl90
b19wYWdlKHBmbikpKSB7DQo+PiArCQkgICAgcGZuX2lzX2h1Z2VfbWFwcGVkKGt2bSwgc3AtPmdm
biwgcGZuKSkgew0KPj4gCQkJcHRlX2xpc3RfcmVtb3ZlKHJtYXBfaGVhZCwgc3B0ZXApOw0KPj4g
DQo+PiAJCQlpZiAoa3ZtX2F2YWlsYWJsZV9mbHVzaF90bGJfd2l0aF9yYW5nZSgpKQ0KPj4gLS0g
DQo+PiAyLjI0LjAuNTI1Lmc4ZjM2YTM1NGFlLWdvb2cNCj4+IA0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAt
LSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
