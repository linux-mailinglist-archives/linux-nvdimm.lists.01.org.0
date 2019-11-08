Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DDEF40FD
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Nov 2019 08:11:17 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 320F5100EA625;
	Thu,  7 Nov 2019 23:13:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 74351100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 23:13:33 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA878SH8193459
	for <linux-nvdimm@lists.01.org>; Fri, 8 Nov 2019 02:11:09 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2w41w7um2s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Fri, 08 Nov 2019 02:11:09 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Fri, 8 Nov 2019 07:11:06 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 8 Nov 2019 07:10:59 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA87Avda37749040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Nov 2019 07:10:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B77A404D;
	Fri,  8 Nov 2019 07:10:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F003AA4055;
	Fri,  8 Nov 2019 07:10:56 +0000 (GMT)
Received: from pic2.home (unknown [9.145.165.93])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  8 Nov 2019 07:10:56 +0000 (GMT)
Subject: Re: [PATCH 09/10] powerpc: Enable OpenCAPI Storage Class Memory
 driver on bare metal
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-10-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Fri, 8 Nov 2019 08:10:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-10-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110807-0016-0000-0000-000002C1D1E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110807-0017-0000-0000-0000332357B5
Message-Id: <3ba57ce6-9135-0d83-b99d-1c5b0c744855@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=914 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080070
Message-ID-Hash: LEUEOJQ53IS2AZ3LXFDFLS7PHJG6Q6BL
X-Message-ID-Hash: LEUEOJQ53IS2AZ3LXFDFLS7PHJG6Q6BL
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Oscar Salvador <osalvador@suse.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, David Hildenbrand <david@redhat.com>, Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Pavel Tatashin <pasha.tatashin@soleen.com>, linux-nvdimm@lists.01.org, Krzysztof Kozlowski <krzk@kernel.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kurz <groug@kaod.org>, Qian Cai <cai@lca.pw>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Hari Bathini <hbathini@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LEUEOJQ53IS2AZ3LXFDFLS7PHJG6Q6BL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBF
bmFibGUgT3BlbkNBUEkgU3RvcmFnZSBDbGFzcyBNZW1vcnkgZHJpdmVyIG9uIGJhcmUgbWV0YWwN
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEu
b3JnPg0KPiAtLS0NCj4gICBhcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZpZyB8
IDQgKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZpZyBiL2FyY2gvcG93
ZXJwYy9jb25maWdzL3Bvd2VybnZfZGVmY29uZmlnDQo+IGluZGV4IDY2NThjY2ViOTI4Yy4uNDVj
MGVmZjk0OTY0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2Rl
ZmNvbmZpZw0KPiArKysgYi9hcmNoL3Bvd2VycGMvY29uZmlncy9wb3dlcm52X2RlZmNvbmZpZw0K
PiBAQCAtMzUyLDMgKzM1Miw3IEBAIENPTkZJR19LVk1fQk9PSzNTXzY0PW0NCj4gICBDT05GSUdf
S1ZNX0JPT0szU182NF9IVj1tDQo+ICAgQ09ORklHX1ZIT1NUX05FVD1tDQo+ICAgQ09ORklHX1BS
SU5US19USU1FPXkNCj4gK0NPTkZJR19PQ1hMX1NDTT1tDQo+ICtDT05GSUdfREVWX0RBWD15DQo+
ICtDT05GSUdfREVWX0RBWF9QTUVNPXkNCj4gK0NPTkZJR19GU19EQVg9eQ0KDQoNCklmIHRoaXMg
cmVhbGx5IHRoZSBpbnRlbnQgb3IgZG8gd2Ugd2FudCB0byBhY3RpdmF0ZSBEQVggb25seSBpZiAN
CkNPTkZJR19PQ1hMX1NDTSBpcyBlbmFibGVkPw0KDQogICBGcmVkDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0
IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFp
bCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
