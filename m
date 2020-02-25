Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384516BE2D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 11:02:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6022A10FC3598;
	Tue, 25 Feb 2020 02:03:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B9C0B10FC33F9
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 02:03:22 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01P9x3LD135055
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 05:02:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yb00a8c8a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 05:02:29 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 25 Feb 2020 10:02:24 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 25 Feb 2020 10:02:17 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PA2F2N60620808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2020 10:02:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66A0A4203F;
	Tue, 25 Feb 2020 10:02:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430D34204D;
	Tue, 25 Feb 2020 10:02:14 +0000 (GMT)
Received: from pc-48.home (unknown [9.145.68.118])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2020 10:02:14 +0000 (GMT)
Subject: Re: [PATCH v3 03/27] powerpc: Map & release OpenCAPI LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-4-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 25 Feb 2020 11:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-4-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022510-0016-0000-0000-000002EA0F90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022510-0017-0000-0000-0000334D3A69
Message-Id: <69991128-3cf1-a8ba-4d9f-9ff90f1783db@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_02:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 suspectscore=2 adultscore=0 phishscore=0 mlxlogscore=610 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250081
Message-ID-Hash: OAHRYTDHADXCEYKR3T23V3OHKL44OYUN
X-Message-ID-Hash: OAHRYTDHADXCEYKR3T23V3OHKL44OYUN
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OAHRYTDHADXCEYKR3T23V3OHKL44OYUN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGFkZHMgcGxhdGZvcm0gc3VwcG9ydCB0byBtYXAgJiByZWxlYXNlIExQQyBtZW1v
cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNp
bHZhLm9yZz4NCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgg
ICB8ICA0ICsrKw0KPiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMgfCA0
MyArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ3IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
cG52LW9jeGwuaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+IGluZGV4
IDdkZTgyNjQ3ZTc2MS4uMGIyYTY3MDdlNTU1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMv
aW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
cG52LW9jeGwuaA0KPiBAQCAtMzIsNSArMzIsOSBAQCBleHRlcm4gaW50IHBudl9vY3hsX3NwYV9y
ZW1vdmVfcGVfZnJvbV9jYWNoZSh2b2lkICpwbGF0Zm9ybV9kYXRhLCBpbnQgcGVfaGFuZGxlKQ0K
PiAgIA0KPiAgIGV4dGVybiBpbnQgcG52X29jeGxfYWxsb2NfeGl2ZV9pcnEodTMyICppcnEsIHU2
NCAqdHJpZ2dlcl9hZGRyKTsNCj4gICBleHRlcm4gdm9pZCBwbnZfb2N4bF9mcmVlX3hpdmVfaXJx
KHUzMiBpcnEpOw0KPiArI2lmZGVmIENPTkZJR19NRU1PUllfSE9UUExVR19TUEFSU0UNCj4gK3U2
NCBwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU2NCBz
aXplKTsNCj4gK3ZvaWQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpOw0KPiArI2VuZGlmDQoNCg0KVGhpcyBicmVha3MgdGhlIGNvbXBpbGF0aW9uIG9m
IHRoZSBvY3hsIGRyaXZlciBpZiBDT05GSUdfTUVNT1JZX0hPVFBMVUc9bg0KDQpUaG9zZSBmdW5j
dGlvbnMgc3RpbGwgbWFrZSBzZW5zZSBldmVuIHdpdGhvdXQgbWVtb3J5IGhvdHBsdWcsIGZvciAN
CmV4YW1wbGUgaW4gdGhlIGNvbnRleHQgb2YgdGhlIGltcGxlbWVudGF0aW9uIHlvdSBoYWQgdG8g
YWNjZXNzIG9wZW5jYXBpIA0KTFBDIG1lbW9yeSB0aHJvdWdoIG1tYXAoKS4gVGhlICNpZmRlZiBp
cyByZWFsbHkgbmVlZGVkIG9ubHkgYXJvdW5kIHRoZSANCmNoZWNrX2hvdHBsdWdfbWVtb3J5X2Fk
ZHJlc3NhYmxlKCkgY2FsbC4NCg0KICAgRnJlZA0KDQoNCj4gICAjZW5kaWYgLyogX0FTTV9QTlZf
T0NYTF9IICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYv
b2N4bC5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYw0KPiBpbmRleCA4
YzY1YWFjZGE5YzguLmYyZWRiY2M2NzM2MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L29jeGwuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bv
d2VybnYvb2N4bC5jDQo+IEBAIC00NzUsNiArNDc1LDQ5IEBAIHZvaWQgcG52X29jeGxfc3BhX3Jl
bGVhc2Uodm9pZCAqcGxhdGZvcm1fZGF0YSkNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwo
cG52X29jeGxfc3BhX3JlbGVhc2UpOw0KPiAgIA0KPiArI2lmZGVmIENPTkZJR19NRU1PUllfSE9U
UExVR19TUEFSU0UNCj4gK3U2NCBwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAoc3RydWN0IHBj
aV9kZXYgKnBkZXYsIHU2NCBzaXplKQ0KPiArew0KPiArCXN0cnVjdCBwY2lfY29udHJvbGxlciAq
aG9zZSA9IHBjaV9idXNfdG9faG9zdChwZGV2LT5idXMpOw0KPiArCXN0cnVjdCBwbnZfcGhiICpw
aGIgPSBob3NlLT5wcml2YXRlX2RhdGE7DQo+ICsJdTMyIGJkZm4gPSBwY2lfZGV2X2lkKHBkZXYp
Ow0KPiArCV9fYmU2NCBiYXNlX2FkZHJfYmU2NDsNCj4gKwl1NjQgYmFzZV9hZGRyOw0KPiArCWlu
dCByYzsNCj4gKw0KPiArCXJjID0gb3BhbF9ucHVfbWVtX2FsbG9jKHBoYi0+b3BhbF9pZCwgYmRm
biwgc2l6ZSwgJmJhc2VfYWRkcl9iZTY0KTsNCj4gKwlpZiAocmMpIHsNCj4gKwkJZGV2X3dhcm4o
JnBkZXYtPmRldiwNCj4gKwkJCSAiT1BBTCBjb3VsZCBub3QgYWxsb2NhdGUgTFBDIG1lbW9yeSwg
cmM9JWRcbiIsIHJjKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICsJfQ0KPiArDQo+ICsJYmFzZV9hZGRy
ID0gYmU2NF90b19jcHUoYmFzZV9hZGRyX2JlNjQpOw0KPiArDQo+ICsJcmMgPSBjaGVja19ob3Rw
bHVnX21lbW9yeV9hZGRyZXNzYWJsZShiYXNlX2FkZHIgPj4gUEFHRV9TSElGVCwNCj4gKwkJCQkJ
ICAgICAgc2l6ZSA+PiBQQUdFX1NISUZUKTsNCj4gKwlpZiAocmMpDQo+ICsJCXJldHVybiAwOw0K
PiArDQo+ICsJcmV0dXJuIGJhc2VfYWRkcjsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBu
dl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cCk7DQo+ICsNCj4gK3ZvaWQgcG52X29jeGxfcGxhdGZv
cm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ICt7DQo+ICsJc3RydWN0IHBj
aV9jb250cm9sbGVyICpob3NlID0gcGNpX2J1c190b19ob3N0KHBkZXYtPmJ1cyk7DQo+ICsJc3Ry
dWN0IHBudl9waGIgKnBoYiA9IGhvc2UtPnByaXZhdGVfZGF0YTsNCj4gKwl1MzIgYmRmbiA9IHBj
aV9kZXZfaWQocGRldik7DQo+ICsJaW50IHJjOw0KPiArDQo+ICsJcmMgPSBvcGFsX25wdV9tZW1f
cmVsZWFzZShwaGItPm9wYWxfaWQsIGJkZm4pOw0KPiArCWlmIChyYykNCj4gKwkJZGV2X3dhcm4o
JnBkZXYtPmRldiwNCj4gKwkJCSAiT1BBTCByZXBvcnRlZCByYz0lZCB3aGVuIHJlbGVhc2luZyBM
UEMgbWVtb3J5XG4iLCByYyk7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChwbnZfb2N4bF9w
bGF0Zm9ybV9scGNfcmVsZWFzZSk7DQo+ICsjZW5kaWYNCj4gKw0KPiAgIGludCBwbnZfb2N4bF9z
cGFfcmVtb3ZlX3BlX2Zyb21fY2FjaGUodm9pZCAqcGxhdGZvcm1fZGF0YSwgaW50IHBlX2hhbmRs
ZSkNCj4gICB7DQo+ICAgCXN0cnVjdCBzcGFfZGF0YSAqZGF0YSA9IChzdHJ1Y3Qgc3BhX2RhdGEg
KikgcGxhdGZvcm1fZGF0YTsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
