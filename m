Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7183C31AFEF
	for <lists+linux-nvdimm@lfdr.de>; Sun, 14 Feb 2021 10:59:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41BF1100ED49C;
	Sun, 14 Feb 2021 01:59:08 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 15F5D100EF27B
	for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 01:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1613296738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zp3fh8bmhevQAw8R7MoL8KMwwdmbqk0SnEL9PkDxXR0=;
	b=e6JrFeo3sp9c8uMSHumSFcXiOg2Y5C+DP024UY9ZqInFzewvo7EhUIGOvYLRqIrUwDqSbg
	BjYMJZ6J5dZYZ+wldLZ1ntJrPWorGGtE8GIF2mMik+yZ7Y1AynABUnC5swavwQcNoIcgeM
	VD7AfJFBQazqg2mM+/F/ElLIzESXlmk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-oC-utK8mPEueHeGcNbTh9A-1; Sun, 14 Feb 2021 04:58:54 -0500
X-MC-Unique: oC-utK8mPEueHeGcNbTh9A-1
Received: by mail-wr1-f72.google.com with SMTP id d7so6188072wri.23
        for <linux-nvdimm@lists.01.org>; Sun, 14 Feb 2021 01:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FB1Zi7Y2SkOv/JvlFfpIv8DdC9H5NuowZUsuUzsgYnw=;
        b=S7Kl3u0u6KrHi78F5G+677VurKJ2uQ0W+DZHJ7KNi3QARja4xvukQqkxFETq6bj8zL
         4EJg9VIooOfwU/1RdJXbsKlUQdOM9K0oFhUWKgnEFcp5zNMwBjGWgRU7WaM0cf0Rk2xs
         PbMjj+/Q3fktpjNO+yN7ZWGxq+ePIOR7tGUJltKUxVtBhQFcyabPfrLWlA8WWTBccysy
         ElmOWjkYLqQSShlSj3pWki554yWtFiYeWerNN28S4QSg7M17XliKYP47zf5Dm+kV6qcx
         o0OAjo1cFmBnI/4gkeI2q8E5dg01Hb6zIeSc2NdkUpvBg+kX9M38nDrauVRQF16JijCk
         agrQ==
X-Gm-Message-State: AOAM533csRCQ2dz9zg87r+TL4fg5azklMtZTzkULamzw4gkH5Oya2McW
	9TC75IpXpEgB8fvDvTSEM7mqmD3WjYiZKwLtZq+nApcfhA/nDcYk8Jnk+eWsCCgLwalFjxRjych
	VXWUcZ+6TS4FpMxL89qew
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr9687121wmk.163.1613296733126;
        Sun, 14 Feb 2021 01:58:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6AiGKsLxdVOEv3lcfmH3b0B76nApmRsRYcgYL0hyAbXvIT8wdTN/HlT3/mJBi3lug6LzkMg==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr9687058wmk.163.1613296732697;
        Sun, 14 Feb 2021 01:58:52 -0800 (PST)
Received: from [192.168.3.108] (p4ff23363.dip0.t-ipconnect.de. [79.242.51.99])
        by smtp.gmail.com with ESMTPSA id x15sm18554557wro.66.2021.02.14.01.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Feb 2021 01:58:52 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to create "secret" memory areas
Date: Sun, 14 Feb 2021 10:58:44 +0100
Message-Id: <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
References: <20210214091954.GM242749@kernel.org>
In-Reply-To: <20210214091954.GM242749@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18D52)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: QSSNBB5LJMXQSKZF5WFASGTUHYQTHOLR
X-Message-ID-Hash: QSSNBB5LJMXQSKZF5WFASGTUHYQTHOLR
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleix
 ner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QSSNBB5LJMXQSKZF5WFASGTUHYQTHOLR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IEFtIDE0LjAyLjIwMjEgdW0gMTA6MjAgc2NocmllYiBNaWtlIFJhcG9wb3J0IDxycHB0QGtl
