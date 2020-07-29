Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53430231C1F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 11:32:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08E85126A2FA1;
	Wed, 29 Jul 2020 02:32:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 72579126A2F81
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 02:32:25 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T93bf6067805;
	Wed, 29 Jul 2020 05:32:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8vkapt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 05:32:12 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06T93iK8068431;
	Wed, 29 Jul 2020 05:32:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8vkajg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 05:32:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06T9TuNs015244;
	Wed, 29 Jul 2020 09:31:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma03ams.nl.ibm.com with ESMTP id 32gcpx4vje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 09:31:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06T9Vu8657933988
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2020 09:31:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EADC52050;
	Wed, 29 Jul 2020 09:31:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.204.160])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 01EE75204F;
	Wed, 29 Jul 2020 09:31:52 +0000 (GMT)
Date: Wed, 29 Jul 2020 12:31:50 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: Justin He <Justin.He@arm.com>
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
Message-ID: <20200729093150.GC3672596@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_03:2020-07-29,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 mlxlogscore=891
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007290061
Message-ID-Hash: BY7YY246KHHSSILF2YUHIYRFH4R6A4AX
X-Message-ID-Hash: BY7YY246KHHSSILF2YUHIYRFH4R6A4AX
X-MailFrom: rppt@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BY7YY246KHHSSILF2YUHIYRFH4R6A4AX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgSnVzdGluLA0KDQpPbiBXZWQsIEp1bCAyOSwgMjAyMCBhdCAwODoyNzo1OEFNICswMDAwLCBK
dXN0aW4gSGUgd3JvdGU6DQo+IEhpIERhdmlkDQo+ID4gPg0KPiA+ID4gV2l0aG91dCB0aGlzIHNl
cmllcywgaWYgcWVtdSBjcmVhdGVzIGEgNEcgYnl0ZXMgbnZkaW1tIGRldmljZSwgd2UgY2FuDQo+
ID4gb25seQ0KPiA+ID4gdXNlIDJHIGJ5dGVzIGZvciBkYXggcG1lbShrbWVtKSBpbiB0aGUgd29y
c3QgY2FzZS4NCj4gPiA+IGUuZy4NCj4gPiA+IDI0MDAwMDAwMC0zM2ZkZmZmZmYgOiBQZXJzaXN0
ZW50IE1lbW9yeQ0KPiA+ID4gV2UgY2FuIG9ubHkgdXNlIHRoZSBtZW1ibG9jayBiZXR3ZWVuIFsy
NDAwMDAwMDAsIDJmZmZmZmZmZl0gZHVlIHRvIHRoZQ0KPiA+IGhhcmQNCj4gPiA+IGxpbWl0YXRp
b24uIEl0IHdhc3RlcyB0b28gbXVjaCBtZW1vcnkgc3BhY2UuDQo+ID4gPg0KPiA+ID4gRGVjcmVh
c2luZyB0aGUgU0VDVElPTl9TSVpFX0JJVFMgb24gYXJtNjQgbWlnaHQgYmUgYW4gYWx0ZXJuYXRp
dmUsIGJ1dA0KPiA+IHRoZXJlDQo+ID4gPiBhcmUgdG9vIG1hbnkgY29uY2VybnMgZnJvbSBvdGhl
ciBjb25zdHJhaW50cywgZS5nLiBQQUdFX1NJWkUsIGh1Z2V0bGIsDQo+ID4gPiBTUEFSU0VNRU1f
Vk1FTU1BUCwgcGFnZSBiaXRzIGluIHN0cnVjdCBwYWdlIC4uLg0KPiA+ID4NCj4gPiA+IEJlc2lk
ZSBkZWNyZWFzaW5nIHRoZSBTRUNUSU9OX1NJWkVfQklUUywgd2UgY2FuIGFsc28gcmVsYXggdGhl
IGttZW0NCj4gPiBhbGlnbm1lbnQNCj4gPiA+IHdpdGggbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMo
KS4NCj4gPiA+DQo+ID4gPiBUZXN0ZWQgb24gYXJtNjQgZ3Vlc3QgYW5kIHg4NiBndWVzdCwgcWVt
dSBjcmVhdGVzIGEgNEcgcG1lbSBkZXZpY2UuIGRheA0KPiA+IHBtZW0NCj4gPiA+IGNhbiBiZSB1
c2VkIGFzIHJhbSB3aXRoIHNtYWxsZXIgZ2FwLiBBbHNvIHRoZSBrbWVtIGhvdHBsdWcgYWRkL3Jl
bW92ZQ0KPiA+IGFyZSBib3RoDQo+ID4gPiB0ZXN0ZWQgb24gYXJtNjQveDg2IGd1ZXN0Lg0KPiA+
ID4NCj4gPiANCj4gPiBIaSwNCj4gPiANCj4gPiBJIGFtIG5vdCBjb252aW5jZWQgdGhpcyB1c2Ug
Y2FzZSBpcyB3b3J0aCBzdWNoIGhhY2tzICh0aGF04oCZcyB3aGF0IGl0IGlzKQ0KPiA+IGZvciBu
b3cuIE9uIHJlYWwgbWFjaGluZXMgcG1lbSBpcyBiaWcgLSB5b3VyIGV4YW1wbGUgKGxvc2luZyA1
MCUgaXMNCj4gPiBleHRyZW1lKS4NCj4gPiANCj4gPiBJIHdvdWxkIG11Y2ggcmF0aGVyIHdhbnQg
dG8gc2VlIHRoZSBzZWN0aW9uIHNpemUgb24gYXJtNjQgcmVkdWNlZC4gSQ0KPiA+IHJlbWVtYmVy
IHRoZXJlIHdlcmUgcGF0Y2hlcyBhbmQgdGhhdCBhdCBsZWFzdCB3aXRoIGEgYmFzZSBwYWdlIHNp
emUgb2YgNGsNCj4gPiBpdCBjYW4gYmUgcmVkdWNlZCBkcmFzdGljYWxseSAoNjRrIGJhc2UgcGFn
ZXMgYXJlIG1vcmUgcHJvYmxlbWF0aWMgZHVlIHRvDQo+ID4gdGhlIHJpZGljdWxvdXMgVEhQIHNp
emUgb2YgNTEyTSkuIEJ1dCBjb3VsZCBiZSBhIHNlY3Rpb24gc2l6ZSBvZiA1MTIgaXMNCj4gPiBw
b3NzaWJsZSBvbiBhbGwgY29uZmlncyByaWdodCBub3cuDQo+IA0KPiBZZXMsIEkgb25jZSBpbnZl
c3RpZ2F0ZWQgaG93IHRvIHJlZHVjZSBzZWN0aW9uIHNpemUgb24gYXJtNjQgdGhvdWdodGZ1bGx5
Og0KPiBUaGVyZSBhcmUgbWFueSBjb25zdHJhaW50cyBmb3IgcmVkdWNpbmcgU0VDVElPTl9TSVpF
X0JJVFMNCj4gMS4gR2l2ZW4gcGFnZS0+ZmxhZ3MgYml0cyBpcyBsaW1pdGVkLCBTRUNUSU9OX1NJ
WkVfQklUUyBjYW4ndCBiZSByZWR1Y2VkIHRvbw0KPiAgICBtdWNoLg0KPiAyLiBPbmNlIENPTkZJ
R19TUEFSU0VNRU1fVk1FTU1BUCBpcyBlbmFibGVkLCBzZWN0aW9uIGlkIHdpbGwgbm90IGJlIGNv
dW50ZWQNCj4gICAgaW50byBwYWdlLT5mbGFncy4NCj4gMy4gTUFYX09SREVSIGRlcGVuZHMgb24g
U0VDVElPTl9TSVpFX0JJVFMgDQo+ICAtIDMuMSBtbXpvbmUuaA0KPiAjaWYgKE1BWF9PUkRFUiAt
IDEgKyBQQUdFX1NISUZUKSA+IFNFQ1RJT05fU0laRV9CSVRTDQo+ICNlcnJvciBBbGxvY2F0b3Ig
TUFYX09SREVSIGV4Y2VlZHMgU0VDVElPTl9TSVpFDQo+ICNlbmRpZg0KPiAgLSAzLjIgaHVnZXBh
Z2VfaW5pdCgpDQo+IE1BWUJFX0JVSUxEX0JVR19PTihIUEFHRV9QTURfT1JERVIgPj0gTUFYX09S
REVSKTsNCj4gDQo+IEhlbmNlIHdoZW4gQVJNNjRfNEtfUEFHRVMgJiYgQ09ORklHX1NQQVJTRU1F
TV9WTUVNTUFQIGFyZSBlbmFibGVkLA0KPiBTRUNUSU9OX1NJWkVfQklUUyBjYW4gYmUgcmVkdWNl
ZCB0byAyNy4NCj4gQnV0IHdoZW4gQVJNNjRfNjRLX1BBR0VTLCBnaXZlbiAzLjIsIE1BWF9PUkRF
UiA+IDI5LTE2ID0gMTMuDQo+IEdpdmVuIDMuMSBTRUNUSU9OX1NJWkVfQklUUyA+PSBNQVhfT1JE
RVIrMTUgPiAyOC4gU28gU0VDVElPTl9TSVpFX0JJVFMgY2FuIG5vdA0KPiBiZSByZWR1Y2VkIHRv
IDI3Lg0KPiANCj4gSW4gb25lIHdvcmQsIGlmIHdlIGNvbnNpZGVyZWQgdG8gcmVkdWNlIFNFQ1RJ
T05fU0laRV9CSVRTIG9uIGFybTY0LCB0aGUgS2NvbmZpZw0KPiBtaWdodCBiZSB2ZXJ5IGNvbXBs
aWNhdGVkLGUuZy4gd2Ugc3RpbGwgbmVlZCB0byBjb25zaWRlciB0aGUgY2FzZSBmb3INCj4gQVJN
NjRfMTZLX1BBR0VTLg0KDQpJdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHBvbGx1dGUgS2NvbmZpZyB3
aXRoIHRoYXQuDQphcmNoL2FybTY0L2luY2x1ZGUvYXNtL3NwYXJlc2VtZW0uaCBjYW4gaGF2ZSBz
b21ldGhpbmcgbGlrZQ0KDQojaWZkZWYgQ09ORklHX0FSTTY0XzY0S19QQUdFUw0KI2RlZmluZSBT
UEFSU0VfU0VDVElPTl9TSVpFIDI5DQojZWxpZiBkZWZpbmVkKENPTkZJR19BUk0xNktfUEFHRVMp
DQojZGVmaW5lIFNQQVJTRV9TRUNUSU9OX1NJWkUgMjgNCiNlbGlmIGRlZmluZWQoQ09ORklHX0FS
TTRLX1BBR0VTKQ0KI2RlZmluZSBTUEFSU0VfU0VDVElPTl9TSVpFIDI3DQojZWxzZQ0KI2Vycm9y
DQojZW5kaWYNCiANClRoZXJlIGlzIHN0aWxsIGxhcmdlIGdhcCB3aXRoIEFSTTY0XzY0S19QQUdF
UywgdGhvdWdoLg0KDQpBcyBmb3IgU1BBUlNFTUVNIHdpdGhvdXQgVk1FTU1BUCwgYXJlIHRoZXJl
IGFjdHVhbCBiZW5lZml0cyB0byB1c2UgaXQ/DQoNCj4gPiANCj4gPiBJbiB0aGUgbG9uZyB0ZXJt
IHdlIG1pZ2h0IHdhbnQgdG8gcmV3b3JrIHRoZSBtZW1vcnkgYmxvY2sgZGV2aWNlIG1vZGVsDQo+
ID4gKGV2ZW50dWFsbHkgc3VwcG9ydGluZyBvbGQvbmV3IGFzIGRpc2N1c3NlZCB3aXRoIE1pY2hh
bCBzb21lIHRpbWUgYWdvDQo+ID4gdXNpbmcgYSBrZXJuZWwgcGFyYW1ldGVyKSwgZHJvcHBpbmcg
dGhlIGZpeGVkIHNpemVzDQo+IA0KPiBIYXMgdGhpcyBiZWVuIHBvc3RlZCB0byBMaW51eCBtbSBt
YWlsbGlzdD8gU29ycnksIHNlYXJjaGVkIGFuZCBkaWRuJ3QgZmluZCBpdC4NCj4gDQo+IA0KPiAt
LQ0KPiBDaGVlcnMsDQo+IEp1c3RpbiAoSmlhIEhlKQ0KPiANCj4gDQo+IA0KPiA+IC0gYWxsb3dp
bmcgc2l6ZXMgLyBhZGRyZXNzZXMgYWxpZ25lZCB3aXRoIHN1YnNlY3Rpb24gc2l6ZQ0KPiA+IC0g
ZHJhc3RpY2FsbHkgcmVkdWNpbmcgdGhlIG51bWJlciBvZiBkZXZpY2VzIGZvciBib290IG1lbW9y
eSB0byBvbmx5IGENCj4gPiBoYW5kIGZ1bGwgKGUuZy4sIG9uZSBwZXIgcmVzb3VyY2UgLyBESU1N
IHdlIGNhbiBhY3R1YWxseSB1bnBsdWcgYWdhaW4uDQo+ID4gDQo+ID4gTG9uZyBzdG9yeSBzaG9y
dCwgSSBkb27igJl0IGxpa2UgdGhpcyBoYWNrLg0KPiA+IA0KPiA+IA0KPiA+ID4gVGhpcyBwYXRj
aCBzZXJpZXMgKG1haW5seSBwYXRjaDYvNikgaXMgYmFzZWQgb24gdGhlIGZpeGluZyBwYXRjaCwg
fnY1LjgtDQo+ID4gcmM1IFsyXS4NCj4gPiA+DQo+ID4gPiBbMV0gaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMTkvNi8xOS82Nw0KPiA+ID4gWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzcv
OC8xNTQ2DQo+ID4gPiBKaWEgSGUgKDYpOg0KPiA+ID4gIG1tL21lbW9yeV9ob3RwbHVnOiByZW1v
dmUgcmVkdW5kYW50IG1lbW9yeSBibG9jayBzaXplIGFsaWdubWVudCBjaGVjaw0KPiA+ID4gIHJl
c291cmNlOiBleHBvcnQgZmluZF9uZXh0X2lvbWVtX3JlcygpIGhlbHBlcg0KPiA+ID4gIG1tL21l
bW9yeV9ob3RwbHVnOiBhbGxvdyBwbWVtIGttZW0gbm90IHRvIGFsaWduIHdpdGggbWVtb3J5X2Js
b2NrX3NpemUNCj4gPiA+ICBtbS9wYWdlX2FsbG9jOiBhZGp1c3QgdGhlIHN0YXJ0LGVuZCBpbiBk
YXggcG1lbSBrbWVtIGNhc2UNCj4gPiA+ICBkZXZpY2UtZGF4OiByZWxheCB0aGUgbWVtYmxvY2sg
c2l6ZSBhbGlnbm1lbnQgZm9yIGttZW1fc3RhcnQNCj4gPiA+ICBhcm02NDogZmFsbCBiYWNrIHRv
IHZtZW1tYXBfcG9wdWxhdGVfYmFzZXBhZ2VzIGlmIG5vdCBhbGlnbmVkICB3aXRoDQo+ID4gPiAg
ICBQTURfU0laRQ0KPiA+ID4NCj4gPiA+IGFyY2gvYXJtNjQvbW0vbW11LmMgICAgfCAgNCArKysr
DQo+ID4gPiBkcml2ZXJzL2Jhc2UvbWVtb3J5LmMgIHwgMjQgKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+ID4gPiBkcml2ZXJzL2RheC9rbWVtLmMgICAgIHwgMjIgKysrKysrKysrKysrKy0tLS0t
LS0tLQ0KPiA+ID4gaW5jbHVkZS9saW51eC9pb3BvcnQuaCB8ICAzICsrKw0KPiA+ID4ga2VybmVs
L3Jlc291cmNlLmMgICAgICB8ICAzICsrLQ0KPiA+ID4gbW0vbWVtb3J5X2hvdHBsdWcuYyAgICB8
IDM5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gbW0vcGFn
ZV9hbGxvYy5jICAgICAgICB8IDE0ICsrKysrKysrKysrKysrDQo+ID4gPiA3IGZpbGVzIGNoYW5n
ZWQsIDkwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IC0tDQo+
ID4gPiAyLjE3LjENCj4gPiA+DQo+IA0KDQotLSANClNpbmNlcmVseSB5b3VycywNCk1pa2UuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
