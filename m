Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EDC1C0768
	for <lists+linux-nvdimm@lfdr.de>; Thu, 30 Apr 2020 22:07:17 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 590C1110F2E0B;
	Thu, 30 Apr 2020 13:06:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 896C610053E03
	for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 13:06:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so2700034plq.12
        for <linux-nvdimm@lists.01.org>; Thu, 30 Apr 2020 13:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=p3wUvEbSn9f+WPyEEsvBQpBZL7x1SSk0c7XRYZKC7go=;
        b=vLKm85XeGVLBINOi+MNK7f63J8VzDtOC7kEqYCvUpC4YvbvTEJAYkMiBSGQX6J70Ha
         maCBbN6Occzx6JzwsTyizH4bV5bF82J1N3xXZLGRQ6aVP1XmfstafoB5WPCGqRGsQwEK
         fvEkC4NCRYQ5xnMtYPB0OAq8dlOZa9n33vdEJ0pRlrc7xXYyA+cVJn2gpcBJJoPdOSQ9
         DH0j5fkW9bao+gLWoFUenYN07TOxS19vea2YvvDccg5FxBmAxAbHWtKy+i35RAaIsqGc
         YYpb6EHY6WGpF1QO657rmcKInIALsnUwu7XXWfMHA4jWEOxpOTV9p4srfx3ugdTOALk1
         Bn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=p3wUvEbSn9f+WPyEEsvBQpBZL7x1SSk0c7XRYZKC7go=;
        b=p/4T3cTNSL/cmV7Ko3vnF26uMfMQLax/zajsiwvx2t7pTr1XCYSxgVKhaHMRehNiRQ
         yQejgvFEQtNyTtPZneCd+0CfyYCnjtNWtIPZZv7IWI8+S16L7nbuOAwd4dZ9M99xZmdz
         8gUWD8LF+NyqhTtLi/54695f24VHAvMBR+FoBE+dD8MzSGqHhUAs2RdtZ0NUE0+0CHzQ
         a2OpI0T9XZlpvSoOKF4zPtT0DiS6bVrjsmsq+jIg19C/77jYp4jyH6eTph4ZY28rknwf
         bDELwNyZWvLHY+cnurxrZ8QFWQztsNUvelEWFDR8aDujMsIpFMrso4ahsLmLWCDoERFO
         BlAA==
X-Gm-Message-State: AGi0PuaVdeC0wMcZURy1EVnw6CnPHgfpAG/RChV0z6CmDRkDJqUxTw2Q
	jIv4o3K1bvjLfEXmRlk8R5BHYw==
X-Google-Smtp-Source: APiQypIYAXUg7Biw0D2TBRkbkjLKeZ1YlBGAyuI6df4rKF0UYwZavIIpzVrPwSNRWmjAPJ3maXqqbw==
X-Received: by 2002:a17:90a:1b26:: with SMTP id q35mr571681pjq.149.1588277232615;
        Thu, 30 Apr 2020 13:07:12 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:fd86:293b:2791:eb06? ([2601:646:c200:1ef2:fd86:293b:2791:eb06])
        by smtp.gmail.com with ESMTPSA id d203sm523177pfd.79.2020.04.30.13.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 13:07:11 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date: Thu, 30 Apr 2020 13:07:09 -0700
