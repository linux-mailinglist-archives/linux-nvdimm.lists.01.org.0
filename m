Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078322B6931
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Nov 2020 16:58:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62B95100ED49C;
	Tue, 17 Nov 2020 07:58:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1F317100ED49A
	for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 07:58:42 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D3B60238E6;
	Tue, 17 Nov 2020 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605628721;
	bh=9is+MjALfTGepw57FVx0JouySPxlzfHt3CDVLQ4Unmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8sWlliyDkUNYoXZjFWSoiuQvdgEZNX+2SxP4AeRu3E6J1nQ7q1oTfz+6Ip2yE0wn
	 cmwAFaK1S/AmhU4S6q0bHx0jhCupiexg9VCuzKWD3rTOMD16YOJ0wT4exivwNxppfK
	 VG9oFzcdjadQK9Y3xyHqBPePYLUqwIL58wy/neZo=
Date: Tue, 17 Nov 2020 17:58:29 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Message-ID: <20201117155829.GJ370813@kernel.org>
References: <20201112190827.GP4758@kernel.org>
 <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
 <20201115082625.GT4758@kernel.org>
 <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
Message-ID-Hash: H4CBHY4YF7CRIPVEJGTJR7437KPVG5SX
X-Message-ID-Hash: H4CBHY4YF7CRIPVEJGTJR7437KPVG5SX
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H4CBHY4YF7CRIPVEJGTJR7437KPVG5SX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBOb3YgMTcsIDIwMjAgYXQgMDQ6MDk6MzlQTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDE1LjExLjIwIDA5OjI2LCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPiA+
IE9uIFRodSwgTm92IDEyLCAyMDIwIGF0IDA5OjE1OjE4UE0gKzAxMDAsIERhdmlkIEhpbGRlbmJy
YW5kIHdyb3RlOg0KDQouLi4NCg0KPiA+IE15IHRoaW5raW5nIHdhcyB0aGF0IHNpbmNlIHNlY3Jl
dG1lbSBkb2VzIHdoYXQgbWxvY2soKSBkb2VzIHdydA0KPiA+IHN3YXBhYmlsaXR5LCBpdCBzaG91
bGQgYXQgbGVhc3Qgb2JleSB0aGUgc2FtZSBsaW1pdCwgaS5lLg0KPiA+IFJMSU1JVF9NRU1MT0NL
Lg0KPiANCj4gUmlnaHQsIGJ1dCBhdCBsZWFzdCBjdXJyZW50bHksIGl0IGJlaGF2ZXMgbGlrZSBh
bnkgb3RoZXIgQ01BIGFsbG9jYXRpb24NCj4gKElJUkMgdGhleSBhcmUgYWxsIHVubW92YWJsZSBh
bmQsIHRoZXJlZm9yZSwgbm90IHN3YXBwYWJsZSkuIEluIHRoZSBmdXR1cmUsDQo+IGlmIHBhZ2Vz
IHdvdWxkIGJlIG1vdmFibGUgKGJ1dCBub3Qgc3dhcHBhYmxlKSwgSSBndWVzcyBpdCBtaWdodCBt
YWtlcyBtb3JlDQo+IHNlbnNlLiBJIGFzc3VtZSB3ZSBuZXZlciBldmVyIHdhbnQgdG8gc3dhcCBz
ZWNyZXRtZW0uDQo+IA0KPiAibWFuIGdldHJsaW1pdCIgc3RhdGVzIGZvciBSTElNSVRfTUVNTE9D
SzoNCj4gDQo+ICJUaGlzIGlzIHRoZSBtYXhpbXVtIG51bWJlciBvZiBieXRlcyBvZiBtZW1vcnkg
dGhhdCBtYXkgYmUNCj4gIGxvY2tlZCBpbnRvIFJBTS4gIFsuLi5dIFRoaXMgbGltaXQgYWZmZWN0
cw0KPiAgbWxvY2soMiksIG1sb2NrYWxsKDIpLCBhbmQgdGhlIG1tYXAoMikgTUFQX0xPQ0tFRCBv
cGVyYXRpb24uDQo+ICBTaW5jZSBMaW51eCAyLjYuOSwgaXQgYWxzbyBhZmZlY3RzIHRoZSBzaG1j
dGwoMikgU0hNX0xPQ0sgb3DigJANCj4gIGVyYXRpb24gWy4uLl0iDQo+IA0KPiBTbyB0aGF0IHBs
YWNlIGhhcyB0byBiZSB1cGRhdGVkIGFzIHdlbGwgSSBndWVzcz8gT3RoZXJ3aXNlIHRoaXMgbWln
aHQgY29tZQ0KPiBhcyBhIHN1cnByaXNlIGZvciB1c2Vycy4NCg0KU3VyZS4NCg0KPiA+IA0KPiA+
ID4gRS5nLiwgd2UgYWxzbyBkb27igJh0DQo+ID4gPiBhY2NvdW50IGZvciBnaWdhbnRpYyBwYWdl
cyAtIHdoaWNoIG1pZ2h0IGJlIGFsbG9jYXRlZCBmcm9tIENNQSBhbmQgYXJlDQo+ID4gPiBub3Qg
c3dhcHBhYmxlLg0KPiA+IERvIHlvdSBtZWFuIGdpZ2FudGljIHBhZ2VzIGluIGh1Z2V0bGJmcz8N
Cj4gDQo+IFllcw0KPiANCj4gPiBJdCBzZWVtcyB0byBtZSB0aGF0IGh1Z2V0bGJmcyBhY2NvdW50
aW5nIGlzIGEgY29tcGxldGVseSBkaWZmZXJlbnQNCj4gPiBzdG9yeS4NCj4gDQo+IEknZCBzYXkg
aXQgaXMgcmlnaHQgbm93IGNvbXBhcmFibGUgdG8gc2VjcmV0bWVtIC0gd2hpY2ggaXMgd2h5IEkg
dGhvdWdoDQo+IHNpbWlsYXIgYWNjb3VudGluZyB3b3VsZCBtYWtlIHNlbnNlLg0KDQpJTUhPLCB1
c2luZyBSTElNSVRfTUVNTE9DSyBhbmQgbWVtY2cgaXMgYSBtb3JlIHN0cmFpZ2h0Zm9yd2FyZCB3
YXkgdGhhbg0KYSBjdXN0b20gY2dyb3VwLg0KDQpBbmQgaWYgd2UnbGwgc2VlIGEgbmVlZCBmb3Ig
YWRkaXRpb25hbCBtZWNoYW5pc20sIHdlIGNhbiBhbHdheXMgYWRkIGl0Lg0KIA0KPiAtLSANCj4g
VGhhbmtzLA0KPiANCj4gRGF2aWQgLyBkaGlsZGVuYg0KPiANCj4gDQoNCi0tIA0KU2luY2VyZWx5
IHlvdXJzLA0KTWlrZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
