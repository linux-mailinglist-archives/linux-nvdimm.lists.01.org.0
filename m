Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A9177E3D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Mar 2020 19:05:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2FC9A10FC3597;
	Tue,  3 Mar 2020 10:06:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2D3A10FC3415
	for <linux-nvdimm@lists.01.org>; Tue,  3 Mar 2020 10:05:58 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023I4o6J008296
	for <linux-nvdimm@lists.01.org>; Tue, 3 Mar 2020 13:05:06 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yh0dveyhp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 03 Mar 2020 13:05:05 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 3 Mar 2020 18:05:03 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 3 Mar 2020 18:04:56 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 023I3uiT39518482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2020 18:03:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8070442042;
	Tue,  3 Mar 2020 18:04:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5262D42041;
	Tue,  3 Mar 2020 18:04:53 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2020 18:04:53 +0000 (GMT)
Subject: Re: [PATCH v3 18/27] powerpc/powernv/pmem: Add controller dump IOCTLs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-19-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 3 Mar 2020 19:04:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-19-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030318-0020-0000-0000-000003B02A77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030318-0021-0000-0000-000022085B20
Message-Id: <6d1f28bc-334c-e85b-9974-71cf88a1ad20@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_06:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=39 malwarescore=0
 priorityscore=1501 mlxlogscore=20 lowpriorityscore=0 mlxscore=39
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=39 impostorscore=0
 adultscore=0 suspectscore=2 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2003030122
