Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064BA2421A1
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Aug 2020 23:07:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4C6AA12B41369;
	Tue, 11 Aug 2020 14:07:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2F53612B41363
	for <linux-nvdimm@lists.01.org>; Tue, 11 Aug 2020 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1597180066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VthFkyGCFIh85pRmVSVaEBHjQustoj147EebE/56Eiw=;
	b=DENV1wygMlwh0HGD8eZyWolJ9y/4r8v6akmXTrkZLLvRME7zpJuFgpaiAsgnG/fK6hE0tQ
	JQBR8NTgnqTbxwHZcphgjuP7UC8KKPClwwIwHe2arYas4awjVLqHxDo7JUvTvznLNnVsAz
	tp81W+QliFdap1L3wpQfkhGL4a8sC/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-FYjZlXzsPp2LNMKyiGvItQ-1; Tue, 11 Aug 2020 17:07:42 -0400
X-MC-Unique: FYjZlXzsPp2LNMKyiGvItQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C10B8015F4;
	Tue, 11 Aug 2020 21:07:40 +0000 (UTC)
Received: from [10.36.112.12] (ovpn-112-12.ams2.redhat.com [10.36.112.12])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1456C5F9DF;
	Tue, 11 Aug 2020 21:07:36 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] memremap: rename MEMORY_DEVICE_DEVDAX to
 MEMORY_DEVICE_GENERIC
To: Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org
References: <20200811094447.31208-1-roger.pau@citrix.com>
 <20200811094447.31208-2-roger.pau@citrix.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <96e34f77-8f55-d8a2-4d1f-4f4b667b0472@redhat.com>
