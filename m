Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0623224E2FD
	for <lists+linux-nvdimm@lfdr.de>; Sat, 22 Aug 2020 00:07:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EC7E123B96FF;
	Fri, 21 Aug 2020 15:07:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD2D1123B72FD
	for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1598047670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjtI18d1f2H/aKTyFHmileH6IrtXVHmAbfK2HkX3dk0=;
	b=cRxzOahG7oxP4yxBF6gGv1UnnIVbQBZt/uBOIi/MDnL79jACh7KQHwIuBaZICKeiXxg1Uf
	kYLkV34F/KCJlWbEOnoPeglM7d0QzuIzivaL3TjTWgpG0Yhnc/fTxt+t7JBNiuHZt/sC79
	Zt2rzzhcnJZRPkMkYwNWws4DLpwXA1c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-JshuvdwfPrWtlhCE4n6U9w-1; Fri, 21 Aug 2020 18:07:47 -0400
X-MC-Unique: JshuvdwfPrWtlhCE4n6U9w-1
Received: by mail-ej1-f70.google.com with SMTP id d24so1288785ejb.3
        for <linux-nvdimm@lists.01.org>; Fri, 21 Aug 2020 15:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6/wi0Nw+OScWqjXUa7deT7et3gd07Go77zu0NJl9auw=;
        b=AqySdDRJTJOVOLz/dHP6ZNeih+JyjfMNxfNB6Sl7u3jPFA3k621sS1fRI1/xd19dzB
         YI2GwBD34n8TZFc1xnpFwjuLOYASROVfBJPdpEm940Bd1ddevDtFZDp7q5h7i5OFRnVb
         zsV39M+z2RLu05e4bSZc5d+GpiU010mjoaEOvNepw5sz1ysYoHw9XkR6qbXIuzVBKz+H
         oNY0VZkiwWpZeVx3+hemppJHq1L+upNbjQAEMAI6BPBHVSCCB6qmtQRG4dO8aAjgtQYU
         bUzMBGUUvoJ1+pa4h02jiEjeNoAeZ7FeI0VXHl/WJTn5CoyltxQc5ZgbH6TsgFK+Ytmo
         KBnQ==
X-Gm-Message-State: AOAM531naTmoPPiCpagaAR5Xt9xrSyU6lQU0OAA/XO6F68ymfTDnlfzT
	VXpgLaOfSZkyMBCQNmfo2L0QKDhUSGAg8hBJR92GNp2dQprH+iQJhR99DPDN7KytBP7DKYpKRuF
	QsGWc0qLBDMSYJ51dHhv5
X-Received: by 2002:a17:906:6d91:: with SMTP id h17mr4593048ejt.531.1598047665749;
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2fGCDlUrSC0ozVrUImslz75nvdXz6gshUl15sF6TxX4V9+R9BHsd6i/JypP0Cf8+w6d3+oA==
X-Received: by 2002:a17:906:6d91:: with SMTP id h17mr4593016ejt.531.1598047665540;
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6231.dip0.t-ipconnect.de. [91.12.98.49])
        by smtp.gmail.com with ESMTPSA id n10sm1810467edo.43.2020.08.21.15.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 15:07:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 00/23] device-dax: Support sub-dividing soft-reserved ranges
Date: Fri, 21 Aug 2020 23:42:49 +0200
Message-Id: <1FB395E7-633D-4F3E-82F5-12E2FDAF33EC@redhat.com>
References: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
In-Reply-To: <646DDE9B-90C2-493A-958C-90EFA1CCA475@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17G68)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0.502
X-Mimecast-Originator: redhat.com
Message-ID-Hash: P6254IB56GEFCX75XY74J5PWZFRIHN32
X-Message-ID-Hash: P6254IB56GEFCX75XY74J5PWZFRIHN32
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, David Airlie <airlied@linux.ie>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Joao Martins <joao.m.martins@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ben Skeggs <bskeggs@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jason Gunthorpe <jgg@mellanox.com>, Jia He <justin.he@arm.com>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Paul Mackerras <paulus@ozlabs.org>, Brice Goglin <Brice.Goglin@inr
 ia.fr>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Vetter <daniel@ffwll.ch>, Andy Lutomirski <luto@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P6254IB56GEFCX75XY74J5PWZFRIHN32/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gQW0gMjEuMDguMjAyMCB1bSAyMzozNCBzY2hyaWViIERhdmlkIEhpbGRlbmJyYW5kIDxk
