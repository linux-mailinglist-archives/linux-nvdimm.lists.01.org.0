Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7D71B00E6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 07:08:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CF96810FE2562;
	Sun, 19 Apr 2020 22:08:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5712710FC62E3
	for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 22:08:34 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so6087285edv.8
        for <linux-nvdimm@lists.01.org>; Sun, 19 Apr 2020 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uosnnvhWZ3yyd1hjeyEdalFBW58ozyttD3SAmZ9epkk=;
        b=eoqWpiOwRq7oi4XyC2As+GUHLC5NEcZO1OOE4PRCK1UPnSV64nsIERwHkSaXSb1dXW
         8ciCXTUnSaOgWRKxTBfIk/x746ztoISrwImvbu7zUF//ygyqTnbEwNtwad8pWAE0tlLF
         804WRCHLh/Po0dTXTLal3QEkVr8WjIdRa7gF/K9a+6RXlUwuMEDBQgKPvyO9l6kBNiFQ
         sROA4R4733K1cB+fGzkmc2I49Ou2AL4qMfdApkWJwUKs1HpyfYya8lM6KJGumgV4MRl4
         rKnBTsXYivznrdqhvAu6F57Kt1Wj4IbjIQ1/BkGhB7vdWkBLJOEtt0vSTZFUHrXOIUX6
         OZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uosnnvhWZ3yyd1hjeyEdalFBW58ozyttD3SAmZ9epkk=;
        b=nN3OpHYj8t/QeDd+2tnFRmQmfjTY8osP9DTkWBZ2tnXoH96bfsosjhG9/hYPmKtW9O
         MdW7ezpW0pzc6QSW7aHdI60KLx4nrjo/+oQbs+nktof+Qplwczx6uz/TaV6DMIbxKlMn
         isjetlW9NPP3WAlzU+hZCp99abnPgKW071jXZ8MkpkveEriGrQvLCVWO5eqVqDk7iZlr
         lZq6fIUdMH5NB6yy4XZldd/16CibQU8dhy6fQDhZFvXUKuALUFjJOqtFxLovkuFwiWdD
         ddM5/h+fRo7r+xWsEJ3JLWL1XzZnrWonbcM+DNkxLJMAaDt5iuXHM6qxFV1VVsz+EBBX
         MKfA==
X-Gm-Message-State: AGi0Pub5fMKfZFCw+gk8hN5CVJ3czHi0mIyx4Ofzjr3eQy7A+hEpk2WB
	UOP7jK7rImiYGA6pmjc+QirjPF6icFIpJDNmzZqofA==
X-Google-Smtp-Source: APiQypKvZgj9wXFg38gj+SIw0DMo/cjC6QoMNTqE70yXQ5Mpi1Piz373LSRUoNAHXo/kXfpbyB4oZQtKaQOTioBGdeE=
X-Received: by 2002:a05:6402:2203:: with SMTP id cq3mr921641edb.154.1587359314565;
 Sun, 19 Apr 2020 22:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net> <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
