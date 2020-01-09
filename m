Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57DF135BD7
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 15:54:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 491BE10097DB6;
	Thu,  9 Jan 2020 06:58:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 757D410097DB5
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 06:58:08 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Eq4AB102462
	for <linux-nvdimm@lists.01.org>; Thu, 9 Jan 2020 09:54:49 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xe0hupfa5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 09 Jan 2020 09:54:48 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 9 Jan 2020 14:54:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 9 Jan 2020 14:54:38 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 009EsaDt56557640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2020 14:54:36 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B693BA4055;
	Thu,  9 Jan 2020 14:54:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DAAA404D;
	Thu,  9 Jan 2020 14:54:35 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2020 14:54:35 +0000 (GMT)
Subject: Re: [PATCH v2 09/27] ocxl: Free detached contexts in
 ocxl_context_detach_all()
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191203034655.51561-1-alastair@au1.ibm.com>
 <20191203034655.51561-10-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 9 Jan 2020 15:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191203034655.51561-10-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20010914-0012-0000-0000-0000037BF30D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010914-0013-0000-0000-000021B814C0
Message-Id: <4c9da9a0-55f4-6cf4-53b8-e8a69744bf98@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_02:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=2 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090130
Message-ID-Hash: E7YQYLEUC2VYNLE3QY4DNQJBTADF6RYU
X-Message-ID-Hash: E7YQYLEUC2VYNLE3QY4DNQJBTADF6RYU
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linu
 x-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/E7YQYLEUC2VYNLE3QY4DNQJBTADF6RYU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDAzLzEyLzIwMTkgw6AgMDQ6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBv
