Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F3277B31
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 23:41:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACAD51549F120;
	Thu, 24 Sep 2020 14:41:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7B23515497D67
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:41:47 -0700 (PDT)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1600983706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pHEGyEcLx4wAmD4wOcYy6+1bBrCfu6/M5kZTaPojpLc=;
	b=V/0YgUUjSutKM6r9bxwG5tb9ogVoqfQx9kIqxlv050A3WtkIwkP25hdHO39JClpSRIjMJk
	W4I+d3emlleQNteUwDcv5dXLZ+ZIEizU828AoQc0PajblNYEydlMPRW8apMt6jk+IOFAhm
	4ZtezxYnq4GeUHKpArLIi1Lr6xH/3OY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-AHPY_LVaPdCRg7ChEqHXPg-1; Thu, 24 Sep 2020 17:41:44 -0400
X-MC-Unique: AHPY_LVaPdCRg7ChEqHXPg-1
Received: by mail-wr1-f70.google.com with SMTP id l17so222391wrw.11
        for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=g/Xbd+gOY1D7k7S7s+pOd/hTecpIxif1KV3RUcYn5rQ=;
        b=M+fjRDe2T60S0OF1LhZquv1e5Xqg32kvoy0HQXh41plXKlEGDTeeOPdPmMgPAVB4UQ
         AR2o6pzMRUltF9+5oPj5DY0PqV9uqxO5VQEyKon+zmRpMB7i39S4gmpCqlUaiz7XIPYt
         E1qx33JV9Or4EonsKMAsks44WZCIVjB34p8XoeIyZHSYB0CnktLdIR4HrqxRnSi2RvNJ
         YjOdXMDF7P2Gu+ytuR7Vq6Gdvd/zDjQ72TH2cmZ7THevs9GJBE2BQwtDNz0duSYMM8S5
         xN6Sp6VVKWISw+R5RBAyCiKSYwiLXMWv1K3ZhOpjO8Jo8I4kNic5KXUYzHP5MsRLc7YF
         BW0A==
X-Gm-Message-State: AOAM531lf+OcJdJ96ij16ykf/8OJLUA8hZ+cuVEUTTNN84T5QnQ8THaA
	feACJsloEe0mv3yR19rq0OBTgs6M1RZfLVI6KE6EtzCmmT4AsBfbHGzBoZfLfj0ArGZlCmo4nBk
	GOAy+eaGUDk4FLi4jXK26
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1019734wrr.105.1600983703565;
        Thu, 24 Sep 2020 14:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcmOcMLK9ieZTe6UE9SIsXG/tKkkWvHxZX+em+xkUyTPxjCgMj7blLOZyUvF+KwveIZvdq7w==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr1019712wrr.105.1600983703320;
        Thu, 24 Sep 2020 14:41:43 -0700 (PDT)
Received: from localhost.localdomain (p4ff23f51.dip0.t-ipconnect.de. [79.242.63.81])
        by smtp.gmail.com with ESMTPSA id e13sm490886wre.60.2020.09.24.14.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 14:41:42 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
