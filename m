Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ED127B51C
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 21:16:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 139BA1537194D;
	Mon, 28 Sep 2020 12:16:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1AC411537194C
	for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 12:16:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id r7so10383296ejs.11
        for <linux-nvdimm@lists.01.org>; Mon, 28 Sep 2020 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7t9Bsr/Zk+WVD4Len3KHQr43DFMknMG5uZzhMcmKEdw=;
        b=Pm7U9saz6JRqJ2uM/03TX9ibWu4wgc7yu4g31n5DpvnoOs+iSuoSgpRZKsbI83jX5B
         qN4UNWbk+rIx4x3ASpKsJ97m2CVg7z7697PDw0dF0c58oc1meXmYEWLISA0XSnqAFzIj
         Eq3f5ulFBi6riKWAKWs7F1io1CDeigPB8OC1vla7TGyJl60mJMqXREZPn0KrEvmL7Gvn
         /f2MUBKlQS+igXZ5gfBxsreLlMBxxURXBJTBq/8GbI+TicDEeAxCNrc9TagtWgA9qg4k
         t8aavsg2dgGGDjRZkngptENpK0hQn6sYG7Ru+cY5U64NI23z7JbwACKnAd0c0szuzxfx
         LWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7t9Bsr/Zk+WVD4Len3KHQr43DFMknMG5uZzhMcmKEdw=;
        b=YxwXglRtv3ZSKCnc49qbE+1mSGnaGMqkwVggTgPv21wjOIW9+aYVgKs6Tsw5lB4qH1
         MHKEkSJVzT9ShG6OjNVkDUNB/nZMwj6IbNFywsIVFkjOc+3OvJfXGvBbJiyN5JlycoiT
         +Ji3wWWIBBUx6EM6i6vrp6CKQabHSYtqXqWHPZvwQKFvfgQOk8l6jwwWiTpg0d4Q2ve3
         bQheeDvglGhhXifjq5hOoalu07R/BhFfmHC/AjpW2mxjHqCEb+yS6PzfISEr6OHRTzoK
         SI65c1aueHp9wvmNoelVSBHtud3gpaB5k1F776B3n78aS5sR9812seZ3Ita0hDu4e313
         vqUg==
X-Gm-Message-State: AOAM530UhVrUFCiHmOXqngki9HkdV+xhjKorIu/f5uFndeSe+CrN/WNy
	8MzFlmbVlquIePfR2b1jmVrZsQ01weuyKccpRpLzwg==
X-Google-Smtp-Source: ABdhPJyGTdT5M9ZDR+Bv0xeVxzbX0v5eDERAtZDguvdAE+jlYwYAvNE5kybu8JT8uDS0gczApROx5q7Y4r4vDXUOkuk=
X-Received: by 2002:a17:906:14c9:: with SMTP id y9mr240964ejc.523.1601320576419;
 Mon, 28 Sep 2020 12:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200925091806.1860663-1-yanaijie@huawei.com> <CAPcyv4jgCp4_rSWs2SipiR3Jhz2jbSGWuLjtPExGDdTOEztAXA@mail.gmail.com>
 <306e724d-00f1-648c-9018-0ec1f3be9da4@huawei.com>
