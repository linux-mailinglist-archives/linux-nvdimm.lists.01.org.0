Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D35257814
	for <lists+linux-nvdimm@lfdr.de>; Mon, 31 Aug 2020 13:17:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2242113995FA7;
	Mon, 31 Aug 2020 04:17:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::143; helo=mail-il1-x143.google.com; envelope-from=azizissaa101@gmail.com; receiver=<UNKNOWN> 
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D56E813995FA7
	for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 04:17:26 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q14so679386ilm.2
        for <linux-nvdimm@lists.01.org>; Mon, 31 Aug 2020 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LEisga0HEyOHXoukHr3NTMNjOTRAldNjVdgW/U4Qb/M=;
        b=syHkTyNrbwCC1UVVqrvzZ6/vxw0rwdyCHCbycBlpTZgunnI+8GF8mS5rVonQ8N7hr+
         jaGsPbb7cqjeOMLKPI3zbIrJZ2dRrcyZhLbuoyLTorfuUpnsJVEooWh57f/Ny0gIJK4P
         dOwPEmNd2jIFybvudoDmmSsHbX4UccqM+xG0mBqaitV7KHKSFV+6MlBRa3vzGtWLZhEN
         z1c66aDFDbpLlLQZJ2qC/TC2xeHF6bTB2FsTUHWE7yvF4MiOgH1eBpNPEKZ1yFcsbHGG
         p3xdusnM/MoCe2cTNvl+4R5TURKQsiggzvF1pMyluw68SRrxpYhLdsWiEzrHXEnsGHMy
         7YJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LEisga0HEyOHXoukHr3NTMNjOTRAldNjVdgW/U4Qb/M=;
        b=RZph2y/Ze8ZtA10LEqYL/afrYTUfNO93tpvbMjY0MEJIT2h2GO+nWdlWDF2LyyHy/H
         OdBE9EB8XKTLiWd4GYbZw1OwI46nhUSYBsJc/eL5Izs9R//W8JgBMXL2jtOO9hHd7nj8
         ly6SlX7gtTrYC98xaIqT9ndXoGigqFPPNInmCL57PY7jVgq5ilwOJSBUonPwfbUgF+gK
         9UiL9dPM2kwYeqSKRvJLsyLrDYm+pa3wONTRh04jzRAOp3Io6aAiHbIrGloxRzVzEYkQ
         m6NxPfH6vyqOKiOOCx9Lt5HdSIM16cshqBcft8MobjYuzvodU+2y0F9650K9RrAxg4hp
         18hg==
X-Gm-Message-State: AOAM530InA+ZNOEslMdz3cbzSkoazTajmpb/C3JHI/LqiKJdpI7b1uMb
	Fxbbsm23OQiKHF5bYoBgdkXmYvKnEKny5vd6UWg=
X-Google-Smtp-Source: ABdhPJz0GqLcfnhubnEUSrpPINlWqe2GQWo32Fx89Wpzx79JYqBXJArxkvWidMsfAYEgWCPZPuUOSf0MUp2NKhb8JYA=
X-Received: by 2002:a05:6e02:c1:: with SMTP id r1mr923799ilq.79.1598872645246;
 Mon, 31 Aug 2020 04:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:98f:0:0:0:0 with HTTP; Mon, 31 Aug 2020 04:17:23
 -0700 (PDT)
From: "Miss.Aisha Gaddafi" <azizissaa101@gmail.com>
Date: Mon, 31 Aug 2020 04:17:23 -0700
Message-ID: <CALbx=XSET8wASbcGc+_EAZ4nzy0ravxbM6p6tQbWx1brsazCUg@mail.gmail.com>
Subject: URGENT BUSINESS PROPOSAL
To: undisclosed-recipients:;
Message-ID-Hash: QZRFAFZTHQUFU5IU4XGW5YSGOYZY6QPE
X-Message-ID-Hash: QZRFAFZTHQUFU5IU4XGW5YSGOYZY6QPE
X-MailFrom: azizissaa101@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: aishsgaddafi00@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QZRFAFZTHQUFU5IU4XGW5YSGOYZY6QPE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

