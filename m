Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5EE16EB76
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Feb 2020 17:31:12 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4662210FC35B9;
	Tue, 25 Feb 2020 08:32:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=fbarrat@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85C6310FC35B7
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 08:31:59 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PGLGdd184585
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 11:31:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2yd4h2xf78-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Tue, 25 Feb 2020 11:31:06 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <fbarrat@linux.ibm.com>;
	Tue, 25 Feb 2020 16:31:04 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 25 Feb 2020 16:30:55 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PGUsai37683538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2020 16:30:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A49542041;
	Tue, 25 Feb 2020 16:30:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F8E34204B;
	Tue, 25 Feb 2020 16:30:53 +0000 (GMT)
Received: from bali.tlslab.ibm.com (unknown [9.101.4.17])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2020 16:30:52 +0000 (GMT)
Subject: Re: [PATCH v3 06/27] ocxl: Tally up the LPC memory on a link & allow
 it to be mapped
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20200221032720.33893-1-alastair@au1.ibm.com>
 <20200221032720.33893-7-alastair@au1.ibm.com>
From: Frederic Barrat <fbarrat@linux.ibm.com>
Date: Tue, 25 Feb 2020 17:30:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221032720.33893-7-alastair@au1.ibm.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022516-4275-0000-0000-000003A56068
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022516-4276-0000-0000-000038B976B1
Message-Id: <4c8f704b-5607-5ca0-c00e-01e412117f6b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_05:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=2 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250124
Message-ID-Hash: LIPS4KV2VWAMNIL2IBSNBO4QNG2KO5OI
X-Message-ID-Hash: LIPS4KV2VWAMNIL2IBSNBO4QNG2KO5OI
X-MailFrom: fbarrat@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-de
 v@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LIPS4KV2VWAMNIL2IBSNBO4QNG2KO5OI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDIxLzAyLzIwMjAgw6AgMDQ6MjYsIEFsYXN0YWlyIEQnU2lsdmEgYSDDqWNyaXTCoDoN
