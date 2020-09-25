Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8CB278354
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 10:55:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7E44A154B1019;
	Fri, 25 Sep 2020 01:55:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83EDA154B1010
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 01:54:58 -0700 (PDT)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1601024097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3sgv1pOZlB06dEQ0nLJCJG7WcKIpgapVe9e7yCMNbog=;
	b=E1t63bbe8dDogIM3TSMgFEDaGBkBTc7fzvtVnoXiPy5111l7PCkT2KZObdiXS0OGPLR0uF
	nJncz7m58JXYzFK2BDDr0Qfgbn4BSTIplKXk2ec+9qJuncTNxCBPYwLv1M+9/wosRwlJ2G
	Yot3He0cedo52dvNO/WYiBHmb9n/If0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-L5b0IUGPMD2PwNgdTNW4dA-1; Fri, 25 Sep 2020 04:54:53 -0400
X-MC-Unique: L5b0IUGPMD2PwNgdTNW4dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA291800E23;
	Fri, 25 Sep 2020 08:54:51 +0000 (UTC)
Received: from [10.36.112.211] (ovpn-112-211.ams2.redhat.com [10.36.112.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7468578822;
	Fri, 25 Sep 2020 08:54:43 +0000 (UTC)
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
 <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
 <CAPcyv4jsUiXTqDtnh_fnm_p4NaX2=c3rrjFe6Efa-oWPkTe-fA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <d729e2e3-1f8e-31e6-7095-841b9e3ca47b@redhat.com>
Date: Fri, 25 Sep 2020 10:54:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jsUiXTqDtnh_fnm_p4NaX2=c3rrjFe6Efa-oWPkTe-fA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Message-ID-Hash: RGSSLLXSTTW45OFSAF2ONELAHZNOQBI4
X-Message-ID-Hash: RGSSLLXSTTW45OFSAF2ONELAHZNOQBI4
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Joao Martins <joao.m.martins@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RGSSLLXSTTW45OFSAF2ONELAHZNOQBI4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjQuMDkuMjAgMjM6NTAsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gVGh1LCBTZXAgMjQs
IDIwMjAgYXQgMjo0MiBQTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+Pg0KPj4NCj4+DQo+Pj4gQW0gMjQuMDkuMjAyMCB1bSAyMzoyNiBzY2hyaWViIERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjoNCj4+Pg0KPj4+IO+7v1suLl0NCj4+
Pj4+IEknbSBub3Qgc3VnZ2VzdGluZyB0byBidXN5IHRoZSB3aG9sZSAidmlydGlvIiByYW5nZSwg
anVzdCB0aGUgcG9ydGlvbg0KPj4+Pj4gdGhhdCdzIGFib3V0IHRvIGJlIHBhc3NlZCB0byBhZGRf
bWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCkuDQo+Pj4+DQo+Pj4+IEknbSBhZnJhaWQgSSBkb24ndCBn
ZXQgeW91ciBwb2ludC4gRm9yIHZpcnRpby1tZW06DQo+Pj4+DQo+Pj4+IEJlZm9yZToNCj4+Pj4N
Cj4+Pj4gMS4gQ3JlYXRlIHZpcnRpbzAgY29udGFpbmVyIHJlc291cmNlDQo+Pj4+DQo+Pj4+IDIu
IChzb21ld2hlbiBpbiB0aGUgZnV0dXJlKSBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCkNCj4+
Pj4gLSBDcmVhdGUgcmVzb3VyY2UgKFN5c3RlbSBSQU0gKHZpcnRpb19tZW0pKSwgbWFya2luZyBp
dCBidXN5L2RyaXZlcg0KPj4+PiAgIG1hbmFnZWQNCj4+Pj4NCj4+Pj4gQWZ0ZXI6DQo+Pj4+DQo+
Pj4+IDEuIENyZWF0ZSB2aXJ0aW8wIGNvbnRhaW5lciByZXNvdXJjZQ0KPj4+Pg0KPj4+PiAyLiAo
c29tZXdoZW4gaW4gdGhlIGZ1dHVyZSkgQ3JlYXRlIHJlc291cmNlIChTeXN0ZW0gUkFNICh2aXJ0
aW9fbWVtKSksDQo+Pj4+ICAgbWFya2luZyBpdCBidXN5L2RyaXZlciBtYW5hZ2VkDQo+Pj4+IDMu
IGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKQ0KPj4+Pg0KPj4+PiBOb3QgaGVscGZ1bCBvciBz
aW1wbGVyIElNSE8uDQo+Pj4NCj4+PiBUaGUgY29uY2VybiBJJ20gdHJ5aW5nIHRvIGFkZHJlc3Mg
aXMgdGhlIHRoZW9yZXRpY2FsIHJhY2Ugd2luZG93IGFuZA0KPj4+IGxheWVyaW5nIHZpb2xhdGlv
biBpbiB0aGlzIHNlcXVlbmNlIGluIHRoZSBrbWVtIGRyaXZlcjoNCj4+Pg0KPj4+IDEvIHJlcyA9
IHJlcXVlc3RfbWVtX3JlZ2lvbiguLi4pOw0KPj4+IDIvIHJlcy0+ZmxhZ3MgPSBJT1JFU09VUkNF
X01FTTsNCj4+PiAzLyBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCk7DQo+Pj4NCj4+PiBCZXR3
ZWVuIDIvIGFuZCAzLyBzb21ldGhpbmcgY2FuIHJhY2UgYW5kIHRoaW5rIHRoYXQgaXQgb3ducyB0
aGUNCj4+PiByZWdpb24uIERvIEkgdGhpbmsgaXQgd2lsbCBoYXBwZW4gaW4gcHJhY3RpY2UsIG5v
LCBidXQgaXQncyBzdGlsbCBhDQo+Pj4gcGF0dGVybiB0aGF0IGRlc2VydmVzIGNvbWUgY2xlYW51
cC4NCj4+DQo+PiBJIHRoaW5rIGluIHRoYXQgdW5saWtlbHkgZXZlbnQgKHJhdGhlciBpbXBvc3Np
YmxlKSwgYWRkX21lbW9yeV9kcml2ZXJfbWFuYWdlZCgpIHNob3VsZCBmYWlsLCBkZXRlY3Rpbmcg
YSBjb25mbGljdGluZyAoYnVzeSkgcmVzb3VyY2UuIE5vdCBzdXJlIHdoYXQgd2lsbCBoYXBwZW4g
bmV4dCAoIGFuZCBkaWQgbm90IGRvdWJsZS1jaGVjaykuDQo+IA0KPiBhZGRfbWVtb3J5X2RyaXZl
cl9tYW5hZ2VkKCkgd2lsbCBmYWlsLCBidXQgdGhlIHJlbGVhc2VfbWVtX3JlZ2lvbigpIGluDQo+
IGttZW0gdG8gdW53aW5kIG9uIHRoZSBlcnJvciBwYXRoIHdpbGwgZG8gdGhlIHdyb25nIHRoaW5n
IGJlY2F1c2UgdGhhdA0KPiBvdGhlciBkcml2ZXIgdGhpbmtzIGl0IGdvdCBvd25lcnNoaXAgb2Yg
dGhlIHJlZ2lvbi4NCj4gDQoNCkkgdGhpbmsgaWYgc29tZWJvZHkgd291bGQgcmFjZSBhbmQgY2xh
aW0gdGhlIHJlZ2lvbiBmb3IgaXRzZWxmIChhZnRlciB3ZQ0KdW5jaGVja2VkIHRoZSBCVVNZIGZs
YWcpLCB0aGVyZSB3b3VsZCBiZSBhbm90aGVyIG1lbW9yeSByZXNvdXJjZSBiZWxvdw0Kb3VyIHJl
c291cmNlIGNvbnRhaW5lciAoZS5nLiwgdmlhIF9fcmVxdWVzdF9yZWdpb24oKSkuDQoNClNvLCBp
bnRlcmVzdGluZ2x5LCB0aGUgY3VycmVudCBjb2RlIHdpbGwgZG8gYQ0KDQpyZWxlYXNlX3Jlc291
cmNlLT5fX3JlbGVhc2VfcmVzb3VyY2Uob2xkLCB0cnVlKTsNCg0Kd2hpY2ggd2lsbCByZW1vdmUg
d2hhdGV2ZXIgc29tZWJvZHkgYWRkZWQgYmVsb3cgdGhlIHJlc291cmNlLg0KDQpJZiB3ZSB3ZXJl
IHRvIGRvIGENCg0KcmVtb3ZlX3Jlc291cmNlLT5fX3JlbGVhc2VfcmVzb3VyY2Uob2xkLCBmYWxz
ZSk7DQoNCndlIHdvdWxkIG9ubHkgcmVtb3ZlIHdoYXQgd2UgdGVtcG9yYXJpbHkgYWRkZWQsIHJl
bG9jYXRpbmcgYW55Y2hpbGRyZW4NCihzb21lb25lIG5hc3R5IGFkZGVkKS4NCg0KQnV0IHllYWgs
IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSB0byB3b3JyeSBhYm91dCB0aGlzIGNhc2UuDQoNCj4+IEJ1
dCB5ZWFoLCB0aGUgd2F5IHRoZSBCVVNZIGJpdCBpcyBjbGVhcmVkIGhlcmUgaXMgd3JvbmcgLSBz
aW1wbHkgb3ZlcndyaXRpbmcgb3RoZXIgYml0cy4gQW5kIGl0IHdvdWxkIGJlIGV2ZW4gYmV0dGVy
IGlmIHdlIGNvdWxkIGF2b2lkIG1hbnVhbGx5IG1lc3Npbmcgd2l0aCBmbGFncyBoZXJlLg0KPiAN
Cj4gSSdtIG9rIHRvIGxlYXZlIGl0IGFsb25lIGZvciBub3cgKGhhc24ndCBiZWVuIGFuZCBsaWtl
bHkgbmV2ZXIgd2lsbCBiZQ0KPiBhIHByb2JsZW0gaW4gcHJhY3RpY2UpLCBidXQgSSB0aGluayBp
dCB3YXMgc3RpbGwgd29ydGggZ3J1bWJsaW5nDQoNCkRlZmluaXRlbHksIGl0IGdpdmVzIHVzIGEg
YmV0dGVyIHVuZGVyc3RhbmRpbmcuDQoNCj4gYWJvdXQuIEknbGwgbGVhdmUgdGhhdCBwYXJ0IG9m
IGttZW0gYWxvbmUgaW4gdGhlIHVwY29taW5nIHNwbGl0IG9mDQo+IGRheF9rbWVtX3JlcyByZW1v
dmFsLg0KDQpZZWFoLCBzdHVmZiBpcyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gSSB3b3VsZCB3aXNo
ZWQsIHNvIEkgZ3Vlc3MgaXQncw0KYmV0dGVyIHRvIGxlYXZlIGl0IGFsb25lIGZvciBub3cgdW50
aWwgd2UgYWN0dWFsbHkgc2VlIGlzc3VlcyB3aXRoDQpzb21lYm9keSBlbHNlIHJlZ2FyZGluZyAq
b3VyKiBkZXZpY2Utb3duZWQgcmVnaW9uIChvciB3ZSdyZSBhYmxlIHRvIGNvbWUNCnVwIHdpdGgg
YSBjbGVhbnVwIHRoYXQga2VlcHMgYWxsIGNvcm5lciBjYXNlcyB3b3JraW5nIGZvciBrbWVtIGFu
ZA0KdmlydGlvLW1lbSkuDQoNCi0tIA0KVGhhbmtzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0g
bWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
