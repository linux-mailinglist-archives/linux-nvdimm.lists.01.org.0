Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75824363E5A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 11:15:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFC20100EBB92;
	Mon, 19 Apr 2021 02:15:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2D894100EBB92
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618823708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJHH0NX3OsQ2e3bz8MbvbRBxnLsHKmu/POOlzwxl9eU=;
	b=QX2G3CzJ/NKD5UOg85qHAZTkn4RiYHvYTExtbc+L2jA7dhUw0gVsiT0k5iKqRzYhEVDons
	pF1+55fvvZBvw9Gn3JVIcieUx0XziS9/K+8s9SJ1s9J0VSkh8kwTvP28dW+dEFJcvlIqU0
	KMPI/jgfhyYGNVdLCq+Z1xq5xuU5A5w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-M_DJhLxnNr-sJy9HAZaLqg-1; Mon, 19 Apr 2021 05:15:06 -0400
X-MC-Unique: M_DJhLxnNr-sJy9HAZaLqg-1
Received: by mail-ej1-f70.google.com with SMTP id w2-20020a1709062f82b0290378745f26d5so3385878eji.6
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JJHH0NX3OsQ2e3bz8MbvbRBxnLsHKmu/POOlzwxl9eU=;
        b=G53mAzuA+3+5t4a9k5e+03l0wCofPGViPApFua/7/wOJnRaHtmVP02B6Zq8tL8QCaN
         iQEzRbDpgzSU/nAfvfZWne4vGaEl0QaArQcDIQ/XC6kU8oi+xRX/nlUR8aeGXEKls85n
         jnMLbAy33CTVITodaphiXjPYw3/a28p63ldUnxepLnZa+qJbKSbqJiy+WzPW9i3iyf+1
         WTD/JOgvyMruORPt2O8/TctuWaxI0l0KW5m7pt+9NK9cq7cU/Z8w6tb/ca2Rrk8ATo4P
         v57MkxjZIexuaJBDTk2QrX2x7SLw06lt4MKJ6b8q6Thja39GPaLzrIJSUJddV2XZgHeE
         PXKg==
X-Gm-Message-State: AOAM531m0p5SvxG4zYo/h3526DdFGfYorCjotU6iffo7ls/vnVJLxN1o
	5j+aiW8kkmVEYqDyyv0V2aQCJHVHMTnN+nnBktvMUiBvd1buG3BfzArTjEsqTObZCmQvqv9uFUk
	km46wP32wpN93g41cqpT8
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr23711248edc.131.1618823705481;
        Mon, 19 Apr 2021 02:15:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYzYlDX/eTm99p4Oo7Oz5LAmRLoDDSSTEdvjwkyJC6GdKrJUD2OsxJ6l4DnJdCX72CgXH3hg==
X-Received: by 2002:a05:6402:42d1:: with SMTP id i17mr23711232edc.131.1618823705193;
        Mon, 19 Apr 2021 02:15:05 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id y16sm12144407edc.62.2021.04.19.02.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:15:04 -0700 (PDT)
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20210419084218.7466-1-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
Message-ID: <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
Date: Mon, 19 Apr 2021 11:15:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210419084218.7466-1-rppt@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: BF3JFK2COP6LEQYXGJLJRWOXKJWKPRTS
X-Message-ID-Hash: BF3JFK2COP6LEQYXGJLJRWOXKJWKPRTS
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixn
 er <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BF3JFK2COP6LEQYXGJLJRWOXKJWKPRTS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjEgMTA6NDIsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IEZyb206IE1pa2UgUmFw
