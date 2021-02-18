Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA5231EABF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Feb 2021 15:10:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3EEF6100EBB6F;
	Thu, 18 Feb 2021 06:10:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com; envelope-from=traoreahm11@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A58BF100ED4BF
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 06:10:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p186so2285692ybg.2
        for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 06:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LT9hi1/MIWP6C65ZPSsx0zHyg4jIhFJKq6DjKV8bu1Q=;
        b=pMpyXbzpL/TIhT5wESanJ/k4BkKUGJ9lE35SrBCDboiYgnHTaB3XQPxRU6iMWYwDiw
         R4GCT1W22u24RogBdsD9ltWpZpR7RGs8F35DKhWb4SV6lhv0RS7l3uN+MbolahSGnFHk
         b2/J8xY1/qTLkIGEd1dct+b5CMCM517xKemRYqF6kCRLsV/BsCmjgOtIXt6rvGqwgtE2
         aZBgKXrsp+xDnmJrUGAtKpxgpda4MxY7nQQ/3IMhViSoI8SPNRD0IS8r6RW+gDy9VHFd
         cHZ4g91WuCxYBnirNZVjeGhjKGS2nFPfuCgRaDvEoXRS60VLGL9F5tNC9pfFjBNLsWWJ
         govw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LT9hi1/MIWP6C65ZPSsx0zHyg4jIhFJKq6DjKV8bu1Q=;
        b=IYLUksudOU60Ys1PJVe1nd+HI8zfQGCVMs7lcowLzbylgP2u3F81q3tWFTtPuLBoaP
         53wnYGGkVN0tP2WdR3EI8Not0u3ZL4UtTVRlwwMbAFy8vlQxIm69/bXjpVRQyd5hwa9w
         CrYAoymY7nK6sDXYwG7mOUl5TUwktasgUVFm84Mq2FGbdlQfRVLP7cy8tUpffFO5YP9W
         AKtmNVGghm+EJp06NctEZPFIP/Hv7wmqIAbfDLP+ObNmyNHTI4s8FPNHTeKmnblnly16
         rfBUbA6KwmbtGJ0S5ltkXka131H9H66kX0dLyzSXkHOIRTWffdGMU8bRXapBJy9tT6Tz
         DqKQ==
X-Gm-Message-State: AOAM532cJmtqy3ZicJNRxHEm21bifk8k7h8P8wuGQ3nvOvjMZojdBSPv
	9VSOjAt/MMzPEK1k4wj8rcKBmUATSErz8Ul+3Lc=
X-Google-Smtp-Source: ABdhPJx5IqXzRIgl5Vr4aXt+h2Frff1LQyEe4AqfG46YbfBzm6EFLKzEWdOkYNIZFanG3fd1LwSgIyp01uP0ojEht1I=
X-Received: by 2002:a25:338b:: with SMTP id z133mr6636474ybz.313.1613657409985;
 Thu, 18 Feb 2021 06:10:09 -0800 (PST)
