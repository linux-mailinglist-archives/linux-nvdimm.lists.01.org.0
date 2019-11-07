Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF96F3664
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 18:57:36 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 26FB0100EA626;
	Thu,  7 Nov 2019 10:00:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 60A65100EA622
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 09:59:57 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7HlVhQ096549
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 12:57:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w4qbft5pc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 12:57:30 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 17:57:27 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 17:57:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7HvHmQ262624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 17:57:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD5DD4C04E;
	Thu,  7 Nov 2019 17:57:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D734C044;
	Thu,  7 Nov 2019 17:57:16 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 17:57:16 +0000 (GMT)
Subject: Re: [PATCH 03/10] powerpc: Add OPAL calls for LPC memory
 alloc/release
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-4-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 18:57:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-4-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110717-0020-0000-0000-000003837F8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110717-0021-0000-0000-000021D9B527
Message-Id: <150de4f8-a257-4b4b-8495-73f3aa6954c0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070165
Message-ID-Hash: MDIM3EJ6LYDGM5L2DKQNLREUBTUD6S6S
X-Message-ID-Hash: MDIM3EJ6LYDGM5L2DKQNLREUBTUD6S6S
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Donnellan <ajd@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Blanchard <anton@ozlabs.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Allison Randal <allison@lohutok.net>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@
 soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDIM3EJ6LYDGM5L2DKQNLREUBTUD6S6S/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBB
