Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBF2319A5
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 08:36:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0322912693505;
	Tue, 28 Jul 2020 23:36:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [216.205.24.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D9BD126934FE
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 23:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1596004609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDnOGzrtle3KYYzuMAUvVtP9mTXNkGzn83ZG7Mp/mr0=;
	b=HiPOR7V7oX7UhogtotciVM17AzyYfpFW0DJQhnew3vsYj9TSm5rzQTahoD/4uC5Z7EayK2
	JHptLw89FckzvqT1LMkA7hiSbstQ3NRmcMZcmElRLq/jcvNtA0qVwgZgLLNnGUWS9qURaE
	tvUcNN6Rpx39STp8BGRzv2VeZhcpui0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-KdVUShFTP7eSGY_zV4sSdA-1; Wed, 29 Jul 2020 02:36:39 -0400
X-MC-Unique: KdVUShFTP7eSGY_zV4sSdA-1
Received: by mail-ej1-f70.google.com with SMTP id e7so8092870ejj.10
        for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 23:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vCrW+09lbptolyLVHV/kS+2Iwz8f8KaQB9+crgZ4nRc=;
        b=FpH1dm84ViO5SeGMU5HFMxT44b3m1tnHZkeI5vEU8TCXeTvYA0q4bLz+j9EiCBE/Kq
         6VaAT2bN6+PI4LpnaiTL854XVyHazKpysJZ09S1N3If0s3w5FMsqLj3PYRgiXYwQXIPR
         fplN/g9As/mHkFP+QS1CcswR7g/PLE1zW+Ot8FZc3OKyqQJ+pRDl9Gwi+BXuDWeXP18O
         tLT1K6pzpVdbr98nFGapnQHf8n0G9J+Aqrwk3f6iS6loxd9oycNULj8/Jbu7owuiOsfO
         2zODjcaM/WX2tSZA8/vj4xPTBy9wWrOX7amcxBp8RuIe8l/Fad5mOXaR8UNKgLiIMDit
         OHwg==
X-Gm-Message-State: AOAM530kg6lN4xwvFAlEyHwCa9hpLOqE4LqO6mAH/5yDYIRYRhX2Mm64
	74vTXAL9WaQ6bsZAxGJvaDZ4I+R+RwygSUax/nTuCyD4GU66LDhaiqMun0aJc7+wq+8aFxDWfAp
	OQSgEVf9+8I5cLygA8PPH
X-Received: by 2002:a17:906:af72:: with SMTP id os18mr22077236ejb.43.1596004598537;
        Tue, 28 Jul 2020 23:36:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcOEQf3BfvpROnJUn2gc1RpMHWSlSuMLRoJwDln6tha4VHmjjudQEPLpp9B2oHlZl36OhE4A==
X-Received: by 2002:a17:906:af72:: with SMTP id os18mr22077187ejb.43.1596004598057;
        Tue, 28 Jul 2020 23:36:38 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c648d.dip0.t-ipconnect.de. [91.12.100.141])
        by smtp.gmail.com with ESMTPSA id y1sm1101921ede.7.2020.07.28.23.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 23:36:37 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 0/6] decrease unnecessary gap due to pmem kmem alignment
