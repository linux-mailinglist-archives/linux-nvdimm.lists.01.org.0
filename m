Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2587E1C0B3B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  1 May 2020 02:23:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 825DF111F36F0;
	Thu, 30 Apr 2020 17:22:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 21AAB111F36E5
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:22:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so1666344pjw.0
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=q6XSSbORtzdGM5wsbVVdblLZLp4drz8TDfwttIDJ1z4=;
        b=r4d1DSiLI7OzhNnrgDQYPizLp5Uolgf7Mc7ZMXQsfzXIivOBc1mAMesjCUhkWWIi2y
         yex588qrp8KlVr1SuLZUCj9OssMwY+aaAfCKjy+x9+JfSDfBS1Y/gdhgJEH3q8iiqNex
         iDvrz7IM41lpzKYWJEv4iBMdnX7oCb0T30GM+GIC5l5Y9epnFFE69w6a4yfNUb5zdep1
         faAEeWjW4wlEC6m2J+TuNWxWVWiWbHwVnhwmwehvckJUO9vNL5ReuvTC8nMM66+/SQYe
         QSm0RTZ8YdH0IZK2Jqm+j2sNapESRzuwTfkfqlKsYv8m5cvyFuWu8KPZsccCLJzeSRtV
         DVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=q6XSSbORtzdGM5wsbVVdblLZLp4drz8TDfwttIDJ1z4=;
        b=mQexE6q1383ADzrFiUAYY0X4tKu6L1FjjIprPjvJkjrxYc4PvK2ROftt7byF9E8+2A
         iCWddblHG4sMJBbq9uIfydaY6MCz84+xB55hrqsG+3qzik87Vy20O1J046lv6Bp/WSev
         uUZlJkhcSy3eg9lX2iuCrrfE+N/FkEs5Ii+5FN47HDRiDpHnE8/7koovWCtT5/EX97A/
         DM0V1mGPV0EJeE5Dwi8XzvFoj0R3BlDwgG4gqvZ2rpDpwKTIDRNm7zennryK+GW48fuo
         JpH/2KfrrQHU14bL33Isf7tCm2O3HAsq+iEAbPqwXv1rNNRSb1KArcHrtAsELxWQtfbh
         nalg==
X-Gm-Message-State: AGi0Pubzq78PMX3gPkdfZGcpRSLe8Fz8K4E+mJWofyw/5kKiwGAnCHr9
	7qsX8w30bPpDitmUgkLlVGFRsw==
X-Google-Smtp-Source: APiQypJVozuXgtmFv1oxaxiVxd1C0J2JT+J68tf0qsuERm2lt0FgWE/aW2WqeSKKnq7hUTr7lXX6cQ==
X-Received: by 2002:a17:90a:fe06:: with SMTP id ck6mr1694160pjb.4.1588292614361;
        Thu, 30 Apr 2020 17:23:34 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d495:581b:d692:e814? ([2601:646:c200:1ef2:d495:581b:d692:e814])
        by smtp.gmail.com with ESMTPSA id c2sm781538pfp.118.2020.04.30.17.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 17:23:33 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date: Thu, 30 Apr 2020 17:23:31 -0700
