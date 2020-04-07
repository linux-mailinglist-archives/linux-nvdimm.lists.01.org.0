Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485321A051A
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Apr 2020 05:05:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB04011017AC7;
	Mon,  6 Apr 2020 20:06:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::241; helo=mail-lj1-x241.google.com; envelope-from=mrwongshiuki7@gmail.com; receiver=<UNKNOWN> 
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7336A11017AC5
	for <linux-nvdimm@lists.01.org>; Mon,  6 Apr 2020 20:06:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t17so1957064ljc.12
        for <linux-nvdimm@lists.01.org>; Mon, 06 Apr 2020 20:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=cajrldfMYzlT5Xc1OKiyPsuoCP2ST9x7cvU8F4TMAO4=;
        b=U3i13eMan5mew7cl9Ia/zqzn1KMs3dGt74cbUmNO9pEltyGZAfjaGZdfnhlKDfH/hD
         1FmJtJv9H0XHM60qFEfMo0GRnGcijI2qs96Qa/gbTVo7U9KdF6E1x3MWsjdZuwmxBEcZ
         copG7jcqBav/u4tUwjNV1bJNWm8vD2btfvts1QBHqA/M5h7REg6AT+839HSLNh/a3Nbs
         CnE+cx6BGH/AWEUzPv9f2A+Nriby5dNL1H+3sopFVTvvrttQjpTxlLuEvEFGfTD2R/Ij
         mHR3QD2cfT6oAS64zoHhgG+8TjVKSL8ygiKMGpHqiPAGb90CoGwgoRfQW2gNR3AOblXJ
         hSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cajrldfMYzlT5Xc1OKiyPsuoCP2ST9x7cvU8F4TMAO4=;
        b=GHY9R5gNI9TODMyxm27ieKzPEdNFPgmn8wjTfAsRbabbOKzLxZYTd3lZ1TtfOqZohp
         O3Zb/i0dHhoFc9mSH5ghK6gINHZsZLIO8i52vyd+oFhP1ukqrhpPXm63czGsdpwpOmi5
         NCbAxlIr4su+1imClDFHDOziLk5c3hpPO5UCN06X4A1chmOE63maSKCCKE+rqJ8VZFcJ
         OmIuAUuDqS6HFkl9UqVccMD/i+XDEBC3rXYLZq0K+cR+uVWsuUZ7lFJH7HbcmB+Rx+5x
         fUoi6SyAazbpYD5bJnclspY2zz1Bt4SlA0Smj8ZrRZSxfKfrDNTziNrad/XmkqfCxPFx
         XMBQ==
X-Gm-Message-State: AGi0PuZmooLKP2eyKR+afV5+ejXPeaHIqoBhKnkUsj/8qtfc0+hBLVR7
	PHdL4B/cKVxkndfE5Z3gcGHSsUVPe5xXnxd9FjY=
X-Google-Smtp-Source: APiQypIX+OBrVstETcXfpCIn2+e+lJJw2cwfb2kMC2w3EcB2IMr8HVKh0+MiwSY2HtgUo/VIDN70ESeyPHjlvkTEySQ=
X-Received: by 2002:a2e:87da:: with SMTP id v26mr225736ljj.63.1586228719987;
 Mon, 06 Apr 2020 20:05:19 -0700 (PDT)
MIME-Version: 1.0
From: "Mrs. Anna H. Bruun" <mrs.annahbruun10@gmail.com>
Date: Tue, 7 Apr 2020 05:05:09 +0200
Message-ID: <CAKhb=JTtiPS7rSOogp0u6QiW0K+KpqVXczvG4DjMtxYVJt0-tg@mail.gmail.com>
Subject: May The Peace of the Lord be with You
To: undisclosed-recipients:;
Message-ID-Hash: ES3RLLVQMS4PWCCBXRKKGJOBXARO3G3P
X-Message-ID-Hash: ES3RLLVQMS4PWCCBXRKKGJOBXARO3G3P
X-MailFrom: mrwongshiuki7@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ES3RLLVQMS4PWCCBXRKKGJOBXARO3G3P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

