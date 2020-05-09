Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF71CBDCF
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 07:40:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A0C81191801A;
	Fri,  8 May 2020 22:38:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-1.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECCF711917FD4
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1589002838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wLITgYcnji+lI1/U32+qXSFD10JDWBM8uaMukB/H0iE=;
	b=Vvq7p2COu54dnAF91J5b9coXg6xBMBrNC1ITP4XaahwV19SZg5bDZOZrKQKP0vNlqANjAx
	OGWLfRenVrKQpfY76U9EaDs7e3ZD/NnPg67pACRsbxFWbRVbP0a4yKUUCL1reN2XZTrAyJ
	fBbfgECupXDxCrf0ix+skxcPRkmyig0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Hl-zLirNNuWyO2PZx9HIvA-1; Sat, 09 May 2020 01:40:37 -0400
X-MC-Unique: Hl-zLirNNuWyO2PZx9HIvA-1
Received: by mail-wm1-f70.google.com with SMTP id w2so6245400wmc.3
        for <linux-nvdimm@lists.01.org>; Fri, 08 May 2020 22:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=mTjszWW/EefMrw7aIGeEPuK1Cqsav+nLkGOW2S21ZN0=;
        b=Ox73P/2qA00Slvm0ci4ZR6lo+B6MsMbMAzlOnBt9pVXAtcEvW0yzmrLv50vKpb2+MJ
         A0k+jcqx0K7GftBmaHB97zOKN83WWQMzwv8uC7y9hFtlwk4ZXFtfNvPQVp4y06P42/Sw
         D8oLJm0yr4z+awsguxIa/680I+4fUm6EunRif7zmX8CMIfObeNFeNOnNfBTJg068nj3f
         /PPQAqz5YA1G3tFRuNn7uHMfzGuWye+42O7YNpXxTaEyEGWJhKQ+zyjdzr4PEMYvWBQ5
         PA+FEWCoicghnS62kk3OJZCGQIVe68/oP1PCL1NWtDow2UwtzUn15ud6B+RTc0dgVQ04
         G6xQ==
X-Gm-Message-State: AGi0PuaG6vKb4ZG02/agQ+b5FocrH3ECiOM6ygSDKph9t+dOtpApfFIL
	RQlGIQW6oY4rgD4B5EAz2t5LY0PaTIAyFZbU21lhMGzw0blESoUxq2X3JZGrGIQrOXXAX4GTG/l
	Hywo5Wj7RblbGc/SOs3ZJ
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr7021358wrv.334.1589002836112;
        Fri, 08 May 2020 22:40:36 -0700 (PDT)
X-Google-Smtp-Source: APiQypLh46b+OJHiK+BmOVxHBKBIBg126/s6UEDmzeKxMWF5zY7CcNlENVRlnP1JVfzUUAXHjN/rxA==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr7021307wrv.334.1589002835393;
        Fri, 08 May 2020 22:40:35 -0700 (PDT)
Received: from ?IPv6:2a01:598:b901:53f:9037:7517:2497:29c? ([2a01:598:b901:53f:9037:7517:2497:29c])
        by smtp.gmail.com with ESMTPSA id z6sm437028wrq.1.2020.05.08.22.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 22:40:34 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/4] device-dax: Don't leak kernel memory to user space after unloading kmem
