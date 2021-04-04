Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8543538FB
	for <lists+linux-nvdimm@lfdr.de>; Sun,  4 Apr 2021 19:06:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B47CA100EC1F5;
	Sun,  4 Apr 2021 10:05:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN> 
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B1081100EC1D9
	for <linux-nvdimm@lists.01.org>; Sun,  4 Apr 2021 10:05:54 -0700 (PDT)
Received: from localhost (mailhub1-int [192.168.12.234])
	by localhost (Postfix) with ESMTP id 4FD0Y82fMyz9txtD;
	Sun,  4 Apr 2021 19:05:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
	with ESMTP id x2rDN5V69KRg; Sun,  4 Apr 2021 19:05:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4FD0Y80xvSz9txtB;
	Sun,  4 Apr 2021 19:05:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AB7A08B78E;
	Sun,  4 Apr 2021 19:05:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SL43VzMhlW0d; Sun,  4 Apr 2021 19:05:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 15B408B76A;
	Sun,  4 Apr 2021 19:05:51 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/mm: Add cond_resched() while removing hpte
 mappings
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
References: <20210404163148.321346-1-vaibhav@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cb4a3059-0f5f-d904-7da4-065f2ec9bf0a@csgroup.eu>
Date: Sun, 4 Apr 2021 19:05:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210404163148.321346-1-vaibhav@linux.ibm.com>
Content-Language: fr
Message-ID-Hash: ZCCCXZYQX4MO4JFDFL5T4D7BGMV3OVWV
X-Message-ID-Hash: ZCCCXZYQX4MO4JFDFL5T4D7BGMV3OVWV
X-MailFrom: christophe.leroy@csgroup.eu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZCCCXZYQX4MO4JFDFL5T4D7BGMV3OVWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCkxlIDA0LzA0LzIwMjEgw6AgMTg6MzEsIFZhaWJoYXYgSmFpbiBhIMOpY3JpdMKgOg0KPiBX
aGlsZSByZW1vdmluZyBsYXJnZSBudW1iZXIgb2YgbWFwcGluZ3MgZnJvbSBoYXNoIHBhZ2UgdGFi
bGVzIGZvcg0KPiBsYXJnZSBtZW1vcnkgc3lzdGVtcyBhcyBzb2Z0LWxvY2t1cCBpcyByZXBvcnRl
ZCBiZWNhdXNlIG9mIHRoZSB0aW1lDQo+IHNwZW50IGluc2lkZSBodGFwX3JlbW92ZV9tYXBwaW5n
KCkgbGlrZSBvbmUgYmVsb3c6DQo+IA0KPiAgIHdhdGNoZG9nOiBCVUc6IHNvZnQgbG9ja3VwIC0g
Q1BVIzggc3R1Y2sgZm9yIDIzcyENCj4gICA8c25pcD4NCj4gICBOSVAgcGxwYXJfaGNhbGwrMHgz
OC8weDU4DQo+ICAgTFIgIHBTZXJpZXNfbHBhcl9ocHRlX2ludmFsaWRhdGUrMHg2OC8weGIwDQo+
ICAgQ2FsbCBUcmFjZToNCj4gICAgMHgxZmZmZmZmZmZmZmYwMDAgKHVucmVsaWFibGUpDQo+ICAg
IHBTZXJpZXNfbHBhcl9ocHRlX3JlbW92ZWJvbHRlZCsweDljLzB4MjMwDQo+ICAgIGhhc2hfX3Jl
bW92ZV9zZWN0aW9uX21hcHBpbmcrMHhlYy8weDFjMA0KPiAgICByZW1vdmVfc2VjdGlvbl9tYXBw
aW5nKzB4MjgvMHgzYw0KPiAgICBhcmNoX3JlbW92ZV9tZW1vcnkrMHhmYy8weDE1MA0KPiAgICBk
ZXZtX21lbXJlbWFwX3BhZ2VzX3JlbGVhc2UrMHgxODAvMHgyZjANCj4gICAgZGV2bV9hY3Rpb25f
cmVsZWFzZSsweDMwLzB4NTANCj4gICAgcmVsZWFzZV9ub2RlcysweDI4Yy8weDMwMA0KPiAgICBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHgxNmMvMHgyODANCj4gICAgdW5iaW5kX3N0
b3JlKzB4MTI0LzB4MTcwDQo+ICAgIGRydl9hdHRyX3N0b3JlKzB4NDQvMHg2MA0KPiAgICBzeXNm
c19rZl93cml0ZSsweDY0LzB4OTANCj4gICAga2VybmZzX2ZvcF93cml0ZSsweDFiMC8weDI5MA0K
PiAgICBfX3Zmc193cml0ZSsweDNjLzB4NzANCj4gICAgdmZzX3dyaXRlKzB4ZDQvMHgyNzANCj4g
ICAga3N5c193cml0ZSsweGRjLzB4MTMwDQo+ICAgIHN5c3RlbV9jYWxsKzB4NWMvMHg3MA0KPiAN
Cj4gRml4IHRoaXMgYnkgYWRkaW5nIGEgY29uZF9yZXNjaGVkKCkgdG8gdGhlIGxvb3AgaW4NCj4g
aHRhcF9yZW1vdmVfbWFwcGluZygpIHRoYXQgaXNzdWVzIGhjYWxsIHRvIHJlbW92ZSBocHRlIG1h
cHBpbmcuIFRoZQ0KPiBjYWxsIHRvIGNvbmRfcmVzY2hlZCgpIGlzIGlzc3VlZCBldmVyeSBIWiBq
aWZmaWVzIHdoaWNoIHNob3VsZCBwcmV2ZW50DQo+IHRoZSBzb2Z0LWxvY2t1cCBmcm9tIGJlaW5n
IHJlcG9ydGVkLg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBBbmVlc2ggS3VtYXIgSy5WIDxhbmVlc2gu
a3VtYXJAbGludXguaWJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVmFpYmhhdiBKYWluIDx2YWli
aGF2QGxpbnV4LmlibS5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gDQo+IC0tLQ0KPiBDaGFuZ2Vsb2c6DQo+IA0K
PiB2MjogSXNzdWUgY29uZF9yZXNjaGVkKCkgZXZlcnkgSFogamlmZmllcyBpbnN0ZWFkIG9mIGVh
Y2ggaXRlcmF0aW9uIG9mDQo+ICAgICAgdGhlIGxvb3AuIFsgQ2hyaXN0b3BoZSBMZXJveSBdDQo+
IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9oYXNoX3V0aWxzLmMgfCAxMyArKysr
KysrKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvaGFzaF91
dGlscy5jIGIvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L2hhc2hfdXRpbHMuYw0KPiBpbmRleCA1
ODFiMjBhMmZlYWYuLjI4NmU3ZThjYjkxOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21t
L2Jvb2szczY0L2hhc2hfdXRpbHMuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQv
aGFzaF91dGlscy5jDQo+IEBAIC0zMzgsNyArMzM4LDcgQEAgaW50IGh0YWJfYm9sdF9tYXBwaW5n
KHVuc2lnbmVkIGxvbmcgdnN0YXJ0LCB1bnNpZ25lZCBsb25nIHZlbmQsDQo+ICAgaW50IGh0YWJf
cmVtb3ZlX21hcHBpbmcodW5zaWduZWQgbG9uZyB2c3RhcnQsIHVuc2lnbmVkIGxvbmcgdmVuZCwN
Cj4gICAJCSAgICAgIGludCBwc2l6ZSwgaW50IHNzaXplKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBs
b25nIHZhZGRyOw0KPiArCXVuc2lnbmVkIGxvbmcgdmFkZHIsIHRpbWVfbGltaXQ7DQo+ICAgCXVu
c2lnbmVkIGludCBzdGVwLCBzaGlmdDsNCj4gICAJaW50IHJjOw0KPiAgIAlpbnQgcmV0ID0gMDsN
Cj4gQEAgLTM1MSw4ICszNTEsMTkgQEAgaW50IGh0YWJfcmVtb3ZlX21hcHBpbmcodW5zaWduZWQg
bG9uZyB2c3RhcnQsIHVuc2lnbmVkIGxvbmcgdmVuZCwNCj4gICANCj4gICAJLyogVW5tYXAgdGhl
IGZ1bGwgcmFuZ2Ugc3BlY2lmaWNpZWQgKi8NCj4gICAJdmFkZHIgPSBBTElHTl9ET1dOKHZzdGFy
dCwgc3RlcCk7DQo+ICsJdGltZV9saW1pdCA9IGppZmZpZXMgKyBIWjsNCj4gKw0KPiAgIAlmb3Ig
KDt2YWRkciA8IHZlbmQ7IHZhZGRyICs9IHN0ZXApIHsNCj4gICAJCXJjID0gbW11X2hhc2hfb3Bz
LmhwdGVfcmVtb3ZlYm9sdGVkKHZhZGRyLCBwc2l6ZSwgc3NpemUpOw0KPiArDQo+ICsJCS8qDQo+
ICsJCSAqIEZvciBsYXJnZSBudW1iZXIgb2YgbWFwcGluZ3MgaW50cm9kdWNlIGEgY29uZF9yZXNj
aGVkKCkNCj4gKwkJICogdG8gcHJldmVudCBzb2Z0bG9ja3VwIHdhcm5pbmdzLg0KPiArCQkgKi8N
Cj4gKwkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZV9saW1pdCkpIHsNCj4gKwkJCWNvbmRf
cmVzY2hlZCgpOw0KPiArCQkJdGltZV9saW1pdCA9IGppZmZpZXMgKyBIWjsNCj4gKwkJfQ0KPiAg
IAkJaWYgKHJjID09IC1FTk9FTlQpIHsNCj4gICAJCQlyZXQgPSAtRU5PRU5UOw0KPiAgIAkJCWNv
bnRpbnVlOw0KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