Message-ID-Hash: NDEZYS2EXREHWHN37KR5JEJVQYFO3JY4
X-Message-ID-Hash: NDEZYS2EXREHWHN37KR5JEJVQYFO3JY4
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NDEZYS2EXREHWHN37KR5JEJVQYFO3JY4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIGFkZHMgSU9DVExzIHRvIGFsbG93IHVzZXJzcGFjZSB0byByZXF1ZXN0ICYgZmV0
Y2ggZHVtcHMNCj4gb2YgdGhlIGludGVybmFsIGNvbnRyb2xsZXIgc3RhdGUuDQo+IA0KPiBUaGlz
IGlzIHVzZWZ1bCBkdXJpbmcgZGVidWdnaW5nIG9yIHdoZW4gYSBmYXRhbCBlcnJvciBvbiB0aGUg
Y29udHJvbGxlcg0KPiBoYXMgb2NjdXJyZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFp
ciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBj
L3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jIHwgMTMyICsrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIGluY2x1ZGUvdWFwaS9udmRpbW0vb2N4bC1wbWVtLmggICAgICAgICAgICB8ICAxNSAr
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE0NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jIGIvYXJjaC9w
b3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L3BtZW0vb2N4bC5jDQo+IGluZGV4IDJiNjQ1MDRmOTEy
OS4uMmNhYmFmZTFmYzU4IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bv
d2VybnYvcG1lbS9vY3hsLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52
L3BtZW0vb2N4bC5jDQo+IEBAIC02NDAsNiArNjQwLDEyNCBAQCBzdGF0aWMgaW50IGlvY3RsX2Vy
cm9yX2xvZyhzdHJ1Y3Qgb2N4bHBtZW0gKm9jeGxwbWVtLA0KPiAgIAlyZXR1cm4gMDsNCj4gICB9
DQo+ICAgDQo+ICtzdGF0aWMgaW50IGlvY3RsX2NvbnRyb2xsZXJfZHVtcF9kYXRhKHN0cnVjdCBv
Y3hscG1lbSAqb2N4bHBtZW0sDQo+ICsJCXN0cnVjdCBpb2N0bF9vY3hsX3BtZW1fY29udHJvbGxl
cl9kdW1wX2RhdGEgX191c2VyICp1YXJnKQ0KPiArew0KPiArCXN0cnVjdCBpb2N0bF9vY3hsX3Bt
ZW1fY29udHJvbGxlcl9kdW1wX2RhdGEgYXJnczsNCj4gKwl1MTYgaTsNCj4gKwl1NjQgdmFsOw0K
PiArCWludCByYzsNCj4gKw0KPiArCWlmIChjb3B5X2Zyb21fdXNlcigmYXJncywgdWFyZywgc2l6
ZW9mKGFyZ3MpKSkNCj4gKwkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsNCj4gKwlpZiAoYXJncy5idWZf
c2l6ZSAlIDgpDQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJaWYgKGFyZ3MuYnVmX3Np
emUgPiBvY3hscG1lbS0+YWRtaW5fY29tbWFuZC5kYXRhX3NpemUpDQo+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmb2N4bHBtZW0tPmFkbWluX2NvbW1hbmQubG9jayk7
DQo+ICsNCj4gKwlyYyA9IGFkbWluX2NvbW1hbmRfcmVxdWVzdChvY3hscG1lbSwgQURNSU5fQ09N
TUFORF9DT05UUk9MTEVSX0RVTVApOw0KPiArCWlmIChyYykNCj4gKwkJZ290byBvdXQ7DQo+ICsN
Cj4gKwl2YWwgPSAoKHU2NClhcmdzLm9mZnNldCkgPDwgMzI7DQo+ICsJdmFsIHw9IGFyZ3MuYnVm
X3NpemU7DQo+ICsJcmMgPSBvY3hsX2dsb2JhbF9tbWlvX3dyaXRlNjQob2N4bHBtZW0tPm9jeGxf
YWZ1LA0KPiArCQkJCSAgICAgIG9jeGxwbWVtLT5hZG1pbl9jb21tYW5kLnJlcXVlc3Rfb2Zmc2V0
ICsgMHgwOCwNCj4gKwkJCQkgICAgICBPQ1hMX0xJVFRMRV9FTkRJQU4sIHZhbCk7DQo+ICsJaWYg
KHJjKQ0KPiArCQlnb3RvIG91dDsNCj4gKw0KPiArCXJjID0gYWRtaW5fY29tbWFuZF9leGVjdXRl
KG9jeGxwbWVtKTsNCj4gKwlpZiAocmMpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICsJcmMgPSBh
ZG1pbl9jb21tYW5kX2NvbXBsZXRlX3RpbWVvdXQob2N4bHBtZW0sDQo+ICsJCQkJCSAgICBBRE1J
Tl9DT01NQU5EX0NPTlRST0xMRVJfRFVNUCk7DQo+ICsJaWYgKHJjIDwgMCkgew0KPiArCQlkZXZf
d2Fybigmb2N4bHBtZW0tPmRldiwgIkNvbnRyb2xsZXIgZHVtcCB0aW1lZCBvdXRcbiIpOw0KPiAr
CQlnb3RvIG91dDsNCj4gKwl9DQo+ICsNCj4gKwlyYyA9IGFkbWluX3Jlc3BvbnNlKG9jeGxwbWVt
KTsNCj4gKwlpZiAocmMgPCAwKQ0KPiArCQlnb3RvIG91dDsNCj4gKwlpZiAocmMgIT0gU1RBVFVT
X1NVQ0NFU1MpIHsNCj4gKwkJd2Fybl9zdGF0dXMob2N4bHBtZW0sDQo+ICsJCQkgICAgIlVuZXhw
ZWN0ZWQgc3RhdHVzIGZyb20gcmV0cmlldmUgZXJyb3IgbG9nIiwNCj4gKwkJCSAgICByYyk7DQo+
ICsJCWdvdG8gb3V0Ow0KPiArCX0NCg0KDQoNCkl0IHdvdWxkIGhlbHAgaWYgdGhlcmUgd2FzIGEg
Y29tbWVudCBpbmRpY2F0aW5nIGhvdyB0aGUgMyBpb2N0bHMgYXJlIA0KdXNlZC4gTXkgdW5kZXJz
dGFuZGluZyBpcyB0aGF0IHRoZSB1c2VybGFuZCBpczoNCi0gcmVxdWVzdGluZyB0aGUgY29udHJv
bGxlciB0byBwcmVwYXJlIGEgc3RhdGUgZHVtcA0KLSB0aGVuIG9uZSBvciBtb3JlIGlvY3RscyB0
byBmZXRjaCB0aGUgZGF0YS4gVGhlIG51bWJlciBvZiBjYWxscyANCnJlcXVpcmVkIHRvIGdldCB0
aGUgZnVsbCBzdGF0ZSByZWFsbHkgZGVwZW5kcyBvbiB0aGUgc2l6ZSBvZiB0aGUgYnVmZmVyIA0K
cGFzc2VkIGJ5IHVzZXINCi0gYSBsYXN0IGlvY3RsIHRvIHRlbGwgdGhlIGNvbnRyb2xsZXIgdGhh
dCB3ZSdyZSBkb25lLCBwcmVzdW1hYmx5IHRvIGxldCANCml0IGZyZWUgc29tZSByZXNvdXJjZXMu
DQoNCg0KPiArDQo+ICsJZm9yIChpID0gMDsgaSA8IGFyZ3MuYnVmX3NpemU7IGkgKz0gOCkgew0K
PiArCQl1NjQgdmFsOw0KPiArDQo+ICsJCXJjID0gb2N4bF9nbG9iYWxfbW1pb19yZWFkNjQob2N4
bHBtZW0tPm9jeGxfYWZ1LA0KPiArCQkJCQkgICAgIG9jeGxwbWVtLT5hZG1pbl9jb21tYW5kLmRh
dGFfb2Zmc2V0ICsgaSwNCj4gKwkJCQkJICAgICBPQ1hMX0hPU1RfRU5ESUFOLCAmdmFsKTsNCj4g
KwkJaWYgKHJjKQ0KPiArCQkJZ290byBvdXQ7DQo+ICsNCj4gKwkJaWYgKGNvcHlfdG9fdXNlcigm
YXJncy5idWZbaV0sICZ2YWwsIHNpemVvZih1NjQpKSkgew0KPiArCQkJcmMgPSAtRUZBVUxUOw0K
PiArCQkJZ290byBvdXQ7DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwlpZiAoY29weV90b191c2Vy
KHVhcmcsICZhcmdzLCBzaXplb2YoYXJncykpKSB7DQo+ICsJCXJjID0gLUVGQVVMVDsNCj4gKwkJ
Z290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICsJcmMgPSBhZG1pbl9yZXNwb25zZV9oYW5kbGVkKG9j
eGxwbWVtKTsNCj4gKwlpZiAocmMpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICtvdXQ6DQo+ICsJ
bXV0ZXhfdW5sb2NrKCZvY3hscG1lbS0+YWRtaW5fY29tbWFuZC5sb2NrKTsNCj4gKwlyZXR1cm4g
cmM7DQo+ICt9DQo+ICsNCj4gK2ludCByZXF1ZXN0X2NvbnRyb2xsZXJfZHVtcChzdHJ1Y3Qgb2N4
bHBtZW0gKm9jeGxwbWVtKQ0KPiArew0KPiArCWludCByYzsNCj4gKwl1NjQgYnVzeSA9IDE7DQo+
ICsNCj4gKwlyYyA9IG9jeGxfZ2xvYmFsX21taW9fc2V0NjQob2N4bHBtZW0tPm9jeGxfYWZ1LCBH
TE9CQUxfTU1JT19DSElDLA0KPiArCQkJCSAgICBPQ1hMX0xJVFRMRV9FTkRJQU4sDQo+ICsJCQkJ
ICAgIEdMT0JBTF9NTUlPX0NISV9DREEpOw0KPiArDQoNCg0KcmMgaXMgbm90IGNoZWNrZWQgaGVy
ZS4NCg0KDQo+ICsNCj4gKwlyYyA9IG9jeGxfZ2xvYmFsX21taW9fc2V0NjQob2N4bHBtZW0tPm9j
eGxfYWZ1LCBHTE9CQUxfTU1JT19IQ0ksDQo+ICsJCQkJICAgIE9DWExfTElUVExFX0VORElBTiwN
Cj4gKwkJCQkgICAgR0xPQkFMX01NSU9fSENJX0NPTlRST0xMRVJfRFVNUCk7DQo+ICsJaWYgKHJj
KQ0KPiArCQlyZXR1cm4gcmM7DQo+ICsNCj4gKwl3aGlsZSAoYnVzeSkgew0KPiArCQlyYyA9IG9j
eGxfZ2xvYmFsX21taW9fcmVhZDY0KG9jeGxwbWVtLT5vY3hsX2FmdSwNCj4gKwkJCQkJICAgICBH
TE9CQUxfTU1JT19IQ0ksDQo+ICsJCQkJCSAgICAgT0NYTF9MSVRUTEVfRU5ESUFOLCAmYnVzeSk7
DQo+ICsJCWlmIChyYykNCj4gKwkJCXJldHVybiByYzsNCj4gKw0KPiArCQlidXN5ICY9IEdMT0JB
TF9NTUlPX0hDSV9DT05UUk9MTEVSX0RVTVA7DQoNCg0KU2V0dGluZyAnYnVzeScgZG9lc24ndCBo
dXJ0LCBidXQgaXQncyBub3QgcmVhbGx5IHVzZWZ1bCwgaXMgaXQ/DQoNCldlIHNob3VsZCBhZGQg
c29tZSBraW5kIG9mIHRpbWVvdXQgc28gdGhhdCBpZiB0aGUgY29udHJvbGxlciBoaXRzIGFuIA0K
aXNzdWUsIHdlIGRvbid0IHNwaW4gaW4ga2VybmVsIHNwYWNlIGVuZGxlc3NseS4NCg0KDQoNCj4g
KwkJY29uZF9yZXNjaGVkKCk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgaW9jdGxfY29udHJvbGxlcl9kdW1wX2NvbXBsZXRlKHN0cnVjdCBvY3hs
cG1lbSAqb2N4bHBtZW0pDQo+ICt7DQo+ICsJcmV0dXJuIG9jeGxfZ2xvYmFsX21taW9fc2V0NjQo
b2N4bHBtZW0tPm9jeGxfYWZ1LCBHTE9CQUxfTU1JT19IQ0ksDQo+ICsJCQkJICAgIE9DWExfTElU
VExFX0VORElBTiwNCj4gKwkJCQkgICAgR0xPQkFMX01NSU9fSENJX0NPTlRST0xMRVJfRFVNUF9D
T0xMRUNURUQpOw0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGxvbmcgZmlsZV9pb2N0bChzdHJ1Y3Qg
ZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmdzKQ0KPiAgIHsN
Cj4gICAJc3RydWN0IG9jeGxwbWVtICpvY3hscG1lbSA9IGZpbGUtPnByaXZhdGVfZGF0YTsNCj4g
QEAgLTY1MCw3ICs3NjgsMjEgQEAgc3RhdGljIGxvbmcgZmlsZV9pb2N0bChzdHJ1Y3QgZmlsZSAq
ZmlsZSwgdW5zaWduZWQgaW50IGNtZCwgdW5zaWduZWQgbG9uZyBhcmdzKQ0KPiAgIAkJcmMgPSBp
b2N0bF9lcnJvcl9sb2cob2N4bHBtZW0sDQo+ICAgCQkJCSAgICAgKHN0cnVjdCBpb2N0bF9vY3hs
X3BtZW1fZXJyb3JfbG9nIF9fdXNlciAqKWFyZ3MpOw0KPiAgIAkJYnJlYWs7DQo+ICsNCj4gKwlj
YXNlIElPQ1RMX09DWExfUE1FTV9DT05UUk9MTEVSX0RVTVA6DQo+ICsJCXJjID0gcmVxdWVzdF9j
b250cm9sbGVyX2R1bXAob2N4bHBtZW0pOw0KPiArCQlicmVhazsNCj4gKw0KPiArCWNhc2UgSU9D
VExfT0NYTF9QTUVNX0NPTlRST0xMRVJfRFVNUF9EQVRBOg0KPiArCQlyYyA9IGlvY3RsX2NvbnRy
b2xsZXJfZHVtcF9kYXRhKG9jeGxwbWVtLA0KPiArCQkJCQkJKHN0cnVjdCBpb2N0bF9vY3hsX3Bt
ZW1fY29udHJvbGxlcl9kdW1wX2RhdGEgX191c2VyICopYXJncyk7DQo+ICsJCWJyZWFrOw0KPiAr
DQo+ICsJY2FzZSBJT0NUTF9PQ1hMX1BNRU1fQ09OVFJPTExFUl9EVU1QX0NPTVBMRVRFOg0KPiAr
CQlyYyA9IGlvY3RsX2NvbnRyb2xsZXJfZHVtcF9jb21wbGV0ZShvY3hscG1lbSk7DQo+ICsJCWJy
ZWFrOw0KPiAgIAl9DQo+ICsNCj4gICAJcmV0dXJuIHJjOw0KPiAgIH0NCj4gICANCj4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvdWFwaS9udmRpbW0vb2N4bC1wbWVtLmggYi9pbmNsdWRlL3VhcGkvbnZk
aW1tL29jeGwtcG1lbS5oDQo+IGluZGV4IGIxMGY4YWMwYzIwZi4uZDRkODUxMmQwM2Y3IDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbnZkaW1tL29jeGwtcG1lbS5oDQo+ICsrKyBiL2luY2x1
ZGUvdWFwaS9udmRpbW0vb2N4bC1wbWVtLmgNCj4gQEAgLTM4LDkgKzM4LDI0IEBAIHN0cnVjdCBp
b2N0bF9vY3hsX3BtZW1fZXJyb3JfbG9nIHsNCj4gICAJX191OCAqYnVmOyAvKiBwb2ludGVyIHRv
IG91dHB1dCBidWZmZXIgKi8NCj4gICB9Ow0KPiAgIA0KPiArc3RydWN0IGlvY3RsX29jeGxfcG1l
bV9jb250cm9sbGVyX2R1bXBfZGF0YSB7DQo+ICsJX191OCAqYnVmOyAvKiBwb2ludGVyIHRvIG91
dHB1dCBidWZmZXIgKi8NCg0KDQpXZSBvbmx5IHN1cHBvcnQgNjQtYml0IHVzZXIgYXBwIG9uIHBv
d2VycGMsIGJ1dCB1c2luZyBhIHBvaW50ZXIgdHlwZSBpbiANCmEga2VybmVsIEFCSSBpcyB1bnVz
dWFsLiBXZSBzaG91bGQgdXNlIGEga25vdyBzaXplIGxpa2UgX191NjQuDQooYWxzbyBhcHBsaWVz
IHRvIGJ1ZiBwb2ludGVyIGluIHN0cnVjdCBpb2N0bF9vY3hsX3BtZW1fZXJyb3JfbG9nIGZyb20g
DQpwcmV2aW91cyBwYXRjaCB0b28pDQoNClRoZSByZXN0IG9mIHRoZSBzdHJ1Y3R1cmUgd2lsbCBh
bHNvIGJlIHBhZGRlZCBieSB0aGUgY29tcGlsZXIsIHdoaWNoIHdlIA0Kc2hvdWxkIGF2b2lkLg0K
DQogICAgRnJlZA0KDQoNCg0KPiArCV9fdTE2IGJ1Zl9zaXplOyAvKiBpbi9vdXQsIGJ1ZmZlciBz
aXplIHByb3ZpZGVkL3JlcXVpcmVkLg0KPiArCQkJICogSWYgcmVxdWlyZWQgaXMgZ3JlYXRlciB0
aGFuIHByb3ZpZGVkLCB0aGUgYnVmZmVyDQo+ICsJCQkgKiB3aWxsIGJlIHRydW5jYXRlZCB0byB0
aGUgYW1vdW50IHByb3ZpZGVkLiBJZiBpdHMNCj4gKwkJCSAqIGxlc3MsIHRoZW4gb25seSB0aGUg
cmVxdWlyZWQgYnl0ZXMgd2lsbCBiZSBwb3B1bGF0ZWQuDQo+ICsJCQkgKiBJZiBpdCBpcyAwLCB0
aGVuIHRoZXJlIGlzIG5vIG1vcmUgZHVtcCBkYXRhIGF2YWlsYWJsZS4NCj4gKwkJCSAqLw0KPiAr
CV9fdTMyIG9mZnNldDsgLyogaW4sIE9mZnNldCB3aXRoaW4gdGhlIGR1bXAgKi8NCj4gKwlfX3U2
NCByZXNlcnZlZFs4XTsNCj4gK307DQo+ICsNCj4gICAvKiBpb2N0bCBudW1iZXJzICovDQo+ICAg
I2RlZmluZSBPQ1hMX1BNRU1fTUFHSUMgMHg1Qw0KPiAgIC8qIFNDTSBkZXZpY2VzICovDQo+ICAg
I2RlZmluZSBJT0NUTF9PQ1hMX1BNRU1fRVJST1JfTE9HCQkJX0lPV1IoT0NYTF9QTUVNX01BR0lD
LCAweDAxLCBzdHJ1Y3QgaW9jdGxfb2N4bF9wbWVtX2Vycm9yX2xvZykNCj4gKyNkZWZpbmUgSU9D
VExfT0NYTF9QTUVNX0NPTlRST0xMRVJfRFVNUAkJCV9JTyhPQ1hMX1BNRU1fTUFHSUMsIDB4MDIp
DQo+ICsjZGVmaW5lIElPQ1RMX09DWExfUE1FTV9DT05UUk9MTEVSX0RVTVBfREFUQQkJX0lPV1Io
T0NYTF9QTUVNX01BR0lDLCAweDAzLCBzdHJ1Y3QgaW9jdGxfb2N4bF9wbWVtX2NvbnRyb2xsZXJf
ZHVtcF9kYXRhKQ0KPiArI2RlZmluZSBJT0NUTF9PQ1hMX1BNRU1fQ09OVFJPTExFUl9EVU1QX0NP
TVBMRVRFCV9JTyhPQ1hMX1BNRU1fTUFHSUMsIDB4MDQpDQo+ICAgDQo+ICAgI2VuZGlmIC8qIF9V
QVBJX09DWExfU0NNX0ggKi8NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
