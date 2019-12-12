Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4961411D30C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:03:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E007E10113664;
	Thu, 12 Dec 2019 09:07:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f41; helo=mail-qv1-xf41.google.com; envelope-from=brho@google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 17E7D10113662
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:07:02 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id b18so1225242qvo.8
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BFu2QWawMDo8B85b8x7NXC6lIZ2Hbdt7KAZDH/cd0Mw=;
        b=uJQ81efnMOHOq6dmsBK8drxQnWrVDOdv8wGOOqXsdXxN7MhmstzRl6qMKoIgIuASAY
         lEMPd/dfy/crfpO/6N/VYadcmKGFrnXX4+mmXiFkiUzG5PU/Xej146ZJHj/dEykZgxvy
         O+736S4rCVpZL8qO9PDMpS7ySgMAdKBw9pj7/tzKtk7CI7RTtduMaLcqZk07DY8+moZF
         bhUxoQO5G3JypRZzuwZiBUVL1eXd8sas3jVkAS5Wsw+g0QVTow0WeUF7SMo0GvEb1yGN
         kTpPj0oqoIC97Z/MBaZkh6bNy1JKFpcUqpZ4ZUFKziv0r5L1pZe+Jr9MM94NAGfLXcIO
         wA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFu2QWawMDo8B85b8x7NXC6lIZ2Hbdt7KAZDH/cd0Mw=;
        b=hU/fkKITk3XB2XgRpG/JlIf3cr3SzzSgmhZgv4RFaub27NfDX6M7ScaufFKnOU9NaN
         W3kHEEre4kOqNcur7ww6+kPDjPwXT8OgT1jFE0SBXqvdP4QdeUojFI8e3MisJYVagwyb
         vK18t5jZnPHYNO25ecQrn+T6uWrJst26tL6hldjpy3hBD9ldcj1nCpC0ntigY/ZLSnrX
         zFVibLBLe/TiTJaYJhon2kX4zk4sBIWqubkYN9SM/8AtOoD0ajMLSd+9ItsuQanXZ0gh
         OWtB1hoW+9vElfZj7roeM8xAmu4IoAlY/LLR89jXoar1oTiqi28ptH0N6AJbu8/TPCNt
         7BhQ==
X-Gm-Message-State: APjAAAXPvDjAzhQsYVAt8/Rfjxnsm6x2O0et8PQ/Uz4tGmjda6gZpGNr
	wgJ3ClUq1kJLzR3KntSZT2D1fA==
X-Google-Smtp-Source: APXvYqyixXbMscj+Nh5/8lf0UVe2+f6RVkD6z054yrZ1R+8RY56Ujz8IweJ8MUL8w3BnzkuS2BNpnA==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr9025509qvb.242.1576170219393;
        Thu, 12 Dec 2019 09:03:39 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id b7sm1906173qkh.106.2019.12.12.09.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:03:38 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Liran Alon <liran.alon@oracle.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
From: Barret Rhoden <brho@google.com>
Message-ID: <ce8fa354-4530-2a01-6ccc-3cffd0692547@google.com>
Date: Thu, 12 Dec 2019 12:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
Content-Language: en-GB
Message-ID-Hash: YZSJZHMFNHVOE5YP7NDMOAAIDB7Q5U56
X-Message-ID-Hash: YZSJZHMFNHVOE5YP7NDMOAAIDB7Q5U56
X-MailFrom: brho@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YZSJZHMFNHVOE5YP7NDMOAAIDB7Q5U56/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTIvMTIvMTkgNzozMyBBTSwgTGlyYW4gQWxvbiB3cm90ZToNCj4+ICsJLyoNCj4+ICsJICog
T3VyIGNhbGxlciBncmFiYmVkIHRoZSBLVk0gbW11X2xvY2sgd2l0aCBhIHN1Y2Nlc3NmdWwNCj4+
ICsJICogbW11X25vdGlmaWVyX3JldHJ5LCBzbyB3ZSdyZSBzYWZlIHRvIHdhbGsgdGhlIHBhZ2Ug
dGFibGUuDQo+PiArCSAqLw0KPj4gKwlzd2l0Y2ggKGRldl9wYWdlbWFwX21hcHBpbmdfc2hpZnQo
aHZhLCBjdXJyZW50LT5tbSkpIHsNCj4gRG9lc27igJl0IGRldl9wYWdlbWFwX21hcHBpbmdfc2hp
ZnQoKSBnZXQg4oCcc3RydWN0IHBhZ2XigJ0gYXMgZmlyc3QgcGFyYW1ldGVyPw0KPiBXYXMgdGhp
cyBjaGFuZ2VkIGJ5IGEgY29tbWl0IEkgbWlzc2VkPw0KDQpJIGNoYW5nZWQgdGhpcyBpbiBQYXRj
aCAxLiAgVGhlIHBsYWNlIEkgY2FsbCBpdCBpbiBLVk0gaGFzIHRoZSBhZGRyZXNzIA0KYW5kIG1t
IGF2YWlsYWJsZSwgd2hpY2ggaXMgdGhlIG9ubHkgdGhpbmsgZGV2X3BhZ2VtYXBfbWFwcGluZ19z
aGlmdCgpIA0KcmVhbGx5IG5lZWRzLiAgKFRoZSBmaXJzdCB0aGluZyBpdCBkaWQgd2FzIGNvbnZl
cnQgcGFnZSB0byBhZGRyZXNzKS4NCg0KSSdsbCBhZGQgc29tZSBtb3JlIHRleHQgdG8gcGF0Y2gg
MSdzIGNvbW1pdCBtZXNzYWdlIGFib3V0IHRoYXQuDQoNClRoYW5rcywNCg0KQmFycmV0DQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
