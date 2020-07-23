Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A56522B93A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 00:14:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B69C612531B6F;
	Thu, 23 Jul 2020 15:14:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=<UNKNOWN> 
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7CDD312531B6E
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 15:14:31 -0700 (PDT)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1595542468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmyzjmH8/olb4mM6hh3RrBawdAZ1ohRuT2f6HKf6J84=;
	b=V5Z5Rq1nk71rXzhuUOz5ybYySxFdqFcH8dpWSElBd5qV0W8MCoBko+38RNWOwqWv2ju5Ig
	bQIZTjLoRGXb0gRm8ytYEZ+t/kr7TRL00g3qwWdo76SMcfJ4GqUmx1vL6JGaDTvO7FZH+R
	ehWAUFsqGo/fbWIHtNHboBF7FH01EARrdMRiueauNFcaZcnEvopvmfNUwCfpZJv1T5dDwT
	im0DmUgWCCRiLQJaa9slhiO8uBTVN7eOzTJKLsyQvSGFvkDS9iSTv6B55CVKQYzX50pMS/
	92w4HmCS53+4wG2ZzwtaOhcrmTM/WnQ4LlDs75AQoLaiaAd4mZmRHbv65Gb2eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1595542468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmyzjmH8/olb4mM6hh3RrBawdAZ1ohRuT2f6HKf6J84=;
	b=DpE/SglP+UbEOY+9bcINMPHA9y7J8tMcjgmZMJCa1/pPbw5ifZwHGpOKKPr+c+G54aYYVK
	9inwqDxRJmQ+XGDQ==
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com> <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <87imeevv6b.fsf@nanos.tec.linutronix.de> <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Date: Fri, 24 Jul 2020 00:14:28 +0200
Message-ID: <874kpxx4jf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID-Hash: UDFY2MCHHGEUI6RC6TXM7HKY3PWYQS6R
X-Message-ID-Hash: UDFY2MCHHGEUI6RC6TXM7HKY3PWYQS6R
X-MailFrom: tglx@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UDFY2MCHHGEUI6RC6TXM7HKY3PWYQS6R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyaXRlczoNCj4+IE9uIEp1bCAyMywg
MjAyMCwgYXQgMToyMiBQTSwgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdy
b3RlOg0KPj4g77u/QW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0YWwubmV0PiB3cml0ZXM6
DQo+Pj4gTXkgc3VnZ2VzdGlvbiBpcyB0byBlbmxhcmdlIHB0X3JlZ3MuICBUaGUgc2F2ZSBhbmQg
cmVzdG9yZSBsb2dpYyBjYW4NCj4+PiBwcm9iYWJseSBiZSBpbiBDLCBidXQgcHRfcmVncyBpcyB0
aGUgbG9naWNhbCBwbGFjZSB0byBwdXQgYSByZWdpc3Rlcg0KPj4+IHRoYXQgaXMgc2F2ZWQgYW5k
IHJlc3RvcmVkIGFjcm9zcyBhbGwgZW50cmllcy4NCj4+DQo+PiBLaW5kYSwgYnV0IHRoYXQgc3Rp
bGwgc3Vja3MgYmVjYXVzZSBzY2hlZHVsZSBmcm9tICNQRiB3aWxsIGdldCBpdCB3cm9uZw0KPj4g
dW5sZXNzIHlvdSBkbyBleHRyYSBuYXN0aWVzLg0KPg0KPiBUaGlzIHNlZW1zIGxpa2Ugd2XigJly
ZSByZWludmVudGluZyB0aGUgd2hlZWwuICBQS1JTIGlzIG5vdA0KPiBmdW5kYW1lbnRhbGx5IGRp
ZmZlcmVudCBmcm9tLCBzYXksIFJTUC4gIElmIHdlIHdhbnQgdG8gc2F2ZSBpdCBhY3Jvc3MNCj4g
ZXhjZXB0aW9ucywgd2Ugc2F2ZSBpdCBvbiBlbnRyeSBhbmQgY29udGV4dC1zd2l0Y2gtb3V0IGFu
ZCByZXN0b3JlIGl0DQo+IG9uIGV4aXQgYW5kIGNvbnRleHQtc3dpdGNoLWluLg0KDQpJdCdzIGZ1
bmRhbWVudGFsbHkgZGlmZmVyZW50IGZyb20gUlNQIGJlY2F1c2UgaXQgaGFzIHN0YXRlIChyZWZj
b3VudCkNCmF0dGFjaGVkLCB3aGljaCBSU1AgY2xlYXJseSBoYXMgbm90LiBJZiB5b3UgZ2V0IHJp
ZCBvZiB0aGUgc3RhdGUgdGhlbg0KeWVzLg0KDQo+Pj4gV2hvZXZlciBkb2VzIHRoaXMgd29yayB3
aWxsIGhhdmUgdGhlIGRlbGlnaHRmdWwgam9iIG9mIGZpZ3VyaW5nIG91dA0KPj4+IHdoZXRoZXIg
QlBGIHRoaW5rcyB0aGF0IHRoZSBsYXlvdXQgb2YgcHRfcmVncyBpcyBBQkkgYW5kLCBpZiBzbywN
Cj4+PiBmaXhpbmcgdGhlIHJlc3VsdGluZyBtZXNzLg0KPj4+DQo+Pj4gVGhlIGZhY3QgdGhlIG5l
dyBmaWVsZHMgd2lsbCBnbyBhdCB0aGUgYmVnaW5uaW5nIG9mIHB0X3JlZ3Mgd2lsbCBtYWtlDQo+
Pj4gdGhpcyBhbiBlbnRlcnRhaW5pbmcgcHJvc3BlY3QuDQo+Pg0KPj4gR29vZCBsdWNrIHdpdGgg
YWxsIG9mIHRoYXQuDQo+DQo+IFdlIGNhbiBhbHdheXMgY2hlYXQgbGlrZSB0aGlzOg0KPg0KPiBz
dHJ1Y3QgcmVhbF9wdF9yZWdzIHsNCj4gICB1bnNpZ25lZCBsb25nIHBrcnM7DQo+ICAgc3RydWN0
IHB0X3JlZ3MgcmVnczsNCj4gfTsNCj4NCj4gYW5kIHBhc3MgYSBwb2ludGVyIHRvIHJlZ3MgYXJv
dW5kLiAgV2hhdCBCUEYgZG9lc24ndCBrbm93IGFib3V0IGNhbid0IGh1cnQgaXQuDQoNClllcywg
YnV0IHRoYXQncyB0aGUgZWFzeSBwYXJ0IG9mIHRoZSBwcm9ibGVtIDopDQoNClRoYW5rcywNCg0K
ICAgICAgICB0Z2x4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
