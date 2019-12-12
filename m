Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394111D642
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 19:51:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B285710113674;
	Thu, 12 Dec 2019 10:54:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=liran.alon@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C5A4310113672
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:54:44 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCInQ2N071249;
	Thu, 12 Dec 2019 18:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=zaKIVHYYQNYvdMbmkRZGkWLw1vkdwvczrml95DtTJAY=;
 b=XwzJ2fiZ/H6sRv26zjzMBqb3PduV1kwp19YMd2Q8A5BYL3kZtD1/DHph5L4EFEAzt5nF
 ur59alOYzAKyd2qzbopbMwdclz1eeGufSx4SUJj+kltObp02f3880J53RuFPEvVdmWsJ
 W+FJIT4RYh89zg3QZ1Ul+CtUbmMSeaWKxXpJNikqkFRFrfnl2XmOqvKvHqORsZq3LX24
 2lg9hceviEG1xwbriNl0b4eJm6HeSPXd/BZA0LiA9qHBC6BbPW+KKtuRESJBPNErXTdM
 tz/7rJpCg2IiGhuYL7BQR6jrdlMNPIZd/bX1l1CC1HRdKcVgbKPNwE0v8kjjXH0R7bcK 7g==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 2wr4qrvu6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:51:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBCInqlB097689;
	Thu, 12 Dec 2019 18:51:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 2wumk6mu80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2019 18:51:18 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBCIpGOF018385;
	Thu, 12 Dec 2019 18:51:17 GMT
