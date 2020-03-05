Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D636179E51
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Mar 2020 04:39:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 306DF10FC3770;
	Wed,  4 Mar 2020 19:39:55 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEA581007B1C9
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 19:39:53 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0253cf9N036206
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 22:39:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q1w54w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 22:39:01 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Thu, 5 Mar 2020 03:38:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 5 Mar 2020 03:38:52 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0253cpG563176904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2020 03:38:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 587A0A405C;
	Thu,  5 Mar 2020 03:38:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2436A405B;
	Thu,  5 Mar 2020 03:38:50 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2020 03:38:50 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C64C2A0264;
	Thu,  5 Mar 2020 14:38:45 +1100 (AEDT)
Subject: Re: [PATCH v3 16/27] powerpc/powernv/pmem: Register a character
 device for userspace to interact with
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 05 Mar 2020 14:38:49 +1100
In-Reply-To: <e9ebc395-9748-61a2-9125-eefc5c763332@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-17-alastair@au1.ibm.com>
	 <e9ebc395-9748-61a2-9125-eefc5c763332@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20030503-0008-0000-0000-000003597306
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030503-0009-0000-0000-00004A7AA8AC
Message-Id: <083251112829de95609c2220dde2e381940184cb.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=2 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050017
Message-ID-Hash: DP3BFJJ5EHSAYSBPUEPAWBLXC7FW7BWD
X-Message-ID-Hash: DP3BFJJ5EHSAYSBPUEPAWBLXC7FW7BWD
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-
 dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DP3BFJJ5EHSAYSBPUEPAWBLXC7FW7BWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIwLTAzLTAzIGF0IDEwOjI4ICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyMS8wMi8yMDIwIMOgIDA0OjI3LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgYSBjaGFyYWN0ZXIgZGV2aWNlICgvZGV2L29j