Date: Thu, 24 Sep 2020 23:41:41 +0200
Message-Id: <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
References: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
In-Reply-To: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (18A373)
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: T4V4TQR3KVYBRRXAEKDY54WGVKMBLR6E
X-Message-ID-Hash: T4V4TQR3KVYBRRXAEKDY54WGVKMBLR6E
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: David Hildenbrand <david@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T4V4TQR3KVYBRRXAEKDY54WGVKMBLR6E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQoNCj4gQW0gMjQuMDkuMjAyMCB1bSAyMzoyNiBzY2hyaWViIERhbiBXaWxsaWFtcyA8ZGFuLmou
d2lsbGlhbXNAaW50ZWwuY29tPjoNCj4gDQo+IO+7v1suLl0NCj4+PiBJJ20gbm90IHN1Z2dlc3Rp
bmcgdG8gYnVzeSB0aGUgd2hvbGUgInZpcnRpbyIgcmFuZ2UsIGp1c3QgdGhlIHBvcnRpb24NCj4+
PiB0aGF0J3MgYWJvdXQgdG8gYmUgcGFzc2VkIHRvIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQo
KS4NCj4+IA0KPj4gSSdtIGFmcmFpZCBJIGRvbid0IGdldCB5b3VyIHBvaW50LiBGb3IgdmlydGlv
LW1lbToNCj4+IA0KPj4gQmVmb3JlOg0KPj4gDQo+PiAxLiBDcmVhdGUgdmlydGlvMCBjb250YWlu
ZXIgcmVzb3VyY2UNCj4+IA0KPj4gMi4gKHNvbWV3aGVuIGluIHRoZSBmdXR1cmUpIGFkZF9tZW1v
cnlfZHJpdmVyX21hbmFnZWQoKQ0KPj4gLSBDcmVhdGUgcmVzb3VyY2UgKFN5c3RlbSBSQU0gKHZp
cnRpb19tZW0pKSwgbWFya2luZyBpdCBidXN5L2RyaXZlcg0KPj4gICBtYW5hZ2VkDQo+PiANCj4+
IEFmdGVyOg0KPj4gDQo+PiAxLiBDcmVhdGUgdmlydGlvMCBjb250YWluZXIgcmVzb3VyY2UNCj4+
IA0KPj4gMi4gKHNvbWV3aGVuIGluIHRoZSBmdXR1cmUpIENyZWF0ZSByZXNvdXJjZSAoU3lzdGVt
IFJBTSAodmlydGlvX21lbSkpLA0KPj4gICBtYXJraW5nIGl0IGJ1c3kvZHJpdmVyIG1hbmFnZWQN
Cj4+IDMuIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKQ0KPj4gDQo+PiBOb3QgaGVscGZ1bCBv
ciBzaW1wbGVyIElNSE8uDQo+IA0KPiBUaGUgY29uY2VybiBJJ20gdHJ5aW5nIHRvIGFkZHJlc3Mg
aXMgdGhlIHRoZW9yZXRpY2FsIHJhY2Ugd2luZG93IGFuZA0KPiBsYXllcmluZyB2aW9sYXRpb24g
aW4gdGhpcyBzZXF1ZW5jZSBpbiB0aGUga21lbSBkcml2ZXI6DQo+IA0KPiAxLyByZXMgPSByZXF1
ZXN0X21lbV9yZWdpb24oLi4uKTsNCj4gMi8gcmVzLT5mbGFncyA9IElPUkVTT1VSQ0VfTUVNOw0K
PiAzLyBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCk7DQo+IA0KPiBCZXR3ZWVuIDIvIGFuZCAz
LyBzb21ldGhpbmcgY2FuIHJhY2UgYW5kIHRoaW5rIHRoYXQgaXQgb3ducyB0aGUNCj4gcmVnaW9u
LiBEbyBJIHRoaW5rIGl0IHdpbGwgaGFwcGVuIGluIHByYWN0aWNlLCBubywgYnV0IGl0J3Mgc3Rp
bGwgYQ0KPiBwYXR0ZXJuIHRoYXQgZGVzZXJ2ZXMgY29tZSBjbGVhbnVwLg0KDQpJIHRoaW5rIGlu
IHRoYXQgdW5saWtlbHkgZXZlbnQgKHJhdGhlciBpbXBvc3NpYmxlKSwgYWRkX21lbW9yeV9kcml2
ZXJfbWFuYWdlZCgpIHNob3VsZCBmYWlsLCBkZXRlY3RpbmcgYSBjb25mbGljdGluZyAoYnVzeSkg
cmVzb3VyY2UuIE5vdCBzdXJlIHdoYXQgd2lsbCBoYXBwZW4gbmV4dCAoIGFuZCBkaWQgbm90IGRv
dWJsZS1jaGVjaykuDQoNCkJ1dCB5ZWFoLCB0aGUgd2F5IHRoZSBCVVNZIGJpdCBpcyBjbGVhcmVk
IGhlcmUgaXMgd3JvbmcgLSBzaW1wbHkgb3ZlcndyaXRpbmcgb3RoZXIgYml0cy4gQW5kIGl0IHdv
dWxkIGJlIGV2ZW4gYmV0dGVyIGlmIHdlIGNvdWxkIGF2b2lkIG1hbnVhbGx5IG1lc3Npbmcgd2l0
aCBmbGFncyBoZXJlLg0KPiANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