Y3hsX2NvbnRleHRfZGV0YWNoX2FsbCgpIGlzIGNhbGxlZCBmcm9tIG9jeGxfZnVuY3Rpb25fY2xv
c2UoKSwgc28NCj4gdGhlcmUgaXMgbm8gcmVhc29uIHRvIGxlYXZlIHRoZSBjb250ZXh0cyBhbGxv
Y2F0ZWQsIGFzIHRoZSBjYWxsZXINCj4gY2FuIGRvIG5vdGhpbmcgdXNlZnVsIHdpdGggdGhlbSBh
dCB0aGF0IHBvaW50Lg0KPiANCj4gVGhpcyBhbHNvIGhhcyB0aGUgc2lkZS1lZmZlY3Qgb2YgZnJl
ZWluZyBhbnkgYWxsb2NhdGVkIElSUXMNCj4gd2l0aGluIHRoZSBjb250ZXh0Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IC0t
LQ0KDQoNCkkgdGhpbmsgdGhpcyBpcyB3cm9uZyBhbmQgcHJvYmFibHkgdW5uZWVkZWQuIEluIG9j
eGwgKGFuZCBJIHdvdWxkIGFzc3VtZSANCm1vc3QgZHJpdmVycyksIHdlIHNlcGFyYXRlIHByZXR0
eSBjbGVhcmx5IHdoYXQgaXMgc2V0dXAgYnkgdGhlIGRyaXZlciANCmZyYW1ld29yayB3aGVuIGEg
ZGV2aWNlIGlzIHByb2JlZCwgYW5kIHdoYXQgaXMgYWxsb2NhdGVkIGJ5IHRoZSB1c2VycyANCih1
c2VybGFuZCBvciBzY20pLiBDb250ZXh0cyBhcmUgYWxsb2NhdGVkIGJ5IHRoZSB1c2Vycy4gU28g
dGhleSBzaG91bGQgDQpiZSBmcmVlZCBieSB0aGVtIG9ubHkuIFRoYXQgc2VwYXJhdGlvbiBpcyBh
bHNvIHdoeSB3ZSBoYXZlIHNvbWUgDQpyZWZlcmVuY2UgY291bnRpbmcgb24gdGhlIGFmdSBhbmQg
ZnVuY3Rpb24gc3RydWN0cywgdG8gbWFrZSBzdXJlIHRoZSANCmNvcmUgZGF0YSByZW1haW5zIHZh
bGlkIGZvciBhcyBsb25nIGFzIHJlcXVpcmVkLg0KVGhvdWdoIGl0J3MgYSBiaXQgYXNraW5nIGZv
ciB0cm91YmxlcywgaXQgY2FuIGJlIHNlZW4gd2hlbiB1bmJpbmRpbmcgYSANCmZ1bmN0aW9uIGZy
b20gdGhlIGRyaXZlciB0aHJvdWdoIHN5c2ZzLiBUaGF0IHdpbGwgZW5kIHVwIGNhbGxpbmcgDQpv
Y3hsX2Z1bmN0aW9uX2Nsb3NlKCkgYW5kIHRoZXJlZm9yZSBvY3hsX2NvbnRleHRfZGV0YWNoX2Fs
bCgpLiBIb3dldmVyIA0KaXQncyBwb3NzaWJsZSBmb3IgYSB1c2VyIHByb2Nlc3MgdG8gc3RpbGwg
aGF2ZSBhIGZpbGUgZGVzY3JpcHRvciBvcGVuZWQuIA0KVGhlIGNvbnRleHQgaXMgZGV0YWNoZWQg
YW5kIG1hcmtlZCBhcyBDTE9TRUQsIHNvIGFueSBpbnRlcmFjdGlvbiB3aXRoIGl0IA0KZnJvbSB0
aGUgdXNlciB3aWxsIGZhaWwsIGJ1dCBpdCBzaG91bGQgc3RpbGwgYmUgYWxsb2NhdGVkIHNvIHRo
YXQgaXQgaXMgDQp2YWxpZCBpZiB0aGUgdXNlciBwcm9jZXNzIG1ha2VzIGEgc3lzdGVtIGNhbGwg
dG8gdGhlIGRyaXZlci4gVGhlIGNvbnRleHQgDQp3aWxsIGJlIGZyZWVkIHdoZW4gdGhlIGZpbGUg
ZGVzY3JpcHRvciBpcyBjbG9zZWQuDQpJIGRvbid0IHRoaW5rIHRoaXMgaXMgbmVlZGVkIGZvciBz
Y20gZWl0aGVyLCBzaW5jZSB5b3UndmUgbm93IGFkZGVkIHRoZSANCmNvbnRleHQgZGV0YWNoIGFu
ZCBmcmVlIGNhbGwgaW4gZnJlZV9zY20oKQ0KSSB3b3VsZCBqdXN0IGRyb3AgdGhpcyBwYXRjaC4N
Cg0KICAgRnJlZA0KDQoNCg0KPiAgIGRyaXZlcnMvbWlzYy9vY3hsL2NvbnRleHQuYyB8IDYgKysr
KystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvbnRleHQuYyBiL2RyaXZlcnMv
bWlzYy9vY3hsL2NvbnRleHQuYw0KPiBpbmRleCA5OTQ1NjNhMDc4ZWIuLjZjYjM2ZWY5NmUwOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9taXNjL29jeGwvY29udGV4dC5jDQo+ICsrKyBiL2RyaXZl
cnMvbWlzYy9vY3hsL2NvbnRleHQuYw0KPiBAQCAtMjU5LDEwICsyNTksMTEgQEAgdm9pZCBvY3hs
X2NvbnRleHRfZGV0YWNoX2FsbChzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gICB7DQo+ICAgCXN0
cnVjdCBvY3hsX2NvbnRleHQgKmN0eDsNCj4gICAJaW50IHRtcDsNCj4gKwlpbnQgcmM7DQo+ICAg
DQo+ICAgCW11dGV4X2xvY2soJmFmdS0+Y29udGV4dHNfbG9jayk7DQo+ICAgCWlkcl9mb3JfZWFj
aF9lbnRyeSgmYWZ1LT5jb250ZXh0c19pZHIsIGN0eCwgdG1wKSB7DQo+IC0JCW9jeGxfY29udGV4
dF9kZXRhY2goY3R4KTsNCj4gKwkJcmMgPSBvY3hsX2NvbnRleHRfZGV0YWNoKGN0eCk7DQo+ICAg
CQkvKg0KPiAgIAkJICogV2UgYXJlIGZvcmNlIGRldGFjaGluZyAtIHJlbW92ZSBhbnkgYWN0aXZl
IG1taW8NCj4gICAJCSAqIG1hcHBpbmdzIHNvIHVzZXJzcGFjZSBjYW5ub3QgaW50ZXJmZXJlIHdp
dGggdGhlDQo+IEBAIC0yNzQsNiArMjc1LDkgQEAgdm9pZCBvY3hsX2NvbnRleHRfZGV0YWNoX2Fs
bChzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gICAJCWlmIChjdHgtPm1hcHBpbmcpDQo+ICAgCQkJ
dW5tYXBfbWFwcGluZ19yYW5nZShjdHgtPm1hcHBpbmcsIDAsIDAsIDEpOw0KPiAgIAkJbXV0ZXhf
dW5sb2NrKCZjdHgtPm1hcHBpbmdfbG9jayk7DQo+ICsNCj4gKwkJaWYgKHJjICE9IC1FQlVTWSkN
Cj4gKwkJCW9jeGxfY29udGV4dF9mcmVlKGN0eCk7DQo+ICAgCX0NCj4gICAJbXV0ZXhfdW5sb2Nr
KCZhZnUtPmNvbnRleHRzX2xvY2spOw0KPiAgIH0NCj4gDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
