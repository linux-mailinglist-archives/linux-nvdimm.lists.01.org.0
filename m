Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F737375D58
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 01:16:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D80D100EBB6B;
	Thu,  6 May 2021 16:16:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.91.1.2; helo=mailgate.ics.forth.gr; envelope-from=mick@ics.forth.gr; receiver=<UNKNOWN> 
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70786100EBB68
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 16:16:22 -0700 (PDT)
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 146NGIpS043562
	for <linux-nvdimm@lists.01.org>; Fri, 7 May 2021 02:16:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1620342973; x=1622934973;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uf0onNfnHBzOPbID0tZ8t011w+r/nxI4x/Q1TyEOdQE=;
	b=PM4UzE0tjJb0ton6+hFqgkCcvCPtBByAxRm712TdGgM8oH0uKI3fYmQulecm+EDP
	VX/y3RFo1wqeqd0M0KT/NGXp67dMJ3EswjXL7/Rvs2m3exSNibfkcTfc4Ds1LdVZ
	zIO1mwOOSeXB/gkB+gBayO9ehtfE1kOLWrgcVaes3kdO9vNH4wOxJv3okCWEcOXq
	7wxQ55OdhLAsE3nZ4q/4x7s7ycQC0w3Gol5dj1eF7An6hnmST3jy8YU3tIa2mTWi
	ctsjP4o/QYbATmSPpaRFC0hLvogkCgCc8SAFLAmz5IdYCrO9I64z/wBrUohkg55F
	bxOCRdo40Lnk7VwOyEhcoA==;
X-AuditID: 8b5b014d-a70347000000209f-ba-609478bd5c23
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id EB.87.08351.DB874906; Fri,  7 May 2021 02:16:13 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Date: Fri, 07 May 2021 02:16:03 +0300
From: Nick Kossifidis <mick@ics.forth.gr>
To: jejb@linux.ibm.com
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Organization: FORTH
In-Reply-To: <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
Message-ID: <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA03SfUwTZxzA8Tx317uDrOFEGZdKwNWRbGwrmsn8JTKijs2LRuLMFhUW5AI3
	YEMkLRAmc2EC8qqjtS+uRXlRAUlHoWUwCoQXZQUFXwpaNhHr4I91MNxkTEaHjK5bwj9PPsnv
	l+f5/vHQuH+HSEKnpmcK8nQ+TUr6EmVxus1vdOeoE7Y8rwmBSpORhGXV9xTMNz8n4UldOQLH
	n7MIdJo7CH5uLkKwYFrCoW5eTcCC6g4J2pZAqB1vw8CorMHB8qyYhGLrAgHmqfsi6OoeImDU
	WkmCbuIJCZPGFRHkKx9Q0DZfQMJt6zciuOK4i8GjszvB3luNwb3HBgJuVDgpcI2W43Ba7we2
	M70YLP+wegzftIvguqkdg3F1Hgl992cQqF1NFFjMGhxODZgwuL1sE0HBRAS4F1cfXWyeEu18
	jXtWeJbgjBeNiHMvqRA363IRnDJ/juI69A8prtqcxVkawrhLXS6MMzeWkJz5qYri5m7dorjB
	826Cmx7TYVxFbS/iLg69fyAo1jcySUhLzRbk4VEJvilu0zSWcdUvx5CnovKQ9oVS5EOzzDZ2
	pP4SKkW+tD8zgNjxDhXlHUSwhu4S5LGYWccOfT1NeIwzwGrGepDXIWz+twbcY4IJZQunlzGP
	SeZVtsret7pP0xuYF9k5Y7B3fUHMOpThHq9nBLbu0SjpsR+znn368K7IYx9mH/tTWRfh7WnE
	2CbVH/81RLNttnukt+1l9je3k/LcH7BqywVpBVqnX1OqX1OqX1NajfBGxPDZb8pSExWyj4/L
	M1NkyXIz+vd3of3foQeWX2X9CKNRP2JpXLpBfLP2XIK/OIn/7IQgP35UnpUmKPrRRpqQBorF
	soqj/kwynyl8KggZgvz/KUb7SPIw2ye49vWaA7G7646gV97u3FS/vSc+sGAXzQTzA+8ym22D
	fVdq9w5+0HCygX4skW48Nzw+c3lP/kRMg7mocleU6PCxbbGNY6f4SbrqWkzPaEn5mb25xS99
	eCI0Lqp+UR2wPTc7aEYjuyHZpI4+KZS3HYmov1z11Wyc1nb+gmEpMqA874uglMPD82NO7Zxj
	x+fh4cnYwc6t6SO7i6xJDvvgis+P7YfYmD36GVPxlwMfheXwzEF5xu9ME52YteN0HHM1VP2L
	zKjtlBiynFH7nWVNrVN/C9b49ux3qt5rPRapmNTxRSst5MhkdHohWWFShiRu+ev6W/amVs2h
	ay1B4vjS4FwpoUjht4bhcgX/D3XLkQHMAwAA
