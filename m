Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FB116C230
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 14:24:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BEE210FC3403;
	Tue, 25 Feb 2020 05:25:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7E2C210FC33FB
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 05:25:04 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PDNW5D040401
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 08:24:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2yb1b8k7kb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 08:24:11 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 25 Feb 2020 13:24:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 25 Feb 2020 13:24:01 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PDO0jc51773506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2020 13:24:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CB611C05B;
	Tue, 25 Feb 2020 13:23:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C212811C058;
	Tue, 25 Feb 2020 13:23:58 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2020 13:23:58 +0000 (GMT)
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-5-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 25 Feb 2020 14:23:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-5-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022513-4275-0000-0000-000003A552DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022513-4276-0000-0000-000038B968AA
Message-Id: <4a29677a-885e-d493-c9f0-2698ea41a58c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_04:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250106
Message-ID-Hash: EU7D43OKQYZ42RR3ASFYB65H3F5OEVF3
X-Message-ID-Hash: EU7D43OKQYZ42RR3ASFYB65H3F5OEVF3
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EU7D43OKQYZ42RR3ASFYB65H3F5OEVF3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBG
dW5jdGlvbiBkZWNsYXJhdGlvbnMgZG9uJ3QgbmVlZCBleHRlcm5zLCByZW1vdmUgdGhlIGV4aXN0
aW5nIG9uZXMNCj4gc28gdGhleSBhcmUgY29uc2lzdGVudCB3aXRoIG5ld2VyIGNvZGUNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEub3JnPg0K
PiAtLS0NCg0KVGhhbmtzIGZvciB0aGUgY2xlYW51cCENCkFja2VkLWJ5OiBGcmVkZXJpYyBCYXJy
YXQgPGZiYXJyYXRAbGludXguaWJtLmNvbT4NCg0KDQoNCg0KPiAgIGFyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9wbnYtb2N4bC5oIHwgMzIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4g
ICBpbmNsdWRlL21pc2Mvb2N4bC5oICAgICAgICAgICAgICAgICB8ICA2ICsrKy0tLQ0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmggYi9hcmNoL3Bv
d2VycGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiBpbmRleCAwYjJhNjcwN2U1NTUuLmIyM2M5
OWJjMGM4NCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hs
LmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gQEAgLTks
MjkgKzksMjcgQEANCj4gICAjZGVmaW5lIFBOVl9PQ1hMX1RMX0JJVFNfUEVSX1JBVEUgICAgICAg
NA0KPiAgICNkZWZpbmUgUE5WX09DWExfVExfUkFURV9CVUZfU0laRSAgICAgICAoKFBOVl9PQ1hM
X1RMX01BWF9URU1QTEFURSsxKSAqIFBOVl9PQ1hMX1RMX0JJVFNfUEVSX1JBVEUgLyA4KQ0KPiAg
IA0KPiAtZXh0ZXJuIGludCBwbnZfb2N4bF9nZXRfYWN0YWcoc3RydWN0IHBjaV9kZXYgKmRldiwg
dTE2ICpiYXNlLCB1MTYgKmVuYWJsZWQsDQo+IC0JCQl1MTYgKnN1cHBvcnRlZCk7DQo+IC1leHRl
cm4gaW50IHBudl9vY3hsX2dldF9wYXNpZF9jb3VudChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQg
KmNvdW50KTsNCj4gK2ludCBwbnZfb2N4bF9nZXRfYWN0YWcoc3RydWN0IHBjaV9kZXYgKmRldiwg
dTE2ICpiYXNlLCB1MTYgKmVuYWJsZWQsIHUxNiAqc3VwcG9ydGVkKTsNCj4gK2ludCBwbnZfb2N4
bF9nZXRfcGFzaWRfY291bnQoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50ICpjb3VudCk7DQo+ICAg
DQo+IC1leHRlcm4gaW50IHBudl9vY3hsX2dldF90bF9jYXAoc3RydWN0IHBjaV9kZXYgKmRldiwg
bG9uZyAqY2FwLA0KPiAraW50IHBudl9vY3hsX2dldF90bF9jYXAoc3RydWN0IHBjaV9kZXYgKmRl
diwgbG9uZyAqY2FwLA0KPiAgIAkJCWNoYXIgKnJhdGVfYnVmLCBpbnQgcmF0ZV9idWZfc2l6ZSk7
DQo+IC1leHRlcm4gaW50IHBudl9vY3hsX3NldF90bF9jb25mKHN0cnVjdCBwY2lfZGV2ICpkZXYs
IGxvbmcgY2FwLA0KPiAraW50IHBudl9vY3hsX3NldF90bF9jb25mKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsIGxvbmcgY2FwLA0KPiAgIAkJCXVpbnQ2NF90IHJhdGVfYnVmX3BoeXMsIGludCByYXRlX2J1
Zl9zaXplKTsNCj4gICANCj4gLWV4dGVybiBpbnQgcG52X29jeGxfZ2V0X3hzbF9pcnEoc3RydWN0
IHBjaV9kZXYgKmRldiwgaW50ICpod2lycSk7DQo+IC1leHRlcm4gdm9pZCBwbnZfb2N4bF91bm1h
cF94c2xfcmVncyh2b2lkIF9faW9tZW0gKmRzaXNyLCB2b2lkIF9faW9tZW0gKmRhciwNCj4gLQkJ
CQl2b2lkIF9faW9tZW0gKnRmYywgdm9pZCBfX2lvbWVtICpwZV9oYW5kbGUpOw0KPiAtZXh0ZXJu
IGludCBwbnZfb2N4bF9tYXBfeHNsX3JlZ3Moc3RydWN0IHBjaV9kZXYgKmRldiwgdm9pZCBfX2lv
bWVtICoqZHNpc3IsDQo+IC0JCQkJdm9pZCBfX2lvbWVtICoqZGFyLCB2b2lkIF9faW9tZW0gKip0
ZmMsDQo+IC0JCQkJdm9pZCBfX2lvbWVtICoqcGVfaGFuZGxlKTsNCj4gK2ludCBwbnZfb2N4bF9n
ZXRfeHNsX2lycShzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgKmh3aXJxKTsNCj4gK3ZvaWQgcG52
X29jeGxfdW5tYXBfeHNsX3JlZ3Modm9pZCBfX2lvbWVtICpkc2lzciwgdm9pZCBfX2lvbWVtICpk
YXIsDQo+ICsJCQkgICAgIHZvaWQgX19pb21lbSAqdGZjLCB2b2lkIF9faW9tZW0gKnBlX2hhbmRs
ZSk7DQo+ICtpbnQgcG52X29jeGxfbWFwX3hzbF9yZWdzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHZv
aWQgX19pb21lbSAqKmRzaXNyLA0KPiArCQkJICB2b2lkIF9faW9tZW0gKipkYXIsIHZvaWQgX19p
b21lbSAqKnRmYywNCj4gKwkJCSAgdm9pZCBfX2lvbWVtICoqcGVfaGFuZGxlKTsNCj4gICANCj4g
LWV4dGVybiBpbnQgcG52X29jeGxfc3BhX3NldHVwKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHZvaWQg
KnNwYV9tZW0sIGludCBQRV9tYXNrLA0KPiAtCQkJdm9pZCAqKnBsYXRmb3JtX2RhdGEpOw0KPiAt
ZXh0ZXJuIHZvaWQgcG52X29jeGxfc3BhX3JlbGVhc2Uodm9pZCAqcGxhdGZvcm1fZGF0YSk7DQo+
IC1leHRlcm4gaW50IHBudl9vY3hsX3NwYV9yZW1vdmVfcGVfZnJvbV9jYWNoZSh2b2lkICpwbGF0
Zm9ybV9kYXRhLCBpbnQgcGVfaGFuZGxlKTsNCj4gK2ludCBwbnZfb2N4bF9zcGFfc2V0dXAoc3Ry
dWN0IHBjaV9kZXYgKmRldiwgdm9pZCAqc3BhX21lbSwgaW50IFBFX21hc2ssIHZvaWQgKipwbGF0
Zm9ybV9kYXRhKTsNCj4gK3ZvaWQgcG52X29jeGxfc3BhX3JlbGVhc2Uodm9pZCAqcGxhdGZvcm1f
ZGF0YSk7DQo+ICtpbnQgcG52X29jeGxfc3BhX3JlbW92ZV9wZV9mcm9tX2NhY2hlKHZvaWQgKnBs
YXRmb3JtX2RhdGEsIGludCBwZV9oYW5kbGUpOw0KPiAgIA0KPiAtZXh0ZXJuIGludCBwbnZfb2N4
bF9hbGxvY194aXZlX2lycSh1MzIgKmlycSwgdTY0ICp0cmlnZ2VyX2FkZHIpOw0KPiAtZXh0ZXJu
IHZvaWQgcG52X29jeGxfZnJlZV94aXZlX2lycSh1MzIgaXJxKTsNCj4gK2ludCBwbnZfb2N4bF9h
bGxvY194aXZlX2lycSh1MzIgKmlycSwgdTY0ICp0cmlnZ2VyX2FkZHIpOw0KPiArdm9pZCBwbnZf
b2N4bF9mcmVlX3hpdmVfaXJxKHUzMiBpcnEpOw0KPiAgICNpZmRlZiBDT05GSUdfTUVNT1JZX0hP
VFBMVUdfU1BBUlNFDQo+ICAgdTY0IHBudl9vY3hsX3BsYXRmb3JtX2xwY19zZXR1cChzdHJ1Y3Qg
cGNpX2RldiAqcGRldiwgdTY0IHNpemUpOw0KPiAgIHZvaWQgcG52X29jeGxfcGxhdGZvcm1fbHBj
X3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9t
aXNjL29jeGwuaCBiL2luY2x1ZGUvbWlzYy9vY3hsLmgNCj4gaW5kZXggMDZkZDU4MzllNDM4Li4w
YTc2MmUzODc0MTggMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbWlzYy9vY3hsLmgNCj4gKysrIGIv
aW5jbHVkZS9taXNjL29jeGwuaA0KPiBAQCAtMTczLDcgKzE3Myw3IEBAIGludCBvY3hsX2NvbnRl
eHRfZGV0YWNoKHN0cnVjdCBvY3hsX2NvbnRleHQgKmN0eCk7DQo+ICAgICoNCj4gICAgKiBSZXR1
cm5zIDAgb24gc3VjY2VzcywgbmVnYXRpdmUgb24gZmFpbHVyZQ0KPiAgICAqLw0KPiAtZXh0ZXJu
IGludCBvY3hsX2FmdV9pcnFfYWxsb2Moc3RydWN0IG9jeGxfY29udGV4dCAqY3R4LCBpbnQgKmly
cV9pZCk7DQo+ICtpbnQgb2N4bF9hZnVfaXJxX2FsbG9jKHN0cnVjdCBvY3hsX2NvbnRleHQgKmN0
eCwgaW50ICppcnFfaWQpOw0KPiAgIA0KPiAgIC8qKg0KPiAgICAqIEZyZWVzIGFuIElSUSBhc3Nv
Y2lhdGVkIHdpdGggYW4gQUZVIGNvbnRleHQNCj4gQEAgLTE4Miw3ICsxODIsNyBAQCBleHRlcm4g
aW50IG9jeGxfYWZ1X2lycV9hbGxvYyhzdHJ1Y3Qgb2N4bF9jb250ZXh0ICpjdHgsIGludCAqaXJx
X2lkKTsNCj4gICAgKg0KPiAgICAqIFJldHVybnMgMCBvbiBzdWNjZXNzLCBuZWdhdGl2ZSBvbiBm
YWlsdXJlDQo+ICAgICovDQo+IC1leHRlcm4gaW50IG9jeGxfYWZ1X2lycV9mcmVlKHN0cnVjdCBv
Y3hsX2NvbnRleHQgKmN0eCwgaW50IGlycV9pZCk7DQo+ICtpbnQgb2N4bF9hZnVfaXJxX2ZyZWUo
c3RydWN0IG9jeGxfY29udGV4dCAqY3R4LCBpbnQgaXJxX2lkKTsNCj4gICANCj4gICAvKioNCj4g
ICAgKiBHZXRzIHRoZSBhZGRyZXNzIG9mIHRoZSB0cmlnZ2VyIHBhZ2UgZm9yIGFuIElSUQ0KPiBA
QCAtMTkzLDcgKzE5Myw3IEBAIGV4dGVybiBpbnQgb2N4bF9hZnVfaXJxX2ZyZWUoc3RydWN0IG9j
eGxfY29udGV4dCAqY3R4LCBpbnQgaXJxX2lkKTsNCj4gICAgKg0KPiAgICAqIHJldHVybnMgdGhl
IHRyaWdnZXIgcGFnZSBhZGRyZXNzLCBvciAwIGlmIHRoZSBJUlEgaXMgbm90IHZhbGlkDQo+ICAg
ICovDQo+IC1leHRlcm4gdTY0IG9jeGxfYWZ1X2lycV9nZXRfYWRkcihzdHJ1Y3Qgb2N4bF9jb250
ZXh0ICpjdHgsIGludCBpcnFfaWQpOw0KPiArdTY0IG9jeGxfYWZ1X2lycV9nZXRfYWRkcihzdHJ1
Y3Qgb2N4bF9jb250ZXh0ICpjdHgsIGludCBpcnFfaWQpOw0KPiAgIA0KPiAgIC8qKg0KPiAgICAq
IFByb3ZpZGUgYSBjYWxsYmFjayB0byBiZSBjYWxsZWQgd2hlbiBhbiBJUlEgaXMgdHJpZ2dlcmVk
DQo+IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
