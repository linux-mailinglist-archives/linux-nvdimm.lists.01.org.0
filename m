Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 978572F5A99
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 07:18:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF414100F2265;
	Wed, 13 Jan 2021 22:18:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5F433100F2252
	for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 22:18:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d17so6527830ejy.9
        for <linux-nvdimm@lists.01.org>; Wed, 13 Jan 2021 22:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V6f56GHlvX+30vh+DfZsExZ/lVAivzj42R6p1vKO9YA=;
        b=1VxNfJeYo2SCW48DoIhJXUv4ZH/NwkAwPSchXiBWcyb0pHcnoyYSzydSAPwShL9/w+
         LsvaAe7mF6uXUVEFgv5fSiXdCtUeZ3JEhabsZ1Ccl7uxjM2smFWVoo+HEHwyfNwaow7L
         8S9JJletV2OtIkQzBQrT4j7RXy0gfBR2aSiYdcTGriyLkQBsMghrRWwKrTSSGixJta+E
         JTAaiD6v8ePqVmOmR6wmW6fYZrqwpxpMlS8fPgie+k9CvynrC5o/6nbXAQHkMjMi+pv1
         tC0vWVPGaRdnesbjLjoyy6C8l2CbwOBjauh1Df9fiTLBZSzOFVKd8W/XZmcJvLwD0bkw
         qoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V6f56GHlvX+30vh+DfZsExZ/lVAivzj42R6p1vKO9YA=;
        b=F9/APulB/vBMhYC9IbERgxwLiBDz7x+MUoIGwAvmPTMr48GW4ITHAipQ4eZxFj1tnW
         Y21G1d/SzE3mxFtce4JJQkbMMxCwOM9O21LeT6V0jnlU9EY+SzvuX1lRENLjdwVwVl+s
         Qlgg2knolkABQLkkDGsnYkVGGHjJzaMoquvoORcfPtLdYrTKcXzBspiHhqcU3JXHZTV/
         F3A/HmuSIocXY5/lsdL5mp0rU3SXGBccU8heZG6i0kQz65boG0Qf8xvUIq21LRrt+euf
         TbbVbXdSweUUcw4aCx5hu1n/PV6yz0wM+cs7DUlhKvCH29Wjodp/Tjbzjaq+p5wFzttg
         C60g==
X-Gm-Message-State: AOAM533kOpw9f4blID2eS47nfqC1DaDpB3KUnXR6O4MW65NbthH7A97w
	6aENBoWzUwZgduaev2WoMpqISvyAUb8DajWjtxKJmQ==
X-Google-Smtp-Source: ABdhPJxrgOBl9xEDA1Gqh4koRRCp2CcKtKLfmgUGiGQTbaKZpts+wK9W7/mgOVdXnyraOhZw/5TvuyhbRoA/6YubSNk=
X-Received: by 2002:a17:906:a29a:: with SMTP id i26mr4116106ejz.45.1610605097907;
 Wed, 13 Jan 2021 22:18:17 -0800 (PST)
