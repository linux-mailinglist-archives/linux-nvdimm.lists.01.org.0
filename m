Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B9363EB2
	for <lists+linux-nvdimm@lfdr.de>; Mon, 19 Apr 2021 11:38:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E9ADF100EBB9C;
	Mon, 19 Apr 2021 02:38:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 585DD100EBB96
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618825125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9MP8cjbzcrX9DzJPJwd3PFnkP3wW8EZhTQvmYtyhYA=;
	b=aSUDHsDRby2E8EtiMp9TFt9+e2RJwj6hKsww3mBHOCtlhOGbyaosvAouc3JrEs1DNbJWON
	EF/Qap1ZmSbO6QBUcDDxI2vV+f6MqXq2u4l8A7R/M8tb0jNHhliMJ6NgP9zLiPJZ3HtpsF
	MH1zxYFTJqBDAoRV5oNkXijPSq6BdfY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-TW1-ETNWNpiDGOOJXrAWBw-1; Mon, 19 Apr 2021 05:38:44 -0400
X-MC-Unique: TW1-ETNWNpiDGOOJXrAWBw-1
Received: by mail-ed1-f71.google.com with SMTP id z3-20020a05640240c3b029037fb0c2bd3bso10949807edb.23
        for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=W9MP8cjbzcrX9DzJPJwd3PFnkP3wW8EZhTQvmYtyhYA=;
        b=M8MAPdboaJERBPFBygVl9XdW+k+YJPJFUdXOZF2YgCaa0mOyhs55TUWvefIA4SrOjf
         ighjyPxYKEb2hKgzG+ApgGaHMhsypuA+xwueWz2w1d7GjBtN4O3um6fGINUeD3K7VpPK
         oUXUivMZ03T/WSEXXkWxKXBHZtYdfXZRIWt/Q2Co2ILOXl+w86xcRjfMbNlnc2O3i+ai
         c1fMP9S9bFaN8pTpRozxWDE/yHPQIeo8xM8cSj9Wg11EP9fP+IcqnUjZzYkSuIxmTQMW
         nMO43I2xlAQNtUPUNXY3wnXjZjO7m7Cih/Ey9lK5cq1xASblUHXXh6Gouz5TCrKRFsgB
         RBTQ==
X-Gm-Message-State: AOAM531YzOcOiI8jfEvI9Ec392mO1717saEOQITxF3lScO94JjWJiZYK
	i4mRpGgnncn7GCHIIiuHqWoFRtSzoxFW9B8h9of7Hz6ynwWPNcJDgBF3TgUMs+0i1ZMuLUx+Cex
	zdAIuJlAooStFJtFSezz8
X-Received: by 2002:a17:906:98d6:: with SMTP id zd22mr16697383ejb.17.1618825122874;
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGQ30kMI3cddajeZS/U8PQuAuuPoix56tOatD7f6VV3+y8LgKZjvgSrEGol9OdxIgtH/QwWg==
X-Received: by 2002:a17:906:98d6:: with SMTP id zd22mr16697331ejb.17.1618825122657;
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id x7sm11903755eds.67.2021.04.19.02.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:38:42 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
To: Mike Rapoport <rppt@kernel.org>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Date: Mon, 19 Apr 2021 11:38:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH1PE4oWeicpJT9g@kernel.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: JVPDSC6CCRETM3KYAFE6G6YX4VM2OVUN
X-Message-ID-Hash: JVPDSC6CCRETM3KYAFE6G6YX4VM2OVUN
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, S
 huah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, kernel test robot <oliver.sang@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JVPDSC6CCRETM3KYAFE6G6YX4VM2OVUN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTkuMDQuMjEgMTE6MzYsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIE1vbiwgQXByIDE5
