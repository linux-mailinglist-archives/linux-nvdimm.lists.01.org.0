Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F282611E946
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 18:34:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1FB2010113697;
	Fri, 13 Dec 2019 09:37:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A4BEE10113694
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 09:37:30 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDHTOdn127556;
	Fri, 13 Dec 2019 17:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=Xxj7XcIX3BAsTswq61qTm+XpYP5WHVykPf5srMGAjkc=;
 b=mAOGIVqWLZik4enG0nrF6/laKdv7t2RczO8djlQtfN1vtwtXeVg2Ju0XmIywCGa/TaDr
 SJijmblW5eEjQAIlrIpNNOmGKKqy38a3v+vzlJZITA3UenYbGsK7tfuLoAk8GhFphcG5
 rZ0zpDqupDJKZNzJ9WTNUnas5KgrJ+u1a0gKdnj6mWBiGmk5c8GPHt/tWC9MEO9ca7CI
 Nc6QgFGbHW8RDcy57OkK/tSvYT0MVJI4AnZSqLs8LNLwfDzbfBcO2mgXfbkrA6fWFdGP
 diPjDj9RxIhedUnkiV0pxMkjK1SO/1FsNXvx9LZwWsKvujwIadKwVR6VK9mIhXurfV/R Ww==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 2wr41qtdeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 17:32:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDHSpew164562;
	Fri, 13 Dec 2019 17:32:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2wvb99gs9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 17:32:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBDHW0Hb004855;
	Fri, 13 Dec 2019 17:32:00 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 13 Dec 2019 09:32:00 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <20191213171950.GA31552@linux.intel.com>
