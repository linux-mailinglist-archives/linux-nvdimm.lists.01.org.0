Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B4F3662
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 18:57:15 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ED4E5100EA622;
	Thu,  7 Nov 2019 09:59:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 62DC2100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 09:59:37 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7HlP6v047617
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 12:57:08 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w4qxjge97-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 12:57:07 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 17:57:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 17:56:57 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7Huun262324934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 17:56:56 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 228554C044;
	Thu,  7 Nov 2019 17:56:56 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 097A24C046;
	Thu,  7 Nov 2019 17:56:55 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 17:56:54 +0000 (GMT)
Subject: Re: [PATCH 02/10] nvdimm: remove prototypes for nonexistent functions
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-3-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 18:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-3-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110717-0008-0000-0000-0000032C7E84
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110717-0009-0000-0000-00004A4B84B8
Message-Id: <5da350ac-42a2-6614-7f1c-e8b4b17d3906@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070165
Message-ID-Hash: YI4PDGZMCZQTXNY4WXVCRBQ4RGL2OZCF
X-Message-ID-Hash: YI4PDGZMCZQTXNY4WXVCRBQ4RGL2OZCF
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anton Blanchard <anton@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, linux-
 kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YI4PDGZMCZQTXNY4WXVCRBQ4RGL2OZCF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGVzZSBmdW5jdGlvbnMgZG9uJ3QgZXhpc3QsIHNvIHJlbW92ZSB0aGUgcHJvdG90eXBlcyBmb3Ig
dGhlbS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQt
c2lsdmEub3JnPg0KPiAtLS0NCg0KDQpSZXZpZXdlZC1ieTogRnJlZGVyaWMgQmFycmF0IDxmYmFy
cmF0QGxpbnV4LmlibS5jb20+DQoNCg0KPiAgIGRyaXZlcnMvbnZkaW1tL25kLWNvcmUuaCB8IDQg
LS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZkaW1tL25kLWNvcmUuaCBiL2RyaXZlcnMvbnZkaW1tL25kLWNvcmUuaA0K
PiBpbmRleCAyNWZhMTIxMTA0ZDAuLjlmMTIxYTZhZWIwMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9udmRpbW0vbmQtY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL25kLWNvcmUuaA0KPiBA
QCAtMTI0LDExICsxMjQsNyBAQCB2b2lkIG5kX3JlZ2lvbl9jcmVhdGVfZGF4X3NlZWQoc3RydWN0
IG5kX3JlZ2lvbiAqbmRfcmVnaW9uKTsNCj4gICBpbnQgbnZkaW1tX2J1c19jcmVhdGVfbmRjdGwo
c3RydWN0IG52ZGltbV9idXMgKm52ZGltbV9idXMpOw0KPiAgIHZvaWQgbnZkaW1tX2J1c19kZXN0
cm95X25kY3RsKHN0cnVjdCBudmRpbW1fYnVzICpudmRpbW1fYnVzKTsNCj4gICB2b2lkIG5kX3N5
bmNocm9uaXplKHZvaWQpOw0KPiAtaW50IG52ZGltbV9idXNfcmVnaXN0ZXJfZGltbXMoc3RydWN0
IG52ZGltbV9idXMgKm52ZGltbV9idXMpOw0KPiAtaW50IG52ZGltbV9idXNfcmVnaXN0ZXJfcmVn
aW9ucyhzdHJ1Y3QgbnZkaW1tX2J1cyAqbnZkaW1tX2J1cyk7DQo+IC1pbnQgbnZkaW1tX2J1c19p
bml0X2ludGVybGVhdmVfc2V0cyhzdHJ1Y3QgbnZkaW1tX2J1cyAqbnZkaW1tX2J1cyk7DQo+ICAg
dm9pZCBfX25kX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAtaW50IG5k
X21hdGNoX2RpbW0oc3RydWN0IGRldmljZSAqZGV2LCB2b2lkICpkYXRhKTsNCj4gICBzdHJ1Y3Qg
bmRfbGFiZWxfaWQ7DQo+ICAgY2hhciAqbmRfbGFiZWxfZ2VuX2lkKHN0cnVjdCBuZF9sYWJlbF9p
ZCAqbGFiZWxfaWQsIHU4ICp1dWlkLCB1MzIgZmxhZ3MpOw0KPiAgIGJvb2wgbmRfaXNfdXVpZF91
bmlxdWUoc3RydWN0IGRldmljZSAqZGV2LCB1OCAqdXVpZCk7DQo+IA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
