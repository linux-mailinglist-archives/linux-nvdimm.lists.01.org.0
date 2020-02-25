Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF5216EC09
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 18:03:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BEFD510FC35BF;
	Tue, 25 Feb 2020 09:04:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CF9F10FC35BB
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 09:04:41 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PGx58k060753
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 12:03:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yax393yky-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 12:03:45 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 25 Feb 2020 17:03:40 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 25 Feb 2020 17:03:34 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PH3WpP42926282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2020 17:03:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0A1D4204B;
	Tue, 25 Feb 2020 17:03:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A651C42045;
	Tue, 25 Feb 2020 17:03:31 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2020 17:03:31 +0000 (GMT)
Subject: Re: [PATCH v3 08/27] ocxl: Emit a log message showing how much LPC
 memory was detected
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-9-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 25 Feb 2020 18:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-9-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022517-0008-0000-0000-0000035657A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022517-0009-0000-0000-00004A7773F7
Message-Id: <f83b0a0f-116e-8e27-00a0-0c3e3ecb7600@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_06:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=852 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002250126
Message-ID-Hash: LLH2K4J5NEZMRGSOEKX3LSN3FWMXUSTV
X-Message-ID-Hash: LLH2K4J5NEZMRGSOEKX3LSN3FWMXUSTV
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LLH2K4J5NEZMRGSOEKX3LSN3FWMXUSTV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGVtaXRzIGEgbWVzc2FnZSBzaG93aW5nIGhvdyBtdWNoIExQQyBtZW1vcnkgJiBz
cGVjaWFsIHB1cnBvc2UNCj4gbWVtb3J5IHdhcyBkZXRlY3RlZCBvbiBhbiBPQ1hMIGRldmljZS4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEu
b3JnPg0KPiAtLS0NCg0KDQpBY2tlZC1ieTogRnJlZGVyaWMgQmFycmF0IDxmYmFycmF0QGxpbnV4
LmlibS5jb20+DQoNCg0KDQo+ICAgZHJpdmVycy9taXNjL29jeGwvY29uZmlnLmMgfCA0ICsrKysN
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9taXNjL29jeGwvY29uZmlnLmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYw0K
PiBpbmRleCBhNjJlM2Q3ZGIyYmYuLjcwMWFlNjIxNmFiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9taXNjL29jeGwvY29uZmlnLmMNCj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvY29uZmlnLmMN
Cj4gQEAgLTU2OCw2ICs1NjgsMTAgQEAgc3RhdGljIGludCByZWFkX2FmdV9scGNfbWVtb3J5X2lu
Zm8oc3RydWN0IHBjaV9kZXYgKmRldiwNCj4gICAJCWFmdS0+c3BlY2lhbF9wdXJwb3NlX21lbV9z
aXplID0NCj4gICAJCQl0b3RhbF9tZW1fc2l6ZSAtIGxwY19tZW1fc2l6ZTsNCj4gICAJfQ0KPiAr
DQo+ICsJZGV2X2luZm8oJmRldi0+ZGV2LCAiUHJvYmVkIExQQyBtZW1vcnkgb2YgJSNsbHggYnl0
ZXMgYW5kIHNwZWNpYWwgcHVycG9zZSBtZW1vcnkgb2YgJSNsbHggYnl0ZXNcbiIsDQo+ICsJCWFm
dS0+bHBjX21lbV9zaXplLCBhZnUtPnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSk7DQo+ICsNCj4g
ICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4
LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