TWF5IFRoZSBQZWFjZSBvZiB0aGUgTG9yZCBiZSB3aXRoIFlvdQ0KDQpNeSBOYW1lIGlzIE1ycy4g
QW5uYSBILiBCcnV1biwgIGZyb20gTm9yd2F5LiBJIGtub3cgdGhhdCB0aGlzIG1lc3NhZ2Ugd2ls
bA0KYmUgYSBzdXJwcmlzZSB0byB5b3UuIEZpcnN0bHksIEkgYW0gbWFycmllZCB0byBNci4gUGF0
cmljayBCcnV1biwgQSBnb2xkDQptZXJjaGFudCB3aG8gb3ducyBhIHNtYWxsIGdvbGQgTWluZSBp
biBCdXJraW5hIEZhc287IEhlIGRpZWQgb2YNCkNhcmRpb3Zhc2N1bGFyIERpc2Vhc2UgaW4gbWlk
LU1hcmNoIDIwMTEuIER1cmluZyBoaXMgbGlmZSB0aW1lIGhlIGRlcG9zaXRlZA0KdGhlIHN1bSBv
ZiDigqwgOC41IE1pbGxpb24gRXVybykgRWlnaHQgbWlsbGlvbiwgRml2ZSBodW5kcmVkIHRob3Vz
YW5kIEV1cm9zDQppbiBhIGJhbmsgaW4gT3VhZ2Fkb3Vnb3UgdGhlIGNhcGl0YWwgY2l0eSBvZiBC
dXJraW5hIEZhc28gaW4gV2VzdCBBZnJpY2EuDQpUaGUgZGVwb3NpdGVkIG1vbmV5IHdhcyBmcm9t
IHRoZSBzYWxlIG9mIHRoZSBzaGFyZXMsIGRlYXRoIGJlbmVmaXRzIHBheW1lbnQNCmFuZCBlbnRp
dGxlbWVudHMgb2YgbXkgZGVjZWFzZWQgaHVzYmFuZCBieSBoaXMgY29tcGFueS4NCg0KSSBhbSBz
ZW5kaW5nIHRoaXMgbWVzc2FnZSB0byB5b3UgcHJheWluZyB0aGF0IGl0IHdpbGwgcmVhY2ggeW91
IGluIGdvb2QNCmhlYWx0aCwgc2luY2UgSSBhbSBub3QgaW4gZ29vZCBoZWFsdGggY29uZGl0aW9u
IGluIHdoaWNoIEkgc2xlZXAgZXZlcnkNCm5pZ2h0IHdpdGhvdXQga25vd2luZyBpZiBJIG1heSBi
ZSBhbGl2ZSB0byBzZWUgdGhlIG5leHQgZGF5LiBJIGFtIHN1ZmZlcmluZw0KZnJvbSBsb25nIHRp
bWUgY2FuY2VyIGFuZCBwcmVzZW50bHkgaSBhbSBwYXJ0aWFsbHkgc3VmZmVyaW5nIGZyb20gYSBz
dHJva2UNCmlsbG5lc3Mgd2hpY2ggaGFzIGJlY29tZSBhbG1vc3QgaW1wb3NzaWJsZSBmb3IgbWUg
dG8gbW92ZSBhcm91bmQuIEkgYW0NCm1hcnJpZWQgdG8gbXkgbGF0ZSBodXNiYW5kIGZvciBvdmVy
IDQgeWVhcnMgYmVmb3JlIGhlIGRpZWQgYW5kIGlzDQp1bmZvcnR1bmF0ZWx5IHRoYXQgd2UgZG9u
J3QgaGF2ZSBhIGNoaWxkLCBteSBkb2N0b3IgY29uZmlkZWQgaW4gbWUgdGhhdCBpDQpoYXZlIGxl
c3MgY2hhbmNlIHRvIGxpdmUuIEhhdmluZyBrbm93biBteSBoZWFsdGggY29uZGl0aW9uLCBJIGRl
Y2lkZWQgdG8NCmNvbnRhY3QgeW91IHRvIGNsYWltIHRoZSBmdW5kIHNpbmNlIEkgZG9uJ3QgaGF2
ZSBhbnkgcmVsYXRpb24gSSBncmV3IHVwDQpmcm9tIHRoZSBvcnBoYW5hZ2UgaG9tZS4NCg0KSSBo
YXZlIGRlY2lkZWQgdG8gZG9uYXRlIHdoYXQgSSBoYXZlIHRvIHlvdSBmb3IgdGhlIHN1cHBvcnQg
b2YgIGhlbHBpbmcNCk1vdGhlcmxlc3MgYmFiaWVzL0xlc3MgcHJpdmlsZWdlZC9XaWRvd3MnIGJl
Y2F1c2UgSSBhbSBkeWluZyBhbmQgZGlhZ25vc2VkDQpvZiBjYW5jZXIgZm9yIGFib3V0IDIgeWVh
cnMgYWdvLiBJIGhhdmUgYmVlbiB0b3VjaGVkIGJ5IEdvZCBBbG1pZ2h0eSB0bw0KZG9uYXRlIGZy
b20gd2hhdCBJIGhhdmUgaW5oZXJpdGVkIGZyb20gbXkgbGF0ZSBodXNiYW5kIHRvIHlvdSBmb3Ig
Z29vZCB3b3JrDQpvZiBHb2QgQWxtaWdodHkuIEkgaGF2ZSBhc2tlZCBBbG1pZ2h0eSBHb2QgdG8g
Zm9yZ2l2ZSBtZSBhbmQgYmVsaWV2ZSBoZQ0KaGFzLCBiZWNhdXNlIEhlIGlzIGEgTWVyY2lmdWwg
R29kIEkgd2lsbCBiZSBnb2luZyBpbiBmb3IgYW4gb3BlcmF0aW9uDQpzdXJnZXJ5IHNvb24NCg0K
VGhpcyBpcyB0aGUgcmVhc29uIGkgbmVlZCB5b3VyIHNlcnZpY2VzIHRvIHN0YW5kIGFzIG15IG5l
eHQgb2Yga2luIG9yIGFuDQpleGVjdXRvciB0byBjbGFpbSB0aGUgZnVuZHMgZm9yIGNoYXJpdHkg
cHVycG9zZXMuIElmIHRoaXMgbW9uZXkgcmVtYWlucw0KdW5jbGFpbWVkIGFmdGVyIG15IGRlYXRo
LCB0aGUgYmFuayBleGVjdXRpdmVzIG9yIHRoZSBnb3Zlcm5tZW50IHdpbGwgdGFrZQ0KdGhlIG1v
bmV5IGFzIHVuY2xhaW1lZCBmdW5kIGFuZCBtYXliZSB1c2UgaXQgZm9yIHNlbGZpc2ggYW5kIHdv
cnRobGVzcw0KdmVudHVyZXMsIEkgbmVlZCBhIHZlcnkgaG9uZXN0IHBlcnNvbiB3aG8gY2FuIGNs
YWltIHRoaXMgbW9uZXkgYW5kIHVzZSBpdA0KZm9yIENoYXJpdHkgd29ya3MsIGZvciBvcnBoYW5h
Z2VzLCB3aWRvd3MgYW5kIGFsc28gYnVpbGQgc2Nob29scyBmb3IgbGVzcw0KcHJpdmlsZWdlIHRo
YXQgd2lsbCBiZSBuYW1lZCBhZnRlciBteSBsYXRlIGh1c2JhbmQgYW5kIG15IG5hbWU7IEkgbmVl
ZCB5b3VyDQp1cmdlbnQgYW5zd2VyIHRvIGtub3cgaWYgeW91IHdpbGwgYmUgYWJsZSB0byBleGVj
dXRlIHRoaXMgcHJvamVjdCwgYW5kIEkNCndpbGwgZ2l2ZSB5b3UgbW9yZSBpbmZvcm1hdGlvbiBv
biBob3cgdGhlIGZ1bmQgd2lsbCBiZSB0cmFuc2ZlcnJlZCB0byB5b3VyDQpiYW5rIGFjY291bnQu
DQoNCg0KVGhhbmtzDQpNcnMuIEFubmEgSC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
