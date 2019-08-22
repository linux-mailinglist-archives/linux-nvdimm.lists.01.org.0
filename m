Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC419891E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 03:52:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA9AE20213F24;
	Wed, 21 Aug 2019 18:53:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 62D852020D306
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 18:53:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s145so3720036qke.7
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f5/b6EM5llXI7wbQ95XKS+eTiQfi8CiOgyUNELxbz44=;
 b=liA8TgG1W6iZeAa9+70rFbWjKcqn5+YCZNPq4ZFUoUxdc8fe4ITH/EhJhXNLxLlpWx
 4hZZpx/YtJ2oyNeITVRI2P6yGZ9wR3/jZtrWDnOLHnWFlSqq23FUyMlYTdLYl5umh9Fl
 tEAIiLfZ2VycAd3ib1a2j2MRFNAwyktc5uxdjHTCsm3bvCKYtayVOEm5M451cOPTKOpo
 FtHJe2VpQfkw2pG3WHutYH17VTlmEBfxApng7hdTr31iLi4qyr2tu1Gy0AxbM6T8OBob
 qKJxvRRMVszsDJJCE7vak4CHaUJ1pFfWrWtQYmbOgIrlYU44ZYeyHLaeXZdgH7C9h3nF
 p60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f5/b6EM5llXI7wbQ95XKS+eTiQfi8CiOgyUNELxbz44=;
 b=seLqhc9G5Ejw8bpjrdp/94QKR+TlbyfyrIJ1swp8gv5+/D72tQ2JFu6lxZqKwMug0b
 wB34lb2GVZHs5xIxTerlOSH07b7oqxWDEZ2+kA0J6XT58nDQHQRHDEDnFa+Jldsc5SWU
 HcweysmHpUlAqSX8IkRapWASEP+B4bQ2hYAymr96c6oOVeW0Fh/Xpf2X4LIF5pea6mm5
 fv7mtkr42zr8L/glvhhHItoNE3pdSOxAYsgHUW1jOIQBbjvMU4OzphMYJ5vGxxRMtpdF
 8bzGA1ml6xunPOelHVv5FwWTvvzzyYeZp7xBxi6C+1VVPZrO6zndDB84PxpJ3V1riJj7
 gyvA==
X-Gm-Message-State: APjAAAUkWf7R/c8pa81EC80wYzPMSm/WX41zLCZ5ar21pRUCGg4opjTi
 Dd4jg/N2wY3TAax45lA7xP6aWQ==
X-Google-Smtp-Source: APXvYqxUve7UdEp+jCWfHeLX4rsl8Y4/WA+O4MncLknAPC+G2GjOVUN/aglze/CttKpX1cWQmHr6XA==
X-Received: by 2002:a37:7b06:: with SMTP id w6mr26784846qkc.436.1566438723558; 
 Wed, 21 Aug 2019 18:52:03 -0700 (PDT)
Received: from qians-mbp.fios-router.home
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id d37sm7289872qtb.80.2019.08.21.18.52.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 18:52:02 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: devm_memremap_pages() triggers a kasan_add_zero_shadow() warning
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20190822013100.GC2588@MiWiFi-R3L-srv>
Date: Wed, 21 Aug 2019 21:52:01 -0400
Message-Id: <90D5A1E0-24EC-4646-9275-373E43A17A66@lca.pw>
References: <1565991345.8572.28.camel@lca.pw>
 <CAPcyv4i9VFLSrU75U0gQH6K2sz8AZttqvYidPdDcS7sU2SFaCA@mail.gmail.com>
 <0FB85A78-C2EE-4135-9E0F-D5623CE6EA47@lca.pw>
 <CAPcyv4h9Y7wSdF+jnNzLDRobnjzLfkGLpJsML2XYLUZZZUPsQA@mail.gmail.com>
 <E7A04694-504D-4FB3-9864-03C2CBA3898E@lca.pw>
 <CAPcyv4gofF-Xf0KTLH4EUkxuXdRO3ha-w+GoxgmiW7gOdS2nXQ@mail.gmail.com>
 <0AC959D7-5BCB-4A81-BBDC-990E9826EB45@lca.pw>
 <1566421927.5576.3.camel@lca.pw> <20190822013100.GC2588@MiWiFi-R3L-srv>