LCAyMDIxIGF0IDExOjE1OjAyQU0gKzAyMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4g
T24gMTkuMDQuMjEgMTA6NDIsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4gRnJvbTogTWlrZSBS
YXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPj4+DQo+Pj4gS2VybmVsIHRlc3Qgcm9ib3Qg
cmVwb3J0ZWQgLTQuMiUgcmVncmVzc2lvbiBvZiB3aWxsLWl0LXNjYWxlLnBlcl90aHJlYWRfb3Bz
DQo+Pj4gZHVlIHRvIGNvbW1pdCAibW06IGludHJvZHVjZSBtZW1mZF9zZWNyZXQgc3lzdGVtIGNh
bGwgdG8gY3JlYXRlICJzZWNyZXQiDQo+Pj4gbWVtb3J5IGFyZWFzIi4NCj4+Pg0KPj4+IFRoZSBw
ZXJmIHByb2ZpbGUgb2YgdGhlIHRlc3QgaW5kaWNhdGVkIHRoYXQgdGhlIHJlZ3Jlc3Npb24gaXMg
Y2F1c2VkIGJ5DQo+Pj4gcGFnZV9pc19zZWNyZXRtZW0oKSBjYWxsZWQgZnJvbSBndXBfcHRlX3Jh
bmdlKCkgKGlubGluZWQgYnkgZ3VwX3BnZF9yYW5nZSk6DQo+Pj4NCj4+PiAgICAyNy43NiAgKzIu
NSAgMzAuMjMgICAgICAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5ndXBfcGdkX3Jh
bmdlDQo+Pj4gICAgIDAuMDAgICszLjIgICAzLjE5IMKxIDIlICBwZXJmLXByb2ZpbGUuY2hpbGRy
ZW4uY3ljbGVzLXBwLnBhZ2VfbWFwcGluZw0KPj4+ICAgICAwLjAwICArMy43ICAgMy42NiDCsSAy
JSAgcGVyZi1wcm9maWxlLmNoaWxkcmVuLmN5Y2xlcy1wcC5wYWdlX2lzX3NlY3JldG1lbQ0KPj4+
DQo+Pj4gRnVydGhlciBhbmFseXNpcyBzaG93ZWQgdGhhdCB0aGUgc2xvdyBkb3duIGhhcHBlbnMg
YmVjYXVzZSBuZWl0aGVyDQo+Pj4gcGFnZV9pc19zZWNyZXRtZW0oKSBub3IgcGFnZV9tYXBwaW5n
KCkgYXJlIG5vdCBpbmxpbmUgYW5kIG1vcmVvdmVyLA0KPj4+IG11bHRpcGxlIHBhZ2UgZmxhZ3Mg
Y2hlY2tzIGluIHBhZ2VfbWFwcGluZygpIGludm9sdmUgY2FsbGluZw0KPj4+IGNvbXBvdW5kX2hl
YWQoKSBzZXZlcmFsIHRpbWVzIGZvciB0aGUgc2FtZSBwYWdlLg0KPj4+DQo+Pj4gTWFrZSBwYWdl
X2lzX3NlY3JldG1lbSgpIGlubGluZSBhbmQgcmVwbGFjZSBwYWdlX21hcHBpbmcoKSB3aXRoIHBh
Z2UgZmxhZw0KPj4+IGNoZWNrcyB0aGF0IGRvIG5vdCBpbXBseSBwYWdlLXRvLWhlYWQgY29udmVy
c2lvbi4NCj4+Pg0KPj4+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNh
bmdAaW50ZWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGlu
dXguaWJtLmNvbT4NCj4+PiAtLS0NCj4+Pg0KPj4+IEBBbmRyZXcsDQo+Pj4gVGhlIHBhdGNoIGlz
IHZzIHY1LjEyLXJjNy1tbW90cy0yMDIxLTA0LTE1LTE2LTI4LCBJJ2QgYXBwcmVjaWF0ZSBpZiBp
dCB3b3VsZA0KPj4+IGJlIGFkZGVkIGFzIGEgZml4dXAgdG8gdGhlIG1lbWZkX3NlY3JldCBzZXJp
ZXMuDQo+Pj4NCj4+PiAgICBpbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oIHwgMjYgKysrKysrKysr
KysrKysrKysrKysrKysrKy0NCj4+PiAgICBtbS9zZWNyZXRtZW0uYyAgICAgICAgICAgIHwgMTIg
Ky0tLS0tLS0tLS0tDQo+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAx
MiBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlY3Jl
dG1lbS5oIGIvaW5jbHVkZS9saW51eC9zZWNyZXRtZW0uaA0KPj4+IGluZGV4IDkwN2E2NzM0MDU5
Yy4uYjg0MmIzOGNiZWIxIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvc2VjcmV0bWVt
LmgNCj4+PiArKysgYi9pbmNsdWRlL2xpbnV4L3NlY3JldG1lbS5oDQo+Pj4gQEAgLTQsOCArNCwz
MiBAQA0KPj4+ICAgICNpZmRlZiBDT05GSUdfU0VDUkVUTUVNDQo+Pj4gK2V4dGVybiBjb25zdCBz
dHJ1Y3QgYWRkcmVzc19zcGFjZV9vcGVyYXRpb25zIHNlY3JldG1lbV9hb3BzOw0KPj4+ICsNCj4+
PiArc3RhdGljIGlubGluZSBib29sIHBhZ2VfaXNfc2VjcmV0bWVtKHN0cnVjdCBwYWdlICpwYWdl
KQ0KPj4+ICt7DQo+Pj4gKwlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZzsNCj4+PiArDQo+
Pj4gKwkvKg0KPj4+ICsJICogVXNpbmcgcGFnZV9tYXBwaW5nKCkgaXMgcXVpdGUgc2xvdyBiZWNh
dXNlIG9mIHRoZSBhY3R1YWwgY2FsbA0KPj4+ICsJICogaW5zdHJ1Y3Rpb24gYW5kIHJlcGVhdGVk
IGNvbXBvdW5kX2hlYWQocGFnZSkgaW5zaWRlIHRoZQ0KPj4+ICsJICogcGFnZV9tYXBwaW5nKCkg
ZnVuY3Rpb24uDQo+Pj4gKwkgKiBXZSBrbm93IHRoYXQgc2VjcmV0bWVtIHBhZ2VzIGFyZSBub3Qg
Y29tcG91bmQgYW5kIExSVSBzbyB3ZSBjYW4NCj4+PiArCSAqIHNhdmUgYSBjb3VwbGUgb2YgY3lj
bGVzIGhlcmUuDQo+Pj4gKwkgKi8NCj4+PiArCWlmIChQYWdlQ29tcG91bmQocGFnZSkgfHwgIVBh
Z2VMUlUocGFnZSkpDQo+Pj4gKwkJcmV0dXJuIGZhbHNlOw0KPj4NCj4+IEknZCBhc3N1bWUgc2Vj
cmV0bWVtIHBhZ2VzIGFyZSByYXJlIGluIGJhc2ljYWxseSBldmVyeSBzZXR1cCBvdXQgdGhlcmUu
IFNvDQo+PiBtYXliZSB0aHJvd2luZyBpbiBhIGNvdXBsZSBvZiBsaWtlbHkoKS91bmxpa2VseSgp
IG1pZ2h0IG1ha2Ugc2Vuc2UuDQo+IA0KPiBJJ2Qgc2F5IHdlIGNvdWxkIGRvIHVubGlrZWx5KHBh
Z2VfaXNfc2VjcmV0bWVtKCkpIGF0IGNhbGwgc2l0ZXMuIEhlcmUgSSBjYW4NCj4gaGFyZGx5IGVz
dGltYXRlIHdoaWNoIHBhZ2VzIGFyZSBnb2luZyB0byBiZSBjaGVja2VkLg0KPiAgIA0KPj4+ICsN
Cj4+PiArCW1hcHBpbmcgPSAoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKikNCj4+PiArCQkoKHVuc2ln
bmVkIGxvbmcpcGFnZS0+bWFwcGluZyAmIH5QQUdFX01BUFBJTkdfRkxBR1MpOw0KPj4+ICsNCj4+
DQo+PiBOb3Qgc3VyZSBpZiBvcGVuLWNvZGluZyBwYWdlX21hcHBpbmcgaXMgcmVhbGx5IGEgZ29v
ZCBpZGVhIGhlcmUgLS0gb3IgZXZlbg0KPj4gbmVjZXNzYXJ5IGFmdGVyIHRoZSBmYXN0IHBhdGgg
YWJvdmUgaXMgaW4gcGxhY2UuIEFueWhvdywganVzdCBteSAyIGNlbnRzLg0KPiANCj4gV2VsbCwg
bW9zdCBpZiB0aGUgLTQuMiUgb2YgdGhlIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24ga2J1aWxkIHJl
cG9ydGVkIHdlcmUNCj4gZHVlIHRvIHJlcGVhdGVkIGNvbXBvdW50X2hlYWQocGFnZSkgaW4gcGFn
ZV9tYXBwaW5nKCkuIFNvIHRoZSB3aG9sZSBwb2ludA0KPiBvZiB0aGlzIHBhdGNoIGlzIHRvIGF2
b2lkIGNhbGxpbmcgcGFnZV9tYXBwaW5nKCkuDQoNCkkgd291bGQgaGF2ZSB0aG91Z2h0IHRoZSBm
YXN0IHBhdGggIihQYWdlQ29tcG91bmQocGFnZSkgfHwgDQohUGFnZUxSVShwYWdlKSkiIHdvdWxk
IGFscmVhZHkgYXZvaWQgY2FsbGluZyBwYWdlX21hcHBpbmcoKSBpbiBtYW55IGNhc2VzLg0KDQoN
Ci0tIA0KVGhhbmtzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