Date: Wed, 29 Jul 2020 08:36:36 +0200
Message-Id: <D1981D47-61F1-42E9-A426-6FEF0EC310C8@redhat.com>
References: <20200729033424.2629-1-justin.he@arm.com>
In-Reply-To: <20200729033424.2629-1-justin.he@arm.com>
To: Jia He <justin.he@arm.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: BYZP3RKTDKC2A3C6GVO72DLH4BBCHZ2Z
X-Message-ID-Hash: BYZP3RKTDKC2A3C6GVO72DLH4BBCHZ2Z
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Steve Capper <steve.capper@arm.com>, Mark Rutland <mark.rutland@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Hsin-Yi Wang <hsinyi@chromium.org>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BYZP3RKTDKC2A3C6GVO72DLH4BBCHZ2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gQW0gMjkuMDcuMjAyMCB1bSAwNTozNSBzY2hyaWViIEppYSBIZSA8anVzdGluLmhlQGFy
bS5jb20+Og0KPiANCj4g77u/V2hlbiBlbmFibGluZyBkYXggcG1lbSBhcyBSQU0gZGV2aWNlIG9u
IGFybTY0LCBJIG5vdGljZWQgdGhhdCBrbWVtX3N0YXJ0DQo+IGFkZHIgaW4gZGV2X2RheF9rbWVt
X3Byb2JlKCkgc2hvdWxkIGJlIGFsaWduZWQgdy8gU0VDVElPTl9TSVpFX0JJVFMoMzApLGkuZS4N
Cj4gMUcgbWVtYmxvY2sgc2l6ZS4gRXZlbiBEYW4gV2lsbGlhbXMnIHN1Yi1zZWN0aW9uIHBhdGNo
IHNlcmllcyBbMV0gaGFkIGJlZW4NCj4gdXBzdHJlYW0gbWVyZ2VkLCBpdCB3YXMgbm90IGhlbHBm
dWwgZHVlIHRvIGhhcmQgbGltaXRhdGlvbiBvZiBrbWVtX3N0YXJ0Og0KPiAkbmRjdGwgY3JlYXRl
LW5hbWVzcGFjZSAtZSBuYW1lc3BhY2UwLjAgLS1tb2RlPWRldmRheCAtLW1hcD1kZXYgLXMgMmcg
LWYgLWEgMk0NCj4gJGVjaG8gZGF4MC4wID4gL3N5cy9idXMvZGF4L2RyaXZlcnMvZGV2aWNlX2Rh
eC91bmJpbmQNCj4gJGVjaG8gZGF4MC4wID4gL3N5cy9idXMvZGF4L2RyaXZlcnMva21lbS9uZXdf
aWQNCj4gJGNhdCAvcHJvYy9pb21lbQ0KPiAuLi4NCj4gMjNjMDAwMDAwLTIzZmZmZmZmZiA6IFN5
c3RlbSBSQU0NCj4gIDIzZGQ0MDAwMC0yM2ZlY2ZmZmYgOiByZXNlcnZlZA0KPiAgMjNmZWQwMDAw
LTIzZmZmZmZmZiA6IHJlc2VydmVkDQo+IDI0MDAwMDAwMC0zM2ZkZmZmZmYgOiBQZXJzaXN0ZW50
IE1lbW9yeQ0KPiAgMjQwMDAwMDAwLTI0MDNmZmZmZiA6IG5hbWVzcGFjZTAuMA0KPiAgMjgwMDAw
MDAwLTJiZmZmZmZmZiA6IGRheDAuMCAgICAgICAgICA8LSBhbGlnbmVkIHdpdGggMUcgYm91bmRh
cnkNCj4gICAgMjgwMDAwMDAwLTJiZmZmZmZmZiA6IFN5c3RlbSBSQU0NCj4gSGVuY2UgdGhlcmUg
aXMgYSBiaWcgZ2FwIGJldHdlZW4gMHgyNDAzZmZmZmYgYW5kIDB4MjgwMDAwMDAwIGR1ZSB0byB0
aGUgMUcNCj4gYWxpZ25tZW50Lg0KPiANCj4gV2l0aG91dCB0aGlzIHNlcmllcywgaWYgcWVtdSBj
cmVhdGVzIGEgNEcgYnl0ZXMgbnZkaW1tIGRldmljZSwgd2UgY2FuIG9ubHkNCj4gdXNlIDJHIGJ5
dGVzIGZvciBkYXggcG1lbShrbWVtKSBpbiB0aGUgd29yc3QgY2FzZS4NCj4gZS5nLg0KPiAyNDAw
MDAwMDAtMzNmZGZmZmZmIDogUGVyc2lzdGVudCBNZW1vcnkgDQo+IFdlIGNhbiBvbmx5IHVzZSB0
aGUgbWVtYmxvY2sgYmV0d2VlbiBbMjQwMDAwMDAwLCAyZmZmZmZmZmZdIGR1ZSB0byB0aGUgaGFy
ZA0KPiBsaW1pdGF0aW9uLiBJdCB3YXN0ZXMgdG9vIG11Y2ggbWVtb3J5IHNwYWNlLg0KPiANCj4g
RGVjcmVhc2luZyB0aGUgU0VDVElPTl9TSVpFX0JJVFMgb24gYXJtNjQgbWlnaHQgYmUgYW4gYWx0
ZXJuYXRpdmUsIGJ1dCB0aGVyZQ0KPiBhcmUgdG9vIG1hbnkgY29uY2VybnMgZnJvbSBvdGhlciBj
b25zdHJhaW50cywgZS5nLiBQQUdFX1NJWkUsIGh1Z2V0bGIsDQo+IFNQQVJTRU1FTV9WTUVNTUFQ
LCBwYWdlIGJpdHMgaW4gc3RydWN0IHBhZ2UgLi4uDQo+IA0KPiBCZXNpZGUgZGVjcmVhc2luZyB0
aGUgU0VDVElPTl9TSVpFX0JJVFMsIHdlIGNhbiBhbHNvIHJlbGF4IHRoZSBrbWVtIGFsaWdubWVu
dA0KPiB3aXRoIG1lbW9yeV9ibG9ja19zaXplX2J5dGVzKCkuDQo+IA0KPiBUZXN0ZWQgb24gYXJt
NjQgZ3Vlc3QgYW5kIHg4NiBndWVzdCwgcWVtdSBjcmVhdGVzIGEgNEcgcG1lbSBkZXZpY2UuIGRh
eCBwbWVtDQo+IGNhbiBiZSB1c2VkIGFzIHJhbSB3aXRoIHNtYWxsZXIgZ2FwLiBBbHNvIHRoZSBr
bWVtIGhvdHBsdWcgYWRkL3JlbW92ZSBhcmUgYm90aA0KPiB0ZXN0ZWQgb24gYXJtNjQveDg2IGd1
ZXN0Lg0KPiANCg0KSGksDQoNCkkgYW0gbm90IGNvbnZpbmNlZCB0aGlzIHVzZSBjYXNlIGlzIHdv
cnRoIHN1Y2ggaGFja3MgKHRoYXTigJlzIHdoYXQgaXQgaXMpIGZvciBub3cuIE9uIHJlYWwgbWFj
aGluZXMgcG1lbSBpcyBiaWcgLSB5b3VyIGV4YW1wbGUgKGxvc2luZyA1MCUgaXMgZXh0cmVtZSku
DQoNCkkgd291bGQgbXVjaCByYXRoZXIgd2FudCB0byBzZWUgdGhlIHNlY3Rpb24gc2l6ZSBvbiBh
cm02NCByZWR1Y2VkLiBJIHJlbWVtYmVyIHRoZXJlIHdlcmUgcGF0Y2hlcyBhbmQgdGhhdCBhdCBs
ZWFzdCB3aXRoIGEgYmFzZSBwYWdlIHNpemUgb2YgNGsgaXQgY2FuIGJlIHJlZHVjZWQgZHJhc3Rp
Y2FsbHkgKDY0ayBiYXNlIHBhZ2VzIGFyZSBtb3JlIHByb2JsZW1hdGljIGR1ZSB0byB0aGUgcmlk
aWN1bG91cyBUSFAgc2l6ZSBvZiA1MTJNKS4gQnV0IGNvdWxkIGJlIGEgc2VjdGlvbiBzaXplIG9m
IDUxMiBpcyBwb3NzaWJsZSBvbiBhbGwgY29uZmlncyByaWdodCBub3cuDQoNCkluIHRoZSBsb25n
IHRlcm0gd2UgbWlnaHQgd2FudCB0byByZXdvcmsgdGhlIG1lbW9yeSBibG9jayBkZXZpY2UgbW9k
ZWwgKGV2ZW50dWFsbHkgc3VwcG9ydGluZyBvbGQvbmV3IGFzIGRpc2N1c3NlZCB3aXRoIE1pY2hh
bCBzb21lIHRpbWUgYWdvIHVzaW5nIGEga2VybmVsIHBhcmFtZXRlciksIGRyb3BwaW5nIHRoZSBm
aXhlZCBzaXplcw0KLSBhbGxvd2luZyBzaXplcyAvIGFkZHJlc3NlcyBhbGlnbmVkIHdpdGggc3Vi
c2VjdGlvbiBzaXplDQotIGRyYXN0aWNhbGx5IHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgZGV2aWNl
cyBmb3IgYm9vdCBtZW1vcnkgdG8gb25seSBhIGhhbmQgZnVsbCAoZS5nLiwgb25lIHBlciByZXNv
dXJjZSAvIERJTU0gd2UgY2FuIGFjdHVhbGx5IHVucGx1ZyBhZ2Fpbi4NCg0KTG9uZyBzdG9yeSBz
aG9ydCwgSSBkb27igJl0IGxpa2UgdGhpcyBoYWNrLg0KDQoNCj4gVGhpcyBwYXRjaCBzZXJpZXMg
KG1haW5seSBwYXRjaDYvNikgaXMgYmFzZWQgb24gdGhlIGZpeGluZyBwYXRjaCwgfnY1LjgtcmM1
IFsyXS4NCj4gDQo+IFsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS82LzE5LzY3DQo+IFsy
XSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzgvMTU0Ng0KPiBKaWEgSGUgKDYpOg0KPiAg
bW0vbWVtb3J5X2hvdHBsdWc6IHJlbW92ZSByZWR1bmRhbnQgbWVtb3J5IGJsb2NrIHNpemUgYWxp
Z25tZW50IGNoZWNrDQo+ICByZXNvdXJjZTogZXhwb3J0IGZpbmRfbmV4dF9pb21lbV9yZXMoKSBo
ZWxwZXINCj4gIG1tL21lbW9yeV9ob3RwbHVnOiBhbGxvdyBwbWVtIGttZW0gbm90IHRvIGFsaWdu
IHdpdGggbWVtb3J5X2Jsb2NrX3NpemUNCj4gIG1tL3BhZ2VfYWxsb2M6IGFkanVzdCB0aGUgc3Rh
cnQsZW5kIGluIGRheCBwbWVtIGttZW0gY2FzZQ0KPiAgZGV2aWNlLWRheDogcmVsYXggdGhlIG1l
bWJsb2NrIHNpemUgYWxpZ25tZW50IGZvciBrbWVtX3N0YXJ0DQo+ICBhcm02NDogZmFsbCBiYWNr
IHRvIHZtZW1tYXBfcG9wdWxhdGVfYmFzZXBhZ2VzIGlmIG5vdCBhbGlnbmVkICB3aXRoDQo+ICAg
IFBNRF9TSVpFDQo+IA0KPiBhcmNoL2FybTY0L21tL21tdS5jICAgIHwgIDQgKysrKw0KPiBkcml2
ZXJzL2Jhc2UvbWVtb3J5LmMgIHwgMjQgKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+IGRyaXZl
cnMvZGF4L2ttZW0uYyAgICAgfCAyMiArKysrKysrKysrKysrLS0tLS0tLS0tDQo+IGluY2x1ZGUv
bGludXgvaW9wb3J0LmggfCAgMyArKysNCj4ga2VybmVsL3Jlc291cmNlLmMgICAgICB8ICAzICsr
LQ0KPiBtbS9tZW1vcnlfaG90cGx1Zy5jICAgIHwgMzkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystDQo+IG1tL3BhZ2VfYWxsb2MuYyAgICAgICAgfCAxNCArKysrKysrKysr
KysrKw0KPiA3IGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygt
KQ0KPiANCj4gLS0gDQo+IDIuMTcuMQ0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
