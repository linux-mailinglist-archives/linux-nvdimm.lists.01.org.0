Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4952B0EE7
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Nov 2020 21:15:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6E6E6100EC1DD;
	Thu, 12 Nov 2020 12:15:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA7AF100EC1DA
	for <linux-nvdimm@lists.01.org>; Thu, 12 Nov 2020 12:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605212123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwJcHMqFNMjcwmrQqeZ7xQpjUn5kuh+iR2Mn5fyrgQY=;
	b=F6E3nEI2LmafJBFU65gOCLfUUhboj3bvkxL6SUgi6d1XiVXOIgaokg1Y3wFFj6A4h1EYfq
	vk719m3BYsb5E4chsJISDJFma32dc8h67l1SjyN4HpJflErpKz3Zh0cgvDEuqiH55jNrMQ
	diP3j8Kass2IW2VtgbM8WA7Oy1LRWMQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-fq3XeDE8Oj6o7OTofGJdwg-1; Thu, 12 Nov 2020 15:15:22 -0500
X-MC-Unique: fq3XeDE8Oj6o7OTofGJdwg-1
Received: by mail-wr1-f71.google.com with SMTP id p16so2481785wrx.4
        for <linux-nvdimm@lists.01.org>; Thu, 12 Nov 2020 12:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vHPfrB8xVjlPFSCqejvi+QTUrEERRY3Dc+wUeNVcoBQ=;
        b=laTNkOkI2VNtTGxA/CLKqTBFY4Si9p9/nSzRIVulIYu72/b/6pmprN0bmALQgX3sfF
         MBwMgWiUbcU3Xgti2XjpbOq0ACo6qy57TEInMBLTqaw8R2ROuF3oE7sIylkbPfZVVh6U
         8dffb4hWw3PxQKo/ECtWrq4L6BfRs70ynJ31ekoAiwgRuwyh07+uDSksIzsyqkeXnsbH
         9frB9pA8uvztSAKf2ZDagpWC3k4bDMgclx9aH8tGcgFk7fornkU/aIzVmygMxoNmmuKJ
         2MEhupneET/rZCDieCP88J2ob0HPloSn9Z5ALnE0b7G89NhGD11gL69S7kzJN5Xiuu76
         /Mig==
X-Gm-Message-State: AOAM533tH2fOQPf0Facw46U43HStEO4hu+WOgarC0KPfer411vKP3+Iy
	QxCcmQwYIZRmSrqpMRKOBScy1G4R7MJTCxAIh8Pyuhh+vq5P+GI+cPuOy4S2LuqU5TuSivO+52c
	vZdhnzwMjJGledTEcsgEz
X-Received: by 2002:adf:e350:: with SMTP id n16mr1455267wrj.419.1605212120790;
        Thu, 12 Nov 2020 12:15:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxji2+rXiblNfD29iXHuiDwrhuPVpa0KNLoEK9tHEW4ondrhf0pVB9gNYs6gWjo3tNv0xhLcA==
X-Received: by 2002:adf:e350:: with SMTP id n16mr1455211wrj.419.1605212120462;
        Thu, 12 Nov 2020 12:15:20 -0800 (PST)
Received: from [192.168.3.114] (p5b0c631d.dip0.t-ipconnect.de. [91.12.99.29])
        by smtp.gmail.com with ESMTPSA id 35sm8578483wro.71.2020.11.12.12.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 12:15:19 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Date: Thu, 12 Nov 2020 21:15:18 +0100
Message-Id: <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
References: <20201112190827.GP4758@kernel.org>
In-Reply-To: <20201112190827.GP4758@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18A8395)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: CJIMC63FDYWXMMKEMX2QYSV5QBRHDAWV
X-Message-ID-Hash: CJIMC63FDYWXMMKEMX2QYSV5QBRHDAWV
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-ap
 i@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CJIMC63FDYWXMMKEMX2QYSV5QBRHDAWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IEFtIDEyLjExLjIwMjAgdW0gMjA6MDggc2NocmllYiBNaWtlIFJhcG9wb3J0IDxycHB0QGtl
