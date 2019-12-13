Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83511DB7C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 02:07:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 89D791011367D;
	Thu, 12 Dec 2019 17:11:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 486471011367C
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 17:11:10 -0800 (PST)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD10G36157971;
	Fri, 13 Dec 2019 01:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=fPXd9WaeWO8tk1E5p/rW9kWN/nN6E2zMrMlpS1GApvM=;
 b=Lul6uFIQmVMejmPBkKC+64VmVUFgk3do7OzMsTJ5C96n59vuXWwlbqn4jLU4EiLT1YAO
 3ILQ7QLF6j7Kf3CBUM+lhP03mt9gaBU+UI7tE0q6ZJSOnChOnfbEo0SuRauhwm+v6LQp
 aHkb1VPX2NQFWYVoYLE5RotbxnH4VdNuHmPe/sgtFjEgR9vSCxtM3qLhghVArn75fWiP
 4AYiRaHSTQAbiphHgwDuGn05de24o91F7u2RTj8ACjfUF9udgLuUGJQsmmIf0ZdIv9Q8
 CrGWw89UTd+aj2hktSYdAKrlXF0w8lqef8WaFvJyahx3/WYlPq/EmoT/QUB6M2GP/R3t 3w==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 2wr41qpc3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 01:07:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBD13odI061658;
	Fri, 13 Dec 2019 01:07:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 2wumk72qr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2019 01:07:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBD17bd5024770;
	Fri, 13 Dec 2019 01:07:37 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 17:07:36 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
