Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CB22CC2E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 19:29:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDE1211897B5C;
	Fri, 24 Jul 2020 10:29:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 641B811897B5A
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so5674070pjc.4
        for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 10:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=oCF2bACf0J3wi10Mkevj6a1lx9ZJ2XYqftXol/Y5C3BUVETOi1ThoRhsL2OxKFCyb4
         LGJ3ZE9QuRoT+dYLR9CdhNjE9P+KA1F0J34lD0z4Rjmsdl1uULCFsHQh/kjIrw/3yYIN
         MIxEx6ObahD1W2wfYbyu5J04MgrODyT6hzuLM3mpaqgWNY1btI1HYMmRRqfrG327H9oM
         z5+CURUIEaZafgf40maNhBKcXiwP+sIOTIqvFURURI9WNSOzDt9L7YckftzfASDKb67X
         c6S0yxsINqy7Fs9MCqKwbe5ZznH0YewS4KMFQ8V9Fo2+D3qH4LKoiOb9hjdKp/ooZMns
         71UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xVJb6QB7yJwnn1Z6Ovzuc7SiH2/mFZI/eEetibZkjak=;
        b=UAYNmTzynBpGHBXSsLfoFX6fMrNR1FjvBYz0Ay+ODIqx6P/wjPvpTvdICfUzIOQPvr
         MexOCgta2SNVWmtDY2vdPsjN7SM0cefm1rkCn6Gm1bGbEuHIdehQc2qcLvh/wpUSRbqM
         7Sat5US70aVkSIeGTRU3bo8LrV7Hu7IgawpKLpg9XYhrMQ/cAdZVBsGZqg+/U+mkn1Xm
         l0BO3tDn5Rm9KNf1UydLWzMQcLRja9iJkOrahUDhLLViZOTbLCYPohDCT9g9h2kso1+X
         JbpWx0vv5hlvGGVln4meyqcCyz8318jqa0v4He4RDpzk5llS+bROpF4ezs4AZi4S2Zet
         6i8Q==
X-Gm-Message-State: AOAM530De++u1PxSWJLdToypOZir0m6Smg6DGtw+J3yKgwZh3eWfD0cY
	szRakbekLa/SunDyC6DAKFeqVw==
X-Google-Smtp-Source: ABdhPJxgGZkOO3kQzBrpxCwHwlk1F6DYD0lzx0NwksvJwkCVThBWugwQYsACXzFP/Kw/IrlXRyq2VQ==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr6495292pjq.195.1595611767681;
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:cc1b:c95e:6185:cfc7? ([2601:646:c200:1ef2:cc1b:c95e:6185:cfc7])
        by smtp.gmail.com with ESMTPSA id x66sm6882326pgb.12.2020.07.24.10.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 10:29:27 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
