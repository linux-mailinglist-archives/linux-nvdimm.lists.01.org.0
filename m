Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B881C0B82
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 03:10:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1E364111FF462;
	Thu, 30 Apr 2020 18:09:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE83B111FF460
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:08:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so4178842pjo.0
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=k15OpOeoQ3rmzh87tU7V+M2stfR65Ddwc7t7jeSZ6rI=;
        b=ZLa2+csE7C3ftsRmz/3+xOMLvS/uMepf5whKkn8d0OzfNoAxs3NYCmP/f16enqaROD
         JXZtPTYe1UyUJ/8SMeBi91XE6HWT6NlMiR35fFnnS7pvY3G7mtAEbbz5XTC/gox9CeWD
         eiReEYv/wwrQc3YopVZRokis2rX/nm1PfgdSC4RCTLPAgTawOYwjMf5cvk1BtVdwvXJ8
         uGNOUfjzRolRhppVNHd4kWTxIHehl5ULT1jNZb1WnV7sL9d3eiUzPkPD4f6tnuQ14q06
         +fnZlk8TLV+1KRT0DC5j0jC9LPU+s7Jmfx/bn3uiN2FV8qzlbJXUjdcVZKGkx7i8RNOE
         URiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=k15OpOeoQ3rmzh87tU7V+M2stfR65Ddwc7t7jeSZ6rI=;
        b=NNDY+97HjYHMFkDgSuuf7plQe9MdkQRMGn/PzGEZGluz1WJRojUCDn3X4I/7VlVdcI
         ZM4AnUZGXvzyMONOycnAdve9KPjDHjDsNq0fwIErSE2+oNF/G/d2XVm6ukJkWa/a6KcN
         Ja8ZaWqF+6TF5TXPnGXGRJTrzk4m9Mv27Y9G8K4jtLEkcJVZsPoEBmUBsfBDuW+a0r2a
         CF8smOcFpgfIeJbsePWcVG0Htu+5xR9yaFob2etWQOh383wCOQhx65JSr1dSGNYvGGR+
         Nf0nB2P4kx29t+MvPb1ajdde1KXZ5KGozg5JnRJmTZFoIEQaek30XzRliOeD8lNSoZ/7
         tvjw==
X-Gm-Message-State: AGi0PuY4MMdiE30Rp6ZaOSowy2kUuUy/+DyC7z3f+SNI1yrTfR2X3ZJk
	8zSi01jC/A8iKhPImL6jZKmCow==
X-Google-Smtp-Source: APiQypLTNhaQKdhVNhLmaUuI3eQ6yUGYMyMvnDjWA4wLYl43Zk7iNftpbdYKFJfHjKaWZp+OVuHDLQ==
X-Received: by 2002:a17:90a:2526:: with SMTP id j35mr1791482pje.98.1588295411228;
        Thu, 30 Apr 2020 18:10:11 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d495:581b:d692:e814? ([2601:646:c200:1ef2:d495:581b:d692:e814])
        by smtp.gmail.com with ESMTPSA id y13sm818856pfc.78.2020.04.30.18.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 18:10:10 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date: Thu, 30 Apr 2020 18:10:08 -0700