Date: Fri, 13 Dec 2019 19:31:55 +0200
Message-Id: <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130138
Message-ID-Hash: CJHZGI3M6N5ZXIJTSZ35YGQTGLXK5OOY
X-Message-ID-Hash: CJHZGI3M6N5ZXIJTSZ35YGQTGLXK5OOY
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CJHZGI3M6N5ZXIJTSZ35YGQTGLXK5OOY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTMgRGVjIDIwMTksIGF0IDE5OjE5LCBTZWFuIENocmlzdG9waGVyc29uIDxzZWFu
LmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgRGVjIDEz
LCAyMDE5IGF0IDAzOjA3OjMxQU0gKzAyMDAsIExpcmFuIEFsb24gd3JvdGU6DQo+PiANCj4+PiBP
biAxMiBEZWMgMjAxOSwgYXQgMjE6NTUsIEJhcnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4g
d3JvdGU6DQo+Pj4gDQo+Pj4+Pj4gTm90ZSB0aGF0IEtWTSBhbHJlYWR5IGZhdWx0ZWQgaW4gdGhl
IHBhZ2UgKG9yIGh1Z2UgcGFnZSkgaW4gdGhlIGhvc3Qncw0KPj4+Pj4+IHBhZ2UgdGFibGUsIGFu
ZCB3ZSBob2xkIHRoZSBLVk0gbW11IHNwaW5sb2NrLiAgV2UgZ3JhYmJlZCB0aGF0IGxvY2sgaW4N
Cj4+Pj4+PiBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRhdGVfcmFuZ2VfZW5kLCBiZWZvcmUgY2hl
Y2tpbmcgdGhlIG1tdSBzZXEuDQo+Pj4+Pj4gDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQmFycmV0
IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPg0KPj4+Pj4gDQo+Pj4+PiBJIGRvbuKAmXQgdGhpbmsg
dGhlIHJpZ2h0IHBsYWNlIHRvIGNoYW5nZSBmb3IgdGhpcyBmdW5jdGlvbmFsaXR5IGlzDQo+Pj4+
PiB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKSB3aGljaCBpcyBtZWFudCB0byBoYW5kbGUg
UEZOcyB0aGF0IGFyZQ0KPj4+Pj4gbWFwcGVkIGFzIHBhcnQgb2YgYSB0cmFuc3BhcmVudCBodWdl
LXBhZ2UuDQo+Pj4+PiANCj4+Pj4+IEZvciBleGFtcGxlLCB0aGlzIHdvdWxkIHByZXZlbnQgbWFw
cGluZyBEQVgtYmFja2VkIGZpbGUgcGFnZSBhcyAxR0IuICBBcw0KPj4+Pj4gdHJhbnNwYXJlbnRf
aHVnZXBhZ2VfYWRqdXN0KCkgb25seSBoYW5kbGVzIHRoZSBjYXNlIChsZXZlbCA9PQ0KPj4+Pj4g
UFRfUEFHRV9UQUJMRV9MRVZFTCkuDQo+IA0KPiBUZWFjaGluZyB0aHBfYWRqdXN0KCkgaG93IHRv
IGhhbmRsZSAxR0Igd291bGRuJ3QgYmUgYSBiYWQgdGhpbmcuICBJdCdzDQo+IHVubGlrZWx5IFRI
UCBpdHNlbGYgd2lsbCBzdXBwb3J0IDFHQiBwYWdlcyBhbnkgdGltZSBzb29uLCBidXQgaGF2aW5n
IHRoZQ0KPiBsb2dpYyB0aGVyZSB3b3VsZG4ndCBodXJ0IGFueXRoaW5nLg0KDQpJIGFncmVlLg0K
DQo+IA0KPj4+Pj4gQXMgeW91IGFyZSBwYXJzaW5nIHRoZSBwYWdlLXRhYmxlcyB0byBkaXNjb3Zl
ciB0aGUgcGFnZS1zaXplIHRoZSBQRk4gaXMNCj4+Pj4+IG1hcHBlZCBpbiwgSSB0aGluayB5b3Ug
c2hvdWxkIGluc3RlYWQgbW9kaWZ5IGt2bV9ob3N0X3BhZ2Vfc2l6ZSgpIHRvDQo+Pj4+PiBwYXJz
ZSBwYWdlLXRhYmxlcyBpbnN0ZWFkIG9mIHJlbHkgb24gdm1hX2tlcm5lbF9wYWdlc2l6ZSgpIChX
aGljaCByZWxpZXMNCj4+Pj4+IG9uIHZtYS0+dm1fb3BzLT5wYWdlc2l6ZSgpKSBpbiBjYXNlIG9m
IGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4NCj4+Pj4+IA0KPj4+Pj4gVGhlIG1haW4gY29tcGxpY2F0
aW9uIHRob3VnaCBvZiBkb2luZyB0aGlzIGlzIHRoYXQgYXQgdGhpcyBwb2ludCB5b3UNCj4+Pj4+
IGRvbuKAmXQgeWV0IGhhdmUgdGhlIFBGTiB0aGF0IGlzIHJldHJpZXZlZCBieSB0cnlfYXN5bmNf
cGYoKS4gU28gbWF5YmUgeW91DQo+Pj4+PiBzaG91bGQgY29uc2lkZXIgbW9kaWZ5aW5nIHRoZSBv
cmRlciBvZiBjYWxscyBpbiB0ZHBfcGFnZV9mYXVsdCgpICYNCj4+Pj4+IEZOQU1FKHBhZ2VfZmF1
bHQpKCkuDQo+Pj4+PiANCj4+Pj4+IC1MaXJhbg0KPj4+PiBPciBhbHRlcm5hdGl2ZWx5IHdoZW4g
dGhpbmtpbmcgYWJvdXQgaXQgbW9yZSwgbWF5YmUganVzdCByZW5hbWUNCj4+Pj4gdHJhbnNwYXJl
bnRfaHVnZXBhZ2VfYWRqdXN0KCkgdG8gbm90IGJlIHNwZWNpZmljIHRvIFRIUCBhbmQgYmV0dGVy
IGhhbmRsZQ0KPj4+PiB0aGUgY2FzZSBvZiBwYXJzaW5nIHBhZ2UtdGFibGVzIGNoYW5naW5nIG1h
cHBpbmctbGV2ZWwgdG8gMUdCLg0KPj4+PiBUaGF0IGlzIHByb2JhYmx5IGVhc2llciBhbmQgbW9y
ZSBlbGVnYW50Lg0KPiANCj4gQWdyZWVkLg0KPiANCj4+PiBJIGNhbiByZW5hbWUgaXQgdG8gaHVn
ZXBhZ2VfYWRqdXN0KCksIHNpbmNlIGl0J3Mgbm90IGp1c3QgVEhQIGFueW1vcmUuDQo+IA0KPiBP
ciBtYXliZSBhbGxvd2VkX2h1Z2VwYWdlX2FkanVzdCgpPyAgVG8gcGFpciB3aXRoIGRpc2FsbG93
ZWRfaHVnZXBhZ2VfYWRqdXN0KCksDQo+IHdoaWNoIGFkanVzdHMgS1ZNJ3MgcGFnZSBzaXplIGlu
IHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24gdG8gYXZvaWQgdGhlIGlUTEINCj4gbXVsdGktaGl0IGlz
c3VlLg0KPiANCj4+IA0KPj4gU291bmRzIGdvb2QuDQo+PiANCj4+PiANCj4+PiBJIHdhcyBhIGxp
dHRsZSBoZXNpdGFudCB0byBjaGFuZ2UgdGhlIHRoaXMgdG8gaGFuZGxlIDEgR0IgcGFnZXMgd2l0
aCB0aGlzDQo+Pj4gcGF0Y2hzZXQgYXQgZmlyc3QuICBJIGRpZG4ndCB3YW50IHRvIGJyZWFrIHRo
ZSBub24tREFYIGNhc2Ugc3R1ZmYgYnkgZG9pbmcNCj4+PiBzby4NCj4+IA0KPj4gV2h5IHdvdWxk
IGl0IGFmZmVjdCBub24tREFYIGNhc2U/DQo+PiBZb3VyIHBhdGNoIHNob3VsZCBqdXN0IG1ha2Ug
aHVnZXBhZ2VfYWRqdXN0KCkgdG8gcGFyc2UgcGFnZS10YWJsZXMgb25seSBpbiBjYXNlIGlzX3pv
bmVfZGV2aWNlX3BhZ2UoKS4gT3RoZXJ3aXNlLCBwYWdlIHRhYmxlcyBzaG91bGRu4oCZdCBiZSBw
YXJzZWQuDQo+PiBpLmUuIFRIUCBtZXJnZWQgcGFnZXMgc2hvdWxkIHN0aWxsIGJlIGRldGVjdGVk
IGJ5IFBhZ2VUcmFuc0NvbXBvdW5kTWFwKCkuDQo+IA0KPiBJIHRoaW5rIHdoYXQgQmFycmV0IGlz
IHNheWluZyBpcyB0aGF0IHRlYWNoaW5nIHRocF9hZGp1c3QoKSBob3cgdG8gZG8gMWdiDQo+IG1h
cHBpbmdzIHdvdWxkIG5hdHVyYWxseSBhZmZlY3QgdGhlIGNvZGUgcGF0aCBmb3IgVEhQIHBhZ2Vz
LiAgQnV0IEkgYWdyZWUNCj4gdGhhdCBpdCB3b3VsZCBiZSBzdXBlcmZpY2lhbC4NCj4gDQo+Pj4g
U3BlY2lmaWNhbGx5LCBjYW4gYSBUSFAgcGFnZSBiZSAxIEdCLCBhbmQgaWYgc28sIGhvdyBjYW4g
eW91IHRlbGw/ICBJZiB5b3UNCj4+PiBjYW4ndCB0ZWxsIGVhc2lseSwgSSBjb3VsZCB3YWxrIHRo
ZSBwYWdlIHRhYmxlIGZvciBhbGwgY2FzZXMsIGluc3RlYWQgb2YNCj4+PiBqdXN0IHpvbmVfZGV2
aWNlKCkuDQo+IA0KPiBObywgVEhQIGRvZXNuJ3QgY3VycmVudGx5IHN1cHBvcnQgMWdiIHBhZ2Vz
LiAgRXhwbGljaXRpbmcgcmV0dXJuaW5nDQo+IFBNRF9TSVpFIG9uIFBhZ2VUcmFuc0NvbXBvdW5k
TWFwKCkgd291bGQgYmUgYSBnb29kIHRoaW5nIGZyb20gYSByZWFkYWJpbGl0eQ0KPiBwZXJzcGVj
dGl2ZS4NCg0KUmlnaHQuDQoNCj4gDQo+PiBJIHByZWZlciB0byB3YWxrIHBhZ2UtdGFibGVzIG9u
bHkgZm9yIGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4NCj4+IA0KPj4+IA0KPj4+IEknZCBhbHNvIGhh
dmUgdG8gZHJvcCB0aGUgImxldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwiIGNoZWNrLCBJIHRo
aW5rLA0KPj4+IHdoaWNoIHdvdWxkIG9wZW4gdGhpcyB1cCB0byBodWdldGxiZnMgcGFnZXMgKGJh
c2VkIG9uIHRoZSBjb21tZW50cykuICBJcw0KPj4+IHRoZXJlIGFueSByZWFzb24gd2h5IHRoYXQg
d291bGQgYmUgYSBiYWQgaWRlYT8NCj4gDQo+IE5vLCB0aGUgImxldmVsID09IFBUX1BBR0VfVEFC
TEVfTEVWRUwiIGNoZWNrIGlzIHRvIGZpbHRlciBvdXQgdGhlIGNhc2UNCj4gd2hlcmUgS1ZNIGlz
IGFscmVhZHkgcGxhbm5pbmcgb24gdXNpbmcgYSBsYXJnZSBwYWdlLCBlLmcuIHdoZW4gdGhlIG1l
bW9yeQ0KPiBpcyBiYWNrZWQgYnkgaHVnZXRsYnMuDQoNClJpZ2h0Lg0KDQo+IA0KPj4gS1ZNIGFs
cmVhZHkgc3VwcG9ydHMgbWFwcGluZyAxR0IgaHVnZXRsYmZzIHBhZ2VzLiBBcyBsZXZlbCBpcyBz
ZXQgdG8NCj4+IFBVRC1sZXZlbCBieQ0KPj4gdGRwX3BhZ2VfZmF1bHQoKS0+bWFwcGluZ19sZXZl
bCgpLT5ob3N0X21hcHBpbmdfbGV2ZWwoKS0+a3ZtX2hvc3RfcGFnZV9zaXplKCktPnZtYV9rZXJu
ZWxfcGFnZXNpemUoKS4NCj4+IEFzIFZNQSB3aGljaCBpcyBtbWFwIG9mIGh1Z2V0bGJmcyBzZXRz
IHZtYS0+dm1fb3BzIHRvIGh1Z2V0bGJfdm1fb3BzKCkgd2hlcmUNCj4+IGh1Z2V0bGJfdm1fb3Bf
cGFnZXNpemUoKSB3aWxsIHJldHVybiBhcHByb3ByaWF0ZSBwYWdlLXNpemUuDQo+PiANCj4+IFNw
ZWNpZmljYWxseSwgSSBkb27igJl0IHRoaW5rIFRIUCBldmVyIG1lcmdlcyBzbWFsbCBwYWdlcyB0
byAxR0IgcGFnZXMuIEkgdGhpbmsNCj4+IHRoaXMgaXMgd2h5IHRyYW5zcGFyZW50X2h1Z2VwYWdl
X2FkanVzdCgpIGNoZWNrcyBQYWdlVHJhbnNDb21wb3VuZE1hcCgpIG9ubHkNCj4+IGluIGNhc2Ug
bGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTC4gSSB0aGluayB5b3Ugc2hvdWxkIGtlZXAgdGhp
cyBjaGVjayBpbg0KPj4gdGhlIGNhc2Ugb2YgIWlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4NCj4gDQo+
IEkgd291bGQgYWRkIDFnYiBzdXBwb3J0IGZvciBEQVggYXMgYSB0aGlyZCBwYXRjaCBpbiB0aGlz
IHNlcmllcy4gIFRvIHBhdmUNCj4gdGhlIHdheSBpbiBwYXRjaCAyLzIsIGNoYW5nZSBpdCB0byBy
ZXBsYWNlICJib29sIHBmbl9pc19odWdlX21hcHBlZCgpIiB3aXRoDQo+ICJpbnQgaG9zdF9wZm5f
bWFwcGluZ19sZXZlbCgpIiwgYW5kIG1heWJlIGFsc28gcmVuYW1pbmcgaG9zdF9tYXBwaW5nX2xl
dmVsKCkNCj4gdG8gaG9zdF92bWFfbWFwcGluZ19sZXZlbCgpIHRvIGF2b2lkIGNvbmZ1c2lvbi4N
Cg0KSSBhZ3JlZS4NClNvIGFsc28gcmVuYW1lIGt2bV9ob3N0X3BhZ2Vfc2l6ZSgpIHRvIGt2bV9o
b3N0X3ZtYV9wYWdlX3NpemUoKSA6KQ0KDQo+IA0KPiBUaGVuIGFsbG93ZWRfaHVnZXBhZ2VfYWRq
dXN0KCkgd291bGQgbG9vayBzb21ldGhpbmcgbGlrZToNCj4gDQo+IHN0YXRpYyB2b2lkIGFsbG93
ZWRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLA0KPiAJ
CQkJICAgIGt2bV9wZm5fdCAqcGZucCwgaW50ICpsZXZlbHAsIGludCBtYXhfbGV2ZWwpDQo+IHsN
Cj4gCWt2bV9wZm5fdCBwZm4gPSAqcGZucDsNCj4gCWludCBsZXZlbCA9ICpsZXZlbHA7CQ0KPiAJ
dW5zaWduZWQgbG9uZyBtYXNrOw0KPiANCj4gCWlmIChpc19lcnJvcl9ub3Nsb3RfcGZuKHBmbikg
fHwgIWt2bV9pc19yZXNlcnZlZF9wZm4ocGZuKSB8fA0KPiAJICAgIGxldmVsID09IFBUX1BBR0Vf
VEFCTEVfTEVWRUwpDQo+IAkJcmV0dXJuOw0KPiANCj4gCS8qDQo+IAkgKiBtbXVfbm90aWZpZXJf
cmV0cnkoKSB3YXMgc3VjY2Vzc2Z1bCBhbmQgbW11X2xvY2sgaXMgaGVsZCwgc28NCj4gCSAqIHRo
ZSBwbWQvcHVkIGNhbid0IGJlIHNwbGl0IGZyb20gdW5kZXIgdXMuDQo+IAkgKi8NCj4gCWxldmVs
ID0gaG9zdF9wZm5fbWFwcGluZ19sZXZlbCh2Y3B1LT5rdm0sIGdmbiwgcGZuKTsNCj4gDQo+IAkq
bGV2ZWxwID0gbGV2ZWwgPSBtaW4obGV2ZWwsIG1heF9sZXZlbCk7DQo+IAltYXNrID0gS1ZNX1BB
R0VTX1BFUl9IUEFHRShsZXZlbCkgLSAxOw0KPiAJVk1fQlVHX09OKChnZm4gJiBtYXNrKSAhPSAo
cGZuICYgbWFzaykpOw0KPiAJKnBmbnAgPSBwZm4gJiB+bWFzazsNCg0KV2h5IGRvbuKAmXQgeW91
IHN0aWxsIG5lZWQgdG8ga3ZtX3JlbGVhc2VfcGZuX2NsZWFuKCkgZm9yIG9yaWdpbmFsIHBmbiBh
bmQga3ZtX2dldF9wZm4oKSBmb3IgbmV3IGh1Z2UtcGFnZSBzdGFydCBwZm4/DQoNCj4gfQ0KDQpZ
ZXAuIFRoaXMgaXMgc2ltaWxhciB0byB3aGF0IEkgaGFkIGluIG1pbmQuDQoNClRoZW4ganVzdCBw
dXQgbG9naWMgb2YgcGFyc2luZyBwYWdlLXRhYmxlcyBpbiBjYXNlIGl04oCZcyBpc196b25lX2Rl
dmljZV9wYWdlKCkgb3IgcmV0dXJuaW5nIFBNRF9TSVpFIGluIGNhc2UgaXTigJlzIFBhZ2VUcmFu
c0NvbXBvdW5kTWFwKCkgaW5zaWRlIGhvc3RfcGZuX21hcHBpbmdfbGV2ZWwoKS4gVGhpcyBtYWtl
IGNvZGUgdmVyeSBzdHJhaWdodC1mb3J3YXJkLg0KDQotTGlyYW4NCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
