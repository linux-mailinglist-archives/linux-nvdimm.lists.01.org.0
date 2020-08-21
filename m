Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 838F624E2BD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Aug 2020 23:34:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BAAB123B94C9;
	Fri, 21 Aug 2020 14:34:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C0B3123B94C6
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1598045641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIVcS3RezIuEV+dVfMcP0ao+5stAsTga3e8QCCUMb3U=;
	b=JtyYymkahTagCYKP7PVG55xk855KWCUeEiy089LBkbwm/0K42pcn/p5DU1AKVE3G79pcUy
	H4Rlj0wh9EvOotj6Cr+DwhUT09BP5mPlOOxJIU9zpz2Qz9emFbOcR+V0MRq3wwWg37o9ga
	Y9rf4e/DSczFULnSnl+CbghjzxNabmY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-_mL50VkzPE6_FRC5eQn5gA-1; Fri, 21 Aug 2020 17:34:00 -0400
X-MC-Unique: _mL50VkzPE6_FRC5eQn5gA-1
Received: by mail-ed1-f69.google.com with SMTP id be15so1241198edb.20
        for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 14:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vgmuzKXgcjBcRgoPDChBvhGV7hX/eWB5I9mkSmfnUJ8=;
        b=mGN3OcXhuwKgLBTMNzmiC/PYe4FIqYiAaxRDd0JJBgeU7RtphvfriKTXmcDqYLVwKd
         O0h1gGIAFuIbpqm8zdQX+x5Uz9vf7F3Dd8cwBKn6RQHDtIPj7yYhEi5EwfBq6831P59S
         51PyfXDKoBOW9UJHWesj+lLmieDgW4uMFotsbu+24QrTZ/3/ooTzjC56c313+sZf097d
         eOUzNC9JfMtwoFSHJff0fJlUMwrT9Y+G2AznwVZaAUvbf19lF+1z9nAenMfEU/r2h+Di
         D3to+7EVxOXcY9OYD5PHbVcYtTk6Zc5LvLQPe+m7MRGdY3W2c+7Mr2TNe/DsmaJ9EvPk
         q5Ow==
X-Gm-Message-State: AOAM530fvbCrjgdlIbm89G9gDM6ng0AluME/Ux+HdvyhNF5Iw/FPyfTa
	org/kHdg7kzsiVt7EE6qxvIPoP/B22ipCfZqiaXxoHBVsDf4z2HdsfZAURrie4N6k2W2cubikrh
	p/H89azCpPCIA0GWY+QP5
X-Received: by 2002:aa7:db10:: with SMTP id t16mr4670987eds.196.1598045639009;
        Fri, 21 Aug 2020 14:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsY3HWTjNmnI8n64swZ39edXjTL651Y7phqEaxt8pR/mpnMiF2k94JkzZc4axtZWxBWkdbNw==
X-Received: by 2002:aa7:db10:: with SMTP id t16mr4670942eds.196.1598045638810;
        Fri, 21 Aug 2020 14:33:58 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6231.dip0.t-ipconnect.de. [91.12.98.49])
        by smtp.gmail.com with ESMTPSA id j21sm93193eja.109.2020.08.21.14.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 14:33:58 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
Date: Fri, 21 Aug 2020 23:33:57 +0200
Message-Id: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
References: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
In-Reply-To: <CAPcyv4gTJgZ0jM3oRM8Exs7MKwyNHF5yWNceAFrX7k8KfFcBig@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17G68)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0.502
X-Mimecast-Originator: redhat.com
Message-ID-Hash: DJVL7SBVX3GRNTOB2UEWRIGPUEAXWH3U
X-Message-ID-Hash: DJVL7SBVX3GRNTOB2UEWRIGPUEAXWH3U
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlab
 s.org>, Brice Goglin <Brice.Goglin@inria.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DJVL7SBVX3GRNTOB2UEWRIGPUEAXWH3U/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gQW0gMjEuMDguMjAyMCB1bSAyMzoxNyBzY2hyaWViIERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPjoNCj4gDQo+IO+7v09uIEZyaSwgQXVnIDIxLCAyMDIwIGF0IDEx
OjMwIEFNIERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4+IA0K
Pj4+IE9uIDIxLjA4LjIwIDIwOjI3LCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+Pj4gT24gRnJpLCBB
dWcgMjEsIDIwMjAgYXQgMzoxNSBBTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNv
bT4gd3JvdGU6DQo+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+IDEuIE9uIHg4Ni02NCwgZTgyMCBpbmRp
Y2F0ZXMgInNvZnQtcmVzZXJ2ZWQiIG1lbW9yeS4gVGhpcyBtZW1vcnkgaXMgbm90DQo+Pj4+Pj4g
YXV0b21hdGljYWxseSB1c2VkIGluIHRoZSBidWRkeSBkdXJpbmcgYm9vdCwgYnV0IHJlbWFpbnMg
dW50b3VjaGVkDQo+Pj4+Pj4gKHNpbWlsYXIgdG8gcG1lbSkuIEJ1dCBhcyBpdCBpbnZvbHZlcyBB
Q1BJIGFzIHdlbGwsIGl0IGNvdWxkIGFsc28gYmUNCj4+Pj4+PiB1c2VkIG9uIGFybTY0ICgtZTgy
MCksIGNvcnJlY3Q/DQo+Pj4+PiANCj4+Pj4+IENvcnJlY3QsIGFybTY0IGFsc28gZ2V0cyB0aGUg
RUZJIHN1cHBvcnQgZm9yIGVudW1lcmF0aW5nIG1lbW9yeSB0aGlzDQo+Pj4+PiB3YXkuIEhvd2V2
ZXIsIEkgd291bGQgY2xhcmlmeSB0aGF0IHdoZXRoZXIgc29mdC1yZXNlcnZlZCBpcyBnaXZlbiB0
bw0KPj4+Pj4gdGhlIGJ1ZGR5IGFsbG9jYXRvciBieSBkZWZhdWx0IG9yIG5vdCBpcyB0aGUga2Vy
bmVsJ3MgcG9saWN5IGNob2ljZSwNCj4+Pj4+ICJidWRkeS1ieS1kZWZhdWx0IiBpcyBvayBhbmQg
aXMgd2hhdCB3aWxsIGhhcHBlbiBhbnl3YXlzIHdpdGggb2xkZXINCj4+Pj4+IGtlcm5lbHMgb24g
cGxhdGZvcm1zIHRoYXQgZW51bWVyYXRlIGEgbWVtb3J5IHJhbmdlIHRoaXMgd2F5Lg0KPj4+PiAN
Cj4+Pj4gSXMgInNvZnQtcmVzZXJ2ZWQiIHRoZW4gdGhlIHJpZ2h0IHRlcm1pbm9sb2d5IGZvciB0
aGF0PyBJdCBzb3VuZHMgdmVyeQ0KPj4+PiB4ODYtNjQvZTgyMCBzcGVjaWZpYy4gTWF5YmUgYSBj
b21wcmVzc2VkIGZvciBvZiAicGVyZm9ybWFuY2UNCj4+Pj4gZGlmZmVyZW50aWF0ZWQgbWVtb3J5
IiBtaWdodCBiZSBhIGJldHRlciBmaXQgdG8gZXhwb3NlIHRvIHVzZXIgc3BhY2UsIG5vPw0KPj4+
IA0KPj4+IE5vLiBUaGUgRUZJICJTcGVjaWZpYyBQdXJwb3NlIiBiaXQgaXMgYW4gYXR0cmlidXRl
IGluZGVwZW5kZW50IG9mDQo+Pj4gZTgyMCwgaXQncyB4ODYtTGludXggdGhhdCBlbnRhbmdsZXMg
dGhvc2UgdG9nZXRoZXIuIFRoZXJlIGlzIG5vDQo+Pj4gcmVxdWlyZW1lbnQgZm9yIHBsYXRmb3Jt
IGZpcm13YXJlIHRvIHVzZSB0aGF0IGRlc2lnbmF0aW9uIGV2ZW4gZm9yDQo+Pj4gZHJhc3RpYyBw
ZXJmb3JtYW5jZSBkaWZmZXJlbnRpYXRpb24gYmV0d2VlbiByYW5nZXMsIGFuZCBjb252ZXJzZWx5
DQo+Pj4gdGhlcmUgaXMgbm8gcmVxdWlyZW1lbnQgdGhhdCBtZW1vcnkgKndpdGgqIHRoYXQgZGVz
aWduYXRpb24gaGFzIGFueQ0KPj4+IHBlcmZvcm1hbmNlIGRpZmZlcmVuY2UgY29tcGFyZWQgdG8g
dGhlIGRlZmF1bHQgbWVtb3J5IHBvb2wuIFNvIGl0DQo+Pj4gcmVhbGx5IGlzIGEgcmVzZXJ2YXRp
b24gcG9saWN5IGFib3V0IGEgbWVtb3J5IHJhbmdlIHRvIGtlZXAgb3V0IG9mIHRoZQ0KPj4+IGJ1
ZGR5IGFsbG9jYXRvciBieSBkZWZhdWx0Lg0KPj4gDQo+PiBPa2F5LCBzdGlsbCAic29mdC1yZXNl
cnZlZCIgaXMgeDg2LTY0IHNwZWNpZmljLCBubz8NCj4gDQo+IFRoZXJlJ3Mgbm90aGluZyBwcmV2
ZW50aW5nIG90aGVyIEVGSSBhcmNocywgb3IgYSBzaW1pbGFyIGRlc2lnbmF0aW9uDQo+IGluIGFu
b3RoZXIgZmlybXdhcmUgc3BlYywgcGlja2luZyB1cCB0aGlzIHBvbGljeS4NCj4gDQo+PiAgKEFG
QUlLLA0KPj4gInNvZnQtcmVzZXJ2ZWQiIHdpbGwgYmUgdmlzaWJsZSBpbiAvcHJvYy9pb21lbSwg
b3IgYW0gSSBjb25mdXNpbmcNCj4+IHN0dWZmPykNCj4gDQo+IE5vLCB5b3UncmUgY29ycmVjdC4N
Cj4gDQo+PiBJT1csIGl0ICJwZXJmb3JtYW5jZSBkaWZmZXJlbnRpYXRlZCIgaXMgbm90IHVuaXZl
cnNhbGx5DQo+PiBhcHBsaWNhYmxlLCBtYXliZSAgInNwZWNpZmljIHB1cnBvc2UgbWVtb3J5IiBp
cyA/DQo+IA0KPiBUaG9zZSBiaWtlc2hlZCBjb2xvcnMgZG9uJ3Qgc2VlbSBhbiBpbXByb3ZlbWVu
dCB0byBtZS4NCj4gDQo+ICJTb2Z0LXJlc2VydmVkIiBhY3R1YWxseSB0ZWxscyB5b3Ugc29tZXRo
aW5nIGFib3V0IHRoZSBrZXJuZWwgcG9saWN5DQo+IGZvciB0aGUgbWVtb3J5LiBUaGUgY3JpdGlj
aXNtIG9mICJzcGVjaWZpYyBwdXJwb3NlIiB0aGF0IGxlZCB0bw0KPiBjYWxsaW5nIGl0ICJzb2Z0
LXJlc2VydmVkIiBpbiBMaW51eCBpcyB0aGUgZmFjdCB0aGF0ICJzcGVjaWZpYyIgaXMNCj4gdW5k
ZWZpbmVkIGFzIGZhciBhcyB0aGUgZmlybXdhcmUga25vd3MsIGFuZCAic3BlY2lmaWMiIG1heSBo
YXZlDQo+IGRpZmZlcmVudCBhcHBsaWNhdGlvbnMgYmFzZWQgb24gdGhlIHBsYXRmb3JtIHVzZXIu
ICJTb2Z0LXJlc2VydmVkIg0KPiBsaWtlICJSZXNlcnZlZCIgdGVsbHMgeW91IHRoYXQgYSBkcml2
ZXIgcG9saWN5IG1pZ2h0IGJlIGluIHBsYXkgZm9yDQo+IHRoYXQgbWVtb3J5Lg0KPiANCj4gQWxz
byBub3RlIHRoYXQgdGhlIGN1cnJlbnQgY29sb3Igb2YgdGhlIGJpa2VzaGVkIGhhcyBhbHJlYWR5
IHNoaXBwZWQgc2luY2UgdjUuNToNCj4gDQo+ICAgMjYyYjQ1YWUzYWI0IHg4Ni9lZmk6IEVGSSBz
b2Z0IHJlc2VydmF0aW9uIHRvIEU4MjAgZW51bWVyYXRpb24NCj4gDQoNCkkgd2FzIGFza2luZyBi
ZWNhdXNlIEkgd2FzIHN0cnVnZ2xpbmcgdG8gZXZlbiB1bmRlcnN0YW5kIHdoYXQg4oCec29mdC1y
ZXNlcnZlZOKAnCBpcyBhbmQgSSBjb3VsZCBiZXQgbW9zdCBwZW9wbGUgaGF2ZSBubyBjbHVlIHdo
YXQgdGhhdCBpcyBzdXBwb3NlZCB0byBiZS4NCg0KSW4gY29udHJhc3Qg4oCecGVyc2lzdGVudCBt
ZW1vcnnigJwgb3Ig4oCec3BlY2lhbCBwdXJwb3NlIG1lbW9yeeKAnCBpbiAvcHJvYy9pb21lbSBp
cyBzb21ldGhpbmcgbm9ybWFsIChMaW51eCB1c2luZykgaHVtYW4gYmVpbmdzIGNhbiB1bmRlcnN0
YW5kLg0KDQpCdXQgYW55aG93LCBqdXN0IGRldGFpbHMsIGFuZCB5b3XigJhyZSB0ZWxsaW5nIG1l
IHRoYXQgdGhhdCBzaGlwIGFscmVhZHkgc2FpbGVkLiBTbyBubyBmdXJ0aGVyIGNvbW1lbnRzIGZy
b20gbXkgc2lkZS4NCg0KVGhhbmtzIGZvciBhbGwgdGhlIGluZm8hDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0
IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFp
bCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
