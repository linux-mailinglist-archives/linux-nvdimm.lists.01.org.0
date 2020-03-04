Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3331E17924D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 15:26:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D93010FC3639;
	Wed,  4 Mar 2020 06:27:11 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40A9810FC337F
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 06:27:09 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024EMVkl136868
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 09:26:17 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmg2ju0r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 09:26:16 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Wed, 4 Mar 2020 14:26:07 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 4 Mar 2020 14:26:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024EPwZ512648592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2020 14:25:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93DBCAE04D;
	Wed,  4 Mar 2020 14:25:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A97CAE045;
	Wed,  4 Mar 2020 14:25:57 +0000 (GMT)
Received: from pic2.home (unknown [9.145.145.27])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2020 14:25:57 +0000 (GMT)
Subject: Re: [PATCH v3 22/27] powerpc/powernv/pmem: Implement the heartbeat
 command
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-23-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 4 Mar 2020 15:25:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-23-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030414-0016-0000-0000-000002ED23C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030414-0017-0000-0000-00003350725A
Message-Id: <c660294c-58aa-24cc-efd1-291ffe4836c1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_05:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040109
Message-ID-Hash: WR27DNIIO363C5X3YJ4MH55IZLW44Q36
X-Message-ID-Hash: WR27DNIIO363C5X3YJ4MH55IZLW44Q36
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WR27DNIIO363C5X3YJ4MH55IZLW44Q36/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGUgaGVhcnRiZWF0IGFkbWluIGNvbW1hbmQgaXMgYSBzaW1wbGUgYWRtaW4gY29tbWFuZCB0aGF0
IGV4ZXJjaXNlcw0KPiB0aGUgY29tbXVuaWNhdGlvbiBtZWNoYW5pc21zIHdpdGhpbiB0aGUgY29u
dHJvbGxlci4NCj4gDQo+IFRoaXMgcGF0Y2ggaXNzdWVzIGEgaGVhcnRiZWF0IGNvbW1hbmQgdG8g
dGhlIGNhcmQgZHVyaW5nIGluaXQgdG8gZW5zdXJlDQo+IHdlIGNhbiBjb21tdW5pY2F0ZSB3aXRo
IHRoZSBjYXJkJ3MgY29udHJvbGxlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQn
U2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEub3JnPg0KPiAtLS0NCg0KDQpOb3RoaW5nIHRvIGFkZCBj
b21wYXJlZCB0byB3aGF0IGhhcyBhbHJlYWR5IGJlZW4gY29tbWVudGVkIG9uIHByZXZpb3VzIA0K
cGF0Y2hlcyAocmMgbm90IHNldCBpbiBwcm9iZSgpLCBoaWdoZXIgbGV2ZWwgZnVuY3Rpb24gdG8g
ZXhlY3V0ZSBhZG1pbiANCmNvbW1hbmQgaW4gb25lIGNhbGwpLg0KDQogICBGcmVkDQoNCg0KDQo+
ICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jIHwgNDMgKysrKysr
KysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4
bC5jIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jDQo+IGluZGV4
IDA4MTg4M2E4MjQ3YS4uZTAxZjZmOWZjMTgwIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL3Bvd2VybnYvcG1lbS9vY3hsLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRm
b3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jDQo+IEBAIC0zMDYsNiArMzA2LDQ0IEBAIHN0YXRpYyBi
b29sIGlzX3VzYWJsZShjb25zdCBzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtLCBib29sIHZlcmJv
c2UpDQo+ICAgCXJldHVybiB0cnVlOw0KPiAgIH0NCj4gICANCj4gKy8qKg0KPiArICogaGVhcnRi
ZWF0KCkgLSBJc3N1ZSBhIGhlYXJ0YmVhdCBjb21tYW5kIHRvIHRoZSBjb250cm9sbGVyDQo+ICsg
KiBAb2N4bHBtZW06IHRoZSBkZXZpY2UgbWV0YWRhdGENCj4gKyAqIFJldHVybjogMCBpZiB0aGUg
Y29udHJvbGxlciByZXNwb25kZWQgY29ycmVjdGx5LCBuZWdhdGl2ZSBvbiBlcnJvcg0KPiArICov
DQo+ICtzdGF0aWMgaW50IGhlYXJ0YmVhdChzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtKQ0KPiAr
ew0KPiArCWludCByYzsNCj4gKw0KPiArCW11dGV4X2xvY2soJm9jeGxwbWVtLT5hZG1pbl9jb21t
YW5kLmxvY2spOw0KPiArDQo+ICsJcmMgPSBhZG1pbl9jb21tYW5kX3JlcXVlc3Qob2N4bHBtZW0s
IEFETUlOX0NPTU1BTkRfSEVBUlRCRUFUKTsNCj4gKwlpZiAocmMpDQo+ICsJCWdvdG8gb3V0Ow0K
PiArDQo+ICsJcmMgPSBhZG1pbl9jb21tYW5kX2V4ZWN1dGUob2N4bHBtZW0pOw0KPiArCWlmIChy
YykNCj4gKwkJZ290byBvdXQ7DQo+ICsNCj4gKwlyYyA9IGFkbWluX2NvbW1hbmRfY29tcGxldGVf
dGltZW91dChvY3hscG1lbSwgQURNSU5fQ09NTUFORF9IRUFSVEJFQVQpOw0KPiArCWlmIChyYyA8
IDApIHsNCj4gKwkJZGV2X2Vycigmb2N4bHBtZW0tPmRldiwgIkhlYXJ0YmVhdCB0aW1lb3V0XG4i
KTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmMgPSBhZG1pbl9yZXNwb25zZShv
Y3hscG1lbSk7DQo+ICsJaWYgKHJjIDwgMCkNCj4gKwkJZ290byBvdXQ7DQo+ICsJaWYgKHJjICE9
IFNUQVRVU19TVUNDRVNTKQ0KPiArCQl3YXJuX3N0YXR1cyhvY3hscG1lbSwgIlVuZXhwZWN0ZWQg
c3RhdHVzIGZyb20gaGVhcnRiZWF0IiwgcmMpOw0KPiArDQo+ICsJKHZvaWQpYWRtaW5fcmVzcG9u
c2VfaGFuZGxlZChvY3hscG1lbSk7DQo+ICsNCj4gK291dDoNCj4gKwltdXRleF91bmxvY2soJm9j
eGxwbWVtLT5hZG1pbl9jb21tYW5kLmxvY2spOw0KPiArCXJldHVybiByYzsNCj4gK30NCj4gKw0K
PiAgIC8qKg0KPiAgICAqIGFsbG9jYXRlX21pbm9yKCkgLSBBbGxvY2F0ZSBhIG1pbm9yIG51bWJl
ciB0byB1c2UgZm9yIGFuIE9wZW5DQVBJIHBtZW0gZGV2aWNlDQo+ICAgICogQG9jeGxwbWVtOiB0
aGUgZGV2aWNlIG1ldGFkYXRhDQo+IEBAIC0xNDU4LDYgKzE0OTYsMTEgQEAgc3RhdGljIGludCBw
cm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVu
dCkNCj4gICAJCWdvdG8gZXJyOw0KPiAgIAl9DQo+ICAgDQo+ICsJaWYgKGhlYXJ0YmVhdChvY3hs
cG1lbSkpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAiSGVhcnRiZWF0IGZhaWxlZFxuIik7
DQo+ICsJCWdvdG8gZXJyOw0KPiArCX0NCj4gKw0KPiAgIAllbGFwc2VkID0gMDsNCj4gICAJdGlt
ZW91dCA9IG9jeGxwbWVtLT5yZWFkaW5lc3NfdGltZW91dCArIG9jeGxwbWVtLT5tZW1vcnlfYXZh
aWxhYmxlX3RpbWVvdXQ7DQo+ICAgCXdoaWxlICghaXNfdXNhYmxlKG9jeGxwbWVtLCBmYWxzZSkp
IHsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
