Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E8D22B78A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 22:22:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 048DC1251E234;
	Thu, 23 Jul 2020 13:22:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BA5D81251E233
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 13:22:07 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595535725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUfejVCnGJSFUxx4AbkzbVJFCZGcWbz/N8REfPWxQoU=;
	b=3w6pydta60AUDlW71ctlUmfCuxjZwrDBjdn+FnMylpeeRNx3lZdxfaaRT4irOoFTC9CUuh
	PXbbNu0NFQnT2ebz/rTRFFus4A56eVJaHT1Nku6xPVzKWr5/EfpxjeqXE2M8OHYK60mpNZ
	G/1vehBDzGDMsOv9JDLd9t0ZwgJq18uO4GXkwYlXX/XavlQ/d8MeiixW8yeG71ll4tXpXy
	OSNidJ+vtacBscsslNQRCmpPO3hM5Ayd5CFQN/LEVQ+5TWmlgprge1xI1euwEayu59G88G
	Yr4RymiC2f4ktP3jTZXWmeO9OG2t4cANxrJrr3YILRR0osb7reG9Ymiqqc1/bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595535725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUfejVCnGJSFUxx4AbkzbVJFCZGcWbz/N8REfPWxQoU=;
	b=S6pO3lE+IfHj3HhkeQ26FcQansBJxu9GNSfmIP0x4haRe07iB3E2Ls0tYUMfsjoVnW9XRq
	EEpNr2bboZIhELDQ==
To: Andy Lutomirski <luto@amacapital.net>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net>
Date: Thu, 23 Jul 2020 22:22:04 +0200
Message-ID: <87imeevv6b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: FBS5RK23BJJJBLGSQIVEX3RI4EW7UZNO
X-Message-ID-Hash: FBS5RK23BJJJBLGSQIVEX3RI4EW7UZNO
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FBS5RK23BJJJBLGSQIVEX3RI4EW7UZNO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cml0ZXM6DQoNCj4gU3VwcG9z
ZSBzb21lIGtlcm5lbCBjb2RlIChhIHN5c2NhbGwgb3Iga2VybmVsIHRocmVhZCkgY2hhbmdlcyBQ
S1JTDQo+IHRoZW4gdGFrZXMgYSBwYWdlIGZhdWx0LiBUaGUgcGFnZSBmYXVsdCBoYW5kbGVyIG5l
ZWRzIGEgZnJlc2gNCj4gUEtSUy4gVGhlbiB0aGUgcGFnZSBmYXVsdCBoYW5kbGVyIChzYXkgYSBW
TUHigJlzIC5mYXVsdCBoYW5kbGVyKSBjaGFuZ2VzDQo+IFBLUlMuICBUaGUgd2UgZ2V0IGFuIGlu
dGVycnVwdC4gVGhlIGludGVycnVwdCAqYWxzbyogbmVlZHMgYSBmcmVzaA0KPiBQS1JTIGFuZCB0
aGUgcGFnZSBmYXVsdCB2YWx1ZSBuZWVkcyB0byBiZSBzYXZlZCBzb21ld2hlcmUuDQo+DQo+IFNv
IHdlIGhhdmUgbW9yZSB0aGFuIG9uZSBzYXZlZCB2YWx1ZSBwZXIgdGhyZWFkLCBhbmQgdGhyZWFk
X3N0cnVjdA0KPiBpc27igJl0IGdvaW5nIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCg0KQSBzdGFj
ayBvZiA3IGVudHJpZXMgYW5kIGFuIGluZGV4IG5lZWRzIDMyYnl0ZXMgdG90YWwgd2hpY2ggaXMg
YQ0KcmVhc29uYWJsZSBhbW91bnQgYW5kIHNvbHZlcyB0aGUgcHJvYmxlbSBpbmNsdWRpbmcgc2No
ZWR1bGluZyBmcm9tICNQRg0KbmljZWx5LiBNYWtlIGl0IDE1IGFuZCBpdCdzIHN0aWxsIG9ubHkg
NjQgYnl0ZXMuDQoNCj4gQnV0IGlkdGVudHJ5X3N0YXRlIGlzIGFsc28gbm90IGdyZWF0IGZvciBh
IGNvdXBsZSByZWFzb25zLiAgTm90IGFsbA0KPiBlbnRyaWVzIGhhdmUgaWR0ZW50cnlfc3RhdGUs
IGFuZCB0aGUgdW53aW5kZXIgY2Fu4oCZdCBmaW5kIGl0IGZvcg0KPiBkZWJ1Z2dpbmcuIEZvciB0
aGF0IG1hdHRlciwgdGhlIHBhZ2UgZmF1bHQgbG9naWMgcHJvYmFibHkgd2FudHMgdG8NCj4ga25v
dyB0aGUgcHJldmlvdXMgUEtSUywgc28gaXQgc2hvdWxkIGVpdGhlciBiZSBzdGFzaGVkIHNvbWV3
aGVyZQ0KPiBmaW5kYWJsZSBvciBpdCBzaG91bGQgYmUgZXhwbGljaXRseSBwYXNzZWQgYXJvdW5k
Lg0KPg0KPiBNeSBzdWdnZXN0aW9uIGlzIHRvIGVubGFyZ2UgcHRfcmVncy4gIFRoZSBzYXZlIGFu
ZCByZXN0b3JlIGxvZ2ljIGNhbg0KPiBwcm9iYWJseSBiZSBpbiBDLCBidXQgcHRfcmVncyBpcyB0
aGUgbG9naWNhbCBwbGFjZSB0byBwdXQgYSByZWdpc3Rlcg0KPiB0aGF0IGlzIHNhdmVkIGFuZCBy
ZXN0b3JlZCBhY3Jvc3MgYWxsIGVudHJpZXMuDQoNCktpbmRhLCBidXQgdGhhdCBzdGlsbCBzdWNr
cyBiZWNhdXNlIHNjaGVkdWxlIGZyb20gI1BGIHdpbGwgZ2V0IGl0IHdyb25nDQp1bmxlc3MgeW91
IGRvIGV4dHJhIG5hc3RpZXMuDQoNCj4gV2hvZXZlciBkb2VzIHRoaXMgd29yayB3aWxsIGhhdmUg
dGhlIGRlbGlnaHRmdWwgam9iIG9mIGZpZ3VyaW5nIG91dA0KPiB3aGV0aGVyIEJQRiB0aGlua3Mg
dGhhdCB0aGUgbGF5b3V0IG9mIHB0X3JlZ3MgaXMgQUJJIGFuZCwgaWYgc28sDQo+IGZpeGluZyB0
aGUgcmVzdWx0aW5nIG1lc3MuDQo+DQo+IFRoZSBmYWN0IHRoZSBuZXcgZmllbGRzIHdpbGwgZ28g
YXQgdGhlIGJlZ2lubmluZyBvZiBwdF9yZWdzIHdpbGwgbWFrZQ0KPiB0aGlzIGFuIGVudGVydGFp
bmluZyBwcm9zcGVjdC4NCg0KR29vZCBsdWNrIHdpdGggYWxsIG9mIHRoYXQuDQoNClRoYW5rcywN
Cg0KICAgICAgICB0Z2x4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAx
Lm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBs
aXN0cy4wMS5vcmcK
