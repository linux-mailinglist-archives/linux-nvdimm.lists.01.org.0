Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E64842457E8
	for <lists+linux-nvdimm@lfdr.de>; Sun, 16 Aug 2020 16:28:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D83A13188DEA;
	Sun, 16 Aug 2020 07:28:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com; envelope-from=confianzayrentabilidad@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 97CCA13188DE8
	for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 07:28:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g75so11860065wme.4
        for <linux-nvdimm@lists.01.org>; Sun, 16 Aug 2020 07:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Duxa+mmNF3T3C2WDKsmzowR2OzvdY892XFjTPp0RWRI=;
        b=NAKDDu3zYGlp6/1rTFA3zLXzfLNUWElMFpld1DGXTqZ3f2C1G5vMMGgQBtzYdv61gR
         j0gW2VjYzcAEQEK9JcrA+yGSHFEXNhE9RNkaz3uxkanP37gacJrIVytgT7/c7zGkA2Dy
         XJB3L8ToVDoWAD9Rvm7U849RIrxncLk9xI9S/Uu5ZGT/cXsim2IUQmYeZsKFSBsv6kJT
         3kDR9KLYjND6JPpx0YTAndrQaTelzP3558OkivI4ykhj79/nak1F6z80uX1/EQIXmTKV
         I+kUa6Zt2XAbNuMItIuLndMdaWWyo32PYvWKoOywYCMLUV2UDlYdbpJ66arhF+MiPCa0
         yMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Duxa+mmNF3T3C2WDKsmzowR2OzvdY892XFjTPp0RWRI=;
        b=NBOY5fBOvdrc5tmYoVdFujoJChQHNA+bM5K5mZEqmG8yzmQ5RuLdC0EX2YtoCjfU8p
         DG8aOhwIH1zdooCyrk/rVu6B0/yMnB96f+zcrPkmAa1PIgb0DMrq8sXLkQ8hE1aeny3p
         ckatGsYL/n/kblxn0VzVqHsz/0AqNrciUvLMMlZtFs5g9XM4qPahzfdhgPh7IUPokDfQ
         pOB0GnUEnQOc+HdjIak/p3Uwxgp5nIQG8Jt8TUDzQJ1n+wLcukcbAuZrN1y7NA0nxRhM
         6Lo7Rv/AhrDAvlnOmhm4nQ2p0FSV82dgz6duHxCc9rHUC01SmtInVYN0YpBuiGPPYCKr
         h+lA==
X-Gm-Message-State: AOAM530YxJWz+Jq+Jz9h6F4iv4hmx+tQy4ZGeLmk+4KZyJDhhnV357Uv
	/r9BR384o6FWOCQtUBhtRheSCubOUIhtSqYoWeM=
X-Google-Smtp-Source: ABdhPJydZZ8FQlFGmrB/EDLy0Z8gH5X03F6EFXypW4K1vf8iv94WhLhI3iwPKgeJEaRZZocHWED4lUmYPOBkTFPeX+4=
X-Received: by 2002:a1c:a1c7:: with SMTP id k190mr10461870wme.1.1597588111746;
 Sun, 16 Aug 2020 07:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6cd3:0:0:0:0:0 with HTTP; Sun, 16 Aug 2020 07:28:30
 -0700 (PDT)
From: "Mr. Scott Donald" <confianzayrentabilidad@gmail.com>
Date: Sun, 16 Aug 2020 07:28:30 -0700
Message-ID: <CANrrfX7wwL97G=jb--8nb9jH8oRO8T90L6NGSfg1HfnzMyyHcw@mail.gmail.com>
Subject: Hello, Please
To: undisclosed-recipients:;
Message-ID-Hash: VL2YBMHZRDYNHOU2B3K45BRAHUL7AL4E
X-Message-ID-Hash: VL2YBMHZRDYNHOU2B3K45BRAHUL7AL4E
X-MailFrom: confianzayrentabilidad@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: sctnld11170@tlen.pl
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VL2YBMHZRDYNHOU2B3K45BRAHUL7AL4E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

