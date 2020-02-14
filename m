Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E768F15D64A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Feb 2020 12:09:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDC5210FC33FB;
	Fri, 14 Feb 2020 03:12:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0EA3510FC33ED
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 03:12:32 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EB4hjq036163
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 06:09:15 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j88jyru-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 14 Feb 2020 06:09:14 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Fri, 14 Feb 2020 11:09:12 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 14 Feb 2020 11:09:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01EB94aI55640210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2020 11:09:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 787A5A405B;
	Fri, 14 Feb 2020 11:09:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74ADFA406A;
	Fri, 14 Feb 2020 11:09:03 +0000 (GMT)
Received: from pic2.home (unknown [9.145.28.205])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2020 11:09:03 +0000 (GMT)
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203034655.51561-6-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 14 Feb 2020 12:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191203034655.51561-6-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20021411-0020-0000-0000-000003AA12A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021411-0021-0000-0000-000022020116
Message-Id: <85e5a3d4-bac2-a8fc-8fc7-865be539dc3c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_03:2020-02-12,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=2 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140091
Message-ID-Hash: MAK2TWF6YXAHKBXFE2HTSM2DKS45WS6Z
X-Message-ID-Hash: MAK2TWF6YXAHKBXFE2HTSM2DKS45WS6Z
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linu
 x-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MAK2TWF6YXAHKBXFE2HTSM2DKS45WS6Z/>
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
bHZhLm9yZz4NCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgg
ICB8ICAyICsrDQo+ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYyB8IDQy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9w
bnYtb2N4bC5oIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gaW5kZXgg
N2RlODI2NDdlNzYxLi5mOGY4ZmZiNDhhYTggMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9p
bmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9w
bnYtb2N4bC5oDQo+IEBAIC0zMiw1ICszMiw3IEBAIGV4dGVybiBpbnQgcG52X29jeGxfc3BhX3Jl
bW92ZV9wZV9mcm9tX2NhY2hlKHZvaWQgKnBsYXRmb3JtX2RhdGEsIGludCBwZV9oYW5kbGUpDQo+
ICAgDQo+ICAgZXh0ZXJuIGludCBwbnZfb2N4bF9hbGxvY194aXZlX2lycSh1MzIgKmlycSwgdTY0
ICp0cmlnZ2VyX2FkZHIpOw0KPiAgIGV4dGVybiB2b2lkIHBudl9vY3hsX2ZyZWVfeGl2ZV9pcnEo
dTMyIGlycSk7DQo+ICtleHRlcm4gdTY0IHBudl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cChzdHJ1
Y3QgcGNpX2RldiAqcGRldiwgdTY0IHNpemUpOw0KPiArZXh0ZXJuIHZvaWQgcG52X29jeGxfcGxh
dGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiAgIA0KPiAgICNlbmRp
ZiAvKiBfQVNNX1BOVl9PQ1hMX0ggKi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcG93ZXJudi9vY3hsLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4
bC5jDQo+IGluZGV4IDhjNjVhYWNkYTljOC4uYjU2YTQ4ZGFmNDhjIDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4bC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gQEAgLTQ3NSw2ICs0NzUsNDggQEAgdm9pZCBw
bnZfb2N4bF9zcGFfcmVsZWFzZSh2b2lkICpwbGF0Zm9ybV9kYXRhKQ0KPiAgIH0NCj4gICBFWFBP
UlRfU1lNQk9MX0dQTChwbnZfb2N4bF9zcGFfcmVsZWFzZSk7DQo+ICAgDQo+ICt1NjQgcG52X29j
eGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCB1NjQgc2l6ZSkNCj4g
K3sNCj4gKwlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UgPSBwY2lfYnVzX3RvX2hvc3QocGRl
di0+YnVzKTsNCj4gKwlzdHJ1Y3QgcG52X3BoYiAqcGhiID0gaG9zZS0+cHJpdmF0ZV9kYXRhOw0K
PiArCXUzMiBiZGZuID0gcGNpX2Rldl9pZChwZGV2KTsNCj4gKwlfX2JlNjQgYmFzZV9hZGRyX2Jl
NjQ7DQo+ICsJdTY0IGJhc2VfYWRkcjsNCj4gKwlpbnQgcmM7DQo+ICsNCj4gKwlyYyA9IG9wYWxf
bnB1X21lbV9hbGxvYyhwaGItPm9wYWxfaWQsIGJkZm4sIHNpemUsICZiYXNlX2FkZHJfYmU2NCk7
DQo+ICsJaWYgKHJjKSB7DQo+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsDQo+ICsJCQkgIk9QQUwg
Y291bGQgbm90IGFsbG9jYXRlIExQQyBtZW1vcnksIHJjPSVkXG4iLCByYyk7DQo+ICsJCXJldHVy
biAwOw0KPiArCX0NCj4gKw0KPiArCWJhc2VfYWRkciA9IGJlNjRfdG9fY3B1KGJhc2VfYWRkcl9i
ZTY0KTsNCj4gKw0KPiArCXJjID0gY2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoYmFz
ZV9hZGRyID4+IFBBR0VfU0hJRlQsDQo+ICsJCQkJCSAgICAgIHNpemUgPj4gUEFHRV9TSElGVCk7
DQoNCg0KY2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoKSBpcyBvbmx5IGRlY2xhcmVk
IGlmIA0KQ09ORklHX01FTU9SWV9IT1RQTFVHX1NQQVJTRSBpcyBzZWxlY3RlZC4NCkkgdGhpbmsg
d2UgYWxzbyBuZWVkIGEgI2lmZGVmIGhlcmUuDQoNCiAgIEZyZWQNCg0KDQo+ICsJaWYgKHJjKQ0K
PiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCXJldHVybiBiYXNlX2FkZHI7DQo+ICt9DQo+ICtFWFBP
UlRfU1lNQk9MX0dQTChwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXApOw0KPiArDQo+ICt2b2lk
IHBudl9vY3hsX3BsYXRmb3JtX2xwY19yZWxlYXNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiAr
ew0KPiArCXN0cnVjdCBwY2lfY29udHJvbGxlciAqaG9zZSA9IHBjaV9idXNfdG9faG9zdChwZGV2
LT5idXMpOw0KPiArCXN0cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5wcml2YXRlX2RhdGE7DQo+
ICsJdTMyIGJkZm4gPSBwY2lfZGV2X2lkKHBkZXYpOw0KPiArCWludCByYzsNCj4gKw0KPiArCXJj
ID0gb3BhbF9ucHVfbWVtX3JlbGVhc2UocGhiLT5vcGFsX2lkLCBiZGZuKTsNCj4gKwlpZiAocmMp
DQo+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsDQo+ICsJCQkgIk9QQUwgcmVwb3J0ZWQgcmM9JWQg
d2hlbiByZWxlYXNpbmcgTFBDIG1lbW9yeVxuIiwgcmMpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJP
TF9HUEwocG52X29jeGxfcGxhdGZvcm1fbHBjX3JlbGVhc2UpOw0KPiArDQo+ICsNCj4gICBpbnQg
cG52X29jeGxfc3BhX3JlbW92ZV9wZV9mcm9tX2NhY2hlKHZvaWQgKnBsYXRmb3JtX2RhdGEsIGlu
dCBwZV9oYW5kbGUpDQo+ICAgew0KPiAgIAlzdHJ1Y3Qgc3BhX2RhdGEgKmRhdGEgPSAoc3RydWN0
IHNwYV9kYXRhICopIHBsYXRmb3JtX2RhdGE7DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51
eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGlu
dXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
