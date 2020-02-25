Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E616EBFA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 18:01:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83A7C10FC35BB;
	Tue, 25 Feb 2020 09:02:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CF59A10FC35B5
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:02:19 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PGwxnR060112
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 12:01:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yax393vm9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 12:01:27 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 25 Feb 2020 17:01:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 25 Feb 2020 17:01:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PH1De953936252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2020 17:01:13 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2D3642049;
	Tue, 25 Feb 2020 17:01:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67F5742042;
	Tue, 25 Feb 2020 17:01:12 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2020 17:01:12 +0000 (GMT)
Subject: Re: [PATCH v3 07/27] ocxl: Add functions to map/unmap LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 25 Feb 2020 18:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-8-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022517-0012-0000-0000-0000038A3168
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022517-0013-0000-0000-000021C6D4AF
Message-Id: <ae0dfe17-ced9-8ba8-3769-1955797dfbef@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_06:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250126
Message-ID-Hash: XHLNUTBW2FNW2T6HHK3UKUS42I567XQT
X-Message-ID-Hash: XHLNUTBW2FNW2T6HHK3UKUS42I567XQT
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XHLNUTBW2FNW2T6HHK3UKUS42I567XQT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBB
ZGQgZnVuY3Rpb25zIHRvIG1hcC91bm1hcCBMUEMgbWVtb3J5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gLS0tDQoNCg0KSXQg
bG9va3Mgb2sgdG8gbWUuDQpBY2tlZC1ieTogRnJlZGVyaWMgQmFycmF0IDxmYmFycmF0QGxpbnV4
LmlibS5jb20+DQoNCg0KDQo+ICAgZHJpdmVycy9taXNjL29jeGwvY29yZS5jICAgICAgICAgIHwg
NTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvbWlzYy9vY3hs
L29jeGxfaW50ZXJuYWwuaCB8ICAzICsrDQo+ICAgaW5jbHVkZS9taXNjL29jeGwuaCAgICAgICAg
ICAgICAgIHwgMjEgKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNzUgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYyBiL2Ry
aXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiBpbmRleCAyNTMxYzZjZjE5YTAuLjc1ZmYxNGUzODgy
YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL29jeGwvY29yZS5jDQo+ICsrKyBiL2RyaXZl
cnMvbWlzYy9vY3hsL2NvcmUuYw0KPiBAQCAtMjEwLDYgKzIxMCw1NiBAQCBzdGF0aWMgdm9pZCB1
bm1hcF9tbWlvX2FyZWFzKHN0cnVjdCBvY3hsX2FmdSAqYWZ1KQ0KPiAgIAlyZWxlYXNlX2ZuX2Jh
cihhZnUtPmZuLCBhZnUtPmNvbmZpZy5nbG9iYWxfbW1pb19iYXIpOw0KPiAgIH0NCj4gICANCj4g
K2ludCBvY3hsX2FmdV9tYXBfbHBjX21lbShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gK3sNCj4g
KwlzdHJ1Y3QgcGNpX2RldiAqZGV2ID0gdG9fcGNpX2RldihhZnUtPmZuLT5kZXYucGFyZW50KTsN
Cj4gKw0KPiArCWlmICgoYWZ1LT5jb25maWcubHBjX21lbV9zaXplICsgYWZ1LT5jb25maWcuc3Bl
Y2lhbF9wdXJwb3NlX21lbV9zaXplKSA9PSAwKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCWFm
dS0+bHBjX2Jhc2VfYWRkciA9IG9jeGxfbGlua19scGNfbWFwKGFmdS0+Zm4tPmxpbmssIGRldik7
DQo+ICsJaWYgKGFmdS0+bHBjX2Jhc2VfYWRkciA9PSAwKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKw0KPiArCWlmIChhZnUtPmNvbmZpZy5scGNfbWVtX3NpemUgPiAwKSB7DQo+ICsJCWFmdS0+
bHBjX3Jlcy5zdGFydCA9IGFmdS0+bHBjX2Jhc2VfYWRkciArIGFmdS0+Y29uZmlnLmxwY19tZW1f
b2Zmc2V0Ow0KPiArCQlhZnUtPmxwY19yZXMuZW5kID0gYWZ1LT5scGNfcmVzLnN0YXJ0ICsgYWZ1
LT5jb25maWcubHBjX21lbV9zaXplIC0gMTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoYWZ1LT5jb25m
aWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplID4gMCkgew0KPiArCQlhZnUtPnNwZWNpYWxfcHVy
cG9zZV9yZXMuc3RhcnQgPSBhZnUtPmxwY19iYXNlX2FkZHIgKw0KPiArCQkJCQkJIGFmdS0+Y29u
ZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fb2Zmc2V0Ow0KPiArCQlhZnUtPnNwZWNpYWxfcHVycG9z
ZV9yZXMuZW5kID0gYWZ1LT5zcGVjaWFsX3B1cnBvc2VfcmVzLnN0YXJ0ICsNCj4gKwkJCQkJICAg
ICAgIGFmdS0+Y29uZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSAtIDE7DQo+ICsJfQ0KPiAr
DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTChvY3hsX2FmdV9tYXBf
bHBjX21lbSk7DQo+ICsNCj4gK3N0cnVjdCByZXNvdXJjZSAqb2N4bF9hZnVfbHBjX21lbShzdHJ1
Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gK3sNCj4gKwlyZXR1cm4gJmFmdS0+bHBjX3JlczsNCj4gK30N
Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKG9jeGxfYWZ1X2xwY19tZW0pOw0KPiArDQo+ICtzdGF0aWMg
dm9pZCB1bm1hcF9scGNfbWVtKHN0cnVjdCBvY3hsX2FmdSAqYWZ1KQ0KPiArew0KPiArCXN0cnVj
dCBwY2lfZGV2ICpkZXYgPSB0b19wY2lfZGV2KGFmdS0+Zm4tPmRldi5wYXJlbnQpOw0KPiArDQo+
ICsJaWYgKGFmdS0+bHBjX3Jlcy5zdGFydCB8fCBhZnUtPnNwZWNpYWxfcHVycG9zZV9yZXMuc3Rh
cnQpIHsNCj4gKwkJdm9pZCAqbGluayA9IGFmdS0+Zm4tPmxpbms7DQo+ICsNCj4gKwkJLy8gb25s
eSByZWxlYXNlIHRoZSBsaW5rIHdoZW4gdGhlIHRoZSBsYXN0IGNvbnN1bWVyIGNhbGxzIHJlbGVh
c2UNCj4gKwkJb2N4bF9saW5rX2xwY19yZWxlYXNlKGxpbmssIGRldik7DQo+ICsNCj4gKwkJYWZ1
LT5scGNfcmVzLnN0YXJ0ID0gMDsNCj4gKwkJYWZ1LT5scGNfcmVzLmVuZCA9IDA7DQo+ICsJCWFm
dS0+c3BlY2lhbF9wdXJwb3NlX3Jlcy5zdGFydCA9IDA7DQo+ICsJCWFmdS0+c3BlY2lhbF9wdXJw
b3NlX3Jlcy5lbmQgPSAwOw0KPiArCX0NCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBpbnQgY29uZmln
dXJlX2FmdShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSwgdTggYWZ1X2lkeCwgc3RydWN0IHBjaV9kZXYg
KmRldikNCj4gICB7DQo+ICAgCWludCByYzsNCj4gQEAgLTI1MSw2ICszMDEsNyBAQCBzdGF0aWMg
aW50IGNvbmZpZ3VyZV9hZnUoc3RydWN0IG9jeGxfYWZ1ICphZnUsIHU4IGFmdV9pZHgsIHN0cnVj
dCBwY2lfZGV2ICpkZXYpDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgZGVjb25maWd1cmVfYWZ1KHN0
cnVjdCBvY3hsX2FmdSAqYWZ1KQ0KPiAgIHsNCj4gKwl1bm1hcF9scGNfbWVtKGFmdSk7DQo+ICAg
CXVubWFwX21taW9fYXJlYXMoYWZ1KTsNCj4gICAJcmVjbGFpbV9hZnVfcGFzaWQoYWZ1KTsNCj4g
ICAJcmVjbGFpbV9hZnVfYWN0YWcoYWZ1KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9v
Y3hsL29jeGxfaW50ZXJuYWwuaCBiL2RyaXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaA0K
PiBpbmRleCBkMGM4YzQ4MzhmNDIuLmNlMGNhYzFkYTQxNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL29j
eGxfaW50ZXJuYWwuaA0KPiBAQCAtNTIsNiArNTIsOSBAQCBzdHJ1Y3Qgb2N4bF9hZnUgew0KPiAg
IAl2b2lkIF9faW9tZW0gKmdsb2JhbF9tbWlvX3B0cjsNCj4gICAJdTY0IHBwX21taW9fc3RhcnQ7
DQo+ICAgCXZvaWQgKnByaXZhdGU7DQo+ICsJdTY0IGxwY19iYXNlX2FkZHI7IC8qIENvdmVycyBi
b3RoIExQQyAmIHNwZWNpYWwgcHVycG9zZSBtZW1vcnkgKi8NCj4gKwlzdHJ1Y3QgcmVzb3VyY2Ug
bHBjX3JlczsNCj4gKwlzdHJ1Y3QgcmVzb3VyY2Ugc3BlY2lhbF9wdXJwb3NlX3JlczsNCj4gICB9
Ow0KPiAgIA0KPiAgIGVudW0gb2N4bF9jb250ZXh0X3N0YXR1cyB7DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL21pc2Mvb2N4bC5oIGIvaW5jbHVkZS9taXNjL29jeGwuaA0KPiBpbmRleCAzNTdlZjFh
YWRiYzAuLmQ4YjBiNGQ0NmJmYiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9taXNjL29jeGwuaA0K
PiArKysgYi9pbmNsdWRlL21pc2Mvb2N4bC5oDQo+IEBAIC0yMDMsNiArMjAzLDI3IEBAIGludCBv
Y3hsX2lycV9zZXRfaGFuZGxlcihzdHJ1Y3Qgb2N4bF9jb250ZXh0ICpjdHgsIGludCBpcnFfaWQs
DQo+ICAgDQo+ICAgLy8gQUZVIE1ldGFkYXRhDQo+ICAgDQo+ICsvKioNCj4gKyAqIG9jeGxfYWZ1
X21hcF9scGNfbWVtKCkgLSBNYXAgdGhlIExQQyBzeXN0ZW0gJiBzcGVjaWFsIHB1cnBvc2UgbWVt
b3J5IGZvciBhbiBBRlUNCj4gKyAqIERvIG5vdCBjYWxsIHRoaXMgZHVyaW5nIGRldmljZSBkaXNj
b3ZlcnksIGFzIHRoZXJlIG1heSBtZSBtdWx0aXBsZQ0KPiArICogZGV2aWNlcyBvbiBhIGxpbmss
IGFuZCB0aGUgbWVtb3J5IGlzIG1hcHBlZCBmb3IgdGhlIHdob2xlIGxpbmssIG5vdA0KPiArICog
anVzdCBvbmUgZGV2aWNlLiBJdCBzaG91bGQgb25seSBiZSBjYWxsZWQgYWZ0ZXIgYWxsIGRldmlj
ZXMgaGF2ZQ0KPiArICogcmVnaXN0ZXJlZCB0aGVpciBtZW1vcnkgb24gdGhlIGxpbmsuDQo+ICsg
Kg0KPiArICogQGFmdTogVGhlIEFGVSB0aGF0IGhhcyB0aGUgTFBDIG1lbW9yeSB0byBtYXANCj4g
KyAqDQo+ICsgKiBSZXR1cm5zIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgb24gZmFpbHVyZQ0KPiAr
ICovDQo+ICtpbnQgb2N4bF9hZnVfbWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpOw0K
PiArDQo+ICsvKioNCj4gKyAqIG9jeGxfYWZ1X2xwY19tZW0oKSAtIEdldCB0aGUgcGh5c2ljYWwg
YWRkcmVzcyByYW5nZSBvZiBMUEMgbWVtb3J5IGZvciBhbiBBRlUNCj4gKyAqIEBhZnU6IFRoZSBB
RlUgYXNzb2NpYXRlZCB3aXRoIHRoZSBMUEMgbWVtb3J5DQo+ICsgKg0KPiArICogUmV0dXJucyBh
IHBvaW50ZXIgdG8gdGhlIHJlc291cmNlIHN0cnVjdCBmb3IgdGhlIHBoeXNpY2FsIGFkZHJlc3Mg
cmFuZ2UNCj4gKyAqLw0KPiArc3RydWN0IHJlc291cmNlICpvY3hsX2FmdV9scGNfbWVtKHN0cnVj
dCBvY3hsX2FmdSAqYWZ1KTsNCj4gKw0KPiAgIC8qKg0KPiAgICAqIG9jeGxfYWZ1X2NvbmZpZygp
IC0gR2V0IGEgcG9pbnRlciB0byB0aGUgY29uZmlnIGZvciBhbiBBRlUNCj4gICAgKiBAYWZ1OiBh
IHBvaW50ZXIgdG8gdGhlIEFGVSB0byBnZXQgdGhlIGNvbmZpZyBmb3INCj4gDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
