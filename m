Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B02178F42
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 12:07:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC62110FC3639;
	Wed,  4 Mar 2020 03:07:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A718310FC3162
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 03:07:49 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 024B6pqr001192
	for <linux-nvdimm@lists.01.org>; Wed, 4 Mar 2020 06:06:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yfknbu7k8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Wed, 04 Mar 2020 06:06:54 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Wed, 4 Mar 2020 11:06:41 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 4 Mar 2020 11:06:35 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 024B5ZcQ41484714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2020 11:05:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9325AE058;
	Wed,  4 Mar 2020 11:06:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7F8AAE056;
	Wed,  4 Mar 2020 11:06:32 +0000 (GMT)
Received: from pic2.home (unknown [9.145.145.27])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2020 11:06:32 +0000 (GMT)
Subject: Re: [PATCH v3 21/27] powerpc/powernv/pmem: Add an IOCTL to request
 controller health & perf data
To: Andrew Donnellan <ajd@linux.ibm.com>,
        "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-22-alastair@au1.ibm.com>
 <fdc5faec-d03d-3cba-4a9c-add7e522ad13@linux.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Wed, 4 Mar 2020 12:06:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fdc5faec-d03d-3cba-4a9c-add7e522ad13@linux.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030411-0008-0000-0000-0000035938C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030411-0009-0000-0000-00004A7A6B55
Message-Id: <3ecb49e3-8828-ab7b-4391-5dd6127e76e0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_01:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=688 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040086
Message-ID-Hash: OIGG7GQQMYXDY6KEJUMLLW44ST76NLAU
X-Message-ID-Hash: OIGG7GQQMYXDY6KEJUMLLW44ST76NLAU
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists
 .01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OIGG7GQQMYXDY6KEJUMLLW44ST76NLAU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI4LzAyLzIwMjAgw6AgMDc6MTIsIEFuZHJldyBEb25uZWxsYW4gYSDDqWNyaXTCoDoN
Cj4gT24gMjEvMi8yMCAyOjI3IHBtLCBBbGFzdGFpciBEJ1NpbHZhIHdyb3RlOg0KPj4gRnJvbTog
QWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+Pg0KPj4gV2hlbiBoZWFs
dGggJiBwZXJmb3JtYW5jZSBkYXRhIGlzIHJlcXVlc3RlZCBmcm9tIHRoZSBjb250cm9sbGVyLA0K
Pj4gaXQgcmVzcG9uZHMgd2l0aCBhbiBlcnJvciBsb2cgY29udGFpbmluZyB0aGUgcmVxdWVzdGVk
IGluZm9ybWF0aW9uLg0KPj4NCj4+IFRoaXMgcGF0Y2ggYWxsb3dzIHRoZSByZXF1ZXN0IHRvIG1l
IGlzc3VlZCB2aWEgYW4gSU9DVEwuDQo+IA0KPiBBIGJldHRlciBleHBsYW5hdGlvbiB3b3VsZCBi
ZSBnb29kIC0gdGhpcyBJT0NUTCB0cmlnZ2VycyBhIHJlcXVlc3QgdG8gDQo+IHRoZSBjb250cm9s
bGVyIHRvIGNvbGxlY3QgY29udHJvbGxlciBoZWFsdGgvcGVyZiBkYXRhLCBhbmQgdGhlIA0KPiBj
b250cm9sbGVyIHdpbGwgbGF0ZXIgcmVzcG9uZCB3aXRoIGFuIGVycm9yIGxvZyB0aGF0IGNhbiBi
ZSBwaWNrZWQgdXAgDQo+IHZpYSB0aGUgZXJyb3IgbG9nIElPQ1RMIHRoYXQgeW91J3ZlIGRlZmlu
ZWQgZWFybGllci4NCg0KQW5kIGV2ZW4gbW9yZSBwcmVjaXNlbHkgKHRvIGFsc28gY2hlY2sgbXkg
dW5kZXJzdGFuZGluZyk6DQoNCiA+IHRoaXMgSU9DVEwgdHJpZ2dlcnMgYSByZXF1ZXN0IHRvDQog
PiB0aGUgY29udHJvbGxlciB0byBjb2xsZWN0IGNvbnRyb2xsZXIgaGVhbHRoL3BlcmYgZGF0YSwg
YW5kIHRoZQ0KID4gY29udHJvbGxlciB3aWxsIGxhdGVyIHJlc3BvbmQNCg0KYnkgcmFpc2luZyBh
biBpbnRlcnJ1cHQgdG8gbGV0IHRoZSB1c2VyIGFwcCBrbm93IHRoYXQNCg0KID4gYW4gZXJyb3Ig
bG9nIHRoYXQgY2FuIGJlIHBpY2tlZCB1cA0KID4gdmlhIHRoZSBlcnJvciBsb2cgSU9DVEwgdGhh
dCB5b3UndmUgZGVmaW5lZCBlYXJsaWVyLg0KDQoNClRoZSByZXN0IG9mIHRoZSBwYXRjaCBsb29r
cyBvayB0byBtZS4NCg0KICAgRnJlZA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
