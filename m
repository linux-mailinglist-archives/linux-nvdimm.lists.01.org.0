Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E630A1AF4FF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 22:52:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5EBDB10FC62F2;
	Sat, 18 Apr 2020 13:52:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::244; helo=mail-lj1-x244.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A80310FC62F1
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 13:52:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so3246829lje.10
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s/MCXYluiV/Di6rRKjHU/d4NnQSkJUzqjX8QxIsHmUc=;
        b=IeynsinqAESZ7D5iH0Mw7AG00cif0HeQeEDlNnZHliL9sMslW01AUBwTualDAKcx6x
         vICf3ReOAIMcS25qObUhbwk3qGc/BhprOp/3VHZEytcvQY4Pv2D4bBv88lxtaCvewGqg
         DnGnok45WuhxHNH5EwyksqWHkDHRbvN//rwvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s/MCXYluiV/Di6rRKjHU/d4NnQSkJUzqjX8QxIsHmUc=;
        b=SLuKNpZFSzYyz3qlU0NM7qWNRVn6Mp4Ky/MVyyC/m9PbxTDBwhhOiFVElhBzyqCpWT
         Gq6/CEaTU3j5GxdUErPd0uILl8JGFFVUwitukuwvTRBkIDvp/hp3+1ypmCCYQLiW4Rmo
         Bf9mpJbRu8C2FbTh+lxuszLdJrnMiwotRdPAq2ZpxDjl2/6O0eX/a71EtniN3X/sY5xF
         +mCFE0njvFFp1N8fSTbEdTx2GG/xQ47f8aL3aqvgKxij/sev4ROQlpmzVmGFw04xt9J7
         gpCUn8rIY3MqaXfMZJpjY/ncfh4wsjz+k+UTIQ5SD19QFEU+rgoczEHAlM3ZiZtA6E0C
         FHxg==
X-Gm-Message-State: AGi0PuaZWZJTD8NWcBeMskqfxsKKM6x6ofhkAgep2D14Jpuqv0KJivy2
	ELBTWeYs/AO7bTg5l/OMr37PpGpUcMI=
X-Google-Smtp-Source: APiQypIv/xS0/cSc3jM0hBGXwkO+LqbgQhpHJcxiC1iTPIOYZfoxzHdgrgmL4cCHbnhGUgYffK3cfw==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr2744736ljf.233.1587243152860;
        Sat, 18 Apr 2020 13:52:32 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z23sm3371316ljm.46.2020.04.18.13.52.31
        for <linux-nvdimm@lists.01.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 13:52:31 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id w145so4751786lff.3
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 13:52:31 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr5848677lfl.125.1587243150793;
 Sat, 18 Apr 2020 13:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
