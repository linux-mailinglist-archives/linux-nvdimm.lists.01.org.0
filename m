Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADF16F426
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 01:19:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AE2410FC36CD;
	Tue, 25 Feb 2020 16:20:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E2E9310FC36CD
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 16:20:10 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q0E5nd034484
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:19:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcnbt5tf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:19:18 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 26 Feb 2020 00:19:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 26 Feb 2020 00:19:08 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q0J7EO62914758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2020 00:19:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ECAD11C050;
	Wed, 26 Feb 2020 00:19:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC63211C04A;
	Wed, 26 Feb 2020 00:19:06 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2020 00:19:06 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 18A29A00F1;
	Wed, 26 Feb 2020 11:19:02 +1100 (AEDT)
Subject: Re: [PATCH v3 03/27] powerpc: Map & release OpenCAPI LPC memory
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 26 Feb 2020 11:19:05 +1100
In-Reply-To: <69991128-3cf1-a8ba-4d9f-9ff90f1783db@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-4-alastair@au1.ibm.com>
	 <69991128-3cf1-a8ba-4d9f-9ff90f1783db@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022600-0020-0000-0000-000003AD9382
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022600-0021-0000-0000-00002205ABB7
Message-Id: <20f0a729962c1fe58f34f500c2666b4516073508.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_09:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=462
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260000
Message-ID-Hash: V65AT5ING7RSHNDTFTYUV6VCLEIFDHAE
X-Message-ID-Hash: V65AT5ING7RSHNDTFTYUV6VCLEIFDHAE
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-
 dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V65AT5ING7RSHNDTFTYUV6VCLEIFDHAE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDExOjAyICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyMS8wMi8yMDIwIMOgIDA0OjI2LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgcGxhdGZvcm0gc3VwcG9ydCB0byBtYXAgJiByZWxlYXNl
