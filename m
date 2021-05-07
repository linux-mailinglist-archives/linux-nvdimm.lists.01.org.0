Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED373376138
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 09:35:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5DFBB100EBB6C;
	Fri,  7 May 2021 00:35:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8808B100EC1CE
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 00:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620372951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRLhFcul/s0bAb0h6pwheuix10YVXJYp5em6Jk4RpTY=;
	b=LKQ8IWaBht40hQ37zGhiXWlx+x+Dj6an1dgqmq+UDQ3Msuggv1C2b3TezDAWLG/j28CUxx
	SYtxDjtmTeLa6lateTlt99a9Vpwn/iZBxnYdboXBfMzDsZa4lqARUwn76xIegra1nQR16K
	nHeDtHsZAN4JgiRXzfUjQ3eqptexoS4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-_XpjFp3MPeuTCe5aPY_g-w-1; Fri, 07 May 2021 03:35:49 -0400
X-MC-Unique: _XpjFp3MPeuTCe5aPY_g-w-1
Received: by mail-ed1-f71.google.com with SMTP id y17-20020a0564023591b02903886c26ada4so4008154edc.5
        for <linux-nvdimm@lists.01.org>; Fri, 07 May 2021 00:35:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YRLhFcul/s0bAb0h6pwheuix10YVXJYp5em6Jk4RpTY=;
        b=UMYqIcILtcDk5QtvrVxpFBcNGlPkUVsZPm29PpEBJk7fOqIn7opIiqIXp2j/nYpf0+
         XX9xc+1ov2THIZxG/Qo+CueMLwb6/l6UBVzs+bKlKjf8HbMf4buvgmfA2toHWgTf/TY8
         IS0OqoA6TVvxEnHgt4hnBwZJw/LUy++UUayIPIWVE/RcmFikZvCNkJjsjz22nENtEljT
         rYqfPBM5uoTSX/+EivABY7dEgNq4htFsgYFT0yywyCH3Gv822LHdYnY/XKo41Xul3/7j
         zCNx7YnaUcUpT720YbmL7Sa7rz/kFTdIP/6Uz45wlerOd5gENQPbcWIndq1tU67KdQVQ
         ZtzQ==
X-Gm-Message-State: AOAM530DjOUYcvkxFZEHjAeJoO8UmQ1+3W9suDE8syPb2NHIjiQlDihE
	GSMPpIEiEoM2bgZXs/s22JrFFFe1JDW3WfJYdfFz5qIoBw+VI4EbFUS4gMm6jZfXrkHy5gcsEHc
	u/+O1vnssh0w9TG+nvFdi
X-Received: by 2002:a17:907:174a:: with SMTP id lf10mr8861656ejc.433.1620372948567;
        Fri, 07 May 2021 00:35:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5XI2zKUbsKazvcW2Vr5jvMDeiB+dtOEKTtfzbIqz37aYae3i7ugq6B0OmfMhiabycSZroRA==
X-Received: by 2002:a17:907:174a:: with SMTP id lf10mr8861569ejc.433.1620372947917;
        Fri, 07 May 2021 00:35:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c63c0.dip0.t-ipconnect.de. [91.12.99.192])
        by smtp.gmail.com with ESMTPSA id l17sm2925176ejk.22.2021.05.07.00.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 00:35:47 -0700 (PDT)
To: Nick Kossifidis <mick@ics.forth.gr>, jejb@linux.ibm.com
References: <20210303162209.8609-1-rppt@kernel.org>
 <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
 <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
 <996dbc29-e79c-9c31-1e47-cbf20db2937d@redhat.com>
 <8eb933f921c9dfe4c9b1b304e8f8fa4fbc249d84.camel@linux.ibm.com>
 <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <5232c8a7-8a05-9d0f-69ff-3dba2b04e784@redhat.com>
Date: Fri, 7 May 2021 09:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <77fe28bd940b2c1afd69d65b6d349352@mailhost.ics.forth.gr>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: YVEGTZICHYOYEMIFN4HPMZJYMHRISCQQ
X-Message-ID-Hash: YVEGTZICHYOYEMIFN4HPMZJYMHRISCQQ
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah 
 Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YVEGTZICHYOYEMIFN4HPMZJYMHRISCQQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMDcuMDUuMjEgMDE6MTYsIE5pY2sgS29zc2lmaWRpcyB3cm90ZToNCj4gzqPPhM65z4IgMjAy
