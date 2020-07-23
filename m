Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5427D22B8B0
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 Jul 2020 23:30:25 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 250EB12520401;
	Thu, 23 Jul 2020 14:30:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B67D312520400
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 14:30:20 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id DAE7322CB3
	for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539820;
	bh=LjPYQXYCMq01OkWf8ZVQxeTp9Qz+blIk2hR6fIzeLNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QinynW2K93EXrPR6DHoUgxUGXaHWzMH146Nrrve6MhpMPCFwGDoURTCwZW01w2nig
	 yjJRiHvrDGxPpz7uOlli64G8+T1vxQUU9Hzaz9+hUdIyI0JcVCYuSGY1wFgfAPnSa/
	 Qz1ISBhK19OBZO0AlIkHeM5E1hrKxyuX0nsm1UII=
Received: by mail-wr1-f48.google.com with SMTP id z18so2924461wrm.12
        for <linux-nvdimm@lists.01.org>; Thu, 23 Jul 2020 14:30:19 -0700 (PDT)
X-Gm-Message-State: AOAM532I3zjeYQq6MbUHI3EQZ4qQdalhZjCD3xhyw2q4VUSE3D9iqLMi
	JkDCTzSYh6d9PpLMzUd0qzmG1GcZmQHUnJ0Mj649Fg==
X-Google-Smtp-Source: ABdhPJxkIDtPFawZcWsduLG2ySWexVRWYEyTMNYsD2OEQFrKOENShjDryhjYBkc7VXix4cqL0MKNzSQ5LIQb5iHR31E=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr5578852wrc.257.1595539818063;
 Thu, 23 Jul 2020 14:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200723165204.GB77434@romley-ivt3.sc.intel.com>
 <C03DA782-BD1A-42E3-B118-ABB34BC5F2AF@amacapital.net> <87imeevv6b.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imeevv6b.fsf@nanos.tec.linutronix.de>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 23 Jul 2020 14:30:06 -0700
