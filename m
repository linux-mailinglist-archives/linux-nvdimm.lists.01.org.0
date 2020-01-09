Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF7135B96
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 15:42:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1AC6B10097DF4;
	Thu,  9 Jan 2020 06:46:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DB1F10097F35
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 06:46:03 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009EgIQb041320
	for <linux-nvdimm@lists.01.org>; Thu, 9 Jan 2020 09:42:44 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xe2h0s8cq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 09:42:43 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 9 Jan 2020 14:41:50 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 Jan 2020 14:41:44 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009Eesn145482480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2020 14:40:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FDB6A405B;
	Thu,  9 Jan 2020 14:41:42 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED23A4051;
	Thu,  9 Jan 2020 14:41:41 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2020 14:41:41 +0000 (GMT)
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203034655.51561-6-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 9 Jan 2020 15:41:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203034655.51561-6-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010914-0028-0000-0000-000003CFAE9E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010914-0029-0000-0000-00002493C478
Message-Id: <d7b9741e-ddf5-024a-6f63-0e957e240c6d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 clxscore=1011
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxlogscore=833
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001090129
Message-ID-Hash: XKJGVMLZKHT3WOT6SSXJ5ZKLVNSTMA5L
X-Message-ID-Hash: XKJGVMLZKHT3WOT6SSXJ5ZKLVNSTMA5L
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linu
 x-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XKJGVMLZKHT3WOT6SSXJ5ZKLVNSTMA5L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDAzLzEyLzIwMTkgw6AgMDQ6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGFkZHMgcGxhdGZvcm0gc3VwcG9ydCB0byBtYXAgJiByZWxlYXNlIExQQyBtZW1v
cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNp
bHZhLm9yZz4NCj4gLS0tDQoNCg0KSXQgbG9va3Mgb2sgbm93LCB0aGFua3MNCkFja2VkLWJ5OiBG
cmVkZXJpYyBCYXJyYXQgPGZiYXJyYXRAbGludXguaWJtLmNvbT4NCg0KDQo+ICAgYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmggICB8ICAyICsrDQo+ICAgYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L29jeGwuYyB8IDQyICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oIGIvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL3Budi1vY3hsLmgNCj4gaW5kZXggN2RlODI2NDdlNzYxLi5mOGY4ZmZiNDhhYTggMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+ICsrKyBi
L2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+IEBAIC0zMiw1ICszMiw3IEBA
IGV4dGVybiBpbnQgcG52X29jeGxfc3BhX3JlbW92ZV9wZV9mcm9tX2NhY2hlKHZvaWQgKnBsYXRm
b3JtX2RhdGEsIGludCBwZV9oYW5kbGUpDQo+ICAgDQo+ICAgZXh0ZXJuIGludCBwbnZfb2N4bF9h
bGxvY194aXZlX2lycSh1MzIgKmlycSwgdTY0ICp0cmlnZ2VyX2FkZHIpOw0KPiAgIGV4dGVybiB2
b2lkIHBudl9vY3hsX2ZyZWVfeGl2ZV9pcnEodTMyIGlycSk7DQo+ICtleHRlcm4gdTY0IHBudl9v
Y3hsX3BsYXRmb3JtX2xwY19zZXR1cChzdHJ1Y3QgcGNpX2RldiAqcGRldiwgdTY0IHNpemUpOw0K
PiArZXh0ZXJuIHZvaWQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9k
ZXYgKnBkZXYpOw0KPiAgIA0KPiAgICNlbmRpZiAvKiBfQVNNX1BOVl9PQ1hMX0ggKi8NCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMgYi9hcmNoL3Bv
d2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4bC5jDQo+IGluZGV4IDhjNjVhYWNkYTljOC4uYjU2
YTQ4ZGFmNDhjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYv
b2N4bC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4g
QEAgLTQ3NSw2ICs0NzUsNDggQEAgdm9pZCBwbnZfb2N4bF9zcGFfcmVsZWFzZSh2b2lkICpwbGF0
Zm9ybV9kYXRhKQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChwbnZfb2N4bF9zcGFfcmVs
ZWFzZSk7DQo+ICAgDQo+ICt1NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LCB1NjQgc2l6ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIg
Kmhvc2UgPSBwY2lfYnVzX3RvX2hvc3QocGRldi0+YnVzKTsNCj4gKwlzdHJ1Y3QgcG52X3BoYiAq
cGhiID0gaG9zZS0+cHJpdmF0ZV9kYXRhOw0KPiArCXUzMiBiZGZuID0gcGNpX2Rldl9pZChwZGV2
KTsNCj4gKwlfX2JlNjQgYmFzZV9hZGRyX2JlNjQ7DQo+ICsJdTY0IGJhc2VfYWRkcjsNCj4gKwlp
bnQgcmM7DQo+ICsNCj4gKwlyYyA9IG9wYWxfbnB1X21lbV9hbGxvYyhwaGItPm9wYWxfaWQsIGJk
Zm4sIHNpemUsICZiYXNlX2FkZHJfYmU2NCk7DQo+ICsJaWYgKHJjKSB7DQo+ICsJCWRldl93YXJu
KCZwZGV2LT5kZXYsDQo+ICsJCQkgIk9QQUwgY291bGQgbm90IGFsbG9jYXRlIExQQyBtZW1vcnks
IHJjPSVkXG4iLCByYyk7DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4gKw0KPiArCWJhc2VfYWRk
ciA9IGJlNjRfdG9fY3B1KGJhc2VfYWRkcl9iZTY0KTsNCj4gKw0KPiArCXJjID0gY2hlY2tfaG90
cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoYmFzZV9hZGRyID4+IFBBR0VfU0hJRlQsDQo+ICsJCQkJ
CSAgICAgIHNpemUgPj4gUEFHRV9TSElGVCk7DQo+ICsJaWYgKHJjKQ0KPiArCQlyZXR1cm4gMDsN
Cj4gKw0KPiArCXJldHVybiBiYXNlX2FkZHI7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChw
bnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXApOw0KPiArDQo+ICt2b2lkIHBudl9vY3hsX3BsYXRm
b3JtX2xwY19yZWxlYXNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBw
Y2lfY29udHJvbGxlciAqaG9zZSA9IHBjaV9idXNfdG9faG9zdChwZGV2LT5idXMpOw0KPiArCXN0
cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5wcml2YXRlX2RhdGE7DQo+ICsJdTMyIGJkZm4gPSBw
Y2lfZGV2X2lkKHBkZXYpOw0KPiArCWludCByYzsNCj4gKw0KPiArCXJjID0gb3BhbF9ucHVfbWVt
X3JlbGVhc2UocGhiLT5vcGFsX2lkLCBiZGZuKTsNCj4gKwlpZiAocmMpDQo+ICsJCWRldl93YXJu
KCZwZGV2LT5kZXYsDQo+ICsJCQkgIk9QQUwgcmVwb3J0ZWQgcmM9JWQgd2hlbiByZWxlYXNpbmcg
TFBDIG1lbW9yeVxuIiwgcmMpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTF9HUEwocG52X29jeGxf
cGxhdGZvcm1fbHBjX3JlbGVhc2UpOw0KPiArDQo+ICsNCj4gICBpbnQgcG52X29jeGxfc3BhX3Jl
bW92ZV9wZV9mcm9tX2NhY2hlKHZvaWQgKnBsYXRmb3JtX2RhdGEsIGludCBwZV9oYW5kbGUpDQo+
ICAgew0KPiAgIAlzdHJ1Y3Qgc3BhX2RhdGEgKmRhdGEgPSAoc3RydWN0IHNwYV9kYXRhICopIHBs
YXRmb3JtX2RhdGE7DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