MS0wNS0wNiAyMDowNSwgSmFtZXMgQm90dG9tbGV5IM6tzrPPgc6xz4jOtToNCj4+IE9uIFRodSwg
MjAyMS0wNS0wNiBhdCAxODo0NSArMDIwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4N
Cj4+PiBBbHNvLCB0aGVyZSBpcyBhIHdheSB0byBzdGlsbCByZWFkIHRoYXQgbWVtb3J5IHdoZW4g
cm9vdCBieQ0KPj4+DQo+Pj4gMS4gSGF2aW5nIGtkdW1wIGFjdGl2ZSAod2hpY2ggd291bGQgb2Z0
ZW4gYmUgdGhlIGNhc2UsIGJ1dCBtYXliZSBub3QNCj4+PiB0byBkdW1wIHVzZXIgcGFnZXMgKQ0K
Pj4+IDIuIFRyaWdnZXJpbmcgYSBrZXJuZWwgY3Jhc2ggKGVhc3kgdmlhIHByb2MgYXMgcm9vdCkN
Cj4+PiAzLiBXYWl0aW5nIGZvciB0aGUgcmVib290IGFmdGVyIGt1bXAoKSBjcmVhdGVkIHRoZSBk
dW1wIGFuZCB0aGVuDQo+Pj4gcmVhZGluZyB0aGUgY29udGVudCBmcm9tIGRpc2suDQo+Pg0KPj4g
QW55dGhpbmcgdGhhdCBjYW4gbGVhdmUgcGh5c2ljYWwgbWVtb3J5IGludGFjdCBidXQgYm9vdCB0
byBhIGtlcm5lbA0KPj4gd2hlcmUgdGhlIG1pc3NpbmcgZGlyZWN0IG1hcCBlbnRyeSBpcyByZXN0
b3JlZCBjb3VsZCB0aGVvcmV0aWNhbGx5DQo+PiBleHRyYWN0IHRoZSBzZWNyZXQuICBIb3dldmVy
LCBpdCdzIG5vdCBleGFjdGx5IGdvaW5nIHRvIGJlIGEgc3RlYWx0aHkNCj4+IGV4dHJhY3Rpb24g
Li4uDQo+Pg0KPj4+IE9yLCBhcyBhbiBhdHRhY2tlciwgbG9hZCBhIGN1c3RvbSBrZXhlYygpIGtl
cm5lbCBhbmQgcmVhZCBtZW1vcnkNCj4+PiBmcm9tIHRoZSBuZXcgZW52aXJvbm1lbnQuIE9mIGNv
dXJzZSwgdGhlIGxhdHRlciB0d28gYXJlIGFkdmFuY2VkDQo+Pj4gbWVjaGFuaXNtcywgYnV0IHRo
ZXkgYXJlIHBvc3NpYmxlIHdoZW4gcm9vdC4gV2UgbWlnaHQgYmUgYWJsZSB0bw0KPj4+IG1pdGln
YXRlLCBmb3IgZXhhbXBsZSwgYnkgemVyb2luZyBvdXQgc2VjcmV0bWVtIHBhZ2VzIGJlZm9yZSBi
b290aW5nDQo+Pj4gaW50byB0aGUga2V4ZWMga2VybmVsLCBpZiB3ZSBjYXJlIDopDQo+Pg0KPj4g
SSB0aGluayB3ZSBjb3VsZCBoYW5kbGUgaXQgYnkgbWFya2luZyB0aGUgcmVnaW9uLCB5ZXMsIGFu
ZCBhIHplcm8gb24NCj4+IHNodXRkb3duIG1pZ2h0IGJlIHVzZWZ1bCAuLi4gaXQgd291bGQgcHJl
dmVudCBhbGwgd2FybSByZWJvb3QgdHlwZQ0KPj4gYXR0YWNrcy4NCj4+DQo+IA0KPiBJIGhhZCBz
aW1pbGFyIGNvbmNlcm5zIGFib3V0IHJlY292ZXJpbmcgc2VjcmV0cyB3aXRoIGtkdW1wLCBhbmQN
Cj4gY29uc2lkZXJlZCBjbGVhbmluZyB1cCBrZXlyaW5ncyBiZWZvcmUganVtcGluZyB0byB0aGUg
bmV3IGtlcm5lbC4gVGhlDQo+IHByb2JsZW0gaXMgd2UgY2FuJ3QgcHJvdmlkZSBndWFyYW50ZWVz
IGluIHRoYXQgY2FzZSwgb25jZSB0aGUga2VybmVsIGhhcw0KPiBjcmFzaGVkIGFuZCB3ZSBhcmUg
b24gb3VyIHdheSB0byBydW4gY3Jhc2hrZXJuZWwsIHdlIGNhbid0IGJlIHN1cmUgd2UNCj4gY2Fu
IHJlbGlhYmx5IHplcm8tb3V0IGFueXRoaW5nLCB0aGUgbW9yZSBjb2RlIHdlIGFkZCB0byB0aGF0
IHBhdGggdGhlDQoNCldlbGwsIEkgdGhpbmsgaXQgZGVwZW5kcy4gQXNzdW1lIHdlIGRvIHRoZSBm
b2xsb3dpbmcNCg0KMSkgWmVybyBvdXQgYW55IHNlY3JldG1lbSBwYWdlcyB3aGVuIGhhbmRpbmcg
dGhlbSBiYWNrIHRvIHRoZSBidWRkeS4gDQooYWx0ZXJuYXRpdmU6IGluaXRfb25fZnJlZT0xKSAt
LSBpZiBub3QgYWxyZWFkeSBkb25lLCBJIGRpZG4ndCBjaGVjayB0aGUgDQpjb2RlLg0KDQoyKSBP
biBrZHVtcCgpLCB6ZXJvIG91dCBhbGwgYWxsb2NhdGVkIHNlY3JldG1lbS4gSXQnZCBiZSBlYXNp
ZXIgaWYgd2UnZCANCmp1c3QgYWxsb2NhdGVkIGZyb20gYSBmaXhlZCBwaHlzaWNhbCBtZW1vcnkg
YXJlYTsgb3RoZXJ3aXNlIHdlIGhhdmUgdG8gDQp3YWxrIHByb2Nlc3MgcGFnZSB0YWJsZXMgb3Ig
dXNlIGEgUEZOIHdhbGtlci4gQW5kIHplcm9pbmcgb3V0IHNlY3JldG1lbSANCnBhZ2VzIHdpdGhv
dXQgYSBkaXJlY3QgbWFwcGluZyBpcyBhIGRpZmZlcmVudCBjaGFsbGVuZ2UuDQoNCk5vdywgZHVy
aW5nIDIpIGl0IGNhbiBoYXBwZW4gdGhhdA0KDQphKSBXZSBjcmFzaCBpbiBvdXIgY2xlYXJpbmcg
Y29kZSAoZS5nLiwgc29tZXRoaW5nIGlzIHNlcmlvdXNseSBtZXNzZWQgDQp1cCkgYW5kIGZhaWwg
dG8gc3RhcnQgdGhlIGtkdW1wIGtlcm5lbC4gVGhhdCdzIGFjdHVhbGx5IGdvb2QsIGluc3RlYWQg
b2YgDQpsZWFraW5nIGRhdGEgd2UgZmFpbCBoYXJkLg0KDQpiKSBXZSBkb24ndCBmaW5kIGFsbCBz
ZWNyZXRtZW0gcGFnZXMsIGZvciBleGFtcGxlLCBiZWNhdXNlIHByb2Nlc3MgcGFnZSANCnRhYmxl
cyBhcmUgbWVzc2VkIHVwIG9yIHNvbWV0aGluZyBtZXNzZWQgdXAgb3VyIG1lbW1hcCAoaWYgd2Un
ZCB1c2UgdGhhdCANCnRvIGlkZW50aWZ5IHNlY3JldG1lbSBwYWdlcyB2aWEgYSBQRk4gd2Fsa2Vy
IHNvbWVob3cpDQoNCg0KQnV0IGZvciB0aGUgc2ltcGxlIGNhc2VzIChlLmcuLCBtYWxpY2lvdXMg
cm9vdCB0cmllcyB0byBjcmFzaCB0aGUga2VybmVsIA0KdmlhIC9wcm9jL3N5c3JxLXRyaWdnZXIp
IGJvdGggYSkgYW5kIGIpIHdvdWxkbid0IGFwcGx5Lg0KDQpPYnZpb3VzbHksIGlmIGFuIGFkbWlu
IHdvdWxkIHdhbnQgdG8gbWl0aWdhdGUgcmlnaHQgbm93LCBoZSB3b3VsZCB3YW50IA0KdG8gZGlz
YWJsZSBrZHVtcCBjb21wbGV0ZWx5LCBtZWFuaW5nIGFueSBhdHRlbXB0IHRvIGxvYWQgYSBjcmFz
aGtlcm5lbCANCndvdWxkIGZhaWwgYW5kIGNhbm5vdCBiZSBlbmFibGVkIGFnYWluIGZvciB0aGF0
IGtlcm5lbCAoYWxzbyBub3QgdmlhIA0KY21kbGluZSBhbiBhdHRhY2tlciBjb3VsZCBtb2RpZnkg
dG8gcmVib290IGludG8gYSBzeXN0ZW0gd2l0aCB0aGUgb3B0aW9uIA0KZm9yIGEgY3Jhc2hrZXJu
ZWwpLiBEaXNhYmxpbmcga2R1bXAgaW4gdGhlIGtlcm5lbCB3aGVuIHNlY3JldG1lbSBwYWdlcyAN
CmFyZSBhbGxvY2F0ZWQgaXMgb25lIGFwcHJvYWNoLCBhbHRob3VnaCBzdWItb3B0aW1hbC4NCg0K
PiBtb3JlIHJpc2t5IGl0IGdldHMuIEhvd2V2ZXIgZHVyaW5nIHJlYm9vdC9ub3JtYWwga2V4ZWMo
KSB3ZSBzaG91bGQgZG8NCj4gc29tZSBjbGVhbnVwLCBpdCBtYWtlcyBzZW5zZSBhbmQgc2VjcmV0
bWVtIGNhbiBpbmRlZWQgYmUgdXNlZnVsIGluIHRoYXQNCj4gY2FzZS4gUmVnYXJkaW5nIGxvYWRp
bmcgY3VzdG9tIGtleGVjKCkga2VybmVscywgd2UgbWl0aWdhdGUgdGhpcyB3aXRoDQo+IHRoZSBr
ZXhlYyBmaWxlLWJhc2VkIEFQSSB3aGVyZSB3ZSBjYW4gdmVyaWZ5IHRoZSBzaWduYXR1cmUgb2Yg
dGhlIGxvYWRlZA0KPiBraW1hZ2UgKGFzc3VtaW5nIHRoZSBzeXN0ZW0gcnVucyBhIGtlcm5lbCBw
cm92aWRlZCBieSBhIHRydXN0ZWQgM3JkDQo+IHBhcnR5IGFuZCB3ZSAndmUgbWFpbnRhaW5lZCBh
IGNoYWluIG9mIHRydXN0IHNpbmNlIGJvb3RpbmcpLg0KDQpGb3IgZXhhbXBsZSBpbiBWTXMgKGxp
a2UgUUVNVSksIHdlIG9mdGVuIGRvbid0IGNsZWFyIHBoeXNpY2FsIG1lbW9yeSANCmR1cmluZyBh
IHJlYm9vdC4gU28gaWYgYW4gYXR0YWNrZXIgbWFuYWdlcyB0byBsb2FkIGEga2VybmVsIHRoYXQg
eW91IGNhbiANCnRyaWNrIGludG8gcmVhZGluZyByYW5kb20gcGh5c2ljYWwgbWVtb3J5IGFyZWFz
LCB3ZSBjYW4gbGVhayBzZWNyZXRtZW0gDQpkYXRhIEkgdGhpbmsuDQoNCkFuZCB0aGVyZSBtaWdo
dCBiZSB3YXlzIHRvIGFjaGlldmUgdGhhdCBqdXN0IHVzaW5nIHRoZSBjbWRsaW5lLCBub3QgDQpu
ZWNlc3NhcmlseSBsb2FkaW5nIGEgZGlmZmVyZW50IGtlcm5lbC4gRm9yIGV4YW1wbGUgaWYgeW91
IGxpbWl0IHRoZSANCmtlcm5lbCBmb290cHJpbnQgKCJtZW09MjU2TSIpIGFuZCBkaXNhYmxlIHN0
cmljdF9pb21lbV9jaGVja3MgDQooInN0cmljdF9pb21lbV9jaGVja3M9cmVsYXhlZCIpIHlvdSBj
YW4ganVzdCBleHRyYWN0IHRoYXQgbWVtb3J5IHZpYSANCi9kZXYvbWVtIGlmIEkgYW0gbm90IHdy
b25nLg0KDQpTbyBhcyBhbiBhdHRhY2tlciwgbW9kaWZ5IHRoZSAoZ3J1YikgY21kbGluZSB0byAi
bWVtPTI1Nk0gDQpzdHJpY3RfaW9tZW1fY2hlY2tzPXJlbGF4ZWQiLCByZWJvb3QsIGFuZCByZWFk
IGFsbCBtZW1vcnkgdmlhIC9kZXYvbWVtLiANCk9yIGxvYWQgYSBzaWduZWQga2V4ZWMga2VybmVs
IHdpdGggdGhhdCBjbWRsaW5lIGFuZCBib290IGludG8gaXQuDQoNCkludGVyZXN0aW5nIHByb2Js
ZW0gOikNCg0KLS0gDQpUaGFua3MsDQoNCkRhdmlkIC8gZGhpbGRlbmINCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxp
c3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
