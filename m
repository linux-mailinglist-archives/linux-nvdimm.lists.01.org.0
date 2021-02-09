Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47220314AF4
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 09:59:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73165100EBB72;
	Tue,  9 Feb 2021 00:59:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF443100EC1E8
	for <linux-nvdimm@lists.01.org>; Tue,  9 Feb 2021 00:59:33 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1612861172; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qKmPZ6awqg5hjlBR0sI2r8zXB8YBdpf3Fstd9lWw2l4=;
	b=p4niOOYBVsAxuZvLvSyfuqafhhIwTbqalQ0XUlb0o+XPLT9GQJWEuScror9bMiRAM/VDNR
	Gg1qoKrVPkiLaebs0ekDczrIK91xZLqc+rSpU+PO8Uxxh1llnmK79t7ldLJZVcdfnC2J7E
	dBwPdj8xY5v0EllSgVlDCcSTDxSJc8Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 14A0BAB71;
	Tue,  9 Feb 2021 08:59:32 +0000 (UTC)
Date: Tue, 9 Feb 2021 09:59:31 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCJO8zLq8YkXGy8B@dhcp22.suse.cz>
References: <20210208211326.GV242749@kernel.org>
 <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
Message-ID-Hash: CQE427UAKGZB6QEHKEUGGS4DH42ZZEH2
X-Message-ID-Hash: CQE427UAKGZB6QEHKEUGGS4DH42ZZEH2
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CQE427UAKGZB6QEHKEUGGS4DH42ZZEH2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uIDA4LTAyLTIxIDIyOjM4OjAzLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gDQo+
ID4gQW0gMDguMDIuMjAyMSB1bSAyMjoxMyBzY2hyaWViIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2Vy
bmVsLm9yZz46DQo+ID4gDQo+ID4g77u/T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMTA6Mjc6MThB
TSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+ID4+IE9uIDA4LjAyLjIxIDA5OjQ5
LCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+PiANCj4gPj4gU29tZSBxdWVzdGlvbnMgKGFuZCBy
ZXF1ZXN0IHRvIGRvY3VtZW50IHRoZSBhbnN3ZXJzKSBhcyB3ZSBub3cgYWxsb3cgdG8gaGF2ZQ0K
PiA+PiB1bm1vdmFibGUgYWxsb2NhdGlvbnMgYWxsIG92ZXIgdGhlIHBsYWNlIGFuZCBJIGRvbid0
IHNlZSBhIHNpbmdsZSBjb21tZW50DQo+ID4+IHJlZ2FyZGluZyB0aGF0IGluIHRoZSBjb3ZlciBs
ZXR0ZXI6DQo+ID4+IA0KPiA+PiAxLiBIb3cgd2lsbCB0aGUgaXNzdWUgb2YgcGxlbnR5IG9mIHVu
bW92YWJsZSBhbGxvY2F0aW9ucyBmb3IgdXNlciBzcGFjZSBiZQ0KPiA+PiB0YWNrbGVkIGluIHRo
ZSBmdXR1cmU/DQo+ID4+IA0KPiA+PiAyLiBIb3cgaGFzIHRoaXMgaXNzdWUgYmVlbiBkb2N1bWVu
dGVkPyBFLmcuLCBpbnRlcmFjdGlvbiB3aXRoIFpPTkVfTU9WQUJMRQ0KPiA+PiBhbmQgQ01BLCBh
bGxvY19jb25pZ19yYW5nZSgpL2FsbG9jX2NvbnRpZ19wYWdlcz8uDQo+ID4gDQo+ID4gU2VjcmV0
bWVtIHNldHMgdGhlIG1hcHBpbmdzIGdmcCBtYXNrIHRvIEdGUF9ISUdIVVNFUiwgc28gaXQgZG9l
cyBub3QNCj4gPiBhbGxvY2F0ZSBtb3ZhYmxlIHBhZ2VzIGF0IHRoZSBmaXJzdCBwbGFjZS4NCj4g
DQo+IFRoYXQgaXMgbm90IHRoZSBwb2ludC4gU2VjcmV0bWVtIGNhbm5vdCBnbyBvbiBDTUEgLyBa
T05FX01PVkFCTEUNCj4gbWVtb3J5IGFuZCBiZWhhdmVzIGxpa2UgbG9uZy10ZXJtIHBpbm5pbmdz
IGluIHRoYXQgc2Vuc2UuIFRoaXMgaXMgYQ0KPiByZWFsIGlzc3VlIHdoZW4gdXNpbmcgYSBsb3Qg
b2Ygc2VjdHJlbWVtLg0KDQpBIGxvdCBvZiB1bmV2aWN0YWJsZSBtZW1vcnkgaXMgYSBjb25jZXJu
IHJlZ2FyZGxlc3Mgb2YgQ01BL1pPTkVfTU9WQUJMRS4NCkFzIEkndmUgc2FpZCBpdCBpcyBxdWl0
ZSBlYXN5IHRvIGxhbmQgYXQgdGhlIHNpbWlsYXIgc2l0dWF0aW9uIGV2ZW4gd2l0aA0KdG1wZnMv
TUFQX0FOT058TUFQX1NIQVJFRCBvbiBzd2FwbGVzcyBzeXN0ZW0uIE5laXRoZXIgb2YgdGhlIHR3
byBpcw0KcmVhbGx5IHVuY29tbW9uLiBJdCB3b3VsZCBiZSBldmVuIHdvcnNlIHRoYXQgdGhvc2Ug
d291bGQgYmUgYWxsb3dlZCB0bw0KY29uc3VtZSBib3RoIENNQS9aT05FX01PVkFCTEUuDQoNCk9u
ZSBoYXMgdG8gYmUgdmVyeSBjYXJlZnVsIHdoZW4gcmVseWluZyBvbiBDTUEgb3IgbW92YWJsZSB6
b25lcy4gVGhpcyBpcw0KZGVmaW5pdGVseSB3b3J0aCBhIGNvbW1lbnQgaW4gdGhlIGtlcm5lbCBj
b21tYW5kIGxpbmUgcGFyYW1ldGVyDQpkb2N1bWVudGF0aW9uLiBCdXQgdGhpcyBpcyBub3QgYSBu
ZXcgcHJvYmxlbS4NCg0KLS0gDQpNaWNoYWwgSG9ja28NClNVU0UgTGFicwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
