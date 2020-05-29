Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EF1E798D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 29 May 2020 11:37:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B361912313CFA;
	Fri, 29 May 2020 02:33:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3F1A21230F47F
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 02:33:20 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04T9WvOC009538;
	Fri, 29 May 2020 05:37:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1bu4v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 05:37:39 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04T9aFad024099;
	Fri, 29 May 2020 05:37:38 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1bu4tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 05:37:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04T9ZbDf019231;
	Fri, 29 May 2020 09:37:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf93ns9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 09:37:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04T9aKgi63504852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 09:36:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 243A611C058;
	Fri, 29 May 2020 09:37:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4912F11C05C;
	Fri, 29 May 2020 09:37:32 +0000 (GMT)
Received: from [9.85.84.128] (unknown [9.85.84.128])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2020 09:37:32 +0000 (GMT)
Subject: Re: [RFC PATCH 1/2] libnvdimm: Add prctl control for disabling
 synchronous fault support.
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, jack@suse.de
References: <20200529054141.156384-1-aneesh.kumar@linux.ibm.com>
 <20200529093310.GL25173@kitsune.suse.cz>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <6183cf4a-d134-99e5-936e-ef35f530c2ec@linux.ibm.com>
Date: Fri, 29 May 2020 15:07:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529093310.GL25173@kitsune.suse.cz>
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_02:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 clxscore=1011 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290075
Message-ID-Hash: R25KFAUWDV5QGJ3TVGIXXS4NRXG3UCPR
X-Message-ID-Hash: R25KFAUWDV5QGJ3TVGIXXS4NRXG3UCPR
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R25KFAUWDV5QGJ3TVGIXXS4NRXG3UCPR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGksDQoNCg0KVGhhbmtzIE1pY2hhbC4gSSBhbHNvIG1pc3NlZCBKZWZmIGluIHRoaXMgZW1haWwg
dGhyZWFkLg0KDQotYW5lZXNoDQoNCk9uIDUvMjkvMjAgMzowMyBQTSwgTWljaGFsIFN1Y2jDoW5l
ayB3cm90ZToNCj4gQWRkaW5nIEphbg0KPiANCj4gT24gRnJpLCBNYXkgMjksIDIwMjAgYXQgMTE6
MTE6MzlBTSArMDUzMCwgQW5lZXNoIEt1bWFyIEsuViB3cm90ZToNCj4+IFdpdGggUE9XRVIxMCwg
YXJjaGl0ZWN0dXJlIGlzIGFkZGluZyBuZXcgcG1lbSBmbHVzaCBhbmQgc3luYyBpbnN0cnVjdGlv
bnMuDQo+PiBUaGUga2VybmVsIHNob3VsZCBwcmV2ZW50IHRoZSB1c2FnZSBvZiBNQVBfU1lOQyBp
ZiBhcHBsaWNhdGlvbnMgYXJlIG5vdCB1c2luZw0KPj4gdGhlIG5ldyBpbnN0cnVjdGlvbnMgb24g
bmV3ZXIgaGFyZHdhcmUuDQo+Pg0KPj4gVGhpcyBwYXRjaCBhZGRzIGEgcHJjdGwgb3B0aW9uIE1B
UF9TWU5DX0VOQUJMRSB0aGF0IGNhbiBiZSB1c2VkIHRvIGVuYWJsZQ0KPj4gdGhlIHVzYWdlIG9m
IE1BUF9TWU5DLiBUaGUga2VybmVsIGNvbmZpZyBvcHRpb24gaXMgYWRkZWQgdG8gYWxsb3cgdGhl
IHVzZXINCj4+IHRvIGNvbnRyb2wgd2hldGhlciBNQVBfU1lOQyBzaG91bGQgYmUgZW5hYmxlZCBi
eSBkZWZhdWx0IG9yIG5vdC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmVlc2ggS3VtYXIgSy5W
IDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2xpbnV4
L3NjaGVkL2NvcmVkdW1wLmggfCAxMyArKysrKysrKysrLS0tDQo+PiAgIGluY2x1ZGUvdWFwaS9s
aW51eC9wcmN0bC5oICAgICB8ICAzICsrKw0KPj4gICBrZXJuZWwvZm9yay5jICAgICAgICAgICAg
ICAgICAgfCAgOCArKysrKysrLQ0KPj4gICBrZXJuZWwvc3lzLmMgICAgICAgICAgICAgICAgICAg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4+ICAgbW0vS2NvbmZpZyAgICAgICAgICAgICAgICAg
ICAgIHwgIDMgKysrDQo+PiAgIG1tL21tYXAuYyAgICAgICAgICAgICAgICAgICAgICB8ICA0ICsr
KysNCj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL2NvcmVkdW1wLmggYi9p
bmNsdWRlL2xpbnV4L3NjaGVkL2NvcmVkdW1wLmgNCj4+IGluZGV4IGVjZGM2NTQyMDcwZi4uOWJh
NmIzZDVmOTkxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC9jb3JlZHVtcC5o
DQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkL2NvcmVkdW1wLmgNCj4+IEBAIC03Miw5ICs3
MiwxNiBAQCBzdGF0aWMgaW5saW5lIGludCBnZXRfZHVtcGFibGUoc3RydWN0IG1tX3N0cnVjdCAq
bW0pDQo+PiAgICNkZWZpbmUgTU1GX0RJU0FCTEVfVEhQCQkyNAkvKiBkaXNhYmxlIFRIUCBmb3Ig
YWxsIFZNQXMgKi8NCj4+ICAgI2RlZmluZSBNTUZfT09NX1ZJQ1RJTQkJMjUJLyogbW0gaXMgdGhl
IG9vbSB2aWN0aW0gKi8NCj4+ICAgI2RlZmluZSBNTUZfT09NX1JFQVBfUVVFVUVECTI2CS8qIG1t
IHdhcyBxdWV1ZWQgZm9yIG9vbV9yZWFwZXIgKi8NCj4+IC0jZGVmaW5lIE1NRl9ESVNBQkxFX1RI
UF9NQVNLCSgxIDw8IE1NRl9ESVNBQkxFX1RIUCkNCj4+ICsjZGVmaW5lIE1NRl9ESVNBQkxFX01B
UF9TWU5DCTI3CS8qIGRpc2FibGUgVEhQIGZvciBhbGwgVk1BcyAqLw0KPj4gKyNkZWZpbmUgTU1G
X0RJU0FCTEVfVEhQX01BU0sJCSgxIDw8IE1NRl9ESVNBQkxFX1RIUCkNCj4+ICsjZGVmaW5lIE1N
Rl9ESVNBQkxFX01BUF9TWU5DX01BU0sJKDEgPDwgTU1GX0RJU0FCTEVfTUFQX1NZTkMpDQo+PiAg
IA0KPj4gLSNkZWZpbmUgTU1GX0lOSVRfTUFTSwkJKE1NRl9EVU1QQUJMRV9NQVNLIHwgTU1GX0RV
TVBfRklMVEVSX01BU0sgfFwNCj4+IC0JCQkJIE1NRl9ESVNBQkxFX1RIUF9NQVNLKQ0KPj4gKyNk
ZWZpbmUgTU1GX0lOSVRfTUFTSwkJKE1NRl9EVU1QQUJMRV9NQVNLIHwgTU1GX0RVTVBfRklMVEVS
X01BU0sgfCBcDQo+PiArCQkJTU1GX0RJU0FCTEVfVEhQX01BU0sgfCBNTUZfRElTQUJMRV9NQVBf
U1lOQ19NQVNLKQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBtYXBfc3luY19lbmFibGVk
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPj4gK3sNCj4+ICsJcmV0dXJuICEobW0tPmZsYWdzICYg
TU1GX0RJU0FCTEVfTUFQX1NZTkNfTUFTSyk7DQo+PiArfQ0KPj4gICANCj4+ICAgI2VuZGlmIC8q
IF9MSU5VWF9TQ0hFRF9DT1JFRFVNUF9IICovDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBp
L2xpbnV4L3ByY3RsLmggYi9pbmNsdWRlL3VhcGkvbGludXgvcHJjdGwuaA0KPj4gaW5kZXggMDdi
NGY4MTMxZTM2Li5lZTRjZGUzMmQ1Y2YgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvcHJjdGwuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ByY3RsLmgNCj4+IEBAIC0y
MzgsNCArMjM4LDcgQEAgc3RydWN0IHByY3RsX21tX21hcCB7DQo+PiAgICNkZWZpbmUgUFJfU0VU
X0lPX0ZMVVNIRVIJCTU3DQo+PiAgICNkZWZpbmUgUFJfR0VUX0lPX0ZMVVNIRVIJCTU4DQo+PiAg
IA0KPj4gKyNkZWZpbmUgUFJfU0VUX01BUF9TWU5DX0VOQUJMRQkJNTkNCj4+ICsjZGVmaW5lIFBS
X0dFVF9NQVBfU1lOQ19FTkFCTEUJCTYwDQo+PiArDQo+PiAgICNlbmRpZiAvKiBfTElOVVhfUFJD
VExfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jDQo+
PiBpbmRleCA4YzcwMGY4ODFkOTIuLmQ1YTlhMzYzZTgxZSAxMDA2NDQNCj4+IC0tLSBhL2tlcm5l
bC9mb3JrLmMNCj4+ICsrKyBiL2tlcm5lbC9mb3JrLmMNCj4+IEBAIC05NjMsNiArOTYzLDEyIEBA
IF9fY2FjaGVsaW5lX2FsaWduZWRfaW5fc21wIERFRklORV9TUElOTE9DSyhtbWxpc3RfbG9jayk7
DQo+PiAgIA0KPj4gICBzdGF0aWMgdW5zaWduZWQgbG9uZyBkZWZhdWx0X2R1bXBfZmlsdGVyID0g
TU1GX0RVTVBfRklMVEVSX0RFRkFVTFQ7DQo+PiAgIA0KPj4gKyNpZmRlZiBDT05GSUdfQVJDSF9N
QVBfU1lOQ19ESVNBQkxFDQo+PiArdW5zaWduZWQgbG9uZyBkZWZhdWx0X21hcF9zeW5jX21hc2sg
PSBNTUZfRElTQUJMRV9NQVBfU1lOQ19NQVNLOw0KPj4gKyNlbHNlDQo+PiArdW5zaWduZWQgbG9u
ZyBkZWZhdWx0X21hcF9zeW5jX21hc2sgPSAwOw0KPj4gKyNlbmRpZg0KPj4gKw0KPj4gICBzdGF0
aWMgaW50IF9faW5pdCBjb3JlZHVtcF9maWx0ZXJfc2V0dXAoY2hhciAqcykNCj4+ICAgew0KPj4g
ICAJZGVmYXVsdF9kdW1wX2ZpbHRlciA9DQo+PiBAQCAtMTAzOSw3ICsxMDQ1LDcgQEAgc3RhdGlj
IHN0cnVjdCBtbV9zdHJ1Y3QgKm1tX2luaXQoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCB0
YXNrX3N0cnVjdCAqcCwNCj4+ICAgCQltbS0+ZmxhZ3MgPSBjdXJyZW50LT5tbS0+ZmxhZ3MgJiBN
TUZfSU5JVF9NQVNLOw0KPj4gICAJCW1tLT5kZWZfZmxhZ3MgPSBjdXJyZW50LT5tbS0+ZGVmX2Zs
YWdzICYgVk1fSU5JVF9ERUZfTUFTSzsNCj4+ICAgCX0gZWxzZSB7DQo+PiAtCQltbS0+ZmxhZ3Mg
PSBkZWZhdWx0X2R1bXBfZmlsdGVyOw0KPj4gKwkJbW0tPmZsYWdzID0gZGVmYXVsdF9kdW1wX2Zp
bHRlciB8IGRlZmF1bHRfbWFwX3N5bmNfbWFzazsNCj4+ICAgCQltbS0+ZGVmX2ZsYWdzID0gMDsN
Cj4+ICAgCX0NCj4+ICAgDQo+PiBkaWZmIC0tZ2l0IGEva2VybmVsL3N5cy5jIGIva2VybmVsL3N5
cy5jDQo+PiBpbmRleCBkMzI1ZjNhYjYyNGEuLmY2MTI3Y2Y0MTI4YiAxMDA2NDQNCj4+IC0tLSBh
L2tlcm5lbC9zeXMuYw0KPj4gKysrIGIva2VybmVsL3N5cy5jDQo+PiBAQCAtMjQ1MCw2ICsyNDUw
LDI0IEBAIFNZU0NBTExfREVGSU5FNShwcmN0bCwgaW50LCBvcHRpb24sIHVuc2lnbmVkIGxvbmcs
IGFyZzIsIHVuc2lnbmVkIGxvbmcsIGFyZzMsDQo+PiAgIAkJCWNsZWFyX2JpdChNTUZfRElTQUJM
RV9USFAsICZtZS0+bW0tPmZsYWdzKTsNCj4+ICAgCQl1cF93cml0ZSgmbWUtPm1tLT5tbWFwX3Nl
bSk7DQo+PiAgIAkJYnJlYWs7DQo+PiArDQo+PiArCWNhc2UgUFJfR0VUX01BUF9TWU5DX0VOQUJM
RToNCj4+ICsJCWlmIChhcmcyIHx8IGFyZzMgfHwgYXJnNCB8fCBhcmc1KQ0KPj4gKwkJCXJldHVy
biAtRUlOVkFMOw0KPj4gKwkJZXJyb3IgPSAhdGVzdF9iaXQoTU1GX0RJU0FCTEVfTUFQX1NZTkMs
ICZtZS0+bW0tPmZsYWdzKTsNCj4+ICsJCWJyZWFrOw0KPj4gKwljYXNlIFBSX1NFVF9NQVBfU1lO
Q19FTkFCTEU6DQo+PiArCQlpZiAoYXJnMyB8fCBhcmc0IHx8IGFyZzUpDQo+PiArCQkJcmV0dXJu
IC1FSU5WQUw7DQo+PiArCQlpZiAoZG93bl93cml0ZV9raWxsYWJsZSgmbWUtPm1tLT5tbWFwX3Nl
bSkpDQo+PiArCQkJcmV0dXJuIC1FSU5UUjsNCj4+ICsJCWlmIChhcmcyKQ0KPj4gKwkJCWNsZWFy
X2JpdChNTUZfRElTQUJMRV9NQVBfU1lOQywgJm1lLT5tbS0+ZmxhZ3MpOw0KPj4gKwkJZWxzZQ0K
Pj4gKwkJCXNldF9iaXQoTU1GX0RJU0FCTEVfTUFQX1NZTkMsICZtZS0+bW0tPmZsYWdzKTsNCj4+
ICsJCXVwX3dyaXRlKCZtZS0+bW0tPm1tYXBfc2VtKTsNCj4+ICsJCWJyZWFrOw0KPj4gKw0KPj4g
ICAJY2FzZSBQUl9NUFhfRU5BQkxFX01BTkFHRU1FTlQ6DQo+PiAgIAljYXNlIFBSX01QWF9ESVNB
QkxFX01BTkFHRU1FTlQ6DQo+PiAgIAkJLyogTm8gbG9uZ2VyIGltcGxlbWVudGVkOiAqLw0KPj4g
ZGlmZiAtLWdpdCBhL21tL0tjb25maWcgYi9tbS9LY29uZmlnDQo+PiBpbmRleCBjMWFjYzM0YzFj
MzUuLjM4ZmQ3Y2ZiZmNhOCAxMDA2NDQNCj4+IC0tLSBhL21tL0tjb25maWcNCj4+ICsrKyBiL21t
L0tjb25maWcNCj4+IEBAIC04NjcsNCArODY3LDcgQEAgY29uZmlnIEFSQ0hfSEFTX0hVR0VQRA0K
Pj4gICBjb25maWcgTUFQUElOR19ESVJUWV9IRUxQRVJTDQo+PiAgICAgICAgICAgYm9vbA0KPj4g
ICANCj4+ICtjb25maWcgQVJDSF9NQVBfU1lOQ19ESVNBQkxFDQo+PiArCWJvb2wNCj4+ICsNCj4+
ICAgZW5kbWVudQ0KPj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPj4gaW5k
ZXggZjYwOWU5ZWM0YTI1Li42MTNlNTg5NGYxNzggMTAwNjQ0DQo+PiAtLS0gYS9tbS9tbWFwLmMN
Cj4+ICsrKyBiL21tL21tYXAuYw0KPj4gQEAgLTE0NjQsNiArMTQ2NCwxMCBAQCB1bnNpZ25lZCBs
b25nIGRvX21tYXAoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4+ICAg
CQljYXNlIE1BUF9TSEFSRURfVkFMSURBVEU6DQo+PiAgIAkJCWlmIChmbGFncyAmIH5mbGFnc19t
YXNrKQ0KPj4gICAJCQkJcmV0dXJuIC1FT1BOT1RTVVBQOw0KPj4gKw0KPj4gKwkJCWlmICgoZmxh
Z3MgJiBNQVBfU1lOQykgICYmICFtYXBfc3luY19lbmFibGVkKG1tKSkNCj4+ICsJCQkJcmV0dXJu
IC1FT1BOT1RTVVBQOw0KPj4gKw0KPj4gICAJCQlpZiAocHJvdCAmIFBST1RfV1JJVEUpIHsNCj4+
ICAgCQkJCWlmICghKGZpbGUtPmZfbW9kZSAmIEZNT0RFX1dSSVRFKSkNCj4+ICAgCQkJCQlyZXR1
cm4gLUVBQ0NFUzsNCj4+IC0tIA0KPj4gMi4yNi4yDQo+Pg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
