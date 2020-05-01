Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DCE1C0B4E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 02:40:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 00EBA111FC1E6;
	Thu, 30 Apr 2020 17:38:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::142; helo=mail-lf1-x142.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AFC810113FCE
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:38:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so2636353lfd.0
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sRFJfZwHnsJQqFJepe+LvPqS40H3J51FnSnbFsYaAJM=;
        b=AvUgqN7PB/2m6j6r3ChFqht9nBGFMbV8AKa9u30SyVlVrTUy+Tv1TOIg+df2atuDm9
         mrQr9/kg7XzvTBlUGO0QByBQRaSsjKRXNdddPP7Y9Z8zjn9Nh1TKQSTFhhdcbHFIGZAm
         23fUYndzjvvhniZu8dhlkJL4EDHoYqfSv1iW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sRFJfZwHnsJQqFJepe+LvPqS40H3J51FnSnbFsYaAJM=;
        b=jmeeiVXa5h3mbYcbYqZpx5m7lRQSgFs3/7ByaMW8S8h15UgwGUWuTYvxWpPb0UhO1o
         SAniZrWz4EL0i7iZA/WGY5fWbcZQ5+fon+btYSGVNqyjxy3O5gFlOASakxArLSL/sAq4
         diiLYBqrLlRbtuugl/Chi42Mvb5eOp6ZrkxF74dGOhWYbcdk1XunuxvtJHQhFo314aTN
         mIyqrent4LFxENys7GDuYs/tgi75hXp4j0vDQL1lO07YEiMhWzOrLAcyO6hUZfgcQ4mO
         xHQgTgV5Tyxwt0q+FC4u+HmlFmh189dsiTkgvkudfMZdc7H4p5tRkL33FthXzmp4sbDq
         YQXQ==
X-Gm-Message-State: AGi0Pua/NjQw8LSPVMTFaa8Fw9vsKvgmLoty/1sjzDt6+0csWgRyOsA2
	ANWu5l5XxKkQxj+rHiHRu38gBTChugY=
X-Google-Smtp-Source: APiQypIaIfyg6cUwSowpAVOU7ID9BRybagQ3233Ekvv8j30pMwM018cn8kZvftggOmDWom0Frk6fYQ==
X-Received: by 2002:a19:505b:: with SMTP id z27mr764857lfj.123.1588293605548;
        Thu, 30 Apr 2020 17:40:05 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b9sm1193671lfp.27.2020.04.30.17.40.02
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:40:03 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b2so1315144ljp.4
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:40:02 -0700 (PDT)
X-Received: by 2002:a2e:814e:: with SMTP id t14mr886854ljg.204.1588293602471;
 Thu, 30 Apr 2020 17:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