In-Reply-To: <306e724d-00f1-648c-9018-0ec1f3be9da4@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 28 Sep 2020 12:16:05 -0700
Message-ID: <CAPcyv4jkOf7A9KieZsiXbNvNCnoBz2C7MR1PRq1qDOE1ziXRZg@mail.gmail.com>
Subject: Re: [PATCH] device-dax: include bus.h in super.c
To: Jason Yan <yanaijie@huawei.com>
Message-ID-Hash: CTMVPRBKM7RGUAOE5LR7MNHXR253S7Y3
X-Message-ID-Hash: CTMVPRBKM7RGUAOE5LR7MNHXR253S7Y3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CTMVPRBKM7RGUAOE5LR7MNHXR253S7Y3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCBTZXAgMjcsIDIwMjAgYXQgNjoxNSBQTSBKYXNvbiBZYW4gPHlhbmFpamllQGh1YXdl
aS5jb20+IHdyb3RlOg0KPg0KPiBIaSBEYW7vvIwNCj4NCj4g5ZyoIDIwMjAvOS8yNiAyOjI0LCBE
YW4gV2lsbGlhbXMg5YaZ6YGTOg0KPiA+IE9uIEZyaSwgU2VwIDI1LCAyMDIwIGF0IDI6MTcgQU0g
SmFzb24gWWFuIDx5YW5haWppZUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPj4NCj4gPj4gVGhpcyBh
ZGRyZXNzZXMgdGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZzoNCj4gPj4NCj4gPj4gZHJpdmVy
cy9kYXgvc3VwZXIuYzo0NTI6Njogd2FybmluZzogc3ltYm9sICdydW5fZGF4JyB3YXMgbm90IGRl
Y2xhcmVkLg0KPiA+PiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiA+DQo+ID4gcnVuX2RheCgpIGlz
IGEgY29yZSBoZWxwZXIgZGVmaW5lZCBpbiBkcml2ZXJzL2RheC9zdXBlci5jIHRoYXQgaXMNCj4g
PiBtZWFudCB0byBoaWRlIHRoZSBkZWZpbml0aW9uIG9mICdzdHJ1Y3QgZGF4X2RldmljZScgZnJv
bSB0aGUgd2lkZXINCj4gPiBrZXJuZWwgdGhhdCBkb2VzIG5vdCBuZWVkIHRvIHBva2UgaW50byBp
dHMgaW50ZXJuYWxzLiBUaGVyZSdzIGFsc28gbm8NCj4gPiBuZWVkIGZvciBkcml2ZXJzL2RheC9z
dXBlci5jIHRvIGJlIGdpdmVuIGtub3dsZWRnZSBvZiBvdGhlciBjb3JlDQo+ID4gZGV0YWlscyB0
aGF0IGFyZSBjb250YWluZWQgd2l0aGluIGJ1cy5oLiBTbywgSSB0aGluayB0aGlzIHBhdGNoDQo+
ID4gcHJvdmlkZXMgbm8gdmFsdWUgYW5kIGdvZXMgYWdhaW5zdCB0aGUgcHJpbmNpcGxlIG9mIGxl
YXN0IHByaXZpbGVnZQ0KPiA+IChodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9QcmluY2lw
bGVfb2ZfbGVhc3RfcHJpdmlsZWdlKQ0KPiA+DQo+DQo+IFNvcnJ5IEkgZGlkIG5vdCBnZXQgd2hh
dCB5b3UgbWVhbi4gSSBvbmx5IGluY2x1ZGVkIHRoZSBpbnRlcm5hbCBidXMuaA0KPiB3aGljaCBp
cyBkcml2ZXJzL2RheC9idXMuaC4gV2h5IGlzIHRoaXMgYWZmZWN0aW5nIHRoZSBvdGhlciBwYXJ0
IG9mIHRoZQ0KPiBrZXJuZWw/DQoNCkl0J3Mgbm90IGFmZmVjdGluZyBvdGhlciBwYXJ0cyBvZiB0
aGUga2VybmVsLiBkcml2ZXIvZGF4L3N1cGVyLmMgZG9lcw0Kbm90IG5lZWQgdGhlIG90aGVyIGRl
ZmluaXRpb25zIGluIGJ1cy5oLiBZb3UgY291bGQgbWFrZSB0aGUgYXJndW1lbnQNCnRoYXQgdGhl
IGRlZmluaXRpb24gb2YgcnVuX2RheCgpIG5lZWRzIHRvIG1vdmUgc29tZXdoZXJlIGVsc2UgdGhh
dA0Kc3VwZXIuYyBjb3VsZCBpbmNsdWRlLCBidXQganVzdCBibGluZGx5IGdpdmluZyBzdXBlci5j
IGFjY2VzcyB0byBhbGwNCnRoZSBvdGhlciBkZWZpbml0aW9ucyBpbiBidXMuaCBpcyB0aGUgd3Jv
bmcgZml4IGluIG15IHZpZXcuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3Rz
LjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2
ZUBsaXN0cy4wMS5vcmcK
