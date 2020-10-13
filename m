Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD2428D054
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Oct 2020 16:38:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D66AC15737C47;
	Tue, 13 Oct 2020 07:38:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=sarah.madelyn@acuitydatasolns.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0211C15737C41
	for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 07:38:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq12so21199615edb.2
        for <linux-nvdimm@lists.01.org>; Tue, 13 Oct 2020 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=acuitydatasolns-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=knVSjQj7sqMeSJ2VuFojoMy94SN3WJxTCA2yiyBFtQA=;
        b=yO6kime3gkLTFO3S+fv8Eu17MkNq2gvXEnlEXxzCx+miYeqM98KlEtDiMsMf0LAeyE
         A6iJwf8jnL1z+snUtiZ5gUHZjL0e+idQG8NutizdcGO0QIq/3ATbtDySnUhm2szMdW3K
         wwueTAjEkyRnGnk+q0mYjAbukBWEYu2oSZgR9lBU9usXGyZlT0OOgVEHcrQK41HpQtzy
         rY0I9VkfpLUNt/EcMvNvPo39tdhU72gfjYm/1Pm6P4e8UUsGA4rK52fYkkB7kImm9DdQ
         7eQYFzirBYM0SLLJ3OB+3Wxx3Qham6KZFKG+4byMwDVLR3A3oX7BPrpt4T2xPpF4yLmD
         ayzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=knVSjQj7sqMeSJ2VuFojoMy94SN3WJxTCA2yiyBFtQA=;
        b=grk2myHmruadiI5MN5pvljkts2ZDHE21IpdL0x2epcSzIH6HCoIzMcI3oZtpLTTmBv
         f0xgTkVYBnMiZlMSltJnpxe6GdHva+83KpSX2F9aNy2gobxWpZ+KRSMN0R2h80GdMFaX
         A12kvoQortQEXiupeJsEFEVfJnIKnkreFZtcAjbGUaNtsnYoq6tCzOrCAvhRMp7+D2pd
         qEJjTMjjv5aqeMCN9GiTbzOpH1TetqbzsSXl6ubGgM2NCEKJ9LwB1g3FsP+ty0NlFRZ6
         3lg8oikkI2smX/C1UsYOzW+GqYEF0cfWOIS/UhZvh9o0RRsXpwlSBk4w3tXE5N8B444v
         YYLw==
X-Gm-Message-State: AOAM531+yg9Tkxf7KLj6sQiKWq7Wdnl2CJ3fHsiKAHnIXJbto9VPguzi
	CcwIyu6q/qcq9lnb0+xESPrSTtcevD3IvKuERmWvvQ==
X-Google-Smtp-Source: ABdhPJwQqSOjKoJDes+m0E2qy0dfgJ+YOeNzT0gnvwas1R8RtFelKX3VjZYcGGrWqk4M1iS9u59FPsh/iNapOGBlvkM=
X-Received: by 2002:a05:6402:209:: with SMTP id t9mr21346500edv.208.1602599896285;
 Tue, 13 Oct 2020 07:38:16 -0700 (PDT)
MIME-Version: 1.0
From: Sarah Madelyn <sarah.madelyn@acuitydatasolns.com>
Date: Tue, 13 Oct 2020 07:38:07 -0700
Message-ID: <CAGtCFHWC=5Vvt4XEwrcoKbsKrDWzftQghXZktcG+TweNK_8fZg@mail.gmail.com>
Subject: Outstanding Offer for WESTEC Exhibitors 2020
To: undisclosed-recipients:;
Message-ID-Hash: O2XHLKE6GYVTIGRLIWUD465RT7FB6XZ3
X-Message-ID-Hash: O2XHLKE6GYVTIGRLIWUD465RT7FB6XZ3
X-MailFrom: sarah.madelyn@acuitydatasolns.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O2XHLKE6GYVTIGRLIWUD465RT7FB6XZ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCg0KDQpIb3BlIHlvdSBhcmUgZG9pbmcgd2VsbC4NCg0KDQoNCkkgc2VlIHRoYXQg
eW91ciBjb21wYW55IHdhcyBhIHBhcnQgb2Ygb25saW5lIGV2ZW50ICpXRVNURUMgMjAyMCoNCg0K
DQoNClNvIEnigJltIHdvbmRlcmluZyBpZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gYWNxdWlyaW5n
IEF0dGVuZGVlcyBMaXN0IGNvbnRhY3RzDQpvZg0KDQoqOCw5NDAgKmZvciB5b3VyIHByZSBhbmQg
cG9zdCBldmVudCBjYW1wYWlnbnMuDQoNCg0KDQoqT05FIFRJTUUgRkxBVCBPRkZFUiAkNDk5Kg0K
DQoNCg0KV2UgcHJvdmlkZSBhbGwgdGhlIHJlbGV2YW50IGluZm9ybWF0aW9uIGFib3V0IHRoZSBh
dHRlbmRlZSBpbmNsdWRpbmcNCkNvbXBhbnkgTmFtZSwgQ29tcGFueSBVUkwsIENvbnRhY3QgTmFt
ZSwgVGl0bGUsIFBob25lIG51bWJlciwgRmF4IE51bWJlciwNCkVtYWlsIEFkZHJlc3MsIENvbXBh
bnkgQWRkcmVzcyBhbmQgSW5kdXN0cnkgdHlwZS4gSGVuY2UgeW91IGNhbiB1c2UgdGhpcw0KaW5m
b3JtYXRpb24gZm9yIHlvdXIgZW1haWwsIHRlbGVwaG9uaWMgYW5kIG1haWxpbmcgY2FtcGFpZ25z
Lg0KDQoNCg0KSWYgeW91IGFyZSBpbnRlcmVzdGVkLCBkcm9wIG1lIGEgbGluZS4gV2Ugd2lsbCBn
ZXQgYmFjayB0byB5b3Ugd2l0aA0KcHJpY2luZywgY291bnRzIGFuZCBvdGhlciBpbmZvcm1hdGlv
biBmb3IgeW91ciByZXZpZXcuDQoNCklmIHlvdSB0aGluayBJIHNob3VsZCBiZSB0YWxraW5nIHRv
IHNvbWVvbmUgZWxzZSwgcGxlYXNlIGZvcndhcmQgdGhpcyBlbWFpbA0KdG8gdGhlIGNvbmNlcm5l
ZCBwZXJzb24uDQoNCkxvb2tpbmcgZm9yd2FyZCB0byBoZWFyaW5nIGZyb20geW91Lg0KDQoNCg0K
QmVzdCBSZWdhcmRzLA0KDQoNCg0KKlNhcmFoIE1hZGVseW4qDQoNCipBY3VpdHkgRGF0YSBTb2x1
dGlvbnMqDQoNCipNYXJrZXRpbmcgYW5kIGNvbW11bmljYXRpb24qDQoNCg0KDQpJZiAgIHlvdSBk
b24ndCB3aXNoIHRvIHJlY2VpdmUgZW1haWxzIGZyb20gdXMgcmVwbHkgYmFjayB3aXRoDQrigJxV
bnN1YnNjcmliZeKAnS4gU3RheSBTYWZlIOKAkyBDT1ZJRC0xOQ0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAt
LSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
