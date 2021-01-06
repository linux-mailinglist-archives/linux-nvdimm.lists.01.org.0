Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4662EC677
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Jan 2021 00:00:04 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A069100EB35C;
	Wed,  6 Jan 2021 15:00:02 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b45; helo=mail-yb1-xb45.google.com; envelope-from=35ud2xxijdeyuz0mtq7ijm1pitzqkpouiqt.kwutqv25-v3lquutq010.89.wzo@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb45.google.com (mail-yb1-xb45.google.com [IPv6:2607:f8b0:4864:20::b45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 33A1C100EB35C
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 14:59:52 -0800 (PST)
Received: by mail-yb1-xb45.google.com with SMTP id h75so6543527ybg.18
        for <linux-nvdimm@lists.01.org>; Wed, 06 Jan 2021 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=OtU3bB7/uDBaEl1co75agzxgDwVlYXhTzovLnk7y1OE=;
        b=ADF1Lhw7o1qLvJdTs4Lm15K4/pQT05lQeAPpcB5RgRWZLpQmNPoNhJkthgBIyFUzY3
         UjqhTfCcRYJ/9nD3thYaWZz4/ichYObT0Mfvisp9KhTkad6+udBui1lGFD+h4oVhvbiv
         0H/EEtfTZfR2NlDrOox7FGdbsXQ/bxXnN6z41I0tpu4wlbEbxfskIwul2MwE242KUjnr
         /VthetnZ/feEluB+f3lL2Aq7LHPSG8V4Rwa/BSL8gEbOp/jXsXDg36YeaP0xXJwhzML1
         2pYBvF8zyV6JGGkC8S660BOufu3GOWwZPSWSe77SVtfhinAaoRmvb3F9mK/4ya2Vl5gx
         OYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=OtU3bB7/uDBaEl1co75agzxgDwVlYXhTzovLnk7y1OE=;
        b=WNeaGedb2Kpok3zS3OvJCP9lczcwCldjheb05Fvt6dZVhWljQdGXFCRyNicIIOW/U9
         QfguFijimBlw5JBVfz1GggoNYziIidsC0vEM2cg2UmqJvqHfKMSBTfOKEdQexuDOtctD
         MznME48F7Vsjrn0dOF+xmNDBUgilY9oXTZQF5p7+Hi9gV85pU6sKOZecbxA9GFiiFgd3
         j+epj8hFUShapUp1YLRe2z1+iEiejeKIuhX5hcP13tDhGiUJ8XCxagOiwrUMTCJyXay4
         BJwMA6P74+LYR0t+6I/2prDBVzo+bFdhifBm0mjbuM7d1nsOaQ5WRaBLvvQbeKZZpJiz
         dphQ==
X-Gm-Message-State: AOAM530TGi+SGjYKQBH75MKG69C/ZOze0INqXslxKh+uxKl8fbRZ81XL
	gQjqNDTTXyxkXsBgOcdcjiQmZWiXYP5LwJdjOTff
MIME-Version: 1.0
X-Received: by 2002:a25:d802:: with SMTP id p2mt9668677ybg.305.1609973989807;
 Wed, 06 Jan 2021 14:59:49 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <000000000000c2b1b605b8434707@google.com>
Date: Wed, 06 Jan 2021 22:59:51 +0000
Subject: Untitled form
From: mrselizabethalrich@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: HC4ZZHESM4U2QP242QKQELQCO3AYRR66
X-Message-ID-Hash: HC4ZZHESM4U2QP242QKQELQCO3AYRR66
X-MailFrom: 35UD2XxIJDEYuz0mtq7ijm1pitzqkpouiqt.kwutqv25-v3lquutq010.89.wzo@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrselizabethalrich@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HC4ZZHESM4U2QP242QKQELQCO3AYRR66/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: base64

SSd2ZSBpbnZpdGVkIHlvdSB0byBmaWxsIG91dCB0aGUgZm9sbG93aW5nIGZvcm06DQpVbnRpdGxl
ZCBmb3JtDQoNClRvIGZpbGwgaXQgb3V0LCB2aXNpdDoNCmh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L2Zvcm1zL2QvZS8xRkFJcFFMU2VNLS1mYW9tRm1EdkNvY3RyZC1fNkFZSnBjLTJRVWp4VHdxcGl0
YXc4c1FHY29Zdy92aWV3Zm9ybT92Yz0wJmFtcDtjPTAmYW1wO3c9MSZhbXA7ZmxyPTAmYW1wO3Vz
cD1tYWlsX2Zvcm1fbGluaw0KDQpHcmVldGluZ3MNCkdvb2QgRGF5IERlYXJlc3QsDQoNCkkgcHJh
eSB0aGlzIG1haWwgZmluZHMgeW91IGluIGEgc3RhdGUgb2YgeW91ciBzb3VuZCBoZWFsdGggYW5k
IGluZG9taXRhYmxlICANCnNwaXJpdC4gUGxlYXNlLCBJIHdvdWxkIGxpa2UgdG8gY29uZmlkZSBp
biB5b3UgZm9yIHlvdXIgaG9uZXN0eSBhbmQgdHJ1dGggIA0KZm9yIHByb2dyZXNzLiBJIGZlZWwg
cXVpdGUgc2FmZSBkZWFsaW5nIHdpdGggeW91IGluIHRoaXMgaW1wb3J0YW50IGJ1c2luZXNzLg0K
DQpMZXQgbWUgaW50cm9kdWNlIG15c2VsZiB0byB5b3UsIEkgYW0gTXJzLiBBbGljZSBGcmVlbWFu
LCA0MCB5ZWFycyBwZXJpb2Qgb2YgIA0KbWFycmlhZ2UgbGlmZSwgd2UgY291bGQgbm90IHByb2R1
Y2UgYW55IGNoaWxkLCBteSBsYXRlIGh1c2JhbmQgd2FzIHZlcnkgIA0Kd2VhbHRoeSBhbmQgYWZ0
ZXIgaGlzIGRlYXRoLCBJIGluaGVyaXRlZCBzb21lIHBhcnQgb2YgaGlzIGJ1c2luZXNzIGFuZCAg
DQptb25leSBpbiB0aGUgYmFuay4gVGhlIGRvY3RvciBoYXMgYWR2aXNlZCBtZSB0aGF0IEkNCm1h
eSBub3QgbGl2ZSBmb3IgbW9yZSB0aGFuIHRocmVlIG1vbnRocyBhbmQgMiB3ZWVrcyBhbmQgd2Fy
biBtZSB0byBzdG9wICANCmZyb20gdGhpbmtpbmcgb3ZlciB3aG8gaXMgZ29pbmcgdG8gaW5oZXJp
dCBtZSBhbmQgdGhlIHdlYWx0aC4NCg0KQmFzZWQgb24gdGhhdCwgdG9kYXkgSSBoYXZlIGRlY2lk
ZWQgdG8gZG9uYXRlIGFuZCBjb250cmlidXRlIHRvIHRoZSBsZXNzICANCnByaXZpbGVnZXMsIGNo
YXJpdHkgaG9tZXMsIGFuZCBvcnBoYW5hZ2UgaG9tZXMgYW5kIHRvIHRob3NlIGRpc3BsYWNlZCBi
eSAgDQp3YXJzIGdvaW5nIG9uIGluIHRoZSBtaWRkbGUtZWFzdCBhbmQgYXJvdW5kIHRoZSB3b3Js
ZC4NCg0KSSBjaG9vc2UgeW91IGFmdGVyIG1hbnkgcHJheWVycyBhcyBJJiMzOTttIGRldm90ZWQg
Q2hyaXN0aWFuIGFuZCBhbHdheXMgIA0KZG9pbmcgdGhlIHJpZ2h0IHRoaW5nIGFzIEkgaGF2ZSB0
aGUgY29uZmlkZW50IGluIHlvdSBiZWNhdXNlIEkgaGF2ZSBwcmF5ZWQuICANCkkgYW0gd2lsbGlu
ZyB0byBkb25hdGUgdGhlIHN1bSBvZiAkMjAuNW1pbGxpb24gVS5TIGRvbGxhcnMsIHRvIHRoZSBs
ZXNzICANCnByaXZpbGVnZWQgb2Ygd2hpY2ggeW91IHdpbGwgYmUgcmVzcG9uc2libGUgaW4gdGFr
aW5nIGNhcmUgb2YgdGhlICANCmRpc2J1cnNlbWVudCBhbmQgc2hhcmluZyBvZiB0aGlzIG1vbmV5
IHRvIG9yZ2FuaXphdGlvbnMgdGhhdCBJIHdpbGwgIA0KYXBwb2ludC4gTWVhbndoaWxlLCB5b3Ug
d2lsbCBhbHNvIGdldCAzMCUgb2YgdGhlIG1vbmV5IHdoaWNoIHdpbGwgYmU7IHNpeCAgDQptaWxs
aW9uIGFuZCBvbmUgaHVuZHJlZCB0aG91c2FuZCBkb2xsYXJzICgkNiwxNTAsMDAwKSBhcyB5b3Vy
IGNvbXBlbnNhdGlvbiAgDQpmb3IgaGVscGluZyBtZSBmdWxmaWwgdGhpcyBkZXNpcmUgb2YgZG9u
YXRpb24uDQoNClBsZWFzZSBJIHdhbnQgeW91IHRvIG5vdGUgdGhhdCB0aGlzIGZ1bmQgaXMgc3Rp
bGwgd2l0aCBvbmUgb2YgdGhlIGtub3duICANCnNlY3VyaXR5IGNvbXBhbnkgd2hlcmUgbXkgbGF0
ZSBodXNiYW5kIGRlcG9zaXRlZCBpdC4gSSBhbSBnb2luZyB0byBhZHZpY2UgIA0KbXkgbGF3eWVy
IHRvIGNoYW5nZSBteSBsYXN0IHdpbGwgdG8geW91ciBuYW1lIGFuZCBmaWxlIGluIGFuIGFwcGxp
Y2F0aW9uICANCmZvciB0aGUgdHJhbnNmZXIgb2YgdGhlIG1vbmV5IGluIHlvdXIgbmFtZS4gTGFz
dGx5LCBJDQpob25lc3RseSBwcmF5IHRoYXQgdGhpcyBtb25leSB3aGVuIHRyYW5zZmVycmVkIHRv
IHlvdXIgYWNjb3VudCB3aWxsIGJlIHVzZWQgIA0KZm9yIHRoZSBzYWlkIHB1cnBvc2UgZXZlbiB0
aG91Z2ggSSBhbSBsYXRlIHRoZW4gb3IgYWxpdmUsIGJlY2F1c2UgSSBoYXZlICANCmNvbWUgdG8g
ZmluZCBvdXQgdGhhdCB3ZWFsdGggYWNxdWlzaXRpb24gaXMgbm90IGFsd2F5cyB0aGUgZmluYWwg
dGhpbmcgaW4gIA0KbGlmZSBvciBkZWF0aCBpZiB5b3UgZG8gbm90IGhlbHAgcGVvcGxlIGFzIHdl
bGwgd2hlbg0KdGhleSBuZWVkIGl0Lg0KDQpQbGVhc2UgYmVhciBpdCBpbiBtaW5kIHRoYXQgdGhh
dCBhbGwgdGhlIG1vbmV5IHdpbGwgcmlnaHRmdWxseSBiZWxvbmcgdG8gIA0KeW91ciBuYW1lIGFz
IHF1aWNrbHkgYXMgSSBnZXQgeW91ciByZXBseSwgYW5kIEkgbWFkZSB0aGUgcHJvbWlzZSB0byBn
b2QgIA0KdGhhdCB0aGUgZnVuZCB3aWxsIGJlIHVzZWQgdG8gaGVscCB0aGUgbmVlZHkgYW5kIHRo
ZSBsZXNzIHByaXZpbGVnZS4NCg0KTWF5IHRoZSBncmFjZSBvZiBvdXIgbG9yZCB0aGUgbG92ZSBv
ZiBnb2QgYW5kIHRoZSBmZWxsb3dzaGlwIG9mIGdvZCBiZSB3aXRoICANCnlvdSBhbmQgeW91ciBm
YW1pbHksIHBsZWFzZSBmdXJ0aGVyIGRpc2N1c3Npb24gY29udGFjdCBtZSB3aXRoIG15IGVtYWls
ICANCmFkZHJlc3M6IHJlcGx5IG1lIHRocm91Z2ggdGhpcyBlbWFpbDogYWxpY2VmcmVlbWFuMjY4
QGdtYWlsLmNvbQ0KDQpJIGF3YWl0IGtpbmQgcmVzcG9uc2Ugd2l0aCBhbGwgeW91ciBjb250YWN0
IGluZm9ybWF0aW9u4oCZcw0KDQpNeSByZWdhcmRzIHRvIHlvdXIgZmFtaWx5Lg0KDQpSZW1haW4g
Qmxlc3NlZCwNCk1ycy4gQWxpY2UgRnJlZW1hbjogKGFsaWNlZnJlZW1hbjI2OEBnbWFpbC5jb20p
DQoNCg0KR29vZ2xlIEZvcm1zOiBDcmVhdGUgYW5kIGFuYWx5emUgc3VydmV5cy4NCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