Date: Tue, 11 Aug 2020 23:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811094447.31208-2-roger.pau@citrix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Message-ID-Hash: XYGPIMRBNKXLELNKS2OVENH2UFXZM3HG
X-Message-ID-Hash: XYGPIMRBNKXLELNKS2OVENH2UFXZM3HG
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Logan Gunthorpe <logang@deltatee.com>, linux-nvdimm@lists.01.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XYGPIMRBNKXLELNKS2OVENH2UFXZM3HG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMTEuMDguMjAgMTE6NDQsIFJvZ2VyIFBhdSBNb25uZSB3cm90ZToNCj4gVGhpcyBpcyBpbiBw
cmVwYXJhdGlvbiBmb3IgdGhlIGxvZ2ljIGJlaGluZCBNRU1PUllfREVWSUNFX0RFVkRBWCBhbHNv
DQo+IGJlaW5nIHVzZWQgYnkgbm9uIERBWCBkZXZpY2VzLg0KPiANCj4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBQYXUgTW9ubsOpIDxy
b2dlci5wYXVAY2l0cml4LmNvbT4NCj4gLS0tDQo+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndp
bGxpYW1zQGludGVsLmNvbT4NCj4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50
ZWwuY29tPg0KPiBDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQo+IENjOiBB
bmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBDYzogSmFzb24gR3Vu
dGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IENjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5j
b20+DQo+IENjOiAiQW5lZXNoIEt1bWFyIEsuViIgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29t
Pg0KPiBDYzogSm9oYW5uZXMgVGh1bXNoaXJuIDxqdGh1bXNoaXJuQHN1c2UuZGU+DQo+IENjOiBM
b2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+IENjOiBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnDQo+IENjOiB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmcNCj4gQ2M6
IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiAtLS0NCj4gIGRyaXZlcnMvZGF4L2RldmljZS5jICAgICB8
IDIgKy0NCj4gIGluY2x1ZGUvbGludXgvbWVtcmVtYXAuaCB8IDkgKysrKy0tLS0tDQo+ICBtbS9t
ZW1yZW1hcC5jICAgICAgICAgICAgfCAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9k
ZXZpY2UuYyBiL2RyaXZlcnMvZGF4L2RldmljZS5jDQo+IGluZGV4IDRjMGFmMmViN2UxOS4uMWU4
OTUxM2YzYzU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2RheC9kZXZpY2UuYw0KPiArKysgYi9k
cml2ZXJzL2RheC9kZXZpY2UuYw0KPiBAQCAtNDI5LDcgKzQyOSw3IEBAIGludCBkZXZfZGF4X3By
b2JlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAkJcmV0dXJuIC1FQlVTWTsNCj4gIAl9DQo+ICAN
Cj4gLQlkZXZfZGF4LT5wZ21hcC50eXBlID0gTUVNT1JZX0RFVklDRV9ERVZEQVg7DQo+ICsJZGV2
X2RheC0+cGdtYXAudHlwZSA9IE1FTU9SWV9ERVZJQ0VfR0VORVJJQzsNCj4gIAlhZGRyID0gZGV2
bV9tZW1yZW1hcF9wYWdlcyhkZXYsICZkZXZfZGF4LT5wZ21hcCk7DQo+ICAJaWYgKElTX0VSUihh
ZGRyKSkNCj4gIAkJcmV0dXJuIFBUUl9FUlIoYWRkcik7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L21lbXJlbWFwLmggYi9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCj4gaW5kZXggNWY1
YjJkZjA2ZTYxLi5lNTg2Mjc0Njc1MWIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWVt
cmVtYXAuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21lbXJlbWFwLmgNCj4gQEAgLTQ2LDExICs0
NiwxMCBAQCBzdHJ1Y3Qgdm1lbV9hbHRtYXAgew0KPiAgICogd2FrZXVwIGlzIHVzZWQgdG8gY29v
cmRpbmF0ZSBwaHlzaWNhbCBhZGRyZXNzIHNwYWNlIG1hbmFnZW1lbnQgKGV4Og0KPiAgICogZnMg
dHJ1bmNhdGUvaG9sZSBwdW5jaCkgdnMgcGlubmVkIHBhZ2VzIChleDogZGV2aWNlIGRtYSkuDQo+
ICAgKg0KPiAtICogTUVNT1JZX0RFVklDRV9ERVZEQVg6DQo+ICsgKiBNRU1PUllfREVWSUNFX0dF
TkVSSUM6DQo+ICAgKiBIb3N0IG1lbW9yeSB0aGF0IGhhcyBzaW1pbGFyIGFjY2VzcyBzZW1hbnRp
Y3MgYXMgU3lzdGVtIFJBTSBpLmUuIERNQQ0KPiAtICogY29oZXJlbnQgYW5kIHN1cHBvcnRzIHBh
Z2UgcGlubmluZy4gSW4gY29udHJhc3QgdG8NCj4gLSAqIE1FTU9SWV9ERVZJQ0VfRlNfREFYLCB0
aGlzIG1lbW9yeSBpcyBhY2Nlc3MgdmlhIGEgZGV2aWNlLWRheA0KPiAtICogY2hhcmFjdGVyIGRl
dmljZS4NCj4gKyAqIGNvaGVyZW50IGFuZCBzdXBwb3J0cyBwYWdlIHBpbm5pbmcuIFRoaXMgaXMg
Zm9yIGV4YW1wbGUgdXNlZCBieSBEQVggZGV2aWNlcw0KPiArICogdGhhdCBleHBvc2UgbWVtb3J5
IHVzaW5nIGEgY2hhcmFjdGVyIGRldmljZS4NCj4gICAqDQo+ICAgKiBNRU1PUllfREVWSUNFX1BD
SV9QMlBETUE6DQo+ICAgKiBEZXZpY2UgbWVtb3J5IHJlc2lkaW5nIGluIGEgUENJIEJBUiBpbnRl
bmRlZCBmb3IgdXNlIHdpdGggUGVlci10by1QZWVyDQo+IEBAIC02MCw3ICs1OSw3IEBAIGVudW0g
bWVtb3J5X3R5cGUgew0KPiAgCS8qIDAgaXMgcmVzZXJ2ZWQgdG8gY2F0Y2ggdW5pbml0aWFsaXpl
ZCB0eXBlIGZpZWxkcyAqLw0KPiAgCU1FTU9SWV9ERVZJQ0VfUFJJVkFURSA9IDEsDQo+ICAJTUVN
T1JZX0RFVklDRV9GU19EQVgsDQo+IC0JTUVNT1JZX0RFVklDRV9ERVZEQVgsDQo+ICsJTUVNT1JZ
X0RFVklDRV9HRU5FUklDLA0KPiAgCU1FTU9SWV9ERVZJQ0VfUENJX1AyUERNQSwNCj4gIH07DQo+
ICANCj4gZGlmZiAtLWdpdCBhL21tL21lbXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jDQo+IGluZGV4
IDAzZTM4YjdhMzhmMS4uMDA2ZGFjZTYwYjFhIDEwMDY0NA0KPiAtLS0gYS9tbS9tZW1yZW1hcC5j
DQo+ICsrKyBiL21tL21lbXJlbWFwLmMNCj4gQEAgLTIxNiw3ICsyMTYsNyBAQCB2b2lkICptZW1y
ZW1hcF9wYWdlcyhzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFwLCBpbnQgbmlkKQ0KPiAgCQkJcmV0
dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+ICAJCX0NCj4gIAkJYnJlYWs7DQo+IC0JY2FzZSBNRU1P
UllfREVWSUNFX0RFVkRBWDoNCj4gKwljYXNlIE1FTU9SWV9ERVZJQ0VfR0VORVJJQzoNCj4gIAkJ
bmVlZF9kZXZtYXBfbWFuYWdlZCA9IGZhbHNlOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIE1FTU9S
WV9ERVZJQ0VfUENJX1AyUERNQToNCj4gDQoNCk5vIHN0cm9uZyBvcGluaW9uIChARGFuPyksIEkg
ZG8gd29uZGVyIGlmIGEgc2VwYXJhdGUgdHlwZSB3b3VsZCBtYWtlIHNlbnNlLg0KDQotLSANClRo
YW5rcywNCg0KRGF2aWQgLyBkaGlsZGVuYg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
