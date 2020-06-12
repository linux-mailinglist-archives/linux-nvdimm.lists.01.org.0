Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C61F79EF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 12 Jun 2020 16:46:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 25762100A457D;
	Fri, 12 Jun 2020 07:46:02 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f43; helo=mail-qv1-xf43.google.com; envelope-from=mrsmimiphilip777@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5FB47100A4625
	for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 07:46:00 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p15so4453486qvr.9
        for <linux-nvdimm@lists.01.org>; Fri, 12 Jun 2020 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Zfdq4OIwissKCmn8KumJps6sYPH+ctUi+oO5mKmyoA4=;
        b=LlTC1Z7ILYa9DgZ7p5U28P9LcjIgzhHdFD183gQ8pQYSKiD7Haxx5e50BewJ06Cyu+
         o11zWsBKJ6uBR1iON2gj+/VEoChTUPqeiHHq5K5kQEwg1a4LGKyVe6Nco3o0LB5ezs+Q
         4WUVWb+eL8mv7M/5lLFt18TlpWwlWUwgNZ7PQG0an43Y5pZnn8vMXHGdIH7BUzoC90EK
         YYu07m656QkAAbPdkLwxIXq3KFffXJvevR7/JE1gPZef4KdjtbAdljuPxwP0ZFw9F1dR
         omZvKXu6NlMBKHhvwYNeMT7zue+TgNDuO/gxbzQhsy6OAlxBe8YKOS0XkhbLjAcC+KZ5
         7C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Zfdq4OIwissKCmn8KumJps6sYPH+ctUi+oO5mKmyoA4=;
        b=EvRwu5kfg69u/V3Y+glNuYpWhEmUFPfV+WMmR6R0RFaYJCz3851Q+O2eUoWmticZZg
         sKnM0wMZFUweT65O0g7UTGPpVtvnWdcyrO+seArDg5i11pjtfcnHkUNAaxUSQHHtJBV7
         svPauB0TTZFoKJ0Xnw6+m0Pa4cNmLSFU55qn3BX3Rq5C5uBfCJs9NNdCyY0BChBv+tv2
         P66wdp9du/eL2JLzA869zZgcuZ7bbECx8NyfIPy6eHxMh4W7N0He7ZglwJjbt8EGMRxh
         UTgJJ/3h56kZ4wa7GdGhUS3UEAKxOyEHWMcCanEkU59A+zWVHr9KVzgy9AesiguQloLW
         amSw==
X-Gm-Message-State: AOAM533uAyoDlXVrhnVEzZC3ziGYkO0l64HGkaqsVhGAQ9TGb+l6Ujzi
	/6yUaoMU4tNevk7jW9pEFLluzIO955eUjJ/KD3I=
X-Google-Smtp-Source: ABdhPJyidLGlHKw92stdxb/Xnis8ihHW9B4dkmlsKaqH9mJ+ONdpnt5UirfseNlPOOIsggzanR5f/DuOOBVlNBoJYuw=
X-Received: by 2002:ad4:43c8:: with SMTP id o8mr13293377qvs.235.1591973159140;
 Fri, 12 Jun 2020 07:45:59 -0700 (PDT)