Message-Id: <4819995F-4EAE-46EE-8311-9CF65CB8D08A@amacapital.net>
References: <CAPcyv4g8rA2TRvoFHqEjs5Xn74gdZx8uF0PXFYCjTcx56yA=Jw@mail.gmail.com>
In-Reply-To: <CAPcyv4g8rA2TRvoFHqEjs5Xn74gdZx8uF0PXFYCjTcx56yA=Jw@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17E262)
Message-ID-Hash: DTGX34Z5RNYQJDPDQ6IJ5ZXYIS4LVUPL
X-Message-ID-Hash: DTGX34Z5RNYQJDPDQ6IJ5ZXYIS4LVUPL
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Luck, Tony" <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, stable <stable@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Erwin Tsaur <erwin.tsaur@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DTGX34Z5RNYQJDPDQ6IJ5ZXYIS4LVUPL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIEFwciAzMCwgMjAyMCwgYXQgMTI6NTEgUE0sIERhbiBXaWxsaWFtcyA8ZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIFRodSwgQXByIDMwLCAyMDIwIGF0
IDEyOjIzIFBNIEx1Y2ssIFRvbnkgPHRvbnkubHVja0BpbnRlbC5jb20+IHdyb3RlOg0KPj4gDQo+
Pj4gT24gVGh1LCBBcHIgMzAsIDIwMjAgYXQgMTE6NDI6MjBBTSAtMDcwMCwgQW5keSBMdXRvbWly
c2tpIHdyb3RlOg0KPj4+IEkgc3VwcG9zZSB0aGVyZSBjb3VsZCBiZSBhIGNvbnNpc3RlbnQgbmFt
aW5nIGxpa2UgdGhpczoNCj4+PiANCj4+PiBjb3B5X2Zyb21fdXNlcigpDQo+Pj4gY29weV90b191
c2VyKCkNCj4+PiANCj4+PiBjb3B5X2Zyb21fdW5jaGVja2VkX2tlcm5lbF9hZGRyZXNzKCkgW3do
YXQgcHJvYmVfa2VybmVsX3JlYWQoKSBpc10NCj4+PiBjb3B5X3RvX3VuY2hlY2tlZF9rZXJuZWxf
YWRkcmVzcygpIFt3aGF0IHByb2JlX2tlcm5lbF93cml0ZSgpIGlzXQ0KPj4+IA0KPj4+IGNvcHlf
ZnJvbV9mYWxsaWJsZSgpIFtmcm9tIGEga2VybmVsIGFkZHJlc3MgdGhhdCBjYW4gZmFpbCB0byBh
IGtlcm5lbA0KPj4+IGFkZHJlc3MgdGhhdCBjYW4ndCBmYWlsXQ0KPj4+IGNvcHlfdG9fZmFsbGli
bGUoKSBbdGhlIG9wcG9zaXRlLCBidXQgaG9wZWZ1bGx5IGlkZW50aWNhbCB0byBtZW1jcHkoKSBv
biB4ODZdDQo+Pj4gDQo+Pj4gY29weV9mcm9tX2ZhbGxpYmxlX3RvX3VzZXIoKQ0KPj4+IGNvcHlf
ZnJvbV91c2VyX3RvX2ZhbGxpYmxlKCkNCj4+PiANCj4+PiBUaGVzZSBuYW1lcyBhcmUgZmFpcmx5
IHZlcmJvc2UgYW5kIGNvdWxkIHByb2JhYmx5IGJlIGltcHJvdmVkLg0KPj4gDQo+PiBIb3cgYWJv
dXQNCj4+IA0KPj4gICAgICAgIHRyeV9jb3B5X2NhdGNoKHZvaWQgKmRzdCwgdm9pZCAqc3JjLCBz
aXplX3QgY291bnQsIGludCAqZmF1bHQpDQo+PiANCj4+IHJldHVybnMgbnVtYmVyIG9mIGJ5dGVz
IG5vdC1jb3BpZWQgKGxpa2UgY29weV90b191c2VyIGV0YykuDQo+PiANCj4+IGlmIHJldHVybiBp
cyBub3QgemVybywgImZhdWx0IiB0ZWxscyB5b3Ugd2hhdCB0eXBlIG9mIGZhdWx0DQo+PiBjYXVz
ZSB0aGUgZWFybHkgc3RvcCAoI1BGLCAjTUMpLg0KPiANCj4gSSBkbyBsaWtlIHRyeV9jb3B5X2Nh
dGNoKCkgZm9yIHRoZSBjYXNlIHdoZW4gbmVpdGhlciBvZiB0aGUgYnVmZmVycw0KPiBhcmUgX191
c2VyIChsaWtlIGluIHRoZSBwbWVtIGRyaXZlcikgYW5kIF9jb3B5X3RvX2l0ZXJfZmFsbGlibGUo
KQ0KPiAocGx1cyBhbGwgdGhlIGhlbHBlcnMgaXQgaW1wbGllcykgZm9yIHRoZSBvdGhlciBjYXNl
cy4NCj4gDQo+IGNvcHlfdG9fdXNlcl9mYWxsaWJsZQ0KPiBjb3B5X2ZhbGxpYmxlX3RvX3BhZ2UN
Cj4gY29weV9waXBlX3RvX2l0ZXJfZmFsbGlibGUNCj4gDQo+IC4uLmJlY2F1c2UgdGhlIG1tdS1m
YXVsdCBoYW5kbGluZyBpcyBhbiBhc3BlY3Qgb2YgIl91c2VyIiBhbmQgZmFsbGlibGUNCj4gaW1w
bGllcyBvdGhlciBzb3VyY2UgZmF1bHQgcmVhc29ucy4gSXQgZG9lcyBsZWF2ZSBhIGdhcCBpZiBh
bg0KPiBhcmNoaXRlY3R1cmUgaGFzIGEgY29uY2VwdCBvZiBhIGZhbGxpYmxlIHdyaXRlLCBidXQg
dGhhdCBzZWVtcyBsaWtlDQo+IHNvbWV0aGluZyB0aGF0IHdpbGwgYmUgaGFuZGxlZCBhc3luY2hy
b25vdXNseSBhbmQgbm90IHN1YmplY3QgdG8gdGhpcw0KPiBpbnRlcmZhY2UuDQoNCg0KSeKAmW0g
c3VzcGljaW91cyB0aGF0LCBhcyBhIHByYWN0aWNhbCBtYXR0ZXIsIHg4NiBkb2VzIGhhdmUgYSBm
YWxsaWJsZSB3cml0ZS4gSW4gcGFydGljdWxhciwgaWYgYSBwYWdlIGZhaWxzIGFuZCB0aGUgbWVt
b3J5IGZhaWx1cmUgY29kZSBpcyBub3RpZmllZCwgdGhlIHBhZ2Ugd2lsbCBiZSB1bm1hcHBlZC4g
QXQgdGhhdCBwb2ludCwgYW4gYXR0ZW1wdCB0byB3cml0ZSB0byB0aGUgZmFpbGVkIGZhbGxpYmxl
IHBhZ2Ugd2lsbCBnZXQgI1BGLCBhbmQgY29kZSB0aGF0IHdyaXRlcyB0byBpdCBuZWVkcyB0byBi
ZSBwcmVwYXJlZCB0byBoYW5kbGUgI1BGLiAgUGVyaGFwcyBjb3B5X3RvX2ZhbGxpYmxlKCksIGV0
YyBjYW4gc3RpbGwgcmV0dXJuIHZvaWQsIGJ1dCBJ4oCZbSB1bmNvbnZpbmNlZA0KdGhlIGltcGxl
bWVudGF0aW9uIGNhbiBiZSB0aGUgc2FtZSBhcyBtZW1jcHkuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