In-Reply-To: <CAHk-=wjePyyiNZo0oufYSn0s46qMYHoFyyNKhLOm5MXnKtfLcg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 19 Apr 2020 22:08:23 -0700
Message-ID: <CAPcyv4jQ3s_ZVRvw6jAmm3vcebc-Ucf7FHYP3_nTybwdfQeG8Q@mail.gmail.com>
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: JQHBFB6PEZ4C7FPYYQSMAJ2JABWMEXYD
X-Message-ID-Hash: JQHBFB6PEZ4C7FPYYQSMAJ2JABWMEXYD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andy Lutomirski <luto@amacapital.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JQHBFB6PEZ4C7FPYYQSMAJ2JABWMEXYD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBBcHIgMTgsIDIwMjAgYXQgMTo1MiBQTSBMaW51cyBUb3J2YWxkcw0KPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4NCj4gT24gU2F0LCBBcHIgMTgsIDIwMjAg
YXQgMTozMCBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdyb3RlOg0K
PiA+DQo+ID4gTWF5YmUgSeKAmW0gbWlzc2luZyBzb21ldGhpbmcgb2J2aW91cywgYnV0IHdoYXTi
gJlzIHRoZSBhbHRlcm5hdGl2ZT8gIFRoZSBfbWNzYWZlIHZhcmlhbnRzIGRvbuKAmXQganVzdCBh
dm9pZCB0aGUgUkVQIG1lc3Mg4oCUIHRoZXkgYWxzbyB0ZWxsIHRoZSBrZXJuZWwgdGhhdCB0aGlz
IHBhcnRpY3VsYXIgYWNjZXNzIGlzIHJlY292ZXJhYmxlIHZpYSBleHRhYmxlLg0KPg0KPiAuLiB3
aGljaCB0aGV5IGNvdWxkIGVhc2lseSBkbyBleGFjdGx5IHRoZSBzYW1lIHdheSB0aGUgdXNlciBz
cGFjZQ0KPiBhY2Nlc3NvcnMgZG8sIGp1c3Qgd2l0aCBhIG11Y2ggc2ltcGxpZmllZCBtb2RlbCB0
aGF0IGRvZXNuJ3QgZXZlbiBjYXJlDQo+IGFib3V0IG11bHRpcGxlIHNpemVzLCBzaW5jZSB1bmFs
aWduZWQgYWNjZXNzZXMgd2VyZW4ndCB2YWxpZCBhbnl3YXkuDQo+DQo+IFRoZSB0aGluZyBpcywg
YWxsIG9mIHRoZSBNQ1MgY29kZSBoYXMgYmVlbiBuYXN0eS4gVGhlcmUncyBubyByZWFzb24NCj4g
Zm9yIGl0IHdoYXQtc28tZXZlciB0aGF0IEkgY2FuIHRlbGwuIFRoZSBoYXJkd2FyZSBoYXMgYmVl
biBzbw0KPiBpbmNyZWRpYmx5IGJyb2tlbiB0aGF0IGl0J3MgYmFzaWNhbGx5IHVudXNhYmxlLCBh
bmQgbW9zdCBvZiB0aGUNCj4gc29mdHdhcmUgYXJvdW5kIGl0IHNlZW1zIHRvIGhhdmUgYmVlbiBh
Ym91dCB0ZXN0aW5nLg0KPg0KPiBTbyBJIGFic29sdXRlbHkgYWJob3IgdGhhdCB0aGluZy4gRXZl
cnl0aGluZyBhYm91dCB0aGF0IGNvZGUgaGFzDQo+IHNjcmVhbWVkICJ5ZWFoLCB3ZSBjb21wbGV0
ZWx5IG1pcy1kZXNpZ25lZCB0aGUgaGFyZHdhcmUsIHdlJ3JlIHB1c2hpbmcNCj4gdGhlIHByb2Js
ZW1zIGludG8gc29mdHdhcmUsIGFuZCBub2JvZHkgZXZlbiB1c2VzIGl0IG9yIGNhbiB0ZXN0IGl0
IHNvDQo+IHRoZXJlJ3MgbGlrZSA1IHBlb3BsZSB3aG8gY2FyZSIuDQo+DQo+IEFuZCBJJ20gcHVz
aGluZyBiYWNrIG9uIGl0LCBiZWNhdXNlIEkgdGhpbmsgdGhhdCB0aGUgbGVhc3QgdGhlIGNvZGUN
Cj4gY2FuIGRvIGlzIHRvIGF0IGxlYXN0IGJlIHNpbXBsZS4NCj4NCj4gRm9yIGV4YW1wbGUsIG5v
bmUgb2YgdGhvc2Ugb3B0aW1pemF0aW9ucyBzaG91bGQgZXhpc3QuIFRoYXQgZnVuY3Rpb24NCj4g
c2hvdWxkbid0IGhhdmUgYmVlbiBpbmxpbmUgdG8gYmVnaW4gd2l0aC4gQW5kIGlmIGl0IHJlYWxs
eSByZWFsbHkNCj4gbWF0dGVycyBmcm9tIGEgcGVyZm9ybWFuY2UgYW5nbGUgdGhhdCBpdCB3YXMg
aW5saW5lICh3aGljaCBJIGRvdWJ0KSwNCj4gaXQgc2hvdWxkbid0IGhhdmUgbG9va2VkIGxpa2Ug
YSBtZW1vcnkgY29weSwgaXQgc2hvdWxkIGhhdmUgbG9va2VkDQo+IGxpa2UgImdldF91c2VyKCki
IChleGNlcHQgd2l0aG91dCBhbGwgdGhlIGNvbXBsaWNhdGlvbnMgb2YgYWN0dWFsbHkNCj4gaGF2
aW5nIHRvIHRlc3QgYWRkcmVzc2VzIG9yIHdvcnJ5IGFib3V0IGRpZmZlcmVudCBzaXplcykuDQo+
DQo+DQo+IEFuZCBpdCBhbG1vc3QgY2VydGFpbmx5IHNob3VsZG4ndCBoYXZlIGJlZW4gZG9uZSBp
biBsb3ctbGV2ZWwgYXNtDQo+IGVpdGhlci4gSXQgY291bGQgaGF2ZSBiZWVuIGEgc2luZ2xlICJy
ZWFkIGFsaWduZWQgd29yZCIgaW50ZXJmYWNlDQo+IHVzaW5nIGFuIGlubGluZSBhc20sIGFuZCB0
aGVuIGV2ZXJ5dGhpbmcgZWxzZSBjb3VsZCBoYXZlIGJlZW4gZG9uZSBhcw0KPiBDIGNvZGUgYXJv
dW5kIGl0Lg0KDQpEbyB3ZSBoYXZlIGV4YW1wbGVzIG9mIGRvaW5nIGV4Y2VwdGlvbiBoYW5kbGlu
ZyBmcm9tIEM/IEkgdGhvdWdodCBhbGwNCnRoZSBleGNlcHRpb24gaGFuZGxpbmcgY29weSByb3V0
aW5lcyB3ZXJlIGFzc2VtYmx5IHJvdXRpbmVzPw0KDQo+DQo+IEJ1dCBuby4gVGhlIHNvZnR3YXJl
IHNpZGUgaXMgYWxtb3N0IGFzIG1lc3N5IGFzIHRoZSBoYXJkd2FyZSBzaWRlIGlzLg0KPiBJIGhh
dGUgaXQuIEFuZCBzaW5jZSBub2JvZHkgc2FuZSBjYW4gdGVzdCBpdCwgYW5kIHRoZSBicm9rZW4g
aGFyZHdhcmUNCj4gaXMgX3NvXyBicm9rZW4gdGhhbiBub2JvZHkgc2hvdWxkIGV2ZXIgdXNlIGl0
LCBJIGhhdmUgY29udGludWFsbHkNCj4gcHVzaGVkIGJhY2sgYWdhaW5zdCB0aGlzIGtpbmQgb2Yg
dWdseSBuYXN0eSBzcGVjaWFsIGNvZGUuDQo+DQo+IFdlIGtub3cgdGhlIHdyaXRlcyBjYW4ndCBm
YXVsdCwgc2luY2UgdGhleSBhcmUgYnVmZmVyZWQuIFNvIHRoZXkNCj4gYXJlbid0IHNwZWNpYWwg
YXQgYWxsLg0KDQpUaGUgd3JpdGVzIGNhbiBtbXUtZmF1bHQgbm93IHRoYXQgbWVtY3B5X21jc2Fm
ZSgpIGlzIGFsc28gdXNlZCBieQ0KX2NvcHlfdG9faXRlcl9tY3NhZmUoKS4gVGhpcyBhbGxvd3Mg
YSBjbGVhbiBieXBhc3Mgb2YgdGhlIGJsb2NrIGxheWVyDQppbiBmcy9kYXguYyBpbiBhZGRpdGlv
biB0byB0aGUgcG1lbSBkcml2ZXIgYWNjZXNzIG9mIHBvaXNvbmVkIG1lbW9yeS4NCk5vdyB0aGF0
IHRoZSBmYWxsYmFjayBpcyBhIHNhbmUgcmVwOyBtb3ZzOyBpdCBjYW4gYmUgY29uc2lkZXJlZCBm
b3INCnBsYWluIGNvcHlfdG9faXRlcigpIGZvciBvdGhlciB1c2VyIGNvcGllcyBzbyB5b3UgZ2V0
IGV4Y2VwdGlvbg0KaGFuZGxpbmcgb24ga2VybmVsIGFjY2VzcyBvZiBwb2lzb24gb3V0c2lkZSBv
ZiBwZXJzaXN0ZW50IG1lbW9yeS4gVG8NCkFuZHkncyBwb2ludCBJIHRoaW5rIGEgcmVjb3ZlcmFi
bGUgY29weSAoZm9yIGV4Y2VwdGlvbnMgb3IgZmF1bHRzKSBpcw0KZ2VuZXJhbGx5IHVzZWZ1bC4N
Cg0KPiBXZSBrbm93IHRoZSBhY2NlcHRhYmxlIHJlYWRzIGZvciB0aGUgYnJva2VuIGhhcmR3YXJl
IGJhc2ljYWxseSBib2lsDQo+IGRvd24gdG8gYSBzaW5nbGUgc2ltcGxlIHdvcmQtc2l6ZSBhbGln
bmVkIHJlYWQsIHNvIHlvdSBuZWVkIF9vbmVfDQo+IHNwZWNpYWwgaW5saW5lIGFzbSBmb3IgdGhh
dC4gVGhlIHJlc3Qgb2YgdGhlIGNhc2VzIGNhbiBiZSBoYW5kbGVkIGJ5DQo+IG1hc2tpbmcgYW5k
IHNoaWZ0aW5nIGlmIHlvdSByZWFsbHkgcmVhbGx5IG5lZWQgdG8gLSBhbmQgZG9uZSBiZXR0ZXIN
Cj4gdGhhdCB3YXkgdGhhbiB3aXRoIGJ5dGUgYWNjZXNzZXMgYW55d2F5Lg0KPg0KPiBUaGVuIHlv
dSBoYXZlIF9vbmVfIEMgZmlsZSB0aGF0IGltcGxlbWVudHMgZXZlcnl0aGluZyB1c2luZyB0aGF0
DQo+IHNpbmdsZSBvcGVyYXRpb24gKG9rLCBpZiBwZW9wbGUgYWJzb2x1dGVseSB3YW50IHRvIGRv
IHNpemVzLCBJIGd1ZXNzDQo+IHRoZXkgY2FuIGlmIHRoZXkgY2FuIGp1c3QgaGlkZSBpdCBpbiB0
aGF0IG9uZSBmaWxlKSwgYW5kIHlvdSBoYXZlIG9uZQ0KPiBoZWFkZXIgZmlsZSB0aGF0IGV4cG9z
ZXMgdGhlIGludGVyZmFjZXMgdG8gaXQsIGFuZCB5b3UncmUgZG9uZS4NCj4NCj4gQW5kIHlvdSBz
dHJpdmUgaGFyZCBhcyBoZWxsIHRvIG5vdCBpbXBhY3QgYW55dGhpbmcgZWxzZSwgYmVjYXVzZSB5
b3UNCj4ga25vdyB0aGF0IHRoZSBoYXJkd2FyZSBpcyB1bmFjY2VwdGFibGUgdW50aWwgYWxsIHRo
b3NlIHNwZWNpYWwgcnVsZXMNCj4gZ28gYXdheS4gV2hpY2ggdGhleSBhcHBhcmVudGx5IGZpbmFs
bHkgaGF2ZS4NCg0KSSB1bmRlcnN0YW5kIHRoZSBncmlwZXMgYWJvdXQgdGhlIG1jc2FmZV9zbG93
KCkgaW1wbGVtZW50YXRpb24sIGJ1dA0KaG93IGRvIEkgaW1wbGVtZW50IG1jc2FmZV9mYXN0KCkg
YW55IGJldHRlciB0aGFuIGhvdyBpdCBpcyBjdXJyZW50bHkNCm9yZ2FuaXplZCBnaXZlbiB0aGF0
LCBzZXR0aW5nIGFzaWRlIG1hY2hpbmUgY2hlY2sgaGFuZGxpbmcsDQptZW1jcHlfbWNzYWZlKCkg
aXMgdGhlIGNvcmUgb2YgYSBjb3B5X3RvX2l0ZXIqKCkgZnJvbnQtZW5kIHRoYXQgY2FuDQptbXUt
ZmF1bHQgb24gZWl0aGVyIHNvdXJjZSBvciBkZXN0aW5hdGlvbiBhY2Nlc3M/Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
