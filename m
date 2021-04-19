Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF01363F72
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 12:21:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F012100EB827;
	Mon, 19 Apr 2021 03:21:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6FD47100EBB97
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 03:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618827698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xpi5lBk+awQqaK6Y03m/CCSgGP4Mxrpo1j7RjBYWGpQ=;
	b=RpFTYZJllBfLrvOkIyyyjdJB5dQpYh75p1kl7C17eZHpzIJCD1chdSBHNdXO+1X9rEchpd
	dv4GrQ5LwDmZfhmmQ/w8Pv1dKToK4Z6ZST9WU4Pvq2PMYtdVqPqYMcin7fbcxdlazxc6Bu
	HO59Nf+wV9S2ZM82Hkd/HCe3sufmUso=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-OEfZTDtDPWC0nUUGiB02wQ-1; Mon, 19 Apr 2021 06:21:34 -0400
X-MC-Unique: OEfZTDtDPWC0nUUGiB02wQ-1
Received: by mail-ed1-f71.google.com with SMTP id f9-20020a50fe090000b02903839889635cso8952090edt.14
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 03:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xpi5lBk+awQqaK6Y03m/CCSgGP4Mxrpo1j7RjBYWGpQ=;
        b=Ohs8iWJQMeUT+FkGtfh1DXV8pUe+hIFuMAMB3qsv2DdE3SHyPpbGJp6UPAUm7Gi1g7
         rKKbOzeTCRjccwfBSiregX8c8BeySVYZaaRk55Pv910C9JcCP2S9WRWvyhTpufwwIHhx
         FzRv84O13Jwxpm7z/ofvw7eES5Pvf1OhJpkGbG3KsH3guTHY4ZSk7euqa40614C4F9QN
         tkM19RNPm5zaUQa4wqs8P/OnngCBlB9HNOnoOvx5NQvoZLoC6Q1YM3toDCaTVbY/hxlF
         gdZoV3peEJW6aiMsWI7zBpmdMN+7t2tdBi4bk9AIZeI9AL74euOBdX12OL5nAG+nvoel
         Ztyg==
X-Gm-Message-State: AOAM532HCgPViG8wjtRhezdUI5xzSGkiX/seMeHeh0u04prAmJtgLuvm
	wOQHYUxOmjpoSwFv3NdMz6EbQmoL6iskk8BN+OJMXDrXXykuTmmeVPkGDYu9qamnIFVictub3bW
	PlbVzeOayu2v1J2XxDEZE
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr25471491edd.126.1618827693632;
        Mon, 19 Apr 2021 03:21:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmgqAt375JQolL1odKMUOeY+mBAXFeiW3PyhYVPJipQltfTGdvih9swcKv5opSGIf6ZUpLaQ==
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr25471472edd.126.1618827693375;
        Mon, 19 Apr 2021 03:21:33 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id g11sm12241330edy.9.2021.04.19.03.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 03:21:32 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
To: Mike Rapoport <rppt@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
 <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
 <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
 <YH1X+0CMH/2yppHK@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0a957f9b-b4d7-869a-44ec-14e92a40d941@redhat.com>
