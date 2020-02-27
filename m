Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3535171283
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 09:27:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17A0810FC3626;
	Thu, 27 Feb 2020 00:28:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B801E10FC361D
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 00:28:23 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R8OOp1175466
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 03:27:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yden24mb9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 03:27:30 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Thu, 27 Feb 2020 08:27:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 27 Feb 2020 08:27:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R8RJaa58851568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2020 08:27:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E4094C044;
	Thu, 27 Feb 2020 08:27:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4D34C046;
	Thu, 27 Feb 2020 08:27:18 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2020 08:27:18 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A5F70A01C0;
	Thu, 27 Feb 2020 19:27:13 +1100 (AEDT)
Subject: Re: [PATCH v3 14/27] powerpc/powernv/pmem: Add support for Admin
 commands
From: Andrew Donnellan <ajd@linux.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-15-alastair@au1.ibm.com>
 <c88a3808-3ce9-ff6c-b963-ca9317092145@linux.ibm.com>
Date: Thu, 27 Feb 2020 19:27:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <c88a3808-3ce9-ff6c-b963-ca9317092145@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022708-0028-0000-0000-000003DE6B81
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022708-0029-0000-0000-000024A389F3
Message-Id: <cf2b3037-6436-1244-e125-c95542528823@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_02:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=764 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270068
Message-ID-Hash: 3RCNUIZ6OZVP5635HSZBY44MU2AONUBH
X-Message-ID-Hash: 3RCNUIZ6OZVP5635HSZBY44MU2AONUBH
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc
 -dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3RCNUIZ6OZVP5635HSZBY44MU2AONUBH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMjcvMi8yMCA3OjIyIHBtLCBBbmRyZXcgRG9ubmVsbGFuIHdyb3RlOg0KPj4gK2ludCBhZG1p
bl9jb21tYW5kX3JlcXVlc3Qoc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSwgdTggb3BfY29kZSkN
Cj4+ICt7DQo+PiArwqDCoMKgIHU2NCB2YWw7DQo+PiArwqDCoMKgIGludCByYyA9IG9jeGxfZ2xv
YmFsX21taW9fcmVhZDY0KG9jeGxwbWVtLT5vY3hsX2FmdSwgDQo+PiBHTE9CQUxfTU1JT19DSEks
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPQ1hMX0xJVFRM
RV9FTkRJQU4sICZ2YWwpOw0KPj4gK8KgwqDCoCBpZiAocmMpDQo+PiArwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIHJjOw0KPiANCj4gSWdub3JpbmcgdGhlIHZhbHVlIGhlcmUgZXhwZWN0ZWQsIHlvdSdy
ZSBqdXN0IHRyeWluZyB0byB2ZXJpZnkgdGhhdCB5b3UgDQo+IGRvbid0IHNlZSBhbiBlcnJvciBv
biB0aGUgcmVhZD8NCg0KSSBzZWUgdGhhdCBpbiB0aGUgbmV4dCBwYXRjaCwgaW4gbnNfY29tbWFu
ZF9yZXF1ZXN0KCkgeW91IGNoZWNrIHRoYXQgDQpOU0NSQSBpcyAxIC0gZGlkIHlvdSBtZWFuIHRv
IGNoZWNrIHRoYXQgQUNSQSA9IDEgaGVyZT8NCg0KDQotLSANCkFuZHJldyBEb25uZWxsYW4gICAg
ICAgICAgICAgIE96TGFicywgQURMIENhbmJlcnJhDQphamRAbGludXguaWJtLmNvbSAgICAgICAg
ICAgICBJQk0gQXVzdHJhbGlhIExpbWl0ZWQNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
