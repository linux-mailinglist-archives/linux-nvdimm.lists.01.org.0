Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC60314B35
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 10:15:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 43DDC100EB35A;
	Tue,  9 Feb 2021 01:15:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A664E100EB34F
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 01:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612862138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uS7AnbSaMBJT+nB4CnATGQkmbCcT2ALwEDRI78KagxU=;
	b=DEQ9QfzRbiEiIfDxXiw6oIwNxllL3F82yeiFvH+ASc+u+8CyAhyXu6P7Et/QrPxzAOH0qf
	Z72DiRiCPSKFOBtLeqo+w+lZGu+jXn8aCrJjwQm/izBytK8VsTMSEwUPBV9tZ6qCzmKYCj
	k/0PII51pOVtcFIKIp01trDwJmBVTsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-NwZYbqYANyOm-qFvzH4vwA-1; Tue, 09 Feb 2021 04:15:34 -0500
X-MC-Unique: NwZYbqYANyOm-qFvzH4vwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBB2C79EC5;
	Tue,  9 Feb 2021 09:15:29 +0000 (UTC)
Received: from [10.36.113.141] (ovpn-113-141.ams2.redhat.com [10.36.113.141])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 282C760CEC;
	Tue,  9 Feb 2021 09:15:18 +0000 (UTC)
To: Michal Hocko <mhocko@suse.com>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
 <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <662b5871-b461-0896-697f-5e903c23d7b9@redhat.com>