Message-ID-Hash: 3R5IM2WCBFGWAUN4UN4KZEOQCCKX4LP5
X-Message-ID-Hash: 3R5IM2WCBFGWAUN4UN4KZEOQCCKX4LP5
X-MailFrom: mick@ics.forth.gr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki  <rjw@rjwysocki.net>, Rick Edgecombe" <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Sha
 keel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3R5IM2WCBFGWAUN4UN4KZEOQCCKX4LP5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

zqPPhM65z4IgMjAyMS0wNS0wNiAyMDowNSwgSmFtZXMgQm90dG9tbGV5IM6tzrPPgc6xz4jOtToN
Cj4gT24gVGh1LCAyMDIxLTA1LTA2IGF0IDE4OjQ1ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3
cm90ZToNCj4+IA0KPj4gQWxzbywgdGhlcmUgaXMgYSB3YXkgdG8gc3RpbGwgcmVhZCB0aGF0IG1l
bW9yeSB3aGVuIHJvb3QgYnkNCj4+IA0KPj4gMS4gSGF2aW5nIGtkdW1wIGFjdGl2ZSAod2hpY2gg
d291bGQgb2Z0ZW4gYmUgdGhlIGNhc2UsIGJ1dCBtYXliZSBub3QNCj4+IHRvIGR1bXAgdXNlciBw
YWdlcyApDQo+PiAyLiBUcmlnZ2VyaW5nIGEga2VybmVsIGNyYXNoIChlYXN5IHZpYSBwcm9jIGFz
IHJvb3QpDQo+PiAzLiBXYWl0aW5nIGZvciB0aGUgcmVib290IGFmdGVyIGt1bXAoKSBjcmVhdGVk
IHRoZSBkdW1wIGFuZCB0aGVuDQo+PiByZWFkaW5nIHRoZSBjb250ZW50IGZyb20gZGlzay4NCj4g
DQo+IEFueXRoaW5nIHRoYXQgY2FuIGxlYXZlIHBoeXNpY2FsIG1lbW9yeSBpbnRhY3QgYnV0IGJv
b3QgdG8gYSBrZXJuZWwNCj4gd2hlcmUgdGhlIG1pc3NpbmcgZGlyZWN0IG1hcCBlbnRyeSBpcyBy
ZXN0b3JlZCBjb3VsZCB0aGVvcmV0aWNhbGx5DQo+IGV4dHJhY3QgdGhlIHNlY3JldC4gIEhvd2V2
ZXIsIGl0J3Mgbm90IGV4YWN0bHkgZ29pbmcgdG8gYmUgYSBzdGVhbHRoeQ0KPiBleHRyYWN0aW9u
IC4uLg0KPiANCj4+IE9yLCBhcyBhbiBhdHRhY2tlciwgbG9hZCBhIGN1c3RvbSBrZXhlYygpIGtl
cm5lbCBhbmQgcmVhZCBtZW1vcnkNCj4+IGZyb20gdGhlIG5ldyBlbnZpcm9ubWVudC4gT2YgY291
cnNlLCB0aGUgbGF0dGVyIHR3byBhcmUgYWR2YW5jZWQNCj4+IG1lY2hhbmlzbXMsIGJ1dCB0aGV5
IGFyZSBwb3NzaWJsZSB3aGVuIHJvb3QuIFdlIG1pZ2h0IGJlIGFibGUgdG8NCj4+IG1pdGlnYXRl
LCBmb3IgZXhhbXBsZSwgYnkgemVyb2luZyBvdXQgc2VjcmV0bWVtIHBhZ2VzIGJlZm9yZSBib290
aW5nDQo+PiBpbnRvIHRoZSBrZXhlYyBrZXJuZWwsIGlmIHdlIGNhcmUgOikNCj4gDQo+IEkgdGhp
bmsgd2UgY291bGQgaGFuZGxlIGl0IGJ5IG1hcmtpbmcgdGhlIHJlZ2lvbiwgeWVzLCBhbmQgYSB6
ZXJvIG9uDQo+IHNodXRkb3duIG1pZ2h0IGJlIHVzZWZ1bCAuLi4gaXQgd291bGQgcHJldmVudCBh
bGwgd2FybSByZWJvb3QgdHlwZQ0KPiBhdHRhY2tzLg0KPiANCg0KSSBoYWQgc2ltaWxhciBjb25j
ZXJucyBhYm91dCByZWNvdmVyaW5nIHNlY3JldHMgd2l0aCBrZHVtcCwgYW5kIA0KY29uc2lkZXJl
ZCBjbGVhbmluZyB1cCBrZXlyaW5ncyBiZWZvcmUganVtcGluZyB0byB0aGUgbmV3IGtlcm5lbC4g
VGhlIA0KcHJvYmxlbSBpcyB3ZSBjYW4ndCBwcm92aWRlIGd1YXJhbnRlZXMgaW4gdGhhdCBjYXNl
LCBvbmNlIHRoZSBrZXJuZWwgaGFzIA0KY3Jhc2hlZCBhbmQgd2UgYXJlIG9uIG91ciB3YXkgdG8g
cnVuIGNyYXNoa2VybmVsLCB3ZSBjYW4ndCBiZSBzdXJlIHdlIA0KY2FuIHJlbGlhYmx5IHplcm8t
b3V0IGFueXRoaW5nLCB0aGUgbW9yZSBjb2RlIHdlIGFkZCB0byB0aGF0IHBhdGggdGhlIA0KbW9y
ZSByaXNreSBpdCBnZXRzLiBIb3dldmVyIGR1cmluZyByZWJvb3Qvbm9ybWFsIGtleGVjKCkgd2Ug
c2hvdWxkIGRvIA0Kc29tZSBjbGVhbnVwLCBpdCBtYWtlcyBzZW5zZSBhbmQgc2VjcmV0bWVtIGNh
biBpbmRlZWQgYmUgdXNlZnVsIGluIHRoYXQgDQpjYXNlLiBSZWdhcmRpbmcgbG9hZGluZyBjdXN0
b20ga2V4ZWMoKSBrZXJuZWxzLCB3ZSBtaXRpZ2F0ZSB0aGlzIHdpdGggDQp0aGUga2V4ZWMgZmls
ZS1iYXNlZCBBUEkgd2hlcmUgd2UgY2FuIHZlcmlmeSB0aGUgc2lnbmF0dXJlIG9mIHRoZSBsb2Fk
ZWQgDQpraW1hZ2UgKGFzc3VtaW5nIHRoZSBzeXN0ZW0gcnVucyBhIGtlcm5lbCBwcm92aWRlZCBi
eSBhIHRydXN0ZWQgM3JkIA0KcGFydHkgYW5kIHdlICd2ZSBtYWludGFpbmVkIGEgY2hhaW4gb2Yg
dHJ1c3Qgc2luY2UgYm9vdGluZykuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
