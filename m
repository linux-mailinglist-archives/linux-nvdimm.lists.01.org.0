Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3757BF36E5
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 19:19:19 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D8D2100EA622;
	Thu,  7 Nov 2019 10:21:42 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3FDB9100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 10:21:39 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7I8HiL145140
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 13:19:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w4qb6b0yd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 13:19:13 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 18:19:10 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 18:19:02 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7IJ1dU44105970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 18:19:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E2024C046;
	Thu,  7 Nov 2019 18:19:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D9F4C044;
	Thu,  7 Nov 2019 18:19:00 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 18:18:59 +0000 (GMT)
Subject: Re: [PATCH 07/10] ocxl: Save the device serial number in ocxl_fn
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-8-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 19:18:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-8-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110718-0016-0000-0000-000002C1AD4F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110718-0017-0000-0000-000033233106
Message-Id: <11327e5f-bc88-620e-f119-495eb7d4b02f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=785 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070167
Message-ID-Hash: 2K2I6CDHSANKMEDTQOGAEQUPP7DNLUAC
X-Message-ID-Hash: 2K2I6CDHSANKMEDTQOGAEQUPP7DNLUAC
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Nicholas Piggin <npiggin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca
 .pw>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2K2I6CDHSANKMEDTQOGAEQUPP7DNLUAC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