IExQQyBtZW1vcnkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3RhaXIgRCdTaWx2YSA8
YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gLS0tDQo+ID4gICBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vcG52LW9jeGwuaCAgIHwgIDQgKysrDQo+ID4gICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1z
L3Bvd2VybnYvb2N4bC5jIHwgNDMNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiA+IGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gPiBpbmRleCA3ZGU4MjY0N2U3NjEuLjBiMmE2
NzA3ZTU1NSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52LW9j
eGwuaA0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+ID4g
QEAgLTMyLDUgKzMyLDkgQEAgZXh0ZXJuIGludCBwbnZfb2N4bF9zcGFfcmVtb3ZlX3BlX2Zyb21f
Y2FjaGUodm9pZA0KPiA+ICpwbGF0Zm9ybV9kYXRhLCBpbnQgcGVfaGFuZGxlKQ0KPiA+ICAgDQo+
ID4gICBleHRlcm4gaW50IHBudl9vY3hsX2FsbG9jX3hpdmVfaXJxKHUzMiAqaXJxLCB1NjQgKnRy
aWdnZXJfYWRkcik7DQo+ID4gICBleHRlcm4gdm9pZCBwbnZfb2N4bF9mcmVlX3hpdmVfaXJxKHUz
MiBpcnEpOw0KPiA+ICsjaWZkZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHX1NQQVJTRQ0KPiA+ICt1
NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1NjQg
c2l6ZSk7DQo+ID4gK3ZvaWQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBj
aV9kZXYgKnBkZXYpOw0KPiA+ICsjZW5kaWYNCj4gDQo+IFRoaXMgYnJlYWtzIHRoZSBjb21waWxh
dGlvbiBvZiB0aGUgb2N4bCBkcml2ZXIgaWYNCj4gQ09ORklHX01FTU9SWV9IT1RQTFVHPW4NCj4g
DQo+IFRob3NlIGZ1bmN0aW9ucyBzdGlsbCBtYWtlIHNlbnNlIGV2ZW4gd2l0aG91dCBtZW1vcnkg
aG90cGx1ZywgZm9yIA0KPiBleGFtcGxlIGluIHRoZSBjb250ZXh0IG9mIHRoZSBpbXBsZW1lbnRh
dGlvbiB5b3UgaGFkIHRvIGFjY2Vzcw0KPiBvcGVuY2FwaSANCj4gTFBDIG1lbW9yeSB0aHJvdWdo
IG1tYXAoKS4gVGhlICNpZmRlZiBpcyByZWFsbHkgbmVlZGVkIG9ubHkgYXJvdW5kDQo+IHRoZSAN
Cj4gY2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoKSBjYWxsLg0KPiANCj4gICAgRnJl
ZA0KDQpIbW0sIHdlIGRvIHN0aWxsIG5lZWQgc3BhcnNlbWVtIHRob3VnaC4gTGV0IG1lIHRoaW5r
IGFib3V0IGhpcyBzb21lDQptb3JlLg0KDQo+IA0KPiANCj4gPiAgICNlbmRpZiAvKiBfQVNNX1BO
Vl9PQ1hMX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dl
cm52L29jeGwuYw0KPiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYw0K
PiA+IGluZGV4IDhjNjVhYWNkYTljOC4uZjJlZGJjYzY3MzYxIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gPiArKysgYi9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4bC5jDQo+ID4gQEAgLTQ3NSw2ICs0NzUsNDkgQEAgdm9p
ZCBwbnZfb2N4bF9zcGFfcmVsZWFzZSh2b2lkICpwbGF0Zm9ybV9kYXRhKQ0KPiA+ICAgfQ0KPiA+
ICAgRVhQT1JUX1NZTUJPTF9HUEwocG52X29jeGxfc3BhX3JlbGVhc2UpOw0KPiA+ICAgDQo+ID4g
KyNpZmRlZiBDT05GSUdfTUVNT1JZX0hPVFBMVUdfU1BBUlNFDQo+ID4gK3U2NCBwbnZfb2N4bF9w
bGF0Zm9ybV9scGNfc2V0dXAoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU2NCBzaXplKQ0KPiA+ICt7
DQo+ID4gKwlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UgPSBwY2lfYnVzX3RvX2hvc3QocGRl
di0+YnVzKTsNCj4gPiArCXN0cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5wcml2YXRlX2RhdGE7
DQo+ID4gKwl1MzIgYmRmbiA9IHBjaV9kZXZfaWQocGRldik7DQo+ID4gKwlfX2JlNjQgYmFzZV9h
ZGRyX2JlNjQ7DQo+ID4gKwl1NjQgYmFzZV9hZGRyOw0KPiA+ICsJaW50IHJjOw0KPiA+ICsNCj4g
PiArCXJjID0gb3BhbF9ucHVfbWVtX2FsbG9jKHBoYi0+b3BhbF9pZCwgYmRmbiwgc2l6ZSwNCj4g
PiAmYmFzZV9hZGRyX2JlNjQpOw0KPiA+ICsJaWYgKHJjKSB7DQo+ID4gKwkJZGV2X3dhcm4oJnBk
ZXYtPmRldiwNCj4gPiArCQkJICJPUEFMIGNvdWxkIG5vdCBhbGxvY2F0ZSBMUEMgbWVtb3J5LCBy
Yz0lZFxuIiwNCj4gPiByYyk7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJYmFzZV9hZGRyID0gYmU2NF90b19jcHUoYmFzZV9hZGRyX2JlNjQpOw0KPiA+ICsNCj4gPiAr
CXJjID0gY2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoYmFzZV9hZGRyID4+IFBBR0Vf
U0hJRlQsDQo+ID4gKwkJCQkJICAgICAgc2l6ZSA+PiBQQUdFX1NISUZUKTsNCj4gPiArCWlmIChy
YykNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYmFzZV9hZGRyOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cCk7
DQo+ID4gKw0KPiA+ICt2b2lkIHBudl9vY3hsX3BsYXRmb3JtX2xwY19yZWxlYXNlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2Ug
PSBwY2lfYnVzX3RvX2hvc3QocGRldi0+YnVzKTsNCj4gPiArCXN0cnVjdCBwbnZfcGhiICpwaGIg
PSBob3NlLT5wcml2YXRlX2RhdGE7DQo+ID4gKwl1MzIgYmRmbiA9IHBjaV9kZXZfaWQocGRldik7
DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0KPiA+ICsJcmMgPSBvcGFsX25wdV9tZW1fcmVsZWFzZShw
aGItPm9wYWxfaWQsIGJkZm4pOw0KPiA+ICsJaWYgKHJjKQ0KPiA+ICsJCWRldl93YXJuKCZwZGV2
LT5kZXYsDQo+ID4gKwkJCSAiT1BBTCByZXBvcnRlZCByYz0lZCB3aGVuIHJlbGVhc2luZyBMUEMN
Cj4gPiBtZW1vcnlcbiIsIHJjKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwbnZf
b2N4bF9wbGF0Zm9ybV9scGNfcmVsZWFzZSk7DQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgIGlu
dCBwbnZfb2N4bF9zcGFfcmVtb3ZlX3BlX2Zyb21fY2FjaGUodm9pZCAqcGxhdGZvcm1fZGF0YSwg
aW50DQo+ID4gcGVfaGFuZGxlKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBzcGFfZGF0YSAqZGF0
YSA9IChzdHJ1Y3Qgc3BhX2RhdGEgKikgcGxhdGZvcm1fZGF0YTsNCj4gPiANCi0tIA0KQWxhc3Rh
aXIgRCdTaWx2YQ0KT3BlbiBTb3VyY2UgRGV2ZWxvcGVyDQpMaW51eCBUZWNobm9sb2d5IENlbnRy
ZSwgSUJNIEF1c3RyYWxpYQ0KbW9iOiAwNDIzIDc2MiA4MTkNCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
