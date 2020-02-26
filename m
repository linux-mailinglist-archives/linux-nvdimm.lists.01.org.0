Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FAB16F444
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 01:29:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E56610FC36D2;
	Tue, 25 Feb 2020 16:30:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B29910FC36CF
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 16:30:21 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01Q0JLB7056361
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:29:28 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ydcqva85r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 19:29:28 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 26 Feb 2020 00:29:25 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 26 Feb 2020 00:29:19 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01Q0TI8544302718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2020 00:29:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F6735204F;
	Wed, 26 Feb 2020 00:29:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 73E275204E;
	Wed, 26 Feb 2020 00:29:17 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C7E00A00F1;
	Wed, 26 Feb 2020 11:29:12 +1100 (AEDT)
Subject: Re: [PATCH v3 06/27] ocxl: Tally up the LPC memory on a link &
 allow it to be mapped
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 26 Feb 2020 11:29:16 +1100
In-Reply-To: <4c8f704b-5607-5ca0-c00e-01e412117f6b@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-7-alastair@au1.ibm.com>
	 <4c8f704b-5607-5ca0-c00e-01e412117f6b@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022600-0028-0000-0000-000003DDFA10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022600-0029-0000-0000-000024A31410
Message-Id: <7833545b1c276ac62651c598af27728b8cacabed.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_09:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 suspectscore=2 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260000
Message-ID-Hash: P47XXZHWX7KXTUBTGNBJHFQ7BCOGRA2T
X-Message-ID-Hash: P47XXZHWX7KXTUBTGNBJHFQ7BCOGRA2T
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-
 dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P47XXZHWX7KXTUBTGNBJHFQ7BCOGRA2T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCAyMDIwLTAyLTI1IGF0IDE3OjMwICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyMS8wMi8yMDIwIMOgIDA0OjI2LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBUYWxseSB1cCB0aGUgTFBDIG1lbW9yeSBvbiBhbiBPcGVuQ0FQSSBsaW5rICYgYWxs