b3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4gDQo+IEtlcm5lbCB0ZXN0IHJvYm90IHJlcG9y
dGVkIC00LjIlIHJlZ3Jlc3Npb24gb2Ygd2lsbC1pdC1zY2FsZS5wZXJfdGhyZWFkX29wcw0KPiBk
dWUgdG8gY29tbWl0ICJtbTogaW50cm9kdWNlIG1lbWZkX3NlY3JldCBzeXN0ZW0gY2FsbCB0byBj
cmVhdGUgInNlY3JldCINCj4gbWVtb3J5IGFyZWFzIi4NCj4gDQo+IFRoZSBwZXJmIHByb2ZpbGUg
b2YgdGhlIHRlc3QgaW5kaWNhdGVkIHRoYXQgdGhlIHJlZ3Jlc3Npb24gaXMgY2F1c2VkIGJ5DQo+
IHBhZ2VfaXNfc2VjcmV0bWVtKCkgY2FsbGVkIGZyb20gZ3VwX3B0ZV9yYW5nZSgpIChpbmxpbmVk
IGJ5IGd1cF9wZ2RfcmFuZ2UpOg0KPiANCj4gICAyNy43NiAgKzIuNSAgMzAuMjMgICAgICAgcGVy
Zi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5ndXBfcGdkX3JhbmdlDQo+ICAgIDAuMDAgICsz
LjIgICAzLjE5IMKxIDIlICBwZXJmLXByb2ZpbGUuY2hpbGRyZW4uY3ljbGVzLXBwLnBhZ2VfbWFw
cGluZw0KPiAgICAwLjAwICArMy43ICAgMy42NiDCsSAyJSAgcGVyZi1wcm9maWxlLmNoaWxkcmVu
LmN5Y2xlcy1wcC5wYWdlX2lzX3NlY3JldG1lbQ0KPiANCj4gRnVydGhlciBhbmFseXNpcyBzaG93
ZWQgdGhhdCB0aGUgc2xvdyBkb3duIGhhcHBlbnMgYmVjYXVzZSBuZWl0aGVyDQo+IHBhZ2VfaXNf
c2VjcmV0bWVtKCkgbm9yIHBhZ2VfbWFwcGluZygpIGFyZSBub3QgaW5saW5lIGFuZCBtb3Jlb3Zl
ciwNCj4gbXVsdGlwbGUgcGFnZSBmbGFncyBjaGVja3MgaW4gcGFnZV9tYXBwaW5nKCkgaW52b2x2
ZSBjYWxsaW5nDQo+IGNvbXBvdW5kX2hlYWQoKSBzZXZlcmFsIHRpbWVzIGZvciB0aGUgc2FtZSBw
YWdlLg0KPiANCj4gTWFrZSBwYWdlX2lzX3NlY3JldG1lbSgpIGlubGluZSBhbmQgcmVwbGFjZSBw
YWdlX21hcHBpbmcoKSB3aXRoIHBhZ2UgZmxhZw0KPiBjaGVja3MgdGhhdCBkbyBub3QgaW1wbHkg
cGFnZS10by1oZWFkIGNvbnZlcnNpb24uDQo+IA0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qg
cm9ib3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBv
cG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiAtLS0NCj4gDQo+IEBBbmRyZXcsDQo+IFRoZSBw
YXRjaCBpcyB2cyB2NS4xMi1yYzctbW1vdHMtMjAyMS0wNC0xNS0xNi0yOCwgSSdkIGFwcHJlY2lh
dGUgaWYgaXQgd291bGQNCj4gYmUgYWRkZWQgYXMgYSBmaXh1cCB0byB0aGUgbWVtZmRfc2VjcmV0
IHNlcmllcy4NCj4gDQo+ICAgaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaCB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysrKystDQo+ICAgbW0vc2VjcmV0bWVtLmMgICAgICAgICAgICB8IDEyICst
LS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaCBi
L2luY2x1ZGUvbGludXgvc2VjcmV0bWVtLmgNCj4gaW5kZXggOTA3YTY3MzQwNTljLi5iODQyYjM4
Y2JlYjEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc2VjcmV0bWVtLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaA0KPiBAQCAtNCw4ICs0LDMyIEBADQo+ICAgDQo+ICAg
I2lmZGVmIENPTkZJR19TRUNSRVRNRU0NCj4gICANCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgYWRk
cmVzc19zcGFjZV9vcGVyYXRpb25zIHNlY3JldG1lbV9hb3BzOw0KPiArDQo+ICtzdGF0aWMgaW5s
aW5lIGJvb2wgcGFnZV9pc19zZWNyZXRtZW0oc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICt7DQo+ICsJ
c3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmc7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFVzaW5n
IHBhZ2VfbWFwcGluZygpIGlzIHF1aXRlIHNsb3cgYmVjYXVzZSBvZiB0aGUgYWN0dWFsIGNhbGwN
Cj4gKwkgKiBpbnN0cnVjdGlvbiBhbmQgcmVwZWF0ZWQgY29tcG91bmRfaGVhZChwYWdlKSBpbnNp
ZGUgdGhlDQo+ICsJICogcGFnZV9tYXBwaW5nKCkgZnVuY3Rpb24uDQo+ICsJICogV2Uga25vdyB0
aGF0IHNlY3JldG1lbSBwYWdlcyBhcmUgbm90IGNvbXBvdW5kIGFuZCBMUlUgc28gd2UgY2FuDQo+
ICsJICogc2F2ZSBhIGNvdXBsZSBvZiBjeWNsZXMgaGVyZS4NCj4gKwkgKi8NCj4gKwlpZiAoUGFn
ZUNvbXBvdW5kKHBhZ2UpIHx8ICFQYWdlTFJVKHBhZ2UpKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQoN
CkknZCBhc3N1bWUgc2VjcmV0bWVtIHBhZ2VzIGFyZSByYXJlIGluIGJhc2ljYWxseSBldmVyeSBz
ZXR1cCBvdXQgdGhlcmUuIA0KU28gbWF5YmUgdGhyb3dpbmcgaW4gYSBjb3VwbGUgb2YgbGlrZWx5
KCkvdW5saWtlbHkoKSBtaWdodCBtYWtlIHNlbnNlLg0KDQo+ICsNCj4gKwltYXBwaW5nID0gKHN0
cnVjdCBhZGRyZXNzX3NwYWNlICopDQo+ICsJCSgodW5zaWduZWQgbG9uZylwYWdlLT5tYXBwaW5n
ICYgflBBR0VfTUFQUElOR19GTEFHUyk7DQo+ICsNCg0KTm90IHN1cmUgaWYgb3Blbi1jb2Rpbmcg
cGFnZV9tYXBwaW5nIGlzIHJlYWxseSBhIGdvb2QgaWRlYSBoZXJlIC0tIG9yIA0KZXZlbiBuZWNl
c3NhcnkgYWZ0ZXIgdGhlIGZhc3QgcGF0aCBhYm92ZSBpcyBpbiBwbGFjZS4gQW55aG93LCBqdXN0
IG15IDIgDQpjZW50cy4NCg0KVGhlIGlkZWEgb2YgdGhlIHBhdGNoIG1ha2VzIHNlbnNlIHRvIG1l
Lg0KDQotLSANClRoYW5rcywNCg0KRGF2aWQgLyBkaGlsZGVuYg0KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAt
LSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwg
dG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
