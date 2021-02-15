Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93F31C25E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Feb 2021 20:20:54 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90D94100ED480;
	Mon, 15 Feb 2021 11:20:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1A21100EF265
	for <linux-nvdimm@lists.01.org>; Mon, 15 Feb 2021 11:20:49 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1613416848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35iSk0+5UfxNhbQoMoqK8Z0u+AvwuK5VeLDZ0BFtGgc=;
	b=LxudusPDnEIzx32bpsNd8eGk9aEHEp8nORbgbhfo9m/WaYQJNvskWIV49SwUk+3e+wUm6W
	bvkuJfdiurilR7t9l+AqCl48/0xWlWnh1jxDaWj32SfJk9fDbkh0PhlICshQRWBYaiM9H0
	Cssa+KhpPwQxypJN/O8+L/ThpHbYF+4=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id C9B2BAC32;
	Mon, 15 Feb 2021 19:20:47 +0000 (UTC)
Date: Mon, 15 Feb 2021 20:20:45 +0100
From: Michal Hocko <mhocko@suse.com>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <YCrJjYmr7A2nO6lA@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
 <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
 <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
 <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
 <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
Message-ID-Hash: BGR2LYXYPLYLBYVPKLKAD5QLJ4DDK32D
X-Message-ID-Hash: BGR2LYXYPLYLBYVPKLKAD5QLJ4DDK32D
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Ander
 sen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BGR2LYXYPLYLBYVPKLKAD5QLJ4DDK32D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uIDE1LTAyLTIxIDEwOjE0OjQzLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6DQo+IE9uIE1v