b3cgaXQgdG8gYmUgbWFwcGVkDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3RhaXIgRCdT
aWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL21pc2Mv
b2N4bC9jb3JlLmMgICAgICAgICAgfCAxMCArKysrKysNCj4gPiAgIGRyaXZlcnMvbWlzYy9vY3hs
L2xpbmsuYyAgICAgICAgICB8IDUzDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oIHwgMzMgKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA5NiBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYyBiL2RyaXZlcnMvbWlz
Yy9vY3hsL2NvcmUuYw0KPiA+IGluZGV4IGI3YTA5YjIxYWIzNi4uMjUzMWM2Y2YxOWEwIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bWlzYy9vY3hsL2NvcmUuYw0KPiA+IEBAIC0yMzAsOCArMjMwLDE4IEBAIHN0YXRpYyBpbnQgY29u
ZmlndXJlX2FmdShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSwNCj4gPiB1OCBhZnVfaWR4LCBzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQ0KPiA+ICAgCWlmIChyYykNCj4gPiAgIAkJZ290byBlcnJfZnJlZV9wYXNp
ZDsNCj4gPiAgIA0KPiA+ICsJaWYgKGFmdS0+Y29uZmlnLmxwY19tZW1fc2l6ZSB8fCBhZnUtDQo+
ID4gPmNvbmZpZy5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUpIHsNCj4gPiArCQlyYyA9IG9jeGxf
bGlua19hZGRfbHBjX21lbShhZnUtPmZuLT5saW5rLCBhZnUtDQo+ID4gPmNvbmZpZy5scGNfbWVt
X29mZnNldCwNCj4gPiArCQkJCQkgICBhZnUtPmNvbmZpZy5scGNfbWVtX3NpemUgKw0KPiA+ICsJ
CQkJCSAgIGFmdS0NCj4gPiA+Y29uZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSk7DQo+ID4g
KwkJaWYgKHJjKQ0KPiA+ICsJCQlnb3RvIGVycl9mcmVlX21taW87DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICAgCXJldHVybiAwOw0KPiA+ICAgDQo+ID4gK2Vycl9mcmVlX21taW86DQo+ID4gKwl1bm1h
cF9tbWlvX2FyZWFzKGFmdSk7DQo+ID4gICBlcnJfZnJlZV9wYXNpZDoNCj4gPiAgIAlyZWNsYWlt
X2FmdV9wYXNpZChhZnUpOw0KPiA+ICAgZXJyX2ZyZWVfYWN0YWc6DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbWlzYy9vY3hsL2xpbmsuYyBiL2RyaXZlcnMvbWlzYy9vY3hsL2xpbmsuYw0KPiA+
IGluZGV4IDU4ZDExMWFmZDlmNi4uMWUwMzljYzVlYmU1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbWlzYy9vY3hsL2xpbmsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL2xpbmsuYw0K
PiA+IEBAIC04NCw2ICs4NCwxMSBAQCBzdHJ1Y3Qgb2N4bF9saW5rIHsNCj4gPiAgIAlpbnQgZGV2
Ow0KPiA+ICAgCWF0b21pY190IGlycV9hdmFpbGFibGU7DQo+ID4gICAJc3RydWN0IHNwYSAqc3Bh
Ow0KPiA+ICsJc3RydWN0IG11dGV4IGxwY19tZW1fbG9jazsgLyogcHJvdGVjdHMgbHBjX21lbSAm
IGxwY19tZW1fc3ogKi8NCj4gPiArCXU2NCBscGNfbWVtX3N6OyAvKiBUb3RhbCBhbW91bnQgb2Yg
TFBDIG1lbW9yeSBwcmVzZW50ZWQgb24gdGhlDQo+ID4gbGluayAqLw0KPiA+ICsJdTY0IGxwY19t
ZW07DQo+ID4gKwlpbnQgbHBjX2NvbnN1bWVyczsNCj4gPiArDQo+ID4gICAJdm9pZCAqcGxhdGZv
cm1fZGF0YTsNCj4gPiAgIH07DQo+ID4gICBzdGF0aWMgc3RydWN0IGxpc3RfaGVhZCBsaW5rc19s
aXN0ID0gTElTVF9IRUFEX0lOSVQobGlua3NfbGlzdCk7DQo+ID4gQEAgLTM5Niw2ICs0MDEsOCBA
QCBzdGF0aWMgaW50IGFsbG9jX2xpbmsoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50DQo+ID4gUEVf
bWFzaywgc3RydWN0IG9jeGxfbGluayAqKm91dF9sDQo+ID4gICAJaWYgKHJjKQ0KPiA+ICAgCQln
b3RvIGVycl9zcGE7DQo+ID4gICANCj4gPiArCW11dGV4X2luaXQoJmxpbmstPmxwY19tZW1fbG9j
ayk7DQo+ID4gKw0KPiA+ICAgCS8qIHBsYXRmb3JtIHNwZWNpZmljIGhvb2sgKi8NCj4gPiAgIAly
YyA9IHBudl9vY3hsX3NwYV9zZXR1cChkZXYsIGxpbmstPnNwYS0+c3BhX21lbSwgUEVfbWFzaywN
Cj4gPiAgIAkJCQkmbGluay0+cGxhdGZvcm1fZGF0YSk7DQo+ID4gQEAgLTcxMSwzICs3MTgsNDkg
QEAgdm9pZCBvY3hsX2xpbmtfZnJlZV9pcnEodm9pZCAqbGlua19oYW5kbGUsIGludA0KPiA+IGh3
X2lycSkNCj4gPiAgIAlhdG9taWNfaW5jKCZsaW5rLT5pcnFfYXZhaWxhYmxlKTsNCj4gPiAgIH0N
Cj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKG9jeGxfbGlua19mcmVlX2lycSk7DQo+ID4gKw0KPiA+
ICtpbnQgb2N4bF9saW5rX2FkZF9scGNfbWVtKHZvaWQgKmxpbmtfaGFuZGxlLCB1NjQgb2Zmc2V0
LCB1NjQgc2l6ZSkNCj4gPiArew0KPiA+ICsJc3RydWN0IG9jeGxfbGluayAqbGluayA9IChzdHJ1
Y3Qgb2N4bF9saW5rICopIGxpbmtfaGFuZGxlOw0KPiA+ICsNCj4gPiArCS8vIENoZWNrIGZvciBv
dmVyZmxvdw0KPiA+ICsJaWYgKG9mZnNldCA+IChvZmZzZXQgKyBzaXplKSkNCj4gPiArCQlyZXR1
cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2sp
Ow0KPiA+ICsJbGluay0+bHBjX21lbV9zeiA9IG1heChsaW5rLT5scGNfbWVtX3N6LCBvZmZzZXQg
KyBzaXplKTsNCj4gPiArDQo+ID4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7
DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3U2NCBvY3hsX2xp
bmtfbHBjX21hcCh2b2lkICpsaW5rX2hhbmRsZSwgc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBvY3hsX2xpbmsgKmxpbmsgPSAoc3RydWN0IG9jeGxfbGluayAqKSBs
aW5rX2hhbmRsZTsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2sp
Ow0KPiA+ICsNCj4gPiArCWlmKCFsaW5rLT5scGNfbWVtKQ0KPiA+ICsJCWxpbmstPmxwY19tZW0g
PSBwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAocGRldiwgbGluay0NCj4gPiA+bHBjX21lbV9z
eik7DQo+ID4gKw0KPiA+ICsJaWYobGluay0+bHBjX21lbSkNCj4gPiArCQlsaW5rLT5scGNfY29u
c3VtZXJzKys7DQo+ID4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIGxpbmstPmxwY19tZW07DQo+ID4gK30NCj4gPiArDQo+ID4gK3ZvaWQg
b2N4bF9saW5rX2xwY19yZWxlYXNlKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3QgcGNpX2Rldg0K
PiA+ICpwZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgb2N4bF9saW5rICpsaW5rID0gKHN0cnVj
dCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfbG9jaygmbGlu
ay0+bHBjX21lbV9sb2NrKTsNCj4gPiArCVdBUk5fT04oLS1saW5rLT5scGNfY29uc3VtZXJzIDwg
MCk7DQo+IA0KPiBIZXJlLCB3ZSBhbHdheXMgZGVjcmVtZW50IHRoZSBscGNfY29uc3VtZXJzIGNv
dW50LiBIb3dldmVyLCBpdCB3YXMNCj4gb25seSANCj4gaW5jcmVtZW50ZWQgaWYgdGhlIG1hcHBp
bmcgd2FzIHNldHVwIGNvcnJlY3RseSBpbiBvcGFsLg0KPiANCj4gV2UgY291bGQgYXJndWFibHkg
Y2xhaW0gdGhhdCBvY3hsX2xpbmtfbHBjX3JlbGVhc2UoKSBzaG91bGQgb25seSBiZSANCj4gY2Fs
bGVkIGlmIG9jeGxfbGlua19scGNfbWFwKCkgc3VjY2VlZGVkLCBidXQgaXQgd291bGQgbWFrZSBl
cnJvcg0KPiBwYXRoIA0KPiBoYW5kbGluZyBlYXNpZXIgaWYgd2Ugb25seSBkZWNyZW1lbnQgdGhl
IGxwY19jb25zdW1lcnMgY291bnQgaWYgDQo+IGxpbmstPmxwY19tZW0gaXMgc2V0LiBTbyB0aGF0
IHdlIGNhbiBqdXN0IGNhbGwNCj4gb2N4bF9saW5rX2xwY19yZWxlYXNlKCkgDQo+IGluIGVycm9y
IHBhdGhzIHdpdGhvdXQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IHRyaWdnZXJpbmcgdGhlIFdBUk5f
T04NCj4gbWVzc2FnZS4NCj4gDQo+ICAgIEZyZWQNCj4gDQo+IA0KDQpPaywgdGhpcyBtYWtlcyBz
ZW5zZS4NCg0KPiANCj4gPiArCWlmIChsaW5rLT5scGNfY29uc3VtZXJzID09IDApIHsNCj4gPiAr
CQlwbnZfb2N4bF9wbGF0Zm9ybV9scGNfcmVsZWFzZShwZGV2KTsNCj4gPiArCQlsaW5rLT5scGNf
bWVtID0gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwltdXRleF91bmxvY2soJmxpbmstPmxwY19t
ZW1fbG9jayk7DQo+ID4gK30NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvb2N4
bF9pbnRlcm5hbC5oDQo+ID4gYi9kcml2ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmgNCj4g
PiBpbmRleCAxOThlNGU0YmM1MWQuLmQwYzhjNDgzOGY0MiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL21pc2Mvb2N4bC9vY3hsX2ludGVybmFsLmgNCj4gPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4
bC9vY3hsX2ludGVybmFsLmgNCj4gPiBAQCAtMTQyLDQgKzE0MiwzNyBAQCBpbnQgb2N4bF9pcnFf
b2Zmc2V0X3RvX2lkKHN0cnVjdCBvY3hsX2NvbnRleHQNCj4gPiAqY3R4LCB1NjQgb2Zmc2V0KTsN
Cj4gPiAgIHU2NCBvY3hsX2lycV9pZF90b19vZmZzZXQoc3RydWN0IG9jeGxfY29udGV4dCAqY3R4
LCBpbnQgaXJxX2lkKTsNCj4gPiAgIHZvaWQgb2N4bF9hZnVfaXJxX2ZyZWVfYWxsKHN0cnVjdCBv
Y3hsX2NvbnRleHQgKmN0eCk7DQo+ID4gICANCj4gPiArLyoqDQo+ID4gKyAqIG9jeGxfbGlua19h
ZGRfbHBjX21lbSgpIC0gSW5jcmVtZW50IHRoZSBhbW91bnQgb2YgbWVtb3J5DQo+ID4gcmVxdWly
ZWQgYnkgYW4gT3BlbkNBUEkgbGluaw0KPiA+ICsgKg0KPiA+ICsgKiBAbGlua19oYW5kbGU6IFRo
ZSBPcGVuQ0FQSSBsaW5rIGhhbmRsZQ0KPiA+ICsgKiBAb2Zmc2V0OiBUaGUgb2Zmc2V0IG9mIHRo
ZSBtZW1vcnkgdG8gYWRkDQo+ID4gKyAqIEBzaXplOiBUaGUgYW1vdW50IG9mIG1lbW9yeSB0byBp
bmNyZW1lbnQgYnkNCj4gPiArICoNCj4gPiArICogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG5lZ2F0
aXZlIG9uIG92ZXJmbG93DQo+ID4gKyAqLw0KPiA+ICtpbnQgb2N4bF9saW5rX2FkZF9scGNfbWVt
KHZvaWQgKmxpbmtfaGFuZGxlLCB1NjQgb2Zmc2V0LCB1NjQNCj4gPiBzaXplKTsNCj4gPiArDQo+
ID4gKy8qKg0KPiA+ICsgKiBvY3hsX2xpbmtfbHBjX21hcCgpIC0gTWFwIHRoZSBMUEMgbWVtb3J5
IGZvciBhbiBPcGVuQ0FQSSBkZXZpY2UNCj4gPiArICogU2luY2UgTFBDIG1lbW9yeSBiZWxvbmdz
IHRvIGEgbGluaywgdGhlIHdob2xlIExQQyBtZW1vcnkNCj4gPiBhdmFpbGFibGUNCj4gPiArICog
b24gdGhlIGxpbmsgbXVzdCBiZSBtYXBwZWQgaW4gb3JkZXIgdG8gbWFrZSBpdCBhY2Nlc3NpYmxl
IHRvIGENCj4gPiBkZXZpY2UuDQo+ID4gKyAqIEBsaW5rX2hhbmRsZTogVGhlIE9wZW5DQVBJIGxp
bmsgaGFuZGxlDQo+ID4gKyAqIEBwZGV2OiBBIGRldmljZSB0aGF0IGlzIG9uIHRoZSBsaW5rDQo+
ID4gKyAqDQo+ID4gKyAqIFJldHVybnMgdGhlIGFkZHJlc3Mgb2YgdGhlIG1hcHBlZCBMUEMgbWVt
b3J5LCBvciAwIG9uIGVycm9yDQo+ID4gKyAqLw0KPiA+ICt1NjQgb2N4bF9saW5rX2xwY19tYXAo
dm9pZCAqbGlua19oYW5kbGUsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gPiArDQo+ID4gKy8q
Kg0KPiA+ICsgKiBvY3hsX2xpbmtfbHBjX3JlbGVhc2UoKSAtIFJlbGVhc2UgdGhlIExQQyBtZW1v
cnkgZGV2aWNlIGZvciBhbg0KPiA+IE9wZW5DQVBJIGRldmljZQ0KPiA+ICsgKg0KPiA+ICsgKiBP
ZmZsaW5lcyBMUEMgbWVtb3J5IG9uIGFuIE9wZW5DQVBJIGxpbmsgZm9yIGEgZGV2aWNlLiBJZiB0
aGlzDQo+ID4gaXMgdGhlDQo+ID4gKyAqIGxhc3QgZGV2aWNlIG9uIHRoZSBsaW5rIHRvIHJlbGVh
c2UgdGhlIG1lbW9yeSwgdW5tYXAgaXQgZnJvbQ0KPiA+IHRoZSBsaW5rLg0KPiA+ICsgKg0KPiA+
ICsgKiBAbGlua19oYW5kbGU6IFRoZSBPcGVuQ0FQSSBsaW5rIGhhbmRsZQ0KPiA+ICsgKiBAcGRl
djogQSBkZXZpY2UgdGhhdCBpcyBvbiB0aGUgbGluaw0KPiA+ICsgKi8NCj4gPiArdm9pZCBvY3hs
X2xpbmtfbHBjX3JlbGVhc2Uodm9pZCAqbGlua19oYW5kbGUsIHN0cnVjdCBwY2lfZGV2DQo+ID4g
KnBkZXYpOw0KPiA+ICsNCj4gPiAgICNlbmRpZiAvKiBfT0NYTF9JTlRFUk5BTF9IXyAqLw0KPiA+
IA0KLS0gDQpBbGFzdGFpciBEJ1NpbHZhDQpPcGVuIFNvdXJjZSBEZXZlbG9wZXINCkxpbnV4IFRl
Y2hub2xvZ3kgQ2VudHJlLCBJQk0gQXVzdHJhbGlhDQptb2I6IDA0MjMgNzYyIDgxOQ0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