Date: Sat, 9 May 2020 07:40:33 +0200
Message-Id: <B72EB609-44DC-4133-820C-9BEA95CA012D@redhat.com>
References: <20200508165306.7cd806f7e451c5c9bc2a40ac@linux-foundation.org>
In-Reply-To: <20200508165306.7cd806f7e451c5c9bc2a40ac@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: Z6WC4HPS7TIUTQ2E757UJ7IHPQQQXIIT
X-Message-ID-Hash: Z6WC4HPS7TIUTQ2E757UJ7IHPQQQXIIT
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z6WC4HPS7TIUTQ2E757UJ7IHPQQQXIIT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gQW0gMDkuMDUuMjAyMCB1bSAwMTo1MyBzY2hyaWViIEFuZHJldyBNb3J0b24gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+Og0KPiANCj4g77u/T24gRnJpLCAgOCBNYXkgMjAyMCAxMDo0
MjoxNCArMDIwMCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
IA0KPj4gQXNzdW1lIHdlIGhhdmUga21lbSBjb25maWd1cmVkIGFuZCBsb2FkZWQ6DQo+PiAgW3Jv
b3RAbG9jYWxob3N0IH5dIyBjYXQgL3Byb2MvaW9tZW0NCj4+ICAuLi4NCj4+ICAxNDAwMDAwMDAt
MzNmZmZmZmZmIDogUGVyc2lzdGVudCBNZW1vcnkkDQo+PiAgICAxNDAwMDAwMDAtMTQ4MWZmZmZm
IDogbmFtZXNwYWNlMC4wDQo+PiAgICAxNTAwMDAwMDAtMzNmZmZmZmZmIDogZGF4MC4wDQo+PiAg
ICAgIDE1MDAwMDAwMC0zM2ZmZmZmZmYgOiBTeXN0ZW0gUkFNDQo+PiANCj4+IEFzc3VtZSB3ZSB0
cnkgdG8gdW5sb2FkIGttZW0uIFRoaXMgZm9yY2UtdW5sb2FkaW5nIHdpbGwgd29yaywgZXZlbiBp
Zg0KPj4gbWVtb3J5IGNhbm5vdCBnZXQgcmVtb3ZlZCBmcm9tIHRoZSBzeXN0ZW0uDQo+PiAgW3Jv
b3RAbG9jYWxob3N0IH5dIyBybW1vZCBrbWVtDQo+PiAgWyAgIDg2LjM4MDIyOF0gcmVtb3Zpbmcg
bWVtb3J5IGZhaWxzLCBiZWNhdXNlIG1lbW9yeSBbMHgwMDAwMDAwMTUwMDAwMDAwLTB4MDAwMDAw
MDE1N2ZmZmZmZl0gaXMgb25saW5lZA0KPj4gIC4uLg0KPj4gIFsgICA4Ni40MzEyMjVdIGttZW0g
ZGF4MC4wOiBEQVggcmVnaW9uIFttZW0gMHgxNTAwMDAwMDAtMHgzM2ZmZmZmZmZdIGNhbm5vdCBi
ZSBob3RyZW1vdmVkIHVudGlsIHRoZSBuZXh0IHJlYm9vdA0KPj4gDQo+PiBOb3csIHdlIGNhbiBy
ZWNvbmZpZ3VyZSB0aGUgbmFtZXNwYWNlOg0KPj4gIFtyb290QGxvY2FsaG9zdCB+XSMgbmRjdGwg
Y3JlYXRlLW5hbWVzcGFjZSAtLWZvcmNlIC0tcmVjb25maWc9bmFtZXNwYWNlMC4wIC0tbW9kZT1k
ZXZkYXgNCj4+ICBbICAxMzEuNDA5MzUxXSBuZF9wbWVtIG5hbWVzcGFjZTAuMDogY291bGQgbm90
IHJlc2VydmUgcmVnaW9uIFttZW0gMHgxNDAwMDAwMDAtMHgzM2ZmZmZmZmZdZGF4DQo+PiAgWyAg
MTMxLjQxMDE0N10gbmRfcG1lbTogcHJvYmUgb2YgbmFtZXNwYWNlMC4wIGZhaWxlZCB3aXRoIGVy
cm9yIC0xNm5hbWVzcGFjZTAuMCAtLW1vZGU9ZGV2ZGF4DQo+PiAgLi4uDQo+PiANCj4+IFRoaXMg
ZmFpbHMgYXMgZXhwZWN0ZWQgZHVlIHRvIHRoZSBidXN5IG1lbW9yeSByZXNvdXJjZSwgYW5kIHRo
ZSBtZW1vcnkNCj4+IGNhbm5vdCBiZSB1c2VkLiBIb3dldmVyLCB0aGUgZGF4MC4wIGRldmljZSBp
cyByZW1vdmVkLCBhbmQgYWxvbmcgaXRzIG5hbWUuDQo+PiANCj4+IFRoZSBuYW1lIG9mIHRoZSBt
ZW1vcnkgcmVzb3VyY2Ugbm93IHBvaW50cyBhdCBmcmVlZCBtZW1vcnkgKG5hbWUgb2YgdGhlDQo+
PiBkZXZpY2UpLg0KPj4gIFtyb290QGxvY2FsaG9zdCB+XSMgY2F0IC9wcm9jL2lvbWVtDQo+PiAg
Li4uDQo+PiAgMTQwMDAwMDAwLTMzZmZmZmZmZiA6IFBlcnNpc3RlbnQgTWVtb3J5DQo+PiAgICAx
NDAwMDAwMDAtMTQ4MWZmZmZmIDogbmFtZXNwYWNlMC4wDQo+PiAgICAxNTAwMDAwMDAtMzNmZmZm
ZmZmIDog77+9X++/vV43X++/ve+/vS9f77+977+9d1Lvv73vv71XUe+/ve+/ve+/vV7vv73vv73v
v70gLi4uDQo+PiAgICAxNTAwMDAwMDAtMzNmZmZmZmZmIDogU3lzdGVtIFJBTQ0KPj4gDQo+PiBX
ZSBoYXZlIHRvIG1ha2Ugc3VyZSB0byBkdXBsaWNhdGUgdGhlIHN0cmluZy4gV2hpbGUgYXQgaXQs
IHJlbW92ZSB0aGUNCj4+IHN1cGVyZmx1b3VzIHNldHRpbmcgb2YgdGhlIG5hbWUgYW5kIGZpeHVw
IGEgc3RhbGUgY29tbWVudC4NCj4+IA0KPj4gRml4ZXM6IDlmOTYwZGE3MmIyNSAoImRldmljZS1k
YXg6ICJIb3RyZW1vdmUiIHBlcnNpc3RlbnQgbWVtb3J5IHRoYXQgaXMgdXNlZCBsaWtlIG5vcm1h
bCBSQU0iKQ0KPj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyB2NS4zDQo+IA0KPiBobS4N
Cj4gDQo+IElzIHRoaXMgcmVhbGx5IC1zdGFibGUgbWF0ZXJpYWw/ICBUaGVzZSBhcmUgYWxsIHBy
aXZpbGVnZWQgb3BlcmF0aW9ucywNCj4gSSBleHBlY3Q/DQoNClllcywgbXkgdGhvdWdodCB3YXMg
cmF0aGVyIHRoYXQgYW4gYWRtaW4gY291bGQgYnJpbmcgdGhlIHN5c3RlbSBpbnRvIHN1Y2ggYSBz
dGF0ZSAoYnkgbWlzdGFrZT8pLiBMZXTigJhzIHNlZSBpZiBzb21lYm9keSBoYXMgYSBzdWdnZXN0
aW9uLg0KDQpJIGd1ZXNzIGlmIHdlIHdlcmUgcmVhbGx5IHVubHVja3ksIHdlIGNvdWxkIGFjY2Vz
cyBpbnZhbGlkIG1lbW9yeSBhbmQgdHJpZ2dlciBhIEJVRyAoZS5nLiwgcGFnZSBhdCB0aGUgZW5k
IG9mIG1lbW9yeSBhbmQgZG9lcyBub3QgY29udGFpbiBhIDAgYnl0ZSkuDQoNCj4gDQo+IEFzc3Vt
aW5nICJ5ZXMiLCBJJ3ZlIHF1ZXVlZCB0aGlzIHNlcGFyYXRlbHksIHN0YWdlZCBmb3IgNS43LXJj
WC4gIEknbGwNCj4gcmVkbyBwYXRjaGVzIDItNCBhcyBhIHRocmVlLXBhdGNoIHNlcmllcyBmb3Ig
NS44LXJjMS4NCg0KTWFrZSBzZW5zZSwgbGV04oCYcyB3YWl0IGZvciByZXZpZXcgZmVlZGJhY2ss
IHRoYW5rcyENCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
