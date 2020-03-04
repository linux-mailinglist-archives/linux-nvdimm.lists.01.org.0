Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 370FF1793C5
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 16:40:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 015C210FC3162;
	Wed,  4 Mar 2020 07:41:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5825810FC36C5
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 07:41:38 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024FZLYS132663
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 10:40:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yj4q18kss-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 10:40:45 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Wed, 4 Mar 2020 15:40:42 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 4 Mar 2020 15:40:34 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024FeWKl48758790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2020 15:40:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7001AE05A;
	Wed,  4 Mar 2020 15:40:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9640AE045;
	Wed,  4 Mar 2020 15:40:31 +0000 (GMT)
Received: from pic2.home (unknown [9.145.145.27])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2020 15:40:31 +0000 (GMT)
Subject: Re: [PATCH v3 24/27] powerpc/powernv/pmem: Expose SMART data via
 ndctl
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-25-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 4 Mar 2020 16:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-25-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030415-0008-0000-0000-0000035951B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030415-0009-0000-0000-00004A7A85DB
Message-Id: <7d461119-12e6-7813-50d5-42e2d7774b54@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040115
Message-ID-Hash: WID4ROXRMI5BORKWLE6CKCLRNAOLFDHQ
X-Message-ID-Hash: WID4ROXRMI5BORKWLE6CKCLRNAOLFDHQ
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WID4ROXRMI5BORKWLE6CKCLRNAOLFDHQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIHJldHJpZXZlcyBwcm9wcmlldGFyeSBmb3JtYXR0ZWQgU01BUlQgZGF0YSBhbmQg
bWFrZXMgaXQNCj4gYXZhaWxhYmxlIHZpYSBuZGN0bC4gQSBsYXRlciBjb250cmlidXRpb24gd2ls
bCBiZSBtYWRlIHRvIG5kY3RsIHRvDQo+IHBhcnNlIHRoaXMgZGF0YS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEub3JnPg0KPiAtLS0NCg0K
DQpOb3RoaW5nIG5ldyB0byBhZGQgY29tcGFyZWQgdG8gcHJldmlvdXMgcGF0Y2hlcyB3aXRoIHNp
bWlsYXJpdGllcy4NCg0KICAgRnJlZA0KDQoNCg0KPiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cG93ZXJudi9wbWVtL29jeGwuYyAgICB8IDEyOCArKysrKysrKysrKysrKysrKysNCj4gICAuLi4v
cGxhdGZvcm1zL3Bvd2VybnYvcG1lbS9vY3hsX2ludGVybmFsLmggICAgfCAgMTggKysrDQo+ICAg
aW5jbHVkZS91YXBpL2xpbnV4L25kY3RsLmggICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
ICAzIGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jIGIvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jDQo+IGluZGV4IGQ0Y2U1ZTllMDUyMS4uNWNk
MWI2ZDc4ZGQ2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYv
cG1lbS9vY3hsLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0v
b2N4bC5jDQo+IEBAIC04MSw2ICs4MSwxMjkgQEAgc3RhdGljIGludCBuZGN0bF9jb25maWdfc2l6
ZShzdHJ1Y3QgbmRfY21kX2dldF9jb25maWdfc2l6ZSAqY29tbWFuZCkNCj4gICAJcmV0dXJuIDA7
DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBzbWFydF9oZWFkZXJfcGFyc2UoKSAtIFBhcnNl
IHRoZSBmaXJzdCA2NCBiaXRzIG9mIHRoZSBTTUFSVCBhZG1pbiBjb21tYW5kIHJlc3BvbnNlDQo+
ICsgKiBAb2N4bHBtZW06IHRoZSBkZXZpY2UgbWV0YWRhdGENCj4gKyAqIEBsZW5ndGg6IG91dCwg
cmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIGluIHRoZSByZXNwb25zZSAoZXhjbHVkaW5nIHRo
ZSA2NCBiaXQgaGVhZGVyKQ0KPiArICovDQo+ICtzdGF0aWMgaW50IHNtYXJ0X2hlYWRlcl9wYXJz
ZShzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtLCB1MzIgKmxlbmd0aCkNCj4gK3sNCj4gKwlpbnQg
cmM7DQo+ICsJdTY0IHZhbDsNCj4gKw0KPiArCXUxNiBkYXRhX2lkZW50aWZpZXI7DQo+ICsJdTMy
IGRhdGFfbGVuZ3RoOw0KPiArDQo+ICsJcmMgPSBvY3hsX2dsb2JhbF9tbWlvX3JlYWQ2NChvY3hs
cG1lbS0+b2N4bF9hZnUsDQo+ICsJCQkJICAgICBvY3hscG1lbS0+YWRtaW5fY29tbWFuZC5kYXRh
X29mZnNldCwNCj4gKwkJCQkgICAgIE9DWExfTElUVExFX0VORElBTiwgJnZhbCk7DQo+ICsJaWYg
KHJjKQ0KPiArCQlyZXR1cm4gcmM7DQo+ICsNCj4gKwlkYXRhX2lkZW50aWZpZXIgPSB2YWwgPj4g
NDg7DQo+ICsJZGF0YV9sZW5ndGggPSB2YWwgJiAweEZGRkZGRkZGOw0KPiArDQo+ICsJaWYgKGRh
dGFfaWRlbnRpZmllciAhPSAweDUzNEQpIHsgLy8gJ1NNJw0KPiArCQlkZXZfZXJyKCZvY3hscG1l
bS0+ZGV2LA0KPiArCQkJIkJhZCBkYXRhIGlkZW50aWZpZXIgZm9yIHNtYXJ0IGRhdGEsIGV4cGVj
dGVkICdTTScsIGdvdCAnJS0uKnMnXG4iLA0KPiArCQkJMiwgKGNoYXIgKikmZGF0YV9pZGVudGlm
aWVyKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0KPiArDQo+ICsJKmxlbmd0aCA9IGRh
dGFfbGVuZ3RoOw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG5kY3Rs
X3NtYXJ0KHN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW0sIHN0cnVjdCBuZF9jbWRfcGtnICpwa2cp
DQo+ICt7DQo+ICsJdTMyIGxlbmd0aCwgaTsNCj4gKwlzdHJ1Y3QgbmRfb2N4bF9zbWFydCAqb3V0
Ow0KPiArCWludCByYzsNCj4gKw0KPiArCW11dGV4X2xvY2soJm9jeGxwbWVtLT5hZG1pbl9jb21t
YW5kLmxvY2spOw0KPiArDQo+ICsJcmMgPSBhZG1pbl9jb21tYW5kX3JlcXVlc3Qob2N4bHBtZW0s
IEFETUlOX0NPTU1BTkRfU01BUlQpOw0KPiArCWlmIChyYykNCj4gKwkJZ290byBvdXQ7DQo+ICsN
Cj4gKwlyYyA9IGFkbWluX2NvbW1hbmRfZXhlY3V0ZShvY3hscG1lbSk7DQo+ICsJaWYgKHJjKQ0K
PiArCQlnb3RvIG91dDsNCj4gKw0KPiArCXJjID0gYWRtaW5fY29tbWFuZF9jb21wbGV0ZV90aW1l
b3V0KG9jeGxwbWVtLCBBRE1JTl9DT01NQU5EX1NNQVJUKTsNCj4gKwlpZiAocmMgPCAwKSB7DQo+
ICsJCWRldl9lcnIoJm9jeGxwbWVtLT5kZXYsICJTTUFSVCB0aW1lb3V0XG4iKTsNCj4gKwkJZ290
byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmMgPSBhZG1pbl9yZXNwb25zZShvY3hscG1lbSk7DQo+
ICsJaWYgKHJjIDwgMCkNCj4gKwkJZ290byBvdXQ7DQo+ICsJaWYgKHJjICE9IFNUQVRVU19TVUND
RVNTKSB7DQo+ICsJCXdhcm5fc3RhdHVzKG9jeGxwbWVtLCAiVW5leHBlY3RlZCBzdGF0dXMgZnJv
bSBTTUFSVCIsIHJjKTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmMgPSBzbWFy
dF9oZWFkZXJfcGFyc2Uob2N4bHBtZW0sICZsZW5ndGgpOw0KPiArCWlmIChyYykNCj4gKwkJZ290
byBvdXQ7DQo+ICsNCj4gKwlwa2ctPm5kX2Z3X3NpemUgPSBsZW5ndGg7DQo+ICsNCj4gKwlsZW5n
dGggPSBtaW4obGVuZ3RoLCBwa2ctPm5kX3NpemVfb3V0KTsgLy8gYnl0ZXMNCj4gKwlvdXQgPSAo
c3RydWN0IG5kX29jeGxfc21hcnQgKilwa2ctPm5kX3BheWxvYWQ7DQo+ICsJLy8gRWFjaCBTTUFS
VCBhdHRyaWJ1dGUgaXMgMiAqIDY0IGJpdHMNCj4gKwlvdXQtPmNvdW50ID0gbGVuZ3RoIC8gKDIg
KiBzaXplb2YodTY0KSk7IC8vIGF0dHJpYnV0ZXMNCj4gKw0KPiArCWZvciAoaSA9IDA7IGkgPCBs
ZW5ndGg7IGkgKz0gc2l6ZW9mKHU2NCkpIHsNCj4gKwkJcmMgPSBvY3hsX2dsb2JhbF9tbWlvX3Jl
YWQ2NChvY3hscG1lbS0+b2N4bF9hZnUsDQo+ICsJCQkJCSAgICAgb2N4bHBtZW0tPmFkbWluX2Nv
bW1hbmQuZGF0YV9vZmZzZXQgKyBzaXplb2YodTY0KSArIGksDQo+ICsJCQkJCSAgICAgT0NYTF9M
SVRUTEVfRU5ESUFOLA0KPiArCQkJCQkgICAgICZvdXQtPmF0dHJpYnNbaS9zaXplb2YodTY0KV0p
Ow0KPiArCQlpZiAocmMpDQo+ICsJCQlnb3RvIG91dDsNCj4gKwl9DQo+ICsNCj4gKwlyYyA9IGFk
bWluX3Jlc3BvbnNlX2hhbmRsZWQob2N4bHBtZW0pOw0KPiArCWlmIChyYykNCj4gKwkJZ290byBv
dXQ7DQo+ICsNCj4gKwlyYyA9IDA7DQo+ICsJZ290byBvdXQ7DQo+ICsNCj4gK291dDoNCj4gKwlt
dXRleF91bmxvY2soJm9jeGxwbWVtLT5hZG1pbl9jb21tYW5kLmxvY2spOw0KPiArCXJldHVybiBy
YzsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBuZGN0bF9jYWxsKHN0cnVjdCBvY3hscG1lbSAq
b2N4bHBtZW0sIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGJ1Zl9sZW4pDQo+ICt7DQo+ICsJc3Ry
dWN0IG5kX2NtZF9wa2cgKnBrZyA9IGJ1ZjsNCj4gKw0KPiArCWlmIChidWZfbGVuIDwgc2l6ZW9m
KHN0cnVjdCBuZF9jbWRfcGtnKSkgew0KPiArCQlkZXZfZXJyKCZvY3hscG1lbS0+ZGV2LCAiSW52
YWxpZCBORF9DQUxMIHNpemU9JXVcbiIsIGJ1Zl9sZW4pOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKwl9DQo+ICsNCj4gKwlpZiAocGtnLT5uZF9mYW1pbHkgIT0gTlZESU1NX0ZBTUlMWV9PQ1hM
KSB7DQo+ICsJCWRldl9lcnIoJm9jeGxwbWVtLT5kZXYsICJJbnZhbGlkIE5EX0NBTEwgZmFtaWx5
PTB4JWxseFxuIiwgcGtnLT5uZF9mYW1pbHkpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9
DQo+ICsNCj4gKwlzd2l0Y2ggKHBrZy0+bmRfY29tbWFuZCkgew0KPiArCWNhc2UgTkRfQ01EX09D
WExfU01BUlQ6DQo+ICsJCW5kY3RsX3NtYXJ0KG9jeGxwbWVtLCBwa2cpOw0KPiArCQlicmVhazsN
Cj4gKw0KPiArCWRlZmF1bHQ6DQo+ICsJCWRldl9lcnIoJm9jeGxwbWVtLT5kZXYsICJJbnZhbGlk
IE5EX0NBTEwgY29tbWFuZD0weCVsbHhcbiIsIHBrZy0+bmRfY29tbWFuZCk7DQo+ICsJCXJldHVy
biAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4g
ICBzdGF0aWMgaW50IG5kY3RsKHN0cnVjdCBudmRpbW1fYnVzX2Rlc2NyaXB0b3IgKm5kX2Rlc2Ms
DQo+ICAgCQkgc3RydWN0IG52ZGltbSAqbnZkaW1tLA0KPiAgIAkJIHVuc2lnbmVkIGludCBjbWQs
IHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGJ1Zl9sZW4sIGludCAqY21kX3JjKQ0KPiBAQCAtODgs
NiArMjExLDEwIEBAIHN0YXRpYyBpbnQgbmRjdGwoc3RydWN0IG52ZGltbV9idXNfZGVzY3JpcHRv
ciAqbmRfZGVzYywNCj4gICAJc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSA9IGNvbnRhaW5lcl9v
ZihuZF9kZXNjLCBzdHJ1Y3Qgb2N4bHBtZW0sIGJ1c19kZXNjKTsNCj4gICANCj4gICAJc3dpdGNo
IChjbWQpIHsNCj4gKwljYXNlIE5EX0NNRF9DQUxMOg0KPiArCQkqY21kX3JjID0gbmRjdGxfY2Fs
bChvY3hscG1lbSwgYnVmLCBidWZfbGVuKTsNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gICAJY2Fz
ZSBORF9DTURfR0VUX0NPTkZJR19TSVpFOg0KPiAgIAkJKmNtZF9yYyA9IG5kY3RsX2NvbmZpZ19z
aXplKGJ1Zik7DQo+ICAgCQlyZXR1cm4gMDsNCj4gQEAgLTE3MSw2ICsyOTgsNyBAQCBzdGF0aWMg
aW50IHJlZ2lzdGVyX2xwY19tZW0oc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSkNCj4gICAJc2V0
X2JpdChORF9DTURfR0VUX0NPTkZJR19TSVpFLCAmbnZkaW1tX2NtZF9tYXNrKTsNCj4gICAJc2V0
X2JpdChORF9DTURfR0VUX0NPTkZJR19EQVRBLCAmbnZkaW1tX2NtZF9tYXNrKTsNCj4gICAJc2V0
X2JpdChORF9DTURfU0VUX0NPTkZJR19EQVRBLCAmbnZkaW1tX2NtZF9tYXNrKTsNCj4gKwlzZXRf
Yml0KE5EX0NNRF9DQUxMLCAmbnZkaW1tX2NtZF9tYXNrKTsNCj4gICANCj4gICAJc2V0X2JpdChO
RERfQUxJQVNJTkcsICZudmRpbW1fZmxhZ3MpOw0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oIGIvYXJjaC9wb3dl
cnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oDQo+IGluZGV4IDkyNzY5
MGY0ODg4Zi4uMGViN2EzNWQyNGFlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zL3Bvd2VybnYvcG1lbS9vY3hsX2ludGVybmFsLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oDQo+IEBAIC03LDYgKzcsNyBAQA0K
PiAgICNpbmNsdWRlIDxsaW51eC9saWJudmRpbW0uaD4NCj4gICAjaW5jbHVkZSA8dWFwaS9udmRp
bW0vb2N4bC1wbWVtLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L21tLmg+DQo+ICsjaW5jbHVkZSA8
bGludXgvbmRjdGwuaD4NCj4gICANCj4gICAjZGVmaW5lIExBQkVMX0FSRUFfU0laRQkoMVVMIDw8
IFBBX1NFQ1RJT05fU0hJRlQpDQo+ICAgI2RlZmluZSBERUZBVUxUX1RJTUVPVVQgMTAwDQo+IEBA
IC05OCw2ICs5OSwyMyBAQCBzdHJ1Y3Qgb2N4bHBtZW1fZnVuY3Rpb24wIHsNCj4gICAJc3RydWN0
IG9jeGxfZm4gKm9jeGxfZm47DQo+ICAgfTsNCj4gICANCj4gK3N0cnVjdCBuZF9vY3hsX3NtYXJ0
IHsNCj4gKwlfX3U4IGNvdW50Ow0KPiArCV9fdTggcmVzZXJ2ZWRbN107DQo+ICsJX191NjQgYXR0
cmlic1swXTsNCj4gK30gX19wYWNrZWQ7DQo+ICsNCj4gK3N0cnVjdCBuZF9wa2dfb2N4bCB7DQo+
ICsJc3RydWN0IG5kX2NtZF9wa2cgZ2VuOw0KPiArCXVuaW9uIHsNCj4gKwkJc3RydWN0IG5kX29j
eGxfc21hcnQgc21hcnQ7DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gK2VudW0gbmRfY21kX29jeGwg
ew0KPiArCU5EX0NNRF9PQ1hMX1NNQVJUID0gMSwNCj4gK307DQo+ICsNCj4gICBzdHJ1Y3Qgb2N4
bHBtZW0gew0KPiAgIAlzdHJ1Y3QgZGV2aWNlIGRldjsNCj4gICAJc3RydWN0IHBjaV9kZXYgKnBk
ZXY7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvbmRjdGwuaCBiL2luY2x1ZGUv
dWFwaS9saW51eC9uZGN0bC5oDQo+IGluZGV4IGRlNWQ5MDIxMjQwOS4uMjg4NTA1MmU3ZjQwIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvbmRjdGwuaA0KPiArKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvbmRjdGwuaA0KPiBAQCAtMjQ0LDYgKzI0NCw3IEBAIHN0cnVjdCBuZF9jbWRf
cGtnIHsNCj4gICAjZGVmaW5lIE5WRElNTV9GQU1JTFlfSFBFMiAyDQo+ICAgI2RlZmluZSBOVkRJ
TU1fRkFNSUxZX01TRlQgMw0KPiAgICNkZWZpbmUgTlZESU1NX0ZBTUlMWV9IWVBFUlYgNA0KPiAr
I2RlZmluZSBOVkRJTU1fRkFNSUxZX09DWEwgNg0KPiAgIA0KPiAgICNkZWZpbmUgTkRfSU9DVExf
Q0FMTAkJCV9JT1dSKE5EX0lPQ1RMLCBORF9DTURfQ0FMTCxcDQo+ICAgCQkJCQlzdHJ1Y3QgbmRf
Y21kX3BrZykNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlz
dHMuMDEub3JnCg==