To: Baoquan He <bhe@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev@googlegroups.com, Linux MM <linux-mm@kvack.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Cgo+IE9uIEF1ZyAyMSwgMjAxOSwgYXQgOTozMSBQTSwgQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5j
b20+IHdyb3RlOgo+IAo+IE9uIDA4LzIxLzE5IGF0IDA1OjEycG0sIFFpYW4gQ2FpIHdyb3RlOgo+
Pj4+IERvZXMgZGlzYWJsaW5nIENPTkZJR19SQU5ET01JWkVfQkFTRSBoZWxwPyBNYXliZSB0aGF0
IHdvcmthcm91bmQgaGFzCj4+Pj4gcmVncmVzc2VkLiBFZmZlY3RpdmVseSB3ZSBuZWVkIHRvIGZp
bmQgd2hhdCBpcyBjYXVzaW5nIHRoZSBrZXJuZWwgdG8KPj4+PiBzb21ldGltZXMgYmUgcGxhY2Vk
IGluIHRoZSBtaWRkbGUgb2YgYSBjdXN0b20gcmVzZXJ2ZWQgbWVtbWFwPSByYW5nZS4KPj4+IAo+
Pj4gWWVzLCBkaXNhYmxpbmcgS0FTTFIgd29ya3MgZ29vZCBzbyBmYXIuIEFzc3VtaW5nIHRoZSB3
b3JrYXJvdW5kLCBpLmUuLAo+Pj4gZjI4NDQyNDk3YjVjCj4+PiAo4oCceDg2L2Jvb3Q6IEZpeCBL
QVNMUiBhbmQgbWVtbWFwPSBjb2xsaXNpb27igJ0pIGlzIGNvcnJlY3QuCj4+PiAKPj4+IFRoZSBv
bmx5IG90aGVyIGNvbW1pdCB0aGF0IG1pZ2h0IHJlZ3Jlc3MgaXQgZnJvbSBteSByZXNlYXJjaCBz
byBmYXIgaXMsCj4+PiAKPj4+IGQ1MmU3ZDVhOTUyYyAoIng4Ni9LQVNMUjogUGFyc2UgYWxsICdt
ZW1tYXA9JyBib290IG9wdGlvbiBlbnRyaWVz4oCdKQo+Pj4gCj4+IAo+PiBJdCB0dXJucyBvdXQg
dGhhdCB0aGUgb3JpZ2luIGNvbW1pdCBmMjg0NDI0OTdiNWMgKOKAnHg4Ni9ib290OiBGaXggS0FT
TFIgYW5kCj4+IG1lbW1hcD0gY29sbGlzaW9u4oCdKSBoYXMgYSBidWcgdGhhdCBpcyB1bmFibGUg
dG8gaGFuZGxlICJtZW1tYXA9IiBpbgo+PiBDT05GSUdfQ01ETElORSBpbnN0ZWFkIG9mIGEgcGFy
YW1ldGVyIGluIGJvb3Rsb2FkZXIgYmVjYXVzZSB3aGVuIGl0IChhcyB3ZWxsIGFzCj4+IHRoZSBj
b21taXQgZDUyZTdkNWE5NTJjKSBjYWxscyBnZXRfY21kX2xpbmVfcHRyKCkgaW4gb3JkZXIgdG8g
cnVuCj4+IG1lbV9hdm9pZF9tZW1tYXAoKSwgImJvb3RfcGFyYW1zIiBoYXMgbm8ga25vd2xlZGdl
IG9mIENPTkZJR19DTURMSU5FLiBPbmx5IGxhdGVyCj4+IGluIHNldHVwX2FyY2goKSwgdGhlIGtl
cm5lbCB3aWxsIGRlYWwgd2l0aCBwYXJhbWV0ZXJzIG92ZXIgdGhlcmUuCj4gCj4gWWVzLCB3ZSBk
aWRuJ3QgY29uc2lkZXIgQ09ORklHX0NNRExJTkUgZHVyaW5nIGJvb3QgY29tcHJlc3Npbmcgc3Rh
Z2UuIEl0Cj4gc2hvdWxkIGJlIGEgZ2VuZXJpYyBpc3N1ZSBzaW5jZSBvdGhlciBwYXJhbWV0ZXJz
IGZyb20gQ09ORklHX0NNRExJTkUgY291bGQKPiBiZSBpZ25vcmVkIHRvbywgbm90IG9ubHkgS0FT
TFIgaGFuZGxpbmcuIFdvdWxkIHlvdSBsaWtlIHRvIGNhc3QgYSBwYXRjaAo+IHRvIGZpeCBpdD8g
T3IgSSBjYW4gZml4IGl0IGxhdGVyLCBtYXliZSBuZXh0IHdlZWsuCgpJIHRoaW5rIHlvdSBoYXZl
IG1vcmUgZXhwZXJpZW5jZSB0aGFuIG1lIGluIHRoaXMgYXJlYSwgc28gaWYgeW91IGhhdmUgdGlt
ZSB0byBmaXggaXQsIHRoYXQKd291bGQgYmUgbmljZS4KCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QKTGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZwpodHRwczovL2xpc3RzLjAxLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52ZGltbQo=
