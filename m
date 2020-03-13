Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9345184A2E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 16:05:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 03D1D10FC3887;
	Fri, 13 Mar 2020 08:05:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com; envelope-from=ogbonna100@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5213510FC3886
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 08:05:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j2so109724qkl.7
        for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 08:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=j2QEI9qhE499vmlTCneDpKaQfUXMxdNli1p0sYnTZJ8=;
        b=QDxQO+D2/i7ke+aVMh9xK4b68MqlMDukiKeGAyAVOv/UvbSMNvl8OcrVktR8dVZcJC
         PN2aCW5GRoPlKUnzUbVXQYxc9raNiQgESelwinDH52Xn8KC7M4SZzzua1b9Mtbw3uuBD
         B7xiAK9bBLvDUVxLBv/qN4TCX/tA+0CuVXQkBRJr+LtHpOO+bIDce+vhK7+MM6ROYIPZ
         11aab6TG1/c9y8n8v3w7GIpeb1N0IPRepN09KJ8RXz6eSYbjc14YvPLVD+AyNMsUPEaZ
         dZlOLWxWNqf9fzdmrvb5aWaulqZO5/uIZP36/+N2vAoA50OtidGunuj1bnZEquhf1A6S
         XOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=j2QEI9qhE499vmlTCneDpKaQfUXMxdNli1p0sYnTZJ8=;
        b=TFLFBpiXyFJ/XjF1NYbetKn6Gnenyr3l9BAQHhvC3obw7gmvBnOpalndFaUd4xHr58
         /kWurjMfv1cJ/aXGKSCgDfpRvekYonR5tmuSYiAGDBaOEveJekprvmhBwAj2QG6IU42g
         DLkkAPfWHVOjvyxVzi8zBQlBelXU9Ef3orEuLOVxozgWaBkDA8obQ0rk74Dejx/wMvGc
         d+g765UFo/I1+06YKoqylcF2XK6EQT/gp1GIKOESLlbjm4RbrCV2NHNT1038KBPIOxCZ
         JdRxTTTcJ+gNiRb/lt0rAEsjEtXe32nsLkuMDgWHHmpO/ggTbeSKc4TrqZQNDgTZqzMz
         b13w==
X-Gm-Message-State: ANhLgQ0uJ6/ck/okYmd+KH7MmdLQY9n5+lyZc6mL+NYVSa/WvN45LDUZ
	XybFXkHrI73SzXt7dahKL0PJQIr60+7JV0+ZnFM=
X-Google-Smtp-Source: ADFU+vuJssxI9hUfHwB+c4MHxpPMleTdlHiz+EZnFAVc1FDw/7eVpxytY7IIhvJ8k+wL2+uGNh1LmD9j3zHuHlJnN9g=
X-Received: by 2002:a05:620a:110c:: with SMTP id o12mr13231329qkk.87.1584111897959;
 Fri, 13 Mar 2020 08:04:57 -0700 (PDT)
MIME-Version: 1.0
From: Komlaw Louis Atohm <ogbonna100@gmail.com>
Date: Fri, 13 Mar 2020 16:04:46 +0100
Message-ID: <CA+YdZB2exLknazr1-jME-r-zFK=-KOfrYB2XQJPHo-9C+z_c0g@mail.gmail.com>
Subject: =?UTF-8?B?15TXkNedINeQ16rXlCDXoteT15nXmdefINee16nXqtee16kg15HXk9eV15Ai15wg15bXlA==?=
To: undisclosed-recipients:;
Message-ID-Hash: 2LITDK6H5LKRDHXVRB3MMO2B6F5XHVK7
X-Message-ID-Hash: 2LITDK6H5LKRDHXVRB3MMO2B6F5XHVK7
X-MailFrom: ogbonna100@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: atohmk225@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2LITDK6H5LKRDHXVRB3MMO2B6F5XHVK7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

157XlCDXqdec15XXnteaLA0KDQrXqNenINeo15XXpteUINec15DXqdeoINeQ150g15DXqteUINei
15PXmdeZ158g157Xqdeq157XqSDXkdeb16rXldeR16og15PXldeQItecINeW15U/INeQ150g15vX
nywg15DXoNeQINeU16nXkSDXnNeT15XXkNeoDQrXlNeQ15fXqNeV158g16nXqdec15fXqteZINeQ
15zXmdeaLCDXoNeV16nXkCDXl9ep15XXkSDXqdeQ16DXmSDXqNeV16bXlCDXnNeT15XXnyDXkNeq
15ouDQoNCtee16bXpNeUINec16nXnteV16Ig157XnteaLg0KDQrXotedINee16nXkNec15XXqteZ
15og15TXmNeV15HXldeqINeR15nXldeq16ghDQoNCg0KQXRvaCBMb3VpcyBLb21sYWgNCg0KDQoN
Cg0KDQpIb3cgYXJlIHlvdSwNCg0KIEp1c3Qgd2FudCB0byBjb25maXJtIGlmICB5b3UgU3RpbGwg
dXNpbmcgdGhpcyBlbWFpbCBhZGRyZXNzPyBJZiBzbywgcGxlYXNlDQpyZXBseSB0byBteSBsYXN0
IG1haWwgaSBzZW50IHlvdSwgYW4gaW1wb3J0YW50IGlzc3VlIEkgd291bGQgbGlrZSB0bw0KZGlz
Y3VzcyB3aXRoIHlvdS4NCg0KTG9va2luZyBmb3J3YXJkIHRvIGhlYXJpbmcgZnJvbSB5b3UuDQoN
CiBXaXRoIHlvdXIgYmVzdCB3aXNoZXMhDQoNCkF0b2ggTG91aXMgS29tbGFoDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
