Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743B5FE2FF
	for <lists+linux-nvdimm@lfdr.de>; Fri, 15 Nov 2019 17:42:12 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F6CE100DC3D2;
	Fri, 15 Nov 2019 08:43:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BF7E100DC3D0
	for <linux-nvdimm@lists.01.org>; Fri, 15 Nov 2019 08:43:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j7so9157989oib.3
        for <linux-nvdimm@lists.01.org>; Fri, 15 Nov 2019 08:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UZSpFkKNVNV5BKs7QN+kq39SLlJrWMnwXj2a0zo8qnE=;
        b=poDEPVm+GRR+otLxrdSAZ6RsFhwEqAB1QsJkDuE4KbprEHKb80CHLXH6PlYDj+gCJV
         aHoGJ3u18gqjviqy7N0LoTBLO0V2sac4WD6sUmk1cxf7Sedhny0n6g52TAzu+xTL5zcX
         tqsterSsgoqkXQTAK3rkgi24Qnqpvpccy1d9oiLUq5Jl0AXoSygIvE9v68gz5rB1E11H
         AQNZMSqmOY8G/6aXzE1okGyyRJT0rVFrhEFiY+ce5br0jvhm2hC5K3JKJVYJ547eYn4a
         fbU3FL4L9qINKtj5J6n+64VjPU/E93yKhOQa2y2aFvCUxcwPs94f7rvsImulrlR+aYaS
         u5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UZSpFkKNVNV5BKs7QN+kq39SLlJrWMnwXj2a0zo8qnE=;
        b=hqF1338GKJ6LFx18V+XwJxjpfvqXzbRsHbIiQAuWZmQUYj5upPqp54eA4nfQjB2MCe
         M7N7Sk45ePMCi+H5LMNTR5aHcOQxE/qu/Qt9Jn8pcuttL2MA2TqTGzMjgj2E6/OxoR0x
         abqywh7Ma5u1oZNF9Dap/ZLJYpy3R/suPOFyObT3ZM37e7fT+Rj6Y08X9IiLV1cM9SO5
         aCl3Ha4GCzkuHs0ajf1r+ECKmxIvQZJTsOef28YYac8ab8fdFj2lFmM4IgwQRxCoS+uK
         9pqFIYtorbpG+zV4kbhxcBBoEKCVM1jodMtSErWJn2ZyUXyPZyNDaEhjXCzzXJ8FPsY1
         /MGw==
X-Gm-Message-State: APjAAAWlyUgetFC7tZOLRqSuICZ5c0TgFAw/ZdfjEiTDqn6pjwCagCGa
	VdHdySmpXNOX+qqFH/nrQaTV0HmNOHpN6kTk+g3B0Q==
X-Google-Smtp-Source: APXvYqwos7WvYIQqqWWqUogHfETfT35eaGRAWlExs8ZOoMOJeR3E1BLLqRkliqxSdDz2iG5PlZ1EhrthGVA+LQklxHU=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr9249378oib.105.1573836126000;
 Fri, 15 Nov 2019 08:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20191115001134.2489505-1-jhubbard@nvidia.com> <20191115001134.2489505-3-jhubbard@nvidia.com>
In-Reply-To: <20191115001134.2489505-3-jhubbard@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 15 Nov 2019 08:41:55 -0800
Message-ID: <CAPcyv4hWksbxM5h4b4hCfs_MSggDoEDoxiu4sw2uj1N=z+mOcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
To: John Hubbard <jhubbard@nvidia.com>
Message-ID-Hash: LMVBNON37QWBOATRLLXUBJXTDSHBXHXP
X-Message-ID-Hash: LMVBNON37QWBOATRLLXUBJXTDSHBXHXP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LMVBNON37QWBOATRLLXUBJXTDSHBXHXP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgNDoxMSBQTSBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52
aWRpYS5jb20+IHdyb3RlOg0KPg0KPiBBbiB1cGNvbWluZyBwYXRjaCBjaGFuZ2VzIGFuZCBjb21w
bGljYXRlcyB0aGUgcmVmY291bnRpbmcgYW5kDQo+IGVzcGVjaWFsbHkgdGhlICJwdXQgcGFnZSIg
YXNwZWN0cyBvZiBpdC4gSW4gb3JkZXIgdG8ga2VlcA0KPiBldmVyeXRoaW5nIGNsZWFuLCByZWZh
Y3RvciB0aGUgZGV2bWFwIHBhZ2UgcmVsZWFzZSByb3V0aW5lczoNCj4NCj4gKiBSZW5hbWUgcHV0
X2Rldm1hcF9tYW5hZ2VkX3BhZ2UoKSB0byBwYWdlX2lzX2Rldm1hcF9tYW5hZ2VkKCksDQo+ICAg
YW5kIGxpbWl0IHRoZSBmdW5jdGlvbmFsaXR5IHRvICJyZWFkIG9ubHkiOiByZXR1cm4gYSBib29s
LA0KPiAgIHdpdGggbm8gc2lkZSBlZmZlY3RzLg0KPg0KPiAqIEFkZCBhIG5ldyByb3V0aW5lLCBw
dXRfZGV2bWFwX21hbmFnZWRfcGFnZSgpLCB0byBoYW5kbGUgY2hlY2tpbmcNCj4gICB3aGF0IGtp
bmQgb2YgcGFnZSBpdCBpcywgYW5kIHdoYXQga2luZCBvZiByZWZjb3VudCBoYW5kbGluZyBpdA0K
PiAgIHJlcXVpcmVzLg0KPg0KPiAqIFJlbmFtZSBfX3B1dF9kZXZtYXBfbWFuYWdlZF9wYWdlKCkg
dG8gZnJlZV9kZXZtYXBfbWFuYWdlZF9wYWdlKCksDQo+ICAgYW5kIGxpbWl0IHRoZSBmdW5jdGlv
bmFsaXR5IHRvIHVuY29uZGl0aW9uYWxseSBmcmVlaW5nIGEgZGV2bWFwDQo+ICAgcGFnZS4NCj4N
Cj4gVGhpcyBpcyBvcmlnaW5hbGx5IGJhc2VkIG9uIGEgc2VwYXJhdGUgcGF0Y2ggYnkgSXJhIFdl
aW55LCB3aGljaA0KPiBhcHBsaWVkIHRvIGFuIGVhcmx5IHZlcnNpb24gb2YgdGhlIHB1dF91c2Vy
X3BhZ2UoKSBleHBlcmltZW50cy4NCj4gU2luY2UgdGhlbiwgSsOpcsO0bWUgR2xpc3NlIHN1Z2dl
c3RlZCB0aGUgcmVmYWN0b3JpbmcgZGVzY3JpYmVkIGFib3ZlLg0KPg0KPiBDYzogSmFuIEthcmEg
PGphY2tAc3VzZS5jej4NCj4gQ2M6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNzZUByZWRoYXQuY29t
Pg0KPiBDYzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBEYW4gV2lsbGlh
bXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBKw6lyw7RtZSBH
bGlzc2UgPGpnbGlzc2VAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSXJhIFdlaW55IDxp
cmEud2VpbnlAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2huIEh1YmJhcmQgPGpodWJi
YXJkQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgaW5jbHVkZS9saW51eC9tbS5oIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+ICBtbS9tZW1yZW1hcC5jICAgICAgfCAxNiArKy0tLS0t
LS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDE3IGRlbGV0
aW9ucygtKQ0KDQpMb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