Date: Fri, 13 Dec 2019 03:07:31 +0200
Message-Id: <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
To: Barret Rhoden <brho@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130006
Message-ID-Hash: GU3JHOC7XY5JHQBE2UCPDO3Y46G2KZJX
X-Message-ID-Hash: GU3JHOC7XY5JHQBE2UCPDO3Y46G2KZJX
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GU3JHOC7XY5JHQBE2UCPDO3Y46G2KZJX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDIxOjU1LCBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2ds
ZS5jb20+IHdyb3RlOg0KPiANCj4gSGkgLQ0KPiANCj4gT24gMTIvMTIvMTkgMTo0OSBQTSwgTGly
YW4gQWxvbiB3cm90ZToNCj4+PiBPbiAxMiBEZWMgMjAxOSwgYXQgMjA6NDcsIExpcmFuIEFsb24g
PGxpcmFuLmFsb25Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+IE9u
IDEyIERlYyAyMDE5LCBhdCAyMDoyMiwgQmFycmV0IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPiB3
cm90ZToNCj4+Pj4gDQo+Pj4+IFRoaXMgY2hhbmdlIGFsbG93cyBLVk0gdG8gbWFwIERBWC1iYWNr
ZWQgZmlsZXMgbWFkZSBvZiBodWdlIHBhZ2VzIHdpdGgNCj4+Pj4gaHVnZSBtYXBwaW5ncyBpbiB0
aGUgRVBUL1REUC4NCj4+PiANCj4+PiBUaGlzIGNoYW5nZSBpc27igJl0IG9ubHkgcmVsZXZhbnQg
Zm9yIFREUC4gSXQgYWxzbyBhZmZlY3RzIHdoZW4gS1ZNIHVzZSBzaGFkb3ctcGFnaW5nLg0KPj4+
IFNlZSBob3cgRk5BTUUocGFnZV9mYXVsdCkoKSBjYWxscyB0cmFuc3BhcmVudF9odWdlcGFnZV9h
ZGp1c3QoKS4NCj4gDQo+IENvb2wsIEknbGwgZHJvcCByZWZlcmVuY2VzIHRvIHRoZSBFUFQvVERQ
IGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4+Pj4gREFYIHBhZ2VzIGFyZSBub3QgUGFn
ZVRyYW5zQ29tcG91bmQuICBUaGUgZXhpc3RpbmcgY2hlY2sgaXMgdHJ5aW5nIHRvDQo+Pj4+IGRl
dGVybWluZSBpZiB0aGUgbWFwcGluZyBmb3IgdGhlIHBmbiBpcyBhIGh1Z2UgbWFwcGluZyBvciBu
b3QuDQo+Pj4gDQo+Pj4gSSB3b3VsZCByZXBocmFzZSDigJxUaGUgZXhpc3RpbmcgY2hlY2sgaXMg
dHJ5aW5nIHRvIGRldGVybWluZSBpZiB0aGUgcGZuDQo+Pj4gaXMgbWFwcGVkIGFzIHBhcnQgb2Yg
YSB0cmFuc3BhcmVudCBodWdlLXBhZ2XigJ0uDQo+IA0KPiBDYW4gZG8uDQo+IA0KPj4+IA0KPj4+
PiBGb3INCj4+Pj4gbm9uLURBWCBtYXBzLCBlLmcuIGh1Z2V0bGJmcywgdGhhdCBtZWFucyBjaGVj
a2luZyBQYWdlVHJhbnNDb21wb3VuZC4NCj4+PiANCj4+PiBUaGlzIGlzIG5vdCByZWxhdGVkIHRv
IGh1Z2V0bGJmcyBidXQgcmF0aGVyIFRIUC4NCj4gDQo+IEkgdGhvdWdodCB0aGF0IFBhZ2VUcmFu
c0NvbXBvdW5kIGFsc28gcmV0dXJuZWQgdHJ1ZSBmb3IgaHVnZXRsYmZzIChiYXNlZCBvZmYgb2Yg
Y29tbWVudHMgaW4gcGFnZS1mbGFncy5oKS4gIFRob3VnaCBJIGRvIHNlZSB0aGUgY29tbWVudCBh
Ym91dCB0aGUgJ2xldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwnIGNoZWNrIGV4Y2x1ZGluZyBo
dWdldGxiZnMgcGFnZXMuDQo+IA0KPiBBbnl3YXksIEknbGwgcmVtb3ZlIHRoZSAiZS5nLiBodWdl
dGxiZnMiIGZyb20gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4+PiANCj4+Pj4gRm9yIERBWCwg
d2UgY2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlIGl0c2VsZi4NCj4+Pj4gDQo+Pj4+IE5vdGUgdGhh
dCBLVk0gYWxyZWFkeSBmYXVsdGVkIGluIHRoZSBwYWdlIChvciBodWdlIHBhZ2UpIGluIHRoZSBo
b3N0J3MNCj4+Pj4gcGFnZSB0YWJsZSwgYW5kIHdlIGhvbGQgdGhlIEtWTSBtbXUgc3BpbmxvY2su
ICBXZSBncmFiYmVkIHRoYXQgbG9jayBpbg0KPj4+PiBrdm1fbW11X25vdGlmaWVyX2ludmFsaWRh
dGVfcmFuZ2VfZW5kLCBiZWZvcmUgY2hlY2tpbmcgdGhlIG1tdSBzZXEuDQo+Pj4+IA0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+DQo+Pj4gDQo+Pj4g
SSBkb27igJl0IHRoaW5rIHRoZSByaWdodCBwbGFjZSB0byBjaGFuZ2UgZm9yIHRoaXMgZnVuY3Rp
b25hbGl0eSBpcyB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKQ0KPj4+IHdoaWNoIGlzIG1l
YW50IHRvIGhhbmRsZSBQRk5zIHRoYXQgYXJlIG1hcHBlZCBhcyBwYXJ0IG9mIGEgdHJhbnNwYXJl
bnQgaHVnZS1wYWdlLg0KPj4+IA0KPj4+IEZvciBleGFtcGxlLCB0aGlzIHdvdWxkIHByZXZlbnQg
bWFwcGluZyBEQVgtYmFja2VkIGZpbGUgcGFnZSBhcyAxR0IuDQo+Pj4gQXMgdHJhbnNwYXJlbnRf
aHVnZXBhZ2VfYWRqdXN0KCkgb25seSBoYW5kbGVzIHRoZSBjYXNlIChsZXZlbCA9PSBQVF9QQUdF
X1RBQkxFX0xFVkVMKS4NCj4+PiANCj4+PiBBcyB5b3UgYXJlIHBhcnNpbmcgdGhlIHBhZ2UtdGFi
bGVzIHRvIGRpc2NvdmVyIHRoZSBwYWdlLXNpemUgdGhlIFBGTiBpcyBtYXBwZWQgaW4sDQo+Pj4g
SSB0aGluayB5b3Ugc2hvdWxkIGluc3RlYWQgbW9kaWZ5IGt2bV9ob3N0X3BhZ2Vfc2l6ZSgpIHRv
IHBhcnNlIHBhZ2UtdGFibGVzIGluc3RlYWQNCj4+PiBvZiByZWx5IG9uIHZtYV9rZXJuZWxfcGFn
ZXNpemUoKSAoV2hpY2ggcmVsaWVzIG9uIHZtYS0+dm1fb3BzLT5wYWdlc2l6ZSgpKSBpbiBjYXNl
DQo+Pj4gb2YgaXNfem9uZV9kZXZpY2VfcGFnZSgpLg0KPj4+IFRoZSBtYWluIGNvbXBsaWNhdGlv
biB0aG91Z2ggb2YgZG9pbmcgdGhpcyBpcyB0aGF0IGF0IHRoaXMgcG9pbnQgeW91IGRvbuKAmXQg
eWV0IGhhdmUgdGhlIFBGTg0KPj4+IHRoYXQgaXMgcmV0cmlldmVkIGJ5IHRyeV9hc3luY19wZigp
LiBTbyBtYXliZSB5b3Ugc2hvdWxkIGNvbnNpZGVyIG1vZGlmeWluZyB0aGUgb3JkZXIgb2YgY2Fs
bHMNCj4+PiBpbiB0ZHBfcGFnZV9mYXVsdCgpICYgRk5BTUUocGFnZV9mYXVsdCkoKS4NCj4+PiAN
Cj4+PiAtTGlyYW4NCj4+IE9yIGFsdGVybmF0aXZlbHkgd2hlbiB0aGlua2luZyBhYm91dCBpdCBt
b3JlLCBtYXliZSBqdXN0IHJlbmFtZSB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKQ0KPj4g
dG8gbm90IGJlIHNwZWNpZmljIHRvIFRIUCBhbmQgYmV0dGVyIGhhbmRsZSB0aGUgY2FzZSBvZiBw
YXJzaW5nIHBhZ2UtdGFibGVzIGNoYW5naW5nIG1hcHBpbmctbGV2ZWwgdG8gMUdCLg0KPj4gVGhh
dCBpcyBwcm9iYWJseSBlYXNpZXIgYW5kIG1vcmUgZWxlZ2FudC4NCj4gDQo+IEkgY2FuIHJlbmFt
ZSBpdCB0byBodWdlcGFnZV9hZGp1c3QoKSwgc2luY2UgaXQncyBub3QganVzdCBUSFAgYW55bW9y
ZS4NCg0KU291bmRzIGdvb2QuDQoNCj4gDQo+IEkgd2FzIGEgbGl0dGxlIGhlc2l0YW50IHRvIGNo
YW5nZSB0aGUgdGhpcyB0byBoYW5kbGUgMSBHQiBwYWdlcyB3aXRoIHRoaXMgcGF0Y2hzZXQgYXQg
Zmlyc3QuICBJIGRpZG4ndCB3YW50IHRvIGJyZWFrIHRoZSBub24tREFYIGNhc2Ugc3R1ZmYgYnkg
ZG9pbmcgc28uDQoNCldoeSB3b3VsZCBpdCBhZmZlY3Qgbm9uLURBWCBjYXNlPw0KWW91ciBwYXRj
aCBzaG91bGQganVzdCBtYWtlIGh1Z2VwYWdlX2FkanVzdCgpIHRvIHBhcnNlIHBhZ2UtdGFibGVz
IG9ubHkgaW4gY2FzZSBpc196b25lX2RldmljZV9wYWdlKCkuIE90aGVyd2lzZSwgcGFnZSB0YWJs
ZXMgc2hvdWxkbuKAmXQgYmUgcGFyc2VkLg0KaS5lLiBUSFAgbWVyZ2VkIHBhZ2VzIHNob3VsZCBz
dGlsbCBiZSBkZXRlY3RlZCBieSBQYWdlVHJhbnNDb21wb3VuZE1hcCgpLg0KDQo+IA0KPiBTcGVj
aWZpY2FsbHksIGNhbiBhIFRIUCBwYWdlIGJlIDEgR0IsIGFuZCBpZiBzbywgaG93IGNhbiB5b3Ug
dGVsbD8gIElmIHlvdSBjYW4ndCB0ZWxsIGVhc2lseSwgSSBjb3VsZCB3YWxrIHRoZSBwYWdlIHRh
YmxlIGZvciBhbGwgY2FzZXMsIGluc3RlYWQgb2YganVzdCB6b25lX2RldmljZSgpLg0KDQpJIHBy
ZWZlciB0byB3YWxrIHBhZ2UtdGFibGVzIG9ubHkgZm9yIGlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4N
Cg0KPiANCj4gSSdkIGFsc28gaGF2ZSB0byBkcm9wIHRoZSAibGV2ZWwgPT0gUFRfUEFHRV9UQUJM
RV9MRVZFTCIgY2hlY2ssIEkgdGhpbmssIHdoaWNoIHdvdWxkIG9wZW4gdGhpcyB1cCB0byBodWdl
dGxiZnMgcGFnZXMgKGJhc2VkIG9uIHRoZSBjb21tZW50cykuICBJcyB0aGVyZSBhbnkgcmVhc29u
IHdoeSB0aGF0IHdvdWxkIGJlIGEgYmFkIGlkZWE/DQoNCktWTSBhbHJlYWR5IHN1cHBvcnRzIG1h
cHBpbmcgMUdCIGh1Z2V0bGJmcyBwYWdlcy4gQXMgbGV2ZWwgaXMgc2V0IHRvIFBVRC1sZXZlbCBi
eSB0ZHBfcGFnZV9mYXVsdCgpLT5tYXBwaW5nX2xldmVsKCktPmhvc3RfbWFwcGluZ19sZXZlbCgp
LT5rdm1faG9zdF9wYWdlX3NpemUoKS0+dm1hX2tlcm5lbF9wYWdlc2l6ZSgpLiBBcyBWTUEgd2hp
Y2ggaXMgbW1hcCBvZiBodWdldGxiZnMgc2V0cyB2bWEtPnZtX29wcyB0byBodWdldGxiX3ZtX29w
cygpIHdoZXJlIGh1Z2V0bGJfdm1fb3BfcGFnZXNpemUoKSB3aWxsIHJldHVybiBhcHByb3ByaWF0
ZSBwYWdlLXNpemUuDQoNClNwZWNpZmljYWxseSwgSSBkb27igJl0IHRoaW5rIFRIUCBldmVyIG1l
cmdlcyBzbWFsbCBwYWdlcyB0byAxR0IgcGFnZXMuIEkgdGhpbmsgdGhpcyBpcyB3aHkgdHJhbnNw
YXJlbnRfaHVnZXBhZ2VfYWRqdXN0KCkgY2hlY2tzIFBhZ2VUcmFuc0NvbXBvdW5kTWFwKCkgb25s
eSBpbiBjYXNlIGxldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwuIEkgdGhpbmsgeW91IHNob3Vs
ZCBrZWVwIHRoaXMgY2hlY2sgaW4gdGhlIGNhc2Ugb2YgIWlzX3pvbmVfZGV2aWNlX3BhZ2UoKS4N
Cg0KLUxpcmFuDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnJldA0KPiANCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
