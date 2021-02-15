Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1524231B641
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 10:13:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 979F3100EB848;
	Mon, 15 Feb 2021 01:13:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCFC6100EB847
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 01:13:53 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613380431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miCNDkPWZZBRVJ8Jtr1LFzD24yWA9N0KNTV3BkO+MBs=;
	b=TETHPiEq8kl7uQEKm1Aff4L3NsQE0DM02/lfPkpKudaCI6/5lNvCven/uHuRT24qzIXWlb
	R5BxAqdLhSywOBM2nG5lWN1rFZRScNEvDlYO6zf3OlgEc7VuRTl3HqG4uIymDgc/8zHABu
	C6iAKZCoFVJI6hxssRHEbP17I8dvFo0=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9278BAD19;
	Mon, 15 Feb 2021 09:13:51 +0000 (UTC)
Date: Mon, 15 Feb 2021 10:13:50 +0100
From: Michal Hocko <mhocko@suse.com>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
Message-ID-Hash: MLWU66AEAKJNHBX4F6M6HRMRNNEKGCAL
X-Message-ID-Hash: MLWU66AEAKJNHBX4F6M6HRMRNNEKGCAL
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MLWU66AEAKJNHBX4F6M6HRMRNNEKGCAL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuIDE0LTAyLTIxIDExOjIxOjAyLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+IE9uIFN1
biwgMjAyMS0wMi0xNCBhdCAxMDo1OCArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+
IFsuLi5dDQo+ID4gPiBBbmQgaGVyZSB3ZSBjb21lIHRvIHRoZSBxdWVzdGlvbiAid2hhdCBhcmUg
dGhlIGRpZmZlcmVuY2VzIHRoYXQNCj4gPiA+IGp1c3RpZnkgYSBuZXcgc3lzdGVtIGNhbGw/IiBh
bmQgdGhlIGFuc3dlciB0byB0aGlzIGlzIHZlcnkNCj4gPiA+IHN1YmplY3RpdmUuIEFuZCBhcyBz
dWNoIHdlIGNhbiBjb250aW51ZSBiaWtlc2hlZGRpbmcgZm9yZXZlci4NCj4gPiANCj4gPiBJIHRo
aW5rIHRoaXMgZml0cyBpbnRvIHRoZSBleGlzdGluZyBtZW1mZF9jcmVhdGUoKSBzeXNjYWxsIGp1
c3QgZmluZSwNCj4gPiBhbmQgSSBoZWFyZCBubyBjb21wZWxsaW5nIGFyZ3VtZW50IHdoeSBpdCBz
aG91bGRu4oCYdC4gVGhhdOKAmHMgYWxsIEkgY2FuDQo+ID4gc2F5Lg0KPiANCj4gT0ssIHNvIGxl
dCdzIHJldmlldyBoaXN0b3J5LiAgSW4gdGhlIGZpcnN0IHR3byBpbmNhcm5hdGlvbnMgb2YgdGhl
DQo+IHBhdGNoLCBpdCB3YXMgYW4gZXh0ZW5zaW9uIG9mIG1lbWZkX2NyZWF0ZSgpLiAgVGhlIHNw
ZWNpZmljIG9iamVjdGlvbg0KPiBieSBLaXJpbGwgU2h1dGVtb3Ygd2FzIHRoYXQgaXQgZG9lc24n
dCBzaGFyZSBhbnkgY29kZSBpbiBjb21tb24gd2l0aA0KPiBtZW1mZCBhbmQgc28gc2hvdWxkIGJl
IGEgc2VwYXJhdGUgc3lzdGVtIGNhbGw6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hcGkvMjAyMDA3MTMxMDU4MTIuZG53dGRoc3V5ajN4Ymg0ZkBib3gvDQoNClRoYW5rcyBm
b3IgdGhlIHBvaW50ZXIuIEJ1dCB0aGlzIGFyZ3VtZW50IGhhc24ndCBiZWVuIGNoYWxsZW5nZWQg
YXQgYWxsLg0KSXQgaGFzbid0IGJlZW4gYnJvdWdodCB1cCB0aGF0IHRoZSBvdmVybGFwIHdvdWxk
IGJlIGNvbnNpZGVyYWJsZSBoaWdoZXINCmJ5IHRoZSBodWdldGxiL3NlYWxpbmcgc3VwcG9ydC4g
QW5kIHNvIGZhciBub2JvZHkgaGFzIGNsYWltZWQgdGhvc2UNCmNvbWJpbmF0aW9ucyBhcyB1bnZp
YWJsZS4NCg0KPiBUaGUgb3RoZXIgb2JqZWN0aW9uIHJhaXNlZCBvZmZsaXN0IGlzIHRoYXQgaWYg
d2UgZG8gdXNlIG1lbWZkX2NyZWF0ZSwNCj4gdGhlbiB3ZSBoYXZlIHRvIGFkZCBhbGwgdGhlIHNl
Y3JldCBtZW1vcnkgZmxhZ3MgYXMgYW4gYWRkaXRpb25hbCBpb2N0bCwNCj4gd2hlcmVhcyB0aGV5
IGNhbiBiZSBzcGVjaWZpZWQgb24gb3BlbiBpZiB3ZSBkbyBhIHNlcGFyYXRlIHN5c3RlbSBjYWxs
LiANCj4gVGhlIGNvbnRhaW5lciBwZW9wbGUgdmlvbGVudGx5IG9iamVjdGVkIHRvIHRoZSBpb2N0
bCBiZWNhdXNlIGl0IGNhbid0DQo+IGJlIHByb3Blcmx5IGFuYWx5c2VkIGJ5IHNlY2NvbXAgYW5k
IG11Y2ggcHJlZmVycmVkIHRoZSBzeXNjYWxsIHZlcnNpb24uDQo+IA0KPiBTaW5jZSB3ZSdyZSBk
dW1waW5nIHRoZSB1bmNhY2hlZCB2YXJpYW50LCB0aGUgaW9jdGwgcHJvYmxlbSBkaXNhcHBlYXJz
DQo+IGJ1dCBzbyBkb2VzIHRoZSBwb3NzaWJpbGl0eSBvZiBldmVyIGFkZGluZyBpdCBiYWNrIGlm
IHdlIHRha2Ugb24gdGhlDQo+IGNvbnRhaW5lciBwZW9wbGVzJyBvYmplY3Rpb24uICBUaGlzIGFy
Z3VlcyBmb3IgYSBzZXBhcmF0ZSBzeXNjYWxsDQo+IGJlY2F1c2Ugd2UgY2FuIGFkZCBhZGRpdGlv
bmFsIGZlYXR1cmVzIGFuZCBleHRlbmQgdGhlIEFQSSB3aXRoIGZsYWdzDQo+IHdpdGhvdXQgY2F1
c2luZyBhbnRpLWlvY3RsIHJpb3RzLg0KDQpJIGFtIHNvcnJ5IGJ1dCBJIGRvIG5vdCB1bmRlcnN0
YW5kIHRoaXMgYXJndW1lbnQuIFdoYXQga2luZCBvZiBmbGFncyBhcmUNCndlIHRhbGtpbmcgYWJv
dXQgYW5kIHdoeSB3b3VsZCB0aGF0IGJlIGEgcHJvYmxlbSB3aXRoIG1lbWZkX2NyZWF0ZQ0KaW50
ZXJmYWNlPyBDb3VsZCB5b3UgYmUgbW9yZSBzcGVjaWZpYyBwbGVhc2U/DQotLSANCk1pY2hhbCBI
b2Nrbw0KU1VTRSBMYWJzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAx
Lm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBs
aXN0cy4wMS5vcmcK
