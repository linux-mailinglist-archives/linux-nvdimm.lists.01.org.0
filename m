Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A411761B2
	for <lists+linux-nvdimm@lfdr.de>; Mon,  2 Mar 2020 18:58:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7217D10FC35BE;
	Mon,  2 Mar 2020 09:59:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83CC210097E00
	for <linux-nvdimm@lists.01.org>; Mon,  2 Mar 2020 09:59:46 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022Hq1Rs102963
	for <linux-nvdimm@lists.01.org>; Mon, 2 Mar 2020 12:58:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yfhqpx720-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 02 Mar 2020 12:58:54 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Mon, 2 Mar 2020 17:58:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 2 Mar 2020 17:58:43 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022HwfGx50790480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2020 17:58:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D094C044;
	Mon,  2 Mar 2020 17:58:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC4A84C04A;
	Mon,  2 Mar 2020 17:58:40 +0000 (GMT)
Received: from pic2.home (unknown [9.145.49.157])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2020 17:58:40 +0000 (GMT)
Subject: Re: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near
 storage commands
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-16-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Mon, 2 Mar 2020 18:58:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-16-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030217-0008-0000-0000-000003588719
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030217-0009-0000-0000-00004A79B3A6
Message-Id: <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_06:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020118
Message-ID-Hash: HPPACQMREGOJPQGGCTH5YY2KXTXSFKCQ
X-Message-ID-Hash: HPPACQMREGOJPQGGCTH5YY2KXTXSFKCQ
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HPPACQMREGOJPQGGCTH5YY2KXTXSFKCQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBT
aW1pbGFyIHRvIHRoZSBwcmV2aW91cyBwYXRjaCwgdGhpcyBhZGRzIHN1cHBvcnQgZm9yIG5lYXIg
c3RvcmFnZSBjb21tYW5kcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEg
PGFsYXN0YWlyQGQtc2lsdmEub3JnPg0KPiAtLS0NCg0KDQpJcyBhbnkgb2YgdGhlc2UgbmV3IGZ1
bmN0aW9ucyBldmVyIGNhbGxlZD8NCg0KICAgRnJlZA0KDQoNCj4gICBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bvd2VybnYvcG1lbS9vY3hsLmMgICAgfCAgNiArKysNCj4gICAuLi4vcGxhdGZvcm1z
L3Bvd2VybnYvcG1lbS9vY3hsX2ludGVybmFsLmMgICAgfCA0MSArKysrKysrKysrKysrKysrKysr
DQo+ICAgLi4uL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oICAgIHwgMzcg
KysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvcG1lbS9v
Y3hsLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvcG1lbS9vY3hsLmMNCj4gaW5k
ZXggNGU3ODJkMjI2MDViLi5iOGJkN2U3MDNiMTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGwuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3Bvd2VybnYvcG1lbS9vY3hsLmMNCj4gQEAgLTI1OSwxMiArMjU5LDE4IEBAIHN0YXRp
YyBpbnQgc2V0dXBfY29tbWFuZF9tZXRhZGF0YShzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtKQ0K
PiAgIAlpbnQgcmM7DQo+ICAgDQo+ICAgCW11dGV4X2luaXQoJm9jeGxwbWVtLT5hZG1pbl9jb21t
YW5kLmxvY2spOw0KPiArCW11dGV4X2luaXQoJm9jeGxwbWVtLT5uc19jb21tYW5kLmxvY2spOw0K
PiAgIA0KPiAgIAlyYyA9IGV4dHJhY3RfY29tbWFuZF9tZXRhZGF0YShvY3hscG1lbSwgR0xPQkFM
X01NSU9fQUNNQV9DUkVRTywNCj4gICAJCQkJICAgICAgJm9jeGxwbWVtLT5hZG1pbl9jb21tYW5k
KTsNCj4gICAJaWYgKHJjKQ0KPiAgIAkJcmV0dXJuIHJjOw0KPiAgIA0KPiArCXJjID0gZXh0cmFj
dF9jb21tYW5kX21ldGFkYXRhKG9jeGxwbWVtLCBHTE9CQUxfTU1JT19OU0NNQV9DUkVRTywNCj4g
KwkJCQkJICAmb2N4bHBtZW0tPm5zX2NvbW1hbmQpOw0KPiArCWlmIChyYykNCj4gKwkJcmV0dXJu
IHJjOw0KPiArDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGxfaW50ZXJuYWwuYyBiL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGxfaW50ZXJuYWwuYw0KPiBpbmRleCA1
ODNmNDgwMjMwMjUuLjNlMGIxMzNmZWRkZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJw
Yy9wbGF0Zm9ybXMvcG93ZXJudi9wbWVtL29jeGxfaW50ZXJuYWwuYw0KPiBAQCAtMTMzLDYgKzEz
Myw0NyBAQCBpbnQgYWRtaW5fcmVzcG9uc2VfaGFuZGxlZChjb25zdCBzdHJ1Y3Qgb2N4bHBtZW0g
Km9jeGxwbWVtKQ0KPiAgIAkJCQkgICAgICBPQ1hMX0xJVFRMRV9FTkRJQU4sIEdMT0JBTF9NTUlP
X0NISV9BQ1JBKTsNCj4gICB9DQo+ICAgDQo+ICtpbnQgbnNfY29tbWFuZF9yZXF1ZXN0KHN0cnVj
dCBvY3hscG1lbSAqb2N4bHBtZW0sIHU4IG9wX2NvZGUpDQo+ICt7DQo+ICsJdTY0IHZhbDsNCj4g
KwlpbnQgcmMgPSBvY3hsX2dsb2JhbF9tbWlvX3JlYWQ2NChvY3hscG1lbS0+b2N4bF9hZnUsIEdM
T0JBTF9NTUlPX0NISSwNCj4gKwkJCQkJIE9DWExfTElUVExFX0VORElBTiwgJnZhbCk7DQo+ICsJ
aWYgKHJjKQ0KPiArCQlyZXR1cm4gcmM7DQo+ICsNCj4gKwlpZiAoISh2YWwgJiBHTE9CQUxfTU1J
T19DSElfTlNDUkEpKQ0KPiArCQlyZXR1cm4gLUVCVVNZOw0KPiArDQo+ICsJcmV0dXJuIHNjbV9j
b21tYW5kX3JlcXVlc3Qob2N4bHBtZW0sICZvY3hscG1lbS0+bnNfY29tbWFuZCwgb3BfY29kZSk7
DQo+ICt9DQo+ICsNCj4gK2ludCBuc19yZXNwb25zZShjb25zdCBzdHJ1Y3Qgb2N4bHBtZW0gKm9j
eGxwbWVtKQ0KPiArew0KPiArCXJldHVybiBjb21tYW5kX3Jlc3BvbnNlKG9jeGxwbWVtLCAmb2N4
bHBtZW0tPm5zX2NvbW1hbmQpOw0KPiArfQ0KPiArDQo+ICtpbnQgbnNfY29tbWFuZF9leGVjdXRl
KGNvbnN0IHN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW0pDQo+ICt7DQo+ICsJcmV0dXJuIG9jeGxf
Z2xvYmFsX21taW9fc2V0NjQob2N4bHBtZW0tPm9jeGxfYWZ1LCBHTE9CQUxfTU1JT19IQ0ksDQo+
ICsJCQkJICAgICAgT0NYTF9MSVRUTEVfRU5ESUFOLCBHTE9CQUxfTU1JT19IQ0lfTlNDUlcpOw0K
PiArfQ0KPiArDQo+ICtib29sIG5zX2NvbW1hbmRfY29tcGxldGUoY29uc3Qgc3RydWN0IG9jeGxw
bWVtICpvY3hscG1lbSkNCj4gK3sNCj4gKwl1NjQgdmFsID0gMDsNCj4gKwlpbnQgcmMgPSBvY3hs
cG1lbV9jaGkob2N4bHBtZW0sICZ2YWwpOw0KPiArDQo+ICsJV0FSTl9PTihyYyk7DQo+ICsNCj4g
KwlyZXR1cm4gKHZhbCAmIEdMT0JBTF9NTUlPX0NISV9OU0NSQSkgIT0gMDsNCj4gK30NCj4gKw0K
PiAraW50IG5zX3Jlc3BvbnNlX2hhbmRsZWQoY29uc3Qgc3RydWN0IG9jeGxwbWVtICpvY3hscG1l
bSkNCj4gK3sNCj4gKwlyZXR1cm4gb2N4bF9nbG9iYWxfbW1pb19zZXQ2NChvY3hscG1lbS0+b2N4
bF9hZnUsIEdMT0JBTF9NTUlPX0NISUMsDQo+ICsJCQkJICAgICAgT0NYTF9MSVRUTEVfRU5ESUFO
LCBHTE9CQUxfTU1JT19DSElfTlNDUkEpOw0KPiArfQ0KPiArDQo+ICAgdm9pZCB3YXJuX3N0YXR1
cyhjb25zdCBzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtLCBjb25zdCBjaGFyICptZXNzYWdlLA0K
PiAgIAkJICAgICB1OCBzdGF0dXMpDQo+ICAgew0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oIGIvYXJjaC9wb3dlcnBjL3Bs
YXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oDQo+IGluZGV4IDJmZWY2OGM3MTI3
MS4uMjhlMjAyMGY2MzU1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bv
d2VybnYvcG1lbS9vY3hsX2ludGVybmFsLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jt
cy9wb3dlcm52L3BtZW0vb2N4bF9pbnRlcm5hbC5oDQo+IEBAIC0xMDcsNiArMTA3LDcgQEAgc3Ry
dWN0IG9jeGxwbWVtIHsNCj4gICAJc3RydWN0IG9jeGxfY29udGV4dCAqb2N4bF9jb250ZXh0Ow0K
PiAgIAl2b2lkICptZXRhZGF0YV9hZGRyOw0KPiAgIAlzdHJ1Y3QgY29tbWFuZF9tZXRhZGF0YSBh
ZG1pbl9jb21tYW5kOw0KPiArCXN0cnVjdCBjb21tYW5kX21ldGFkYXRhIG5zX2NvbW1hbmQ7DQo+
ICAgCXN0cnVjdCByZXNvdXJjZSBwbWVtX3JlczsNCj4gICAJc3RydWN0IG5kX3JlZ2lvbiAqbmRf
cmVnaW9uOw0KPiAgIAljaGFyIGZ3X3ZlcnNpb25bOCsxXTsNCj4gQEAgLTE3NSw2ICsxNzYsNDIg
QEAgaW50IGFkbWluX2NvbW1hbmRfY29tcGxldGVfdGltZW91dChjb25zdCBzdHJ1Y3Qgb2N4bHBt
ZW0gKm9jeGxwbWVtLA0KPiAgICAqLw0KPiAgIGludCBhZG1pbl9yZXNwb25zZV9oYW5kbGVkKGNv
bnN0IHN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW0pOw0KPiAgIA0KPiArLyoqDQo+ICsgKiBuc19j
b21tYW5kX3JlcXVlc3QoKSAtIElzc3VlIGEgbmVhciBzdG9yYWdlIGNvbW1hbmQgcmVxdWVzdA0K
PiArICogQG9jeGxwbWVtOiB0aGUgZGV2aWNlIG1ldGFkYXRhDQo+ICsgKiBAb3BfY29kZTogVGhl
IG9wLWNvZGUgZm9yIHRoZSBjb21tYW5kDQo+ICsgKiBSZXR1cm5zIGFuIGlkZW50aWZpZXIgZm9y
IHRoZSBjb21tYW5kLCBvciBuZWdhdGl2ZSBvbiBlcnJvcg0KPiArICovDQo+ICtpbnQgbnNfY29t
bWFuZF9yZXF1ZXN0KHN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW0sIHU4IG9wX2NvZGUpOw0KPiAr
DQo+ICsvKioNCj4gKyAqIG5zX3Jlc3BvbnNlKCkgLSBWYWxpZGF0ZSBhIG5lYXIgc3RvcmFnZSBy
ZXNwb25zZQ0KPiArICogQG9jeGxwbWVtOiB0aGUgZGV2aWNlIG1ldGFkYXRhDQo+ICsgKiBSZXR1
cm5zIHRoZSBzdGF0dXMgY29kZSBvZiB0aGUgY29tbWFuZCwgb3IgbmVnYXRpdmUgb24gZXJyb3IN
Cj4gKyAqLw0KPiAraW50IG5zX3Jlc3BvbnNlKGNvbnN0IHN0cnVjdCBvY3hscG1lbSAqb2N4bHBt
ZW0pOw0KPiArDQo+ICsvKioNCj4gKyAqIG5zX2NvbW1hbmRfZXhlY3V0ZSgpIC0gTm90aWZ5IHRo
ZSBjb250cm9sbGVyIHRvIHN0YXJ0IHByb2Nlc3NpbmcgYSBwZW5kaW5nIG5lYXIgc3RvcmFnZSBj
b21tYW5kDQo+ICsgKiBAb2N4bHBtZW06IHRoZSBkZXZpY2UgbWV0YWRhdGENCj4gKyAqIFJldHVy
bnMgMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBvbiBlcnJvcg0KPiArICovDQo+ICtpbnQgbnNfY29t
bWFuZF9leGVjdXRlKGNvbnN0IHN0cnVjdCBvY3hscG1lbSAqb2N4bHBtZW0pOw0KPiArDQo+ICsv
KioNCj4gKyAqIG5zX2NvbW1hbmRfY29tcGxldGUoKSAtIElzIGEgbmVhciBzdG9yYWdlIGNvbW1h
bmQgZXhlY3V0aW5nDQo+ICsgKiBAb2N4bHBtZW06IHRoZSBkZXZpY2UgbWV0YWRhdGENCj4gKyAq
IFJldHVybnMgdHJ1ZSBpZiB0aGUgcHJldmlvdXMgYWRtaW4gY29tbWFuZCBoYXMgY29tcGxldGVk
DQo+ICsgKi8NCj4gK2Jvb2wgbnNfY29tbWFuZF9jb21wbGV0ZShjb25zdCBzdHJ1Y3Qgb2N4bHBt
ZW0gKm9jeGxwbWVtKTsNCj4gKw0KPiArLyoqDQo+ICsgKiBuc19yZXNwb25zZV9oYW5kbGVkKCkg
LSBOb3RpZnkgdGhlIGNvbnRyb2xsZXIgdGhhdCB0aGUgbmVhciBzdG9yYWdlIHJlc3BvbnNlIGhh
cyBiZWVuIGhhbmRsZWQNCj4gKyAqIEBvY3hscG1lbTogdGhlIGRldmljZSBtZXRhZGF0YQ0KPiAr
ICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5lZ2F0aXZlIG9uIGZhaWx1cmUNCj4gKyAqLw0KPiAr
aW50IG5zX3Jlc3BvbnNlX2hhbmRsZWQoY29uc3Qgc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSk7
DQo+ICsNCj4gICAvKioNCj4gICAgKiB3YXJuX3N0YXR1cygpIC0gRW1pdCBhIGtlcm5lbCB3YXJu
aW5nIHNob3dpbmcgYSBjb21tYW5kIHN0YXR1cy4NCj4gICAgKiBAb2N4bHBtZW06IHRoZSBkZXZp
Y2UgbWV0YWRhdGENCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
