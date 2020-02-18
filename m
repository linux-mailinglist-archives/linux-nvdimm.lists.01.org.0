Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AF316376A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Feb 2020 00:44:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79C0510FC340D;
	Tue, 18 Feb 2020 15:45:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D5A9810FC33FC
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 15:45:25 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01INcvN4009487
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 18:44:32 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y6e1j6afr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 18:44:32 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Tue, 18 Feb 2020 23:44:29 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 18 Feb 2020 23:44:21 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01INiKuw32571890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2020 23:44:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE065A405B;
	Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B470A4054;
	Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 18 Feb 2020 23:44:20 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A1042A00DF;
	Wed, 19 Feb 2020 10:44:15 +1100 (AEDT)
Subject: Re: [PATCH v2 05/27] powerpc: Map & release OpenCAPI LPC memory
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 19 Feb 2020 10:44:18 +1100
In-Reply-To: <85e5a3d4-bac2-a8fc-8fc7-865be539dc3c@linux.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	 <20191203034655.51561-6-alastair@au1.ibm.com>
	 <85e5a3d4-bac2-a8fc-8fc7-865be539dc3c@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20021823-0016-0000-0000-000002E8165D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021823-0017-0000-0000-0000334B2C77
Message-Id: <91440c75bacf29ac7423e67b71199695ebf636d0.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_08:2020-02-18,2020-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=2 mlxlogscore=677
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002180161
Message-ID-Hash: NDBW6HIEUJZCMRJA2WY6MWFYTQZOWMQF
X-Message-ID-Hash: NDBW6HIEUJZCMRJA2WY6MWFYTQZOWMQF
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, li
 nux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NDBW6HIEUJZCMRJA2WY6MWFYTQZOWMQF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIwLTAyLTE0IGF0IDEyOjA5ICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAwMy8xMi8yMDE5IMOgIDA0OjQ2LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBUaGlzIHBhdGNoIGFkZHMgcGxhdGZvcm0gc3VwcG9ydCB0byBtYXAgJiByZWxlYXNl