ZGQgT1BBTCBjYWxscyBmb3IgTFBDIG1lbW9yeSBhbGxvYy9yZWxlYXNlDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gQWNrZWQt
Ynk6IEFuZHJldyBEb25uZWxsYW4gPGFqZEBsaW51eC5pYm0uY29tPg0KPiAtLS0NCg0KDQpBY2tl
ZC1ieTogRnJlZGVyaWMgQmFycmF0IDxmYmFycmF0QGxpbnV4LmlibS5jb20+DQoNCg0KDQo+ICAg
YXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL29wYWwtYXBpLmggICAgICAgIHwgMiArKw0KPiAgIGFy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLmggICAgICAgICAgICB8IDMgKysrDQo+ICAgYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwtY2FsbC5jIHwgMiArKw0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL29wYWwtYXBpLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vb3Bh
bC1hcGkuaA0KPiBpbmRleCAzNzhlMzk5Nzg0NWEuLjJjODhjMDJlNjllZCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL29wYWwtYXBpLmgNCj4gKysrIGIvYXJjaC9wb3dl
cnBjL2luY2x1ZGUvYXNtL29wYWwtYXBpLmgNCj4gQEAgLTIwOCw2ICsyMDgsOCBAQA0KPiAgICNk
ZWZpbmUgT1BBTF9IQU5ETEVfSE1JMgkJCTE2Ng0KPiAgICNkZWZpbmUJT1BBTF9OWF9DT1BST0Nf
SU5JVAkJCTE2Nw0KPiAgICNkZWZpbmUgT1BBTF9YSVZFX0dFVF9WUF9TVEFURQkJCTE3MA0KPiAr
I2RlZmluZSBPUEFMX05QVV9NRU1fQUxMT0MJCQkxNzENCj4gKyNkZWZpbmUgT1BBTF9OUFVfTUVN
X1JFTEVBU0UJCQkxNzINCj4gICAjZGVmaW5lIE9QQUxfTVBJUExfVVBEQVRFCQkJMTczDQo+ICAg
I2RlZmluZSBPUEFMX01QSVBMX1JFR0lTVEVSX1RBRwkJCTE3NA0KPiAgICNkZWZpbmUgT1BBTF9N
UElQTF9RVUVSWV9UQUcJCQkxNzUNCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRl
L2FzbS9vcGFsLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vb3BhbC5oDQo+IGluZGV4IGEw
Y2Y4ZmJhNGQxMi4uNGRiMTM1ZmI1NGFiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5j
bHVkZS9hc20vb3BhbC5oDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLmgN
Cj4gQEAgLTM5LDYgKzM5LDkgQEAgaW50NjRfdCBvcGFsX25wdV9zcGFfY2xlYXJfY2FjaGUodWlu
dDY0X3QgcGhiX2lkLCB1aW50MzJfdCBiZGZuLA0KPiAgIAkJCQl1aW50NjRfdCBQRV9oYW5kbGUp
Ow0KPiAgIGludDY0X3Qgb3BhbF9ucHVfdGxfc2V0KHVpbnQ2NF90IHBoYl9pZCwgdWludDMyX3Qg
YmRmbiwgbG9uZyBjYXAsDQo+ICAgCQkJdWludDY0X3QgcmF0ZV9waHlzLCB1aW50MzJfdCBzaXpl
KTsNCj4gK2ludDY0X3Qgb3BhbF9ucHVfbWVtX2FsbG9jKHVpbnQ2NF90IHBoYl9pZCwgdWludDMy
X3QgYmRmbiwNCj4gKwkJCXVpbnQ2NF90IHNpemUsIHVpbnQ2NF90ICpiYXIpOw0KPiAraW50NjRf
dCBvcGFsX25wdV9tZW1fcmVsZWFzZSh1aW50NjRfdCBwaGJfaWQsIHVpbnQzMl90IGJkZm4pOw0K
PiAgIA0KPiAgIGludDY0X3Qgb3BhbF9jb25zb2xlX3dyaXRlKGludDY0X3QgdGVybV9udW1iZXIs
IF9fYmU2NCAqbGVuZ3RoLA0KPiAgIAkJCSAgIGNvbnN0IHVpbnQ4X3QgKmJ1ZmZlcik7DQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1jYWxsLmMgYi9h
cmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1jYWxsLmMNCj4gaW5kZXggYTJhYTVl
NDMzYWM4Li4yN2M0YjkzYzc3NGMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9y
bXMvcG93ZXJudi9vcGFsLWNhbGwuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bv
d2VybnYvb3BhbC1jYWxsLmMNCj4gQEAgLTI4Nyw2ICsyODcsOCBAQCBPUEFMX0NBTEwob3BhbF9w
Y2lfc2V0X3BiY3FfdHVubmVsX2JhciwJCU9QQUxfUENJX1NFVF9QQkNRX1RVTk5FTF9CQVIpOw0K
PiAgIE9QQUxfQ0FMTChvcGFsX3NlbnNvcl9yZWFkX3U2NCwJCQlPUEFMX1NFTlNPUl9SRUFEX1U2
NCk7DQo+ICAgT1BBTF9DQUxMKG9wYWxfc2Vuc29yX2dyb3VwX2VuYWJsZSwJCU9QQUxfU0VOU09S
X0dST1VQX0VOQUJMRSk7DQo+ICAgT1BBTF9DQUxMKG9wYWxfbnhfY29wcm9jX2luaXQsCQkJT1BB
TF9OWF9DT1BST0NfSU5JVCk7DQo+ICtPUEFMX0NBTEwob3BhbF9ucHVfbWVtX2FsbG9jLAkJCU9Q
QUxfTlBVX01FTV9BTExPQyk7DQo+ICtPUEFMX0NBTEwob3BhbF9ucHVfbWVtX3JlbGVhc2UsCQkJ
T1BBTF9OUFVfTUVNX1JFTEVBU0UpOw0KPiAgIE9QQUxfQ0FMTChvcGFsX21waXBsX3VwZGF0ZSwJ
CQlPUEFMX01QSVBMX1VQREFURSk7DQo+ICAgT1BBTF9DQUxMKG9wYWxfbXBpcGxfcmVnaXN0ZXJf
dGFnLAkJT1BBTF9NUElQTF9SRUdJU1RFUl9UQUcpOw0KPiAgIE9QQUxfQ0FMTChvcGFsX21waXBs
X3F1ZXJ5X3RhZywJCQlPUEFMX01QSVBMX1FVRVJZX1RBRyk7DQo+IA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