LS0gDQpEZWFyZXN0IE9uZSwNCg0KSSBhbSBNaXNzIEFpc2hhIEdhZGRhZmksIG9uZSBvZiB0aGUg
ZGF1Z2h0ZXJzIG9mIHRoZSBlbWJhdHRsZWQNCnByZXNpZGVudCBvZiBMaWJ5YSwgSSBhbSBjdXJy
ZW50bHkgcmVzaWRpbmcgaW4gb25lIG9mIHRoZSBBZnJpY2FuDQpDb3VudHJpZXMsIHVuZm9ydHVu
YXRlbHkgYXMgYSByZWZ1Z2VlLiBBdCB0aGUgbWVhbnRpbWUsIG15IGZhbWlseSBpcw0KdGhlIHRh
cmdldCBvZiBXZXN0ZXJuIG5hdGlvbnMgbGVkIGJ5IE5hdG8gd2hvIHdhbnRzIHRvIGRlc3Ryb3kg
bXkNCmZhdGhlciBhdCBhbGwgY29zdHMuIE91ciBpbnZlc3RtZW50cyBhbmQgYmFuayBhY2NvdW50
cyBpbiBzZXZlcmFsDQpjb3VudHJpZXMgYXJlIHRoZWlyIHRhcmdldHMgdG8gZnJlZXplLg0KDQpJ
IGhhdmUgYmVlbiBjb21taXNzaW9uZWQgdG8gY29udGFjdCBhbiBpbnRlcmVzdGVkIGZvcmVpZ24N
CmludmVzdG9yL3BhcnRuZXIgd2hvIHdpbGwgYmUgYWJsZSB0byB0YWtlDQphYnNvbHV0ZSBjb250
cm9sIG9mIHBhcnQgb2YgdGhlIHZhc3QgY2FzaCBhdmFpbGFibGUgdG8gcHJpdmF0ZSBhY2NvdW50
DQp3aXRoIG15IGxhdGUgYnJvdGhlciB3aG8gd2FzIGtpbGxlZCBieSBOQVRPIGFpciBzdHJpa2Us
IGZvciBhIHBvc3NpYmxlDQppbnZlc3RtZW50IGluIHlvdXIgY291bnRyeS4NCg0KSWYgdGhpcyB0
cmFuc2FjdGlvbiBpbnRlcmVzdCB5b3UsIHlvdSBkb27igJl0IGhhdmUgdG8gZGlzY2xvc2UgaXQg
dG8gYW55DQpib2R5IGJlY2F1c2Ugb2Ygd2hhdCBpcyBnb2luZyB3aXRoIG15IGVudGlyZSBmYW1p
bHksIGlmIHRoZSB1bml0ZWQNCm5hdGlvbiBoYXBwZW5zIHRvIGtub3cgdGhpcyBhY2NvdW50LCB0
aGV5IHdpbGwgZnJlZXppbmcgaXQgYXMgdGhleQ0KZnJlZXplIG90aGVycyBzbyBrZWVwIHRoaXMg
dHJhbnNhY3Rpb24gZm9yIHlvdXJzZWxmIG9ubHkgdW50aWwgd2UNCmZpbmFsaXplIGl0Lg0KSSB3
YW50IHRvIHRyYW5zZmVyIHRoaXMgbW9uZXkgaW50byB5b3VyIGFjY291bnQgaW1tZWRpYXRlbHkg
Zm9yIG9ud2FyZA0KaW52ZXN0bWVudCBpbiB5b3VyIGNvdW50cnkgYmVjYXVzZSBJIGRvbuKAmXQg
d2FudCB0aGUgdW5pdGVkIG5hdGlvbiB0bw0Ka25vdyBhYm91dCB0aGlzIGFjY291bnQuDQoNClRo
ZXJlZm9yZSBpZiB5b3UgYXJlIGNhcGFibGUgb2YgcnVubmluZyBhbiBlc3RhYmxpc2htZW50IGFu
ZCBjYW4NCm1haW50YWluIHRoZSBoaWdoIGxldmVsIG9mIHNlY3JlY3kgcmVxdWlyZWQgaW4gdGhp
cyBwcm9qZWN0LCBraW5kbHkNCnJlc3BvbmQgd2l0aCB0aGUgZm9sbG93aW5nIGluZm9ybWF0aW9u
IGZvciBkZXRhaWxzIG9mIHRoZQ0KcHJvamVjdC5QbGVhc2UNCg0KMS4gWW91ciBmdWxsIG5hbWVz
IGFuZCBhZGRyZXNzDQoyLiBZb3VyIHByaXZhdGUgdGVsZXBob25lIGFuZCBmYXggbnVtYmVycw0K
My4gWW91ciBwcml2YXRlIGVtYWlsIGFkZHJlc3MNCjQuIEFnZSBhbmQgcHJvZmVzc2lvbg0KDQpC
ZXN0IFJlZ2FyZA0KTWlzcy5BaXNoYSBHYWRkYWZpCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4
LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
