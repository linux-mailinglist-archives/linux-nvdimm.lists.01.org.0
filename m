Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E80135BA6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 15:48:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B71310097DAF;
	Thu,  9 Jan 2020 06:51:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1969D10097DAB
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 06:51:42 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009EgG04034338
	for <linux-nvdimm@lists.01.org>; Thu, 9 Jan 2020 09:48:22 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xe0hup71w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 09:48:22 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 9 Jan 2020 14:48:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 Jan 2020 14:48:11 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009Em93M37421252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2020 14:48:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7305EA404D;
	Thu,  9 Jan 2020 14:48:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5228DA4051;
	Thu,  9 Jan 2020 14:48:08 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2020 14:48:08 +0000 (GMT)
Subject: Re: [PATCH v2 06/27] ocxl: Tally up the LPC memory on a link & allow
 it to be mapped
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203034655.51561-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 9 Jan 2020 15:48:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203034655.51561-7-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010914-0012-0000-0000-0000037BF294
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010914-0013-0000-0000-000021B81440
Message-Id: <a2f93729-038e-9fcb-2cf0-53739ae19147@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=2 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090129
Message-ID-Hash: EBADVMZYUGF2UMWUNW333ETA6HL7BDLL
X-Message-ID-Hash: EBADVMZYUGF2UMWUNW333ETA6HL7BDLL
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linu
 x-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EBADVMZYUGF2UMWUNW333ETA6HL7BDLL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDAzLzEyLzIwMTkgw6AgMDQ6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
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
L2xpbmsuYw0KPiBpbmRleCA1OGQxMTFhZmQ5ZjYuLmQ4NTAzZjBkYzZlYyAxMDA2NDQNCj4gLS0t
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
aXplKTsNCj4gKw0KPiArCW11dGV4X3VubG9jaygmbGluay0+bHBjX21lbV9sb2NrKTsNCj4gKw0K
PiArCXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICt1NjQgb2N4bF9saW5rX2xwY19tYXAodm9pZCAq
bGlua19oYW5kbGUsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBvY3hs
X2xpbmsgKmxpbmsgPSAoc3RydWN0IG9jeGxfbGluayAqKSBsaW5rX2hhbmRsZTsNCj4gKwl1NjQg
bHBjX21lbTsNCj4gKw0KPiArCW11dGV4X2xvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ICsJ
aWYgKGxpbmstPmxwY19tZW0pIHsNCj4gKwkJbHBjX21lbSA9IGxpbmstPmxwY19tZW07DQo+ICsN
Cj4gKwkJbGluay0+bHBjX2NvbnN1bWVycysrOw0KPiArCQltdXRleF91bmxvY2soJmxpbmstPmxw
Y19tZW1fbG9jayk7DQo+ICsJCXJldHVybiBscGNfbWVtOw0KPiArCX0NCj4gKw0KPiArCWxpbmst
PmxwY19tZW0gPSBwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAocGRldiwgbGluay0+bHBjX21l
bV9zeik7DQo+ICsJaWYgKGxpbmstPmxwY19tZW0pDQo+ICsJCWxpbmstPmxwY19jb25zdW1lcnMr
KzsNCg0KDQpTbyBpZiB3ZSBmYWlsIHRvIHNldHVwIHRoZSBscGMgYWNjZXNzIGluIG9wYWwsIHdl
IGRvbid0IGluY3JlbWVudCANCmxpbmstPmxwY19jb25zdW1lcnMgYW5kIHdlIHNob3VsZG4ndCBj
YWxsIG9jeGxfbGlua19scGNfcmVsZWFzZSgpLiBJcyANCnRoYXQgYWx3YXlzIHRydWU/IFJpc2sg
aXMgdG8gdHJpZ2dlciB0aGUgd2FybmluZyBpbiANCm9jeGxfbGlua19scGNfcmVsZWFzZSgpLiBT
byBtYXliZSB3ZSBzaG91bGQgY2hlY2sgbGluay0+bHBjX21lbSBmaXJzdCBpbiANCm9jeGxfbGlu
a19scGNfcmVsZWFzZSgpIGFuZCBleGl0IGVhcmx5IGlmIG5vIG1lbW9yeSBpcyBtYXBwZWQuIEl0
IHdvdWxkIA0KcHJvYmFibHkgYXZvaWQgaGl0dGluZyB0aGUgV0FSTiBvbiBhbiBlcnJvciBwYXRo
IGZvciBleGFtcGxlLg0KDQogICAgRnJlZA0KDQoNCj4gKwlscGNfbWVtID0gbGluay0+bHBjX21l
bTsNCj4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ICsNCj4gKwlyZXR1
cm4gbHBjX21lbTsNCj4gK30NCj4gKw0KPiArdm9pZCBvY3hsX2xpbmtfbHBjX3JlbGVhc2Uodm9p
ZCAqbGlua19oYW5kbGUsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiArew0KPiArCXN0cnVjdCBv
Y3hsX2xpbmsgKmxpbmsgPSAoc3RydWN0IG9jeGxfbGluayAqKSBsaW5rX2hhbmRsZTsNCj4gKw0K
PiArCW11dGV4X2xvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ICsJV0FSTl9PTigtLWxpbmst
PmxwY19jb25zdW1lcnMgPCAwKTsNCj4gKwlpZiAobGluay0+bHBjX2NvbnN1bWVycyA9PSAwKSB7
DQo+ICsJCXBudl9vY3hsX3BsYXRmb3JtX2xwY19yZWxlYXNlKHBkZXYpOw0KPiArCQlsaW5rLT5s
cGNfbWVtID0gMDsNCj4gKwl9DQo+ICsNCj4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1f
bG9jayk7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVy
bmFsLmggYi9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmgNCj4gaW5kZXggOTc0MTVh
ZmQ3OWYzLi4yMGI0MTdlMDA5NDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL29j
eGxfaW50ZXJuYWwuaA0KPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmgN
Cj4gQEAgLTE0MSw0ICsxNDEsMzcgQEAgaW50IG9jeGxfaXJxX29mZnNldF90b19pZChzdHJ1Y3Qg
b2N4bF9jb250ZXh0ICpjdHgsIHU2NCBvZmZzZXQpOw0KPiAgIHU2NCBvY3hsX2lycV9pZF90b19v
ZmZzZXQoc3RydWN0IG9jeGxfY29udGV4dCAqY3R4LCBpbnQgaXJxX2lkKTsNCj4gICB2b2lkIG9j
eGxfYWZ1X2lycV9mcmVlX2FsbChzdHJ1Y3Qgb2N4bF9jb250ZXh0ICpjdHgpOw0KPiAgIA0KPiAr
LyoqDQo+ICsgKiBvY3hsX2xpbmtfYWRkX2xwY19tZW0oKSAtIEluY3JlbWVudCB0aGUgYW1vdW50
IG9mIG1lbW9yeSByZXF1aXJlZCBieSBhbiBPcGVuQ0FQSSBsaW5rDQo+ICsgKg0KPiArICogQGxp
bmtfaGFuZGxlOiBUaGUgT3BlbkNBUEkgbGluayBoYW5kbGUNCj4gKyAqIEBvZmZzZXQ6IFRoZSBv
ZmZzZXQgb2YgdGhlIG1lbW9yeSB0byBhZGQNCj4gKyAqIEBzaXplOiBUaGUgYW1vdW50IG9mIG1l
bW9yeSB0byBpbmNyZW1lbnQgYnkNCj4gKyAqDQo+ICsgKiBSZXR1cm4gMCBvbiBzdWNjZXNzLCBu
ZWdhdGl2ZSBvbiBvdmVyZmxvdw0KPiArICovDQo+ICtpbnQgb2N4bF9saW5rX2FkZF9scGNfbWVt
KHZvaWQgKmxpbmtfaGFuZGxlLCB1NjQgb2Zmc2V0LCB1NjQgc2l6ZSk7DQo+ICsNCj4gKy8qKg0K
PiArICogb2N4bF9saW5rX2xwY19tYXAoKSAtIE1hcCB0aGUgTFBDIG1lbW9yeSBmb3IgYW4gT3Bl
bkNBUEkgZGV2aWNlDQo+ICsgKg0KPiArICogU2luY2UgTFBDIG1lbW9yeSBiZWxvbmdzIHRvIGEg
bGluaywgdGhlIHdob2xlIExQQyBtZW1vcnkgYXZhaWxhYmxlDQo+ICsgKiBvbiB0aGUgbGluayBi
dXN0IGJlIG1hcHBlZCBpbiBvcmRlciB0byBtYWtlIGl0IGFjY2Vzc2libGUgdG8gYSBkZXZpY2Uu
DQo+ICsgKg0KPiArICogQGxpbmtfaGFuZGxlOiBUaGUgT3BlbkNBUEkgbGluayBoYW5kbGUNCj4g
KyAqIEBwZGV2OiBBIGRldmljZSB0aGF0IGlzIG9uIHRoZSBsaW5rDQo+ICsgKi8NCj4gK3U2NCBv
Y3hsX2xpbmtfbHBjX21hcCh2b2lkICpsaW5rX2hhbmRsZSwgc3RydWN0IHBjaV9kZXYgKnBkZXYp
Ow0KPiArDQo+ICsvKioNCj4gKyAqIG9jeGxfbGlua19scGNfcmVsZWFzZSgpIC0gUmVsZWFzZSB0
aGUgTFBDIG1lbW9yeSBkZXZpY2UgZm9yIGFuIE9wZW5DQVBJIGRldmljZQ0KPiArICoNCj4gKyAq
IE9mZmxpbmVzIExQQyBtZW1vcnkgb24gYW4gT3BlbkNBUEkgbGluayBmb3IgYSBkZXZpY2UuIElm
IHRoaXMgaXMgdGhlDQo+ICsgKiBsYXN0IGRldmljZSBvbiB0aGUgbGluayB0byByZWxlYXNlIHRo
ZSBtZW1vcnksIHVubWFwIGl0IGZyb20gdGhlIGxpbmsuDQo+ICsgKg0KPiArICogQGxpbmtfaGFu
ZGxlOiBUaGUgT3BlbkNBUEkgbGluayBoYW5kbGUNCj4gKyAqIEBwZGV2OiBBIGRldmljZSB0aGF0
IGlzIG9uIHRoZSBsaW5rDQo+ICsgKi8NCj4gK3ZvaWQgb2N4bF9saW5rX2xwY19yZWxlYXNlKHZv
aWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3QgcGNpX2RldiAqcGRldik7DQo+ICsNCj4gICAjZW5kaWYg
LyogX09DWExfSU5URVJOQUxfSF8gKi8NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
