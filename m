Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E341363EF6
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 11:41:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 321AA100EBB9C;
	Mon, 19 Apr 2021 02:41:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B196A100EC1D7
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618825263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeFgKAw6h+mPcXVcc4bWq1BMFLAt/JiFop1ZWmN9P3g=;
	b=Fo1MzPCYUnfH2D4cj+J+HG/HlVOBvTpeMndh55P/z0+dKJaVACsCQCexAXYGQbpMNhF3oD
	Fz6tv4CXT2mVBxCjl+9OmVN5YOjfTJoxml4YinluMqBJlOqE10HYnGItSaAKUYVF3gsnQN
	txu/aOC6/53DtHtWS3Et+0zDK0H2sKQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-HS9rz9BlOv6OkPQfXMPFUw-1; Mon, 19 Apr 2021 05:41:00 -0400
X-MC-Unique: HS9rz9BlOv6OkPQfXMPFUw-1
Received: by mail-ej1-f69.google.com with SMTP id f15-20020a170906738fb029037c94426fffso3445072ejl.22
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GeFgKAw6h+mPcXVcc4bWq1BMFLAt/JiFop1ZWmN9P3g=;
        b=UwYFCaJDEGkOX8GC8tzMXnsApjdbxTXMnOPILUvKXZWwf9NyERwim2AeXikJU9KwGm
         iMcMyhJ/lGZc/ScQKUTD4M488LV1Ej8LWa//Fd5lnLpwO0G6urVcgrdDgMuEzBklgpx9
         TD+pXWFsoAbhkBzWYkC5ym+IwfhYZWc93DpcCcqDsX6KHP4ax6nuaSzB333yThiE5OFL
         HXeuaUc9egs0sBKRhdYBX8TpdXWqOnz1sHdMBanUCAK//maQdjbZjXx1uFlKBe9qDUXa
         GkUCE7IuuoaHV/vux1mFm4eqzbroqjSzbrw8g6H0KL/xECDA733NmRwSOFh56M91vtmW
         f6sw==
X-Gm-Message-State: AOAM53001XCrfYz9O8qq4UAUXMaJ7aTM/MLH0FySPpw7TE2s43Vtrqjz
	rDH6tU+u22epQ/mNoslbpTFm+i4/IUrsE8UOGK4ZLHnmzKrbsv5wzgbId3QP6Hqdpwbe2RnyOdK
	HXPaN0OqlYm+qa6AeW+cI
X-Received: by 2002:aa7:dcd3:: with SMTP id w19mr404796edu.157.1618825258844;
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUep/F2sYsfc/GbdpC874xEruErysvjZiJSGRDsYz4g5yz9xbr6J9pJm9MKGKGsnTSZWCpUQ==
X-Received: by 2002:aa7:dcd3:: with SMTP id w19mr404773edu.157.1618825258627;
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id b6sm1276048edd.18.2021.04.19.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
From: David Hildenbrand <david@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
 <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Organization: Red Hat
