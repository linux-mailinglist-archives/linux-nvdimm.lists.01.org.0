Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2277231EE5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 15:01:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B1ECF126CA4CA;
	Wed, 29 Jul 2020 06:01:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6161F126CA4C9
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 06:01:47 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06TCZaTh124587;
	Wed, 29 Jul 2020 09:00:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqgumyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 09:00:39 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06TCbQ1q136668;
	Wed, 29 Jul 2020 09:00:38 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32hsqgumwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 09:00:38 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06TD0an3022946;
	Wed, 29 Jul 2020 13:00:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma02fra.de.ibm.com with ESMTP id 32gcq0u44y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 13:00:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06TD0XDB59572686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2020 13:00:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36118AE099;
	Wed, 29 Jul 2020 13:00:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18FC5AE06E;
	Wed, 29 Jul 2020 13:00:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.160])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2020 13:00:27 +0000 (GMT)
Date: Wed, 29 Jul 2020 16:00:25 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Message-ID: <20200729130025.GD3672596@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
 <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_07:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=5 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=532 adultscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290082
Message-ID-Hash: YDTQSHYM7VC333YDVWLITZUGRKKX7XEK
X-Message-ID-Hash: YDTQSHYM7VC333YDVWLITZUGRKKX7XEK
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Justin He <Justin.He@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YDTQSHYM7VC333YDVWLITZUGRKKX7XEK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBKdWwgMjksIDIwMjAgYXQgMTE6MzU6MjBBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDI5LjA3LjIwIDExOjMxLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+
IEhpIEp1c3RpbiwNCj4gPiANCj4gPiBPbiBXZWQsIEp1bCAyOSwgMjAyMCBhdCAwODoyNzo1OEFN
ICswMDAwLCBKdXN0aW4gSGUgd3JvdGU6DQo+ID4+IEhpIERhdmlkDQo+ID4+Pj4NCj4gPj4+PiBX
aXRob3V0IHRoaXMgc2VyaWVzLCBpZiBxZW11IGNyZWF0ZXMgYSA0RyBieXRlcyBudmRpbW0gZGV2
aWNlLCB3ZSBjYW4NCj4gPj4+IG9ubHkNCj4gPj4+PiB1c2UgMkcgYnl0ZXMgZm9yIGRheCBwbWVt
KGttZW0pIGluIHRoZSB3b3JzdCBjYXNlLg0KPiA+Pj4+IGUuZy4NCj4gPj4+PiAyNDAwMDAwMDAt
MzNmZGZmZmZmIDogUGVyc2lzdGVudCBNZW1vcnkNCj4gPj4+PiBXZSBjYW4gb25seSB1c2UgdGhl
IG1lbWJsb2NrIGJldHdlZW4gWzI0MDAwMDAwMCwgMmZmZmZmZmZmXSBkdWUgdG8gdGhlDQo+ID4+
PiBoYXJkDQo+ID4+Pj4gbGltaXRhdGlvbi4gSXQgd2FzdGVzIHRvbyBtdWNoIG1lbW9yeSBzcGFj
ZS4NCj4gPj4+Pg0KPiA+Pj4+IERlY3JlYXNpbmcgdGhlIFNFQ1RJT05fU0laRV9CSVRTIG9uIGFy
bTY0IG1pZ2h0IGJlIGFuIGFsdGVybmF0aXZlLCBidXQNCj4gPj4+IHRoZXJlDQo+ID4+Pj4gYXJl
IHRvbyBtYW55IGNvbmNlcm5zIGZyb20gb3RoZXIgY29uc3RyYWludHMsIGUuZy4gUEFHRV9TSVpF
LCBodWdldGxiLA0KPiA+Pj4+IFNQQVJTRU1FTV9WTUVNTUFQLCBwYWdlIGJpdHMgaW4gc3RydWN0
IHBhZ2UgLi4uDQo+ID4+Pj4NCj4gPj4+PiBCZXNpZGUgZGVjcmVhc2luZyB0aGUgU0VDVElPTl9T
SVpFX0JJVFMsIHdlIGNhbiBhbHNvIHJlbGF4IHRoZSBrbWVtDQo+ID4+PiBhbGlnbm1lbnQNCj4g
Pj4+PiB3aXRoIG1lbW9yeV9ibG9ja19zaXplX2J5dGVzKCkuDQo+ID4+Pj4NCj4gPj4+PiBUZXN0
ZWQgb24gYXJtNjQgZ3Vlc3QgYW5kIHg4NiBndWVzdCwgcWVtdSBjcmVhdGVzIGEgNEcgcG1lbSBk
ZXZpY2UuIGRheA0KPiA+Pj4gcG1lbQ0KPiA+Pj4+IGNhbiBiZSB1c2VkIGFzIHJhbSB3aXRoIHNt
YWxsZXIgZ2FwLiBBbHNvIHRoZSBrbWVtIGhvdHBsdWcgYWRkL3JlbW92ZQ0KPiA+Pj4gYXJlIGJv
dGgNCj4gPj4+PiB0ZXN0ZWQgb24gYXJtNjQveDg2IGd1ZXN0Lg0KPiA+Pj4+DQo+ID4+Pg0KPiA+
Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gSSBhbSBub3QgY29udmluY2VkIHRoaXMgdXNlIGNhc2UgaXMg
d29ydGggc3VjaCBoYWNrcyAodGhhdOKAmXMgd2hhdCBpdCBpcykNCj4gPj4+IGZvciBub3cuIE9u
IHJlYWwgbWFjaGluZXMgcG1lbSBpcyBiaWcgLSB5b3VyIGV4YW1wbGUgKGxvc2luZyA1MCUgaXMN
Cj4gPj4+IGV4dHJlbWUpLg0KPiA+Pj4NCj4gPj4+IEkgd291bGQgbXVjaCByYXRoZXIgd2FudCB0
byBzZWUgdGhlIHNlY3Rpb24gc2l6ZSBvbiBhcm02NCByZWR1Y2VkLiBJDQo+ID4+PiByZW1lbWJl
ciB0aGVyZSB3ZXJlIHBhdGNoZXMgYW5kIHRoYXQgYXQgbGVhc3Qgd2l0aCBhIGJhc2UgcGFnZSBz
aXplIG9mIDRrDQo+ID4+PiBpdCBjYW4gYmUgcmVkdWNlZCBkcmFzdGljYWxseSAoNjRrIGJhc2Ug
cGFnZXMgYXJlIG1vcmUgcHJvYmxlbWF0aWMgZHVlIHRvDQo+ID4+PiB0aGUgcmlkaWN1bG91cyBU
SFAgc2l6ZSBvZiA1MTJNKS4gQnV0IGNvdWxkIGJlIGEgc2VjdGlvbiBzaXplIG9mIDUxMiBpcw0K
PiA+Pj4gcG9zc2libGUgb24gYWxsIGNvbmZpZ3MgcmlnaHQgbm93Lg0KPiA+Pg0KPiA+PiBZZXMs
IEkgb25jZSBpbnZlc3RpZ2F0ZWQgaG93IHRvIHJlZHVjZSBzZWN0aW9uIHNpemUgb24gYXJtNjQg
dGhvdWdodGZ1bGx5Og0KPiA+PiBUaGVyZSBhcmUgbWFueSBjb25zdHJhaW50cyBmb3IgcmVkdWNp
bmcgU0VDVElPTl9TSVpFX0JJVFMNCj4gPj4gMS4gR2l2ZW4gcGFnZS0+ZmxhZ3MgYml0cyBpcyBs
aW1pdGVkLCBTRUNUSU9OX1NJWkVfQklUUyBjYW4ndCBiZSByZWR1Y2VkIHRvbw0KPiA+PiAgICBt
dWNoLg0KPiA+PiAyLiBPbmNlIENPTkZJR19TUEFSU0VNRU1fVk1FTU1BUCBpcyBlbmFibGVkLCBz
ZWN0aW9uIGlkIHdpbGwgbm90IGJlIGNvdW50ZWQNCj4gPj4gICAgaW50byBwYWdlLT5mbGFncy4N
Cj4gPj4gMy4gTUFYX09SREVSIGRlcGVuZHMgb24gU0VDVElPTl9TSVpFX0JJVFMgDQo+ID4+ICAt
IDMuMSBtbXpvbmUuaA0KPiA+PiAjaWYgKE1BWF9PUkRFUiAtIDEgKyBQQUdFX1NISUZUKSA+IFNF
Q1RJT05fU0laRV9CSVRTDQo+ID4+ICNlcnJvciBBbGxvY2F0b3IgTUFYX09SREVSIGV4Y2VlZHMg
U0VDVElPTl9TSVpFDQo+ID4+ICNlbmRpZg0KPiA+PiAgLSAzLjIgaHVnZXBhZ2VfaW5pdCgpDQo+
ID4+IE1BWUJFX0JVSUxEX0JVR19PTihIUEFHRV9QTURfT1JERVIgPj0gTUFYX09SREVSKTsNCj4g
Pj4NCj4gPj4gSGVuY2Ugd2hlbiBBUk02NF80S19QQUdFUyAmJiBDT05GSUdfU1BBUlNFTUVNX1ZN
RU1NQVAgYXJlIGVuYWJsZWQsDQo+ID4+IFNFQ1RJT05fU0laRV9CSVRTIGNhbiBiZSByZWR1Y2Vk
IHRvIDI3Lg0KPiA+PiBCdXQgd2hlbiBBUk02NF82NEtfUEFHRVMsIGdpdmVuIDMuMiwgTUFYX09S
REVSID4gMjktMTYgPSAxMy4NCj4gPj4gR2l2ZW4gMy4xIFNFQ1RJT05fU0laRV9CSVRTID49IE1B
WF9PUkRFUisxNSA+IDI4LiBTbyBTRUNUSU9OX1NJWkVfQklUUyBjYW4gbm90DQo+ID4+IGJlIHJl
ZHVjZWQgdG8gMjcuDQo+ID4+DQo+ID4+IEluIG9uZSB3b3JkLCBpZiB3ZSBjb25zaWRlcmVkIHRv
IHJlZHVjZSBTRUNUSU9OX1NJWkVfQklUUyBvbiBhcm02NCwgdGhlIEtjb25maWcNCj4gPj4gbWln
aHQgYmUgdmVyeSBjb21wbGljYXRlZCxlLmcuIHdlIHN0aWxsIG5lZWQgdG8gY29uc2lkZXIgdGhl
IGNhc2UgZm9yDQo+ID4+IEFSTTY0XzE2S19QQUdFUy4NCj4gPiANCj4gPiBJdCBpcyBub3QgbmVj
ZXNzYXJ5IHRvIHBvbGx1dGUgS2NvbmZpZyB3aXRoIHRoYXQuDQo+ID4gYXJjaC9hcm02NC9pbmNs
dWRlL2FzbS9zcGFyZXNlbWVtLmggY2FuIGhhdmUgc29tZXRoaW5nIGxpa2UNCj4gPiANCj4gPiAj
aWZkZWYgQ09ORklHX0FSTTY0XzY0S19QQUdFUw0KPiA+ICNkZWZpbmUgU1BBUlNFX1NFQ1RJT05f
U0laRSAyOQ0KPiA+ICNlbGlmIGRlZmluZWQoQ09ORklHX0FSTTE2S19QQUdFUykNCj4gPiAjZGVm
aW5lIFNQQVJTRV9TRUNUSU9OX1NJWkUgMjgNCj4gPiAjZWxpZiBkZWZpbmVkKENPTkZJR19BUk00
S19QQUdFUykNCj4gPiAjZGVmaW5lIFNQQVJTRV9TRUNUSU9OX1NJWkUgMjcNCj4gPiAjZWxzZQ0K
PiA+ICNlcnJvcg0KPiA+ICNlbmRpZg0KPiANCj4gYWNrDQo+IA0KPiA+ICANCj4gPiBUaGVyZSBp
cyBzdGlsbCBsYXJnZSBnYXAgd2l0aCBBUk02NF82NEtfUEFHRVMsIHRob3VnaC4NCj4gPiANCj4g
PiBBcyBmb3IgU1BBUlNFTUVNIHdpdGhvdXQgVk1FTU1BUCwgYXJlIHRoZXJlIGFjdHVhbCBiZW5l
Zml0cyB0byB1c2UgaXQ/DQo+IA0KPiBJIHdhcyBhc2tpbmcgbXlzZWxmIHRoZSBzYW1lIHF1ZXN0
aW9uIGEgd2hpbGUgYWdvIGFuZCBkaWRuJ3QgcmVhbGx5IGZpbmQNCj4gYSBjb21wZWxsaW5nIG9u
ZS4NCg0KTWVtb3J5IG92ZXJoZWFkIGZvciBWTUVNTUFQIGlzIGxhcmdlciwgZXNwZWNpYWxseSBm
b3IgYXJtNjQgdGhhdCBrbm93cw0KaG93IHRvIGZyZWUgZW1wdHkgcGFydHMgb2YgdGhlIG1lbW9y
eSBtYXAgd2l0aCAiY2xhc3NpYyIgU1BBUlNFTUVNLg0KIA0KPiBJIHRoaW5rIGl0J3MgYWx3YXlz
IGVuYWJsZWQgYXMgZGVmYXVsdCAoU1BBUlNFTUVNX1ZNRU1NQVBfRU5BQkxFKSBhbmQNCj4gd291
bGQgcmVxdWlyZSBjb25maWcgdHdlYWtzIHRvIGV2ZW4gZGlzYWJsZSBpdC4NCg0KTm9wZSwgaXQn
cyByaWdodCB0aGVyZSBpbiBtZW51Y29uZmlnLA0KDQoiTWVtb3J5IE1hbmFnZW1lbnQgb3B0aW9u
cyIgLT4gIlNwYXJzZSBNZW1vcnkgdmlydHVhbCBtZW1tYXAiDQoNCj4gLS0gDQo+IFRoYW5rcywN
Cj4gDQo+IERhdmlkIC8gZGhpbGRlbmINCj4gDQoNCi0tIA0KU2luY2VyZWx5IHlvdXJzLA0KTWlr
ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