aGlzIHBhdGNoIHJldHJpZXZlcyB0aGUgc2VyaWFsIG51bWJlciBvZiB0aGUgY2FyZCBhbmQgbWFr
ZXMgaXQgYXZhaWxhYmxlDQo+IHRvIGNvbnN1bWVycyBvZiB0aGUgb2N4bCBkcml2ZXIgdmlhIHRo
ZSBvY3hsX2ZuIHN0cnVjdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEg
PGFsYXN0YWlyQGQtc2lsdmEub3JnPg0KPiAtLS0NCg0KDQpBY2tlZC1ieTogRnJlZGVyaWMgQmFy
cmF0IDxmYmFycmF0QGxpbnV4LmlibS5jb20+DQoNCg0KDQo+ICAgZHJpdmVycy9taXNjL29jeGwv
Y29uZmlnLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
IGluY2x1ZGUvbWlzYy9vY3hsLmggICAgICAgIHwgIDEgKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwg
NDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2Nv
bmZpZy5jIGIvZHJpdmVycy9taXNjL29jeGwvY29uZmlnLmMNCj4gaW5kZXggZmIwYzNiNmY4MzEy
Li5hOTIwM2MzMDkzNjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5j
DQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5jDQo+IEBAIC03MSw2ICs3MSw1MSBA
QCBzdGF0aWMgaW50IGZpbmRfZHZzZWNfYWZ1X2N0cmwoc3RydWN0IHBjaV9kZXYgKmRldiwgdTgg
YWZ1X2lkeCkNCj4gICAJcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBGaW5k
IGEgcmVsYXRlZCBQQ0kgZGV2aWNlIChmdW5jdGlvbiAwKQ0KPiArICogQGRldmljZTogUENJIGRl
dmljZSB0byBtYXRjaA0KPiArICoNCj4gKyAqIFJldHVybnMgYSBwb2ludGVyIHRvIHRoZSByZWxh
dGVkIGRldmljZSwgb3IgbnVsbCBpZiBub3QgZm91bmQNCj4gKyAqLw0KPiArc3RhdGljIHN0cnVj
dCBwY2lfZGV2ICpnZXRfZnVuY3Rpb25fMChzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiArew0KPiAr
CXVuc2lnbmVkIGludCBkZXZmbiA9IFBDSV9ERVZGTihQQ0lfU0xPVChkZXYtPmRldmZuKSwgMCk7
IC8vIExvb2sgZm9yIGZ1bmN0aW9uIDANCj4gKw0KPiArCXJldHVybiBwY2lfZ2V0X2RvbWFpbl9i
dXNfYW5kX3Nsb3QocGNpX2RvbWFpbl9ucihkZXYtPmJ1cyksDQo+ICsJCQkJCWRldi0+YnVzLT5u
dW1iZXIsIGRldmZuKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgcmVhZF9zZXJpYWwoc3Ry
dWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IG9jeGxfZm5fY29uZmlnICpmbikNCj4gK3sNCj4gKwl1
MzIgbG93LCBoaWdoOw0KPiArCWludCBwb3M7DQo+ICsNCj4gKwlwb3MgPSBwY2lfZmluZF9leHRf
Y2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX0RTTik7DQo+ICsJaWYgKHBvcykgew0KPiAr
CQlwY2lfcmVhZF9jb25maWdfZHdvcmQoZGV2LCBwb3MgKyAweDA0LCAmbG93KTsNCj4gKwkJcGNp
X3JlYWRfY29uZmlnX2R3b3JkKGRldiwgcG9zICsgMHgwOCwgJmhpZ2gpOw0KPiArDQo+ICsJCWZu
LT5zZXJpYWwgPSBsb3cgfCAoKHU2NCloaWdoKSA8PCAzMjsNCj4gKw0KPiArCQlyZXR1cm47DQo+
ICsJfQ0KPiArDQo+ICsJaWYgKFBDSV9GVU5DKGRldi0+ZGV2Zm4pICE9IDApIHsNCj4gKwkJc3Ry
dWN0IHBjaV9kZXYgKnJlbGF0ZWQgPSBnZXRfZnVuY3Rpb25fMChkZXYpOw0KPiArDQo+ICsJCWlm
ICghcmVsYXRlZCkgew0KPiArCQkJZm4tPnNlcmlhbCA9IDA7DQo+ICsJCQlyZXR1cm47DQo+ICsJ
CX0NCj4gKw0KPiArCQlyZWFkX3NlcmlhbChyZWxhdGVkLCBmbik7DQo+ICsJCXBjaV9kZXZfcHV0
KHJlbGF0ZWQpOw0KPiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJZm4tPnNlcmlhbCA9IDA7
DQo+ICt9DQo+ICsNCj4gICBzdGF0aWMgdm9pZCByZWFkX3Bhc2lkKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsIHN0cnVjdCBvY3hsX2ZuX2NvbmZpZyAqZm4pDQo+ICAgew0KPiAgIAl1MTYgdmFsOw0KPiBA
QCAtMjA4LDYgKzI1Myw3IEBAIGludCBvY3hsX2NvbmZpZ19yZWFkX2Z1bmN0aW9uKHN0cnVjdCBw
Y2lfZGV2ICpkZXYsIHN0cnVjdCBvY3hsX2ZuX2NvbmZpZyAqZm4pDQo+ICAgCWludCByYzsNCj4g
ICANCj4gICAJcmVhZF9wYXNpZChkZXYsIGZuKTsNCj4gKwlyZWFkX3NlcmlhbChkZXYsIGZuKTsN
Cj4gICANCj4gICAJcmMgPSByZWFkX2R2c2VjX3RsKGRldiwgZm4pOw0KPiAgIAlpZiAocmMpIHsN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbWlzYy9vY3hsLmggYi9pbmNsdWRlL21pc2Mvb2N4bC5o
DQo+IGluZGV4IDZmN2MwMmYwZDVlMy4uOTg0MzA1MWMzYzViIDEwMDY0NA0KPiAtLS0gYS9pbmNs
dWRlL21pc2Mvb2N4bC5oDQo+ICsrKyBiL2luY2x1ZGUvbWlzYy9vY3hsLmgNCj4gQEAgLTQ2LDYg
KzQ2LDcgQEAgc3RydWN0IG9jeGxfZm5fY29uZmlnIHsNCj4gICAJaW50IGR2c2VjX2FmdV9pbmZv
X3BvczsgLyogb2Zmc2V0IG9mIHRoZSBBRlUgaW5mb3JtYXRpb24gRFZTRUMgKi8NCj4gICAJczgg
bWF4X3Bhc2lkX2xvZzsNCj4gICAJczggbWF4X2FmdV9pbmRleDsNCj4gKwl1NjQgc2VyaWFsOw0K
PiAgIH07DQo+ICAgDQo+ICAgZW51bSBvY3hsX2VuZGlhbiB7DQo+IA0KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
