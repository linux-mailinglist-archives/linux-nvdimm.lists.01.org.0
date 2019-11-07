Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E2F3674
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 18:59:48 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63CE5100EA622;
	Thu,  7 Nov 2019 10:02:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7FE6F100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 10:02:09 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7HlMBi134242
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 12:59:43 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w79420-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 12:59:43 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 17:59:40 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 17:59:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7HxUZr262566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 17:59:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 246C44C046;
	Thu,  7 Nov 2019 17:59:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFF9E4C044;
	Thu,  7 Nov 2019 17:59:28 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 17:59:28 +0000 (GMT)
Subject: Re: [PATCH 04/10] powerpc: Map & release OpenCAPI LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 18:59:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-5-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110717-0028-0000-0000-000003B3A27E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110717-0029-0000-0000-000024760386
Message-Id: <f947dca2-9be5-c9f5-6c55-5d4a92d1ec71@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070165
Message-ID-Hash: 24ZOWR5YBIZQIMB2EPT6F25MMGKPWTTC
X-Message-ID-Hash: 24ZOWR5YBIZQIMB2EPT6F25MMGKPWTTC
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Allison Randal <allison@lohutok.net>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pas
 ha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/24ZOWR5YBIZQIMB2EPT6F25MMGKPWTTC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGFkZHMgcGxhdGZvcm0gc3VwcG9ydCB0byBtYXAgJiByZWxlYXNlIExQQyBtZW1v
cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNp
bHZhLm9yZz4NCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgg
ICB8ICAyICsrDQo+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYyB8IDQx
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvbGludXgvbWVtb3J5X2hv
dHBsdWcuaCAgICAgICAgfCAgNSArKysrDQo+ICAgbW0vbWVtb3J5X2hvdHBsdWcuYyAgICAgICAg
ICAgICAgICAgICB8ICAzICstDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3Budi1vY3hsLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiBp
bmRleCA3ZGU4MjY0N2U3NjEuLmY4ZjhmZmI0OGFhOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL3Budi1vY3hsLmgNCj4gQEAgLTMyLDUgKzMyLDcgQEAgZXh0ZXJuIGludCBwbnZfb2N4bF9z
cGFfcmVtb3ZlX3BlX2Zyb21fY2FjaGUodm9pZCAqcGxhdGZvcm1fZGF0YSwgaW50IHBlX2hhbmRs
ZSkNCj4gICANCj4gICBleHRlcm4gaW50IHBudl9vY3hsX2FsbG9jX3hpdmVfaXJxKHUzMiAqaXJx
LCB1NjQgKnRyaWdnZXJfYWRkcik7DQo+ICAgZXh0ZXJuIHZvaWQgcG52X29jeGxfZnJlZV94aXZl
X2lycSh1MzIgaXJxKTsNCj4gK2V4dGVybiB1NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVw
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1NjQgc2l6ZSk7DQo+ICtleHRlcm4gdm9pZCBwbnZfb2N4
bF9wbGF0Zm9ybV9scGNfcmVsZWFzZShzdHJ1Y3QgcGNpX2RldiAqcGRldik7DQo+ICAgDQo+ICAg
I2VuZGlmIC8qIF9BU01fUE5WX09DWExfSCAqLw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJu
di9vY3hsLmMNCj4gaW5kZXggOGM2NWFhY2RhOWM4Li5jNmQ0MjM0ZTBhYmEgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gKysrIGIvYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYw0KPiBAQCAtNDc1LDYgKzQ3NSw0NyBAQCB2
b2lkIHBudl9vY3hsX3NwYV9yZWxlYXNlKHZvaWQgKnBsYXRmb3JtX2RhdGEpDQo+ICAgfQ0KPiAg
IEVYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3NwYV9yZWxlYXNlKTsNCj4gICANCj4gK3U2NCBw
bnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU2NCBzaXpl
KQ0KPiArew0KPiArCXN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSA9IHBjaV9idXNfdG9faG9z
dChwZGV2LT5idXMpOw0KPiArCXN0cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5wcml2YXRlX2Rh
dGE7DQo+ICsJdTMyIGJkZm4gPSAocGRldi0+YnVzLT5udW1iZXIgPDwgOCkgfCBwZGV2LT5kZXZm
bjsNCj4gKwl1NjQgYmFzZV9hZGRyID0gMDsNCj4gKwlpbnQgcmM7DQo+ICsNCj4gKwlyYyA9IG9w
YWxfbnB1X21lbV9hbGxvYyhwaGItPm9wYWxfaWQsIGJkZm4sIHNpemUsICZiYXNlX2FkZHIpOw0K
PiArCWlmIChyYykgew0KPiArCQlkZXZfd2FybigmcGRldi0+ZGV2LA0KPiArCQkJICJPUEFMIGNv
dWxkIG5vdCBhbGxvY2F0ZSBMUEMgbWVtb3J5LCByYz0lZFxuIiwgcmMpOw0KPiArCQlyZXR1cm4g
MDsNCj4gKwl9DQo+ICsNCj4gKwliYXNlX2FkZHIgPSBiZTY0X3RvX2NwdShiYXNlX2FkZHIpOw0K
PiArDQo+ICsJcmMgPSBjaGVja19ob3RwbHVnX21lbW9yeV9hZGRyZXNzYWJsZShiYXNlX2FkZHIg
Pj4gUEFHRV9TSElGVCwNCj4gKwkJCQkJICAgICAgc2l6ZSA+PiBQQUdFX1NISUZUKTsNCj4gKwlp
ZiAocmMpDQo+ICsJCXJldHVybiAwOw0KPiArDQo+ICsJcmV0dXJuIGJhc2VfYWRkcjsNCj4gK30N
Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cCk7DQo+ICsN
Cj4gK3ZvaWQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBk
ZXYpDQo+ICt7DQo+ICsJc3RydWN0IHBjaV9jb250cm9sbGVyICpob3NlID0gcGNpX2J1c190b19o
b3N0KHBkZXYtPmJ1cyk7DQo+ICsJc3RydWN0IHBudl9waGIgKnBoYiA9IGhvc2UtPnByaXZhdGVf
ZGF0YTsNCj4gKwl1MzIgYmRmbiA9IChwZGV2LT5idXMtPm51bWJlciA8PCA4KSB8IHBkZXYtPmRl
dmZuOw0KPiArCWludCByYzsNCj4gKw0KPiArCXJjID0gb3BhbF9ucHVfbWVtX3JlbGVhc2UocGhi
LT5vcGFsX2lkLCBiZGZuKTsNCj4gKwlpZiAocmMpDQo+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYs
DQo+ICsJCQkgIk9QQUwgcmVwb3J0ZWQgcmM9JWQgd2hlbiByZWxlYXNpbmcgTFBDIG1lbW9yeVxu
IiwgcmMpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwocG52X29jeGxfcGxhdGZvcm1fbHBj
X3JlbGVhc2UpOw0KPiArDQo+ICsNCj4gICBpbnQgcG52X29jeGxfc3BhX3JlbW92ZV9wZV9mcm9t
X2NhY2hlKHZvaWQgKnBsYXRmb3JtX2RhdGEsIGludCBwZV9oYW5kbGUpDQo+ICAgew0KPiAgIAlz
dHJ1Y3Qgc3BhX2RhdGEgKmRhdGEgPSAoc3RydWN0IHNwYV9kYXRhICopIHBsYXRmb3JtX2RhdGE7
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmggYi9pbmNsdWRl
L2xpbnV4L21lbW9yeV9ob3RwbHVnLmgNCj4gaW5kZXggZjQ2ZWE3MWI0ZmZkLi4zZjVmMWE2NDJh
YmUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L21lbW9yeV9ob3RwbHVnLmgNCj4gQEAgLTMzOSw2ICszMzksMTEgQEAg
c3RhdGljIGlubGluZSBpbnQgcmVtb3ZlX21lbW9yeShpbnQgbmlkLCB1NjQgc3RhcnQsIHU2NCBz
aXplKQ0KPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBfX3JlbW92ZV9tZW1vcnkoaW50IG5pZCwgdTY0
IHN0YXJ0LCB1NjQgc2l6ZSkge30NCj4gICAjZW5kaWYgLyogQ09ORklHX01FTU9SWV9IT1RSRU1P
VkUgKi8NCj4gICANCj4gKyNpZiBDT05GSUdfTUVNT1JZX0hPVFBMVUdfU1BBUlNFDQo+ICtpbnQg
Y2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUodW5zaWduZWQgbG9uZyBwZm4sDQo+ICsJ
CXVuc2lnbmVkIGxvbmcgbnJfcGFnZXMpOw0KPiArI2VuZGlmIC8qIENPTkZJR19NRU1PUllfSE9U
UExVR19TUEFSU0UgKi8NCj4gKw0KPiAgIGV4dGVybiB2b2lkIF9fcmVmIGZyZWVfYXJlYV9pbml0
X2NvcmVfaG90cGx1ZyhpbnQgbmlkKTsNCj4gICBleHRlcm4gaW50IF9fYWRkX21lbW9yeShpbnQg
bmlkLCB1NjQgc3RhcnQsIHU2NCBzaXplKTsNCj4gICBleHRlcm4gaW50IGFkZF9tZW1vcnkoaW50
IG5pZCwgdTY0IHN0YXJ0LCB1NjQgc2l6ZSk7DQo+IGRpZmYgLS1naXQgYS9tbS9tZW1vcnlfaG90
cGx1Zy5jIGIvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiBpbmRleCAyY2VjZjA3YjM5NmYuLmIzOTgy
N2RiZDA3MSAxMDA2NDQNCj4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiArKysgYi9tbS9t
ZW1vcnlfaG90cGx1Zy5jDQo+IEBAIC0yNzgsNyArMjc4LDcgQEAgc3RhdGljIGludCBjaGVja19w
Zm5fc3Bhbih1bnNpZ25lZCBsb25nIHBmbiwgdW5zaWduZWQgbG9uZyBucl9wYWdlcywNCj4gICAJ
cmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBjaGVja19ob3RwbHVnX21lbW9y
eV9hZGRyZXNzYWJsZSh1bnNpZ25lZCBsb25nIHBmbiwNCj4gK2ludCBjaGVja19ob3RwbHVnX21l
bW9yeV9hZGRyZXNzYWJsZSh1bnNpZ25lZCBsb25nIHBmbiwNCj4gICAJCQkJCSAgICB1bnNpZ25l
ZCBsb25nIG5yX3BhZ2VzKQ0KPiAgIHsNCj4gICAJY29uc3QgdTY0IG1heF9hZGRyID0gUEZOX1BI
WVMocGZuICsgbnJfcGFnZXMpIC0gMTsNCj4gQEAgLTI5NCw2ICsyOTQsNyBAQCBzdGF0aWMgaW50
IGNoZWNrX2hvdHBsdWdfbWVtb3J5X2FkZHJlc3NhYmxlKHVuc2lnbmVkIGxvbmcgcGZuLA0KPiAg
IA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChjaGVja19ob3Rw
bHVnX21lbW9yeV9hZGRyZXNzYWJsZSk7DQoNCg0KTWFraW5nIGNoZWNrX2hvdHBsdWdfbWVtb3J5
X2FkZHJlc3NhYmxlKCkgdmlzaWJsZSBpbiB0aGUga2VybmVsIGNvdWxkIGJlIA0KYSBzZXBhcmF0
ZSBwYXRjaCwgdG8gbWFrZSBzdXJlIGl0IGdldHMgdGhlIHByb3BlciBhdHRlbnRpb24gaW5zdGVh
ZCBvZiANCmJlaW5nIGJ1cmllZCBpbiBhIHBvd2VycGMgcGF0Y2guDQpBbHNvLCBhbHJlYWR5IG1l
bnRpb25lZCwgYnV0IGl0IHNob3VsZG4ndCBiZSBleHBvcnRlZC4NCg0KDQo+ICAgDQo+ICAgLyoN
Cj4gICAgKiBSZWFzb25hYmx5IGdlbmVyaWMgZnVuY3Rpb24gZm9yIGFkZGluZyBtZW1vcnkuICBJ
dCBpcw0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
