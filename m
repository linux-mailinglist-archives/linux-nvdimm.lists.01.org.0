Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A95F3CF2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Nov 2019 01:37:33 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BC80100EA622;
	Thu,  7 Nov 2019 16:39:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5E612100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 16:39:52 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA80WEBB062133
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 19:37:28 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w4u31ms1g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 19:37:28 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 8 Nov 2019 00:37:25 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 8 Nov 2019 00:37:17 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA80bGhr40173716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2019 00:37:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C106F52050;
	Fri,  8 Nov 2019 00:37:16 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2601B5204E;
	Fri,  8 Nov 2019 00:37:16 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C87D3A01E3;
	Fri,  8 Nov 2019 11:37:13 +1100 (AEDT)
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the
 generic OCXL driver
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 08 Nov 2019 11:37:14 +1100
In-Reply-To: <b70644d6-2c71-cd71-5d00-e25d99beea91@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
	 <20191025044721.16617-11-alastair@au1.ibm.com>
	 <b70644d6-2c71-cd71-5d00-e25d99beea91@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19110800-0020-0000-0000-0000038390E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110800-0021-0000-0000-000021D9C758
Message-Id: <46d72d7b2f91900c4499db127e365baade38e18c.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080004
Message-ID-Hash: 5GI7WL32EFZARXJ7T4T3LCOUH3U2UMWP
X-Message-ID-Hash: 5GI7WL32EFZARXJ7T4T3LCOUH3U2UMWP
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tata
 shin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5GI7WL32EFZARXJ7T4T3LCOUH3U2UMWP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCAyMDE5LTExLTA3IGF0IDE5OjA4ICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyNS8xMC8yMDE5IMOgIDA2OjQ3LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBUaGlzIHBhdGNoIGFsbG93cyB0aGUgdXNlciB0byBiaW5kIE9wZW5DQVBJIFNDTSBk
ZXZpY2VzIHRvIHRoZQ0KPiA+IGdlbmVyaWMgT0NYTA0KPiA+IGRyaXZlci4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiAtLS0NCj4gDQo+IEknbSB3b25kZXJpbmcgaWYgd2Ugc2hvdWxkIHVwc3RyZWFtIHRoaXMuIElz
IGl0IG9mIGFueSB1c2Ugb3V0c2lkZQ0KPiBvZiANCj4gc29tZSBzZXJpb3VzIGRlYnVnIHNlc3Np
b24gZm9yIGEgZGV2ZWxvcGVyPw0KPiBBbHNvIHdlIHdvdWxkIG5vdyBoYXZlIDIgZHJpdmVycyBw
aWNraW5nIHVwIHRoZSBzYW1lIGRldmljZSBJRCwNCj4gc2luY2UgDQo+IHRoZSBTQ00gZHJpdmVy
IGlzIGFsd2F5cyByZWdpc3RlcmluZyBmb3IgdGhhdCBJRCwgaXJyZXNwZWN0aXZlIG9mIA0KPiBD
T05GSUdfT0NYTF9TQ01fR0VORVJJQw0KPiANCj4gICAgRnJlZA0KPiANCg0KSSB0aGluayBJJ2xs
IGRyb3AgdGhpcyBwYXRjaC4gSXQncyBlYXN5IGVub3VnaCB0byBtYWludGFpbiBvdXQtb2YtdHJl
ZQ0KZm9yIG91ciBpbi1ob3VzZSBTQ00gaGFyZHdhcmUgZW5naW5lZXJzLg0KDQo+IA0KPiA+ICAg
ZHJpdmVycy9taXNjL29jeGwvS2NvbmZpZyB8IDcgKysrKysrKw0KPiA+ICAgZHJpdmVycy9taXNj
L29jeGwvcGNpLmMgICB8IDMgKysrDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvS2NvbmZpZyBi
L2RyaXZlcnMvbWlzYy9vY3hsL0tjb25maWcNCj4gPiBpbmRleCAxOTE2ZmE2NWYyZjIuLjhhNjgz
NzE1Yzk3YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21pc2Mvb2N4bC9LY29uZmlnDQo+ID4g
KysrIGIvZHJpdmVycy9taXNjL29jeGwvS2NvbmZpZw0KPiA+IEBAIC0yOSwzICsyOSwxMCBAQCBj
b25maWcgT0NYTA0KPiA+ICAgCSAgZGVkaWNhdGVkIE9wZW5DQVBJIGxpbmssIGFuZCBkb24ndCBm
b2xsb3cgdGhlIHNhbWUgcHJvdG9jb2wuDQo+ID4gICANCj4gPiAgIAkgIElmIHVuc3VyZSwgc2F5
IE4uDQo+ID4gKw0KPiA+ICtjb25maWcgT0NYTF9TQ01fR0VORVJJQw0KPiA+ICsJYm9vbCAiVHJl
YXQgT3BlbkNBUEkgU3RvcmFnZSBDbGFzcyBNZW1vcnkgYXMgYSBnZW5lcmljIE9wZW5DQVBJDQo+
ID4gZGV2aWNlIg0KPiA+ICsJZGVmYXVsdCBuDQo+ID4gKwloZWxwDQo+ID4gKwkgIFNlbGVjdCB0
aGlzIG9wdGlvbiB0byB0cmVhdCBPcGVuQ0FQSSBTdG9yYWdlIENsYXNzIE1lbW9yeQ0KPiA+ICsJ
ICBkZXZpY2VzIGFuIGdlbmVyaWMgT3BlbkNBUEkgZGV2aWNlcy4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9taXNjL29jeGwvcGNpLmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9wY2kuYw0KPiA+IGlu
ZGV4IGNiOTIwYWE4OGQzYS4uNzEzNzA1NWMxODgzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
bWlzYy9vY3hsL3BjaS5jDQo+ID4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvcGNpLmMNCj4gPiBA
QCAtMTAsNiArMTAsOSBAQA0KPiA+ICAgICovDQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IHBj
aV9kZXZpY2VfaWQgb2N4bF9wY2lfdGJsW10gPSB7DQo+ID4gICAJeyBQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfSUJNLCAweDA2MkIpLCB9LA0KPiA+ICsjaWZkZWYgQ09ORklHX09DWExfU0NNX0dF
TkVSSUMNCj4gPiArCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lCTSwgMHgwNjI1KSwgfSwN
Cj4gPiArI2VuZGlmDQo+ID4gICAJeyB9DQo+ID4gICB9Ow0KPiA+ICAgTU9EVUxFX0RFVklDRV9U
QUJMRShwY2ksIG9jeGxfcGNpX3RibCk7DQo+ID4gDQotLSANCkFsYXN0YWlyIEQnU2lsdmENCk9w
ZW4gU291cmNlIERldmVsb3Blcg0KTGludXggVGVjaG5vbG9neSBDZW50cmUsIElCTSBBdXN0cmFs
aWENCm1vYjogMDQyMyA3NjIgODE5DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