cm5lbC5vcmc+Og0KPiANCj4g77u/T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMDU6MjI6MDBQTSAr
MDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4gT24gMTAuMTEuMjAgMTk6MDYsIE1p
a2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4gT24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMDY6MTc6MjZQ
TSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+Pj4+IE9uIDEwLjExLjIwIDE2OjE0
LCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4+Pj4gRnJvbTogTWlrZSBSYXBvcG9ydCA8cnBwdEBs
aW51eC5pYm0uY29tPg0KPj4+Pj4gDQo+Pj4+PiBJdCB3aWxsIGJlIHVzZWQgYnkgdGhlIHVwY29t
aW5nIHNlY3JldCBtZW1vcnkgaW1wbGVtZW50YXRpb24uDQo+Pj4+PiANCj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+
Pj4gICBtbS9pbnRlcm5hbC5oIHwgMyArKysNCj4+Pj4+ICAgbW0vbW1hcC5jICAgICB8IDUgKyst
LS0NCj4+Pj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pj4+PiANCj4+Pj4+IGRpZmYgLS1naXQgYS9tbS9pbnRlcm5hbC5oIGIvbW0vaW50ZXJu
YWwuaA0KPj4+Pj4gaW5kZXggYzQzY2NkZGRiMGY2Li5hZTE0NmEyNjBiMTQgMTAwNjQ0DQo+Pj4+
PiAtLS0gYS9tbS9pbnRlcm5hbC5oDQo+Pj4+PiArKysgYi9tbS9pbnRlcm5hbC5oDQo+Pj4+PiBA
QCAtMzQ4LDYgKzM0OCw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtdW5sb2NrX3ZtYV9wYWdlc19h
bGwoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+Pj4+PiAgIGV4dGVybiB2b2lkIG1sb2Nr
X3ZtYV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKTsNCj4+Pj4+ICAgZXh0ZXJuIHVuc2lnbmVkIGlu
dCBtdW5sb2NrX3ZtYV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKTsNCj4+Pj4+ICtleHRlcm4gaW50
IG1sb2NrX2Z1dHVyZV9jaGVjayhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBm
bGFncywNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGxlbik7DQo+Pj4+
PiArDQo+Pj4+PiAgIC8qDQo+Pj4+PiAgICAqIENsZWFyIHRoZSBwYWdlJ3MgUGFnZU1sb2NrZWQo
KS4gIFRoaXMgY2FuIGJlIHVzZWZ1bCBpbiBhIHNpdHVhdGlvbiB3aGVyZQ0KPj4+Pj4gICAgKiB3
ZSB3YW50IHRvIHVuY29uZGl0aW9uYWxseSByZW1vdmUgYSBwYWdlIGZyb20gdGhlIHBhZ2VjYWNo
ZSAtLSBlLmcuLA0KPj4+Pj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPj4+
Pj4gaW5kZXggNjFmNzJiMDlkOTkwLi5jNDgxZjA4OGJkNTAgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9t
bS9tbWFwLmMNCj4+Pj4+ICsrKyBiL21tL21tYXAuYw0KPj4+Pj4gQEAgLTEzNDgsOSArMTM0OCw4
IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyByb3VuZF9oaW50X3RvX21pbih1bnNpZ25l
ZCBsb25nIGhpbnQpDQo+Pj4+PiAgICAgICByZXR1cm4gaGludDsNCj4+Pj4+ICAgfQ0KPj4+Pj4g
LXN0YXRpYyBpbmxpbmUgaW50IG1sb2NrX2Z1dHVyZV9jaGVjayhzdHJ1Y3QgbW1fc3RydWN0ICpt
bSwNCj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGZsYWdzLA0KPj4+
Pj4gLSAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbGVuKQ0KPj4+Pj4gK2ludCBt
bG9ja19mdXR1cmVfY2hlY2soc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgZmxh
Z3MsDQo+Pj4+PiArICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBsZW4pDQo+Pj4+PiAgIHsN
Cj4+Pj4+ICAgICAgIHVuc2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0Ow0KPj4+Pj4gDQo+
Pj4+IA0KPj4+PiBTbywgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24gaXMgaWYgeW91IGFjdHVhbGx5
IHdhbnQgdG8gY2hhcmdlIHNlY3JldG1lbQ0KPj4+PiBwYWdlcyBhZ2FpbnN0IG1sb2NrIG5vdywg
b3IgaWYgeW91IHdhbnQgYSBkZWRpY2F0ZWQgc2VjcmV0bWVtIGNncm91cA0KPj4+PiBjb250cm9s
bGVyIGluc3RlYWQ/DQo+Pj4gDQo+Pj4gV2VsbCwgd2l0aCB0aGUgY3VycmVudCBpbXBsZW1lbnRh
dGlvbiB0aGVyZSBhcmUgdGhyZWUgbGltaXRzIGFuDQo+Pj4gYWRtaW5pc3RyYXRvciBjYW4gdXNl
IHRvIGNvbnRyb2wgc2VjcmV0bWVtIGxpbWl0czogbWxvY2ssIG1lbWNnIGFuZA0KPj4+IGtlcm5l
bCBwYXJhbWV0ZXIuDQo+Pj4gDQo+Pj4gVGhlIGtlcm5lbCBwYXJhbWV0ZXIgcHV0cyBhIGdsb2Jh
bCB1cHBlciBsaW1pdCBmb3Igc2VjcmV0bWVtIHVzYWdlLA0KPj4+IG1lbWNnIGFjY291bnRzIGFs
bCBzZWNyZXRtZW0gYWxsb2NhdGlvbnMsIGluY2x1ZGluZyB0aGUgdW51c2VkIG1lbW9yeSBpbg0K
Pj4+IGxhcmdlIHBhZ2VzIGNhY2hpbmcgYW5kIG1sb2NrIGFsbG93cyBwZXIgdGFzayBsaW1pdCBm
b3Igc2VjcmV0bWVtDQo+Pj4gbWFwcGluZ3MsIHdlbGwsIGxpa2UgbWxvY2sgZG9lcy4NCj4+PiAN
Cj4+PiBJIGRpZG4ndCBjb25zaWRlciBhIGRlZGljYXRlZCBjZ3JvdXAsIGFzIGl0IHNlZW1zIHdl
IGFscmVhZHkgaGF2ZSBlbm91Z2gNCj4+PiBleGlzdGluZyBrbm9icyBhbmQgYSBuZXcgb25lIHdv
dWxkIGJlIHVubmVjZXNzYXJ5Lg0KPj4gDQo+PiBUbyBtZSBpdCBmZWVscyBsaWtlIHRoZSBtbG9j
aygpIGxpbWl0IGlzIGEgd3JvbmcgZml0IGZvciBzZWNyZXRtZW0uIEJ1dA0KPj4gbWF5YmUgdGhl
cmUgYXJlIG90aGVyIGNhc2VzIG9mIHVzaW5nIHRoZSBtbG9jaygpIGxpbWl0IHdpdGhvdXQgYWN0
dWFsbHkNCj4+IGRvaW5nIG1sb2NrKCkgdGhhdCBJIGFtIG5vdCBhd2FyZSBvZiAobW9zdCBwcm9i
YWJseSA6KSApPw0KPiANCj4gU2VjcmV0bWVtIGRvZXMgbm90IGV4cGxpY2l0bHkgY2FsbHMgdG8g
bWxvY2soKSBidXQgaXQgZG9lcyB3aGF0IG1sb2NrKCkNCj4gZG9lcyBhbmQgYSBiaXQgbW9yZS4g
Q2l0aW5nIG1sb2NrKDIpOg0KPiANCj4gIG1sb2NrKCksICBtbG9jazIoKSwgIGFuZCAgbWxvY2th
bGwoKSAgbG9jayAgcGFydCAgb3IgYWxsIG9mIHRoZSBjYWxsaW5nDQo+ICBwcm9jZXNzJ3Mgdmly
dHVhbCBhZGRyZXNzIHNwYWNlIGludG8gUkFNLCBwcmV2ZW50aW5nIHRoYXQgIG1lbW9yeSAgZnJv
bQ0KPiAgYmVpbmcgcGFnZWQgdG8gdGhlIHN3YXAgYXJlYS4NCj4gDQo+IFNvLCBiYXNlZCBvbiB0
aGF0IHNlY3JldG1lbSBwYWdlcyBhcmUgbm90IHN3YXBwYWJsZSwgSSB0aGluayB0aGF0DQo+IFJM
SU1JVF9NRU1MT0NLIGlzIGFwcHJvcHJpYXRlIGhlcmUuDQo+IA0KDQpUaGUgcGFnZSBleHBsaWNp
dGx5IGxpc3RzIG1sb2NrKCkgc3lzdGVtIGNhbGxzLiBFLmcuLCB3ZSBhbHNvIGRvbuKAmHQgYWNj
b3VudCBmb3IgZ2lnYW50aWMgcGFnZXMgLSB3aGljaCBtaWdodCBiZSBhbGxvY2F0ZWQgZnJvbSBD
TUEgYW5kIGFyZSBub3Qgc3dhcHBhYmxlLg0KDQoNCg0KPj4gSSBtZWFuLCBteSBjb25jZXJuIGlz
IG5vdCBlYXJ0aCBzaGF0dGVyaW5nLCB0aGlzIGNhbiBiZSByZXdvcmtlZCBsYXRlci4gQXMgSQ0K
Pj4gc2FpZCwgaXQganVzdCBmZWVscyB3cm9uZy4NCj4+IA0KPj4gLS0gDQo+PiBUaGFua3MsDQo+
PiANCj4+IERhdmlkIC8gZGhpbGRlbmINCj4+IA0KPiANCj4gLS0gDQo+IFNpbmNlcmVseSB5b3Vy
cywNCj4gTWlrZS4NCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
