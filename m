Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 710B5F36A3
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 19:09:01 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 684AE100EA622;
	Thu,  7 Nov 2019 10:11:24 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 31B7F100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 10:11:21 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7I7MN0113564
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 13:08:55 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w4qxjgvxx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 13:08:55 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 18:08:52 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 18:08:43 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7I86IF10486184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 18:08:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F06D64C044;
	Thu,  7 Nov 2019 18:08:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFE874C04E;
	Thu,  7 Nov 2019 18:08:40 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 18:08:40 +0000 (GMT)
Subject: Re: [PATCH 10/10] ocxl: Conditionally bind SCM devices to the generic
 OCXL driver
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-11-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 19:08:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-11-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110718-0012-0000-0000-00000361A638
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110718-0013-0000-0000-0000219D084A
Message-Id: <b70644d6-2c71-cd71-5d00-e25d99beea91@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070167
Message-ID-Hash: B754RFV7A2VY2MJ53YA7RBVKECVDDRVH
X-Message-ID-Hash: B754RFV7A2VY2MJ53YA7RBVKECVDDRVH
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Allison Randal <allison@lohutok.net>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <
 mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B754RFV7A2VY2MJ53YA7RBVKECVDDRVH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGFsbG93cyB0aGUgdXNlciB0byBiaW5kIE9wZW5DQVBJIFNDTSBkZXZpY2VzIHRv
IHRoZSBnZW5lcmljIE9DWEwNCj4gZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxhc3Rh
aXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IC0tLQ0KDQoNCkknbSB3b25kZXJp
bmcgaWYgd2Ugc2hvdWxkIHVwc3RyZWFtIHRoaXMuIElzIGl0IG9mIGFueSB1c2Ugb3V0c2lkZSBv
ZiANCnNvbWUgc2VyaW91cyBkZWJ1ZyBzZXNzaW9uIGZvciBhIGRldmVsb3Blcj8NCkFsc28gd2Ug
d291bGQgbm93IGhhdmUgMiBkcml2ZXJzIHBpY2tpbmcgdXAgdGhlIHNhbWUgZGV2aWNlIElELCBz
aW5jZSANCnRoZSBTQ00gZHJpdmVyIGlzIGFsd2F5cyByZWdpc3RlcmluZyBmb3IgdGhhdCBJRCwg
aXJyZXNwZWN0aXZlIG9mIA0KQ09ORklHX09DWExfU0NNX0dFTkVSSUMNCg0KICAgRnJlZA0KDQoN
Cj4gICBkcml2ZXJzL21pc2Mvb2N4bC9LY29uZmlnIHwgNyArKysrKysrDQo+ICAgZHJpdmVycy9t
aXNjL29jeGwvcGNpLmMgICB8IDMgKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvS2NvbmZpZyBiL2Ry
aXZlcnMvbWlzYy9vY3hsL0tjb25maWcNCj4gaW5kZXggMTkxNmZhNjVmMmYyLi44YTY4MzcxNWM5
N2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL0tjb25maWcNCj4gKysrIGIvZHJp
dmVycy9taXNjL29jeGwvS2NvbmZpZw0KPiBAQCAtMjksMyArMjksMTAgQEAgY29uZmlnIE9DWEwN
Cj4gICAJICBkZWRpY2F0ZWQgT3BlbkNBUEkgbGluaywgYW5kIGRvbid0IGZvbGxvdyB0aGUgc2Ft
ZSBwcm90b2NvbC4NCj4gICANCj4gICAJICBJZiB1bnN1cmUsIHNheSBOLg0KPiArDQo+ICtjb25m
aWcgT0NYTF9TQ01fR0VORVJJQw0KPiArCWJvb2wgIlRyZWF0IE9wZW5DQVBJIFN0b3JhZ2UgQ2xh
c3MgTWVtb3J5IGFzIGEgZ2VuZXJpYyBPcGVuQ0FQSSBkZXZpY2UiDQo+ICsJZGVmYXVsdCBuDQo+
ICsJaGVscA0KPiArCSAgU2VsZWN0IHRoaXMgb3B0aW9uIHRvIHRyZWF0IE9wZW5DQVBJIFN0b3Jh
Z2UgQ2xhc3MgTWVtb3J5DQo+ICsJICBkZXZpY2VzIGFuIGdlbmVyaWMgT3BlbkNBUEkgZGV2aWNl
cy4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL3BjaS5jIGIvZHJpdmVycy9taXNj
L29jeGwvcGNpLmMNCj4gaW5kZXggY2I5MjBhYTg4ZDNhLi43MTM3MDU1YzE4ODMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hs
L3BjaS5jDQo+IEBAIC0xMCw2ICsxMCw5IEBADQo+ICAgICovDQo+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBwY2lfZGV2aWNlX2lkIG9jeGxfcGNpX3RibFtdID0gew0KPiAgIAl7IFBDSV9ERVZJQ0Uo
UENJX1ZFTkRPUl9JRF9JQk0sIDB4MDYyQiksIH0sDQo+ICsjaWZkZWYgQ09ORklHX09DWExfU0NN
X0dFTkVSSUMNCj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JQk0sIDB4MDYyNSksIH0s
DQo+ICsjZW5kaWYNCj4gICAJeyB9DQo+ICAgfTsNCj4gICBNT0RVTEVfREVWSUNFX1RBQkxFKHBj
aSwgb2N4bF9wY2lfdGJsKTsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