Received: from [192.168.14.112] (/109.65.223.49)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 12 Dec 2019 10:49:57 -0800
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
From: Liran Alon <liran.alon@oracle.com>
In-Reply-To: <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
Date: Thu, 12 Dec 2019 20:49:52 +0200
Message-Id: <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
To: Barret Rhoden <brho@google.com>
X-Mailer: Apple Mail (2.3445.4.7)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912120144
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9469 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912120144
Message-ID-Hash: UOJCSCSX2S6XLKCMUJ2APMYE26JIN5SW
X-Message-ID-Hash: UOJCSCSX2S6XLKCMUJ2APMYE26JIN5SW
X-MailFrom: liran.alon@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, Sean Christopherson <sean.j.christopherson@intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UOJCSCSX2S6XLKCMUJ2APMYE26JIN5SW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gMTIgRGVjIDIwMTksIGF0IDIwOjQ3LCBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9y
YWNsZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMTIgRGVjIDIwMTksIGF0IDIwOjIy
LCBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+IHdyb3RlOg0KPj4gDQo+PiBUaGlzIGNo
YW5nZSBhbGxvd3MgS1ZNIHRvIG1hcCBEQVgtYmFja2VkIGZpbGVzIG1hZGUgb2YgaHVnZSBwYWdl
cyB3aXRoDQo+PiBodWdlIG1hcHBpbmdzIGluIHRoZSBFUFQvVERQLg0KPiANCj4gVGhpcyBjaGFu
Z2UgaXNu4oCZdCBvbmx5IHJlbGV2YW50IGZvciBURFAuIEl0IGFsc28gYWZmZWN0cyB3aGVuIEtW
TSB1c2Ugc2hhZG93LXBhZ2luZy4NCj4gU2VlIGhvdyBGTkFNRShwYWdlX2ZhdWx0KSgpIGNhbGxz
IHRyYW5zcGFyZW50X2h1Z2VwYWdlX2FkanVzdCgpLg0KPiANCj4+IA0KPj4gREFYIHBhZ2VzIGFy
ZSBub3QgUGFnZVRyYW5zQ29tcG91bmQuICBUaGUgZXhpc3RpbmcgY2hlY2sgaXMgdHJ5aW5nIHRv
DQo+PiBkZXRlcm1pbmUgaWYgdGhlIG1hcHBpbmcgZm9yIHRoZSBwZm4gaXMgYSBodWdlIG1hcHBp
bmcgb3Igbm90Lg0KPiANCj4gSSB3b3VsZCByZXBocmFzZSDigJxUaGUgZXhpc3RpbmcgY2hlY2sg
aXMgdHJ5aW5nIHRvIGRldGVybWluZSBpZiB0aGUgcGZuDQo+IGlzIG1hcHBlZCBhcyBwYXJ0IG9m
IGEgdHJhbnNwYXJlbnQgaHVnZS1wYWdl4oCdLg0KPiANCj4+IEZvcg0KPj4gbm9uLURBWCBtYXBz
LCBlLmcuIGh1Z2V0bGJmcywgdGhhdCBtZWFucyBjaGVja2luZyBQYWdlVHJhbnNDb21wb3VuZC4N
Cj4gDQo+IFRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gaHVnZXRsYmZzIGJ1dCByYXRoZXIgVEhQLg0K
PiANCj4+IEZvciBEQVgsIHdlIGNhbiBjaGVjayB0aGUgcGFnZSB0YWJsZSBpdHNlbGYuDQo+PiAN
Cj4+IE5vdGUgdGhhdCBLVk0gYWxyZWFkeSBmYXVsdGVkIGluIHRoZSBwYWdlIChvciBodWdlIHBh
Z2UpIGluIHRoZSBob3N0J3MNCj4+IHBhZ2UgdGFibGUsIGFuZCB3ZSBob2xkIHRoZSBLVk0gbW11
IHNwaW5sb2NrLiAgV2UgZ3JhYmJlZCB0aGF0IGxvY2sgaW4NCj4+IGt2bV9tbXVfbm90aWZpZXJf
aW52YWxpZGF0ZV9yYW5nZV9lbmQsIGJlZm9yZSBjaGVja2luZyB0aGUgbW11IHNlcS4NCj4+IA0K
Pj4gU2lnbmVkLW9mZi1ieTogQmFycmV0IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPg0KPiANCj4g
SSBkb27igJl0IHRoaW5rIHRoZSByaWdodCBwbGFjZSB0byBjaGFuZ2UgZm9yIHRoaXMgZnVuY3Rp
b25hbGl0eSBpcyB0cmFuc3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKQ0KPiB3aGljaCBpcyBtZWFu
dCB0byBoYW5kbGUgUEZOcyB0aGF0IGFyZSBtYXBwZWQgYXMgcGFydCBvZiBhIHRyYW5zcGFyZW50
IGh1Z2UtcGFnZS4NCj4gDQo+IEZvciBleGFtcGxlLCB0aGlzIHdvdWxkIHByZXZlbnQgbWFwcGlu
ZyBEQVgtYmFja2VkIGZpbGUgcGFnZSBhcyAxR0IuDQo+IEFzIHRyYW5zcGFyZW50X2h1Z2VwYWdl
X2FkanVzdCgpIG9ubHkgaGFuZGxlcyB0aGUgY2FzZSAobGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9M
RVZFTCkuDQo+IA0KPiBBcyB5b3UgYXJlIHBhcnNpbmcgdGhlIHBhZ2UtdGFibGVzIHRvIGRpc2Nv
dmVyIHRoZSBwYWdlLXNpemUgdGhlIFBGTiBpcyBtYXBwZWQgaW4sDQo+IEkgdGhpbmsgeW91IHNo
b3VsZCBpbnN0ZWFkIG1vZGlmeSBrdm1faG9zdF9wYWdlX3NpemUoKSB0byBwYXJzZSBwYWdlLXRh
YmxlcyBpbnN0ZWFkDQo+IG9mIHJlbHkgb24gdm1hX2tlcm5lbF9wYWdlc2l6ZSgpIChXaGljaCBy
ZWxpZXMgb24gdm1hLT52bV9vcHMtPnBhZ2VzaXplKCkpIGluIGNhc2UNCj4gb2YgaXNfem9uZV9k
ZXZpY2VfcGFnZSgpLg0KPiBUaGUgbWFpbiBjb21wbGljYXRpb24gdGhvdWdoIG9mIGRvaW5nIHRo
aXMgaXMgdGhhdCBhdCB0aGlzIHBvaW50IHlvdSBkb27igJl0IHlldCBoYXZlIHRoZSBQRk4NCj4g
dGhhdCBpcyByZXRyaWV2ZWQgYnkgdHJ5X2FzeW5jX3BmKCkuIFNvIG1heWJlIHlvdSBzaG91bGQg
Y29uc2lkZXIgbW9kaWZ5aW5nIHRoZSBvcmRlciBvZiBjYWxscw0KPiBpbiB0ZHBfcGFnZV9mYXVs
dCgpICYgRk5BTUUocGFnZV9mYXVsdCkoKS4NCj4gDQo+IC1MaXJhbg0KDQpPciBhbHRlcm5hdGl2
ZWx5IHdoZW4gdGhpbmtpbmcgYWJvdXQgaXQgbW9yZSwgbWF5YmUganVzdCByZW5hbWUgdHJhbnNw
YXJlbnRfaHVnZXBhZ2VfYWRqdXN0KCkNCnRvIG5vdCBiZSBzcGVjaWZpYyB0byBUSFAgYW5kIGJl
dHRlciBoYW5kbGUgdGhlIGNhc2Ugb2YgcGFyc2luZyBwYWdlLXRhYmxlcyBjaGFuZ2luZyBtYXBw
aW5nLWxldmVsIHRvIDFHQi4NClRoYXQgaXMgcHJvYmFibHkgZWFzaWVyIGFuZCBtb3JlIGVsZWdh
bnQuDQoNCi1MaXJhbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
