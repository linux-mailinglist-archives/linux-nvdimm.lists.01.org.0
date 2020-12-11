Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2D2D6D22
	for <lists+linux-nvdimm@lfdr.de>; Fri, 11 Dec 2020 02:16:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 947CC100EB333;
	Thu, 10 Dec 2020 17:16:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f4f; helo=mail-qv1-xf4f.google.com; envelope-from=3emjsxxajdfkdij1e85c5e12ille7d19c.3fdc9elo-em49ddc9jkj.rs.fi7@trix.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf4f.google.com (mail-qv1-xf4f.google.com [IPv6:2607:f8b0:4864:20::f4f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 988C5100EB333
	for <linux-nvdimm@lists.01.org>; Thu, 10 Dec 2020 17:16:43 -0800 (PST)
Received: by mail-qv1-xf4f.google.com with SMTP id i20so5139874qvk.18
        for <linux-nvdimm@lists.01.org>; Thu, 10 Dec 2020 17:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:message-id:date:subject:from:to;
        bh=6pHkVDEAfQJNEIJkoFTmL3ygeiQ2N27uSPqCsv8HC0s=;
        b=gVgCgpjArpeYLLIJYOMKvD1bnO/pw6oWbiK4jdbFKOCBjRGWpvgttnMjvhbFdYTaLM
         UwxA1gc+6727pwpKeak+XJbVve22FnFoENW1kPg0GtJApJNFRNj8OQ7rfdgIE6oYJX1k
         7Iz5duXIU4lD8w6JJuUS9/TPVDFzodGuPoO+/PpKyX/5ObwK9c76TatH2leHRR7PS03D
         mFOhLG49PB7J8HG6VvXxTKlbr907jUHatOlZk/Ei+TPXd/WS4Vp3K1HftIxWIciN03dL
         5dqtWrT+lbZBnbCKcROe2/FyANP5ZzBnkl3WcURdUo+32a6VEx/h5o2wZDk3yIoQNMw5
         iDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:message-id:date:subject
         :from:to;
        bh=6pHkVDEAfQJNEIJkoFTmL3ygeiQ2N27uSPqCsv8HC0s=;
        b=tCncjRzIaaB/g5ahqGMveD2c4ilAADGb8PHv5C0mFmhwxAQ7vivRvEJgnfbL6hFiDY
         LnENd26bMbivZsePbRjhdCPPvh3f9wik6y6XNBhXjBMFFy4aR683JbfOeTJnzapo4bi5
         JB4X97p5dQEFWlWQwR/pPLVO1JyYIK4R8KOPhFAGFDnBTaHhvQaNSApS5Jum2BxhdCKY
         IONU5OGBRdGb9JQyfECkhH6QGxLj4jP/NsyrQN1BfRjJt7tQqUfjrBFi7rweHPMxHIhV
         fGZ6t0UVzlC9WyD6Sey7nsSuuQfcmG7BPcY5xJeNo2XsF7dJYWvr8dBYqaHFddTxlGaH
         RR+A==
X-Gm-Message-State: AOAM531+kJsVKkzyY10bESzpcrvZoR/Q9cWyO0IwzAcqqXfUOZMPtgnZ
	IupW+RgmlIz8GBJmmHVsY66FQ1WFmTySrQBOeWp6
MIME-Version: 1.0
X-Received: by 2002:a37:6552:: with SMTP id z79mt13233011qkb.162.1607649400882;
 Thu, 10 Dec 2020 17:16:40 -0800 (PST)
X-No-Auto-Attachment: 1
Message-ID: <000000000000769f4005b6260ba1@google.com>
Date: Fri, 11 Dec 2020 01:16:42 +0000
Subject: My Dearest Friend,
From: mrsanhelenabruun@gmail.com
To: linux-nvdimm@lists.01.org
Message-ID-Hash: 3M5QUH22YMCCZKYGWH7O6E7J3T7CRFXD
X-Message-ID-Hash: 3M5QUH22YMCCZKYGWH7O6E7J3T7CRFXD
X-MailFrom: 3eMjSXxAJDFkDIJ1E85C5E12ILLE7D19C.3FDC9ELO-EM49DDC9JKJ.RS.FI7@trix.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: mrsanhelenabruun@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3M5QUH22YMCCZKYGWH7O6E7J3T7CRFXD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: base64

SSd2ZSBpbnZpdGVkIHlvdSB0byBmaWxsIG91dCB0aGUgZm9sbG93aW5nIGZvcm06DQpVbnRpdGxl
ZCBmb3JtDQoNClRvIGZpbGwgaXQgb3V0LCB2aXNpdDoNCmh0dHBzOi8vZG9jcy5nb29nbGUuY29t
L2Zvcm1zL2QvZS8xRkFJcFFMU2NSZGtCM3VLS2Jkb3J6Y0ZlSXlTUDVvOVNhQ0MwbjQ0WFRJZG9o
Y05Kc0NBcGFFUS92aWV3Zm9ybT92Yz0wJmFtcDtjPTAmYW1wO3c9MSZhbXA7ZmxyPTAmYW1wO3Vz
cD1tYWlsX2Zvcm1fbGluaw0KDQoNCk15IERlYXJlc3QgRnJpZW5kLA0KDQpNeSBOYW1lIGlzIE1y
cy4gQW5uYSBIZWxlbmEgQnJ1dW4sIGZyb20gTm9yd2F5LiBJIGtub3cgdGhhdCB0aGlzIG1lc3Nh
Z2UgIA0Kd2lsbCBiZQ0KDQphIHN1cnByaXNlIHRvIHlvdS4gRmlyc3RseSwgSSBhbSBtYXJyaWVk
IHRvIE1yLiBQYXRyaWNrIEJydWluLCBBIGdvbGQgIA0KbWVyY2hhbnQNCg0Kd2hvIG93bnMgYSBz
bWFsbCBnb2xkIE1pbmUgaW4gU3lyaWE7IEhlIGRpZWQgb2YgQ2FyZGlvdmFzY3VsYXIgRGlzZWFz
ZSBpbiAgDQptaWQtDQoNCk1hcmNoIDIwMTEuIER1cmluZyBoaXMgbGlmZSB0aW1lIGhlIGRlcG9z
aXRlZCB0aGUgc3VtIG9mIOKCrCA4LjUgTWlsbGlvbiBFdXJvKQ0KDQpFaWdodCBtaWxsaW9uLCBG
aXZlIGh1bmRyZWQgdGhvdXNhbmQgRXVyb3MgaW4gYSBiYW5rIGluIE91YWdhZG91Z291IHRoZSAg
DQpjYXBpdGFsDQoNCmNpdHkgb2YgQnVya2luYSBGYXNvIGluIFdlc3QgQWZyaWNhLiBUaGUgZGVw
b3NpdGVkIG1vbmV5IHdhcyBmcm9tIHRoZSBzYWxlICANCm9mDQoNCnRoZSBzaGFyZXMsIGRlYXRo
IGJlbmVmaXRzIHBheW1lbnQgYW5kIGVudGl0bGVtZW50cyBvZiBteSBkZWNlYXNlZCBodXNiYW5k
ICANCmJ5DQoNCmhpcyBjb21wYW55Lg0KDQpJIGFtIHNlbmRpbmcgdGhpcyBtZXNzYWdlIHRvIHlv
dSBwcmF5aW5nIHRoYXQgaXQgd2lsbCByZWFjaCB5b3UgaW4gZ29vZCAgDQpoZWFsdGgsDQoNCnNp
bmNlIEkgYW0gbm90IGluIGdvb2QgaGVhbHRoIGNvbmRpdGlvbiBpbiB3aGljaCBJIHNsZWVwIGV2
ZXJ5IG5pZ2h0IHdpdGhvdXQNCg0Ka25vd2luZyBpZiBJIG1heSBiZSBhbGl2ZSB0byBzZWUgdGhl
IG5leHQgZGF5LiBJIGFtIHN1ZmZlcmluZyBmcm9tIGxvbmcgdGltZQ0KDQpjYW5jZXIgYW5kIHBy
ZXNlbnRseSBpIGFtIHBhcnRpYWxseSBzdWZmZXJpbmcgZnJvbSBhIHN0cm9rZSBpbGxuZXNzIHdo
aWNoICANCmhhcw0KDQpiZWNvbWUgYWxtb3N0IGltcG9zc2libGUgZm9yIG1lIHRvIG1vdmUgYXJv
dW5kLiBJIGFtIG1hcnJpZWQgdG8gbXkgbGF0ZSAgDQpodXNiYW5kDQoNCmZvciBvdmVyIDQgeWVh
cnMgYmVmb3JlIGhlIGRpZWQgYW5kIGlzIHVuZm9ydHVuYXRlbHkgdGhhdCB3ZSBkb24mIzM5O3Qg
aGF2ZSAgDQphIGNoaWxkLA0KDQpteSBkb2N0b3IgY29uZmlkZWQgaW4gbWUgdGhhdCBpIGhhdmUg
bGVzcyBjaGFuY2UgdG8gbGl2ZS4gSGF2aW5nIGtub3duIG15ICANCmhlYWx0aA0KDQpjb25kaXRp
b24sIEkgZGVjaWRlZCB0byBjb250YWN0IHlvdSB0byBjbGFpbSB0aGUgZnVuZCBzaW5jZSBJIGRv
biYjMzk7dCAgDQpoYXZlIGFueQ0KDQpyZWxhdGlvbiwgSSBncmV3IHVwIGZyb20gdGhlIG9ycGhh
bmFnZSBob21lLA0KDQpJIGhhdmUgZGVjaWRlZCB0byBkb25hdGUgd2hhdCBJIGhhdmUgdG8geW91
IGZvciB0aGUgc3VwcG9ydCBvZiBoZWxwaW5nDQoNCk1vdGhlcmxlc3MgYmFiaWVzL0xlc3MgcHJp
dmlsZWdlZC9XaWRvd3MmIzM5OyBiZWNhdXNlIEkgYW0gZHlpbmcgYW5kICANCmRpYWdub3NlZCBv
Zg0KDQpjYW5jZXIgZm9yIGFib3V0IDIgeWVhcnMgYWdvLiBJIGhhdmUgYmVlbiB0b3VjaGVkIGJ5
IEdvZCBBbG1pZ2h0eSB0byBkb25hdGUgIA0KZnJvbQ0KDQp3aGF0IEkgaGF2ZSBpbmhlcml0ZWQg
ZnJvbSBteSBsYXRlIGh1c2JhbmQgdG8geW91IGZvciBnb29kIHdvcmsgb2YgR29kICANCkFsbWln
aHR5Lg0KDQpJIGhhdmUgYXNrZWQgQWxtaWdodHkgR29kIHRvIGZvcmdpdmUgbWUgYW5kIGJlbGll
dmUgaGUgaGFzLCBiZWNhdXNlIEhlIGlzIGENCg0KTWVyY2lmdWwgR29kLCBJIHdpbGwgYmUgZ29p
bmcgaW4gZm9yIGFuIG9wZXJhdGlvbiBzdXJnZXJ5IHNvb24NCg0KVGhpcyBpcyB0aGUgcmVhc29u
IGkgbmVlZCB5b3VyIHNlcnZpY2VzIHRvIHN0YW5kIGFzIG15IG5leHQgb2Yga2luIG9yIGFuDQoN
CmV4ZWN1dG9yIHRvIGNsYWltIHRoZSBmdW5kcyBmb3IgY2hhcml0eSBwdXJwb3Nlcy4gSWYgdGhp
cyBtb25leSByZW1haW5zDQoNCnVuY2xhaW1lZCBhZnRlciBteSBkZWF0aCwgdGhlIGJhbmsgZXhl
Y3V0aXZlcyBvciB0aGUgZ292ZXJubWVudCB3aWxsIHRha2UgIA0KdGhlDQoNCm1vbmV5IGFzIHVu
Y2xhaW1lZCBmdW5kIGFuZCBtYXliZSB1c2UgaXQgZm9yIHNlbGZpc2ggYW5kIHdvcnRobGVzcyAg
DQp2ZW50dXJlcywgSQ0KDQpuZWVkIGEgdmVyeSBob25lc3QgcGVyc29uIHdobyBjYW4gY2xhaW0g
dGhpcyBtb25leSBhbmQgdXNlIGl0IGZvciBDaGFyaXR5ICANCndvcmtzLA0KDQpmb3Igb3JwaGFu
YWdlcywgd2lkb3dzIGFuZCBhbHNvIGJ1aWxkIHNjaG9vbHMgZm9yIGxlc3MgcHJpdmlsZWdlIHRo
YXQgd2lsbCAgDQpiZQ0KDQpuYW1lZCBhZnRlciBteSBsYXRlIGh1c2JhbmQgYW5kIG15IG5hbWU7
IEkgbmVlZCB5b3VyIHVyZ2VudCBhbnN3ZXIgdG8ga25vdyAgDQppZg0KDQp5b3Ugd2lsbCBiZSBh
YmxlIHRvIGV4ZWN1dGUgdGhpcyBwcm9qZWN0LCBhbmQgSSB3aWxsIGdpdmUgeW91IG1vcmUgIA0K
aW5mb3JtYXRpb24NCg0Kb24gaG93IHRoZSBmdW5kIHdpbGwgYmUgdHJhbnNmZXJyZWQgdG8geW91
ciBiYW5rIGFjY291bnQgLiBJIGFtIHdhaXRpbmcgZm9yICANCnlvdXINCg0KdXJnZW50IHJlc3Bv
bmQgdmlhIG15IHByaXZhdGUgRW1haWwgQWRkcmVzczogW21yc2FubmFoZWxlbmFicnV1bkBnbWFp
bC5jb21dDQoNClRoYW5rcw0KDQpUaGFua3MsDQpNcnMuIEFubmEgSGVsZW5hIEJydXVuDQoNCg0K
R29vZ2xlIEZvcm1zOiBDcmVhdGUgYW5kIGFuYWx5emUgc3VydmV5cy4NCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxp
c3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