IExQQyBtZW1vcnkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3RhaXIgRCdTaWx2YSA8
YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gLS0tDQo+ID4gICBhcmNoL3Bvd2VycGMvaW5jbHVk
ZS9hc20vcG52LW9jeGwuaCAgIHwgIDIgKysNCj4gPiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
cG93ZXJudi9vY3hsLmMgfCA0Mg0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+ID4gYi9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiA+IGluZGV4IDdkZTgyNjQ3ZTc2MS4uZjhmOGZm
YjQ4YWE4IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4
bC5oDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gPiBA
QCAtMzIsNSArMzIsNyBAQCBleHRlcm4gaW50IHBudl9vY3hsX3NwYV9yZW1vdmVfcGVfZnJvbV9j
YWNoZSh2b2lkDQo+ID4gKnBsYXRmb3JtX2RhdGEsIGludCBwZV9oYW5kbGUpDQo+ID4gICANCj4g
PiAgIGV4dGVybiBpbnQgcG52X29jeGxfYWxsb2NfeGl2ZV9pcnEodTMyICppcnEsIHU2NCAqdHJp
Z2dlcl9hZGRyKTsNCj4gPiAgIGV4dGVybiB2b2lkIHBudl9vY3hsX2ZyZWVfeGl2ZV9pcnEodTMy
IGlycSk7DQo+ID4gK2V4dGVybiB1NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0cnVj
dCBwY2lfZGV2ICpwZGV2LCB1NjQNCj4gPiBzaXplKTsNCj4gPiArZXh0ZXJuIHZvaWQgcG52X29j
eGxfcGxhdGZvcm1fbHBjX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiA+ICAgDQo+
ID4gICAjZW5kaWYgLyogX0FTTV9QTlZfT0NYTF9IICovDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gPiBiL2FyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gPiBpbmRleCA4YzY1YWFjZGE5YzguLmI1NmE0OGRhZjQ4
YyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4bC5j
DQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYw0KPiA+IEBA
IC00NzUsNiArNDc1LDQ4IEBAIHZvaWQgcG52X29jeGxfc3BhX3JlbGVhc2Uodm9pZCAqcGxhdGZv
cm1fZGF0YSkNCj4gPiAgIH0NCj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3NwYV9y
ZWxlYXNlKTsNCj4gPiAgIA0KPiA+ICt1NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0
cnVjdCBwY2lfZGV2ICpwZGV2LCB1NjQgc2l6ZSkNCj4gPiArew0KPiA+ICsJc3RydWN0IHBjaV9j
b250cm9sbGVyICpob3NlID0gcGNpX2J1c190b19ob3N0KHBkZXYtPmJ1cyk7DQo+ID4gKwlzdHJ1
Y3QgcG52X3BoYiAqcGhiID0gaG9zZS0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsJdTMyIGJkZm4gPSBw
Y2lfZGV2X2lkKHBkZXYpOw0KPiA+ICsJX19iZTY0IGJhc2VfYWRkcl9iZTY0Ow0KPiA+ICsJdTY0
IGJhc2VfYWRkcjsNCj4gPiArCWludCByYzsNCj4gPiArDQo+ID4gKwlyYyA9IG9wYWxfbnB1X21l
bV9hbGxvYyhwaGItPm9wYWxfaWQsIGJkZm4sIHNpemUsDQo+ID4gJmJhc2VfYWRkcl9iZTY0KTsN
Cj4gPiArCWlmIChyYykgew0KPiA+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsDQo+ID4gKwkJCSAi
T1BBTCBjb3VsZCBub3QgYWxsb2NhdGUgTFBDIG1lbW9yeSwgcmM9JWRcbiIsDQo+ID4gcmMpOw0K
PiA+ICsJCXJldHVybiAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWJhc2VfYWRkciA9IGJlNjRf
dG9fY3B1KGJhc2VfYWRkcl9iZTY0KTsNCj4gPiArDQo+ID4gKwlyYyA9IGNoZWNrX2hvdHBsdWdf
bWVtb3J5X2FkZHJlc3NhYmxlKGJhc2VfYWRkciA+PiBQQUdFX1NISUZULA0KPiA+ICsJCQkJCSAg
ICAgIHNpemUgPj4gUEFHRV9TSElGVCk7DQo+IA0KPiBjaGVja19ob3RwbHVnX21lbW9yeV9hZGRy
ZXNzYWJsZSgpIGlzIG9ubHkgZGVjbGFyZWQgaWYgDQo+IENPTkZJR19NRU1PUllfSE9UUExVR19T
UEFSU0UgaXMgc2VsZWN0ZWQuDQo+IEkgdGhpbmsgd2UgYWxzbyBuZWVkIGEgI2lmZGVmIGhlcmUu
DQo+IA0KDQpBZ3JlZWQuIEkgdGhpbmsgdGhhdCBzaW5jZSBhbnkgYWN0dWFsIHVzZSBvZiB0aGUg
bWVtb3J5IGlzIGdvaW5nIHRvIGJlDQpkZXBlbmRhbnQgb24gYm90aCBob3RwbHVnICYgc3BhcnNl
LCBtb3ZpbmcgdGhlIGlmZGVmIHRvIHdyYXAgdGhlDQpmdW5jdGlvbnMgJiBkZWNsYXJhdGlvbnMg
bWFrZXMgc2Vuc2UuDQoNCg0KPiAgICBGcmVkDQo+IA0KPiANCj4gPiArCWlmIChyYykNCj4gPiAr
CQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYmFzZV9hZGRyOw0KPiA+ICt9DQo+ID4g
K0VYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cCk7DQo+ID4gKw0K
PiA+ICt2b2lkIHBudl9vY3hsX3BsYXRmb3JtX2xwY19yZWxlYXNlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UgPSBwY2lfYnVz
X3RvX2hvc3QocGRldi0+YnVzKTsNCj4gPiArCXN0cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5w
cml2YXRlX2RhdGE7DQo+ID4gKwl1MzIgYmRmbiA9IHBjaV9kZXZfaWQocGRldik7DQo+ID4gKwlp
bnQgcmM7DQo+ID4gKw0KPiA+ICsJcmMgPSBvcGFsX25wdV9tZW1fcmVsZWFzZShwaGItPm9wYWxf
aWQsIGJkZm4pOw0KPiA+ICsJaWYgKHJjKQ0KPiA+ICsJCWRldl93YXJuKCZwZGV2LT5kZXYsDQo+
ID4gKwkJCSAiT1BBTCByZXBvcnRlZCByYz0lZCB3aGVuIHJlbGVhc2luZyBMUEMNCj4gPiBtZW1v
cnlcbiIsIHJjKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwbnZfb2N4bF9wbGF0
Zm9ybV9scGNfcmVsZWFzZSk7DQo+ID4gKw0KPiA+ICsNCj4gPiAgIGludCBwbnZfb2N4bF9zcGFf
cmVtb3ZlX3BlX2Zyb21fY2FjaGUodm9pZCAqcGxhdGZvcm1fZGF0YSwgaW50DQo+ID4gcGVfaGFu
ZGxlKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBzcGFfZGF0YSAqZGF0YSA9IChzdHJ1Y3Qgc3Bh
X2RhdGEgKikgcGxhdGZvcm1fZGF0YTsNCj4gPiANCi0tIA0KQWxhc3RhaXIgRCdTaWx2YQ0KT3Bl
biBTb3VyY2UgRGV2ZWxvcGVyDQpMaW51eCBUZWNobm9sb2d5IENlbnRyZSwgSUJNIEF1c3RyYWxp
YQ0KbW9iOiAwNDIzIDc2MiA4MTkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
