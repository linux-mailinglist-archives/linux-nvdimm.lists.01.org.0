Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA8F3685
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 19:02:51 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8917100EA622;
	Thu,  7 Nov 2019 10:05:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61D35100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 10:05:13 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7HlaBb018763
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 13:02:47 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w4py8uep4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 13:02:46 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 18:02:37 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 18:02:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7I2Sa249676438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 18:02:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02134C059;
	Thu,  7 Nov 2019 18:02:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9453E4C063;
	Thu,  7 Nov 2019 18:02:27 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 18:02:27 +0000 (GMT)
Subject: Re: [PATCH 05/10] ocxl: Tally up the LPC memory on a link & allow it
 to be mapped
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-6-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 19:02:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-6-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110718-0028-0000-0000-000003B3A2B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110718-0029-0000-0000-0000247603B6
Message-Id: <5e00e3a4-f3a3-f5aa-a406-1464c64d8d1d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070165
Message-ID-Hash: NRR7SBGUQ7INKTVDSQKC2QNHIYDG6K4C
X-Message-ID-Hash: NRR7SBGUQ7INKTVDSQKC2QNHIYDG6K4C
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Allison Randal <allison@lohutok.net>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, li
 nuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NRR7SBGUQ7INKTVDSQKC2QNHIYDG6K4C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
