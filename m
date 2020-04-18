Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467C1AF4EE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 22:30:14 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B46E810FC62F0;
	Sat, 18 Apr 2020 13:30:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com; envelope-from=luto@amacapital.net; receiver=<UNKNOWN> 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 658D110FC62ED
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 13:30:17 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so2993357pgc.10
        for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=jJqY9/SR/ad4P7H9qcJcsY9QD5wxC36npZ2vqT03CEs=;
        b=svfRl6JAzcnVOj/h2FflauvL4dvBhAOealAKFUZRMj0RxUVjkwmdFr0X1PPek2F6kR
         s2J+GFL4YWwoEDdJsWo99CwCtjStNv4D6mrX4DbsLVaRMcwndMkV8Z1mTqDCpkF3lfjc
         maBOzwRRO41B/IkGA1GnOfIdJ3HgQumUcPogYxuvu1MkWytQl33wsHglpXd9WFrdSv++
         Ev+4YGBX2TJqHki59IW1oNt8Lk8Wodn3R+ZZUoUfTzJUnRVPWWk3AmS48/17pagt9YWK
         3OQmgs8k/lc66S3BzA6ZRDVnBGxQ3QclKCMEi4wfeO/kSdkZVM9kxtsbc4TzmKqwFYKU
         IrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=jJqY9/SR/ad4P7H9qcJcsY9QD5wxC36npZ2vqT03CEs=;
        b=RSduaf2SVV5z5SFRk+4yFKy9HVPcbOwl8MzANTEEQXMl6Vjyw6VNfk8BqMvHbiGzmI
         tcKALy9xwUJ4lWZrYBM1/xGkY/iRv2FdsObxfpCjPQ1cdYVsMWX4pZ8RQqZNeOjEsKx4
         shwvlM1G5G/FJvS1cnRwLfz77NDWRpuwfwwHsOL1lvApWNi8+q2kMLWsMDj5P5Vi59SV
         SwXf6ZbCUKlxsuf1Y1AU2Siyo8cBRYx2U2Fpp8dY1s3+M4OFz6X23wfJ33mLrI56ox6h
         a/YTIffk6nKGNLk8sh+71UgujiuRfDYAjN84YTz7kHKJY8GPMT/gkSW9rNdY6x2wCQDx
         i0dg==
X-Gm-Message-State: AGi0PuZGVfpKdh4thExbYZJ5SR55OMFUEYNqIVGNyROMoIuOS4uJIq3l
	VpLfEp1+dUAHfVMXcVoEPMTf7A==
X-Google-Smtp-Source: APiQypLcRDF82+gi/uSEl48kZIhOa8/wjmaGeADbXMRVmijfIA5J9MXMJACYqsUjj+dOd+RNBeOpDA==
X-Received: by 2002:a62:62c3:: with SMTP id w186mr9256533pfb.238.1587241808920;
        Sat, 18 Apr 2020 13:30:08 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:e558:74e9:c7af:3ac7? ([2601:646:c200:1ef2:e558:74e9:c7af:3ac7])
        by smtp.gmail.com with ESMTPSA id o15sm8899098pjp.41.2020.04.18.13.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 13:30:07 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Date: Sat, 18 Apr 2020 13:30:05 -0700