Message-ID: <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
Date: Mon, 19 Apr 2021 11:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: UKTZ3WBQKSB2WXXOOQKHT3YOYVAULOFA
X-Message-ID-Hash: UKTZ3WBQKSB2WXXOOQKHT3YOYVAULOFA
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UKTZ3WBQKSB2WXXOOQKHT3YOYVAULOFA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjEgMTE6MzgsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiBPbiAxOS4wNC4y
MSAxMTozNiwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4+IE9uIE1vbiwgQXByIDE5LCAyMDIxIGF0
IDExOjE1OjAyQU0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+IE9uIDE5LjA0
LjIxIDEwOjQyLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+PiBGcm9tOiBNaWtlIFJhcG9wb3J0
IDxycHB0QGxpbnV4LmlibS5jb20+DQo+Pj4+DQo+Pj4+IEtlcm5lbCB0ZXN0IHJvYm90IHJlcG9y
dGVkIC00LjIlIHJlZ3Jlc3Npb24gb2Ygd2lsbC1pdC1zY2FsZS5wZXJfdGhyZWFkX29wcw0KPj4+
PiBkdWUgdG8gY29tbWl0ICJtbTogaW50cm9kdWNlIG1lbWZkX3NlY3JldCBzeXN0ZW0gY2FsbCB0
byBjcmVhdGUgInNlY3JldCINCj4+Pj4gbWVtb3J5IGFyZWFzIi4NCj4+Pj4NCj4+Pj4gVGhlIHBl
cmYgcHJvZmlsZSBvZiB0aGUgdGVzdCBpbmRpY2F0ZWQgdGhhdCB0aGUgcmVncmVzc2lvbiBpcyBj
YXVzZWQgYnkNCj4+Pj4gcGFnZV9pc19zZWNyZXRtZW0oKSBjYWxsZWQgZnJvbSBndXBfcHRlX3Jh
bmdlKCkgKGlubGluZWQgYnkgZ3VwX3BnZF9yYW5nZSk6DQo+Pj4+DQo+Pj4+ICAgICAyNy43NiAg
KzIuNSAgMzAuMjMgICAgICAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5ndXBfcGdk
X3JhbmdlDQo+Pj4+ICAgICAgMC4wMCAgKzMuMiAgIDMuMTkgwrEgMiUgIHBlcmYtcHJvZmlsZS5j
aGlsZHJlbi5jeWNsZXMtcHAucGFnZV9tYXBwaW5nDQo+Pj4+ICAgICAgMC4wMCAgKzMuNyAgIDMu
NjYgwrEgMiUgIHBlcmYtcHJvZmlsZS5jaGlsZHJlbi5jeWNsZXMtcHAucGFnZV9pc19zZWNyZXRt
ZW0NCj4+Pj4NCj4+Pj4gRnVydGhlciBhbmFseXNpcyBzaG93ZWQgdGhhdCB0aGUgc2xvdyBkb3du
IGhhcHBlbnMgYmVjYXVzZSBuZWl0aGVyDQo+Pj4+IHBhZ2VfaXNfc2VjcmV0bWVtKCkgbm9yIHBh
Z2VfbWFwcGluZygpIGFyZSBub3QgaW5saW5lIGFuZCBtb3Jlb3ZlciwNCj4+Pj4gbXVsdGlwbGUg
cGFnZSBmbGFncyBjaGVja3MgaW4gcGFnZV9tYXBwaW5nKCkgaW52b2x2ZSBjYWxsaW5nDQo+Pj4+
IGNvbXBvdW5kX2hlYWQoKSBzZXZlcmFsIHRpbWVzIGZvciB0aGUgc2FtZSBwYWdlLg0KPj4+Pg0K
Pj4+PiBNYWtlIHBhZ2VfaXNfc2VjcmV0bWVtKCkgaW5saW5lIGFuZCByZXBsYWNlIHBhZ2VfbWFw
cGluZygpIHdpdGggcGFnZSBmbGFnDQo+Pj4+IGNoZWNrcyB0aGF0IGRvIG5vdCBpbXBseSBwYWdl
LXRvLWhlYWQgY29udmVyc2lvbi4NCj4+Pj4NCj4+Pj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0
IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pa2Ug
UmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+DQo+Pj4+IEBBbmRy
ZXcsDQo+Pj4+IFRoZSBwYXRjaCBpcyB2cyB2NS4xMi1yYzctbW1vdHMtMjAyMS0wNC0xNS0xNi0y
OCwgSSdkIGFwcHJlY2lhdGUgaWYgaXQgd291bGQNCj4+Pj4gYmUgYWRkZWQgYXMgYSBmaXh1cCB0
byB0aGUgbWVtZmRfc2VjcmV0IHNlcmllcy4NCj4+Pj4NCj4+Pj4gICAgIGluY2x1ZGUvbGludXgv
c2VjcmV0bWVtLmggfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgICAgbW0v
c2VjcmV0bWVtLmMgICAgICAgICAgICB8IDEyICstLS0tLS0tLS0tLQ0KPj4+PiAgICAgMiBmaWxl
cyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2VjcmV0bWVtLmggYi9pbmNsdWRlL2xpbnV4L3Nl
Y3JldG1lbS5oDQo+Pj4+IGluZGV4IDkwN2E2NzM0MDU5Yy4uYjg0MmIzOGNiZWIxIDEwMDY0NA0K
Pj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUv
bGludXgvc2VjcmV0bWVtLmgNCj4+Pj4gQEAgLTQsOCArNCwzMiBAQA0KPj4+PiAgICAgI2lmZGVm
IENPTkZJR19TRUNSRVRNRU0NCj4+Pj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgYWRkcmVzc19zcGFj
ZV9vcGVyYXRpb25zIHNlY3JldG1lbV9hb3BzOw0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgaW5saW5l
IGJvb2wgcGFnZV9pc19zZWNyZXRtZW0oc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4+ICt7DQo+Pj4+
ICsJc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmc7DQo+Pj4+ICsNCj4+Pj4gKwkvKg0KPj4+
PiArCSAqIFVzaW5nIHBhZ2VfbWFwcGluZygpIGlzIHF1aXRlIHNsb3cgYmVjYXVzZSBvZiB0aGUg
YWN0dWFsIGNhbGwNCj4+Pj4gKwkgKiBpbnN0cnVjdGlvbiBhbmQgcmVwZWF0ZWQgY29tcG91bmRf
aGVhZChwYWdlKSBpbnNpZGUgdGhlDQo+Pj4+ICsJICogcGFnZV9tYXBwaW5nKCkgZnVuY3Rpb24u
DQo+Pj4+ICsJICogV2Uga25vdyB0aGF0IHNlY3JldG1lbSBwYWdlcyBhcmUgbm90IGNvbXBvdW5k
IGFuZCBMUlUgc28gd2UgY2FuDQo+Pj4+ICsJICogc2F2ZSBhIGNvdXBsZSBvZiBjeWNsZXMgaGVy
ZS4NCj4+Pj4gKwkgKi8NCj4+Pj4gKwlpZiAoUGFnZUNvbXBvdW5kKHBhZ2UpIHx8ICFQYWdlTFJV
KHBhZ2UpKQ0KPj4+PiArCQlyZXR1cm4gZmFsc2U7DQo+Pj4NCj4+PiBJJ2QgYXNzdW1lIHNlY3Jl
dG1lbSBwYWdlcyBhcmUgcmFyZSBpbiBiYXNpY2FsbHkgZXZlcnkgc2V0dXAgb3V0IHRoZXJlLiBT
bw0KPj4+IG1heWJlIHRocm93aW5nIGluIGEgY291cGxlIG9mIGxpa2VseSgpL3VubGlrZWx5KCkg
bWlnaHQgbWFrZSBzZW5zZS4NCj4+DQo+PiBJJ2Qgc2F5IHdlIGNvdWxkIGRvIHVubGlrZWx5KHBh
Z2VfaXNfc2VjcmV0bWVtKCkpIGF0IGNhbGwgc2l0ZXMuIEhlcmUgSSBjYW4NCj4+IGhhcmRseSBl
c3RpbWF0ZSB3aGljaCBwYWdlcyBhcmUgZ29pbmcgdG8gYmUgY2hlY2tlZC4NCj4+ICAgIA0KPj4+
PiArDQo+Pj4+ICsJbWFwcGluZyA9IChzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqKQ0KPj4+PiArCQko
KHVuc2lnbmVkIGxvbmcpcGFnZS0+bWFwcGluZyAmIH5QQUdFX01BUFBJTkdfRkxBR1MpOw0KPj4+
PiArDQo+Pj4NCj4+PiBOb3Qgc3VyZSBpZiBvcGVuLWNvZGluZyBwYWdlX21hcHBpbmcgaXMgcmVh
bGx5IGEgZ29vZCBpZGVhIGhlcmUgLS0gb3IgZXZlbg0KPj4+IG5lY2Vzc2FyeSBhZnRlciB0aGUg
ZmFzdCBwYXRoIGFib3ZlIGlzIGluIHBsYWNlLiBBbnlob3csIGp1c3QgbXkgMiBjZW50cy4NCj4+
DQo+PiBXZWxsLCBtb3N0IGlmIHRoZSAtNC4yJSBvZiB0aGUgcGVyZm9ybWFuY2UgcmVncmVzc2lv
biBrYnVpbGQgcmVwb3J0ZWQgd2VyZQ0KPj4gZHVlIHRvIHJlcGVhdGVkIGNvbXBvdW50X2hlYWQo
cGFnZSkgaW4gcGFnZV9tYXBwaW5nKCkuIFNvIHRoZSB3aG9sZSBwb2ludA0KPj4gb2YgdGhpcyBw
YXRjaCBpcyB0byBhdm9pZCBjYWxsaW5nIHBhZ2VfbWFwcGluZygpLg0KPiANCj4gSSB3b3VsZCBo
YXZlIHRob3VnaHQgdGhlIGZhc3QgcGF0aCAiKFBhZ2VDb21wb3VuZChwYWdlKSB8fA0KPiAhUGFn
ZUxSVShwYWdlKSkiIHdvdWxkIGFscmVhZHkgYXZvaWQgY2FsbGluZyBwYWdlX21hcHBpbmcoKSBp
biBtYW55IGNhc2VzLg0KDQooYW5kIEkgZG8gd29uZGVyIGlmIGEgZ2VuZXJpYyBwYWdlX21hcHBp
bmcoKSBvcHRpbWl6YXRpb24gd291bGQgbWFrZSANCnNlbnNlIGluc3RlYWQpDQoNCldpbGx5IGNh
biBtb3N0IHByb2JhYmx5IGdpdmUgdGhlIGJlc3QgYWR2aXNlIGhlcmUgOikNCg0KLS0gDQpUaGFu
a3MsDQoNCkRhdmlkIC8gZGhpbGRlbmINCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1t
QGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGlt
bS1sZWF2ZUBsaXN0cy4wMS5vcmcK
