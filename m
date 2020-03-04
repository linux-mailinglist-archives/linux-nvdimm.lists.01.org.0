Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC68A1789B1
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 05:43:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8126710FC3628;
	Tue,  3 Mar 2020 20:44:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=alastair@au1.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10C4F10FC3162
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 20:43:58 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0244YV4q093650
	for <linux-nvdimm@lists.01.org>; Tue, 3 Mar 2020 23:43:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yhsv3789a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 03 Mar 2020 23:43:06 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <alastair@au1.ibm.com>;
	Wed, 4 Mar 2020 04:43:03 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 4 Mar 2020 04:42:56 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0244gtTI44564560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2020 04:42:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56622AE053;
	Wed,  4 Mar 2020 04:42:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F85AE051;
	Wed,  4 Mar 2020 04:42:55 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2020 04:42:54 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id CFCCAA023A;
	Wed,  4 Mar 2020 15:42:49 +1100 (AEDT)
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat
	 <fbarrat@linux.ibm.com>
Date: Wed, 04 Mar 2020 15:42:53 +1100
In-Reply-To: <CAPcyv4gCCjQFnLaSpRPEuKoDq3gOHSxjxLT_=X3N_nr=2ZOcSA@mail.gmail.com>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	 <20200221032720.33893-16-alastair@au1.ibm.com>
	 <9e40ad40-6fa8-0fd2-a53a-8a3029a3639c@linux.ibm.com>
	 <CAPcyv4gCCjQFnLaSpRPEuKoDq3gOHSxjxLT_=X3N_nr=2ZOcSA@mail.gmail.com>
Organization: IBM Australia
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20030404-0012-0000-0000-0000038CF56C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030404-0013-0000-0000-000021C9AE38
Message-Id: <86c3523e9cb2c0a53fdcffca95117e84df452937.camel@au1.ibm.com>
Subject: RE: [PATCH v3 15/27] powerpc/powernv/pmem: Add support for near storage
 commands
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_08:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=977 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003040032
Message-ID-Hash: DG3RD3CWTGUQB5HSUR3ZVOA4C7OI5WPB
X-Message-ID-Hash: DG3RD3CWTGUQB5HSUR3ZVOA4C7OI5WPB
X-MailFrom: alastair@au1.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Linux Kernel Mailing List <linux-kernel
 @vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DG3RD3CWTGUQB5HSUR3ZVOA4C7OI5WPB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDIwLTAzLTAyIGF0IDEwOjQyIC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IE9uIE1vbiwgTWFyIDIsIDIwMjAgYXQgOTo1OSBBTSBGcmVkZXJpYyBCYXJyYXQgPGZiYXJyYXRA
bGludXguaWJtLmNvbQ0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IExlIDIxLzAyLzIwMjAg
w6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXQgOg0KPiA+ID4gRnJvbTogQWxhc3Rh
aXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gPiANCj4gPiA+IFNpbWlsYXIg
dG8gdGhlIHByZXZpb3VzIHBhdGNoLCB0aGlzIGFkZHMgc3VwcG9ydCBmb3IgbmVhciBzdG9yYWdl
DQo+ID4gPiBjb21tYW5kcy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3RhaXIg
RCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gPiAtLS0NCj4gPiANCj4gPiBJcyBh
bnkgb2YgdGhlc2UgbmV3IGZ1bmN0aW9ucyBldmVyIGNhbGxlZD8NCj4gDQo+IFRoaXMgaXMgbXkg
Y29uY2VybiBhcyB3ZWxsLiBUaGUgbGlibnZkaW1tIGNvbW1hbmQgc3VwcG9ydCBpcyBsaW1pdGVk
DQo+IHRvIHRoZSBjb21tYW5kcyB0aGF0IExpbnV4IHdpbGwgdXNlLiBPdGhlciBwYXNzdGhyb3Vn
aCBjb21tYW5kcyBhcmUNCj4gc3VwcG9ydGVkIHRocm91Z2ggYSBwYXNzdGhyb3VnaCBpbnRlcmZh
Y2UuIEhvd2V2ZXIsIHRoYXQgcGFzc3Rocm91Z2gNCj4gaW50ZXJmYWNlIGlzIGV4cGxpY2l0bHkg
bGltaXRlZCB0byBwdWJsaWNseSBkb2N1bWVudGVkIGNvbW1hbmQgc2V0cw0KPiBzbw0KPiB0aGF0
IHRoZSBrZXJuZWwgaGFzIGFuIG9wcG9ydHVuaXR5IHRvIGNvbnN0cmFpbiBhbmQgY29uc29saWRh
dGUNCj4gY29tbWFuZCBpbXBsZW1lbnRhdGlvbnMgYWNyb3NzIHZlbmRvcnMuDQoNCg0KSXQgd2ls
bCBiZSBpbiB0aGUgcGF0Y2ggdGhhdCBpbXBsZW1lbnRzIG92ZXJ3cml0ZS4gSSBtb3ZlZCB0aGF0
IHBhdGNoDQpvdXQgb2YgdGhpcyBzZXJpZXMsIGFzIGl0IG5lZWRzIG1vcmUgdGVzdGluZywgc28g
SSBndWVzcyBJIGNhbiBzdWJtaXQNCnRoaXMgYWxvbmdzaWRlIGl0Lg0KDQotLSANCkFsYXN0YWly
IEQnU2lsdmENCk9wZW4gU291cmNlIERldmVsb3Blcg0KTGludXggVGVjaG5vbG9neSBDZW50cmUs
IElCTSBBdXN0cmFsaWENCm1vYjogMDQyMyA3NjIgODE5DQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
