Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD07213CC26
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 19:33:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC8B210097DD1;
	Wed, 15 Jan 2020 10:37:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 58E1110097DF5
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1579113233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcmbQXfMS2N+5UdYCC/mTbYJliwkMpDElhWxyN3w7uE=;
	b=KBkP8Gz19WoaDZWrqcdKhVTVBUMG8L/+Tp2rrDKi3oXCwPTJbOpBwniotO8meX63HxIYMw
	j0pM2xDaZtsKQ2rgL/zsvaPd4nX/7psTCnEet3wgg0FN6CuGkPwFYKjY2s956Fh4GCs3Ql
	aNpkYG7YCl3G/yFk74eL/uwKdnIIg3w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-ciXUvHunNOym3b62NMcyCA-1; Wed, 15 Jan 2020 13:33:52 -0500
Received: by mail-wr1-f69.google.com with SMTP id k18so8343974wrw.9
        for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 10:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=va5ZZWbJX4SIzlOtIXmCKn6cD0Cw7eHyuV0gMLwZJ6Y=;
        b=X3CN3kQO4T02uSABlw8y/zJqLvicViuarjhpfTKVY8dhAU3naoHfRXVp9EHnVScN5i
         DH6n8Zw0DHZ79NPB/UU5hHAre+w3ZeJnHAUDYEbuTjYDQRz1C2Nkrv/iklili8xxaP6l
         7TGJo/pGSFX+7p5BOcqaB3W+kHvmLAqJNRPKqxQhtOqx1Mj63KHNrUPtXgkM9b0Y5Pw4
         E3HgArcfH3UP5df995VRnJvK+s7eUo3MeWzicLMFlzTQB2AGVeanMNEUBZfX2x3MV6JW
         F+tMXOXQnf/zX+YSn4hQ32tb/dFxneiyfLfpXcCf0e1LyqrnufvH6zPnZM6XFuU5DWek
         e5CQ==
X-Gm-Message-State: APjAAAXOewt1Eqh2WWGnGRHPjdzuGla9VdwmMy7fGVsNhzZK/UYKuGZ6
	ULIylDez36cPQjLo7GdoBxc6nbOzREBaiHaqhIvkXbKuIUMQzuNprX0sZ7izJV/JQWOOI5ShmKW
	8lq9XwjIkEuCIU9570a+F
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr1330110wma.84.1579113231260;
        Wed, 15 Jan 2020 10:33:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqztcB/kOoiO34HAkrYeLeRQT3xoOdqzZnz5pLsFhD3p5EtSAPbc8H6Dz1r3rQxrhzuHO0RdNQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr1330076wma.84.1579113231023;
        Wed, 15 Jan 2020 10:33:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id c17sm25545608wrr.87.2020.01.15.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:33:50 -0800 (PST)
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
To: Barret Rhoden <brho@google.com>,
 Sean Christopherson <sean.j.christopherson@intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-2-brho@google.com>
 <20191213174702.GB31552@linux.intel.com>
 <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <207bd03c-df82-f27b-bdb8-1aef33429dd7@redhat.com>
Date: Wed, 15 Jan 2020 19:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
Content-Language: en-US
X-MC-Unique: ciXUvHunNOym3b62NMcyCA-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: ZI6AJSVGLZWJAGMGNGLWM7BHQEWICWHA
X-Message-ID-Hash: ZI6AJSVGLZWJAGMGNGLWM7BHQEWICWHA
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZI6AJSVGLZWJAGMGNGLWM7BHQEWICWHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gMTYvMTIvMTkgMTg6NTksIEJhcnJldCBSaG9kZW4gd3JvdGU6DQo+IERvZXMgS1ZNLXg4NiBu
ZWVkIGl0cyBvd24gbmFtZXMgZm9yIHRoZSBsZXZlbHM/wqAgSWYgbm90LCBJIGNvdWxkIGNvbnZl
cnQNCj4gdGhlIFBUX1BBR0VfVEFCTEVfKiBzdHVmZiB0byBQR19MRVZFTF8qIHN0dWZmLg0KDQpZ
ZXMsIHBsZWFzZSBkby4gIEZvciB0aGUgMk0vNE0gY2FzZSwgaXQncyBvbmx5IGluY29ycmVjdCB0
byB1c2UgMk0gaGVyZToNCg0KICAgICAgICBpZiAoUFRUWVBFID09IDMyICYmIHdhbGtlci0+bGV2
ZWwgPT0gUFRfRElSRUNUT1JZX0xFVkVMICYmIGlzX2NwdWlkX1BTRTM2KCkpDQogICAgICAgICAg
ICAgICAgZ2ZuICs9IHBzZTM2X2dmbl9kZWx0YShwdGUpOw0KDQpBbmQgZm9yIHRoYXQgeW91IGNh
biBldmVuIHVzZSAiPiBQR19MRVZFTF80SyIgaWYgeW91IHRoaW5rIGl0J3MgbmljZXIuDQoNClBh
b2xvDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
