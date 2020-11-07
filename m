Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CFB2AA416
	for <lists+linux-nvdimm@lfdr.de>; Sat,  7 Nov 2020 10:03:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09693164BF7B0;
	Sat,  7 Nov 2020 01:03:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::745; helo=mail-qk1-x745.google.com; envelope-from=34wkmxw4jdeqjov.gmxktzca88msgor.iusrot03-t1jossroyzy.67.uxm@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x745.google.com (mail-qk1-x745.google.com [IPv6:2607:f8b0:4864:20::745])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE60A1647FFA3
	for <linux-nvdimm@lists.01.org>; Sat,  7 Nov 2020 01:03:32 -0800 (PST)
Received: by mail-qk1-x745.google.com with SMTP id k188so2429584qke.3
        for <linux-nvdimm@lists.01.org>; Sat, 07 Nov 2020 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=ezihhqBndM6x13x5NMhxt87Mgy6pNpSR5ZjznqWYLQU=;
        b=WrTFEmEN9vj5vDO0o/zzwwPVe4MafwzQxGq4lbpGRuVhLamIw/tRpXKbtjbCx3YbIU
         qwlSU1t4/F6yl3QO96ARXJMwFkFg99MMabuFFsD2z8iKXmdvnvV5mBdnqRTxEb7B+u4i
         F7zvprWMLJ1J6Zpu0ulBozaGEL8kS9XKeBMEsCF83Xxs7BJfH1tdS9ds+pRenitkkBU/
         PMWIOoM/bCdwmOjjIwww1DROKANkZ8XiASuzVHktpaq+yEvchK33ZEQpFrlo9wmpHkhs
         hMXOdeJvPkp3eq1d75ZHofMhHriU5cFLrzCHGkzQu+kmFwC4tGQVZ6fzwJBjnTwe11oa
         eFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=ezihhqBndM6x13x5NMhxt87Mgy6pNpSR5ZjznqWYLQU=;
        b=fqm+3yLgx92LIzmKOzrEC8A5hE8kBcT2+ThBKFZ5wQ7f01K9WArdr1PafslEqKWUQy
         slN1veZClhLYbuWB9r9nmFUeU00bN+i14NCMWpreELVALF58pu4hZBzfnw7nBT9QPD/Y
         9KMaasR5yXUGwxvnkLZWFB6izPGEqwRBQzo+Y8ATrXr8tgHi+cLXnOPvporJPquTk8yt
         H4x4LScF4LkjGkKzxiyvVm4ZN+pziLYjKGhLj2RNs/xR527o7K9LUD8busdKU3QD9o6s
         2zH+HjT0tBR+v6tNLYcDvoJuBXrVNeg03rOZb38YdQagfOaFj1mDyu5EVam6VYE7IFKo
         bw/w==
X-Gm-Message-State: AOAM530XVjhn5g1I7ewmrrtS75WyvavQbZS08qHVPKCOGRYTXUC05A+7
	lhlYYyCzFhUv7wC563jvfZxf5QYRuLD31oPaIzEq
MIME-Version: 1.0
X-Received: by 2002:a05:620a:818:: with SMTP id s24mt5221122qks.181.1604739809662;
 Sat, 07 Nov 2020 01:03:29 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <0000000000004ffd4805b3809ab4@google.com>
Date: Sat, 07 Nov 2020 09:03:32 +0000
Subject: U.S. Customs and Border Protection.
From: dip.agrent6422@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: 7DMWGQSYVY2E2566FRCX7MLL4YR26M7X
X-Message-ID-Hash: 7DMWGQSYVY2E2566FRCX7MLL4YR26M7X
X-MailFrom: 34WKmXw4JDEQjov.gmxktzCA88msgor.iusrot03-t1jossroyzy.67.uxm@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: dip.agrent6422@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7DMWGQSYVY2E2566FRCX7MLL4YR26M7X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: base64

