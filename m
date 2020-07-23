Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B922B79F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 22:23:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3274F1251E234;
	Thu, 23 Jul 2020 13:23:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3DD3D1251E233
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 13:23:32 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595535810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13eX65NKhTLwr4wa9nwWsPlfdutzeNj03w02PC/5rs4=;
	b=1jhXPCQJstdH9CtCCpLyVZrksLIJXuuhxFGZnUfU+3pOZrI2KPqYgwbQ0Sm6xJAm0rqb84
	MHefvsezd2XnqxVHrgIgYMxqPKxJw66D6fHc3dzQpiqG2CEqUFsp0YBLPVaaHTntLvme+H
	/Q8NDd4wYx6RFEtIrLe9e6gf5/SxK6E6ht8GAnl2/bGnX2DS7v/GfkzPP8deRI3nk6JNGz
	27vZK5cyaZYNrHexeR5733cnor3v8w+8CWKk5ger8jF9c2FgL5I5wddjdqqVfWk25QGE2H
	3ASkgTxi1JE5c3gbGfZu716QRCpJgAIHFiydJcxvc3hVBjjwb9YihZ2FZYZpkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595535810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13eX65NKhTLwr4wa9nwWsPlfdutzeNj03w02PC/5rs4=;
	b=MQsGZUsaQ6TJWdR6X93SMfni2qTkk1ixXSwjPCEB5I6pgQ0aMVt+vX2XZ7ErADgwbnwtgk
	5MptZ2mJQ+GxetAg==
To: Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <71f0e3d8-6dfa-742d-eaa7-330b59611e2f@intel.com>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <71f0e3d8-6dfa-742d-eaa7-330b59611e2f@intel.com>
Date: Thu, 23 Jul 2020 22:23:29 +0200
Message-ID: <87ft9ivv3y.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: GEDDVGOUOWJ4QWTCB7F54HUTECBC3G2G
X-Message-ID-Hash: GEDDVGOUOWJ4QWTCB7F54HUTECBC3G2G
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GEDDVGOUOWJ4QWTCB7F54HUTECBC3G2G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gd3JpdGVzOg0KDQo+IE9uIDcvMjMv
MjAgMTA6MDggQU0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToNCj4+IFN1cHBvc2Ugc29tZSBrZXJu
ZWwgY29kZSAoYSBzeXNjYWxsIG9yIGtlcm5lbCB0aHJlYWQpIGNoYW5nZXMgUEtSUw0KPj4gdGhl
biB0YWtlcyBhIHBhZ2UgZmF1bHQuIFRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgbmVlZHMgYSBmcmVz
aCBQS1JTLg0KPj4gVGhlbiB0aGUgcGFnZSBmYXVsdCBoYW5kbGVyIChzYXkgYSBWTUHigJlzIC5m
YXVsdCBoYW5kbGVyKSBjaGFuZ2VzDQo+PiBQS1JTLiAgVGhlIHdlIGdldCBhbiBpbnRlcnJ1cHQu
IFRoZSBpbnRlcnJ1cHQgKmFsc28qIG5lZWRzIGEgZnJlc2gNCj4+IFBLUlMgYW5kIHRoZSBwYWdl
IGZhdWx0IHZhbHVlIG5lZWRzIHRvIGJlIHNhdmVkIHNvbWV3aGVyZS4NCj4+IA0KPj4gU28gd2Ug
aGF2ZSBtb3JlIHRoYW4gb25lIHNhdmVkIHZhbHVlIHBlciB0aHJlYWQsIGFuZCB0aHJlYWRfc3Ry
dWN0DQo+PiBpc27igJl0IGdvaW5nIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4NCj4gVGFraW5n
IGEgc3RlcCBiYWNrLi4uICBUaGlzIGlzIGFsbCB0cnVlIG9ubHkgaWYgd2UgZGVjaWRlIHRoYXQg
d2Ugd2FudA0KPiBwcm90ZWN0aW9uIGtleXMgdG8gcHJvdmlkZSBwcm90ZWN0aW9uIGR1cmluZyBl
eGNlcHRpb25zIGFuZCBpbnRlcnJ1cHRzLg0KPiAgUmlnaHQgbm93LCB0aGUgY29kZSBzdXBwb3J0
cyBuZXN0aW5nOg0KPg0KPiAJa21hcChmb28pOw0KPiAJCWttYXAoYmFyKTsNCj4gCQlrdW5tYXAo
YmFyKTsNCj4gCWt1bm1hcChmb28pOw0KPg0KPiB3aXRoIGEgcmVmZXJlbmNlIGNvdW50LiAgU28s
IHRoZSBuZXN0ZWQga21hcCgpIHdpbGwgc2VlIHRoZSBjb3VudA0KPiBlbGV2YXRlZCBhbmQgZG8g
bm90aGluZy4NCg0KSG9wZWZ1bGx5IHdpdGggYSBiaWcgZmF0IHdhcm5pbmcgaWYgdGhlIG5lc3Rl
ZCBtYXAgcmVxdWlyZXMgYSBkaWZmZXJlbnQNCmtleSB0aGFuIHRoZSBvdXRlciBvbmUuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
