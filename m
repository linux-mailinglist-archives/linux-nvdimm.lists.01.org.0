Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA193141FD
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 22:38:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD398100EAB6E;
	Mon,  8 Feb 2021 13:38:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5A94B100EAB6B
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1612820332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2rpEa4PXmR1i2BkerHYaYcliPU1ybbsCKViRbwN9DgE=;
	b=Oik6I5PcSFfoN+e/sTxomNlbNyuM/lX9YlYXxez/Exw+f9A9d5KSFZbAw9cWbgJTiMNj+F
	vjT2GIZi7gDGUdZ2DQCbtmewv5eYVkEsuYoIEPM3AVH6uWq3dXa8lYbQcf5jGXDtB8SwWk
	to44+wFn7gNSBHczvqCRWwP8d4qPwls=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Xn4tz6S2NM-t2kWwYEEbrg-1; Mon, 08 Feb 2021 16:38:51 -0500
X-MC-Unique: Xn4tz6S2NM-t2kWwYEEbrg-1
Received: by mail-wm1-f70.google.com with SMTP id b62so244646wmc.5
        for <linux-nvdimm@lists.01.org>; Mon, 08 Feb 2021 13:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4aepynJlknVRj6NFbhX2n2ebQXb/zj5Dsa2tNMP+Ofs=;
        b=e8gu1Za7KpOYnNSfe/NhPEfKPpUI4YBowugEddaYFJ8vX2ZhyAtyCuFGorWUmQ+1z0
         ul96I7oMpxjZ55Ms1IJy5FCZj5F8EMavyKfvA7EFsKnYSFbXhkDAq5PNNQhbFqCDtvog
         p1MWZWg9SXN/sWRXqbtchUsp7c/AYn3jGrbySqBc22Y6GwLdpMicFH1spcjjmGU3zbgw
         63s0k6UbtaItW6eFJ/tjU/3yFmIdjDebjrigNf9T4xJkNLu42r9p0k3NHMKnhyQsML1b
         cRFQOC0ybWAmmSujxcnQ6b/pavp/sV8UkYU2CU6aPG6Ew8/8ZTIQENrmheG3QFiAlf84
         3X2A==
X-Gm-Message-State: AOAM531lb88JwOLsFeyBag12QOXemZAoPJO0Y8JMV/tqMfiAH7zM2Rrn
	Uz/baxhRMI1qpVm0zhTKcjFAtWCgrJGtnW5qCiVQYQQaJKrCNepQFf/uEvb1qzjuqY35D0f7nTE
	LqI0935lF8KZGBDwGInvq
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr591040wrs.345.1612820308498;
        Mon, 08 Feb 2021 13:38:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYU+ahfuGJ3mGlPDTjZ5sBTd5prIK5bha/7jxkj2wK46UMNjmdy8O20OWQnrZzKp7lrPlvQQ==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr589823wrs.345.1612820285413;
        Mon, 08 Feb 2021 13:38:05 -0800 (PST)
Received: from [192.168.3.108] (p5b0c696d.dip0.t-ipconnect.de. [91.12.105.109])
        by smtp.gmail.com with ESMTPSA id w15sm30039179wrp.15.2021.02.08.13.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 13:38:04 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v17 00/10] mm: introduce memfd_secret system call to create "secret" memory areas
Date: Mon, 8 Feb 2021 22:38:03 +0100
Message-Id: <1F6A73CF-158A-4261-AA6C-1F5C77F4F326@redhat.com>
References: <20210208211326.GV242749@kernel.org>
In-Reply-To: <20210208211326.GV242749@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Mailer: iPhone Mail (18D52)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: WEFNRWKNFWQUSWUDVH5VSCXGYLMH6XR4
X-Message-ID-Hash: WEFNRWKNFWQUSWUDVH5VSCXGYLMH6XR4
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleix
 ner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WEFNRWKNFWQUSWUDVH5VSCXGYLMH6XR4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IEFtIDA4LjAyLjIwMjEgdW0gMjI6MTMgc2NocmllYiBNaWtlIFJhcG9wb3J0IDxycHB0QGtl
cm5lbC5vcmc+Og0KPiANCj4g77u/T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMTA6Mjc6MThBTSAr
MDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+PiBPbiAwOC4wMi4yMSAwOTo0OSwgTWlr
ZSBSYXBvcG9ydCB3cm90ZToNCj4+IA0KPj4gU29tZSBxdWVzdGlvbnMgKGFuZCByZXF1ZXN0IHRv
IGRvY3VtZW50IHRoZSBhbnN3ZXJzKSBhcyB3ZSBub3cgYWxsb3cgdG8gaGF2ZQ0KPj4gdW5tb3Zh
YmxlIGFsbG9jYXRpb25zIGFsbCBvdmVyIHRoZSBwbGFjZSBhbmQgSSBkb24ndCBzZWUgYSBzaW5n
bGUgY29tbWVudA0KPj4gcmVnYXJkaW5nIHRoYXQgaW4gdGhlIGNvdmVyIGxldHRlcjoNCj4+IA0K
Pj4gMS4gSG93IHdpbGwgdGhlIGlzc3VlIG9mIHBsZW50eSBvZiB1bm1vdmFibGUgYWxsb2NhdGlv
bnMgZm9yIHVzZXIgc3BhY2UgYmUNCj4+IHRhY2tsZWQgaW4gdGhlIGZ1dHVyZT8NCj4+IA0KPj4g
Mi4gSG93IGhhcyB0aGlzIGlzc3VlIGJlZW4gZG9jdW1lbnRlZD8gRS5nLiwgaW50ZXJhY3Rpb24g
d2l0aCBaT05FX01PVkFCTEUNCj4+IGFuZCBDTUEsIGFsbG9jX2NvbmlnX3JhbmdlKCkvYWxsb2Nf
Y29udGlnX3BhZ2VzPy4NCj4gDQo+IFNlY3JldG1lbSBzZXRzIHRoZSBtYXBwaW5ncyBnZnAgbWFz
ayB0byBHRlBfSElHSFVTRVIsIHNvIGl0IGRvZXMgbm90DQo+IGFsbG9jYXRlIG1vdmFibGUgcGFn
ZXMgYXQgdGhlIGZpcnN0IHBsYWNlLg0KDQpUaGF0IGlzIG5vdCB0aGUgcG9pbnQuIFNlY3JldG1l
bSBjYW5ub3QgZ28gb24gQ01BIC8gWk9ORV9NT1ZBQkxFIG1lbW9yeSBhbmQgYmVoYXZlcyBsaWtl
IGxvbmctdGVybSBwaW5uaW5ncyBpbiB0aGF0IHNlbnNlLiBUaGlzIGlzIGEgcmVhbCBpc3N1ZSB3
aGVuIHVzaW5nIGEgbG90IG9mIHNlY3RyZW1lbS4NCg0KUGxlYXNlIGhhdmUgYSBsb29rIGF0IHdo
YXQgUGF2ZWwgZG9jdW1lbnRzIHJlZ2FyZGluZyBsb25nIHRlcm0gcGlubmluZ3MgYW5kIFpPTkVf
TU9WQUJMRSBpbiBoaXMgcGF0Y2hlcyBjdXJyZW50bHkgb24gdGhlIGxpc3QuDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