SSd2ZSBpbnZpdGVkIHlvdSB0byBmaWxsIG91dCB0aGUgZm9sbG93aW5nIGZvcm06DQpVbnRpdGxl
ZCBmb3JtDQoNClRvIGZpbGwgaXQgb3V0LCB2aXNpdDoNCmh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L2Zvcm1zL2QvZS8xRkFJcFFMU2ZmejltQUl0dlRHWVN5M19XZ21HVnFzb3cwdmJwTjVRRnVqQTk5
TGphbzJYTEk3Zy92aWV3Zm9ybT92Yz0wJmFtcDtjPTAmYW1wO3c9MSZhbXA7ZmxyPTAmYW1wO3Vz
cD1tYWlsX2Zvcm1fbGluaw0KDQpHb29kIG1vcm5pbmcgdG8geW91Lg0KDQpUaGlzIG1lc3NhZ2Ug
aXMgY29taW5nIHRvIHlvdSBmcm9tIFUuUy4gQ3VzdG9tcyBhbmQgQm9yZGVyIFByb3RlY3Rpb24g
LSAgDQpDaGllZiBNb3VudGFpbiBQb3J0IG9mIEVudHJ5LCBUaGUgbWVzc2FnZSBpcyBiZWNhdXNl
IG9mIHlvdXIgcGFja2FnZSBib3ggIA0Kd2hpY2ggd2FzIGp1c3QgcmVsZWFzZWQgYW5kIGNsZWFy
ZWQgYWJvdXQgMzAgbWludXRlcyBhZ2/igKYgd2Ugd2FudCB5b3UgdG8gIA0KY29tZSBkb3duIGhl
cmUgaW4gcGVyc29uIGFuZCB0YWtlIGF3YXkgeW91ciBwYWNrYWdlIHdpdGhvdXQgYW55IHF1ZXN0
aW9uIG9yICANCmRlbGF5IGZyZWVseSAoQWRkcmVzczogMTM5NSBDaGllZiBNb3VudGFpbiBId3ks
IEJhYmIsIE1UIDU5NDExLCBVbml0ZWQgIA0KU3RhdGVzKQ0KYnV0IGlmIGl0IGNhbuKAmXQgYmUg
cG9zc2libGUgZm9yIHlvdSB0byBjb21lIGRvd24gZHVlIHRvIHdvcmtpbmcgaG91ciBqdXN0ICAN
CmdvIGRvd24gdG8gYW55IG5lYXJlc3Qgc3RvcmUgYnV5IHN0ZWFtIGNhcmQgb3Igbm9yZHN0cm9t
IGNhcmQgb2YgJDE5MCBhbmQgIA0Kc2VuZCBpdCB0byB5b3VyIGRlbGl2ZXJ5IGFnZW50IHZpYSBl
IGVtYWlsIChob25vcmFibGVoYXJyaXNvbjJAZ21haWwuY29tKSAgDQpvciBwaG9uZSArMSAoMjE2
KSA0NjUtNTMxNyBpIGV4cGVjdCB5b3VyIHVyZ2VudCBjYWxsIHBsZWFzZSBhbHNvIHByb3ZpZGUg
IA0KeW91ciBhZGRyZXNzIHdoZXJlIHlvdSB3YW50IHlvdXIgcGFja2FnZSBib3ggdG8gYmUgZGVs
aXZlcmVkIHRvICB5b3UgaW4gIA0KbmV4dCA0IGhvdXJzIHlvdSB3aWxsIGNvbmZpcm0geW91ciBw
YWNrYWdlIGltbWVkaWF0ZWx5LCBwbGVhc2UgZG9u4oCZdCBpZ25vcmUgIA0KdGhpcyBtZXNzYWdl
IGJlY2F1c2UgeW91IGFyZSB2ZXJ5IGx1Y2t5IHBlcnNvbiB0b2RheeKApi4uDQoNClUuUy4gQ3Vz
dG9tcyBhbmQgQm9yZGVyIFByb3RlY3Rpb24uDQoNCkdvb2dsZSBGb3JtczogQ3JlYXRlIGFuZCBh
bmFseXplIHN1cnZleXMuDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