MIME-Version: 1.0
References: <161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161058501210.1840162.8108917599181157327.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210114014944.GA16873@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20210114014944.GA16873@hori.linux.bs1.fc.nec.co.jp>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Jan 2021 22:18:09 -0800
Message-ID: <CAPcyv4gVPMUD7P0KwAY9xk3xBkodPExeJVG6i9=9FGexbJZpBw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: Fix page reference leak in soft_offline_page()
To: =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= <naoya.horiguchi@nec.com>
Message-ID-Hash: GSZA3SLM6CY7XOWACIKSEZOE3YRYOP74
X-Message-ID-Hash: GSZA3SLM6CY7XOWACIKSEZOE3YRYOP74
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GSZA3SLM6CY7XOWACIKSEZOE3YRYOP74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBKYW4gMTMsIDIwMjEgYXQgNTo1MCBQTSBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+j44CA
55u05LmfKQ0KPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPiB3cm90ZToNCj4NCj4gT24gV2VkLCBK
YW4gMTMsIDIwMjEgYXQgMDQ6NDM6MzJQTSAtMDgwMCwgRGFuIFdpbGxpYW1zIHdyb3RlOg0KPiA+
IFRoZSBjb252ZXJzaW9uIHRvIG1vdmUgcGZuX3RvX29ubGluZV9wYWdlKCkgaW50ZXJuYWwgdG8N
Cj4gPiBzb2Z0X29mZmxpbmVfcGFnZSgpIG1pc3NlZCB0aGF0IHRoZSBnZXRfdXNlcl9wYWdlcygp
IHJlZmVyZW5jZSB0YWtlbiBieQ0KPiA+IHRoZSBtYWR2aXNlKCkgcGF0aCBuZWVkcyB0byBiZSBk
cm9wcGVkIHdoZW4gcGZuX3RvX29ubGluZV9wYWdlKCkgZmFpbHMuDQo+ID4gTm90ZSB0aGUgZGly
ZWN0IHN5c2ZzLXBhdGggdG8gc29mdF9vZmZsaW5lX3BhZ2UoKSBkb2VzIG5vdCBwZXJmb3JtIGEN
Cj4gPiBnZXRfdXNlcl9wYWdlcygpIGxvb2t1cC4NCj4gPg0KPiA+IFdoZW4gc29mdF9vZmZsaW5l
X3BhZ2UoKSBpcyBoYW5kZWQgYSBwZm5fdmFsaWQoKSAmJg0KPiA+ICFwZm5fdG9fb25saW5lX3Bh
Z2UoKSBwZm4gdGhlIGtlcm5lbCBoYW5ncyBhdCBkYXgtZGV2aWNlIHNodXRkb3duIGR1ZSB0bw0K
PiA+IGEgbGVha2VkIHJlZmVyZW5jZS4NCj4gPg0KPiA+IEZpeGVzOiBmZWVjMjRhNjEzOWQgKCJt
bSwgc29mdC1vZmZsaW5lOiBjb252ZXJ0IHBhcmFtZXRlciB0byBwZm4iKQ0KPiA+IENjOiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBOYW95YSBIb3Jp
Z3VjaGkgPG5hby5ob3JpZ3VjaGlAZ21haWwuY29tPg0KPiA+IENjOiBNaWNoYWwgSG9ja28gPG1o
b2Nrb0BrZXJuZWwub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRv
ckBzdXNlLmRlPg0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4NCj4gSSdt
IE9LIGlmIHdlIGRvbid0IGhhdmUgYW55IG90aGVyIGJldHRlciBhcHByb2FjaCwgYnV0IHRoZSBw
cm9wb3NlZCBjaGFuZ2VzDQo+IG1ha2UgY29kZSBhIGxpdHRsZSBtZXNzeSwgYW5kIEkgZmVlbCB0
aGF0IGdldF91c2VyX3BhZ2VzKCkgbWlnaHQgYmUgdGhlDQo+IHJpZ2h0IHBsYWNlIHRvIGZpeC4g
SXMgZ2V0X3VzZXJfcGFnZXMoKSBleHBlY3RlZCB0byByZXR1cm4gc3RydWN0IHBhZ2Ugd2l0aA0K
PiBob2xkaW5nIHJlZmNvdW50IGZvciBvZmZsaW5lIHZhbGlkIHBhZ2VzPyAgSSB0aG91Z2h0IHRo
YXQgc3VjaCBwYWdlcyBhcmUNCj4gb25seSB1c2VkIGJ5IGRyaXZlcnMgZm9yIGRheC1kZXZpY2Vz
LCBidXQgdGhhdCBtaWdodCBiZSB3cm9uZy4gQ2FuIEkgYXNrIGZvcg0KPiBhIGxpdHRsZSBtb3Jl
IGV4cGxhbmF0aW9uIGZyb20gdGhpcyBwZXJzcGVjdGl2ZT8NCg0KVGhlIG1vdGl2YXRpb24gZm9y
IFpPTkVfREVWSUNFIGlzIHRvIGFsbG93IGdldF91c2VyX3BhZ2VzKCkgZm9yICJvZmZsaW5lIiBw
Zm5zLg0KDQpzb2Z0X29mZmxpbmVfcGFnZSgpIHdhbnRzIHRvIG9ubHkgb3BlcmF0ZSBvbiAib25s
aW5lIiBwZm5zLg0KDQpnZXRfdXNlcl9wYWdlcygpIG9uIGEgZGF4LW1hcHBpbmcgcmV0dXJucyBh
biAib2ZmbGluZSIgWk9ORV9ERVZJQ0UgcGFnZS4NCg0KV2hlbiBwZm5fdG9fb25saW5lX3BhZ2Uo
KSBmYWlscyB0aGUgZ2V0X3VzZXJfcGFnZXMoKSByZWZlcmVuY2UgbmVlZHMNCnRvIGJlIGRyb3Bw
ZWQuDQoNClRvIGJlIGhvbmVzdCBJIGRpc2xpa2UgdGhlIGVudGlyZSBmbGFncyBiYXNlZCBzY2hl
bWUgZm9yIGNvbW11bmljYXRpbmcNCnRoZSBmYWN0IHRoYXQgcGFnZSByZWZlcmVuY2Ugb2J0YWlu
ZWQgYnkgbWFkdmlzZSBuZWVkcyB0byBiZSBkcm9wcGVkDQpsYXRlci4gSSdkIHJhdGhlciBwYXNz
IGEgbm9uLU5VTEwgJ3N0cnVjdCBwYWdlIConIHRoYW4gcmVkbw0KcGZuX3RvX3BhZ2UoKSBjb252
ZXJzaW9ucyBpbiB0aGUgbGVhZiBmdW5jdGlvbnMsIGJ1dCB0aGF0J3MgYSBtdWNoDQpsYXJnZXIg
Y2hhbmdlLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
