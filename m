Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1881114E80A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 05:57:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0770A1003E991;
	Thu, 30 Jan 2020 21:01:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DAD2100780BF
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 21:01:07 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00V4t505120680
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 23:57:48 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2xv09xgj2w-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 23:57:48 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Fri, 31 Jan 2020 04:57:46 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 31 Jan 2020 04:57:39 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00V4vcsS46661796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2020 04:57:38 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 139B7A4051;
	Fri, 31 Jan 2020 04:57:38 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C1BA404D;
	Fri, 31 Jan 2020 04:57:37 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2020 04:57:37 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B2E26A0388;
	Fri, 31 Jan 2020 15:57:33 +1100 (AEDT)
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 31 Jan 2020 15:56:58 +1100
In-Reply-To: <3ba57ce6-9135-0d83-b99d-1c5b0c744855@linux.ibm.com>
References: <20191025044721.16617-1-alastair@au1.ibm.com>
	 <20191025044721.16617-10-alastair@au1.ibm.com>
	 <3ba57ce6-9135-0d83-b99d-1c5b0c744855@linux.ibm.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20013104-4275-0000-0000-0000039CA981
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013104-4276-0000-0000-000038B0C919
Message-Id: <df24e47c2bd9472c7be06c6c266b2a250c30068f.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_09:2020-01-30,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=922 mlxscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310042
Message-ID-Hash: ZSVR54GWPWESE4B7V3BBLPNPUMHSPMWB
X-Message-ID-Hash: ZSVR54GWPWESE4B7V3BBLPNPUMHSPMWB
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Oscar Salvador <osalvador@suse.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Qian Cai <cai@lca.pw>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZSVR54GWPWESE4B7V3BBLPNPUMHSPMWB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDE5LTExLTA4IGF0IDA4OjEwICswMTAwLCBGcmVkZXJpYyBCYXJyYXQgd3JvdGU6
DQo+IA0KPiBMZSAyNS8xMC8yMDE5IMOgIDA2OjQ3LCBBbGFzdGFpciBEJ1NpbHZhIGEgw6ljcml0
IDoNCj4gPiBGcm9tOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4g
PiANCj4gPiBFbmFibGUgT3BlbkNBUEkgU3RvcmFnZSBDbGFzcyBNZW1vcnkgZHJpdmVyIG9uIGJh
cmUgbWV0YWwNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFz
dGFpckBkLXNpbHZhLm9yZz4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvcG93ZXJwYy9jb25maWdzL3Bv
d2VybnZfZGVmY29uZmlnIHwgNCArKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9jb25maWdzL3Bvd2Vy
bnZfZGVmY29uZmlnDQo+ID4gYi9hcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZp
Zw0KPiA+IGluZGV4IDY2NThjY2ViOTI4Yy4uNDVjMGVmZjk0OTY0IDEwMDY0NA0KPiA+IC0tLSBh
L2FyY2gvcG93ZXJwYy9jb25maWdzL3Bvd2VybnZfZGVmY29uZmlnDQo+ID4gKysrIGIvYXJjaC9w
b3dlcnBjL2NvbmZpZ3MvcG93ZXJudl9kZWZjb25maWcNCj4gPiBAQCAtMzUyLDMgKzM1Miw3IEBA
IENPTkZJR19LVk1fQk9PSzNTXzY0PW0NCj4gPiAgIENPTkZJR19LVk1fQk9PSzNTXzY0X0hWPW0N
Cj4gPiAgIENPTkZJR19WSE9TVF9ORVQ9bQ0KPiA+ICAgQ09ORklHX1BSSU5US19USU1FPXkNCj4g
PiArQ09ORklHX09DWExfU0NNPW0NCj4gPiArQ09ORklHX0RFVl9EQVg9eQ0KPiA+ICtDT05GSUdf
REVWX0RBWF9QTUVNPXkNCj4gPiArQ09ORklHX0ZTX0RBWD15DQo+IA0KPiBJZiB0aGlzIHJlYWxs
eSB0aGUgaW50ZW50IG9yIGRvIHdlIHdhbnQgdG8gYWN0aXZhdGUgREFYIG9ubHkgaWYgDQo+IENP
TkZJR19PQ1hMX1NDTSBpcyBlbmFibGVkPw0KPiANCj4gICAgRnJlZA0KDQpXZSBoYWQgYSBiaXQg
b2YgYSBwbGF5IGFyb3VuZCB3aXRoIHJld29ya2luZyB0aGlzIHRoZSBvdGhlciBkYXkuDQoNClB1
dHRpbmcgdGhlbSBpbiBhcyBkZXBlbmRzIGRpZG4ndCBtYWtlIHNlbnNlLCBhcyB0aGV5IGFyZSAi
c29mdCINCmRlcGVuZGFuY2llcyAtIHRoZSBkcml2ZXIgd29ya3MgYW5kIHlvdSBjYW4gZG8gc29t
ZSB0aGluZ3Mgd2l0aG91dCBEQVguDQoNCkFkZGluZyB0aGVtIGFzIHNlbGVjdHMgd2FzIHJlamVj
dGVkIGFzIHNlbGVjdGluZyBzeW1ib2xzIHRoYXQgY2FuIGFsc28NCmJlIG1hbnVhbGx5IHNlbGVj
dCBpcyBkaXNjb3VyYWdlZC4NCg0KV2UgZW5kZWQgdXAgZ29pbmcgZnVsbCBjaXJjbGUgYW5kIGFk
ZGluZyB0aGVtIGJhY2sgdG8gdGhlIGRlZmNvbmZpZy4NCg0KLS0gDQpBbGFzdGFpciBEJ1NpbHZh
DQpPcGVuIFNvdXJjZSBEZXZlbG9wZXINCkxpbnV4IFRlY2hub2xvZ3kgQ2VudHJlLCBJQk0gQXVz
dHJhbGlhDQptb2I6IDA0MjMgNzYyIDgxOQ0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
