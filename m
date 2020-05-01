Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C85481C0BA0
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 03:20:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 04A4A10053E15;
	Thu, 30 Apr 2020 18:19:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E7977100AA5C5
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:19:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so899051pfv.8
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+ob/X0QXFpxvmr3EWB8fQOJcF1u/V0cTtMVpIs2p45o=;
        b=JWz/HNe9QVe3KpMe6Fx9Bq2GqkBQAoBVa8iqrJqTOXH9HIZzwUCDZU8rE102fg1z7o
         0kalZERJUV6gw/xA8MPaoOfaHwYAbAANimUog9Hm676+TIjcO+dBY89FjUJ4wcMs975/
         SKm9CbmjdES6fxlHT0h2/dzk9hxGqC1/y06ZPZMjk0uNY0N5EoJ6K6sn0qt6pUf2eCuJ
         jgwqP5f32gdTlY0FX3Gs1FAz+ZOhcRu86YggMsjZ1RdG5yNctLB6+vmapn45gRamTYGp
         fRbPwUxOjDOzHfI5AUlpxdC9aNAaFqoSCkIZ/PKmcj6qIrFM96yFQKqxFpwDUaMHMKf7
         yvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+ob/X0QXFpxvmr3EWB8fQOJcF1u/V0cTtMVpIs2p45o=;
        b=nh9MJbIZyL2MqUL/fC9htOixcUuYuJ7MDUXjgB2XXn+hLBXyO8wXGItd5d9PuGOPNT
         IGfN9Koz0QsaLC5aoiVYloFFoZABS7rV2nyF8Y2+KXiO6RwPDVBeXejX1dvu0g4jEdKy
         F+TV+9rxHMHrhUwhOn40/vVNxjwEPDP00iimVkzzx6Sci8nPxWOAba8roI03oyfU4FrI
         sT1BIT8j9/QT3VsBfkPkE7zoOI9UDZZAQ6AxaCQiVz9mqJg9QCUvsrIWo5Qy4iiVlz6b
         ZNPQ3TShUNQIXbqkcS+wWUnjAu7hsv1PYMf/CvpOym78CnwetXg4rQLYSDMPpsEGeI+o
         BTCQ==
X-Gm-Message-State: AGi0Pub0dUfP0QF1iRrcL/bt0ir3x9SLHjU/BXACyQMk+Y681wPK10Eb
	XdnD84JqjiAY1esU+5JGyVarsg==
X-Google-Smtp-Source: APiQypJVdLbyXVtAGU4O61QE9USzd9aHvhWz43HYF+zei+FPbOx+DYcTAVOeS9XOsayG60rqSExmJg==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr1723584pfi.193.1588296042609;
        Thu, 30 Apr 2020 18:20:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d495:581b:d692:e814? ([2601:646:c200:1ef2:d495:581b:d692:e814])
        by smtp.gmail.com with ESMTPSA id h31sm784779pjb.33.2020.04.30.18.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 18:20:41 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date: Thu, 30 Apr 2020 18:20:39 -0700
Message-Id: <D47C71D3-349B-49C4-9945-330C9F42A3E0@amacapital.net>
References: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
In-Reply-To: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Message-ID-Hash: 4QHEBHLCE2MWEISWPJLXPREFTMANDG76
X-Message-ID-Hash: 4QHEBHLCE2MWEISWPJLXPREFTMANDG76
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QHEBHLCE2MWEISWPJLXPREFTMANDG76/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gT24gQXByIDMwLCAyMDIwLCBhdCA1OjI1IFBNLCBMaW51cyBUb3J2YWxkcyA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiANCj4gDQo+IEl0IHdhc24ndCBjbGVh
ciBob3cgImNvcHlfdG9fbWMoKSIgY291bGQgZXZlciBmYXVsdC4gUG9pc29uaW5nDQo+IGFmdGVy
LXRoZS1mYWN0PyBXaHkgd291bGQgdGhhdCBiZSBwcmVmZXJhYmxlIHRvIGp1c3QgbWFwcGluZyBh
IGR1bW15DQo+IHBhZ2U/DQoNCklmIHRoZSBrZXJuZWwgZ2V0cyBhbiBhc3luYyBtZW1vcnkgZXJy
b3IgYW5kIG1hcHMgYSBkdW1teSBwYWdlLCB0aGVuIHN1YnNlcXVlbnQgcmVhZHMgd2lsbCBzdWJz
ZXF1ZW50bHkgc3VjY2VlZCBhbmQgcmV0dXJuIGdhcmJhZ2Ugd2hlbiB0aGV5IHNob3VsZCBmYWls
LiAgSWYgeDg2IGhhZCB3cml0ZS1vbmx5IHBhZ2VzLCB3ZSBjb3VsZCBtYXAgYSBkdW1teSB3cml0
ZS1vbmx5IHBhZ2UuIEJ1dCB3ZSBkb27igJl0LCBzbyBJIHRoaW5rIHdl4oCZcmUgc3R1Y2suDQoN
CkFzIGZvciBuYW1pbmcgdGhlIGtpbmQgb2YgbWVtb3J5IHdl4oCZcmUgdGFraW5nIGFib3V0LCBJ
U1RNIHRoZXJlIGFyZSB0d28gY2xhc3NlczogREFYIGFuZCBtb25zdHJvdXMgbWVtb3J5LW1hcHBl
ZCBub24tcGVyc2lzdGVudCBjYWNoZSBkZXZpY2VzLiAgQm90aCBjb3VsZCBiZSBPcHRhbmUsIEkg
c3VwcG9zZS4NCg0KQnV0IEkgYWxzbyB0aGluayBpdOKAmXMgbGVnaXRpbWF0ZSB0byB1c2UgdGhl
c2UgYWNjZXNzb3JzIHRvIGluY3JlYXNlIHRoZSBjaGFuY2Ugb2Ygc3Vydml2aW5nIGEgZmFpbHVy
ZSBvZiBub3JtYWwgbWVtb3J5LiBJZiBhIG5vcm1hbCBwYWdlIGhhcHBlbnMgdG8gYmUgcGFnZSBj
YWNoZSB3aGVuIGl0IGZhaWxzIGFuZCBpZiBwYWdlIGNhY2hlIGFjY2VzcyB1c2UgdGhlc2UgZmFu
Y3kgYWNjZXNzb3JzLCB0aGVuIHdlIG1pZ2h0IGFjdHVhbGx5IHN1cnZpdmUgYSBmYWlsdXJlLg0K
DQpXZSBjb3VsZCBiZSBhbWJpdGlvdXM6IGRlY2xhcmUgdGhhdCBhbGwgcGFnZSBjYWNoZSBhbmQg
YWxsIGdldF91c2VyX3BhZ2XigJlkIG1lbW9yeSBzaG91bGQgdXNlIHRoZSBuZXcgYWNjZXNzb3Jz
LiAgSSBkb3VidCB3ZeKAmWxsIGV2ZXIgcmVhbGx5IHN1Y2NlZWQgZHVlIHRvIG1hZ2ljYWwgdGhp
bmdzIGxpa2UgcnNlcSBhbmQgYW55dGhpbmcgdGhhdCB0aGlua3MgdGhhdCB1c2VycyBjYW4gc2V0
IHVwIHRoZWlyIG93biBtZW1vcnkgYXMgYSBrZXJuZWwtYWNjZXNzZWQgcmluZyBidWZmZXIsIGJ1
dCBJIHN1cHBvc2Ugd2UgY291bGQgdHJ5Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRp
bW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZk
aW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