LS0gDQpEZWFyIEZyaWVuZCwNCg0KSSdtIE1yLiBTY290dCBEb25hbGQgYSBTdWNjZXNzZnVsIGJ1
c2luZXNzTWFuIGRlYWxpbmcgd2l0aA0KRXhwb3J0YXRpb24sIEkgZ290IHlvdXIgbWFpbCBjb250
YWN0IHRocm91Z2ggc2VhcmNoIHRvIGxldCB5b3Uga25vdyBteQ0KaW50ZW5zaW9uIGFuZCBteSBV
Z2x5IFNpdHVhdGlvbiBBbSBhIGR5aW5nIE1hbiBoZXJlIGluIExvcyBBbmdlbGVzDQpDYWxpZm9y
bmlhIEhvc3BpdGFsIEJlZCBpbiAoVVNBKSwgSSBMb3N0IG15IFdpZmUgYW5kIG15IG9ubHkgRGF1
Z2h0ZXINCmZvciBDb3ZpZC0xOSBhbmQgSSBhbHNvIGhhdmUgYSBwcm9ibGVtIGluIG15IEhlYWx0
aCBhbmQgSSBjYW4gZGllDQphbnl0aW1lIEkgS25vdywNCg0KSSBoYXZlIGEgcHJvamVjdCB0aGF0
IEkgYW0gYWJvdXQgdG8gaGFuZCBvdmVyIHRvIHlvdS4gYW5kIEkgYWxyZWFkeQ0KaW5zdHJ1Y3Rl
ZCB0aGUgQmFua2lhIFMuQS4gTWFkcmlkLCBTcGFpbihCU0EpIHRvIHRyYW5zZmVyIG15IGZ1bmQg
c3VtDQpvZiDCozMsN00gR0JQLiBFcXVpdmFsZW50IHRvIOKCrDQsMDc3LDAzMy45MSBFVVIsIHRv
IHlvdSBhcyB0byBlbmFibGUgeW91DQp0byBnaXZlIDUwJSBvZiB0aGlzIGZ1bmQgdG8gQ2hhcml0
YWJsZSBIb21lIGluIHlvdXIgU3RhdGUgYW5kIHRha2UgNTAlDQpkb24ndCB0aGluayBvdGhlcndp
c2UgYW5kIHdoeSB3b3VsZCBhbnlib2R5IHNlbmQgc29tZW9uZSB5b3UgYmFyZWx5DQprbm93IHRv
IGhlbHAgeW91IGRlbGl2ZXIgYSBtZXNzYWdlLCBoZWxwIG1lIGRvIHRoaXMgZm9yIHRoZSBoYXBw
aW5lc3MNCm9mIG15IHNvdWwgYW5kIGZvciBHb2QgdG8gbWVyY3kgbWUgYW5kIG15IEZhbWlseSBh
bmQgZ2l2ZSBVcyBhIGdvb2QNCnBsYWNlLg0KDQpwbGVhc2UsIGRvIGFzIEkgc2FpZCB0aGVyZSB3
YXMgc29tZW9uZSBmcm9tIHlvdXIgU3RhdGUgdGhhdCBJIGRlZXBseQ0KbG92ZSBzbyB2ZXJ5IHZl
cnkgbXVjaCBhbmQgSSBtaXNzIGhlciBzbyBiYWRseSBJIGhhdmUgbm8gbWVhbnMgdG8NCnJlYWNo
IGFueSBDaGFyaXRhYmxlIEhvbWUgdGhlcmUuIHRoYXQgaXMgd2h5IEkgZ28gZm9yIGEgcGVyc29u
YWwNCnNlYXJjaCBvZiB0aGUgQ291bnRyeSBhbmQgU3RhdGUgYW5kIEkgZ290IHlvdXIgbWFpbCBj
b250YWN0IHRocm91Z2gNCnNlYXJjaCB0byBsZXQgeW91IGtub3cgbXkgQml0dGVybmVzcyBhbmQg
cGxlYXNlLCBoZWxwIG1lIGlzIGdldHRpbmcNCkRhcmsgSSBhc2sgbXkgRG9jdG9yIHRvIGhlbHAg
bWUga2VlcCB5b3Ugbm90aWNlIGZhaWx1cmUgZm9yIG1lIHRvDQpyZWFjaCB5b3UgaW4gcGVyc29u
IFlvdXIgdXJnZW50IFJlc3BvbnNlLCBoZXJlIGlzIG15IERvY3RvciBXaGF0cy1hcHANCk51bWJl
ciBmb3IgdXJnZW50IG5vdGljZSArMTMwMTk2OTI3MzcNCg0KSG9wZSBUbyBIZWFyIEZyb20gWW91
LiBJJ20gc2VuZGluZyB0aGlzIGVtYWlsIHRvIHlvdSBmb3IgdGhlIHNlY29uZA0KdGltZSB5ZXQg
bm8gcmVzcG9uc2UgZnJvbSB5b3UuDQoNCk15IFJlZ2FyZHMuDQoNCk1yLiBTY290dCBEb25hbGQN
CkNFTwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