eGwtc2NtWCkgd2hpY2gNCj4gPiBmdXJ0aGVyDQo+ID4gcGF0Y2hlcyB3aWxsIHVzZSB0byBpbnRl
cmFjdCB3aXRoIHVzZXJzcGFjZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBE
J1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGwuYyAgICB8IDExNg0KPiA+ICsrKysrKysrKysr
KysrKysrLQ0KPiA+ICAgLi4uL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5o
ICAgIHwgICAyICsNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTE2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9y
bXMvcG93ZXJudi9wbWVtL29jeGwuYw0KPiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dl
cm52L3BtZW0vb2N4bC5jDQo+ID4gaW5kZXggYjhiZDdlNzAzYjE5Li42MzEwOWE4NzBkMmMgMTAw
NjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5j
DQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jDQo+
ID4gQEAgLTEwLDYgKzEwLDcgQEANCj4gPiAgICNpbmNsdWRlIDxtaXNjL29jeGwuaD4NCj4gPiAg
ICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L25kY3RsLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21tX3R5
cGVzLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvbWVtb3J5X2hvdHBsdWcuaD4NCj4gPiAgICNp
bmNsdWRlICJvY3hsX2ludGVybmFsLmgiDQo+ID4gQEAgLTMzOSw2ICszNDAsOSBAQCBzdGF0aWMg
dm9pZCBmcmVlX29jeGxwbWVtKHN0cnVjdCBvY3hscG1lbQ0KPiA+ICpvY3hscG1lbSkNCj4gPiAg
IA0KPiA+ICAgCWZyZWVfbWlub3Iob2N4bHBtZW0pOw0KPiA+ICAgDQo+ID4gKwlpZiAob2N4bHBt
ZW0tPmNkZXYub3duZXIpDQo+ID4gKwkJY2Rldl9kZWwoJm9jeGxwbWVtLT5jZGV2KTsNCj4gPiAr
DQo+ID4gICAJaWYgKG9jeGxwbWVtLT5tZXRhZGF0YV9hZGRyKQ0KPiA+ICAgCQlkZXZtX21lbXVu
bWFwKCZvY3hscG1lbS0+ZGV2LCBvY3hscG1lbS0+bWV0YWRhdGFfYWRkcik7DQo+ID4gICANCj4g
PiBAQCAtMzk2LDYgKzQwMCw3MCBAQCBzdGF0aWMgaW50IG9jeGxwbWVtX3JlZ2lzdGVyKHN0cnVj
dCBvY3hscG1lbQ0KPiA+ICpvY3hscG1lbSkNCj4gPiAgIAlyZXR1cm4gZGV2aWNlX3JlZ2lzdGVy
KCZvY3hscG1lbS0+ZGV2KTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICtzdGF0aWMgdm9pZCBvY3hs
cG1lbV9wdXQoc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSkNCj4gPiArew0KPiA+ICsJcHV0X2Rl
dmljZSgmb2N4bHBtZW0tPmRldik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qg
b2N4bHBtZW0gKm9jeGxwbWVtX2dldChzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtKQ0KPiA+ICt7
DQo+ID4gKwlyZXR1cm4gKGdldF9kZXZpY2UoJm9jeGxwbWVtLT5kZXYpID09IE5VTEwpID8gTlVM
TCA6IG9jeGxwbWVtOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG9jeGxwbWVt
ICpmaW5kX2FuZF9nZXRfb2N4bHBtZW0oZGV2X3QgZGV2bm8pDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBvY3hscG1lbSAqb2N4bHBtZW07DQo+ID4gKwlpbnQgbWlub3IgPSBNSU5PUihkZXZubyk7DQo+
ID4gKwkvKg0KPiA+ICsJICogV2UgZG9uJ3QgZGVjbGFyZSBhbiBSQ1UgY3JpdGljYWwgc2VjdGlv
biBoZXJlLCBhcyBvdXIgQUZVDQo+ID4gKwkgKiBpcyBwcm90ZWN0ZWQgYnkgYSByZWZlcmVuY2Ug
Y291bnRlciBvbiB0aGUgZGV2aWNlLiBCeSB0aGUNCj4gPiB0aW1lIHRoZQ0KPiA+ICsJICogbWlu
b3IgbnVtYmVyIG9mIGEgZGV2aWNlIGlzIHJlbW92ZWQgZnJvbSB0aGUgaWRyLCB0aGUgcmVmDQo+
ID4gY291bnQgb2YNCj4gPiArCSAqIHRoZSBkZXZpY2UgaXMgYWxyZWFkeSBhdCAwLCBzbyBubyB1
c2VyIEFQSSB3aWxsIGFjY2VzcyB0aGF0DQo+ID4gQUZVIGFuZA0KPiA+ICsJICogdGhpcyBmdW5j
dGlvbiBjYW4ndCByZXR1cm4gaXQuDQo+ID4gKwkgKi8NCj4gDQo+IEkgZml4ZWQgc29tZXRoaW5n
IHJlbGF0ZWQgaW4gdGhlIG9jeGwgZHJpdmVyICh3aGljaCBoYWQgZW5vdWdoDQo+IGNoYW5nZXMg
DQo+IHdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgImluZm8iIGRldmljZSB0byBtYWtlIGEg
c2ltaWxhciBjb21tZW50IA0KPiBiZWNvbWUgd3JvbmcpLiBTZWUgY29tbWl0IGE1OGQzN2JjZTBk
MjEuIFRoZSBpc3N1ZSBpcyBoYW5kbGluZyBhIA0KPiBzaW11bHRhbmVvdXMgb3BlbigpIGFuZCBy
ZW1vdmFsIG9mIHRoZSBkZXZpY2UgdGhyb3VnaCAvc3lzZnMgYXMgYmVzdA0KPiB3ZSBjYW4uDQo+
IA0KPiBXZSBhcmUgb24gYSBmaWxlIG9wZW4gcGF0aCBhbmQgaXQncyBub3QgbGlrZSB3ZSdyZSBn
b2luZyB0byBoYXZlIGEgDQo+IHRob3VzYW5kIGNsaWVudHMsIHNvIHBlcmZvcm1hbmNlIGlzIG5v
dCB0aGF0IGNyaXRpY2FsLiBXZSBjYW4gdGFrZQ0KPiB0aGUgDQo+IG11dGV4IGJlZm9yZSBzZWFy
Y2hpbmcgaW4gdGhlIElEUiBhbmQgcmVsZWFzZSBpdCBhZnRlciB3ZSBpbmNyZW1lbnQNCj4gdGhl
IA0KPiByZWZlcmVuY2UgY291bnQgb24gdGhlIGRldmljZS4NCj4gQnV0IHRoYXQncyBub3QgZW5v
dWdoOiB3ZSBjb3VsZCBzdGlsbCBmaW5kIHRoZSBkZXZpY2UgaW4gdGhlIElEUg0KPiB3aGlsZSAN
Cj4gaXQgaXMgYmVpbmcgcmVtb3ZlZCBpbiBmcmVlX29jeGxwbWVtKCkuIEkgYmVsaWV2ZSB0aGUg
b25seSBzYWZlIHdheQ0KPiB0byANCj4gYWRkcmVzcyBpdCBpcyBieSByZW1vdmluZyB0aGUgdXNl
ci1mYWNpbmcgQVBJcyAodGhlIGNoYXIgZGV2aWNlKQ0KPiBiZWZvcmUgDQo+IGNhbGxpbmcgZGV2
aWNlX3VucmVnaXN0ZXIoKS4gU28gdGhhdCBpdCdzIG5vdCBwb3NzaWJsZSB0byBmaW5kIHRoZSAN
Cj4gZGV2aWNlIGluIGZpbGVfb3BlbigpIGlmIGl0J3MgaW4gdGhlIG1pZGRsZSBvZiBiZWluZyBy
ZW1vdmVkLg0KPiANCj4gICAgRnJlZA0KPiANCj4gDQoNCk9rLCBJJ2xsIHJlcGxpY2F0ZSB0aGF0
IHBhdGNoICYgZm9sbG93IHlvdXIgYWR2aWNlLg0KDQo+ID4gKwlvY3hscG1lbSA9IGlkcl9maW5k
KCZtaW5vcnNfaWRyLCBtaW5vcik7DQo+ID4gKwlpZiAob2N4bHBtZW0pDQo+ID4gKwkJb2N4bHBt
ZW1fZ2V0KG9jeGxwbWVtKTsNCj4gPiArCXJldHVybiBvY3hscG1lbTsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBmaWxlX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZp
bGUgKmZpbGUpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW07DQo+ID4g
Kw0KPiA+ICsJb2N4bHBtZW0gPSBmaW5kX2FuZF9nZXRfb2N4bHBtZW0oaW5vZGUtPmlfcmRldik7
DQo+ID4gKwlpZiAoIW9jeGxwbWVtKQ0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiA+ICsNCj4g
PiArCWZpbGUtPnByaXZhdGVfZGF0YSA9IG9jeGxwbWVtOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZmlsZV9yZWxlYXNlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgb2N4bHBtZW0gKm9j
eGxwbWVtID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsNCj4gPiArCW9jeGxwbWVtX3B1dChv
Y3hscG1lbSk7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZm9wcyA9IHsNCj4gPiArCS5vd25lcgkJPSBUSElT
X01PRFVMRSwNCj4gPiArCS5vcGVuCQk9IGZpbGVfb3BlbiwNCj4gPiArCS5yZWxlYXNlCT0gZmls
ZV9yZWxlYXNlLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArLyoqDQo+ID4gKyAqIGNyZWF0ZV9jZGV2
KCkgLSBDcmVhdGUgdGhlIGNoYXJkZXYgaW4gL2RldiBmb3IgdGhlIGRldmljZQ0KPiA+ICsgKiBA
b2N4bHBtZW06IHRoZSBTQ00gbWV0YWRhdGENCj4gPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3Ms
IG5lZ2F0aXZlIG9uIGZhaWx1cmUNCj4gPiArICovDQo+ID4gK3N0YXRpYyBpbnQgY3JlYXRlX2Nk
ZXYoc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSkNCj4gPiArew0KPiA+ICsJY2Rldl9pbml0KCZv
Y3hscG1lbS0+Y2RldiwgJmZvcHMpOw0KPiA+ICsJcmV0dXJuIGNkZXZfYWRkKCZvY3hscG1lbS0+
Y2Rldiwgb2N4bHBtZW0tPmRldi5kZXZ0LCAxKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIC8qKg0K
PiA+ICAgICogb2N4bHBtZW1fcmVtb3ZlKCkgLSBGcmVlIGFuIE9wZW5DQVBJIHBlcnNpc3RlbnQg
bWVtb3J5IGRldmljZQ0KPiA+ICAgICogQHBkZXY6IHRoZSBQQ0kgZGV2aWNlIGluZm9ybWF0aW9u
IHN0cnVjdA0KPiA+IEBAIC01NzIsNiArNjQwLDExIEBAIHN0YXRpYyBpbnQgcHJvYmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYsIGNvbnN0DQo+ID4gc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4g
PiAgIAkJZ290byBlcnI7DQo+ID4gICAJfQ0KPiA+ICAgDQo+ID4gKwlpZiAoY3JlYXRlX2NkZXYo
b2N4bHBtZW0pKSB7DQo+ID4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0
ZSBjaGFyYWN0ZXINCj4gPiBkZXZpY2VcbiIpOw0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+ICsJfQ0K
PiANCj4gQXMgYWxyZWFkeSBtZW50aW9uZWQgaW4gYSBwcmV2aW91cyBwYXRjaCwgd2UgYnJhbmNo
IHRvIHRoZSBlcnIgbGFiZWwNCj4gc28gDQo+IHJjIG5lZWRzIHRvIGJlIHNldCB0byBhIHZhbGlk
IGVycm9yLg0KPiANCg0KT2sNCg0KPiANCj4gDQo+ID4gKw0KPiA+ICAgCWVsYXBzZWQgPSAwOw0K
PiA+ICAgCXRpbWVvdXQgPSBvY3hscG1lbS0+cmVhZGluZXNzX3RpbWVvdXQgKyBvY3hscG1lbS0N
Cj4gPiA+bWVtb3J5X2F2YWlsYWJsZV90aW1lb3V0Ow0KPiA+ICAgCXdoaWxlICghaXNfdXNhYmxl
KG9jeGxwbWVtLCBmYWxzZSkpIHsNCj4gPiBAQCAtNjEzLDIwICs2ODYsNTkgQEAgc3RhdGljIHN0
cnVjdCBwY2lfZHJpdmVyIHBjaV9kcml2ZXIgPSB7DQo+ID4gICAJLnNodXRkb3duID0gb2N4bHBt
ZW1fcmVtb3ZlLA0KPiA+ICAgfTsNCj4gPiAgIA0KPiA+ICtzdGF0aWMgaW50IGZpbGVfaW5pdCh2
b2lkKQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfaW5pdCgmbWlu
b3JzX2lkcl9sb2NrKTsNCj4gPiArCWlkcl9pbml0KCZtaW5vcnNfaWRyKTsNCj4gPiArDQo+ID4g
KwlyYyA9IGFsbG9jX2NocmRldl9yZWdpb24oJm9jeGxwbWVtX2RldiwgMCwgTlVNX01JTk9SUywg
Im9jeGwtDQo+ID4gcG1lbSIpOw0KPiA+ICsJaWYgKHJjKSB7DQo+ID4gKwkJaWRyX2Rlc3Ryb3ko
Jm1pbm9yc19pZHIpOw0KPiA+ICsJCXByX2VycigiVW5hYmxlIHRvIGFsbG9jYXRlIE9wZW5DQVBJ
IHBlcnNpc3RlbnQgbWVtb3J5DQo+ID4gbWFqb3IgbnVtYmVyOiAlZFxuIiwgcmMpOw0KPiA+ICsJ
CXJldHVybiByYzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlvY3hscG1lbV9jbGFzcyA9IGNsYXNz
X2NyZWF0ZShUSElTX01PRFVMRSwgIm9jeGwtcG1lbSIpOw0KPiA+ICsJaWYgKElTX0VSUihvY3hs
cG1lbV9jbGFzcykpIHsNCj4gPiArCQlpZHJfZGVzdHJveSgmbWlub3JzX2lkcik7DQo+ID4gKwkJ
cHJfZXJyKCJVbmFibGUgdG8gY3JlYXRlIG9jeGwtcG1lbSBjbGFzc1xuIik7DQo+ID4gKwkJdW5y
ZWdpc3Rlcl9jaHJkZXZfcmVnaW9uKG9jeGxwbWVtX2RldiwgTlVNX01JTk9SUyk7DQo+ID4gKwkJ
cmV0dXJuIFBUUl9FUlIob2N4bHBtZW1fY2xhc3MpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJl
dHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBmaWxlX2V4aXQodm9pZCkN
Cj4gPiArew0KPiA+ICsJY2xhc3NfZGVzdHJveShvY3hscG1lbV9jbGFzcyk7DQo+ID4gKwl1bnJl
Z2lzdGVyX2NocmRldl9yZWdpb24ob2N4bHBtZW1fZGV2LCBOVU1fTUlOT1JTKTsNCj4gPiArCWlk
cl9kZXN0cm95KCZtaW5vcnNfaWRyKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBpbnQg
X19pbml0IG9jeGxwbWVtX2luaXQodm9pZCkNCj4gPiAgIHsNCj4gPiAtCWludCByYyA9IDA7DQo+
ID4gKwlpbnQgcmM7DQo+ID4gICANCj4gPiAtCXJjID0gcGNpX3JlZ2lzdGVyX2RyaXZlcigmcGNp
X2RyaXZlcik7DQo+ID4gKwlyYyA9IGZpbGVfaW5pdCgpOw0KPiA+ICAgCWlmIChyYykNCj4gPiAg
IAkJcmV0dXJuIHJjOw0KPiA+ICAgDQo+ID4gKwlyYyA9IHBjaV9yZWdpc3Rlcl9kcml2ZXIoJnBj
aV9kcml2ZXIpOw0KPiA+ICsJaWYgKHJjKSB7DQo+ID4gKwkJZmlsZV9leGl0KCk7DQo+ID4gKwkJ
cmV0dXJuIHJjOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4g
PiAgIA0KPiA+ICAgc3RhdGljIHZvaWQgb2N4bHBtZW1fZXhpdCh2b2lkKQ0KPiA+ICAgew0KPiA+
ICAgCXBjaV91bnJlZ2lzdGVyX2RyaXZlcigmcGNpX2RyaXZlcik7DQo+ID4gKwlmaWxlX2V4aXQo
KTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+ICAgbW9kdWxlX2luaXQob2N4bHBtZW1faW5pdCk7DQo+
ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGxf
aW50ZXJuYWwuaA0KPiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4
bF9pbnRlcm5hbC5oDQo+ID4gaW5kZXggMjhlMjAyMGY2MzU1Li5kMmQ4MWZlYzdiYjEgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRl
cm5hbC5oDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4
bF9pbnRlcm5hbC5oDQo+ID4gQEAgLTIsNiArMiw3IEBADQo+ID4gICAvLyBDb3B5cmlnaHQgMjAx
OSBJQk0gQ29ycC4NCj4gPiAgIA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvY2Rldi5oPg0KPiA+ICAgI2luY2x1ZGUgPG1pc2Mvb2N4bC5oPg0KPiA+
ICAgI2luY2x1ZGUgPGxpbnV4L2xpYm52ZGltbS5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L21t
Lmg+DQo+ID4gQEAgLTk5LDYgKzEwMCw3IEBAIHN0cnVjdCBvY3hscG1lbV9mdW5jdGlvbjAgew0K
PiA+ICAgc3RydWN0IG9jeGxwbWVtIHsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlIGRldjsNCj4gPiAg
IAlzdHJ1Y3QgcGNpX2RldiAqcGRldjsNCj4gPiArCXN0cnVjdCBjZGV2IGNkZXY7DQo+ID4gICAJ
c3RydWN0IG9jeGxfZm4gKm9jeGxfZm47DQo+ID4gICAJc3RydWN0IG5kX2ludGVybGVhdmVfc2V0
IG5kX3NldDsNCj4gPiAgIAlzdHJ1Y3QgbnZkaW1tX2J1c19kZXNjcmlwdG9yIGJ1c19kZXNjOw0K
PiA+IA0KLS0gDQpBbGFzdGFpciBEJ1NpbHZhDQpPcGVuIFNvdXJjZSBEZXZlbG9wZXINCkxpbnV4
IFRlY2hub2xvZ3kgQ2VudHJlLCBJQk0gQXVzdHJhbGlhDQptb2I6IDA0MjMgNzYyIDgxOQ0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