YXZpZEByZWRoYXQuY29tPjoNCj4gDQo+IO+7vw0KPiANCj4+PiBBbSAyMS4wOC4yMDIwIHVtIDIz
OjE3IHNjaHJpZWIgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+Og0KPj4+
IA0KPj4+IO+7v09uIEZyaSwgQXVnIDIxLCAyMDIwIGF0IDExOjMwIEFNIERhdmlkIEhpbGRlbmJy
YW5kIDxkYXZpZEByZWRoYXQuY29tPiB3cm90ZToNCj4+PiANCj4+Pj4gT24gMjEuMDguMjAgMjA6
MjcsIERhbiBXaWxsaWFtcyB3cm90ZToNCj4+Pj4gT24gRnJpLCBBdWcgMjEsIDIwMjAgYXQgMzox
NSBBTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+PiAN
Cj4+Pj4+Pj4gDQo+Pj4+Pj4+IDEuIE9uIHg4Ni02NCwgZTgyMCBpbmRpY2F0ZXMgInNvZnQtcmVz
ZXJ2ZWQiIG1lbW9yeS4gVGhpcyBtZW1vcnkgaXMgbm90DQo+Pj4+Pj4+IGF1dG9tYXRpY2FsbHkg
dXNlZCBpbiB0aGUgYnVkZHkgZHVyaW5nIGJvb3QsIGJ1dCByZW1haW5zIHVudG91Y2hlZA0KPj4+
Pj4+PiAoc2ltaWxhciB0byBwbWVtKS4gQnV0IGFzIGl0IGludm9sdmVzIEFDUEkgYXMgd2VsbCwg
aXQgY291bGQgYWxzbyBiZQ0KPj4+Pj4+PiB1c2VkIG9uIGFybTY0ICgtZTgyMCksIGNvcnJlY3Q/
DQo+Pj4+Pj4gDQo+Pj4+Pj4gQ29ycmVjdCwgYXJtNjQgYWxzbyBnZXRzIHRoZSBFRkkgc3VwcG9y
dCBmb3IgZW51bWVyYXRpbmcgbWVtb3J5IHRoaXMNCj4+Pj4+PiB3YXkuIEhvd2V2ZXIsIEkgd291
bGQgY2xhcmlmeSB0aGF0IHdoZXRoZXIgc29mdC1yZXNlcnZlZCBpcyBnaXZlbiB0bw0KPj4+Pj4+
IHRoZSBidWRkeSBhbGxvY2F0b3IgYnkgZGVmYXVsdCBvciBub3QgaXMgdGhlIGtlcm5lbCdzIHBv
bGljeSBjaG9pY2UsDQo+Pj4+Pj4gImJ1ZGR5LWJ5LWRlZmF1bHQiIGlzIG9rIGFuZCBpcyB3aGF0
IHdpbGwgaGFwcGVuIGFueXdheXMgd2l0aCBvbGRlcg0KPj4+Pj4+IGtlcm5lbHMgb24gcGxhdGZv
cm1zIHRoYXQgZW51bWVyYXRlIGEgbWVtb3J5IHJhbmdlIHRoaXMgd2F5Lg0KPj4+Pj4gDQo+Pj4+
PiBJcyAic29mdC1yZXNlcnZlZCIgdGhlbiB0aGUgcmlnaHQgdGVybWlub2xvZ3kgZm9yIHRoYXQ/
IEl0IHNvdW5kcyB2ZXJ5DQo+Pj4+PiB4ODYtNjQvZTgyMCBzcGVjaWZpYy4gTWF5YmUgYSBjb21w
cmVzc2VkIGZvciBvZiAicGVyZm9ybWFuY2UNCj4+Pj4+IGRpZmZlcmVudGlhdGVkIG1lbW9yeSIg
bWlnaHQgYmUgYSBiZXR0ZXIgZml0IHRvIGV4cG9zZSB0byB1c2VyIHNwYWNlLCBubz8NCj4+Pj4g
DQo+Pj4+IE5vLiBUaGUgRUZJICJTcGVjaWZpYyBQdXJwb3NlIiBiaXQgaXMgYW4gYXR0cmlidXRl
IGluZGVwZW5kZW50IG9mDQo+Pj4+IGU4MjAsIGl0J3MgeDg2LUxpbnV4IHRoYXQgZW50YW5nbGVz
IHRob3NlIHRvZ2V0aGVyLiBUaGVyZSBpcyBubw0KPj4+PiByZXF1aXJlbWVudCBmb3IgcGxhdGZv
cm0gZmlybXdhcmUgdG8gdXNlIHRoYXQgZGVzaWduYXRpb24gZXZlbiBmb3INCj4+Pj4gZHJhc3Rp
YyBwZXJmb3JtYW5jZSBkaWZmZXJlbnRpYXRpb24gYmV0d2VlbiByYW5nZXMsIGFuZCBjb252ZXJz
ZWx5DQo+Pj4+IHRoZXJlIGlzIG5vIHJlcXVpcmVtZW50IHRoYXQgbWVtb3J5ICp3aXRoKiB0aGF0
IGRlc2lnbmF0aW9uIGhhcyBhbnkNCj4+Pj4gcGVyZm9ybWFuY2UgZGlmZmVyZW5jZSBjb21wYXJl
ZCB0byB0aGUgZGVmYXVsdCBtZW1vcnkgcG9vbC4gU28gaXQNCj4+Pj4gcmVhbGx5IGlzIGEgcmVz
ZXJ2YXRpb24gcG9saWN5IGFib3V0IGEgbWVtb3J5IHJhbmdlIHRvIGtlZXAgb3V0IG9mIHRoZQ0K
Pj4+PiBidWRkeSBhbGxvY2F0b3IgYnkgZGVmYXVsdC4NCj4+PiANCj4+PiBPa2F5LCBzdGlsbCAi
c29mdC1yZXNlcnZlZCIgaXMgeDg2LTY0IHNwZWNpZmljLCBubz8NCj4+IA0KPj4gVGhlcmUncyBu
b3RoaW5nIHByZXZlbnRpbmcgb3RoZXIgRUZJIGFyY2hzLCBvciBhIHNpbWlsYXIgZGVzaWduYXRp
b24NCj4+IGluIGFub3RoZXIgZmlybXdhcmUgc3BlYywgcGlja2luZyB1cCB0aGlzIHBvbGljeS4N
Cj4+IA0KPj4+IChBRkFJSywNCj4+PiAic29mdC1yZXNlcnZlZCIgd2lsbCBiZSB2aXNpYmxlIGlu
IC9wcm9jL2lvbWVtLCBvciBhbSBJIGNvbmZ1c2luZw0KPj4+IHN0dWZmPykNCj4+IA0KPj4gTm8s
IHlvdSdyZSBjb3JyZWN0Lg0KPj4gDQo+Pj4gSU9XLCBpdCAicGVyZm9ybWFuY2UgZGlmZmVyZW50
aWF0ZWQiIGlzIG5vdCB1bml2ZXJzYWxseQ0KPj4+IGFwcGxpY2FibGUsIG1heWJlICAic3BlY2lm
aWMgcHVycG9zZSBtZW1vcnkiIGlzID8NCj4+IA0KPj4gVGhvc2UgYmlrZXNoZWQgY29sb3JzIGRv
bid0IHNlZW0gYW4gaW1wcm92ZW1lbnQgdG8gbWUuDQo+PiANCj4+ICJTb2Z0LXJlc2VydmVkIiBh
Y3R1YWxseSB0ZWxscyB5b3Ugc29tZXRoaW5nIGFib3V0IHRoZSBrZXJuZWwgcG9saWN5DQo+PiBm
b3IgdGhlIG1lbW9yeS4gVGhlIGNyaXRpY2lzbSBvZiAic3BlY2lmaWMgcHVycG9zZSIgdGhhdCBs
ZWQgdG8NCj4+IGNhbGxpbmcgaXQgInNvZnQtcmVzZXJ2ZWQiIGluIExpbnV4IGlzIHRoZSBmYWN0
IHRoYXQgInNwZWNpZmljIiBpcw0KPj4gdW5kZWZpbmVkIGFzIGZhciBhcyB0aGUgZmlybXdhcmUg
a25vd3MsIGFuZCAic3BlY2lmaWMiIG1heSBoYXZlDQo+PiBkaWZmZXJlbnQgYXBwbGljYXRpb25z
IGJhc2VkIG9uIHRoZSBwbGF0Zm9ybSB1c2VyLiAiU29mdC1yZXNlcnZlZCINCj4+IGxpa2UgIlJl
c2VydmVkIiB0ZWxscyB5b3UgdGhhdCBhIGRyaXZlciBwb2xpY3kgbWlnaHQgYmUgaW4gcGxheSBm
b3INCj4+IHRoYXQgbWVtb3J5Lg0KPj4gDQo+PiBBbHNvIG5vdGUgdGhhdCB0aGUgY3VycmVudCBj
b2xvciBvZiB0aGUgYmlrZXNoZWQgaGFzIGFscmVhZHkgc2hpcHBlZCBzaW5jZSB2NS41Og0KPj4g
DQo+PiAgMjYyYjQ1YWUzYWI0IHg4Ni9lZmk6IEVGSSBzb2Z0IHJlc2VydmF0aW9uIHRvIEU4MjAg
ZW51bWVyYXRpb24NCj4+IA0KPiANCj4gSSB3YXMgYXNraW5nIGJlY2F1c2UgSSB3YXMgc3RydWdn
bGluZyB0byBldmVuIHVuZGVyc3RhbmQgd2hhdCDigJ5zb2Z0LXJlc2VydmVk4oCcIGlzIGFuZCBJ
IGNvdWxkIGJldCBtb3N0IHBlb3BsZSBoYXZlIG5vIGNsdWUgd2hhdCB0aGF0IGlzIHN1cHBvc2Vk
IHRvIGJlLg0KPiANCj4gSW4gY29udHJhc3Qg4oCecGVyc2lzdGVudCBtZW1vcnnigJwgb3Ig4oCe
c3BlY2lhbCBwdXJwb3NlIG1lbW9yeeKAnCBpbiAvcHJvYy9pb21lbSBpcyBzb21ldGhpbmcgbm9y
bWFsIChMaW51eCB1c2luZykgaHVtYW4gYmVpbmdzIGNhbiB1bmRlcnN0YW5kLg0KDQpzL25vcm1h
bC9tb3N0LyBvZiBjb3Vyc2UgOikNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
