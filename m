Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC90A180EA1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 04:38:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2540110FC36C9;
	Tue, 10 Mar 2020 20:39:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D6D810FC36C9
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 20:39:40 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02B3TM0D167904
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 23:38:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yppv230xx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 10 Mar 2020 23:38:48 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 11 Mar 2020 03:38:45 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 11 Mar 2020 03:38:38 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02B3cbIQ25952406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2020 03:38:37 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2237242041;
	Wed, 11 Mar 2020 03:38:37 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAE7D4203F;
	Wed, 11 Mar 2020 03:38:36 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2020 03:38:36 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 97549A0130;
	Wed, 11 Mar 2020 14:38:31 +1100 (AEDT)
Subject: Re: [PATCH v3 21/27] powerpc/powernv/pmem: Add an IOCTL to request
 controller health & perf data
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan
	 <ajd@linux.ibm.com>
Date: Wed, 11 Mar 2020 14:38:35 +1100
In-Reply-To: <3ecb49e3-8828-ab7b-4391-5dd6127e76e0@linux.ibm.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-22-alastair@au1.ibm.com>
	 <fdc5faec-d03d-3cba-4a9c-add7e522ad13@linux.ibm.com>
	 <3ecb49e3-8828-ab7b-4391-5dd6127e76e0@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20031103-0020-0000-0000-000003B288B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031103-0021-0000-0000-0000220AD6ED
Message-Id: <97d52eefea5f362fee47e378a3e7ae51d565b291.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_17:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=571 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003110020
Message-ID-Hash: U75TLRKB62QO46XFU6GVBTFEYYETQJG3
X-Message-ID-Hash: U75TLRKB62QO46XFU6GVBTFEYYETQJG3
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lis
 ts.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U75TLRKB62QO46XFU6GVBTFEYYETQJG3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDEyOjA2ICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyOC8wMi8yMDIwIMOgIDA3OjEyLCBBbmRyZXcgRG9ubmVsbGFuIGEgw6ljcml0
IDoNCj4gPiBPbiAyMS8yLzIwIDI6MjcgcG0sIEFsYXN0YWlyIEQnU2lsdmEgd3JvdGU6DQo+ID4g
PiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gPiA+IA0K
PiA+ID4gV2hlbiBoZWFsdGggJiBwZXJmb3JtYW5jZSBkYXRhIGlzIHJlcXVlc3RlZCBmcm9tIHRo
ZSBjb250cm9sbGVyLA0KPiA+ID4gaXQgcmVzcG9uZHMgd2l0aCBhbiBlcnJvciBsb2cgY29udGFp
bmluZyB0aGUgcmVxdWVzdGVkDQo+ID4gPiBpbmZvcm1hdGlvbi4NCj4gPiA+IA0KPiA+ID4gVGhp
cyBwYXRjaCBhbGxvd3MgdGhlIHJlcXVlc3QgdG8gbWUgaXNzdWVkIHZpYSBhbiBJT0NUTC4NCj4g
PiANCj4gPiBBIGJldHRlciBleHBsYW5hdGlvbiB3b3VsZCBiZSBnb29kIC0gdGhpcyBJT0NUTCB0
cmlnZ2VycyBhIHJlcXVlc3QNCj4gPiB0byANCj4gPiB0aGUgY29udHJvbGxlciB0byBjb2xsZWN0
IGNvbnRyb2xsZXIgaGVhbHRoL3BlcmYgZGF0YSwgYW5kIHRoZSANCj4gPiBjb250cm9sbGVyIHdp
bGwgbGF0ZXIgcmVzcG9uZCB3aXRoIGFuIGVycm9yIGxvZyB0aGF0IGNhbiBiZSBwaWNrZWQNCj4g
PiB1cCANCj4gPiB2aWEgdGhlIGVycm9yIGxvZyBJT0NUTCB0aGF0IHlvdSd2ZSBkZWZpbmVkIGVh
cmxpZXIuDQo+IA0KPiBBbmQgZXZlbiBtb3JlIHByZWNpc2VseSAodG8gYWxzbyBjaGVjayBteSB1
bmRlcnN0YW5kaW5nKToNCj4gDQo+ICA+IHRoaXMgSU9DVEwgdHJpZ2dlcnMgYSByZXF1ZXN0IHRv
DQo+ICA+IHRoZSBjb250cm9sbGVyIHRvIGNvbGxlY3QgY29udHJvbGxlciBoZWFsdGgvcGVyZiBk
YXRhLCBhbmQgdGhlDQo+ICA+IGNvbnRyb2xsZXIgd2lsbCBsYXRlciByZXNwb25kDQo+IA0KPiBi
eSByYWlzaW5nIGFuIGludGVycnVwdCB0byBsZXQgdGhlIHVzZXIgYXBwIGtub3cgdGhhdA0KPiAN
Cj4gID4gYW4gZXJyb3IgbG9nIHRoYXQgY2FuIGJlIHBpY2tlZCB1cA0KPiAgPiB2aWEgdGhlIGVy
cm9yIGxvZyBJT0NUTCB0aGF0IHlvdSd2ZSBkZWZpbmVkIGVhcmxpZXIuDQo+IA0KPiANCj4gVGhl
IHJlc3Qgb2YgdGhlIHBhdGNoIGxvb2tzIG9rIHRvIG1lLg0KPiANCj4gICAgRnJlZA0KDQpPaw0K
DQotLSANCkFsYXN0YWlyIEQnU2lsdmENCk9wZW4gU291cmNlIERldmVsb3Blcg0KTGludXggVGVj
aG5vbG9neSBDZW50cmUsIElCTSBBdXN0cmFsaWENCm1vYjogMDQyMyA3NjIgODE5DQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFp
bGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2Vu
ZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