MIME-Version: 1.0
From: "Mr. Abderazack Zebdani" <azebdani13@gmail.com>
Date: Thu, 18 Feb 2021 14:09:54 -0800
Message-ID: <CALBWaBY-eZZR-Fo4c1uzzR0RU1ehZ+p-YTGaRxjL3=Nf_dPedw@mail.gmail.com>
Subject: I wait for your good response!
To: undisclosed-recipients:;
Message-ID-Hash: ELPZAEHGWP3QJWNLI6ZYMYNP2Y6TAWBG
X-Message-ID-Hash: ELPZAEHGWP3QJWNLI6ZYMYNP2Y6TAWBG
X-MailFrom: traoreahm11@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ELPZAEHGWP3QJWNLI6ZYMYNP2Y6TAWBG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SSB3YWl0IGZvciB5b3VyIGdvb2QgcmVzcG9uc2UhDQoNCkdyZWV0aW5ncyB0byB5b3UsIFBsZWFz
ZSBwZXJtaXQgbWUgdG8gaW50cm9kdWNlIG15c2VsZiwgSSBjYW1lIGFjcm9zcyB5b3VyDQplLW1h
aWwgcHJpb3IgdG8gYSBwcml2YXRlIHNlYXJjaCB3aGlsZSBpbiBuZWVkIG9mIHlvdXIgYXNzaXN0
YW5jZS4gTXkgbmFtZQ0KaXMgTXIuIEFiZGVyYXphY2sgWmViZGFuaSwgZnJvbSBCdXJraW5hIEZh
c28sIEkgd29yayBpbiBCYW5rIE9mIEFmcmljYQ0KKEJPQSkgYXMgVGVsZXggTWFuYWdlciwgcGxl
YXNlIHNlZSB0aGlzIGFzIGEgY29uZmlkZW50aWFsIG1lc3NhZ2UgYW5kIGRvDQpub3QgcmV2ZWFs
IGl0IHRvIGFub3RoZXIgcGVyc29uIGFuZCBsZXQgbWUga25vdyB3aGV0aGVyIHlvdSBjYW4gYmUg
b2YNCmFzc2lzdGFuY2UgcmVnYXJkaW5nIG15IHByb3Bvc2FsIGJlbG93IGJlY2F1c2UgaXQgaXMg
dG9wIHNlY3JldC4NCg0KTmV2ZXJ0aGVsZXNzLCBJIHdhbnQgeW91IHRvIHVuZGVyc3RhbmQgdGhh
dCB0aGVyZSBhcmUgc3RpbGwgZ2VudWluZSBhbmQNCmxlZ2l0aW1hdGUgYnVzaW5lc3MgY2xhc3Mg
cGVyc29ucyBpbiB0aGUgaW50ZXJuZXQgd29ybGQgdG9kYXkgc28gSSBhbQ0KYXNzdXJpbmcgeW91
IHRoYXQgdGhpcyB0cmFuc2FjdGlvbiBpcyAxMDAlIGdlbnVpbmUuDQoNCkkgYW0gYWJvdXQgdG8g
cmV0aXJlIGZyb20gYWN0aXZlIEJhbmtpbmcgc2VydmljZSB0byBzdGFydCBhIG5ldyBsaWZlIGJ1
dCBJDQphbSBza2VwdGljYWwgdG8gcmV2ZWFsIHRoaXMgcGFydGljdWxhciBzZWNyZXQgdG8gYSBz
dHJhbmdlci4gWW91IG11c3QNCmFzc3VyZSBtZSB0aGF0IGV2ZXJ5dGhpbmcgd2lsbCBiZSBoYW5k
bGVkIGNvbmZpZGVudGlhbGx5IGJlY2F1c2Ugd2UgYXJlIG5vdA0KZ29pbmcgdG8gc3VmZmVyIGFn
YWluIGluIGxpZmUuIEl0IGhhcyBiZWVuIDEwIHllYXJzIG5vdyB0aGF0IG1vc3Qgb2YgdGhlDQpn
cmVlZHkgQWZyaWNhbiBQb2xpdGljaWFucyB1c2VkIG91ciBiYW5rIHRvIGxhdW5kZXIgbW9uZXkg
b3ZlcnNlYXMgdGhyb3VnaA0KdGhlIGhlbHAgb2YgdGhlaXIgUG9saXRpY2FsIGFkdmlzZXJzLiBN
b3N0IG9mIHRoZSBmdW5kcyB3aGljaCB0aGV5DQp0cmFuc2ZlcnJlZCBvdXQgb2YgdGhlIHNob3Jl
cyBvZiBBZnJpY2Egd2VyZSBnb2xkIGFuZCBvaWwgbW9uZXkgdGhhdCB3YXMNCnN1cHBvc2VkIHRv
IGhhdmUgYmVlbiB1c2VkIHRvIGRldmVsb3AgdGhlIGNvbnRpbmVudC4gVGhlaXIgUG9saXRpY2Fs
DQphZHZpc2VycyBhbHdheXMgaW5mbGF0ZWQgdGhlIGFtb3VudHMgYmVmb3JlIHRyYW5zZmVycmlu
ZyB0byBmb3JlaWduDQphY2NvdW50cywgc28gSSBhbHNvIHVzZWQgdGhlIG9wcG9ydHVuaXR5IHRv
IGRpdmVydCBwYXJ0IG9mIHRoZSBmdW5kcyBoZW5jZQ0KSSBhbSBhd2FyZSB0aGF0IHRoZXJlIGlz
IG5vIG9mZmljaWFsIHRyYWNlIG9mIGhvdyBtdWNoIHdhcyB0cmFuc2ZlcnJlZCBhcw0KYWxsIHRo
ZSBhY2NvdW50cyB1c2VkIGZvciBzdWNoIHRyYW5zZmVycyB3ZXJlIGJlaW5nIGNsb3NlZCBhZnRl
ciB0cmFuc2Zlci4NCkkgYWN0ZWQgYXMgdGhlIEJhbmsgT2ZmaWNlciB0byBtb3N0IG9mIHRoZSBw
b2xpdGljaWFucyBhbmQgd2hlbiBJDQpkaXNjb3ZlcmVkIHRoYXQgdGhleSB3ZXJlIHVzaW5nIG1l
IHRvIHN1Y2NlZWQgaW4gdGhlaXIgZ3JlZWR5IGFjdDsgSSBhbHNvDQpjbGVhbmVkIHNvbWUgb2Yg
dGhlaXIgYmFua2luZyByZWNvcmRzIGZyb20gdGhlIEJhbmsgZmlsZXMgYW5kIG5vIG9uZSBjYXJl
ZA0KdG8gYXNrIG1lIGJlY2F1c2UgdGhlIG1vbmV5IHdhcyB0b28gbXVjaCBmb3IgdGhlbSB0byBj
b250cm9sLiBUaGV5DQpsYXVuZGVyZWQgb3ZlciAkNWJpbGxpb24gRG9sbGFycyBkdXJpbmcgdGhl
IHByb2Nlc3MuDQoNCkJlZm9yZSBJIHNlbmQgdGhpcyBtZXNzYWdlIHRvIHlvdSwgSSBoYXZlIGFs
cmVhZHkgZGl2ZXJ0ZWQgKCQxMC41bWlsbGlvbg0KRG9sbGFycykgdG8gYW4gZXNjcm93IGFjY291
bnQgYmVsb25naW5nIHRvIG5vIG9uZSBpbiB0aGUgYmFuay5UaGUgYmFuayBpcw0KYW54aW91cyBu
b3cgdG8ga25vdyB3aG8gdGhlIGJlbmVmaWNpYXJ5IHRvIHRoZSBmdW5kcyBpcywgYmVjYXVzZSB0
aGV5IGhhdmUNCm1hZGUgYSBsb3Qgb2YgcHJvZml0cyB3aXRoIHRoZSBmdW5kcy4gSXQgaXMgbW9y
ZSB0aGFuIEVpZ2h0IHllYXJzIG5vdywgSQ0KZG9u4oCZdCB3YW50IHRvIHJldGlyZSBmcm9tIHRo
ZSBiYW5rIHdpdGhvdXQgdHJhbnNmZXJyaW5nIHRoZSBmdW5kcyB0byBhDQpmb3JlaWduIGFjY291
bnQsIEkgb25seSB3YW50IHlvdSB0byBhc3Npc3QgbWUgYnkgcHJvdmlkaW5nIGEgcmVsaWFibGUg
YmFuaw0KYWNjb3VudCB3aGVyZSB0aGUgZnVuZHMgY2FuIGJlIHRyYW5zZmVycmVkLiBUaGUgbW9u
ZXkgd2lsbCBiZSBzaGFyZWQgNjAlDQpmb3IgbWUgYW5kIDQwJSBmb3IgeW91LiBUaGVyZSBpcyBu
byBvbmUgY29taW5nIHRvIGFzayB5b3UgYWJvdXQgdGhlIGZ1bmRzDQpiZWNhdXNlIEkgc2VjdXJl
ZCBldmVyeXRoaW5nLg0KDQpZb3UgYXJlIG5vdCB0byBmYWNlIGFueSBkaWZmaWN1bHRpZXMgb3Ig
bGVnYWwgaW1wbGljYXRpb25zIGFzIEkgYW0gZ29pbmcgdG8NCmhhbmRsZSB0aGUgdHJhbnNmZXIg
cGVyc29uYWxseS4gSWYgeW91IGFyZSBjYXBhYmxlIG9mIHJlY2VpdmluZyB0aGUgZnVuZHMsDQpk
byBsZXQgbWUga25vdyBpbW1lZGlhdGVseSB0byBlbmFibGUgbWUgdG8gZ2l2ZSB5b3UgZGV0YWls
ZWQgaW5mb3JtYXRpb24gb24NCndoYXQgdG8gZG8uIEZvciBtZSwgSSBhbSBsb29raW5nIGZvcndh
cmQgdG8gaGVhcmluZyBmcm9tIHlvdSBzb29uLg0KDQpUaGFua3Mgd2l0aCBteSBiZXN0IHJlZ2Fy
ZHMuDQpNci4gQWJkZXJhemFjayBaZWJkYW5pDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