In-Reply-To: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Apr 2020 13:52:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
Message-ID: <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Andy Lutomirski <luto@amacapital.net>
Message-ID-Hash: DUKTXGXAFV7PXJVICZZYQ4VKMGXR4XXH
X-Message-ID-Hash: DUKTXGXAFV7PXJVICZZYQ4VKMGXR4XXH
X-MailFrom: torvalds@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DUKTXGXAFV7PXJVICZZYQ4VKMGXR4XXH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBBcHIgMTgsIDIwMjAgYXQgMTozMCBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1h
Y2FwaXRhbC5uZXQ+IHdyb3RlOg0KPg0KPiBNYXliZSBJ4oCZbSBtaXNzaW5nIHNvbWV0aGluZyBv
YnZpb3VzLCBidXQgd2hhdOKAmXMgdGhlIGFsdGVybmF0aXZlPyAgVGhlIF9tY3NhZmUgdmFyaWFu
dHMgZG9u4oCZdCBqdXN0IGF2b2lkIHRoZSBSRVAgbWVzcyDigJQgdGhleSBhbHNvIHRlbGwgdGhl
IGtlcm5lbCB0aGF0IHRoaXMgcGFydGljdWxhciBhY2Nlc3MgaXMgcmVjb3ZlcmFibGUgdmlhIGV4
dGFibGUuDQoNCi4uIHdoaWNoIHRoZXkgY291bGQgZWFzaWx5IGRvIGV4YWN0bHkgdGhlIHNhbWUg
d2F5IHRoZSB1c2VyIHNwYWNlDQphY2Nlc3NvcnMgZG8sIGp1c3Qgd2l0aCBhIG11Y2ggc2ltcGxp
ZmllZCBtb2RlbCB0aGF0IGRvZXNuJ3QgZXZlbiBjYXJlDQphYm91dCBtdWx0aXBsZSBzaXplcywg
c2luY2UgdW5hbGlnbmVkIGFjY2Vzc2VzIHdlcmVuJ3QgdmFsaWQgYW55d2F5Lg0KDQpUaGUgdGhp
bmcgaXMsIGFsbCBvZiB0aGUgTUNTIGNvZGUgaGFzIGJlZW4gbmFzdHkuIFRoZXJlJ3Mgbm8gcmVh
c29uDQpmb3IgaXQgd2hhdC1zby1ldmVyIHRoYXQgSSBjYW4gdGVsbC4gVGhlIGhhcmR3YXJlIGhh
cyBiZWVuIHNvDQppbmNyZWRpYmx5IGJyb2tlbiB0aGF0IGl0J3MgYmFzaWNhbGx5IHVudXNhYmxl
LCBhbmQgbW9zdCBvZiB0aGUNCnNvZnR3YXJlIGFyb3VuZCBpdCBzZWVtcyB0byBoYXZlIGJlZW4g
YWJvdXQgdGVzdGluZy4NCg0KU28gSSBhYnNvbHV0ZWx5IGFiaG9yIHRoYXQgdGhpbmcuIEV2ZXJ5
dGhpbmcgYWJvdXQgdGhhdCBjb2RlIGhhcw0Kc2NyZWFtZWQgInllYWgsIHdlIGNvbXBsZXRlbHkg
bWlzLWRlc2lnbmVkIHRoZSBoYXJkd2FyZSwgd2UncmUgcHVzaGluZw0KdGhlIHByb2JsZW1zIGlu
dG8gc29mdHdhcmUsIGFuZCBub2JvZHkgZXZlbiB1c2VzIGl0IG9yIGNhbiB0ZXN0IGl0IHNvDQp0
aGVyZSdzIGxpa2UgNSBwZW9wbGUgd2hvIGNhcmUiLg0KDQpBbmQgSSdtIHB1c2hpbmcgYmFjayBv
biBpdCwgYmVjYXVzZSBJIHRoaW5rIHRoYXQgdGhlIGxlYXN0IHRoZSBjb2RlDQpjYW4gZG8gaXMg
dG8gYXQgbGVhc3QgYmUgc2ltcGxlLg0KDQpGb3IgZXhhbXBsZSwgbm9uZSBvZiB0aG9zZSBvcHRp
bWl6YXRpb25zIHNob3VsZCBleGlzdC4gVGhhdCBmdW5jdGlvbg0Kc2hvdWxkbid0IGhhdmUgYmVl
biBpbmxpbmUgdG8gYmVnaW4gd2l0aC4gQW5kIGlmIGl0IHJlYWxseSByZWFsbHkNCm1hdHRlcnMg
ZnJvbSBhIHBlcmZvcm1hbmNlIGFuZ2xlIHRoYXQgaXQgd2FzIGlubGluZSAod2hpY2ggSSBkb3Vi
dCksDQppdCBzaG91bGRuJ3QgaGF2ZSBsb29rZWQgbGlrZSBhIG1lbW9yeSBjb3B5LCBpdCBzaG91
bGQgaGF2ZSBsb29rZWQNCmxpa2UgImdldF91c2VyKCkiIChleGNlcHQgd2l0aG91dCBhbGwgdGhl
IGNvbXBsaWNhdGlvbnMgb2YgYWN0dWFsbHkNCmhhdmluZyB0byB0ZXN0IGFkZHJlc3NlcyBvciB3
b3JyeSBhYm91dCBkaWZmZXJlbnQgc2l6ZXMpLg0KDQpBbmQgaXQgYWxtb3N0IGNlcnRhaW5seSBz
aG91bGRuJ3QgaGF2ZSBiZWVuIGRvbmUgaW4gbG93LWxldmVsIGFzbQ0KZWl0aGVyLiBJdCBjb3Vs
ZCBoYXZlIGJlZW4gYSBzaW5nbGUgInJlYWQgYWxpZ25lZCB3b3JkIiBpbnRlcmZhY2UNCnVzaW5n
IGFuIGlubGluZSBhc20sIGFuZCB0aGVuIGV2ZXJ5dGhpbmcgZWxzZSBjb3VsZCBoYXZlIGJlZW4g
ZG9uZSBhcw0KQyBjb2RlIGFyb3VuZCBpdC4NCg0KQnV0IG5vLiBUaGUgc29mdHdhcmUgc2lkZSBp
cyBhbG1vc3QgYXMgbWVzc3kgYXMgdGhlIGhhcmR3YXJlIHNpZGUgaXMuDQpJIGhhdGUgaXQuIEFu
ZCBzaW5jZSBub2JvZHkgc2FuZSBjYW4gdGVzdCBpdCwgYW5kIHRoZSBicm9rZW4gaGFyZHdhcmUN
CmlzIF9zb18gYnJva2VuIHRoYW4gbm9ib2R5IHNob3VsZCBldmVyIHVzZSBpdCwgSSBoYXZlIGNv
bnRpbnVhbGx5DQpwdXNoZWQgYmFjayBhZ2FpbnN0IHRoaXMga2luZCBvZiB1Z2x5IG5hc3R5IHNw
ZWNpYWwgY29kZS4NCg0KV2Uga25vdyB0aGUgd3JpdGVzIGNhbid0IGZhdWx0LCBzaW5jZSB0aGV5
IGFyZSBidWZmZXJlZC4gU28gdGhleQ0KYXJlbid0IHNwZWNpYWwgYXQgYWxsLg0KDQpXZSBrbm93
IHRoZSBhY2NlcHRhYmxlIHJlYWRzIGZvciB0aGUgYnJva2VuIGhhcmR3YXJlIGJhc2ljYWxseSBi
b2lsDQpkb3duIHRvIGEgc2luZ2xlIHNpbXBsZSB3b3JkLXNpemUgYWxpZ25lZCByZWFkLCBzbyB5
b3UgbmVlZCBfb25lXw0Kc3BlY2lhbCBpbmxpbmUgYXNtIGZvciB0aGF0LiBUaGUgcmVzdCBvZiB0
aGUgY2FzZXMgY2FuIGJlIGhhbmRsZWQgYnkNCm1hc2tpbmcgYW5kIHNoaWZ0aW5nIGlmIHlvdSBy
ZWFsbHkgcmVhbGx5IG5lZWQgdG8gLSBhbmQgZG9uZSBiZXR0ZXINCnRoYXQgd2F5IHRoYW4gd2l0
aCBieXRlIGFjY2Vzc2VzIGFueXdheS4NCg0KVGhlbiB5b3UgaGF2ZSBfb25lXyBDIGZpbGUgdGhh
dCBpbXBsZW1lbnRzIGV2ZXJ5dGhpbmcgdXNpbmcgdGhhdA0Kc2luZ2xlIG9wZXJhdGlvbiAob2ss
IGlmIHBlb3BsZSBhYnNvbHV0ZWx5IHdhbnQgdG8gZG8gc2l6ZXMsIEkgZ3Vlc3MNCnRoZXkgY2Fu
IGlmIHRoZXkgY2FuIGp1c3QgaGlkZSBpdCBpbiB0aGF0IG9uZSBmaWxlKSwgYW5kIHlvdSBoYXZl
IG9uZQ0KaGVhZGVyIGZpbGUgdGhhdCBleHBvc2VzIHRoZSBpbnRlcmZhY2VzIHRvIGl0LCBhbmQg
eW91J3JlIGRvbmUuDQoNCkFuZCB5b3Ugc3RyaXZlIGhhcmQgYXMgaGVsbCB0byBub3QgaW1wYWN0
IGFueXRoaW5nIGVsc2UsIGJlY2F1c2UgeW91DQprbm93IHRoYXQgdGhlIGhhcmR3YXJlIGlzIHVu
YWNjZXB0YWJsZSB1bnRpbCBhbGwgdGhvc2Ugc3BlY2lhbCBydWxlcw0KZ28gYXdheS4gV2hpY2gg
dGhleSBhcHBhcmVudGx5IGZpbmFsbHkgaGF2ZS4NCg0KICAgICAgICAgICAgICAgIExpbnVzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