cm5lbC5vcmc+Og0KPiANCj4g77u/T24gRnJpLCBGZWIgMTIsIDIwMjEgYXQgMTA6MTg6MTlBTSAr
MDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4gT24gMTIuMDIuMjEgMDA6MDksIE1p
a2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4gT24gVGh1LCBGZWIgMTEsIDIwMjEgYXQgMDE6MDc6MTBQ
TSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4+IE9uIDExLjAyLjIxIDEyOjI3
LCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+Pj4gT24gVGh1LCBGZWIgMTEsIDIwMjEgYXQgMTA6
MDE6MzJBTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4+IA0KPj4+PiBTbyBs
ZXQncyB0YWxrIGFib3V0IHRoZSBtYWluIHVzZXItdmlzaWJsZSBkaWZmZXJlbmNlcyB0byBvdGhl
ciBtZW1mZCBmaWxlcw0KPj4+PiAoZXNwZWNpYWxseSwgb3RoZXIgcHVyZWx5IHZpcnR1YWwgZmls
ZXMgbGlrZSBodWdldGxiZnMpLiBXaXRoIHNlY3JldG1lbToNCj4+Pj4gDQo+Pj4+IC0gRmlsZSBj
b250ZW50IGNhbiBvbmx5IGJlIHJlYWQvd3JpdHRlbiB2aWEgbWVtb3J5IG1hcHBpbmdzLg0KPj4+
PiAtIEZpbGUgY29udGVudCBjYW5ub3QgYmUgc3dhcHBlZCBvdXQuDQo+Pj4+IA0KPj4+PiBJIHRo
aW5rIHRoZXJlIGFyZSBzdGlsbCB2YWxpZCB3YXlzIHRvIG1vZGlmeSBmaWxlIGNvbnRlbnQgdXNp
bmcgc3lzY2FsbHM6DQo+Pj4+IGUuZy4sIGZhbGxvY2F0ZShQVU5DSF9IT0xFKS4gVGhpbmdzIGxp
a2UgdHJ1bmNhdGUgYWxzbyBzZWVtcyB0byB3b3JrIGp1c3QNCj4+Pj4gZmluZS4NCj4+PiBUaGVz
ZSB3b3JrIHBlcmZlY3RseSB3aXRoIGFueSBmaWxlLCBzbyBtYXliZSB3ZSBzaG91bGQgaGF2ZSBh
ZGRlZA0KPj4+IG1lbWZkX2NyZWF0ZSBhcyBhIGZsYWcgdG8gb3BlbigyKSBiYWNrIHRoZW4gYW5k
IG5vdyB0aGUgc2VjcmV0bWVtIGZpbGUNCj4+PiBkZXNjcmlwdG9ycz8NCj4+IA0KPj4gSSB0aGlu
ayBvcGVuKCkgdnMgbWVtZmRfY3JlYXRlKCkgbWFrZXMgc2Vuc2U6IGZvciBvcGVuLCB0aGUgcGF0
aCBzcGVjaWZpZXMNCj4+IG1haW4gcHJvcGVydGllcyAodG1wZnMsIGh1Z2V0bGJmcywgZmlsZXN5
c3RlbSkuIE9uIG1lbWZkLCB0aGVyZSBpcyBubyBzdWNoDQo+PiBwYXRoIGFuZCB0aGUgInR5cGUi
IGhhcyB0byBiZSBzcGVjaWZpZWQgZGlmZmVyZW50bHkuDQo+PiANCj4+IEFsc28sIG9wZW4oKSBt
aWdodCBvcGVuIGV4aXN0aW5nIGZpbGVzIC0gbWVtZmQgYWx3YXlzIGNyZWF0ZXMgbmV3IGZpbGVz
Lg0KPiANCj4gWWVzLCBidXQgc3RpbGwgb3BlbigpIHJldHVybnMgYSBoYW5kbGUgdG8gYSBmaWxl
IGFuZCBtZW1mZF9jcmVhdGUoKSByZXR1cm5zDQo+IGEgaGFuZGxlIHRvIGEgZmlsZS4gVGhlIGRp
ZmZlcmVuY2VzIG1heSBiZSB3ZWxsIGhpZGRlbiBieSBlLmcuIE9fTUVNT1JZIGFuZA0KPiB0aGFu
IGZlYXR1cmVzIHVuaXF1ZSB0byBtZW1mZCBmaWxlcyB3aWxsIGhhdmUgdGhlaXIgc2V0IG9mIE9f
U09NRVRISU5HDQo+IGZsYWdzLg0KPiANCg0KTGV04oCYcyBhZ3JlZSB0byBkaXNhZ3JlZS4NCg0K
PiBJdCdzIHRoZSBzYW1lIGxvZ2ljIHRoYXQgc2F5cyAid2UgYWxyZWFkeSBoYXZlIGFuIGludGVy
ZmFjZSB0aGF0J3MgY2xvc2UNCj4gZW5vdWdoIGFuZCBpdCdzIGZpbmUgdG8gYWRkIGEgYnVuY2gg
b2YgbmV3IGZsYWdzIHRoZXJlIi4NCg0KTm8sIG5vdCBxdWl0ZS4gQnV0IGxldOKAmHMgYWdyZWUg
dG8gZGlzYWdyZWUuDQoNCj4gDQo+IEFuZCBoZXJlIHdlIGNvbWUgdG8gdGhlIHF1ZXN0aW9uICJ3
aGF0IGFyZSB0aGUgZGlmZmVyZW5jZXMgdGhhdCBqdXN0aWZ5IGENCj4gbmV3IHN5c3RlbSBjYWxs
PyIgYW5kIHRoZSBhbnN3ZXIgdG8gdGhpcyBpcyB2ZXJ5IHN1YmplY3RpdmUuIEFuZCBhcyBzdWNo
IHdlDQo+IGNhbiBjb250aW51ZSBiaWtlc2hlZGRpbmcgZm9yZXZlci4NCg0KSSB0aGluayB0aGlz
IGZpdHMgaW50byB0aGUgZXhpc3RpbmcgbWVtZmRfY3JlYXRlKCkgc3lzY2FsbCBqdXN0IGZpbmUs
IGFuZCBJIGhlYXJkIG5vIGNvbXBlbGxpbmcgYXJndW1lbnQgd2h5IGl0IHNob3VsZG7igJh0LiBU
aGF04oCYcyBhbGwgSSBjYW4gc2F5Lg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