Cj4gRnJvbTogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IA0KPiBU
YWxseSB1cCB0aGUgTFBDIG1lbW9yeSBvbiBhbiBPcGVuQ0FQSSBsaW5rICYgYWxsb3cgaXQgdG8g
YmUgbWFwcGVkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFp
ckBkLXNpbHZhLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9taXNjL29jeGwvY29yZS5jICAgICAg
ICAgIHwgMTAgKysrKysrDQo+ICAgZHJpdmVycy9taXNjL29jeGwvbGluay5jICAgICAgICAgIHwg
NTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGRyaXZlcnMvbWlzYy9vY3hs
L29jeGxfaW50ZXJuYWwuaCB8IDMzICsrKysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDk2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mv
b2N4bC9jb3JlLmMgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gaW5kZXggYjdhMDliMjFh
YjM2Li4yNTMxYzZjZjE5YTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvcmUu
Yw0KPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4bC9jb3JlLmMNCj4gQEAgLTIzMCw4ICsyMzAsMTgg
QEAgc3RhdGljIGludCBjb25maWd1cmVfYWZ1KHN0cnVjdCBvY3hsX2FmdSAqYWZ1LCB1OCBhZnVf
aWR4LCBzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiAgIAlpZiAocmMpDQo+ICAgCQlnb3RvIGVycl9m
cmVlX3Bhc2lkOw0KPiAgIA0KPiArCWlmIChhZnUtPmNvbmZpZy5scGNfbWVtX3NpemUgfHwgYWZ1
LT5jb25maWcuc3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKSB7DQo+ICsJCXJjID0gb2N4bF9saW5r
X2FkZF9scGNfbWVtKGFmdS0+Zm4tPmxpbmssIGFmdS0+Y29uZmlnLmxwY19tZW1fb2Zmc2V0LA0K
PiArCQkJCQkgICBhZnUtPmNvbmZpZy5scGNfbWVtX3NpemUgKw0KPiArCQkJCQkgICBhZnUtPmNv
bmZpZy5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUpOw0KPiArCQlpZiAocmMpDQo+ICsJCQlnb3Rv
IGVycl9mcmVlX21taW87DQo+ICsJfQ0KPiArDQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiArZXJy
X2ZyZWVfbW1pbzoNCj4gKwl1bm1hcF9tbWlvX2FyZWFzKGFmdSk7DQo+ICAgZXJyX2ZyZWVfcGFz
aWQ6DQo+ICAgCXJlY2xhaW1fYWZ1X3Bhc2lkKGFmdSk7DQo+ICAgZXJyX2ZyZWVfYWN0YWc6DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2Mvb2N4bC9saW5rLmMgYi9kcml2ZXJzL21pc2Mvb2N4
bC9saW5rLmMNCj4gaW5kZXggNThkMTExYWZkOWY2Li4xZTAzOWNjNWViZTUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbWlzYy9vY3hsL2xpbmsuYw0KPiArKysgYi9kcml2ZXJzL21pc2Mvb2N4bC9s
aW5rLmMNCj4gQEAgLTg0LDYgKzg0LDExIEBAIHN0cnVjdCBvY3hsX2xpbmsgew0KPiAgIAlpbnQg
ZGV2Ow0KPiAgIAlhdG9taWNfdCBpcnFfYXZhaWxhYmxlOw0KPiAgIAlzdHJ1Y3Qgc3BhICpzcGE7
DQo+ICsJc3RydWN0IG11dGV4IGxwY19tZW1fbG9jazsgLyogcHJvdGVjdHMgbHBjX21lbSAmIGxw
Y19tZW1fc3ogKi8NCj4gKwl1NjQgbHBjX21lbV9zejsgLyogVG90YWwgYW1vdW50IG9mIExQQyBt
ZW1vcnkgcHJlc2VudGVkIG9uIHRoZSBsaW5rICovDQo+ICsJdTY0IGxwY19tZW07DQo+ICsJaW50
IGxwY19jb25zdW1lcnM7DQo+ICsNCj4gICAJdm9pZCAqcGxhdGZvcm1fZGF0YTsNCj4gICB9Ow0K
PiAgIHN0YXRpYyBzdHJ1Y3QgbGlzdF9oZWFkIGxpbmtzX2xpc3QgPSBMSVNUX0hFQURfSU5JVChs
aW5rc19saXN0KTsNCj4gQEAgLTM5Niw2ICs0MDEsOCBAQCBzdGF0aWMgaW50IGFsbG9jX2xpbmso
c3RydWN0IHBjaV9kZXYgKmRldiwgaW50IFBFX21hc2ssIHN0cnVjdCBvY3hsX2xpbmsgKipvdXRf
bA0KPiAgIAlpZiAocmMpDQo+ICAgCQlnb3RvIGVycl9zcGE7DQo+ICAgDQo+ICsJbXV0ZXhfaW5p
dCgmbGluay0+bHBjX21lbV9sb2NrKTsNCj4gKw0KPiAgIAkvKiBwbGF0Zm9ybSBzcGVjaWZpYyBo
b29rICovDQo+ICAgCXJjID0gcG52X29jeGxfc3BhX3NldHVwKGRldiwgbGluay0+c3BhLT5zcGFf
bWVtLCBQRV9tYXNrLA0KPiAgIAkJCQkmbGluay0+cGxhdGZvcm1fZGF0YSk7DQo+IEBAIC03MTEs
MyArNzE4LDQ5IEBAIHZvaWQgb2N4bF9saW5rX2ZyZWVfaXJxKHZvaWQgKmxpbmtfaGFuZGxlLCBp
bnQgaHdfaXJxKQ0KPiAgIAlhdG9taWNfaW5jKCZsaW5rLT5pcnFfYXZhaWxhYmxlKTsNCj4gICB9
DQo+ICAgRVhQT1JUX1NZTUJPTF9HUEwob2N4bF9saW5rX2ZyZWVfaXJxKTsNCj4gKw0KPiAraW50
IG9jeGxfbGlua19hZGRfbHBjX21lbSh2b2lkICpsaW5rX2hhbmRsZSwgdTY0IG9mZnNldCwgdTY0
IHNpemUpDQo+ICt7DQo+ICsJc3RydWN0IG9jeGxfbGluayAqbGluayA9IChzdHJ1Y3Qgb2N4bF9s
aW5rICopIGxpbmtfaGFuZGxlOw0KPiArDQo+ICsJLy8gQ2hlY2sgZm9yIG92ZXJmbG93DQo+ICsJ
aWYgKG9mZnNldCA+IChvZmZzZXQgKyBzaXplKSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsN
Cj4gKwltdXRleF9sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2spOw0KPiArCWxpbmstPmxwY19tZW1f
c3ogPSBtYXgobGluay0+bHBjX21lbV9zeiwgb2Zmc2V0ICsgc2l6ZSk7DQo+ICsNCj4gKwltdXRl
eF91bmxvY2soJmxpbmstPmxwY19tZW1fbG9jayk7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30N
Cj4gKw0KPiArdTY0IG9jeGxfbGlua19scGNfbWFwKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3Qg
cGNpX2RldiAqcGRldikNCj4gK3sNCj4gKwlzdHJ1Y3Qgb2N4bF9saW5rICpsaW5rID0gKHN0cnVj
dCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7DQo+ICsNCj4gKwltdXRleF9sb2NrKCZsaW5rLT5s
cGNfbWVtX2xvY2spOw0KPiArDQo+ICsJaWYoIWxpbmstPmxwY19tZW0pDQo+ICsJCWxpbmstPmxw
Y19tZW0gPSBwbnZfb2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAocGRldiwgbGluay0+bHBjX21lbV9z
eik7DQo+ICsNCj4gKwlpZihsaW5rLT5scGNfbWVtKQ0KPiArCQlsaW5rLT5scGNfY29uc3VtZXJz
Kys7DQo+ICsJbXV0ZXhfdW5sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2spOw0KPiArDQo+ICsJcmV0
dXJuIGxpbmstPmxwY19tZW07DQo+ICt9DQo+ICsNCj4gK3ZvaWQgb2N4bF9saW5rX2xwY19yZWxl
YXNlKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCj4gK3sNCj4gKwlz
dHJ1Y3Qgb2N4bF9saW5rICpsaW5rID0gKHN0cnVjdCBvY3hsX2xpbmsgKikgbGlua19oYW5kbGU7
DQo+ICsNCj4gKwltdXRleF9sb2NrKCZsaW5rLT5scGNfbWVtX2xvY2spOw0KPiArCVdBUk5fT04o
LS1saW5rLT5scGNfY29uc3VtZXJzIDwgMCk7DQoNCg0KSGVyZSwgd2UgYWx3YXlzIGRlY3JlbWVu
dCB0aGUgbHBjX2NvbnN1bWVycyBjb3VudC4gSG93ZXZlciwgaXQgd2FzIG9ubHkgDQppbmNyZW1l
bnRlZCBpZiB0aGUgbWFwcGluZyB3YXMgc2V0dXAgY29ycmVjdGx5IGluIG9wYWwuDQoNCldlIGNv
dWxkIGFyZ3VhYmx5IGNsYWltIHRoYXQgb2N4bF9saW5rX2xwY19yZWxlYXNlKCkgc2hvdWxkIG9u
bHkgYmUgDQpjYWxsZWQgaWYgb2N4bF9saW5rX2xwY19tYXAoKSBzdWNjZWVkZWQsIGJ1dCBpdCB3
b3VsZCBtYWtlIGVycm9yIHBhdGggDQpoYW5kbGluZyBlYXNpZXIgaWYgd2Ugb25seSBkZWNyZW1l
bnQgdGhlIGxwY19jb25zdW1lcnMgY291bnQgaWYgDQpsaW5rLT5scGNfbWVtIGlzIHNldC4gU28g
dGhhdCB3ZSBjYW4ganVzdCBjYWxsIG9jeGxfbGlua19scGNfcmVsZWFzZSgpIA0KaW4gZXJyb3Ig
cGF0aHMgd2l0aG91dCBoYXZpbmcgdG8gd29ycnkgYWJvdXQgdHJpZ2dlcmluZyB0aGUgV0FSTl9P
TiBtZXNzYWdlLg0KDQogICBGcmVkDQoNCg0KDQo+ICsJaWYgKGxpbmstPmxwY19jb25zdW1lcnMg
PT0gMCkgew0KPiArCQlwbnZfb2N4bF9wbGF0Zm9ybV9scGNfcmVsZWFzZShwZGV2KTsNCj4gKwkJ
bGluay0+bHBjX21lbSA9IDA7DQo+ICsJfQ0KPiArDQo+ICsJbXV0ZXhfdW5sb2NrKCZsaW5rLT5s
cGNfbWVtX2xvY2spOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL29jeGwvb2N4
bF9pbnRlcm5hbC5oIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRlcm5hbC5oDQo+IGluZGV4
IDE5OGU0ZTRiYzUxZC4uZDBjOGM0ODM4ZjQyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2Mv
b2N4bC9vY3hsX2ludGVybmFsLmgNCj4gKysrIGIvZHJpdmVycy9taXNjL29jeGwvb2N4bF9pbnRl
cm5hbC5oDQo+IEBAIC0xNDIsNCArMTQyLDM3IEBAIGludCBvY3hsX2lycV9vZmZzZXRfdG9faWQo
c3RydWN0IG9jeGxfY29udGV4dCAqY3R4LCB1NjQgb2Zmc2V0KTsNCj4gICB1NjQgb2N4bF9pcnFf
aWRfdG9fb2Zmc2V0KHN0cnVjdCBvY3hsX2NvbnRleHQgKmN0eCwgaW50IGlycV9pZCk7DQo+ICAg
dm9pZCBvY3hsX2FmdV9pcnFfZnJlZV9hbGwoc3RydWN0IG9jeGxfY29udGV4dCAqY3R4KTsNCj4g
ICANCj4gKy8qKg0KPiArICogb2N4bF9saW5rX2FkZF9scGNfbWVtKCkgLSBJbmNyZW1lbnQgdGhl
IGFtb3VudCBvZiBtZW1vcnkgcmVxdWlyZWQgYnkgYW4gT3BlbkNBUEkgbGluaw0KPiArICoNCj4g
KyAqIEBsaW5rX2hhbmRsZTogVGhlIE9wZW5DQVBJIGxpbmsgaGFuZGxlDQo+ICsgKiBAb2Zmc2V0
OiBUaGUgb2Zmc2V0IG9mIHRoZSBtZW1vcnkgdG8gYWRkDQo+ICsgKiBAc2l6ZTogVGhlIGFtb3Vu
dCBvZiBtZW1vcnkgdG8gaW5jcmVtZW50IGJ5DQo+ICsgKg0KPiArICogUmV0dXJucyAwIG9uIHN1
Y2Nlc3MsIG5lZ2F0aXZlIG9uIG92ZXJmbG93DQo+ICsgKi8NCj4gK2ludCBvY3hsX2xpbmtfYWRk
X2xwY19tZW0odm9pZCAqbGlua19oYW5kbGUsIHU2NCBvZmZzZXQsIHU2NCBzaXplKTsNCj4gKw0K
PiArLyoqDQo+ICsgKiBvY3hsX2xpbmtfbHBjX21hcCgpIC0gTWFwIHRoZSBMUEMgbWVtb3J5IGZv
ciBhbiBPcGVuQ0FQSSBkZXZpY2UNCj4gKyAqIFNpbmNlIExQQyBtZW1vcnkgYmVsb25ncyB0byBh
IGxpbmssIHRoZSB3aG9sZSBMUEMgbWVtb3J5IGF2YWlsYWJsZQ0KPiArICogb24gdGhlIGxpbmsg
bXVzdCBiZSBtYXBwZWQgaW4gb3JkZXIgdG8gbWFrZSBpdCBhY2Nlc3NpYmxlIHRvIGEgZGV2aWNl
Lg0KPiArICogQGxpbmtfaGFuZGxlOiBUaGUgT3BlbkNBUEkgbGluayBoYW5kbGUNCj4gKyAqIEBw
ZGV2OiBBIGRldmljZSB0aGF0IGlzIG9uIHRoZSBsaW5rDQo+ICsgKg0KPiArICogUmV0dXJucyB0
aGUgYWRkcmVzcyBvZiB0aGUgbWFwcGVkIExQQyBtZW1vcnksIG9yIDAgb24gZXJyb3INCj4gKyAq
Lw0KPiArdTY0IG9jeGxfbGlua19scGNfbWFwKHZvaWQgKmxpbmtfaGFuZGxlLCBzdHJ1Y3QgcGNp
X2RldiAqcGRldik7DQo+ICsNCj4gKy8qKg0KPiArICogb2N4bF9saW5rX2xwY19yZWxlYXNlKCkg
LSBSZWxlYXNlIHRoZSBMUEMgbWVtb3J5IGRldmljZSBmb3IgYW4gT3BlbkNBUEkgZGV2aWNlDQo+
ICsgKg0KPiArICogT2ZmbGluZXMgTFBDIG1lbW9yeSBvbiBhbiBPcGVuQ0FQSSBsaW5rIGZvciBh
IGRldmljZS4gSWYgdGhpcyBpcyB0aGUNCj4gKyAqIGxhc3QgZGV2aWNlIG9uIHRoZSBsaW5rIHRv
IHJlbGVhc2UgdGhlIG1lbW9yeSwgdW5tYXAgaXQgZnJvbSB0aGUgbGluay4NCj4gKyAqDQo+ICsg
KiBAbGlua19oYW5kbGU6IFRoZSBPcGVuQ0FQSSBsaW5rIGhhbmRsZQ0KPiArICogQHBkZXY6IEEg
ZGV2aWNlIHRoYXQgaXMgb24gdGhlIGxpbmsNCj4gKyAqLw0KPiArdm9pZCBvY3hsX2xpbmtfbHBj
X3JlbGVhc2Uodm9pZCAqbGlua19oYW5kbGUsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KTsNCj4gKw0K
PiAgICNlbmRpZiAvKiBfT0NYTF9JTlRFUk5BTF9IXyAqLw0KPiANCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3Qg
LS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWls
IHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