In-Reply-To: <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 17:39:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
Message-ID: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To: Andy Lutomirski <luto@amacapital.net>
Message-ID-Hash: 4MREIW3LBCNTYRZ6CYULXJNPCFAORXUU
X-Message-ID-Hash: 4MREIW3LBCNTYRZ6CYULXJNPCFAORXUU
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4MREIW3LBCNTYRZ6CYULXJNPCFAORXUU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBBcHIgMzAsIDIwMjAgYXQgNToyMyBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1h
Y2FwaXRhbC5uZXQ+IHdyb3RlOg0KPg0KPiA+IEJ1dCBhbnl3YXksIEkgZG9uJ3QgaGF0ZSBzb21l
dGhpbmcgbGlrZSAiY29weV90b191c2VyX2ZhbGxpYmxlKCkiDQo+ID4gY29uY2VwdHVhbGx5LiBU
aGUgbmFtaW5nIG5lZWRzIHRvIGJlIGZpeGVkLCBpbiB0aGF0ICJ1c2VyIiBjYW4gYWx3YXlzDQo+
ID4gdGFrZSBhIGZhdWx0LCBzbyBpdCdzIHRoZSBfc291cmNlXyB0aGF0IGNhbiBmYXVsdCwgbm90
IHRoZSAidXNlciINCj4gPiBwYXJ0Lg0KPg0KPiBJIGRvbuKAmXQgbGlrZSB0aGlzLiAg4oCcdXNl
cuKAnSBhbHJlYWR5IGltcGxpZWQgdGhhdCBiYXNpY2FsbHkgYW55dGhpbmcgY2FuIGJlIHdyb25n
IHdpdGggdGhlIG1lbW9yeQ0KDQpNYXliZSBJIGRpZG4ndCBleHBsYWluLg0KDQoidXNlciIgYWxy
ZWFkeSBpbXBsaWVzIGZhdWx0aW5nLiBXZSBhZ3JlZS4NCg0KQW5kIHNpbmNlIHdlIGJ5IGRlZmlu
aXRpb24gY2Fubm90IGtub3cgd2hhdCB0aGUgdXNlciBoYXMgbWFwcGVkIGludG8NCnVzZXIgc3Bh
Y2UsICpldmVyeSogbm9ybWFsIGNvcHlfdG9fdXNlcigpIGhhcyB0byBiZSBhYmxlIHRvIGhhbmRs
ZQ0Kd2hhdGV2ZXIgZmF1bHRzIHRoYXQgdGhyb3dzIGF0IHVzLg0KDQpUaGUgcmVhc29uIEkgZGlz
bGlrZSAiY29weV90b191c2VyX2ZhbGxpYmxlKCkiIGlzIHRoYXQgdGhlIHVzZXIgc2lkZQ0KYWxy
ZWFkeSBoYXMgdGhhdCAnZmFsbGlibGUiLg0KDQpJZiBpdCdzIHRoZSBfc291cmNlXyBiZWluZyAi
ZmFsbGlibGUiIChpdCByZWFsbHkgbmVlZHMgYSBiZXR0ZXIgbmFtZSAtDQpJIHdpbGwgbm90IGNh
bGwgaXQganVzdCAiZiIpIHRoZW4gaXQgc2hvdWxkIGJlICJjb3B5X2ZfdG9fdXNlcigpIi4NCg0K
VGhhdCB3b3VsZCBiZSBvay4NCg0KU28gImNvcHlfZl90b191c2VyKCkiIG1ha2VzIHNlbnNlLiBC
dXQgImNvcHlfdG9fdXNlcl9mKCkiIGRvZXMgbm90Lg0KVGhhdCBwdXRzIHRoZSAiZiIgb24gdGhl
ICJ1c2VyIiwgd2hpY2ggd2UgYWxyZWFkeSBrbm93IGNhbiBmYXVsdC4NCg0KU2VlIHdoYXQgSSB3
YW50IGluIHRoZSBuYW1lPyBJIHdhbnQgdGhlIG5hbWUgdG8gc2F5IHdoaWNoIHNpZGUgY2FuDQpj
YXVzZSBwcm9ibGVtcyENCg0KSWYgeW91IGFyZSBjb3B5aW5nIG1lbW9yeSBmcm9tIHNvbWUgZiBz
b3VyY2UsIGl0IG11c3Qgbm90IGJlDQoiY29weV9zYWZlKCkiLiBUaGF0IGRvZXNuJ3Qgc2F5IGlm
IHRoZSBfc291cmNlXyBpcyBmLCBvciB0aGUNCmRlc3RpbmF0aW9uIGlzIGYuDQoNClNvICJjb3B5
X3RvX2YoKSIgbWFrZXMgc2Vuc2UgKHdlIGRvbid0IHNheSAiY29weV9rZXJuZWxfdG9fdXNlcigp
IiAtDQp0aGUgIm5vcm1hbCIgY2FzZSBpcyBzaWxlbnQpLCBhbmQgImNvcHlfZnJvbV9mKCkiIG1h
a2VzIHNlbnNlLg0KImNvcHlfaW5fZigpIiBtYWtlcyBzZW5zZSB0b28uDQoNCkJ1dCBub3QgdGhp
cyAicmFuZG9tbHkgY29weSBzb21lIHJhbmRvbWx5IGYgbWVtb3J5IGFyZWEgdGhhdCBJIGRvbid0
DQprbm93IGlmIGl0J3MgdGhlIHNvdXJjZSBvciB0aGUgZGVzdGluYXRpb24iLg0KDQpTb21ldGlt
ZXMgeW91IG1heSB0aGVuIHVzZSBhIGNvbW1vbiBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIGRpZmZl
cmVudA0KZGlyZWN0aW9ucyAtIGlmIHRoYXQgd29ya3Mgb24gdGhlIGFyY2hpdGVjdHVyZS4NCg0K
Rm9yIGV4YW1wbGUsICJjb3B5X3RvX3VzZXIoKSIgYW5kICJjb3B5X2Zyb21fdXNlcigpIiBvbiB4
ODYgYm90aCBlbmQNCnVwIGludGVybmFsbHkgdXNpbmcgYSBzaGFyZWQgImNvcHlfdXNlcl9nZW5l
cmljKCkiIGltcGxlbWVudGF0aW9uLiBJDQp3aXNoIHRoYXQgd2Fzbid0IHRoZSBjYXNlICh3aGVu
IEkgYXNrZWQgZm9yIHdoYXQgd2FzIHRvIGJlY29tZQ0KU1RBQy9DTEFDLCBJIGFza2VkIGZvciBv
bmUgdGhhdCBjb3VsZCBkZXRlcm1pbmUgd2hpY2ggZGlyZWN0aW9uIG9mIGENCiJyZXAgbW92cyIg
Y291bGQgdG91Y2ggdXNlciBzcGFjZSksIGJ1dCBpdCBzbyBoYXBwZW5zIHRoYXQgdGhlDQppbXBs
ZW1lbnRhdGlvbnMgZW5kIHVwIGJlaW5nIHN5bW1ldHJpYyBvbiB4ODYuDQoNCkJ1dCB0aGF0J3Mg
YSBwdXJlIGltcGxlbWVudGF0aW9uIGlzc3VlLCBhbmQgaXQgdmVyeSBtdWNoIGlzIG5vdCBnb2lu
Zw0KdG8gYmUgdHJ1ZSBpbiBnZW5lcmFsLCBhbmQgaXQgc2hvdWxkbid0IGJlIGV4cG9zZWQgdG8g
dXNlcnMgYXMgc3VjaA0KKGFuZCB3ZSBvYnZpb3VzbHkgZG9uJ3QpLg0KDQogICAgICAgICAgICAg
ICAgTGludXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRv
IHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAx
Lm9yZwo=