MIME-Version: 1.0
From: "Mrs. Anna H. Bruun" <mrs.annahbruun10@gmail.com>
Date: Fri, 12 Jun 2020 16:45:07 +0200
Message-ID: <CA+JgWfkVAdnJTsLOXAjWDmuh1y7DhaG0SFEk9JAbJ2H33aRvGg@mail.gmail.com>
Subject: Hi Dear
To: undisclosed-recipients:;
Message-ID-Hash: 4QUC3O5HUJFLC6UYOMPBCY2K3THHPGRJ
X-Message-ID-Hash: 4QUC3O5HUJFLC6UYOMPBCY2K3THHPGRJ
X-MailFrom: mrsmimiphilip777@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QUC3O5HUJFLC6UYOMPBCY2K3THHPGRJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgRGVhcg0KDQpNeSBOYW1lIGlzIE1ycy4gQW5uYSBILiBCcnV1biwgIGZyb20gTm9yd2F5LiBJ
IGtub3cgdGhhdCB0aGlzIG1lc3NhZ2Ugd2lsbA0KYmUgYSBzdXJwcmlzZSB0byB5b3UuIEZpcnN0
bHksIEkgYW0gbWFycmllZCB0byBNci4gUGF0cmljayBCcnV1biwgQSBnb2xkDQptZXJjaGFudCB3
aG8gb3ducyBhIHNtYWxsIGdvbGQgTWluZSBpbiBCdXJraW5hIEZhc287IEhlIGRpZWQgb2YNCkNh
cmRpb3Zhc2N1bGFyIERpc2Vhc2UgaW4gbWlkLU1hcmNoIDIwMTEuIER1cmluZyBoaXMgbGlmZSB0
aW1lIGhlIGRlcG9zaXRlZA0KdGhlIHN1bSBvZiDigqwgOC41IE1pbGxpb24gRXVybykgRWlnaHQg
bWlsbGlvbiwgRml2ZSBodW5kcmVkIHRob3VzYW5kIEV1cm9zDQppbiBhIGJhbmsgaW4gT3VhZ2Fk
b3Vnb3UgdGhlIGNhcGl0YWwgY2l0eSBvZiBCdXJraW5hIEZhc28gaW4gV2VzdCBBZnJpY2EuDQpU
aGUgZGVwb3NpdGVkIG1vbmV5IHdhcyBmcm9tIHRoZSBzYWxlIG9mIHRoZSBzaGFyZXMsIGRlYXRo
IGJlbmVmaXRzIHBheW1lbnQNCmFuZCBlbnRpdGxlbWVudHMgb2YgbXkgZGVjZWFzZWQgaHVzYmFu
ZCBieSBoaXMgY29tcGFueS4NCg0KSSBhbSBzZW5kaW5nIHRoaXMgbWVzc2FnZSB0byB5b3UgcHJh
eWluZyB0aGF0IGl0IHdpbGwgcmVhY2ggeW91IGluIGdvb2QNCmhlYWx0aCwgc2luY2UgSSBhbSBu
b3QgaW4gZ29vZCBoZWFsdGggY29uZGl0aW9uIGluIHdoaWNoIEkgc2xlZXAgZXZlcnkNCm5pZ2h0
IHdpdGhvdXQga25vd2luZyBpZiBJIG1heSBiZSBhbGl2ZSB0byBzZWUgdGhlIG5leHQgZGF5LiBJ
IGFtIHN1ZmZlcmluZw0KZnJvbSBsb25nIHRpbWUgY2FuY2VyIGFuZCBwcmVzZW50bHkgaSBhbSBw
YXJ0aWFsbHkgc3VmZmVyaW5nIGZyb20gYSBzdHJva2UNCmlsbG5lc3Mgd2hpY2ggaGFzIGJlY29t
ZSBhbG1vc3QgaW1wb3NzaWJsZSBmb3IgbWUgdG8gbW92ZSBhcm91bmQuIEkgYW0NCm1hcnJpZWQg
dG8gbXkgbGF0ZSBodXNiYW5kIGZvciBvdmVyIDQgeWVhcnMgYmVmb3JlIGhlIGRpZWQgYW5kIGlz
DQp1bmZvcnR1bmF0ZWx5IHRoYXQgd2UgZG9uJ3QgaGF2ZSBhIGNoaWxkLCBteSBkb2N0b3IgY29u
ZmlkZWQgaW4gbWUgdGhhdCBpDQpoYXZlIGxlc3MgY2hhbmNlIHRvIGxpdmUuIEhhdmluZyBrbm93
biBteSBoZWFsdGggY29uZGl0aW9uLCBJIGRlY2lkZWQgdG8NCmNvbnRhY3QgeW91IHRvIGNsYWlt
IHRoZSBmdW5kIHNpbmNlIEkgZG9uJ3QgaGF2ZSBhbnkgcmVsYXRpb24gSSBncmV3IHVwDQpmcm9t
IHRoZSBvcnBoYW5hZ2UgaG9tZS4NCg0KSSBoYXZlIGRlY2lkZWQgdG8gZG9uYXRlIHdoYXQgSSBo
YXZlIHRvIHlvdSBmb3IgdGhlIHN1cHBvcnQgb2YgIGhlbHBpbmcNCk1vdGhlcmxlc3MgYmFiaWVz
L0xlc3MgcHJpdmlsZWdlZC9XaWRvd3MnIGJlY2F1c2UgSSBhbSBkeWluZyBhbmQgZGlhZ25vc2Vk
DQpvZiBjYW5jZXIgZm9yIGFib3V0IDIgeWVhcnMgYWdvLiBJIGhhdmUgYmVlbiB0b3VjaGVkIGJ5
IEdvZCBBbG1pZ2h0eSB0bw0KZG9uYXRlIGZyb20gd2hhdCBJIGhhdmUgaW5oZXJpdGVkIGZyb20g
bXkgbGF0ZSBodXNiYW5kIHRvIHlvdSBmb3IgZ29vZCB3b3JrDQpvZiBHb2QgQWxtaWdodHkuIEkg
aGF2ZSBhc2tlZCBBbG1pZ2h0eSBHb2QgdG8gZm9yZ2l2ZSBtZSBhbmQgYmVsaWV2ZSBoZQ0KaGFz
LCBiZWNhdXNlIEhlIGlzIGEgTWVyY2lmdWwgR29kIEkgd2lsbCBiZSBnb2luZyBpbiBmb3IgYW4g
b3BlcmF0aW9uDQpzdXJnZXJ5IHNvb24NCg0KVGhpcyBpcyB0aGUgcmVhc29uIGkgbmVlZCB5b3Vy
IHNlcnZpY2VzIHRvIHN0YW5kIGFzIG15IG5leHQgb2Yga2luIG9yIGFuDQpleGVjdXRvciB0byBj
bGFpbSB0aGUgZnVuZHMgZm9yIGNoYXJpdHkgcHVycG9zZXMuIElmIHRoaXMgbW9uZXkgcmVtYWlu
cw0KdW5jbGFpbWVkIGFmdGVyIG15IGRlYXRoLCB0aGUgYmFuayBleGVjdXRpdmVzIG9yIHRoZSBn
b3Zlcm5tZW50IHdpbGwgdGFrZQ0KdGhlIG1vbmV5IGFzIHVuY2xhaW1lZCBmdW5kIGFuZCBtYXli
ZSB1c2UgaXQgZm9yIHNlbGZpc2ggYW5kIHdvcnRobGVzcw0KdmVudHVyZXMsIEkgbmVlZCBhIHZl
cnkgaG9uZXN0IHBlcnNvbiB3aG8gY2FuIGNsYWltIHRoaXMgbW9uZXkgYW5kIHVzZSBpdA0KZm9y
IENoYXJpdHkgd29ya3MsIGZvciBvcnBoYW5hZ2VzLCB3aWRvd3MgYW5kIGFsc28gYnVpbGQgc2No
b29scyBmb3IgbGVzcw0KcHJpdmlsZWdlIHRoYXQgd2lsbCBiZSBuYW1lZCBhZnRlciBteSBsYXRl
IGh1c2JhbmQgYW5kIG15IG5hbWU7IEkgbmVlZCB5b3VyDQp1cmdlbnQgYW5zd2VyIHRvIGtub3cg
aWYgeW91IHdpbGwgYmUgYWJsZSB0byBleGVjdXRlIHRoaXMgcHJvamVjdCwgYW5kIEkNCndpbGwg
Z2l2ZSB5b3UgbW9yZSBpbmZvcm1hdGlvbiBvbiBob3cgdGhlIGZ1bmQgd2lsbCBiZSB0cmFuc2Zl
cnJlZCB0byB5b3VyDQpiYW5rIGFjY291bnQuDQoNCg0KVGhhbmtzDQpNcnMuIEFubmEgSC4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