biwgMjAyMS0wMi0xNSBhdCAxMDoxMyArMDEwMCwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiA+IE9u
IFN1biAxNC0wMi0yMSAxMToyMTowMiwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOg0KPiA+ID4gT24g
U3VuLCAyMDIxLTAyLTE0IGF0IDEwOjU4ICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToN
Cj4gPiA+IFsuLi5dDQo+ID4gPiA+ID4gQW5kIGhlcmUgd2UgY29tZSB0byB0aGUgcXVlc3Rpb24g
IndoYXQgYXJlIHRoZSBkaWZmZXJlbmNlcyB0aGF0DQo+ID4gPiA+ID4ganVzdGlmeSBhIG5ldyBz
eXN0ZW0gY2FsbD8iIGFuZCB0aGUgYW5zd2VyIHRvIHRoaXMgaXMgdmVyeQ0KPiA+ID4gPiA+IHN1
YmplY3RpdmUuIEFuZCBhcyBzdWNoIHdlIGNhbiBjb250aW51ZSBiaWtlc2hlZGRpbmcgZm9yZXZl
ci4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgdGhpcyBmaXRzIGludG8gdGhlIGV4aXN0aW5n
IG1lbWZkX2NyZWF0ZSgpIHN5c2NhbGwganVzdA0KPiA+ID4gPiBmaW5lLCBhbmQgSSBoZWFyZCBu
byBjb21wZWxsaW5nIGFyZ3VtZW50IHdoeSBpdCBzaG91bGRu4oCYdC4gVGhhdOKAmHMNCj4gPiA+
ID4gYWxsIEkgY2FuIHNheS4NCj4gPiA+IA0KPiA+ID4gT0ssIHNvIGxldCdzIHJldmlldyBoaXN0
b3J5LiAgSW4gdGhlIGZpcnN0IHR3byBpbmNhcm5hdGlvbnMgb2YgdGhlDQo+ID4gPiBwYXRjaCwg
aXQgd2FzIGFuIGV4dGVuc2lvbiBvZiBtZW1mZF9jcmVhdGUoKS4gIFRoZSBzcGVjaWZpYw0KPiA+
ID4gb2JqZWN0aW9uIGJ5IEtpcmlsbCBTaHV0ZW1vdiB3YXMgdGhhdCBpdCBkb2Vzbid0IHNoYXJl
IGFueSBjb2RlIGluDQo+ID4gPiBjb21tb24gd2l0aCBtZW1mZCBhbmQgc28gc2hvdWxkIGJlIGEg
c2VwYXJhdGUgc3lzdGVtIGNhbGw6DQo+ID4gPiANCj4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWFwaS8yMDIwMDcxMzEwNTgxMi5kbnd0ZGhzdXlqM3hiaDRmQGJveC8NCj4gPiAN
Cj4gPiBUaGFua3MgZm9yIHRoZSBwb2ludGVyLiBCdXQgdGhpcyBhcmd1bWVudCBoYXNuJ3QgYmVl
biBjaGFsbGVuZ2VkIGF0DQo+ID4gYWxsLiBJdCBoYXNuJ3QgYmVlbiBicm91Z2h0IHVwIHRoYXQg
dGhlIG92ZXJsYXAgd291bGQgYmUgY29uc2lkZXJhYmxlDQo+ID4gaGlnaGVyIGJ5IHRoZSBodWdl
dGxiL3NlYWxpbmcgc3VwcG9ydC4gQW5kIHNvIGZhciBub2JvZHkgaGFzIGNsYWltZWQNCj4gPiB0
aG9zZSBjb21iaW5hdGlvbnMgYXMgdW52aWFibGUuDQo+IA0KPiBLaXJpbGwgaXMgYWN0dWFsbHkg
aW50ZXJlc3RlZCBpbiB0aGUgc2VhbGluZyBwYXRoIGZvciBoaXMgS1ZNIGNvZGUgc28NCj4gd2Ug
dG9vayBhIGxvb2suICBUaGVyZSBtaWdodCBiZSBhIHR3byBsaW5lIG92ZXJsYXAgaW4gbWVtZmRf
Y3JlYXRlIGZvcg0KPiB0aGUgc2VhbCBjYXNlLCBidXQgdGhlcmUncyBubyByZWFsIG92ZXJsYXAg
aW4gbWVtZmRfYWRkX3NlYWxzIHdoaWNoIGlzDQo+IHRoZSBidWxrIG9mIHRoZSBjb2RlLiAgU28g
dGhlIGJlc3Qgd2F5IHdvdWxkIHNlZW0gdG8gbGlmdCB0aGUgaW5vZGUgLi4uDQo+IC0+IHNlYWxz
IGhlbHBlcnMgdG8gYmUgbm9uLXN0YXRpYyBzbyB0aGV5IGNhbiBiZSByZXVzZWQgYW5kIHJvbGwg
b3VyDQo+IG93biBhZGRfc2VhbHMuDQoNClRoZXNlIGFyZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
IHdoaWNoIGFyZSBub3QgcmVhbGx5IHJlbGV2YW50IHRvIHRoZQ0KQVBJIElNSE8uIA0KDQo+IEkg
Y2FuJ3Qgc2VlIGEgdXNlIGNhc2UgYXQgYWxsIGZvciBodWdldGxiIHN1cHBvcnQsIHNvIGl0IHNl
ZW1zIHRvIGJlIGENCj4gYml0IG9mIGFuIGFuZ2VscyBvbiBwaW4gaGVhZCBkaXNjdXNzaW9uLiAg
SG93ZXZlciwgaWYgb25lIHdlcmUgdG8gY29tZQ0KPiBhbG9uZyBoYW5kbGluZyBpdCBpbiB0aGUg
c2FtZSB3YXkgc2VlbXMgcmVhc29uYWJsZS4NCg0KVGhvc2UgYW5nZWxzIGhhdmUgbWFkZSB0aGVp
ciB3YXkgdG8gbW1hcCwgU3lzdGVtIFYgc2htLCBtZW1mZF9jcmVhdGUgYW5kDQpvdGhlciBNTSBp
bnRlcmZhY2VzIHdoaWNoIGhhdmUgbmV2ZXIgZW52aXNpb25lZCB3aGVuIGludHJvZHVjZWQuIEh1
Z2V0bGINCnBhZ2VzIHRvIGJhY2sgZ3Vlc3QgbWVtb3J5IGlzIHF1aXRlIGEgY29tbW9uIHVzZWNh
c2Ugc28gd2h5IGRvIHlvdSB0aGluaw0KdGhvc2UgZ3Vlc3RzIHdvdWxkbid0IGxpa2UgdG8gc2Vl
IHRoZWlyIG1lbW9yeSBiZSAic2VjcmV0Ij8NCg0KQXMgSSd2ZSBzYWlkIGluIG15IGxhc3QgcmVz
cG9uc2UgKFlDWkVHdUxLOTRzektaRGZAZGhjcDIyLnN1c2UuY3opLCBJIGFtDQpub3QgZ29pbmcg
dG8gYXJndWUgYWxsIHRoZXNlIGFnYWluLiBJIGhhdmUgbWFkZSBteSBwb2ludCBhbmQgeW91IGFy
ZQ0KZnJlZSB0byB0YWtlIGl0IG9yIGxlYXZlIGl0Lg0KDQo+ID4gPiBUaGUgb3RoZXIgb2JqZWN0
aW9uIHJhaXNlZCBvZmZsaXN0IGlzIHRoYXQgaWYgd2UgZG8gdXNlDQo+ID4gPiBtZW1mZF9jcmVh
dGUsIHRoZW4gd2UgaGF2ZSB0byBhZGQgYWxsIHRoZSBzZWNyZXQgbWVtb3J5IGZsYWdzIGFzIGFu
DQo+ID4gPiBhZGRpdGlvbmFsIGlvY3RsLCB3aGVyZWFzIHRoZXkgY2FuIGJlIHNwZWNpZmllZCBv
biBvcGVuIGlmIHdlIGRvIGENCj4gPiA+IHNlcGFyYXRlIHN5c3RlbSBjYWxsLiAgVGhlIGNvbnRh
aW5lciBwZW9wbGUgdmlvbGVudGx5IG9iamVjdGVkIHRvDQo+ID4gPiB0aGUgaW9jdGwgYmVjYXVz
ZSBpdCBjYW4ndCBiZSBwcm9wZXJseSBhbmFseXNlZCBieSBzZWNjb21wIGFuZCBtdWNoDQo+ID4g
PiBwcmVmZXJyZWQgdGhlIHN5c2NhbGwgdmVyc2lvbi4NCj4gPiA+IA0KPiA+ID4gU2luY2Ugd2Un
cmUgZHVtcGluZyB0aGUgdW5jYWNoZWQgdmFyaWFudCwgdGhlIGlvY3RsIHByb2JsZW0NCj4gPiA+
IGRpc2FwcGVhcnMgYnV0IHNvIGRvZXMgdGhlIHBvc3NpYmlsaXR5IG9mIGV2ZXIgYWRkaW5nIGl0
IGJhY2sgaWYgd2UNCj4gPiA+IHRha2Ugb24gdGhlIGNvbnRhaW5lciBwZW9wbGVzJyBvYmplY3Rp
b24uICBUaGlzIGFyZ3VlcyBmb3IgYQ0KPiA+ID4gc2VwYXJhdGUgc3lzY2FsbCBiZWNhdXNlIHdl
IGNhbiBhZGQgYWRkaXRpb25hbCBmZWF0dXJlcyBhbmQgZXh0ZW5kDQo+ID4gPiB0aGUgQVBJIHdp
dGggZmxhZ3Mgd2l0aG91dCBjYXVzaW5nIGFudGktaW9jdGwgcmlvdHMuDQo+ID4gDQo+ID4gSSBh
bSBzb3JyeSBidXQgSSBkbyBub3QgdW5kZXJzdGFuZCB0aGlzIGFyZ3VtZW50Lg0KPiANCj4gWW91
IGRvbid0IHVuZGVyc3RhbmQgd2h5IGNvbnRhaW5lciBndWFyZGluZyB0ZWNobm9sb2d5IGRvZXNu
J3QgbGlrZQ0KPiBpb2N0bHM/DQoNCk5vLCBJIGRpZCBub3Qgc2VlIHdoZXJlIHRoZSBpb2N0bCBh
cmd1bWVudCBjYW1lIGZyb20uDQoNClsuLi5dDQoNCj4gPiAgV2hhdCBraW5kIG9mIGZsYWdzIGFy
ZSB3ZSB0YWxraW5nIGFib3V0IGFuZCB3aHkgd291bGQgdGhhdCBiZSBhDQo+ID4gcHJvYmxlbSB3
aXRoIG1lbWZkX2NyZWF0ZSBpbnRlcmZhY2U/IENvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljDQo+
ID4gcGxlYXNlPw0KPiANCj4gWW91IG1lYW4gd2hhdCB3ZXJlIHRoZSBpb2N0bCBmbGFncyBpbiB0
aGUgcGF0Y2ggc2VyaWVzIGxpbmtlZCBhYm92ZT8gDQo+IFRoZXkgd2VyZSBTRUNSRVRNRU1fRVhD
TFVTSVZFIGFuZCBTRUNSRVRNRU1fVU5DQUNIRUQgaW4gcGF0Y2ggMy81LiANCg0KT0sgSSBzZWUu
IEhvdyBtYW55IHBvdGVudGlhbCBtb2RlcyBhcmUgd2UgdGFsa2luZyBhYm91dD8gQSBmZXcgb3IN
CnBvdGVudGlhbGx5IG1hbnk/DQoNCj4gVGhleSB3ZXJlIGV2ZW50dWFsbHkgZHJvcHBlZCBhZnRl
ciB2MTAsIGJlY2F1c2Ugb2YgcHJvYmxlbXMgd2l0aA0KPiBhcmNoaXRlY3R1cmFsIHNlbWFudGlj
cywgd2l0aCB0aGUgaWRlYSB0aGF0IGl0IGNvdWxkIGJlIGFkZGVkIGJhY2sNCj4gYWdhaW4gaWYg
YSBjb21wZWxsaW5nIG5lZWQgYXJvc2U6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1hcGkvMjAyMDExMjMwOTU0MzIuNTg2MC0xLXJwcHRAa2VybmVsLm9yZy8NCj4gDQo+IElu
IHRoZW9yeSB0aGUgZXh0cmEgZmxhZ3MgY291bGQgYmUgbXVsdGlwbGV4ZWQgaW50byB0aGUgbWVt
ZmRfY3JlYXRlDQo+IGZsYWdzIGxpa2UgaHVnZXRsYmZzIGlzIGJ1dCB3aXRoIDMyIGZsYWdzIGFu
ZCBhIGxvdCBhbHJlYWR5IHRha2VuIGl0DQo+IGdldHMgbWVzc3kgZm9yIGV4cGFuc2lvbi4gIFdo
ZW4gd2UgcnVuIG91dCBvZiBmbGFncyB0aGUgZmlyc3QgcXVlc3Rpb24NCj4gcGVvcGxlIHdpbGwg
YXNrIGlzICJ3aHkgZGlkbid0IHlvdSBkbyBzZXBhcmF0ZSBzeXN0ZW0gY2FsbHM/Ii4NCg0KT0ss
IEkgZG8gbm90IG5lY2Vzc2FyaWx5IHNlZSBhIGxhY2sgb2YgZmxhZyBzcGFjZSBhIHByb2JsZW0u
IEkgY2FuIGJlDQp3cm9uZyBoZXJlIGJ1dCBJIGRvIG5vdCBzZWUgaG93IHRoYXQgd291bGQgYmUg
c29sdmVkIGJ5IGEgc2VwYXJhdGUNCnN5c2NhbGwgd2hlbiBpdCBzb3VuZHMgcmF0aGVyIGZvcnNl
ZWFibGUgdGhhdCBtYW55IG1vZGVzIHN1cHBvcnRlZCBieQ0KbWVtZmRfY3JlYXRlIHdpbGwgZXZl
bnR1YWxseSBmaW5kIHRoZWlyIHdheSB0byBhIHNlY3JldCBtZW1vcnkgYXMgd2VsbC4NCklmIGZv
ciBubyBvdGhlciByZWFzb24sIHNlY3JldCBtZW1vcnkgaXMgbm90aGluZyByZWFsbHkgc3BlY2lh
bC4gSXQgaXMNCmp1c3QgYSBtZW1vcnkgd2hpY2ggaXMgbm90IG1hcHBlZCB0byB0aGUga2VybmVs
IHZpYSAxOjEgbWFwcGluZy4gVGhhdCdzDQppdC4gQW5kIHRoYXQgY2FuIGJlIGFwcGxpZWQgdG8g
YW55IG1lbW9yeSBwcm92aWRlZCB0byB0aGUgdXNlcnNwYWNlLg0KDQpCdXQgSSBhbSByZXBlYXRp
bmcgbXlzZWxmIGFnYWluIGhlcmUgc28gSSBiZXR0ZXIgc3RvcC4NCi0tIA0KTWljaGFsIEhvY2tv
DQpTVVNFIExhYnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