Date: Fri, 24 Jul 2020 10:29:23 -0700
Message-Id: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
X-Mailer: iPhone Mail (17F80)
Message-ID-Hash: OVL6GK7HINCK6EJQFI7H3KCVKGXFNE6N
X-Message-ID-Hash: OVL6GK7HINCK6EJQFI7H3KCVKGXFNE6N
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OVL6GK7HINCK6EJQFI7H3KCVKGXFNE6N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIEp1bCAyNCwgMjAyMCwgYXQgMTA6MjMgQU0sIElyYSBXZWlueSA8aXJhLndlaW55QGlu
dGVsLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUaHUsIEp1bCAyMywgMjAyMCBhdCAxMDoxNTox
N1BNICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+PiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4gd3JpdGVzOg0KPj4gDQo+Pj4gSXJhIFdlaW55IDxpcmEud2VpbnlA
aW50ZWwuY29tPiB3cml0ZXM6DQo+Pj4+IE9uIEZyaSwgSnVsIDE3LCAyMDIwIGF0IDEyOjA2OjEw
UE0gKzAyMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgSnVsIDE3LCAy
MDIwIGF0IDEyOjIwOjU2QU0gLTA3MDAsIGlyYS53ZWlueUBpbnRlbC5jb20gd3JvdGU6DQo+Pj4+
PiBJJ3ZlIGJlZW4gcmVhbGx5IGRpZ2dpbmcgaW50byB0aGlzIHRvZGF5IGFuZCBJJ20gdmVyeSBj
b25jZXJuZWQgdGhhdCBJJ20NCj4+Pj4+IGNvbXBsZXRlbHkgbWlzc2luZyBzb21ldGhpbmcgV1JU
IGlkdGVudHJ5X2VudGVyKCkgYW5kIGlkdGVudHJ5X2V4aXQoKS4NCj4+Pj4+IA0KPj4+Pj4gSSd2
ZSBpbnN0cnVtZW50ZWQgaWR0X3tzYXZlLHJlc3RvcmV9X3BrcnMoKSwgYW5kIF9fZGV2X2FjY2Vz
c197ZW4sZGlzfWFibGUoKQ0KPj4+Pj4gd2l0aCB0cmFjZV9wcmludGsoKSdzLg0KPj4+Pj4gDQo+
Pj4+PiBXaXRoIHRoaXMgZGVidWcgY29kZSwgSSBoYXZlIGZvdW5kIGFuIGluc3RhbmNlIHdoZXJl
IGl0IHNlZW1zIGxpa2UNCj4+Pj4+IGlkdGVudHJ5X2VudGVyKCkgaXMgY2FsbGVkIHdpdGhvdXQg
YSBjb3JyZXNwb25kaW5nIGlkdGVudHJ5X2V4aXQoKS4gIFRoaXMgaGFzDQo+Pj4+PiBsZWZ0IHRo
ZSB0aHJlYWQgcmVmIGNvdW50ZXIgYXQgMCB3aGljaCByZXN1bHRzIGluIHZlcnkgYmFkIHRoaW5n
cyBoYXBwZW5pbmcNCj4+Pj4+IHdoZW4gX19kZXZfYWNjZXNzX2Rpc2FibGUoKSBpcyBjYWxsZWQg
YW5kIHRoZSByZWYgY291bnQgZ29lcyBuZWdhdGl2ZS4NCj4+Pj4+IA0KPj4+Pj4gRWZmZWN0aXZl
bHkgdGhpcyBzZWVtcyB0byBiZSBoYXBwZW5pbmc6DQo+Pj4+PiANCj4+Pj4+IC4uLg0KPj4+Pj4g
ICAgLy8gcmVmID09IDANCj4+Pj4+ICAgIGRldl9hY2Nlc3NfZW5hYmxlKCkgIC8vIHJlZiArPSAx
ID09PiBkaXNhYmxlIHByb3RlY3Rpb24NCj4+Pj4+ICAgICAgICAvLyBleGNlcHRpb24gICh3aGlj
aCBvbmUgSSBkb24ndCBrbm93KQ0KPj4+Pj4gICAgICAgICAgICBpZHRlbnRyeV9lbnRlcigpDQo+
Pj4+PiAgICAgICAgICAgICAgICAvLyByZWYgPSAwDQo+Pj4+PiAgICAgICAgICAgICAgICBfaGFu
ZGxlcigpIC8vIG9yIHdoYXRldmVyIGNvZGUuLi4NCj4+Pj4+ICAgICAgICAgICAgLy8gKl9leGl0
KCkgbm90IGNhbGxlZCBbYXQgbGVhc3QgdGhlcmUgaXMgbm8gdHJhY2VfcHJpbnRrKCkgb3V0cHV0
XS4uLg0KPj4+Pj4gICAgICAgICAgICAvLyBSZWdhcmRsZXNzIG9mIHRyYWNlIG91dHB1dCwgdGhl
IHJlZiBpcyBsZWZ0IGF0IDANCj4+Pj4+ICAgIGRldl9hY2Nlc3NfZGlzYWJsZSgpIC8vIHJlZiAt
PSAxID09PiAtMSA9PT4gZG9lcyBub3QgZW5hYmxlIHByb3RlY3Rpb24NCj4+Pj4+ICAgIChCYWQg
c3R1ZmYgaXMgYm91bmQgdG8gaGFwcGVuIG5vdy4uLikNCj4+PiANCj4+PiBXZWxsLCBpZiBhbnkg
ZXhjZXB0aW9uIHdoaWNoIGNhbGxzIGlkdGVudHJ5X2VudGVyKCkgd291bGQgcmV0dXJuIHdpdGhv
dXQNCj4+PiBnb2luZyB0aHJvdWdoIGlkdGVudHJ5X2V4aXQoKSB0aGVuIGxvdHMgb2YgYmFkIHN0
dWZmIHdvdWxkIGhhcHBlbiBldmVuDQo+Pj4gd2l0aG91dCB5b3VyIHBhdGNoZXMuDQo+Pj4gDQo+
Pj4+IEFsc28gaXMgdGhlcmUgYW55IGNoYW5jZSB0aGF0IHRoZSBwcm9jZXNzIGNvdWxkIGJlIGdl
dHRpbmcgc2NoZWR1bGVkIGFuZCB0aGF0DQo+Pj4+IGlzIGNhdXNpbmcgYW4gaXNzdWU/DQo+Pj4g
DQo+Pj4gT25seSBmcm9tICNQRiwgYnV0IGFmdGVyIHRoZSBmYXVsdCBoYXMgYmVlbiByZXNvbHZl
ZCBhbmQgdGhlIHRhc2tzIGlzDQo+Pj4gc2NoZWR1bGVkIGluIGFnYWluIHRoZW4gdGhlIHRhc2sg
cmV0dXJucyB0aHJvdWdoIGlkdGVudHJ5X2V4aXQoKSB0byB0aGUNCj4+PiBwbGFjZSB3aGVyZSBp
dCB0b29rIHRoZSBmYXVsdC4gVGhhdCdzIG5vdCBndWFyYW50ZWVkIHRvIGJlIG9uIHRoZSBzYW1l
DQo+Pj4gQ1BVLiBJZiBzY2hlZHVsZSBpcyBub3QgYXdhcmUgb2YgdGhlIGZhY3QgdGhhdCB0aGUg
ZXhjZXB0aW9uIHR1cm5lZCBvZmYNCj4+PiBzdHVmZiB0aGVuIHlvdSBzdXJlbHkgZ2V0IGludG8g
dHJvdWJsZS4gU28geW91IHJlYWxseSB3YW50IHRvIHN0b3JlIGl0DQo+Pj4gaW4gdGhlIHRhc2sg
aXRzZWxmIHRoZW4gdGhlIGNvbnRleHQgc3dpdGNoIGNvZGUgY2FuIGFjdHVhbGx5IHNlZSB0aGUN
Cj4+PiBzdGF0ZSBhbmQgYWN0IGFjY29yZGluZ2x5Lg0KPj4gDQo+PiBBY3R1YWxseSB0aGF0cyBu
YXN0eSBhcyB3ZWxsIGFzIHlvdSBuZWVkIGEgc3RhY2sgb2YgUEtSUyB2YWx1ZXMgdG8NCj4+IGhh
bmRsZSBuZXN0ZWQgZXhjZXB0aW9ucy4gQnV0IGl0IG1pZ2h0IGJlIHN0aWxsIHRoZSBtb3N0IHJl
YXNvbmFibGUNCj4+IHRoaW5nIHRvIGRvLiA3IFBLUlMgdmFsdWVzIHBsdXMgYW4gaW5kZXggc2hv
dWxkIGJlIHJlYWxseSBzdWZmaWNpZW50LA0KPj4gdGhhdCdzIDMyYnl0ZXMgdG90YWwsIG5vdCB0
aGF0IGJhZC4NCj4gDQo+IEkndmUgdGhvdWdodCBhYm91dCB0aGlzIGEgYml0IG1vcmUgYW5kIHVu
bGVzcyBJJ20gd3JvbmcgSSB0aGluayB0aGUNCj4gaWR0ZW50cnlfc3RhdGUgcHJvdmlkZXMgZm9y
IHRoYXQgYmVjYXVzZSBlYWNoIG5lc3RlZCBleGNlcHRpb24gaGFzIGl0J3Mgb3duDQo+IGlkdGVu
dHJ5X3N0YXRlIGRvZXNuJ3QgaXQ/DQoNCk9ubHkgdGhlIG9uZXMgdGhhdCB1c2UgaWR0ZW50cnlf
ZW50ZXIoKSBpbnN0ZWFkIG9mLCBzYXksIG5taV9lbnRlcigpLg0KDQo+IA0KPiBJcmEKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1h
aWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNl
bmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