X-Gmail-Original-Message-ID: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Message-ID: <CALCETrUdxpVP3dZgsZBpCODxW8yaiHguxTu=aHg_AkRbs91dWg@mail.gmail.com>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
To: Thomas Gleixner <tglx@linutronix.de>
Message-ID-Hash: MDUMTG3DXERS6PWBULJGKDBQK6RANYM5
X-Message-ID-Hash: MDUMTG3DXERS6PWBULJGKDBQK6RANYM5
X-MailFrom: luto@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Fenghua Yu <fenghua.yu@intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MDUMTG3DXERS6PWBULJGKDBQK6RANYM5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBPbiBKdWwgMjMsIDIwMjAsIGF0IDE6MjIgUE0sIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPiB3cm90ZToNCj4NCj4g77u/QW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNhcGl0
YWwubmV0PiB3cml0ZXM6DQo+DQo+PiBTdXBwb3NlIHNvbWUga2VybmVsIGNvZGUgKGEgc3lzY2Fs
bCBvciBrZXJuZWwgdGhyZWFkKSBjaGFuZ2VzIFBLUlMNCj4+IHRoZW4gdGFrZXMgYSBwYWdlIGZh
dWx0LiBUaGUgcGFnZSBmYXVsdCBoYW5kbGVyIG5lZWRzIGEgZnJlc2gNCj4+IFBLUlMuIFRoZW4g
dGhlIHBhZ2UgZmF1bHQgaGFuZGxlciAoc2F5IGEgVk1B4oCZcyAuZmF1bHQgaGFuZGxlcikgY2hh
bmdlcw0KPj4gUEtSUy4gIFRoZSB3ZSBnZXQgYW4gaW50ZXJydXB0LiBUaGUgaW50ZXJydXB0ICph
bHNvKiBuZWVkcyBhIGZyZXNoDQo+PiBQS1JTIGFuZCB0aGUgcGFnZSBmYXVsdCB2YWx1ZSBuZWVk
cyB0byBiZSBzYXZlZCBzb21ld2hlcmUuDQo+Pg0KPj4gU28gd2UgaGF2ZSBtb3JlIHRoYW4gb25l
IHNhdmVkIHZhbHVlIHBlciB0aHJlYWQsIGFuZCB0aHJlYWRfc3RydWN0DQo+PiBpc27igJl0IGdv
aW5nIHRvIHNvbHZlIHRoaXMgcHJvYmxlbS4NCj4NCj4gQSBzdGFjayBvZiA3IGVudHJpZXMgYW5k
IGFuIGluZGV4IG5lZWRzIDMyYnl0ZXMgdG90YWwgd2hpY2ggaXMgYQ0KPiByZWFzb25hYmxlIGFt
b3VudCBhbmQgc29sdmVzIHRoZSBwcm9ibGVtIGluY2x1ZGluZyBzY2hlZHVsaW5nIGZyb20gI1BG
DQo+IG5pY2VseS4gTWFrZSBpdCAxNSBhbmQgaXQncyBzdGlsbCBvbmx5IDY0IGJ5dGVzLg0KPg0K
Pj4gQnV0IGlkdGVudHJ5X3N0YXRlIGlzIGFsc28gbm90IGdyZWF0IGZvciBhIGNvdXBsZSByZWFz
b25zLiAgTm90IGFsbA0KPj4gZW50cmllcyBoYXZlIGlkdGVudHJ5X3N0YXRlLCBhbmQgdGhlIHVu
d2luZGVyIGNhbuKAmXQgZmluZCBpdCBmb3INCj4+IGRlYnVnZ2luZy4gRm9yIHRoYXQgbWF0dGVy
LCB0aGUgcGFnZSBmYXVsdCBsb2dpYyBwcm9iYWJseSB3YW50cyB0bw0KPj4ga25vdyB0aGUgcHJl
dmlvdXMgUEtSUywgc28gaXQgc2hvdWxkIGVpdGhlciBiZSBzdGFzaGVkIHNvbWV3aGVyZQ0KPj4g
ZmluZGFibGUgb3IgaXQgc2hvdWxkIGJlIGV4cGxpY2l0bHkgcGFzc2VkIGFyb3VuZC4NCj4+DQo+
PiBNeSBzdWdnZXN0aW9uIGlzIHRvIGVubGFyZ2UgcHRfcmVncy4gIFRoZSBzYXZlIGFuZCByZXN0
b3JlIGxvZ2ljIGNhbg0KPj4gcHJvYmFibHkgYmUgaW4gQywgYnV0IHB0X3JlZ3MgaXMgdGhlIGxv
Z2ljYWwgcGxhY2UgdG8gcHV0IGEgcmVnaXN0ZXINCj4+IHRoYXQgaXMgc2F2ZWQgYW5kIHJlc3Rv
cmVkIGFjcm9zcyBhbGwgZW50cmllcy4NCj4NCj4gS2luZGEsIGJ1dCB0aGF0IHN0aWxsIHN1Y2tz
IGJlY2F1c2Ugc2NoZWR1bGUgZnJvbSAjUEYgd2lsbCBnZXQgaXQgd3JvbmcNCj4gdW5sZXNzIHlv
dSBkbyBleHRyYSBuYXN0aWVzLg0KDQpUaGlzIHNlZW1zIGxpa2Ugd2XigJlyZSByZWludmVudGlu
ZyB0aGUgd2hlZWwuICBQS1JTIGlzIG5vdA0KZnVuZGFtZW50YWxseSBkaWZmZXJlbnQgZnJvbSwg
c2F5LCBSU1AuICBJZiB3ZSB3YW50IHRvIHNhdmUgaXQgYWNyb3NzDQpleGNlcHRpb25zLCB3ZSBz
YXZlIGl0IG9uIGVudHJ5IGFuZCBjb250ZXh0LXN3aXRjaC1vdXQgYW5kIHJlc3RvcmUgaXQNCm9u
IGV4aXQgYW5kIGNvbnRleHQtc3dpdGNoLWluLg0KDQoNCj4NCj4+IFdob2V2ZXIgZG9lcyB0aGlz
IHdvcmsgd2lsbCBoYXZlIHRoZSBkZWxpZ2h0ZnVsIGpvYiBvZiBmaWd1cmluZyBvdXQNCj4+IHdo
ZXRoZXIgQlBGIHRoaW5rcyB0aGF0IHRoZSBsYXlvdXQgb2YgcHRfcmVncyBpcyBBQkkgYW5kLCBp
ZiBzbywNCj4+IGZpeGluZyB0aGUgcmVzdWx0aW5nIG1lc3MuDQo+Pg0KPj4gVGhlIGZhY3QgdGhl
IG5ldyBmaWVsZHMgd2lsbCBnbyBhdCB0aGUgYmVnaW5uaW5nIG9mIHB0X3JlZ3Mgd2lsbCBtYWtl
DQo+PiB0aGlzIGFuIGVudGVydGFpbmluZyBwcm9zcGVjdC4NCj4NCj4gR29vZCBsdWNrIHdpdGgg
YWxsIG9mIHRoYXQuDQoNCldlIGNhbiBhbHdheXMgY2hlYXQgbGlrZSB0aGlzOg0KDQpzdHJ1Y3Qg
cmVhbF9wdF9yZWdzIHsNCiAgdW5zaWduZWQgbG9uZyBwa3JzOw0KICBzdHJ1Y3QgcHRfcmVncyBy
ZWdzOw0KfTsNCg0KYW5kIHBhc3MgYSBwb2ludGVyIHRvIHJlZ3MgYXJvdW5kLiAgV2hhdCBCUEYg
ZG9lc24ndCBrbm93IGFib3V0IGNhbid0IGh1cnQgaXQuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
bnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