Date: Mon, 19 Apr 2021 12:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH1X+0CMH/2yppHK@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: DVKOFBOKEHDZOOYUKIKT64GE2P2LNSGE
X-Message-ID-Hash: DVKOFBOKEHDZOOYUKIKT64GE2P2LNSGE
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DVKOFBOKEHDZOOYUKIKT64GE2P2LNSGE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjEgMTI6MTQsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIE1vbiwgQXByIDE5
LCAyMDIxIGF0IDExOjQwOjU2QU0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4g
T24gMTkuMDQuMjEgMTE6MzgsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+IE9uIDE5LjA0
LjIxIDExOjM2LCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+PiBPbiBNb24sIEFwciAxOSwgMjAy
MSBhdCAxMToxNTowMkFNICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4+IE9u
IDE5LjA0LjIxIDEwOjQyLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+Pj4+IEZyb206IE1pa2Ug
UmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IEtlcm5lbCB0ZXN0
IHJvYm90IHJlcG9ydGVkIC00LjIlIHJlZ3Jlc3Npb24gb2Ygd2lsbC1pdC1zY2FsZS5wZXJfdGhy
ZWFkX29wcw0KPj4+Pj4+IGR1ZSB0byBjb21taXQgIm1tOiBpbnRyb2R1Y2UgbWVtZmRfc2VjcmV0
IHN5c3RlbSBjYWxsIHRvIGNyZWF0ZSAic2VjcmV0Ig0KPj4+Pj4+IG1lbW9yeSBhcmVhcyIuDQo+
Pj4+Pj4NCj4+Pj4+PiBUaGUgcGVyZiBwcm9maWxlIG9mIHRoZSB0ZXN0IGluZGljYXRlZCB0aGF0
IHRoZSByZWdyZXNzaW9uIGlzIGNhdXNlZCBieQ0KPj4+Pj4+IHBhZ2VfaXNfc2VjcmV0bWVtKCkg
Y2FsbGVkIGZyb20gZ3VwX3B0ZV9yYW5nZSgpIChpbmxpbmVkIGJ5IGd1cF9wZ2RfcmFuZ2UpOg0K
Pj4+Pj4+DQo+Pj4+Pj4gICAgICAyNy43NiAgKzIuNSAgMzAuMjMgICAgICAgcGVyZi1wcm9maWxl
LmNoaWxkcmVuLmN5Y2xlcy1wcC5ndXBfcGdkX3JhbmdlDQo+Pj4+Pj4gICAgICAgMC4wMCAgKzMu
MiAgIDMuMTkgwrEgMiUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAucGFnZV9tYXBw
aW5nDQo+Pj4+Pj4gICAgICAgMC4wMCAgKzMuNyAgIDMuNjYgwrEgMiUgIHBlcmYtcHJvZmlsZS5j
aGlsZHJlbi5jeWNsZXMtcHAucGFnZV9pc19zZWNyZXRtZW0NCj4+Pj4+Pg0KPj4+Pj4+IEZ1cnRo
ZXIgYW5hbHlzaXMgc2hvd2VkIHRoYXQgdGhlIHNsb3cgZG93biBoYXBwZW5zIGJlY2F1c2UgbmVp
dGhlcg0KPj4+Pj4+IHBhZ2VfaXNfc2VjcmV0bWVtKCkgbm9yIHBhZ2VfbWFwcGluZygpIGFyZSBu
b3QgaW5saW5lIGFuZCBtb3Jlb3ZlciwNCj4+Pj4+PiBtdWx0aXBsZSBwYWdlIGZsYWdzIGNoZWNr
cyBpbiBwYWdlX21hcHBpbmcoKSBpbnZvbHZlIGNhbGxpbmcNCj4+Pj4+PiBjb21wb3VuZF9oZWFk
KCkgc2V2ZXJhbCB0aW1lcyBmb3IgdGhlIHNhbWUgcGFnZS4NCj4+Pj4+Pg0KPj4+Pj4+IE1ha2Ug
cGFnZV9pc19zZWNyZXRtZW0oKSBpbmxpbmUgYW5kIHJlcGxhY2UgcGFnZV9tYXBwaW5nKCkgd2l0
aCBwYWdlIGZsYWcNCj4+Pj4+PiBjaGVja3MgdGhhdCBkbyBub3QgaW1wbHkgcGFnZS10by1oZWFk
IGNvbnZlcnNpb24uDQo+Pj4+Pj4NCj4+Pj4+PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9i
b3QgPG9saXZlci5zYW5nQGludGVsLmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWtlIFJh
cG9wb3J0IDxycHB0QGxpbnV4LmlibS5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4NCj4+Pj4+PiBA
QW5kcmV3LA0KPj4+Pj4+IFRoZSBwYXRjaCBpcyB2cyB2NS4xMi1yYzctbW1vdHMtMjAyMS0wNC0x
NS0xNi0yOCwgSSdkIGFwcHJlY2lhdGUgaWYgaXQgd291bGQNCj4+Pj4+PiBiZSBhZGRlZCBhcyBh
IGZpeHVwIHRvIHRoZSBtZW1mZF9zZWNyZXQgc2VyaWVzLg0KPj4+Pj4+DQo+Pj4+Pj4gICAgICBp
bmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKy0N
Cj4+Pj4+PiAgICAgIG1tL3NlY3JldG1lbS5jICAgICAgICAgICAgfCAxMiArLS0tLS0tLS0tLS0N
Cj4+Pj4+PiAgICAgIDIgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zZWNyZXRt
ZW0uaCBiL2luY2x1ZGUvbGludXgvc2VjcmV0bWVtLmgNCj4+Pj4+PiBpbmRleCA5MDdhNjczNDA1
OWMuLmI4NDJiMzhjYmViMSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NlY3Jl
dG1lbS5oDQo+Pj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaA0KPj4+Pj4+IEBA
IC00LDggKzQsMzIgQEANCj4+Pj4+PiAgICAgICNpZmRlZiBDT05GSUdfU0VDUkVUTUVNDQo+Pj4+
Pj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHNlY3JldG1l
bV9hb3BzOw0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIGlubGluZSBib29sIHBhZ2VfaXNfc2Vj
cmV0bWVtKHN0cnVjdCBwYWdlICpwYWdlKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gKwlzdHJ1Y3QgYWRk
cmVzc19zcGFjZSAqbWFwcGluZzsNCj4+Pj4+PiArDQo+Pj4+Pj4gKwkvKg0KPj4+Pj4+ICsJICog
VXNpbmcgcGFnZV9tYXBwaW5nKCkgaXMgcXVpdGUgc2xvdyBiZWNhdXNlIG9mIHRoZSBhY3R1YWwg
Y2FsbA0KPj4+Pj4+ICsJICogaW5zdHJ1Y3Rpb24gYW5kIHJlcGVhdGVkIGNvbXBvdW5kX2hlYWQo
cGFnZSkgaW5zaWRlIHRoZQ0KPj4+Pj4+ICsJICogcGFnZV9tYXBwaW5nKCkgZnVuY3Rpb24uDQo+
Pj4+Pj4gKwkgKiBXZSBrbm93IHRoYXQgc2VjcmV0bWVtIHBhZ2VzIGFyZSBub3QgY29tcG91bmQg
YW5kIExSVSBzbyB3ZSBjYW4NCj4+Pj4+PiArCSAqIHNhdmUgYSBjb3VwbGUgb2YgY3ljbGVzIGhl
cmUuDQo+Pj4+Pj4gKwkgKi8NCj4+Pj4+PiArCWlmIChQYWdlQ29tcG91bmQocGFnZSkgfHwgIVBh
Z2VMUlUocGFnZSkpDQo+Pj4+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4+Pj4NCj4+Pj4+IEknZCBh
c3N1bWUgc2VjcmV0bWVtIHBhZ2VzIGFyZSByYXJlIGluIGJhc2ljYWxseSBldmVyeSBzZXR1cCBv
dXQgdGhlcmUuIFNvDQo+Pj4+PiBtYXliZSB0aHJvd2luZyBpbiBhIGNvdXBsZSBvZiBsaWtlbHko
KS91bmxpa2VseSgpIG1pZ2h0IG1ha2Ugc2Vuc2UuDQo+Pj4+DQo+Pj4+IEknZCBzYXkgd2UgY291
bGQgZG8gdW5saWtlbHkocGFnZV9pc19zZWNyZXRtZW0oKSkgYXQgY2FsbCBzaXRlcy4gSGVyZSBJ
IGNhbg0KPj4+PiBoYXJkbHkgZXN0aW1hdGUgd2hpY2ggcGFnZXMgYXJlIGdvaW5nIHRvIGJlIGNo
ZWNrZWQuDQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJbWFwcGluZyA9IChzdHJ1Y3QgYWRkcmVzc19zcGFj
ZSAqKQ0KPj4+Pj4+ICsJCSgodW5zaWduZWQgbG9uZylwYWdlLT5tYXBwaW5nICYgflBBR0VfTUFQ
UElOR19GTEFHUyk7DQo+Pj4+Pj4gKw0KPj4+Pj4NCj4+Pj4+IE5vdCBzdXJlIGlmIG9wZW4tY29k
aW5nIHBhZ2VfbWFwcGluZyBpcyByZWFsbHkgYSBnb29kIGlkZWEgaGVyZSAtLSBvciBldmVuDQo+
Pj4+PiBuZWNlc3NhcnkgYWZ0ZXIgdGhlIGZhc3QgcGF0aCBhYm92ZSBpcyBpbiBwbGFjZS4gQW55
aG93LCBqdXN0IG15IDIgY2VudHMuDQo+Pj4+DQo+Pj4+IFdlbGwsIG1vc3QgaWYgdGhlIC00LjIl
IG9mIHRoZSBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGtidWlsZCByZXBvcnRlZCB3ZXJlDQo+Pj4+
IGR1ZSB0byByZXBlYXRlZCBjb21wb3VudF9oZWFkKHBhZ2UpIGluIHBhZ2VfbWFwcGluZygpLiBT
byB0aGUgd2hvbGUgcG9pbnQNCj4+Pj4gb2YgdGhpcyBwYXRjaCBpcyB0byBhdm9pZCBjYWxsaW5n
IHBhZ2VfbWFwcGluZygpLg0KPj4+DQo+Pj4gSSB3b3VsZCBoYXZlIHRob3VnaHQgdGhlIGZhc3Qg
cGF0aCAiKFBhZ2VDb21wb3VuZChwYWdlKSB8fA0KPj4+ICFQYWdlTFJVKHBhZ2UpKSIgd291bGQg
YWxyZWFkeSBhdm9pZCBjYWxsaW5nIHBhZ2VfbWFwcGluZygpIGluIG1hbnkgY2FzZXMuDQo+Pg0K
Pj4gKGFuZCBJIGRvIHdvbmRlciBpZiBhIGdlbmVyaWMgcGFnZV9tYXBwaW5nKCkgb3B0aW1pemF0
aW9uIHdvdWxkIG1ha2Ugc2Vuc2UNCj4+IGluc3RlYWQpDQo+IA0KPiBOb3Qgc3VyZS4gUmVwbGFj
aW5nIHBhZ2VfbWFwcGluZygpIHdpdGggcGFnZV9maWxlX21hcHBpbmcoKSBhdCB0aGUNCj4gY2Fs
bCBzaXRlcyBhdCBmcy8gYW5kIG1tLyBpbmNyZWFzZWQgdGhlIGRlZmNvbmZpZyBpbWFnZSBieSBu
ZWFybHkgMmsNCj4gYW5kIHBhZ2VfZmlsZV9tYXBwaW5nKCkgaXMgd2F5IHNpbXBsZXIgdGhhbiBw
YWdlX21hcHBpbmcoKQ0KPiANCj4gYWRkL3JlbW92ZTogMS8wIGdyb3cvc2hyaW5rOiAzNS8wIHVw
L2Rvd246IDE5NjAvMCAoMTk2MCkNCj4gRnVuY3Rpb24gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgb2xkICAgICBuZXcgICBkZWx0YQ0KPiBzaHJpbmtfcGFnZV9saXN0ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDM0MTQgICAgMzY3MCAgICArMjU2DQo+IF9fc2V0X3BhZ2Vf
ZGlydHlfbm9idWZmZXJzICAgICAgICAgICAgICAgICAgIDI0MiAgICAgMzQ5ICAgICsxMDcNCj4g
Y2hlY2tfbW92ZV91bmV2aWN0YWJsZV9wYWdlcyAgICAgICAgICAgICAgICAgOTA0ICAgICA5ODcg
ICAgICs4Mw0KPiBtb3ZlX3RvX25ld19wYWdlICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1
OTEgICAgIDY3MSAgICAgKzgwDQo+IHNocmlua19hY3RpdmVfbGlzdCAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDkxMiAgICAgOTcwICAgICArNTgNCj4gbW92ZV9wYWdlc190b19scnUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOTExICAgICA5NjUgICAgICs1NA0KPiBtaWdyYXRlX3BhZ2Vz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI1MDAgICAgMjU1NCAgICAgKzU0DQo+IHNo
bWVtX3N3YXBpbl9wYWdlICAgICAgICAgICAgICAgICAgICAgICAgICAgMTE0NSAgICAxMTk3ICAg
ICArNTINCj4gc2htZW1fdW5kb19yYW5nZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAxNjY5
ICAgIDE3MTkgICAgICs1MA0KPiBfX3Rlc3Rfc2V0X3BhZ2Vfd3JpdGViYWNrICAgICAgICAgICAg
ICAgICAgICA2MjAgICAgIDY3MCAgICAgKzUwDQo+IF9fc2V0X3BhZ2VfZGlydHlfYnVmZmVycyAg
ICAgICAgICAgICAgICAgICAgIDE4NyAgICAgMjM3ICAgICArNTANCj4gX19wYWdldmVjX2xydV9h
ZGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgNzU3ICAgICA4MDcgICAgICs1MA0KPiBfX211
bmxvY2tfcGFnZXZlYyAgICAgICAgICAgICAgICAgICAgICAgICAgIDExNTUgICAgMTIwNSAgICAg
KzUwDQo+IF9fZHVtcF9wYWdlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTEwMSAg
ICAxMTUxICAgICArNTANCj4gX19jYW5jZWxfZGlydHlfcGFnZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgMTgyICAgICAyMzIgICAgICs1MA0KPiBfX3JlbW92ZV9tYXBwaW5nICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA0NjEgICAgIDUxMCAgICAgKzQ5DQo+IHJtYXBfd2Fsa19maWxlICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDQwMiAgICAgNDQ5ICAgICArNDcNCj4gaXNvbGF0
ZV9tb3ZhYmxlX3BhZ2UgICAgICAgICAgICAgICAgICAgICAgICAgMjQwICAgICAyODcgICAgICs0
Nw0KPiB0ZXN0X2NsZWFyX3BhZ2Vfd3JpdGViYWNrICAgICAgICAgICAgICAgICAgICA2NjggICAg
IDcxNCAgICAgKzQ2DQo+IHBhZ2VfY2FjaGVfcGlwZV9idWZfdHJ5X3N0ZWFsICAgICAgICAgICAg
ICAgIDE3MSAgICAgMjE3ICAgICArNDYNCj4gcGFnZV9lbmRpbyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMjQ2ICAgICAyOTAgICAgICs0NA0KPiBwYWdlX2ZpbGVfbWFwcGluZyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gICAgICA0MyAgICAgKzQzDQo+IF9faXNvbGF0
ZV9scnVfcGFnZV9wcmVwYXJlICAgICAgICAgICAgICAgICAgIDI1NCAgICAgMjk3ICAgICArNDMN
Cj4gaHVnZXRsYl9wYWdlX21hcHBpbmdfbG9ja193cml0ZSAgICAgICAgICAgICAgIDM5ICAgICAg
ODEgICAgICs0Mg0KPiBpb21hcF9zZXRfcGFnZV9kaXJ0eSAgICAgICAgICAgICAgICAgICAgICAg
ICAxMTAgICAgIDE1MSAgICAgKzQxDQo+IGNsZWFyX3BhZ2VfZGlydHlfZm9yX2lvICAgICAgICAg
ICAgICAgICAgICAgIDMyNCAgICAgMzY0ICAgICArNDANCj4gd2FpdF9vbl9wYWdlX3dyaXRlYmFj
a19raWxsYWJsZSAgICAgICAgICAgICAgMTE4ICAgICAxNTcgICAgICszOQ0KPiB3YWl0X29uX3Bh
Z2Vfd3JpdGViYWNrICAgICAgICAgICAgICAgICAgICAgICAxMDUgICAgIDE0NCAgICAgKzM5DQo+
IHNldF9wYWdlX2RpcnR5ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE1OSAgICAgMTk4
ICAgICArMzkNCj4gcHV0YmFja19tb3ZhYmxlX3BhZ2UgICAgICAgICAgICAgICAgICAgICAgICAg
IDMyICAgICAgNzEgICAgICszOQ0KPiBwYWdlX21rY2xlYW4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAxNzIgICAgIDIxMSAgICAgKzM5DQo+IG1hcmtfYnVmZmVyX2RpcnR5ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDE3NiAgICAgMjE1ICAgICArMzkNCj4gaW52YWxpZGF0ZV9p
bm9kZV9wYWdlICAgICAgICAgICAgICAgICAgICAgICAgMTIyICAgICAxNjEgICAgICszOQ0KPiBk
ZWxldGVfZnJvbV9wYWdlX2NhY2hlICAgICAgICAgICAgICAgICAgICAgICAxMzkgICAgIDE3OCAg
ICAgKzM5DQo+IFBhZ2VNb3ZhYmxlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA0
OSAgICAgIDg2ICAgICArMzcNCj4gaXNvbGF0ZV9taWdyYXRlcGFnZXNfYmxvY2sgICAgICAgICAg
ICAgICAgICAyODQzICAgIDI4NzIgICAgICsyOQ0KPiBUb3RhbDogQmVmb3JlPTE3MDY4NjQ4LCBB
ZnRlcj0xNzA3MDYwOCwgY2hnICswLjAxJQ0KPiAgIA0KPj4gV2lsbHkgY2FuIG1vc3QgcHJvYmFi
bHkgZ2l2ZSB0aGUgYmVzdCBhZHZpc2UgaGVyZSA6KQ0KPiANCj4gSSB0aGluayB0aGF0J3Mgd2hh
dCBmb2xpb3MgYXJlIGZvciA6KQ0KDQpFeGFjdGx5IG15IHRob3VnaHQuIDopDQoNCg0KLS0gDQpU
aGFua3MsDQoNCkRhdmlkIC8gZGhpbGRlbmINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