Message-Id: <1AA57F55-0361-4230-82B3-B432C40C0DBC@amacapital.net>
References: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
In-Reply-To: <CAHk-=wgeMRm_yhb_fwvmgdaPMYzgXY01cYvw5htHUCTwSzswqg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Message-ID-Hash: WORRNONPKVCYJDAV2Y3QQ2WNWJMHMRFE
X-Message-ID-Hash: WORRNONPKVCYJDAV2Y3QQ2WNWJMHMRFE
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WORRNONPKVCYJDAV2Y3QQ2WNWJMHMRFE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gQXByIDMwLCAyMDIwLCBhdCA1OjQwIFBNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4g77u/T24gVGh1LCBBcHIgMzAs
IDIwMjAgYXQgNToyMyBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2FwaXRhbC5uZXQ+IHdy
b3RlOg0KPj4gDQo+Pj4gQnV0IGFueXdheSwgSSBkb24ndCBoYXRlIHNvbWV0aGluZyBsaWtlICJj
b3B5X3RvX3VzZXJfZmFsbGlibGUoKSINCj4+PiBjb25jZXB0dWFsbHkuIFRoZSBuYW1pbmcgbmVl
ZHMgdG8gYmUgZml4ZWQsIGluIHRoYXQgInVzZXIiIGNhbiBhbHdheXMNCj4+PiB0YWtlIGEgZmF1
bHQsIHNvIGl0J3MgdGhlIF9zb3VyY2VfIHRoYXQgY2FuIGZhdWx0LCBub3QgdGhlICJ1c2VyIg0K
Pj4+IHBhcnQuDQo+PiANCj4+IEkgZG9u4oCZdCBsaWtlIHRoaXMuICDigJx1c2Vy4oCdIGFscmVh
ZHkgaW1wbGllZCB0aGF0IGJhc2ljYWxseSBhbnl0aGluZyBjYW4gYmUgd3Jvbmcgd2l0aCB0aGUg
bWVtb3J5DQo+IA0KPiBNYXliZSBJIGRpZG4ndCBleHBsYWluLg0KPiANCj4gInVzZXIiIGFscmVh
ZHkgaW1wbGllcyBmYXVsdGluZy4gV2UgYWdyZWUuDQo+IA0KPiBBbmQgc2luY2Ugd2UgYnkgZGVm
aW5pdGlvbiBjYW5ub3Qga25vdyB3aGF0IHRoZSB1c2VyIGhhcyBtYXBwZWQgaW50bw0KPiB1c2Vy
IHNwYWNlLCAqZXZlcnkqIG5vcm1hbCBjb3B5X3RvX3VzZXIoKSBoYXMgdG8gYmUgYWJsZSB0byBo
YW5kbGUNCj4gd2hhdGV2ZXIgZmF1bHRzIHRoYXQgdGhyb3dzIGF0IHVzLg0KPiANCj4gVGhlIHJl
YXNvbiBJIGRpc2xpa2UgImNvcHlfdG9fdXNlcl9mYWxsaWJsZSgpIiBpcyB0aGF0IHRoZSB1c2Vy
IHNpZGUNCj4gYWxyZWFkeSBoYXMgdGhhdCAnZmFsbGlibGUiLg0KPiANCj4gSWYgaXQncyB0aGUg
X3NvdXJjZV8gYmVpbmcgImZhbGxpYmxlIiAoaXQgcmVhbGx5IG5lZWRzIGEgYmV0dGVyIG5hbWUg
LQ0KPiBJIHdpbGwgbm90IGNhbGwgaXQganVzdCAiZiIpIHRoZW4gaXQgc2hvdWxkIGJlICJjb3B5
X2ZfdG9fdXNlcigpIi4NCj4gDQo+IFRoYXQgd291bGQgYmUgb2suDQo+IA0KPiBTbyAiY29weV9m
X3RvX3VzZXIoKSIgbWFrZXMgc2Vuc2UuIEJ1dCAiY29weV90b191c2VyX2YoKSIgZG9lcyBub3Qu
DQo+IFRoYXQgcHV0cyB0aGUgImYiIG9uIHRoZSAidXNlciIsIHdoaWNoIHdlIGFscmVhZHkga25v
dyBjYW4gZmF1bHQuDQo+IA0KPiBTZWUgd2hhdCBJIHdhbnQgaW4gdGhlIG5hbWU/IEkgd2FudCB0
aGUgbmFtZSB0byBzYXkgd2hpY2ggc2lkZSBjYW4NCj4gY2F1c2UgcHJvYmxlbXMhDQoNCldlIGFy
ZSBpbiB2aW9sZW50IGFncmVlbWVudC4gSeKAmW0gbW9kZXJhdGVseSBjb25maWRlbnQgdGhhdCBJ
IG5ldmVyIHN1Z2dlc3RlZCBjb3B5X2Zyb21fdXNlcl9mKCkuIFdlIGFwcGVhciB0byBhZ3JlZSBj
b21wbGV0ZWx5Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3Jn
ClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3Rz
LjAxLm9yZwo=
