Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C418277B44
	for <lists+linux-nvdimm@lfdr.de>; Thu, 24 Sep 2020 23:50:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 647DD154A11E5;
	Thu, 24 Sep 2020 14:50:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C919C154A11E5
	for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:50:16 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j2so418509eds.9
        for <linux-nvdimm@lists.01.org>; Thu, 24 Sep 2020 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VhJeuoj+rOPSJ4IEGV+fYVhmYT10xm972NsSejdMkBg=;
        b=mpx4PkaUmFFwA1xtz/GJ0EVr677LvVWAywlSsSBXx0ShG6AZt57DEjUoyvLg2RGr7Z
         XcGgHUDzZZ6KrvKq3epkk490qeNIFUZ7WVyzH3k2hV1MN72qalnnNSh1ZNSDRi2MLtBr
         E72zTYmp0vKyrWmKXZxOsV3KnQVii0Sr3ANFsR+bCuFKdWlMgcIpCImgEkZKy8/R+I2s
         sqwBTgWf3Vh9dt4g2rUdVd4/T2tJRyZNBbd2wGucpyMBqUgIUxJmtMstfGcJI553/ICm
         BHqlmsbvM2Oar8F97gSEIPFqlW9TLbnrBzxk9NNJIwT7vjE1gUjc8bXNcqREFCuIjxEE
         vIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VhJeuoj+rOPSJ4IEGV+fYVhmYT10xm972NsSejdMkBg=;
        b=qxlgg1jpeMzQBWsQ2eZ5rVfeGZbVaB2msZv9rNVKj0gFjJYWQRAo2nAKwh/SfL+xzw
         QMIe6GjoxHCXrAgifzPlnc+zST4nwphjjPTPuVDPztGcMzUN2qe1A5TrCG8d3+Dm2p4Q
         ft5e9Okfg2ryPPILzV0a3kXdV5DzErnT4fZxMxuA9kd5hKN0Hq1pcDt1VVNcurC/ZmEq
         oCyAcO/npL0KyO36BX5hQUmgDXvOUSdq9yfuWmpvDflrgSr3wmcbswLlha3HpA/Z7crD
         AYdiContbSsCTv0m2vIQhbGmqWpDyjpDP40Z3v+po7u/aZjpU+VY+ZkD2cqVo0+99QPK
         U9NA==
X-Gm-Message-State: AOAM531FL02OpgRjN5uCLK9ocN6ZtVSgzhB5TyOGlbBKkVxEETlDEAxW
	f2DghQTaXlKqhLfvz2BdU7Ec4Q1fhTIrZbTZ23q+kw==
X-Google-Smtp-Source: ABdhPJwxLNwMbKBfN2GZNfdh2odn88qLZ8Gba3MAPoetXp02KpOblT44U8/Ptt6lHHhBfbX75bgCKW+Q3RCxXi3Ppoc=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr884128edq.300.1600984214693;
 Thu, 24 Sep 2020 14:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4iQ4VnXMU0+_7rfXwPowgcdoABSFUH4WO_3P9vHtWAzPg@mail.gmail.com>
 <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
