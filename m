Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D697EF3692
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 19:05:30 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E7AC6100EA622;
	Thu,  7 Nov 2019 10:07:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4714E100EEB95
	for <linux-nvdimm@lists.01.org>; Thu,  7 Nov 2019 10:07:51 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA7HlQQ4082590
	for <linux-nvdimm@lists.01.org>; Thu, 7 Nov 2019 13:05:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2w4qb6ahmy-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 07 Nov 2019 13:05:25 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Thu, 7 Nov 2019 18:05:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 7 Nov 2019 18:05:15 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA7I5D3Q65798194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2019 18:05:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4970E4C04E;
	Thu,  7 Nov 2019 18:05:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26B9E4C04A;
	Thu,  7 Nov 2019 18:05:12 +0000 (GMT)
Received: from pic2.home (unknown [9.145.15.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2019 18:05:12 +0000 (GMT)
Subject: Re: [PATCH 06/10] ocxl: Add functions to map/unmap LPC memory
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Thu, 7 Nov 2019 19:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-7-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19110718-0020-0000-0000-000003837FF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110718-0021-0000-0000-000021D9B598
Message-Id: <127f1885-df07-2a23-976e-f97c6ff8e2b2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-07_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=917 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911070165
Message-ID-Hash: XIRHT6YUPCEVN2XZ4G3TESWPQQCFYVSF
X-Message-ID-Hash: XIRHT6YUPCEVN2XZ4G3TESWPQQCFYVSF
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Thomas Gleixner <tglx@linutronix.de>, Hari Bathini <hbathini@linux.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, lin
 ux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XIRHT6YUPCEVN2XZ4G3TESWPQQCFYVSF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDI1LzEwLzIwMTkgw6AgMDY6NDcsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBB
ZGQgZnVuY3Rpb25zIHRvIG1hcC91bm1hcCBMUEMgbWVtb3J5DQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gLS0tDQo+ICAgZHJp
dmVycy9taXNjL29jeGwvY29uZmlnLmMgICAgICAgIHwgIDQgKysrDQo+ICAgZHJpdmVycy9taXNj
L29jeGwvY29yZS5jICAgICAgICAgIHwgNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgIGRyaXZlcnMvbWlzYy9vY3hsL29jeGxfaW50ZXJuYWwuaCB8ICAzICsrDQo+ICAgaW5j
bHVkZS9taXNjL29jeGwuaCAgICAgICAgICAgICAgIHwgMTggKysrKysrKysrKysNCj4gICA0IGZp
bGVzIGNoYW5nZWQsIDc1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21pc2Mvb2N4bC9jb25maWcuYyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5jDQo+IGluZGV4
IGM4ZTE5YmZiNWVmOS4uZmIwYzNiNmY4MzEyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2Mv
b2N4bC9jb25maWcuYw0KPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYw0KPiBAQCAt
NTY4LDYgKzU2OCwxMCBAQCBzdGF0aWMgaW50IHJlYWRfYWZ1X2xwY19tZW1vcnlfaW5mbyhzdHJ1
Y3QgcGNpX2RldiAqZGV2LA0KPiAgIAkJYWZ1LT5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUgPQ0K
PiAgIAkJCXRvdGFsX21lbV9zaXplIC0gbHBjX21lbV9zaXplOw0KPiAgIAl9DQo+ICsNCj4gKwlk
ZXZfaW5mbygmZGV2LT5kZXYsICJQcm9iZWQgTFBDIG1lbW9yeSBvZiAlI2xseCBieXRlcyBhbmQg
c3BlY2lhbCBwdXJwb3NlIG1lbW9yeSBvZiAlI2xseCBieXRlc1xuIiwNCj4gKwkJYWZ1LT5scGNf
bWVtX3NpemUsIGFmdS0+c3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKTsNCj4gKw0KPiAgIAlyZXR1
cm4gMDsNCj4gICB9DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mvb2N4bC9jb3Jl
LmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gaW5kZXggMjUzMWM2Y2YxOWEwLi41NTU0
ZjVjZTRiOWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUuYw0KPiArKysg
Yi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gQEAgLTIxMCw2ICsyMTAsNTUgQEAgc3RhdGlj
IHZvaWQgdW5tYXBfbW1pb19hcmVhcyhzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gICAJcmVsZWFz
ZV9mbl9iYXIoYWZ1LT5mbiwgYWZ1LT5jb25maWcuZ2xvYmFsX21taW9fYmFyKTsNCj4gICB9DQo+
ICAgDQo+ICtpbnQgb2N4bF9hZnVfbWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpDQo+
ICt7DQo+ICsJc3RydWN0IHBjaV9kZXYgKmRldiA9IHRvX3BjaV9kZXYoYWZ1LT5mbi0+ZGV2LnBh
cmVudCk7DQo+ICsNCj4gKwlpZiAoKGFmdS0+Y29uZmlnLmxwY19tZW1fc2l6ZSArIGFmdS0+Y29u
ZmlnLnNwZWNpYWxfcHVycG9zZV9tZW1fc2l6ZSkgPT0gMCkNCj4gKwkJcmV0dXJuIDA7DQo+ICsN
Cj4gKwlhZnUtPmxwY19iYXNlX2FkZHIgPSBvY3hsX2xpbmtfbHBjX21hcChhZnUtPmZuLT5saW5r
LCBkZXYpOw0KPiArCWlmIChhZnUtPmxwY19iYXNlX2FkZHIgPT0gMCkNCj4gKwkJcmV0dXJuIC1F
SU5WQUw7DQo+ICsNCj4gKwlpZiAoYWZ1LT5jb25maWcubHBjX21lbV9zaXplKSB7DQo+ICsJCWFm
dS0+bHBjX3Jlcy5zdGFydCA9IGFmdS0+bHBjX2Jhc2VfYWRkciArIGFmdS0+Y29uZmlnLmxwY19t
ZW1fb2Zmc2V0Ow0KPiArCQlhZnUtPmxwY19yZXMuZW5kID0gYWZ1LT5scGNfcmVzLnN0YXJ0ICsg
YWZ1LT5jb25maWcubHBjX21lbV9zaXplIC0gMTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoYWZ1LT5j
b25maWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKSB7DQo+ICsJCWFmdS0+c3BlY2lhbF9wdXJw
b3NlX3Jlcy5zdGFydCA9IGFmdS0+bHBjX2Jhc2VfYWRkciArDQo+ICsJCQkJCQkgYWZ1LT5jb25m
aWcuc3BlY2lhbF9wdXJwb3NlX21lbV9vZmZzZXQ7DQo+ICsJCWFmdS0+c3BlY2lhbF9wdXJwb3Nl
X3Jlcy5lbmQgPSBhZnUtPnNwZWNpYWxfcHVycG9zZV9yZXMuc3RhcnQgKw0KPiArCQkJCQkgICAg
ICAgYWZ1LT5jb25maWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplIC0gMTsNCj4gKwl9DQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0wob2N4bF9hZnVfbWFwX2xwY19t
ZW0pOw0KDQoNCldlIHNob3VsZCB1c2UgRVhQT1JUX1NZTUJPTF9HUEwoKS4NCg0Kb2ssIHNvIHdl
J3JlIHVubWFwcGluZyB0aGUgbHBjIG1lbW9yeSBpbXBsaWNpdGx5IHdoZW4gY2FsbGluZyANCm9j
eGxfZnVuY3Rpb25fY2xvc2UoKSBhbmQgdGhlcmVmb3JlIGRvbid0IHJlYWxseSBuZWVkIHRvIGV4
cG9ydCANCihvY3hsXyl1bm1hcF9scGNfbWVtKCkuIEkgZ3Vlc3MgdGhhdCdzIGZpbmUgYW5kIGVh
c3kgZW5vdWdoIHRvIGFkZCBpZiANCm9uZSBkYXkgc29tZWJvZHkgaGFzIHRoZSBuZWVkIHRvIHVu
bWFwIHdpdGhvdXQgY2xvc2luZy4NCg0KDQo+ICsNCj4gK3N0cnVjdCByZXNvdXJjZSAqb2N4bF9h
ZnVfbHBjX21lbShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSkNCj4gK3sNCj4gKwlyZXR1cm4gJmFmdS0+
bHBjX3JlczsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0wob2N4bF9hZnVfbHBjX21lbSk7DQo+ICsN
Cj4gK3N0YXRpYyB2b2lkIHVubWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpDQo+ICt7
DQo+ICsJc3RydWN0IHBjaV9kZXYgKmRldiA9IHRvX3BjaV9kZXYoYWZ1LT5mbi0+ZGV2LnBhcmVu
dCk7DQo+ICsNCj4gKwlpZiAoYWZ1LT5scGNfcmVzLnN0YXJ0IHx8IGFmdS0+c3BlY2lhbF9wdXJw
b3NlX3Jlcy5zdGFydCkgew0KPiArCQl2b2lkICpsaW5rID0gYWZ1LT5mbi0+bGluazsNCj4gKw0K
PiArCQlvY3hsX2xpbmtfbHBjX3JlbGVhc2UobGluaywgZGV2KTsNCj4gKw0KPiArCQlhZnUtPmxw
Y19yZXMuc3RhcnQgPSAwOw0KPiArCQlhZnUtPmxwY19yZXMuZW5kID0gMDsNCj4gKwkJYWZ1LT5z
cGVjaWFsX3B1cnBvc2VfcmVzLnN0YXJ0ID0gMDsNCj4gKwkJYWZ1LT5zcGVjaWFsX3B1cnBvc2Vf
cmVzLmVuZCA9IDA7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICAgc3RhdGljIGludCBjb25maWd1cmVf
YWZ1KHN0cnVjdCBvY3hsX2FmdSAqYWZ1LCB1OCBhZnVfaWR4LCBzdHJ1Y3QgcGNpX2RldiAqZGV2
KQ0KPiAgIHsNCj4gICAJaW50IHJjOw0KPiBAQCAtMjUxLDYgKzMwMCw3IEBAIHN0YXRpYyBpbnQg
Y29uZmlndXJlX2FmdShzdHJ1Y3Qgb2N4bF9hZnUgKmFmdSwgdTggYWZ1X2lkeCwgc3RydWN0IHBj
aV9kZXYgKmRldikNCj4gICANCj4gICBzdGF0aWMgdm9pZCBkZWNvbmZpZ3VyZV9hZnUoc3RydWN0
IG9jeGxfYWZ1ICphZnUpDQo+ICAgew0KPiArCXVubWFwX2xwY19tZW0oYWZ1KTsNCj4gICAJdW5t
YXBfbW1pb19hcmVhcyhhZnUpOw0KPiAgIAlyZWNsYWltX2FmdV9wYXNpZChhZnUpOw0KPiAgIAly
ZWNsYWltX2FmdV9hY3RhZyhhZnUpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwv
b2N4bF9pbnRlcm5hbC5oIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oDQo+IGlu
ZGV4IDIwYjQxN2UwMDk0OS4uOWY0YjQ3OTAwZTYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21p
c2Mvb2N4bC9vY3hsX2ludGVybmFsLmgNCj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9p
bnRlcm5hbC5oDQo+IEBAIC01Miw2ICs1Miw5IEBAIHN0cnVjdCBvY3hsX2FmdSB7DQo+ICAgCXZv
aWQgX19pb21lbSAqZ2xvYmFsX21taW9fcHRyOw0KPiAgIAl1NjQgcHBfbW1pb19zdGFydDsNCj4g
ICAJdm9pZCAqcHJpdmF0ZTsNCj4gKwl1NjQgbHBjX2Jhc2VfYWRkcjsgLyogQ292ZXJzIGJvdGgg
TFBDICYgc3BlY2lhbCBwdXJwb3NlIG1lbW9yeSAqLw0KPiArCXN0cnVjdCByZXNvdXJjZSBscGNf
cmVzOw0KPiArCXN0cnVjdCByZXNvdXJjZSBzcGVjaWFsX3B1cnBvc2VfcmVzOw0KPiAgIH07DQo+
ICAgDQo+ICAgZW51bSBvY3hsX2NvbnRleHRfc3RhdHVzIHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbWlzYy9vY3hsLmggYi9pbmNsdWRlL21pc2Mvb2N4bC5oDQo+IGluZGV4IDA2ZGQ1ODM5ZTQz
OC4uNmY3YzAyZjBkNWUzIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL21pc2Mvb2N4bC5oDQo+ICsr
KyBiL2luY2x1ZGUvbWlzYy9vY3hsLmgNCj4gQEAgLTIxMiw2ICsyMTIsMjQgQEAgaW50IG9jeGxf
aXJxX3NldF9oYW5kbGVyKHN0cnVjdCBvY3hsX2NvbnRleHQgKmN0eCwgaW50IGlycV9pZCwNCj4g
ICANCj4gICAvLyBBRlUgTWV0YWRhdGENCj4gICANCj4gKy8qKg0KPiArICogTWFwIHRoZSBMUEMg
c3lzdGVtICYgc3BlY2lhbCBwdXJwb3NlIG1lbW9yeSBmb3IgYW4gQUZVDQo+ICsgKg0KPiArICog
RG8gbm90IGNhbGwgdGhpcyBkdXJpbmcgZGV2aWNlIGRpc2NvdmVyeSwgYXMgdGhlcmUgbWF5IG1l
IG11bHRpcGxlDQo+ICsgKiBkZXZpY2VzIG9uIGEgbGluaywgYW5kIHRoZSBtZW1vcnkgaXMgbWFw
cGVkIGZvciB0aGUgd2hvbGUgbGluaywgbm90DQo+ICsgKiBqdXN0IG9uZSBkZXZpY2UuIEl0IHNo
b3VsZCBvbmx5IGJlIGNhbGxlZCBhZnRlciBhbGwgZGV2aWNlcyBoYXZlDQo+ICsgKiByZWdpc3Rl
cmVkIHRoZWlyIG1lbW9yeSBvbiB0aGUgbGluay4NCg0KDQpJZiB3ZSB3ZXJlIHN1cHBvcnRpbmcg
bW9yZSB0aGFuIG9uZSBBRlUtY2FycnlpbmcgZnVuY3Rpb25zLCB3ZSB3b3VsZCANCm5lZWQgdG8g
cmV3b3JrIHRoaXMsIGFzIGZ1bmN0aW9ucyBjb3VsZCBjb21lIGFuZCBnbyBhbmQgdGhlIHRvdGFs
IHJhbmdlIA0KY291bGQgYmUgZHluYW1pYyAoZXZlbiB0aGUgbWF4IGFkZHJlc3Mgb2YgdGhlIHJh
bmdlIGNvdWxkIGluY3JlYXNlLCBpZiBhIA0KZnVuY3Rpb24gaXMgdXBkYXRlZCB3aXRoIGFuIEFG
VSB3aXRoIGEgYmlnZ2VyIExQQyBzaXplKS4gQnV0IHdlIGRvbid0IA0Kc3VwcG9ydCBtdWx0aXBs
ZSBBRlUtY2FycnlpbmcgZnVuY3Rpb25zLCBzbyBjdXJyZW50IGltcGxlbWVudGF0aW9uIGlzIA0K
ZmluZS4gQW5kIHNpbXBsZS4NCg0KICAgRnJlZA0KDQoNCj4gKyAqDQo+ICsgKiBhZnU6IFRoZSBB
RlUgdGhhdCBoYXMgdGhlIExQQyBtZW1vcnkgdG8gbWFwDQo+ICsgKi8NCj4gK2V4dGVybiBpbnQg
b2N4bF9hZnVfbWFwX2xwY19tZW0oc3RydWN0IG9jeGxfYWZ1ICphZnUpOw0KPiArDQo+ICsvKioN
Cj4gKyAqIEdldCB0aGUgcGh5c2ljYWwgYWRkcmVzcyByYW5nZSBvZiBMUEMgbWVtb3J5IGZvciBh
biBBRlUNCj4gKyAqIGFmdTogVGhlIEFGVSBhc3NvY2lhdGVkIHdpdGggdGhlIExQQyBtZW1vcnkN
Cj4gKyAqLw0KPiArZXh0ZXJuIHN0cnVjdCByZXNvdXJjZSAqb2N4bF9hZnVfbHBjX21lbShzdHJ1
Y3Qgb2N4bF9hZnUgKmFmdSk7DQo+ICsNCj4gICAvKioNCj4gICAgKiBHZXQgYSBwb2ludGVyIHRv
IHRoZSBjb25maWcgZm9yIGFuIEFGVQ0KPiAgICAqDQo+IA0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