Message-Id: <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net>
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
In-Reply-To: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Message-ID-Hash: XBENXPVJ6UM3RJWQFU5U7TIZGELAGBFE
X-Message-ID-Hash: XBENXPVJ6UM3RJWQFU5U7TIZGELAGBFE
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBENXPVJ6UM3RJWQFU5U7TIZGELAGBFE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIEFwciAzMCwgMjAyMCwgYXQgNToxMCBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgQXByIDMwLCAy
MDIwIGF0IDQ6NTIgUE0gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdy
b3RlOg0KPj4gDQo+PiBZb3UgaGFkIG1lIHVudGlsIGhlcmUuIFVwIHRvIHRoaXMgcG9pbnQgSSB3
YXMgZ3Jva2tpbmcgdGhhdCBBbmR5J3MNCj4+ICJfZmFsbGlibGUiIHN1Z2dlc3Rpb24gZG9lcyBo
ZWxwIGV4cGxhaW4gYmV0dGVyIHRoYW4gIl9zYWZlIiwgYmVjYXVzZQ0KPj4gdGhlIGNvcHkgaXMg
ZG9pbmcgZXh0cmEgc2FmZXR5IGNoZWNrcy4gY29weV90b191c2VyKCkgYW5kDQo+PiBjb3B5X3Rv
X3VzZXJfZmFsbGlibGUoKSBtZWFuICpzb21ldGhpbmcqIHdoZXJlIGNvcHlfdG9fdXNlcl9zYWZl
KCkNCj4+IGRvZXMgbm90Lg0KPiANCj4gSXQncyBhIGhvcnJpYmxlIHdvcmQsIGJ0dy4gVGhlIHdv
cmQgZG9lc24ndCBhY3R1YWxseSBtZWFuIHdoYXQgQW5keQ0KPiBtZWFucyBpdCB0byBtZWFuLiAi
ZmFsbGlibGUiIG1lYW5zICJjYW4gbWFrZSBtaXN0YWtlcyIsIG5vdCAiY2FuDQo+IGZhdWx0Ii4N
Cj4gDQo+IFNvICJmYWxsaWJsZSIgaXMgYSBob3JyaWJsZSBuYW1lLg0KDQpXaGF0IEkgd2FzIHRy
eWluZyB0byBnZXQgYXQgd2FzIG5vdCDigJxjYW4gZmF1bHTigJ0gYnV0IOKAnGNhbiBtYWxmdW5j
dGlvbuKAnS4gIE1heWJlIOKAnHVucmVsaWFibGXigJ0/ICBCZXR0ZXIgd29yZHMgd2VsY29tZS4N
Cg0KPiANCj4gQnV0IGFueXdheSwgSSBkb24ndCBoYXRlIHNvbWV0aGluZyBsaWtlICJjb3B5X3Rv
X3VzZXJfZmFsbGlibGUoKSINCj4gY29uY2VwdHVhbGx5LiBUaGUgbmFtaW5nIG5lZWRzIHRvIGJl
IGZpeGVkLCBpbiB0aGF0ICJ1c2VyIiBjYW4gYWx3YXlzDQo+IHRha2UgYSBmYXVsdCwgc28gaXQn
cyB0aGUgX3NvdXJjZV8gdGhhdCBjYW4gZmF1bHQsIG5vdCB0aGUgInVzZXIiDQo+IHBhcnQuDQoN
CkkgZG9u4oCZdCBsaWtlIHRoaXMuICDigJx1c2Vy4oCdIGFscmVhZHkgaW1wbGllZCB0aGF0IGJh
c2ljYWxseSBhbnl0aGluZyBjYW4gYmUgd3Jvbmcgd2l0aCB0aGUgbWVtb3J5IOKAlCBpdCBjYW4g
YmUgdW5tYXBwZWQgZW50aXJlbHksIGl0IGNhbiBoYXZlIHRoZSB3cm9uZyBwZXJtaXNzaW9ucywg
aXQgY2FuIGhhdmUgdGhlIHdyb25nIHByb3RlY3Rpb24ga2V5LCBpdCBjYW4gaGF2ZSBhbiBFQ0Mg
ZXJyb3IsIGV0Yy4gIElmIHRoZSBvcGVyYXRpb24geW91IHdhbnQgaXMg4oCcY29weSBmcm9tIHVu
cmVsaWFibGUga2VybmVsIG1lbW9yeSAoYnV0IHdpdGggYSBkZWZpbml0ZWx5IHZhbGlkIHBvaW50
ZXIpIHRvIHVzZXIgbWVtb3J54oCdLCB5b3Ugd2FudCBjb3B5X3VucmVsaWFibGVfdG9fdXNlcigp
Lg0KDQpOb3cgbWF5YmUgY29weV90b191c2VyKCkgc2hvdWxkICphbHdheXMqIHdvcmsgdGhpcyB3
YXksIGJ1dCBJ4oCZbSBub3QgY29udmluY2VkLiBDZXJ0YWlubHkgcHV0X3VzZXIoKSBzaG91bGRu
4oCZdCDigJQgdGhlIHJlc3VsdCB3b3VsZG7igJl0IGV2ZW4gYmUgd2VsbCBkZWZpbmVkLiBBbmQg
SeKAmW0gdW5jb252aW5jZWQgdGhhdCBpdCBtYWtlcyBtdWNoIHNlbnNlIGZvciB0aGUgbWFqb3Jp
dHkgb2YgY29weV90b191c2VyKCkgY2FsbGVycyB0aGF0IGFyZSBhbHNvIGRpcmVjdGx5IGFjY2Vz
c2luZyB0aGUgc291cmNlIHN0cnVjdHVyZS4NCg0KSSBhbHNvIHRlbmQgdG8gdGhpbmsgdGhhdCB0
aGUgcHJvYmVfa2VybmVsIHN0dWZmIHNob3VsZCBqdXN0IHN0YXkgc2VwYXJhdGUuIFRob3NlIGFy
ZSByZWFsbHkgZm9yIHR3byB0b3RhbGx5IHNlcGFyYXRlIHR5cGVzIG9mIHVzZTogZWl0aGVyIHRo
ZSBrZXJuZWwgaXMgdHJ5aW5nIGl0cyBiZXN0IHRvIHByaW50IGFuIGVycnIgbWVzc2FnZSB3aXRo
b3V0IGV4cGxvZGluZyB3b3JzZSwgb3IgaXTigJlzIGludm9sdmVkIGluIGVCUEYgb3IgdHJhZGlu
ZyBoYWNrcyBpbiB3aGljaCBhZGRyZXNzIGlzIGFyYml0cmFyeSBhbmQgZXNzZW50aWFsbHkgdW50
cnVzdGVkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
