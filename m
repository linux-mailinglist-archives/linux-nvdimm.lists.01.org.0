Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45B231EE9
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 15:03:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2B8F126C0FC2;
	Wed, 29 Jul 2020 06:03:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [63.128.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36417126AA9EE
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1596027798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ehYWEdiPCInDna3ZEshNEs9eA6ojK3scxoagbYtds0c=;
	b=hI5qtVWgg2NDeOS+R+DMxZFplPiYctUKefxRb99mEw7MwK30nfFq+NM5lW84enmYYHeWye
	D8UyqfzxLffcv1/qB3I+N2aSzbEYY6nL3HSwRJKa7f03TUxPyr00x0bQlAvB6cM6tuMXC2
	23HJjYMUFQYrtzsGK+EqFtC8wXjl4gk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-zfIkg4DEPruShdJQz36tMw-1; Wed, 29 Jul 2020 09:03:14 -0400
X-MC-Unique: zfIkg4DEPruShdJQz36tMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 285C6102C7ED;
	Wed, 29 Jul 2020 13:03:11 +0000 (UTC)
Received: from [10.36.113.153] (ovpn-113-153.ams2.redhat.com [10.36.113.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 348341001B2C;
	Wed, 29 Jul 2020 13:03:05 +0000 (UTC)
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem
 alignment
To: Mike Rapoport <rppt@linux.ibm.com>
References: <20200729033424.2629-1-justin.he@arm.com>
 <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
 <AM6PR08MB40690714A2E77A7128B2B2ADF7700@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <20200729093150.GC3672596@linux.ibm.com>
 <e128f304-7d1d-c1eb-2def-fee7d105424f@redhat.com>
 <20200729130025.GD3672596@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <170d7861-4df8-ecaf-dbdd-9e9a4a832f8f@redhat.com>
Date: Wed, 29 Jul 2020 15:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729130025.GD3672596@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 5IHILDC7IRPVL2F553PZABLYEJSDPQXY
X-Message-ID-Hash: 5IHILDC7IRPVL2F553PZABLYEJSDPQXY
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Justin He <Justin.He@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <Steve.Capper@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Anshuman Khandual <Anshuman.Khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5IHILDC7IRPVL2F553PZABLYEJSDPQXY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjkuMDcuMjAgMTU6MDAsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIFdlZCwgSnVsIDI5
LCAyMDIwIGF0IDExOjM1OjIwQU0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4g
T24gMjkuMDcuMjAgMTE6MzEsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4gSGkgSnVzdGluLA0K
Pj4+DQo+Pj4gT24gV2VkLCBKdWwgMjksIDIwMjAgYXQgMDg6Mjc6NThBTSArMDAwMCwgSnVzdGlu
IEhlIHdyb3RlOg0KPj4+PiBIaSBEYXZpZA0KPj4+Pj4+DQo+Pj4+Pj4gV2l0aG91dCB0aGlzIHNl
cmllcywgaWYgcWVtdSBjcmVhdGVzIGEgNEcgYnl0ZXMgbnZkaW1tIGRldmljZSwgd2UgY2FuDQo+
Pj4+PiBvbmx5DQo+Pj4+Pj4gdXNlIDJHIGJ5dGVzIGZvciBkYXggcG1lbShrbWVtKSBpbiB0aGUg
d29yc3QgY2FzZS4NCj4+Pj4+PiBlLmcuDQo+Pj4+Pj4gMjQwMDAwMDAwLTMzZmRmZmZmZiA6IFBl
cnNpc3RlbnQgTWVtb3J5DQo+Pj4+Pj4gV2UgY2FuIG9ubHkgdXNlIHRoZSBtZW1ibG9jayBiZXR3
ZWVuIFsyNDAwMDAwMDAsIDJmZmZmZmZmZl0gZHVlIHRvIHRoZQ0KPj4+Pj4gaGFyZA0KPj4+Pj4+
IGxpbWl0YXRpb24uIEl0IHdhc3RlcyB0b28gbXVjaCBtZW1vcnkgc3BhY2UuDQo+Pj4+Pj4NCj4+
Pj4+PiBEZWNyZWFzaW5nIHRoZSBTRUNUSU9OX1NJWkVfQklUUyBvbiBhcm02NCBtaWdodCBiZSBh
biBhbHRlcm5hdGl2ZSwgYnV0DQo+Pj4+PiB0aGVyZQ0KPj4+Pj4+IGFyZSB0b28gbWFueSBjb25j
ZXJucyBmcm9tIG90aGVyIGNvbnN0cmFpbnRzLCBlLmcuIFBBR0VfU0laRSwgaHVnZXRsYiwNCj4+
Pj4+PiBTUEFSU0VNRU1fVk1FTU1BUCwgcGFnZSBiaXRzIGluIHN0cnVjdCBwYWdlIC4uLg0KPj4+
Pj4+DQo+Pj4+Pj4gQmVzaWRlIGRlY3JlYXNpbmcgdGhlIFNFQ1RJT05fU0laRV9CSVRTLCB3ZSBj
YW4gYWxzbyByZWxheCB0aGUga21lbQ0KPj4+Pj4gYWxpZ25tZW50DQo+Pj4+Pj4gd2l0aCBtZW1v
cnlfYmxvY2tfc2l6ZV9ieXRlcygpLg0KPj4+Pj4+DQo+Pj4+Pj4gVGVzdGVkIG9uIGFybTY0IGd1
ZXN0IGFuZCB4ODYgZ3Vlc3QsIHFlbXUgY3JlYXRlcyBhIDRHIHBtZW0gZGV2aWNlLiBkYXgNCj4+
Pj4+IHBtZW0NCj4+Pj4+PiBjYW4gYmUgdXNlZCBhcyByYW0gd2l0aCBzbWFsbGVyIGdhcC4gQWxz
byB0aGUga21lbSBob3RwbHVnIGFkZC9yZW1vdmUNCj4+Pj4+IGFyZSBib3RoDQo+Pj4+Pj4gdGVz
dGVkIG9uIGFybTY0L3g4NiBndWVzdC4NCj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IEhpLA0KPj4+Pj4N
Cj4+Pj4+IEkgYW0gbm90IGNvbnZpbmNlZCB0aGlzIHVzZSBjYXNlIGlzIHdvcnRoIHN1Y2ggaGFj
a3MgKHRoYXTigJlzIHdoYXQgaXQgaXMpDQo+Pj4+PiBmb3Igbm93LiBPbiByZWFsIG1hY2hpbmVz
IHBtZW0gaXMgYmlnIC0geW91ciBleGFtcGxlIChsb3NpbmcgNTAlIGlzDQo+Pj4+PiBleHRyZW1l
KS4NCj4+Pj4+DQo+Pj4+PiBJIHdvdWxkIG11Y2ggcmF0aGVyIHdhbnQgdG8gc2VlIHRoZSBzZWN0
aW9uIHNpemUgb24gYXJtNjQgcmVkdWNlZC4gSQ0KPj4+Pj4gcmVtZW1iZXIgdGhlcmUgd2VyZSBw
YXRjaGVzIGFuZCB0aGF0IGF0IGxlYXN0IHdpdGggYSBiYXNlIHBhZ2Ugc2l6ZSBvZiA0aw0KPj4+
Pj4gaXQgY2FuIGJlIHJlZHVjZWQgZHJhc3RpY2FsbHkgKDY0ayBiYXNlIHBhZ2VzIGFyZSBtb3Jl
IHByb2JsZW1hdGljIGR1ZSB0bw0KPj4+Pj4gdGhlIHJpZGljdWxvdXMgVEhQIHNpemUgb2YgNTEy
TSkuIEJ1dCBjb3VsZCBiZSBhIHNlY3Rpb24gc2l6ZSBvZiA1MTIgaXMNCj4+Pj4+IHBvc3NpYmxl
IG9uIGFsbCBjb25maWdzIHJpZ2h0IG5vdy4NCj4+Pj4NCj4+Pj4gWWVzLCBJIG9uY2UgaW52ZXN0
aWdhdGVkIGhvdyB0byByZWR1Y2Ugc2VjdGlvbiBzaXplIG9uIGFybTY0IHRob3VnaHRmdWxseToN
Cj4+Pj4gVGhlcmUgYXJlIG1hbnkgY29uc3RyYWludHMgZm9yIHJlZHVjaW5nIFNFQ1RJT05fU0la
RV9CSVRTDQo+Pj4+IDEuIEdpdmVuIHBhZ2UtPmZsYWdzIGJpdHMgaXMgbGltaXRlZCwgU0VDVElP
Tl9TSVpFX0JJVFMgY2FuJ3QgYmUgcmVkdWNlZCB0b28NCj4+Pj4gICAgbXVjaC4NCj4+Pj4gMi4g
T25jZSBDT05GSUdfU1BBUlNFTUVNX1ZNRU1NQVAgaXMgZW5hYmxlZCwgc2VjdGlvbiBpZCB3aWxs
IG5vdCBiZSBjb3VudGVkDQo+Pj4+ICAgIGludG8gcGFnZS0+ZmxhZ3MuDQo+Pj4+IDMuIE1BWF9P
UkRFUiBkZXBlbmRzIG9uIFNFQ1RJT05fU0laRV9CSVRTIA0KPj4+PiAgLSAzLjEgbW16b25lLmgN
Cj4+Pj4gI2lmIChNQVhfT1JERVIgLSAxICsgUEFHRV9TSElGVCkgPiBTRUNUSU9OX1NJWkVfQklU
Uw0KPj4+PiAjZXJyb3IgQWxsb2NhdG9yIE1BWF9PUkRFUiBleGNlZWRzIFNFQ1RJT05fU0laRQ0K
Pj4+PiAjZW5kaWYNCj4+Pj4gIC0gMy4yIGh1Z2VwYWdlX2luaXQoKQ0KPj4+PiBNQVlCRV9CVUlM
RF9CVUdfT04oSFBBR0VfUE1EX09SREVSID49IE1BWF9PUkRFUik7DQo+Pj4+DQo+Pj4+IEhlbmNl
IHdoZW4gQVJNNjRfNEtfUEFHRVMgJiYgQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQIGFyZSBlbmFi
bGVkLA0KPj4+PiBTRUNUSU9OX1NJWkVfQklUUyBjYW4gYmUgcmVkdWNlZCB0byAyNy4NCj4+Pj4g
QnV0IHdoZW4gQVJNNjRfNjRLX1BBR0VTLCBnaXZlbiAzLjIsIE1BWF9PUkRFUiA+IDI5LTE2ID0g
MTMuDQo+Pj4+IEdpdmVuIDMuMSBTRUNUSU9OX1NJWkVfQklUUyA+PSBNQVhfT1JERVIrMTUgPiAy
OC4gU28gU0VDVElPTl9TSVpFX0JJVFMgY2FuIG5vdA0KPj4+PiBiZSByZWR1Y2VkIHRvIDI3Lg0K
Pj4+Pg0KPj4+PiBJbiBvbmUgd29yZCwgaWYgd2UgY29uc2lkZXJlZCB0byByZWR1Y2UgU0VDVElP
Tl9TSVpFX0JJVFMgb24gYXJtNjQsIHRoZSBLY29uZmlnDQo+Pj4+IG1pZ2h0IGJlIHZlcnkgY29t
cGxpY2F0ZWQsZS5nLiB3ZSBzdGlsbCBuZWVkIHRvIGNvbnNpZGVyIHRoZSBjYXNlIGZvcg0KPj4+
PiBBUk02NF8xNktfUEFHRVMuDQo+Pj4NCj4+PiBJdCBpcyBub3QgbmVjZXNzYXJ5IHRvIHBvbGx1
dGUgS2NvbmZpZyB3aXRoIHRoYXQuDQo+Pj4gYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zcGFyZXNl
bWVtLmggY2FuIGhhdmUgc29tZXRoaW5nIGxpa2UNCj4+Pg0KPj4+ICNpZmRlZiBDT05GSUdfQVJN
NjRfNjRLX1BBR0VTDQo+Pj4gI2RlZmluZSBTUEFSU0VfU0VDVElPTl9TSVpFIDI5DQo+Pj4gI2Vs
aWYgZGVmaW5lZChDT05GSUdfQVJNMTZLX1BBR0VTKQ0KPj4+ICNkZWZpbmUgU1BBUlNFX1NFQ1RJ
T05fU0laRSAyOA0KPj4+ICNlbGlmIGRlZmluZWQoQ09ORklHX0FSTTRLX1BBR0VTKQ0KPj4+ICNk
ZWZpbmUgU1BBUlNFX1NFQ1RJT05fU0laRSAyNw0KPj4+ICNlbHNlDQo+Pj4gI2Vycm9yDQo+Pj4g
I2VuZGlmDQo+Pg0KPj4gYWNrDQo+Pg0KPj4+ICANCj4+PiBUaGVyZSBpcyBzdGlsbCBsYXJnZSBn
YXAgd2l0aCBBUk02NF82NEtfUEFHRVMsIHRob3VnaC4NCj4+Pg0KPj4+IEFzIGZvciBTUEFSU0VN
RU0gd2l0aG91dCBWTUVNTUFQLCBhcmUgdGhlcmUgYWN0dWFsIGJlbmVmaXRzIHRvIHVzZSBpdD8N
Cj4+DQo+PiBJIHdhcyBhc2tpbmcgbXlzZWxmIHRoZSBzYW1lIHF1ZXN0aW9uIGEgd2hpbGUgYWdv
IGFuZCBkaWRuJ3QgcmVhbGx5IGZpbmQNCj4+IGEgY29tcGVsbGluZyBvbmUuDQo+IA0KPiBNZW1v
cnkgb3ZlcmhlYWQgZm9yIFZNRU1NQVAgaXMgbGFyZ2VyLCBlc3BlY2lhbGx5IGZvciBhcm02NCB0
aGF0IGtub3dzDQo+IGhvdyB0byBmcmVlIGVtcHR5IHBhcnRzIG9mIHRoZSBtZW1vcnkgbWFwIHdp
dGggImNsYXNzaWMiIFNQQVJTRU1FTS4NCg0KWW91IG1lYW4gdGhlIGhvbGUgcHVuY2hpbmcgd2l0
aGluIHNlY3Rpb24gbWVtbWFwPyAod2hpY2ggaXMgd2h5IHRoZWlyDQpwZm5fdmFsaWQoKSBpbXBs
ZW1lbnRhdGlvbiBpcyBzcGVjaWFsKQ0KDQooSSBkbyB3b25kZXIgd2h5IHRoYXQgc2hvdWxkbid0
IHdvcmsgd2l0aCBWTUVNTUFQLCBvciBpcyBpdCBzaW1wbHkgbm90DQppbXBsZW1lbnRlZD8pDQoN
Cj4gIA0KPj4gSSB0aGluayBpdCdzIGFsd2F5cyBlbmFibGVkIGFzIGRlZmF1bHQgKFNQQVJTRU1F
TV9WTUVNTUFQX0VOQUJMRSkgYW5kDQo+PiB3b3VsZCByZXF1aXJlIGNvbmZpZyB0d2Vha3MgdG8g
ZXZlbiBkaXNhYmxlIGl0Lg0KPiANCj4gTm9wZSwgaXQncyByaWdodCB0aGVyZSBpbiBtZW51Y29u
ZmlnLA0KPiANCj4gIk1lbW9yeSBNYW5hZ2VtZW50IG9wdGlvbnMiIC0+ICJTcGFyc2UgTWVtb3J5
IHZpcnR1YWwgbWVtbWFwIg0KDQpBaCwgZ29vZCB0byBrbm93Lg0KDQoNCi0tIA0KVGhhbmtzLA0K
DQpEYXZpZCAvIGRoaWxkZW5iDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
