Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE845135BAB
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 15:49:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B015010097DB5;
	Thu,  9 Jan 2020 06:52:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED08B10097DAF
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 06:52:45 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Eg1P7147412
	for <linux-nvdimm@lists.01.org>; Thu, 9 Jan 2020 09:49:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xe3j8q2vm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 09:49:25 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 9 Jan 2020 14:49:23 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 Jan 2020 14:49:16 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009EnEKT24117396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2020 14:49:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7DCEA4055;
	Thu,  9 Jan 2020 14:49:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CDA6A404D;
	Thu,  9 Jan 2020 14:49:13 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2020 14:49:13 +0000 (GMT)
Subject: Re: [PATCH v2 07/27] ocxl: Add functions to map/unmap LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203034655.51561-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 9 Jan 2020 15:49:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203034655.51561-8-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010914-0028-0000-0000-000003CFAF34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010914-0029-0000-0000-00002493C514
Message-Id: <a3a366f7-f2fd-6203-4b80-c7e4f5de24c0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090129
Message-ID-Hash: FZPIA3JC7O3IBCAU52TKY2FQKEEZNIQG
X-Message-ID-Hash: FZPIA3JC7O3IBCAU52TKY2FQKEEZNIQG
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linu
 x-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FZPIA3JC7O3IBCAU52TKY2FQKEEZNIQG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDAzLzEyLzIwMTkgw6AgMDQ6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBB
ZGQgZnVuY3Rpb25zIHRvIG1hcC91bm1hcCBMUEMgbWVtb3J5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gLS0tDQo+ICAgZHJp
dmVycy9taXNjL29jeGwvY29uZmlnLmMgICAgICAgIHwgIDQgKysrDQo+ICAgZHJpdmVycy9taXNj
L29jeGwvY29yZS5jICAgICAgICAgIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIGRyaXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaCB8ICAzICsrDQo+ICAgaW5j
bHVkZS9taXNjL29jeGwuaCAgICAgICAgICAgICAgIHwgMTggKysrKysrKysrKysNCj4gICA0IGZp
bGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21pc2Mvb2N4bC9jb25maWcuYyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5jDQo+IGluZGV4
IGM4ZTE5YmZiNWVmOS4uZmIwYzNiNmY4MzEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2Mv
b2N4bC9jb25maWcuYw0KPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYw0KPiBAQCAt
NTY4LDYgKzU2OCwxMCBAQCBzdGF0aWMgaW50IHJlYWRfYWZ1X2xwY19tZW1vcnlfaW5mbyhzdHJ1
Y3QgcGNpX2RldiAqZGV2LA0KPiAgIAkJYWZ1LT5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUgPQ0K
PiAgIAkJCXRvdGFsX21lbV9zaXplIC0gbHBjX21lbV9zaXplOw0KPiAgIAl9DQo+ICsNCj4gKwlk
ZXZfaW5mbygmZGV2LT5kZXYsICJQcm9iZWQgTFBDIG1lbW9yeSBvZiAlI2xseCBieXRlcyBhbmQg
c3BlY2lhbCBwdXJwb3NlIG1lbW9yeSBvZiAlI2xseCBieXRlc1xuIiwNCj4gKwkJYWZ1LT5scGNf
bWVtX3NpemUsIGFmdS0+c3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKTsNCj4gKw0KPiAgIAlyZXR1
cm4gMDsNCj4gICB9DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mvb2N4bC9jb3Jl
LmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gaW5kZXggMjUzMWM2Y2YxOWEwLi45ODYx
MWZhZWEyMTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gQEAgLTIxMCw2ICsyMTAsNTUgQEAgc3RhdGlj
IHZvaWQgdW5tYXBfbW1pb19hcmVhcyhzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gICAJcmVsZWFz
ZV9mbl9iYXIoYWZ1LT5mbiwgYWZ1LT5jb25maWcuZ2xvYmFsX21taW9fYmFyKTsNCj4gICB9DQo+
ICAgDQo+ICtpbnQgb2N4bF9hZnVfbWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpDQo+
ICt7DQo+ICsJc3RydWN0IHBjaV9kZXYgKmRldiA9IHRvX3BjaV9kZXYoYWZ1LT5mbi0+ZGV2LnBh
cmVudCk7DQo+ICsNCj4gKwlpZiAoKGFmdS0+Y29uZmlnLmxwY19tZW1fc2l6ZSArIGFmdS0+Y29u
ZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSkgPT0gMCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsN
Cj4gKwlhZnUtPmxwY19iYXNlX2FkZHIgPSBvY3hsX2xpbmtfbHBjX21hcChhZnUtPmZuLT5saW5r
LCBkZXYpOw0KPiArCWlmIChhZnUtPmxwY19iYXNlX2FkZHIgPT0gMCkNCj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ICsNCj4gKwlpZiAoYWZ1LT5jb25maWcubHBjX21lbV9zaXplKSB7DQo+ICsJCWFm
dS0+bHBjX3Jlcy5zdGFydCA9IGFmdS0+bHBjX2Jhc2VfYWRkciArIGFmdS0+Y29uZmlnLmxwY19t
ZW1fb2Zmc2V0Ow0KPiArCQlhZnUtPmxwY19yZXMuZW5kID0gYWZ1LT5scGNfcmVzLnN0YXJ0ICsg
YWZ1LT5jb25maWcubHBjX21lbV9zaXplIC0gMTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoYWZ1LT5j
b25maWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKSB7DQo+ICsJCWFmdS0+c3BlY2lhbF9wdXJw
b3NlX3Jlcy5zdGFydCA9IGFmdS0+bHBjX2Jhc2VfYWRkciArDQo+ICsJCQkJCQkgYWZ1LT5jb25m
aWcuc3BlY2lhbF9wdXJwb3NlX21lbV9vZmZzZXQ7DQo+ICsJCWFmdS0+c3BlY2lhbF9wdXJwb3Nl
X3Jlcy5lbmQgPSBhZnUtPnNwZWNpYWxfcHVycG9zZV9yZXMuc3RhcnQgKw0KPiArCQkJCQkgICAg
ICAgYWZ1LT5jb25maWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplIC0gMTsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKG9jeGxfYWZ1X21hcF9s
cGNfbWVtKTsNCj4gKw0KPiArc3RydWN0IHJlc291cmNlICpvY3hsX2FmdV9scGNfbWVtKHN0cnVj
dCBvY3hsX2FmdSAqYWZ1KQ0KPiArew0KPiArCXJldHVybiAmYWZ1LT5scGNfcmVzOw0KPiArfQ0K
PiArRVhQT1JUX1NZTUJPTF9HUEwob2N4bF9hZnVfbHBjX21lbSk7DQo+ICsNCj4gK3N0YXRpYyB2
b2lkIHVubWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpDQo+ICt7DQo+ICsJc3RydWN0
IHBjaV9kZXYgKmRldiA9IHRvX3BjaV9kZXYoYWZ1LT5mbi0+ZGV2LnBhcmVudCk7DQo+ICsNCj4g
KwlpZiAoYWZ1LT5scGNfcmVzLnN0YXJ0IHx8IGFmdS0+c3BlY2lhbF9wdXJwb3NlX3Jlcy5zdGFy
dCkgew0KPiArCQl2b2lkICpsaW5rID0gYWZ1LT5mbi0+bGluazsNCj4gKw0KPiArCQlvY3hsX2xp
bmtfbHBjX3JlbGVhc2UobGluaywgZGV2KTsNCj4gKw0KPiArCQlhZnUtPmxwY19yZXMuc3RhcnQg
PSAwOw0KPiArCQlhZnUtPmxwY19yZXMuZW5kID0gMDsNCj4gKwkJYWZ1LT5zcGVjaWFsX3B1cnBv
c2VfcmVzLnN0YXJ0ID0gMDsNCj4gKwkJYWZ1LT5zcGVjaWFsX3B1cnBvc2VfcmVzLmVuZCA9IDA7
DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBjb25maWd1cmVfYWZ1KHN0cnVjdCBv
Y3hsX2FmdSAqYWZ1LCB1OCBhZnVfaWR4LCBzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAgIHsNCj4g
ICAJaW50IHJjOw0KPiBAQCAtMjUxLDYgKzMwMCw3IEBAIHN0YXRpYyBpbnQgY29uZmlndXJlX2Fm
dShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSwgdTggYWZ1X2lkeCwgc3RydWN0IHBjaV9kZXYgKmRldikN
Cj4gICANCj4gICBzdGF0aWMgdm9pZCBkZWNvbmZpZ3VyZV9hZnUoc3RydWN0IG9jeGxfYWZ1ICph
ZnUpDQo+ICAgew0KPiArCXVubWFwX2xwY19tZW0oYWZ1KTsNCj4gICAJdW5tYXBfbW1pb19hcmVh
cyhhZnUpOw0KPiAgIAlyZWNsYWltX2FmdV9wYXNpZChhZnUpOw0KPiAgIAlyZWNsYWltX2FmdV9h
Y3RhZyhhZnUpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5h
bC5oIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oDQo+IGluZGV4IDIwYjQxN2Uw
MDk0OS4uOWY0YjQ3OTAwZTYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2Mvb2N4bC9vY3hs
X2ludGVybmFsLmgNCj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oDQo+
IEBAIC01Miw2ICs1Miw5IEBAIHN0cnVjdCBvY3hsX2FmdSB7DQo+ICAgCXZvaWQgX19pb21lbSAq
Z2xvYmFsX21taW9fcHRyOw0KPiAgIAl1NjQgcHBfbW1pb19zdGFydDsNCj4gICAJdm9pZCAqcHJp
dmF0ZTsNCj4gKwl1NjQgbHBjX2Jhc2VfYWRkcjsgLyogQ292ZXJzIGJvdGggTFBDICYgc3BlY2lh
bCBwdXJwb3NlIG1lbW9yeSAqLw0KPiArCXN0cnVjdCByZXNvdXJjZSBscGNfcmVzOw0KPiArCXN0
cnVjdCByZXNvdXJjZSBzcGVjaWFsX3B1cnBvc2VfcmVzOw0KPiAgIH07DQo+ICAgDQo+ICAgZW51
bSBvY3hsX2NvbnRleHRfc3RhdHVzIHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWlzYy9vY3hs
LmggYi9pbmNsdWRlL21pc2Mvb2N4bC5oDQo+IGluZGV4IDA2ZGQ1ODM5ZTQzOC4uNmY3YzAyZjBk
NWUzIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL21pc2Mvb2N4bC5oDQo+ICsrKyBiL2luY2x1ZGUv
bWlzYy9vY3hsLmgNCj4gQEAgLTIxMiw2ICsyMTIsMjQgQEAgaW50IG9jeGxfaXJxX3NldF9oYW5k
bGVyKHN0cnVjdCBvY3hsX2NvbnRleHQgKmN0eCwgaW50IGlycV9pZCwNCj4gICANCj4gICAvLyBB
RlUgTWV0YWRhdGENCj4gICANCj4gKy8qKg0KPiArICogTWFwIHRoZSBMUEMgc3lzdGVtICYgc3Bl
Y2lhbCBwdXJwb3NlIG1lbW9yeSBmb3IgYW4gQUZVDQo+ICsgKg0KPiArICogRG8gbm90IGNhbGwg
dGhpcyBkdXJpbmcgZGV2aWNlIGRpc2NvdmVyeSwgYXMgdGhlcmUgbWF5IG1lIG11bHRpcGxlDQo+
ICsgKiBkZXZpY2VzIG9uIGEgbGluaywgYW5kIHRoZSBtZW1vcnkgaXMgbWFwcGVkIGZvciB0aGUg
d2hvbGUgbGluaywgbm90DQo+ICsgKiBqdXN0IG9uZSBkZXZpY2UuIEl0IHNob3VsZCBvbmx5IGJl
IGNhbGxlZCBhZnRlciBhbGwgZGV2aWNlcyBoYXZlDQo+ICsgKiByZWdpc3RlcmVkIHRoZWlyIG1l
bW9yeSBvbiB0aGUgbGluay4NCj4gKyAqDQo+ICsgKiBhZnU6IFRoZSBBRlUgdGhhdCBoYXMgdGhl
IExQQyBtZW1vcnkgdG8gbWFwDQo+ICsgKi8NCj4gK2V4dGVybiBpbnQgb2N4bF9hZnVfbWFwX2xw
Y19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpOw0KPiArDQo+ICsvKioNCj4gKyAqIEdldCB0aGUg
cGh5c2ljYWwgYWRkcmVzcyByYW5nZSBvZiBMUEMgbWVtb3J5IGZvciBhbiBBRlUNCj4gKyAqIGFm
dTogVGhlIEFGVSBhc3NvY2lhdGVkIHdpdGggdGhlIExQQyBtZW1vcnkNCj4gKyAqLw0KPiArZXh0
ZXJuIHN0cnVjdCByZXNvdXJjZSAqb2N4bF9hZnVfbHBjX21lbShzdHJ1Y3Qgb2N4bF9hZnUgKmFm
dSk7DQo+ICsNCg0KDQpZb3UgY2FuIGRyb3AgdGhlIHVzZWxlc3MgJ2V4dGVybicuDQoNCiAgIEZy
ZWQNCg0KDQo+ICAgLyoqDQo+ICAgICogR2V0IGEgcG9pbnRlciB0byB0aGUgY29uZmlnIGZvciBh
biBBRlUNCj4gICAgKg0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