Subject: Re: [PATCH] x86/memcpy: Introduce memcpy_mcsafe_fast
Message-Id: <67FF611B-D10E-4BAF-92EE-684C83C9107E@amacapital.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E255)
Message-ID-Hash: ZTESCHFPPUCW6WXAVNB57ZRHS6LLRHHH
X-Message-ID-Hash: ZTESCHFPPUCW6WXAVNB57ZRHS6LLRHHH
X-MailFrom: luto@amacapital.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZTESCHFPPUCW6WXAVNB57ZRHS6LLRHHH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCi0tQW5keQ0KDQo+IE9uIEFwciAxOCwgMjAyMCwgYXQgMTI6NDIgUE0sIExpbnVzIFRvcnZh
bGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+IA0KPj4+IE9uIEZy
aSwgQXByIDE3LCAyMDIwIGF0IDU6MTIgUE0gRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0Bp
bnRlbC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEBAIC0xMDYsMTIgKzEwOCwxMCBAQCBzdGF0aWMg
X19hbHdheXNfaW5saW5lIF9fbXVzdF9jaGVjayB1bnNpZ25lZCBsb25nDQo+Pj4gbWVtY3B5X21j
c2FmZSh2b2lkICpkc3QsIGNvbnN0IHZvaWQgKnNyYywgc2l6ZV90IGNudCkNCj4+PiB7DQo+Pj4g
I2lmZGVmIENPTkZJR19YODZfTUNFDQo+Pj4gLSAgICAgICBpKHN0YXRpY19icmFuY2hfdW5saWtl
bHkoJm1jc2FmZV9rZXkpKQ0KPj4+IC0gICAgICAgICAgICAgICByZXR1cm4gX19tZW1jcHlfbWNz
YWZlKGRzdCwgc3JjLCBjbnQpOw0KPj4+IC0gICAgICAgZWxzZQ0KPj4+ICsgICAgICAgaWYgKHN0
YXRpY19icmFuY2hfdW5saWtlbHkoJm1jc2FmZV9zbG93X2tleSkpDQo+Pj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBtZW1jcHlfbWNzYWZlX3Nsb3coZHN0LCBzcmMsIGNudCk7DQo+Pj4gI2VuZGlm
DQo+Pj4gLSAgICAgICAgICAgICAgIG1lbWNweShkc3QsIHNyYywgY250KTsNCj4+PiAtICAgICAg
IHJldHVybiAwOw0KPj4+ICsgICAgICAgcmV0dXJuIG1lbWNweV9tY3NhZmVfZmFzdChkc3QsIHNy
YywgY250KTsNCj4+PiB9DQo+IA0KPiBJdCBzdHJpa2VzIG1lIHRoYXQgSSBzZWUgbm8gYWR2YW50
YWdlcyB0byBtYWtpbmcgdGhpcyBhbiBpbmxpbmUgZnVuY3Rpb24gYXQgYWxsLg0KPiANCj4gRXZl
biBmb3IgdGhlIGdvb2QgY2FzZSAtIHdoZXJlIGl0IHR1cm5zIGludG8ganVzdCBhIG1lbWNweSBi
ZWNhdXNlIE1DRQ0KPiBpcyBlbnRpcmVseSBkaXNhYmxlZCAtIGl0IGRvZXNuJ3Qgc2VlbSB0byBt
YXR0ZXIuDQo+IA0KPiBUaGUgb25seSBjYXNlIHRoYXQgcmVhbGx5IGhlbHBzIGlzIHdoZW4gdGhl
IG1lbWNweSBjYW4gYmUgdHVybmVkIGludG8NCj4gYSBzaW5nbGUgYWNjZXNzLiBXaGljaCAtIGFu
ZCBJIGNoZWNrZWQgLSBkb2VzIGV4aXN0LCB3aXRoIHBlb3BsZSBkb2luZw0KPiANCj4gICAgICAg
IHIgPSBtZW1jcHlfbWNzYWZlKCZzYl9zZXFfY291bnQsICZzYih3YyktPnNlcV9jb3VudCwgc2l6
ZW9mKHVpbnQ2NF90KSk7DQo+IA0KPiB0byByZWFkIGEgc2luZ2xlIDY0LWJpdCBmaWVsZCB3aGlj
aCBsb29rcyBhbGlnbmVkIHRvIG1lLg0KPiANCj4gQnV0IHRoYXQgY29kZSBpcyBpbmNyZWRpYmxl
IGdhcmJhZ2UgYW55d2F5LCBzaW5jZSBldmVuIG9uIGEgYnJva2VuDQo+IG1hY2hpbmUsIHRoZXJl
J3Mgbm8gYWN0dWFsIHJlYXNvbiB0byB1c2UgdGhlIHNsb3cgdmFyaWFudCBmb3IgdGhhdA0KPiB3
aG9sZSBhY2Nlc3MgdGhhdCBJIGNhbiB0ZWxsLiBUaGUgbWFjcy1zYWZlIGNvcHkgcm91dGluZXMg
ZG8gbm90IGRvDQo+IGFueXRoaW5nIHdvcnRod2hpbGUgZm9yIGEgc2luZ2xlIGFjY2Vzcy4NCg0K
TWF5YmUgSeKAmW0gbWlzc2luZyBzb21ldGhpbmcgb2J2aW91cywgYnV0IHdoYXTigJlzIHRoZSBh
bHRlcm5hdGl2ZT8gIFRoZSBfbWNzYWZlIHZhcmlhbnRzIGRvbuKAmXQganVzdCBhdm9pZCB0aGUg
UkVQIG1lc3Mg4oCUIHRoZXkgYWxzbyB0ZWxsIHRoZSBrZXJuZWwgdGhhdCB0aGlzIHBhcnRpY3Vs
YXIgYWNjZXNzIGlzIHJlY292ZXJhYmxlIHZpYSBleHRhYmxlLiBXaXRoIGEgcmVndWxhciBtZW1v
cnkgYWNjZXNzLCB0aGUgQ1BVIG1heSBub3QgZXhwbG9kZSwgYnV0IGRvX21hY2hpbmVfY2hlY2so
KSB3aWxsLCBhdCB2ZXJ5IGJlc3QsIE9PUFMsIGFuZCBldmVuIHRoYXQgcmVxdWlyZXMgYSBjZXJ0
YWluIGRlZ3JlZSBvZiBvcHRpbWlzbS4gIEEgcGFuaWMgaXMgbW9yZSBsaWtlbHkuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