Date: Tue, 9 Feb 2021 10:15:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: UCSBZ62SEC5AF4G3UH262I3NPO2R7JJ2
X-Message-ID-Hash: UCSBZ62SEC5AF4G3UH262I3NPO2R7JJ2
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UCSBZ62SEC5AF4G3UH262I3NPO2R7JJ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMDkuMDIuMjEgMDk6NTksIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4gT24gTW9uIDA4LTAyLTIx
IDIyOjM4OjAzLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+DQo+Pj4gQW0gMDguMDIuMjAy
MSB1bSAyMjoxMyBzY2hyaWViIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2VybmVsLm9yZz46DQo+Pj4N
Cj4+PiDvu79PbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAxMDoyNzoxOEFNICswMTAwLCBEYXZpZCBI
aWxkZW5icmFuZCB3cm90ZToNCj4+Pj4gT24gMDguMDIuMjEgMDk6NDksIE1pa2UgUmFwb3BvcnQg
d3JvdGU6DQo+Pj4+DQo+Pj4+IFNvbWUgcXVlc3Rpb25zIChhbmQgcmVxdWVzdCB0byBkb2N1bWVu
dCB0aGUgYW5zd2VycykgYXMgd2Ugbm93IGFsbG93IHRvIGhhdmUNCj4+Pj4gdW5tb3ZhYmxlIGFs
bG9jYXRpb25zIGFsbCBvdmVyIHRoZSBwbGFjZSBhbmQgSSBkb24ndCBzZWUgYSBzaW5nbGUgY29t
bWVudA0KPj4+PiByZWdhcmRpbmcgdGhhdCBpbiB0aGUgY292ZXIgbGV0dGVyOg0KPj4+Pg0KPj4+
PiAxLiBIb3cgd2lsbCB0aGUgaXNzdWUgb2YgcGxlbnR5IG9mIHVubW92YWJsZSBhbGxvY2F0aW9u
cyBmb3IgdXNlciBzcGFjZSBiZQ0KPj4+PiB0YWNrbGVkIGluIHRoZSBmdXR1cmU/DQo+Pj4+DQo+
Pj4+IDIuIEhvdyBoYXMgdGhpcyBpc3N1ZSBiZWVuIGRvY3VtZW50ZWQ/IEUuZy4sIGludGVyYWN0
aW9uIHdpdGggWk9ORV9NT1ZBQkxFDQo+Pj4+IGFuZCBDTUEsIGFsbG9jX2NvbmlnX3JhbmdlKCkv
YWxsb2NfY29udGlnX3BhZ2VzPy4NCj4+Pg0KPj4+IFNlY3JldG1lbSBzZXRzIHRoZSBtYXBwaW5n
cyBnZnAgbWFzayB0byBHRlBfSElHSFVTRVIsIHNvIGl0IGRvZXMgbm90DQo+Pj4gYWxsb2NhdGUg
bW92YWJsZSBwYWdlcyBhdCB0aGUgZmlyc3QgcGxhY2UuDQo+Pg0KPj4gVGhhdCBpcyBub3QgdGhl
IHBvaW50LiBTZWNyZXRtZW0gY2Fubm90IGdvIG9uIENNQSAvIFpPTkVfTU9WQUJMRQ0KPj4gbWVt
b3J5IGFuZCBiZWhhdmVzIGxpa2UgbG9uZy10ZXJtIHBpbm5pbmdzIGluIHRoYXQgc2Vuc2UuIFRo
aXMgaXMgYQ0KPj4gcmVhbCBpc3N1ZSB3aGVuIHVzaW5nIGEgbG90IG9mIHNlY3RyZW1lbS4NCj4g
DQo+IEEgbG90IG9mIHVuZXZpY3RhYmxlIG1lbW9yeSBpcyBhIGNvbmNlcm4gcmVnYXJkbGVzcyBv
ZiBDTUEvWk9ORV9NT1ZBQkxFLg0KPiBBcyBJJ3ZlIHNhaWQgaXQgaXMgcXVpdGUgZWFzeSB0byBs
YW5kIGF0IHRoZSBzaW1pbGFyIHNpdHVhdGlvbiBldmVuIHdpdGgNCj4gdG1wZnMvTUFQX0FOT058
TUFQX1NIQVJFRCBvbiBzd2FwbGVzcyBzeXN0ZW0uIE5laXRoZXIgb2YgdGhlIHR3byBpcw0KPiBy
ZWFsbHkgdW5jb21tb24uIEl0IHdvdWxkIGJlIGV2ZW4gd29yc2UgdGhhdCB0aG9zZSB3b3VsZCBi
ZSBhbGxvd2VkIHRvDQo+IGNvbnN1bWUgYm90aCBDTUEvWk9ORV9NT1ZBQkxFLg0KDQpJSVJDLCB0
bXBmcy9NQVBfQU5PTnxNQVBfU0hBUkVEIG1lbW9yeQ0KYSkgSXMgbW92YWJsZSwgY2FuIGxhbmQg
aW4gWk9ORV9NT1ZBQkxFL0NNQQ0KYikgQ2FuIGJlIGxpbWl0ZWQgYnkgc2l6aW5nIHRtcGZzIGFw
cHJvcHJpYXRlbHkNCg0KQUZBSUssIHdoYXQgeW91IGRlc2NyaWJlIGlzIGEgcHJvYmxlbSB3aXRo
IG1lbW9yeSBvdmVyY29tbWl0LCBub3Qgd2l0aCANCnpvbmUgaW1iYWxhbmNlcyAoYmVsb3cpLiBP
ciB3aGF0IGFtIEkgbWlzc2luZz8NCg0KPiANCj4gT25lIGhhcyB0byBiZSB2ZXJ5IGNhcmVmdWwg
d2hlbiByZWx5aW5nIG9uIENNQSBvciBtb3ZhYmxlIHpvbmVzLiBUaGlzIGlzDQo+IGRlZmluaXRl
bHkgd29ydGggYSBjb21tZW50IGluIHRoZSBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlcg0K
PiBkb2N1bWVudGF0aW9uLiBCdXQgdGhpcyBpcyBub3QgYSBuZXcgcHJvYmxlbS4NCg0KSSBzZWUg
dGhlIGZvbGxvd2luZyB0aGluZyB3b3J0aCBkb2N1bWVudGluZzoNCg0KQXNzdW1lIHlvdSBoYXZl
IGEgc3lzdGVtIHdpdGggMkdCIG9mIFpPTkVfTk9STUFML1pPTkVfRE1BIGFuZCA0R0Igb2YgDQpa
T05FX01PVkFCTEUvQ01BLg0KDQpBc3N1bWUgeW91IG1ha2UgdXNlIG9mIDEuNUdCIG9mIHNlY3Jl
dG1lbS4gWW91ciBzeXN0ZW0gbWlnaHQgcnVuIGludG8gDQpPT00gYW55IHRpbWUgYWx0aG91Z2gg
eW91IHN0aWxsIGhhdmUgcGxlbnR5IG9mIG1lbW9yeSBvbiBaT05FX01PVkFWTEUgDQooYW5kIGV2
ZW4gc3dhcCEpLCBzaW1wbHkgYmVjYXVzZSB5b3UgYXJlIG1ha2luZyBleGNlc3NpdmUgdXNlIG9m
IA0KdW5tb3ZhYmxlIGFsbG9jYXRpb25zIChmb3IgdXNlciBzcGFjZSEpIGluIGFuIGVudmlyb25t
ZW50IHdoZXJlIHlvdSANCnNob3VsZCBub3QgbWFrZSBleGNlc3NpdmUgdXNlIG9mIHVubW92YWJs
ZSBhbGxvY2F0aW9ucyAoZS5nLiwgd2hlcmUgDQpzaG91bGQgcGFnZSB0YWJsZXMgZ28/KS4NCg0K
VGhlIGV4aXN0aW5nIGNvbnRyb2xzIChtbG9jayBsaW1pdCkgZG9uJ3QgcmVhbGx5IG1hdGNoIHRo
ZSBjdXJyZW50IA0Kc2VtYW50aWNzIG9mIHRoYXQgbWVtb3J5LiBJIHJlcGVhdCBpdCBvbmNlIGFn
YWluOiBzZWNyZXRtZW0gKmN1cnJlbnRseSogDQpyZXNlbWJsZXMgbG9uZy10ZXJtIHBpbm5lZCBt
ZW1vcnksIG5vdCBtbG9ja2VkIG1lbW9yeS4gVGhpbmdzIHdpbGwgDQpjaGFuZ2Ugd2hlbiBpbXBs
ZW1lbnRpbmcgbWlncmF0aW9uIHN1cHBvcnQgZm9yIHNlY3JldG1lbSBwYWdlcy4gVW50aWwgDQp0
aGVuLCB0aGUgc2VtYW50aWNzIGFyZSBkaWZmZXJlbnQgYW5kIHRoaXMgc2hvdWxkIGJlIHNwZWxs
ZWQgb3V0Lg0KDQpGb3IgbG9uZy10ZXJtIHBpbm5pbmdzIHRoaXMgaXMga2luZCBvZiBvYnZpb3Vz
LCBzdGlsbCB3ZSdyZSBub3cgDQpkb2N1bWVudGluZyBpdCBiZWNhdXNlIGl0J3MgZGFuZ2Vyb3Vz
IHRvIG5vdCBiZSBhd2FyZSBvZi4gU2VjcmV0bWVtIA0KYmVoYXZlcyBleGFjdGx5IHRoZSBzYW1l
IGFuZCBJIHRoaW5rIHRoaXMgaXMgd29ydGggc3BlbGxpbmcgb3V0OiANCnNlY3JldG1lbSBoYXMg
dGhlIHBvdGVudGlhbCBvZiBiZWluZyB1c2VkIG11Y2ggbW9yZSBvZnRlbiB0aGFuIGZhaXJseSAN
CnNwZWNpYWwgdmZpby9yZG1hLyAuLi4NCg0KTG9va2luZyBhdCBhIGNvdmVyIGxldHRlciB0aGF0
IGRvZXNuJ3QgZXZlbiBtZW50aW9uIHRoZSBpc3N1ZSBvZiANCnVubW92YWJsZSBhbGxvY2F0aW9u
cyBtYWtlcyBtZSB0aGluZyB0aGF0IHdlIGFyZSBlaXRoZXIgdHJ5aW5nIHRvIGlnbm9yZSANCnRo
ZSBwcm9ibGVtIG9yIGFyZSBub3QgYXdhcmUgb2YgdGhlIHByb2JsZW0uDQoNCi0tIA0KVGhhbmtz
LA0KDQpEYXZpZCAvIGRoaWxkZW5iDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
