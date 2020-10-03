Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3679128232D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  3 Oct 2020 11:32:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BABF15728194;
	Sat,  3 Oct 2020 02:32:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com; envelope-from=colomar.6.4.3@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E39B515728192
	for <linux-nvdimm@lists.01.org>; Sat,  3 Oct 2020 02:32:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so4338422wrp.8
        for <linux-nvdimm@lists.01.org>; Sat, 03 Oct 2020 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wmkJ9FxHCpTr+iWv6GHurEZpNNofEO+mT2y21utzFUs=;
        b=i1gww9oLCuAl7ps5bghVOHqyGmypLPIhDKuBqotkCvdnqEFRaD36CeVYStIMsJFTUN
         D6OtC9a5Pd3uni6o0V4KWqVjMy4G9aoHk65TQ0a3vqdwc8JJkyW9d2HuLnCONT5/aDfg
         6/s3VQo5bRbDCwgHl10h4opIShPXPwp0jNEqEv/LXoy0m9KLmBLPzE2Ma/7RxYryfpvx
         KDR4E1aW4hiJeLllUYcX3LaBX6pETHnRvDUFo4bDzUh+KpIuRoixv+Md31XOw1sV9Y0U
         jfsAyXPOLfP0gNHv1chHDLJodyRwn8IOgMLUW4LseTUQ8ulmWGY0taiIppcuxmyOrSSX
         QMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wmkJ9FxHCpTr+iWv6GHurEZpNNofEO+mT2y21utzFUs=;
        b=jOsfjv4dmZzYvF8MqODW7ftboXh0jlKNXiLMS6Oe+Y0gU97rSctSQ+cMhhmQxMF3HZ
         6tAesuCocDSyX7W7LTHxpaz/G1CEeDeZODozcwaapLZzvAyXS4J9opJtlJ7uHPYKUMCz
         a9RMsCzNgV4DXEUzydk8mYUcX3oQFw3NxuB3sqeouw+zgCz+fq+H15C55NtUVp7XKfDl
         cthCoQAsFJBDPXVsqYkY5XITOlclgEy5KFLMLC2RRNnXpyHDj93pyddFUptjmhXkhZe6
         270VXt6j54C2sbvjGQ3jMfkJcaNX/6BYsUMPKVhvPq4lqF9wNFGpGdFSVGERXVZn8OMg
         Tz7g==
X-Gm-Message-State: AOAM532pWaPg7sCNFzFBQoaaqOYV9xx7vpxdp/2BjjPo2Pf/GYC1Myd/
	ZgrsZiKF0Tm4u0TwkUJoxaw=
X-Google-Smtp-Source: ABdhPJxF6OsanYU7MGuhJyTy3ufPHyRz/VHEz71PltEzIDMI5xb5/GcsYkMEQc6B2ut+ufvoU3MTDA==
X-Received: by 2002:adf:e391:: with SMTP id e17mr7048859wrm.289.1601717566307;
        Sat, 03 Oct 2020 02:32:46 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.60.68])
        by smtp.gmail.com with ESMTPSA id i14sm4778140wml.24.2020.10.03.02.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Oct 2020 02:32:45 -0700 (PDT)
Subject: Re: [PATCH] man2: new page describing memfd_secret() system call
From: Alejandro Colomar <colomar.6.4.3@gmail.com>
To: rppt@kernel.org, mtk.manpages@gmail.com
References: <20200924133513.1589-1-rppt@kernel.org>
 <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Message-ID: <94cf1b3a-e191-a896-a27d-cd7649cb2c59@gmail.com>
Date: Sat, 3 Oct 2020 11:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <efb6d051-2104-af26-bfb0-995f4716feb2@gmail.com>
Content-Language: en-US
Message-ID-Hash: PUD5577EONTPGZKFVRVIEVYB75RBXQUD
X-Message-ID-Hash: PUD5577EONTPGZKFVRVIEVYB75RBXQUD
X-MailFrom: colomar.6.4.3@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, dave.hansen@linux.intel.com, david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com, jejb@linux.ibm.com, kirill@shutemov.name, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, rppt@linux.ibm.com, shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws, viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PUD5577EONTPGZKFVRVIEVYB75RBXQUD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgTWlrZSBhbmQgTWljaGFlbCwNCg0KUGluZy4gOikNCg0KVGhhbmtzLA0KDQpBbGV4DQoNCk9u
IDIwMjAtMDktMjQgMTY6NTUsIEFsZWphbmRybyBDb2xvbWFyIHdyb3RlOg0KPiAqIE1pa2UgUmFw
b3BvcnQ6DQo+ICA+ICsuUFANCj4gID4gKy5JUiBOb3RlIDoNCj4gID4gK1RoZXJlIGlzIG5vIGds
aWJjIHdyYXBwZXIgZm9yIHRoaXMgc3lzdGVtIGNhbGw7IHNlZSBOT1RFUy4NCj4gDQo+IFlvdSBh
ZGRlZCBhIHJlZmVyZW5jZSB0byBOT1RFUywgYnV0IHRoZW4gaW4gbm90ZXMgdGhlcmUgaXMgbm90
aGluZyBhYm91dCANCj4gaXQuwqAgSSBndWVzcyB5b3Ugd2FudGVkIHRvIGFkZCB0aGUgZm9sbG93
aW5nIHRvIE5PVEVTICh0YWtlbiBmcm9tIA0KPiBtZW1iYXJyaWVyLjIpOg0KPiANCj4gLlBQDQo+
IEdsaWJjIGRvZXMgbm90IHByb3ZpZGUgYSB3cmFwcGVyIGZvciB0aGlzIHN5c3RlbSBjYWxsOyBj
YWxsIGl0IHVzaW5nDQo+IC5CUiBzeXNjYWxsICgyKS4NCj4gDQo+IENoZWVycywNCj4gDQo+IEFs
ZXgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