In-Reply-To: <79BEC711-C769-432B-9A50-63C6A3AEB0E3@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 24 Sep 2020 14:50:03 -0700
Message-ID: <CAPcyv4jsUiXTqDtnh_fnm_p4NaX2=c3rrjFe6Efa-oWPkTe-fA@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] device-dax: Kill dax_kmem_res
To: David Hildenbrand <david@redhat.com>
Message-ID-Hash: FLQI5BCYNJJHYIGOJVWS4FQLZYZJ6LCJ
X-Message-ID-Hash: FLQI5BCYNJJHYIGOJVWS4FQLZYZJ6LCJ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Joao Martins <joao.m.martins@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FLQI5BCYNJJHYIGOJVWS4FQLZYZJ6LCJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBTZXAgMjQsIDIwMjAgYXQgMjo0MiBQTSBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+DQo+DQo+DQo+ID4gQW0gMjQuMDkuMjAyMCB1bSAyMzoyNiBz
Y2hyaWViIERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjoNCj4gPg0KPiA+
IO+7v1suLl0NCj4gPj4+IEknbSBub3Qgc3VnZ2VzdGluZyB0byBidXN5IHRoZSB3aG9sZSAidmly
dGlvIiByYW5nZSwganVzdCB0aGUgcG9ydGlvbg0KPiA+Pj4gdGhhdCdzIGFib3V0IHRvIGJlIHBh
c3NlZCB0byBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCkuDQo+ID4+DQo+ID4+IEknbSBhZnJh
aWQgSSBkb24ndCBnZXQgeW91ciBwb2ludC4gRm9yIHZpcnRpby1tZW06DQo+ID4+DQo+ID4+IEJl
Zm9yZToNCj4gPj4NCj4gPj4gMS4gQ3JlYXRlIHZpcnRpbzAgY29udGFpbmVyIHJlc291cmNlDQo+
ID4+DQo+ID4+IDIuIChzb21ld2hlbiBpbiB0aGUgZnV0dXJlKSBhZGRfbWVtb3J5X2RyaXZlcl9t
YW5hZ2VkKCkNCj4gPj4gLSBDcmVhdGUgcmVzb3VyY2UgKFN5c3RlbSBSQU0gKHZpcnRpb19tZW0p
KSwgbWFya2luZyBpdCBidXN5L2RyaXZlcg0KPiA+PiAgIG1hbmFnZWQNCj4gPj4NCj4gPj4gQWZ0
ZXI6DQo+ID4+DQo+ID4+IDEuIENyZWF0ZSB2aXJ0aW8wIGNvbnRhaW5lciByZXNvdXJjZQ0KPiA+
Pg0KPiA+PiAyLiAoc29tZXdoZW4gaW4gdGhlIGZ1dHVyZSkgQ3JlYXRlIHJlc291cmNlIChTeXN0
ZW0gUkFNICh2aXJ0aW9fbWVtKSksDQo+ID4+ICAgbWFya2luZyBpdCBidXN5L2RyaXZlciBtYW5h
Z2VkDQo+ID4+IDMuIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKQ0KPiA+Pg0KPiA+PiBOb3Qg
aGVscGZ1bCBvciBzaW1wbGVyIElNSE8uDQo+ID4NCj4gPiBUaGUgY29uY2VybiBJJ20gdHJ5aW5n
IHRvIGFkZHJlc3MgaXMgdGhlIHRoZW9yZXRpY2FsIHJhY2Ugd2luZG93IGFuZA0KPiA+IGxheWVy
aW5nIHZpb2xhdGlvbiBpbiB0aGlzIHNlcXVlbmNlIGluIHRoZSBrbWVtIGRyaXZlcjoNCj4gPg0K
PiA+IDEvIHJlcyA9IHJlcXVlc3RfbWVtX3JlZ2lvbiguLi4pOw0KPiA+IDIvIHJlcy0+ZmxhZ3Mg
PSBJT1JFU09VUkNFX01FTTsNCj4gPiAzLyBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCk7DQo+
ID4NCj4gPiBCZXR3ZWVuIDIvIGFuZCAzLyBzb21ldGhpbmcgY2FuIHJhY2UgYW5kIHRoaW5rIHRo
YXQgaXQgb3ducyB0aGUNCj4gPiByZWdpb24uIERvIEkgdGhpbmsgaXQgd2lsbCBoYXBwZW4gaW4g
cHJhY3RpY2UsIG5vLCBidXQgaXQncyBzdGlsbCBhDQo+ID4gcGF0dGVybiB0aGF0IGRlc2VydmVz
IGNvbWUgY2xlYW51cC4NCj4NCj4gSSB0aGluayBpbiB0aGF0IHVubGlrZWx5IGV2ZW50IChyYXRo
ZXIgaW1wb3NzaWJsZSksIGFkZF9tZW1vcnlfZHJpdmVyX21hbmFnZWQoKSBzaG91bGQgZmFpbCwg
ZGV0ZWN0aW5nIGEgY29uZmxpY3RpbmcgKGJ1c3kpIHJlc291cmNlLiBOb3Qgc3VyZSB3aGF0IHdp
bGwgaGFwcGVuIG5leHQgKCBhbmQgZGlkIG5vdCBkb3VibGUtY2hlY2spLg0KDQphZGRfbWVtb3J5
X2RyaXZlcl9tYW5hZ2VkKCkgd2lsbCBmYWlsLCBidXQgdGhlIHJlbGVhc2VfbWVtX3JlZ2lvbigp
IGluDQprbWVtIHRvIHVud2luZCBvbiB0aGUgZXJyb3IgcGF0aCB3aWxsIGRvIHRoZSB3cm9uZyB0
aGluZyBiZWNhdXNlIHRoYXQNCm90aGVyIGRyaXZlciB0aGlua3MgaXQgZ290IG93bmVyc2hpcCBv
ZiB0aGUgcmVnaW9uLg0KDQo+IEJ1dCB5ZWFoLCB0aGUgd2F5IHRoZSBCVVNZIGJpdCBpcyBjbGVh
cmVkIGhlcmUgaXMgd3JvbmcgLSBzaW1wbHkgb3ZlcndyaXRpbmcgb3RoZXIgYml0cy4gQW5kIGl0
IHdvdWxkIGJlIGV2ZW4gYmV0dGVyIGlmIHdlIGNvdWxkIGF2b2lkIG1hbnVhbGx5IG1lc3Npbmcg
d2l0aCBmbGFncyBoZXJlLg0KDQpJJ20gb2sgdG8gbGVhdmUgaXQgYWxvbmUgZm9yIG5vdyAoaGFz
bid0IGJlZW4gYW5kIGxpa2VseSBuZXZlciB3aWxsIGJlDQphIHByb2JsZW0gaW4gcHJhY3RpY2Up
LCBidXQgSSB0aGluayBpdCB3YXMgc3RpbGwgd29ydGggZ3J1bWJsaW5nDQphYm91dC4gSSdsbCBs
ZWF2ZSB0aGF0IHBhcnQgb2Yga21lbSBhbG9uZSBpbiB0aGUgdXBjb21pbmcgc3BsaXQgb2YNCmRh
eF9rbWVtX3JlcyByZW1vdmFsLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