YWxseSB1cCB0aGUgTFBDIG1lbW9yeSBvbiBhbiBPcGVuQ0FQSSBsaW5rICYgYWxsb3cgaXQgdG8g
YmUgbWFwcGVkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFp
ckBkLXNpbHZhLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9taXNjL29jeGwvY29yZS5jICAgICAg
ICAgIHwgMTAgKysrKysrDQo+ICAgZHJpdmVycy9taXNjL29jeGwvbGluay5jICAgICAgICAgIHwg
NjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvbWlzYy9vY3hs
L29jeGxfaW50ZXJuYWwuaCB8IDMzICsrKysrKysrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFu
Z2VkLCAxMDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9v
Y3hsL2NvcmUuYyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiBpbmRleCBiN2EwOWIyMWFi
MzYuLjI1MzFjNmNmMTlhMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL29jeGwvY29yZS5j
DQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiBAQCAtMjMwLDggKzIzMCwxOCBA
QCBzdGF0aWMgaW50IGNvbmZpZ3VyZV9hZnUoc3RydWN0IG9jeGxfYWZ1ICphZnUsIHU4IGFmdV9p
ZHgsIHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ICAgCWlmIChyYykNCj4gICAJCWdvdG8gZXJyX2Zy
ZWVfcGFzaWQ7DQo+ICAgDQo+ICsJaWYgKGFmdS0+Y29uZmlnLmxwY19tZW1fc2l6ZSB8fCBhZnUt
PmNvbmZpZy5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUpIHsNCj4gKwkJcmMgPSBvY3hsX2xpbmtf
YWRkX2xwY19tZW0oYWZ1LT5mbi0+bGluaywgYWZ1LT5jb25maWcubHBjX21lbV9vZmZzZXQsDQo+
ICsJCQkJCSAgIGFmdS0+Y29uZmlnLmxwY19tZW1fc2l6ZSArDQo+ICsJCQkJCSAgIGFmdS0+Y29u
ZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSk7DQo+ICsJCWlmIChyYykNCj4gKwkJCWdvdG8g
ZXJyX2ZyZWVfbW1pbzsNCj4gKwl9DQo+ICsNCj4gICAJcmV0dXJuIDA7DQo+ICAgDQo+ICtlcnJf
ZnJlZV9tbWlvOg0KPiArCXVubWFwX21taW9fYXJlYXMoYWZ1KTsNCj4gICBlcnJfZnJlZV9wYXNp
ZDoNCj4gICAJcmVjbGFpbV9hZnVfcGFzaWQoYWZ1KTsNCj4gICBlcnJfZnJlZV9hY3RhZzoNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2xpbmsuYyBiL2RyaXZlcnMvbWlzYy9vY3hs
L2xpbmsuYw0KPiBpbmRleCA1OGQxMTFhZmQ5ZjYuLjFkMzUwZDBiYjg2MCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9taXNjL29jeGwvbGluay5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL2xp
bmsuYw0KPiBAQCAtODQsNiArODQsMTEgQEAgc3RydWN0IG9jeGxfbGluayB7DQo+ICAgCWludCBk
ZXY7DQo+ICAgCWF0b21pY190IGlycV9hdmFpbGFibGU7DQo+ICAgCXN0cnVjdCBzcGEgKnNwYTsN
Cj4gKwlzdHJ1Y3QgbXV0ZXggbHBjX21lbV9sb2NrOw0KPiArCXU2NCBscGNfbWVtX3N6OyAvKiBU
b3RhbCBhbW91bnQgb2YgTFBDIG1lbW9yeSBwcmVzZW50ZWQgb24gdGhlIGxpbmsgKi8NCj4gKwl1
NjQgbHBjX21lbTsNCj4gKwlpbnQgbHBjX2NvbnN1bWVyczsNCj4gKw0KPiAgIAl2b2lkICpwbGF0
Zm9ybV9kYXRhOw0KPiAgIH07DQo+ICAgc3RhdGljIHN0cnVjdCBsaXN0X2hlYWQgbGlua3NfbGlz
dCA9IExJU1RfSEVBRF9JTklUKGxpbmtzX2xpc3QpOw0KPiBAQCAtMzk2LDYgKzQwMSw4IEBAIHN0
YXRpYyBpbnQgYWxsb2NfbGluayhzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgUEVfbWFzaywgc3Ry
dWN0IG9jeGxfbGluayAqKm91dF9sDQo+ICAgCWlmIChyYykNCj4gICAJCWdvdG8gZXJyX3NwYTsN
Cj4gICANCj4gKwltdXRleF9pbml0KCZsaW5rLT5scGNfbWVtX2xvY2spOw0KPiArDQo+ICAgCS8q
IHBsYXRmb3JtIHNwZWNpZmljIGhvb2sgKi8NCj4gICAJcmMgPSBwbnZfb2N4bF9zcGFfc2V0dXAo
ZGV2LCBsaW5rLT5zcGEtPnNwYV9tZW0sIFBFX21hc2ssDQo+ICAgCQkJCSZsaW5rLT5wbGF0Zm9y
bV9kYXRhKTsNCj4gQEAgLTcxMSwzICs3MTgsNTYgQEAgdm9pZCBvY3hsX2xpbmtfZnJlZV9pcnEo
dm9pZCAqbGlua19oYW5kbGUsIGludCBod19pcnEpDQo+ICAgCWF0b21pY19pbmMoJmxpbmstPmly
cV9hdmFpbGFibGUpOw0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChvY3hsX2xpbmtfZnJl
ZV9pcnEpOw0KPiArDQo+ICtpbnQgb2N4bF9saW5rX2FkZF9scGNfbWVtKHZvaWQgKmxpbmtfaGFu
ZGxlLCB1NjQgb2Zmc2V0LCB1NjQgc2l6ZSkNCj4gK3sNCj4gKwlzdHJ1Y3Qgb2N4bF9saW5rICps
aW5rID0gKHN0cnVjdCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7DQo+ICsNCj4gKwkvLyBDaGVj
ayBmb3Igb3ZlcmZsb3cNCj4gKwlpZiAob2Zmc2V0ID4gKG9mZnNldCArIHNpemUpKQ0KPiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCW11dGV4X2xvY2soJmxpbmstPmxwY19tZW1fbG9jayk7
DQo+ICsJbGluay0+bHBjX21lbV9zeiA9IG1heChsaW5rLT5scGNfbWVtX3N6LCBvZmZzZXQgKyBz
aXplKTsNCg0KDQpHb29kIGZpbmQgdG8gYXZvaWQgaGF2aW5nIHRvIG1haW50YWluIGEgcmFuZ2Ug
bGlzdCENCg0KDQo+ICsNCj4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArdTY0IG9jeGxfbGlua19scGNfbWFwKHZv
aWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3Qg
b2N4bF9saW5rICpsaW5rID0gKHN0cnVjdCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7DQo+ICsJ
dTY0IGxwY19tZW07DQo+ICsNCj4gKwltdXRleF9sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2spOw0K
PiArCWlmIChsaW5rLT5scGNfbWVtKSB7DQo+ICsJCWxwY19tZW0gPSBsaW5rLT5scGNfbWVtOw0K
PiArDQo+ICsJCWxpbmstPmxwY19jb25zdW1lcnMrKzsNCj4gKwkJbXV0ZXhfdW5sb2NrKCZsaW5r
LT5scGNfbWVtX2xvY2spOw0KPiArCQlyZXR1cm4gbHBjX21lbTsNCj4gKwl9DQo+ICsNCj4gKwls
aW5rLT5scGNfbWVtID0gcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHBkZXYsIGxpbmstPmxw
Y19tZW1fc3opOw0KPiArCWlmIChsaW5rLT5scGNfbWVtKQ0KPiArCQlsaW5rLT5scGNfY29uc3Vt
ZXJzKys7DQo+ICsJbHBjX21lbSA9IGxpbmstPmxwY19tZW07DQo+ICsJbXV0ZXhfdW5sb2NrKCZs
aW5rLT5scGNfbWVtX2xvY2spOw0KPiArDQo+ICsJcmV0dXJuIGxwY19tZW07DQo+ICt9DQo+ICsN
Cj4gK3ZvaWQgb2N4bF9saW5rX2xwY19yZWxlYXNlKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3Qg
cGNpX2RldiAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3Qgb2N4bF9saW5rICpsaW5rID0gKHN0cnVj
dCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7DQo+ICsNCj4gKwltdXRleF9sb2NrKCZsaW5rLT5s
cGNfbWVtX2xvY2spOw0KPiArCWxpbmstPmxwY19jb25zdW1lcnMtLTsNCg0KDQpSZXBsYWNlIHdp
dGggV0FSTl9PTigtLWxpbmstPmxwY19jb25zdW1lcnMgPCAwKSA/DQoNCg0KICAgRnJlZA0KDQoN
Cj4gKwlpZiAobGluay0+bHBjX2NvbnN1bWVycyA9PSAwKSB7DQo+ICsJCXBudl9vY3hsX3BsYXRm
b3JtX2xwY19yZWxlYXNlKHBkZXYpOw0KPiArCQlsaW5rLT5scGNfbWVtID0gMDsNCj4gKwl9DQo+
ICsNCj4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ICt9DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmggYi9kcml2ZXJzL21pc2Mv
b2N4bC9vY3hsX2ludGVybmFsLmgNCj4gaW5kZXggOTc0MTVhZmQ3OWYzLi4yMGI0MTdlMDA5NDkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaA0KPiArKysg
Yi9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmgNCj4gQEAgLTE0MSw0ICsxNDEsMzcg
QEAgaW50IG9jeGxfaXJxX29mZnNldF90b19pZChzdHJ1Y3Qgb2N4bF9jb250ZXh0ICpjdHgsIHU2
NCBvZmZzZXQpOw0KPiAgIHU2NCBvY3hsX2lycV9pZF90b19vZmZzZXQoc3RydWN0IG9jeGxfY29u
dGV4dCAqY3R4LCBpbnQgaXJxX2lkKTsNCj4gICB2b2lkIG9jeGxfYWZ1X2lycV9mcmVlX2FsbChz
dHJ1Y3Qgb2N4bF9jb250ZXh0ICpjdHgpOw0KPiAgIA0KPiArLyoqDQo+ICsgKiBvY3hsX2xpbmtf
YWRkX2xwY19tZW0oKSAtIEluY3JlbWVudCB0aGUgYW1vdW50IG9mIG1lbW9yeSByZXF1aXJlZCBi
eSBhbiBPcGVuQ0FQSSBsaW5rDQo+ICsgKg0KPiArICogQGxpbmtfaGFuZGxlOiBUaGUgT3BlbkNB
UEkgbGluayBoYW5kbGUNCj4gKyAqIEBvZmZzZXQ6IFRoZSBvZmZzZXQgb2YgdGhlIG1lbW9yeSB0
byBhZGQNCj4gKyAqIEBzaXplOiBUaGUgYW1vdW50IG9mIG1lbW9yeSB0byBpbmNyZW1lbnQgYnkN
Cj4gKyAqDQo+ICsgKiBSZXR1cm4gMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBvbiBvdmVyZmxvdw0K
PiArICovDQo+ICtpbnQgb2N4bF9saW5rX2FkZF9scGNfbWVtKHZvaWQgKmxpbmtfaGFuZGxlLCB1
NjQgb2Zmc2V0LCB1NjQgc2l6ZSk7DQo+ICsNCj4gKy8qKg0KPiArICogb2N4bF9saW5rX2xwY19t
YXAoKSAtIE1hcCB0aGUgTFBDIG1lbW9yeSBmb3IgYW4gT3BlbkNBUEkgZGV2aWNlDQo+ICsgKg0K
PiArICogU2luY2UgTFBDIG1lbW9yeSBiZWxvbmdzIHRvIGEgbGluaywgdGhlIHdob2xlIExQQyBt
ZW1vcnkgYXZhaWxhYmxlDQo+ICsgKiBvbiB0aGUgbGluayBidXN0IGJlIG1hcHBlZCBpbiBvcmRl
ciB0byBtYWtlIGl0IGFjY2Vzc2libGUgdG8gYSBkZXZpY2UuDQo+ICsgKg0KPiArICogQGxpbmtf
aGFuZGxlOiBUaGUgT3BlbkNBUEkgbGluayBoYW5kbGUNCj4gKyAqIEBwZGV2OiBBIGRldmljZSB0
aGF0IGlzIG9uIHRoZSBsaW5rDQo+ICsgKi8NCj4gK3U2NCBvY3hsX2xpbmtfbHBjX21hcCh2b2lk
ICpsaW5rX2hhbmRsZSwgc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiArDQo+ICsvKioNCj4gKyAq
IG9jeGxfbGlua19scGNfcmVsZWFzZSgpIC0gUmVsZWFzZSB0aGUgTFBDIG1lbW9yeSBkZXZpY2Ug
Zm9yIGFuIE9wZW5DQVBJIGRldmljZQ0KPiArICoNCj4gKyAqIE9mZmxpbmVzIExQQyBtZW1vcnkg
b24gYW4gT3BlbkNBUEkgbGluayBmb3IgYSBkZXZpY2UuIElmIHRoaXMgaXMgdGhlDQo+ICsgKiBs
YXN0IGRldmljZSBvbiB0aGUgbGluayB0byByZWxlYXNlIHRoZSBtZW1vcnksIHVubWFwIGl0IGZy
b20gdGhlIGxpbmsuDQo+ICsgKg0KPiArICogQGxpbmtfaGFuZGxlOiBUaGUgT3BlbkNBUEkgbGlu
ayBoYW5kbGUNCj4gKyAqIEBwZGV2OiBBIGRldmljZSB0aGF0IGlzIG9uIHRoZSBsaW5rDQo+ICsg
Ki8NCj4gK3ZvaWQgb2N4bF9saW5rX2xwY19yZWxlYXNlKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1
Y3QgcGNpX2RldiAqcGRldik7DQo+ICsNCj4gICAjZW5kaWYgLyogX09DWExfSU5URVJOQUxfSF8g
Ki8NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
