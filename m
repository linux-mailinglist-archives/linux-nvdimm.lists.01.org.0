Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16C51816A4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Mar 2020 12:20:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2336010FC36E9;
	Wed, 11 Mar 2020 04:21:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F08610FC36E6
	for <linux-nvdimm@lists.01.org>; Wed, 11 Mar 2020 04:21:12 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B7121AED2;
	Wed, 11 Mar 2020 11:20:18 +0000 (UTC)
Subject: Re: [PATCH v3] block: refactor duplicated macros
To: Matteo Croce <mcroce@redhat.com>
References: <20200311002254.121365-1-mcroce@redhat.com>
From: Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <89925759-cbc1-e8f0-b9b3-23fd062ebbcd@suse.de>
Date: Wed, 11 Mar 2020 19:20:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311002254.121365-1-mcroce@redhat.com>
Content-Language: en-US
Message-ID-Hash: FVEN6AFY7A4G72SO6OBDY2KQSG6XFZI6
X-Message-ID-Hash: FVEN6AFY7A4G72SO6OBDY2KQSG6XFZI6
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, "James E.J. Bottomley" <jejb@linux.ibm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Anna Schumaker <anna.schumaker@netapp.com>, Song Liu <song@kernel.org>, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FVEN6AFY7A4G72SO6OBDY2KQSG6XFZI6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjAyMC8zLzExIDg6MjIg5LiK5Y2ILCBNYXR0ZW8gQ3JvY2Ugd3JvdGU6DQo+IFRoZSBtYWNy
b3MgUEFHRV9TRUNUT1JTLCBQQUdFX1NFQ1RPUlNfU0hJRlQgYW5kIFNFQ1RPUl9NQVNLIGFyZSBk
ZWZpbmVkDQo+IHNldmVyYWwgdGltZXMgaW4gZGlmZmVyZW50IGZsYXZvdXJzIGFjcm9zcyB0aGUg
d2hvbGUgdHJlZS4NCj4gRGVmaW5lIHRoZW0ganVzdCBvbmNlIGluIGEgY29tbW9uIGhlYWRlci4N
Cj4gDQo+IFdoaWxlIGF0IGl0LCByZXBsYWNlIHJlcGxhY2UgIlBBR0VfU0hJRlQgLSA5IiB3aXRo
ICJQQUdFX1NFQ1RPUlNfU0hJRlQiIHRvbw0KPiBhbmQgcmVuYW1lIFNFQ1RPUl9NQVNLIHRvIFBB
R0VfU0VDVE9SU19NQVNLLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGVvIENyb2NlIDxtY3Jv
Y2VAcmVkaGF0LmNvbT4NCg0KSGkgTWF0dGVvLA0KDQpGb3IgdGhlIGJjYWNoZSBwYXJ0LCBpdCBs
b29rcyBnb29kIHRvIG1lLg0KDQpBY2tlZC1ieTogQ29seSBMaSA8Y29seWxpQHN1c2UuZGU+DQoN
Cj4gLS0tDQo+IHYzOg0KPiBBcyBHdW9xaW5nIEppYW5nIHN1Z2dlc3RlZCwgcmVwbGFjZSAiUEFH
RV9TSElGVCAtIDkiIHdpdGggIlBBR0VfU0VDVE9SU19TSElGVCINCj4gDQo+IHYyOg0KPiBBcyBE
YW4gV2lsbGlhbXMgc3VnZ2VzdGVkOg0KPiANCj4gICNkZWZpbmUgUEFHRV9TRUNUT1JTX01BU0sg
ICAgICAgICAgICAofihQQUdFX1NFQ1RPUlMgLSAxKSkNCj4gDQo+ICBibG9jay9ibGstbGliLmMg
ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBibG9jay9ibGstc2V0dGluZ3MuYyAgICAgICAg
ICAgICB8ICA0ICsrLS0NCj4gIGJsb2NrL3BhcnRpdGlvbi1nZW5lcmljLmMgICAgICAgIHwgIDIg
Ky0NCj4gIGRyaXZlcnMvYmxvY2svYnJkLmMgICAgICAgICAgICAgIHwgIDMgLS0tDQo+ICBkcml2
ZXJzL2Jsb2NrL251bGxfYmxrX21haW4uYyAgICB8IDE0ICsrKysrLS0tLS0tLS0tDQo+ICBkcml2
ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuYyAgICB8ICA4ICsrKystLS0tDQo+ICBkcml2ZXJzL2Js
b2NrL3pyYW0venJhbV9kcnYuaCAgICB8ICAyIC0tDQo+ICBkcml2ZXJzL2RheC9zdXBlci5jICAg
ICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL21kL2JjYWNoZS91dGlsLmggICAgICAgICB8
ICAyIC0tDQo+ICBkcml2ZXJzL21kL2RtLWJ1ZmlvLmMgICAgICAgICAgICB8ICA2ICsrKy0tLQ0K
PiAgZHJpdmVycy9tZC9kbS1pbnRlZ3JpdHkuYyAgICAgICAgfCAxMCArKysrKy0tLS0tDQo+ICBk
cml2ZXJzL21kL2RtLXRhYmxlLmMgICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL21kL21k
LmMgICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gIGRyaXZlcnMvbWQvcmFpZDEuYyAgICAg
ICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvbWQvcmFpZDEwLmMgICAgICAgICAgICAgIHwg
IDIgKy0NCj4gIGRyaXZlcnMvbWQvcmFpZDUtY2FjaGUuYyAgICAgICAgIHwgMTAgKysrKystLS0t
LQ0KPiAgZHJpdmVycy9tZC9yYWlkNS5oICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVy
cy9tbWMvY29yZS9ob3N0LmMgICAgICAgICAgfCAgMyArKy0NCj4gIGRyaXZlcnMvbnZtZS9ob3N0
L2ZjLmMgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvbnZtZS90YXJnZXQvbG9vcC5jICAg
ICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvc2NzaS94ZW4tc2NzaWZyb250LmMgICAgIHwgIDQgKyst
LQ0KPiAgZnMvZXJvZnMvaW50ZXJuYWwuaCAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvZXh0
Mi9kaXIuYyAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvaW9tYXAvYnVmZmVyZWQt
aW8uYyAgICAgICAgICAgfCAgMiArLQ0KPiAgZnMvbGliZnMuYyAgICAgICAgICAgICAgICAgICAg
ICAgfCAgMiArLQ0KPiAgZnMvbmZzL2Jsb2NrbGF5b3V0L2Jsb2NrbGF5b3V0LmggfCAgMiAtLQ0K
PiAgZnMvbmlsZnMyL2Rpci5jICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgaW5jbHVkZS9s
aW51eC9ibGtkZXYuaCAgICAgICAgICAgfCAgNCArKysrDQo+ICBpbmNsdWRlL2xpbnV4L2Rldmlj
ZS1tYXBwZXIuaCAgICB8ICAxIC0NCj4gIG1tL3BhZ2VfaW8uYyAgICAgICAgICAgICAgICAgICAg
IHwgIDQgKystLQ0KPiAgbW0vc3dhcGZpbGUuYyAgICAgICAgICAgICAgICAgICAgfCAxMiArKysr
KystLS0tLS0NCj4gIDMxIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDY1IGRlbGV0
aW9ucygtKQ0KPiANCg0KW3NuaXBwZWRdDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvYmNh
Y2hlL3V0aWwuaCBiL2RyaXZlcnMvbWQvYmNhY2hlL3V0aWwuaA0KPiBpbmRleCBjMDI5Zjc0NDMx
OTAuLjU1MTk2ZTBmMzdjMyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tZC9iY2FjaGUvdXRpbC5o
DQo+ICsrKyBiL2RyaXZlcnMvbWQvYmNhY2hlL3V0aWwuaA0KPiBAQCAtMTUsOCArMTUsNiBAQA0K
PiAgDQo+ICAjaW5jbHVkZSAiY2xvc3VyZS5oIg0KPiAgDQo+IC0jZGVmaW5lIFBBR0VfU0VDVE9S
UwkJKFBBR0VfU0laRSAvIDUxMikNCj4gLQ0KPiAgc3RydWN0IGNsb3N1cmU7DQo+ICANCj4gICNp
ZmRlZiBDT05GSUdfQkNBQ0hFX0RFQlVHDQoNCltzbmlwcGVkXQ0KDQoNCi0tIA0KDQpDb2x5IExp
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
