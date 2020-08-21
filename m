Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 548A724E2D3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Aug 2020 23:47:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69867123B94DB;
	Fri, 21 Aug 2020 14:47:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0D8A123B72E2
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1598046413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1WdXRvG4bCNhwZSZkTWr9Rx/+hCL+T87J2kS4FEJuzY=;
	b=Lwozd2APRza5SRfRvW0MISGY0Lb3Ey6GW0WP9xnKgnrLZ9kphdIVuiONDm6NMTAwv/0glm
	9aI74GukoayvdkI8q4u03B1CPN4SySK6U7+as3jSwoyRiPIYn4svpWAuLp+Uph4F3Wa60o
	og4JxcYNEf6wiweoH1+bCvTyGvaSa5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-SAp0EwLqMC6y5pmLPLYV_Q-1; Fri, 21 Aug 2020 17:46:49 -0400
X-MC-Unique: SAp0EwLqMC6y5pmLPLYV_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34F87801AB9;
	Fri, 21 Aug 2020 21:46:44 +0000 (UTC)
Received: from [10.36.112.5] (ovpn-112-5.ams2.redhat.com [10.36.112.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DE76410013D0;
	Fri, 21 Aug 2020 21:46:34 +0000 (UTC)
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved
 ranges
To: Dan Williams <dan.j.williams@intel.com>
References: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
 <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <6cee1e57-7b7e-f8b6-2c53-f913b18926c0@redhat.com>
Date: Fri, 21 Aug 2020 23:46:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: 4GI5TWZJGURB4MJ667CCOHXUZR6GJFES
X-Message-ID-Hash: 4GI5TWZJGURB4MJ667CCOHXUZR6GJFES
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4GI5TWZJGURB4MJ667CCOHXUZR6GJFES/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMjEuMDguMjAgMjM6MzMsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiANCj4gDQo+PiBB
bSAyMS4wOC4yMDIwIHVtIDIzOjE3IHNjaHJpZWIgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+Og0KPj4NCj4+IO+7v09uIEZyaSwgQXVnIDIxLCAyMDIwIGF0IDExOjMwIEFN
IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4+Pg0KPj4+PiBP
biAyMS4wOC4yMCAyMDoyNywgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPj4+PiBPbiBGcmksIEF1ZyAy
MSwgMjAyMCBhdCAzOjE1IEFNIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3
cm90ZToNCj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IDEuIE9uIHg4Ni02NCwgZTgyMCBpbmRpY2F0
ZXMgInNvZnQtcmVzZXJ2ZWQiIG1lbW9yeS4gVGhpcyBtZW1vcnkgaXMgbm90DQo+Pj4+Pj4+IGF1
dG9tYXRpY2FsbHkgdXNlZCBpbiB0aGUgYnVkZHkgZHVyaW5nIGJvb3QsIGJ1dCByZW1haW5zIHVu
dG91Y2hlZA0KPj4+Pj4+PiAoc2ltaWxhciB0byBwbWVtKS4gQnV0IGFzIGl0IGludm9sdmVzIEFD
UEkgYXMgd2VsbCwgaXQgY291bGQgYWxzbyBiZQ0KPj4+Pj4+PiB1c2VkIG9uIGFybTY0ICgtZTgy
MCksIGNvcnJlY3Q/DQo+Pj4+Pj4NCj4+Pj4+PiBDb3JyZWN0LCBhcm02NCBhbHNvIGdldHMgdGhl
IEVGSSBzdXBwb3J0IGZvciBlbnVtZXJhdGluZyBtZW1vcnkgdGhpcw0KPj4+Pj4+IHdheS4gSG93
ZXZlciwgSSB3b3VsZCBjbGFyaWZ5IHRoYXQgd2hldGhlciBzb2Z0LXJlc2VydmVkIGlzIGdpdmVu
IHRvDQo+Pj4+Pj4gdGhlIGJ1ZGR5IGFsbG9jYXRvciBieSBkZWZhdWx0IG9yIG5vdCBpcyB0aGUg
a2VybmVsJ3MgcG9saWN5IGNob2ljZSwNCj4+Pj4+PiAiYnVkZHktYnktZGVmYXVsdCIgaXMgb2sg
YW5kIGlzIHdoYXQgd2lsbCBoYXBwZW4gYW55d2F5cyB3aXRoIG9sZGVyDQo+Pj4+Pj4ga2VybmVs
cyBvbiBwbGF0Zm9ybXMgdGhhdCBlbnVtZXJhdGUgYSBtZW1vcnkgcmFuZ2UgdGhpcyB3YXkuDQo+
Pj4+Pg0KPj4+Pj4gSXMgInNvZnQtcmVzZXJ2ZWQiIHRoZW4gdGhlIHJpZ2h0IHRlcm1pbm9sb2d5
IGZvciB0aGF0PyBJdCBzb3VuZHMgdmVyeQ0KPj4+Pj4geDg2LTY0L2U4MjAgc3BlY2lmaWMuIE1h
eWJlIGEgY29tcHJlc3NlZCBmb3Igb2YgInBlcmZvcm1hbmNlDQo+Pj4+PiBkaWZmZXJlbnRpYXRl
ZCBtZW1vcnkiIG1pZ2h0IGJlIGEgYmV0dGVyIGZpdCB0byBleHBvc2UgdG8gdXNlciBzcGFjZSwg
bm8/DQo+Pj4+DQo+Pj4+IE5vLiBUaGUgRUZJICJTcGVjaWZpYyBQdXJwb3NlIiBiaXQgaXMgYW4g
YXR0cmlidXRlIGluZGVwZW5kZW50IG9mDQo+Pj4+IGU4MjAsIGl0J3MgeDg2LUxpbnV4IHRoYXQg
ZW50YW5nbGVzIHRob3NlIHRvZ2V0aGVyLiBUaGVyZSBpcyBubw0KPj4+PiByZXF1aXJlbWVudCBm
b3IgcGxhdGZvcm0gZmlybXdhcmUgdG8gdXNlIHRoYXQgZGVzaWduYXRpb24gZXZlbiBmb3INCj4+
Pj4gZHJhc3RpYyBwZXJmb3JtYW5jZSBkaWZmZXJlbnRpYXRpb24gYmV0d2VlbiByYW5nZXMsIGFu
ZCBjb252ZXJzZWx5DQo+Pj4+IHRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IHRoYXQgbWVtb3J5ICp3
aXRoKiB0aGF0IGRlc2lnbmF0aW9uIGhhcyBhbnkNCj4+Pj4gcGVyZm9ybWFuY2UgZGlmZmVyZW5j
ZSBjb21wYXJlZCB0byB0aGUgZGVmYXVsdCBtZW1vcnkgcG9vbC4gU28gaXQNCj4+Pj4gcmVhbGx5
IGlzIGEgcmVzZXJ2YXRpb24gcG9saWN5IGFib3V0IGEgbWVtb3J5IHJhbmdlIHRvIGtlZXAgb3V0
IG9mIHRoZQ0KPj4+PiBidWRkeSBhbGxvY2F0b3IgYnkgZGVmYXVsdC4NCj4+Pg0KPj4+IE9rYXks
IHN0aWxsICJzb2Z0LXJlc2VydmVkIiBpcyB4ODYtNjQgc3BlY2lmaWMsIG5vPw0KPj4NCj4+IFRo
ZXJlJ3Mgbm90aGluZyBwcmV2ZW50aW5nIG90aGVyIEVGSSBhcmNocywgb3IgYSBzaW1pbGFyIGRl
c2lnbmF0aW9uDQo+PiBpbiBhbm90aGVyIGZpcm13YXJlIHNwZWMsIHBpY2tpbmcgdXAgdGhpcyBw
b2xpY3kuDQo+Pg0KPj4+ICAoQUZBSUssDQo+Pj4gInNvZnQtcmVzZXJ2ZWQiIHdpbGwgYmUgdmlz
aWJsZSBpbiAvcHJvYy9pb21lbSwgb3IgYW0gSSBjb25mdXNpbmcNCj4+PiBzdHVmZj8pDQo+Pg0K
Pj4gTm8sIHlvdSdyZSBjb3JyZWN0Lg0KPj4NCj4+PiBJT1csIGl0ICJwZXJmb3JtYW5jZSBkaWZm
ZXJlbnRpYXRlZCIgaXMgbm90IHVuaXZlcnNhbGx5DQo+Pj4gYXBwbGljYWJsZSwgbWF5YmUgICJz
cGVjaWZpYyBwdXJwb3NlIG1lbW9yeSIgaXMgPw0KPj4NCj4+IFRob3NlIGJpa2VzaGVkIGNvbG9y
cyBkb24ndCBzZWVtIGFuIGltcHJvdmVtZW50IHRvIG1lLg0KPj4NCj4+ICJTb2Z0LXJlc2VydmVk
IiBhY3R1YWxseSB0ZWxscyB5b3Ugc29tZXRoaW5nIGFib3V0IHRoZSBrZXJuZWwgcG9saWN5DQo+
PiBmb3IgdGhlIG1lbW9yeS4gVGhlIGNyaXRpY2lzbSBvZiAic3BlY2lmaWMgcHVycG9zZSIgdGhh
dCBsZWQgdG8NCj4+IGNhbGxpbmcgaXQgInNvZnQtcmVzZXJ2ZWQiIGluIExpbnV4IGlzIHRoZSBm
YWN0IHRoYXQgInNwZWNpZmljIiBpcw0KPj4gdW5kZWZpbmVkIGFzIGZhciBhcyB0aGUgZmlybXdh
cmUga25vd3MsIGFuZCAic3BlY2lmaWMiIG1heSBoYXZlDQo+PiBkaWZmZXJlbnQgYXBwbGljYXRp
b25zIGJhc2VkIG9uIHRoZSBwbGF0Zm9ybSB1c2VyLiAiU29mdC1yZXNlcnZlZCINCj4+IGxpa2Ug
IlJlc2VydmVkIiB0ZWxscyB5b3UgdGhhdCBhIGRyaXZlciBwb2xpY3kgbWlnaHQgYmUgaW4gcGxh
eSBmb3INCj4+IHRoYXQgbWVtb3J5Lg0KPj4NCj4+IEFsc28gbm90ZSB0aGF0IHRoZSBjdXJyZW50
IGNvbG9yIG9mIHRoZSBiaWtlc2hlZCBoYXMgYWxyZWFkeSBzaGlwcGVkIHNpbmNlIHY1LjU6DQo+
Pg0KPj4gICAyNjJiNDVhZTNhYjQgeDg2L2VmaTogRUZJIHNvZnQgcmVzZXJ2YXRpb24gdG8gRTgy
MCBlbnVtZXJhdGlvbg0KPj4NCj4gDQo+IEkgd2FzIGFza2luZyBiZWNhdXNlIEkgd2FzIHN0cnVn
Z2xpbmcgdG8gZXZlbiB1bmRlcnN0YW5kIHdoYXQg4oCec29mdC1yZXNlcnZlZOKAnCBpcyBhbmQg
SSBjb3VsZCBiZXQgbW9zdCBwZW9wbGUgaGF2ZSBubyBjbHVlIHdoYXQgdGhhdCBpcyBzdXBwb3Nl
ZCB0byBiZS4NCj4gDQo+IEluIGNvbnRyYXN0IOKAnnBlcnNpc3RlbnQgbWVtb3J54oCcIG9yIOKA
nnNwZWNpYWwgcHVycG9zZSBtZW1vcnnigJwgaW4gL3Byb2MvaW9tZW0gaXMgc29tZXRoaW5nIG5v
cm1hbCAoTGludXggdXNpbmcpIGh1bWFuIGJlaW5ncyBjYW4gdW5kZXJzdGFuZC4NCg0Kcy9ub3Jt
YWwvbW9zdC8gLCBzaG91bGRuJ3QgYmUgd3JpdGluZyBlbWFpbHMgZnJvbSBteSBzbWFydHBob25l
LiBDaGVlcnMhDQoNCg0KLS0gDQpUaGFua3MsDQoNCkRhdmlkIC8gZGhpbGRlbmINCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
