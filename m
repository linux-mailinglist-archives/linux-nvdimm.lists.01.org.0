Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23456271A8B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 07:53:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8FE5143B2B98;
	Sun, 20 Sep 2020 22:53:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::a44; helo=mail-vk1-xa44.google.com; envelope-from=naresh.kamboju@linaro.org; receiver=<UNKNOWN> 
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7064F143B2B95
	for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 22:53:20 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id c63so3061346vkb.7
        for <linux-nvdimm@lists.01.org>; Sun, 20 Sep 2020 22:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qQETu0O7sG8ZefKb7lE9RduahRzUSqc+hLCB6hG+Fns=;
        b=voRjucNk99z17LmRLmWubk3bIhLiHaPpViPQtBSwu2avCoVCt/IFsMrsqhRNYlnGqe
         42+Jp2C3KN2d3GFti2tlN1fcR8LQ5fB8v0l5rVltRVTHVy422pz8jqgp1CA+kVwUb3/S
         5bvZbV2B06SkwutizJdorH7X7+ji9MkcAOkHY9GfyP7vnY3l7nTjs/0NqhPds38s7tOz
         nOjr4oA90XNdlcjzUcfXS5cAWXrw60qZfUQXnLcgPa2Uz8St7vSDyazoi5t8RODh8mnf
         4D78nmdMNssDgAX2EcXov3YzLvy3qunaLiQv3TMv2cbG40iFJbdj0x2DR1rAJ+rWXM83
         47Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qQETu0O7sG8ZefKb7lE9RduahRzUSqc+hLCB6hG+Fns=;
        b=sW0xEruWuL4neqpomAfPqxUQYwZtFzrrSwhYFu36OoVvBSHKQSXvHHv0O6zwuvH5qS
         cgT0k3YqS9ytMvEAL62pLY0yP8cCNYrgnUuzzbHOt5scDDQmSP1ac4jhbkTuOdWfCTIB
         Yc7Wvpg1t2VL0N0ubvMrX6YzJoHVGvNexA2IEh4CjvO2stnTguoXvn5mAaKbIrjwfvjP
         3z4M10qGvQHVY79h+zXsrakTFVu/Z3U+PUAu3ixyjps5+0wreaeC8e6Oczl6vPf98wYg
         06gPlSJQUlxQaGeVgl3cJc6YS0hnmAvjDAm3mSEJoM41NT9xYWKDRP65qhasECHEQSPs
         +MDQ==
X-Gm-Message-State: AOAM531k9E/TvRUvtCnEhND1r4DQbAj1VQqSBTA5N8IvvaKhejPo7roC
	H7YDR7xBUiBXKzGasNAPgrMuiSUigk7smUN/3JAdOg==
X-Google-Smtp-Source: ABdhPJxfjUjmTXeHKimVJajbEcb0o8D28ZqtxiFxWNHvdiioP34k/JSkTjw0hXFK+7mnxl/ASTwGwXilqixsBm5+sz8=
X-Received: by 2002:a1f:fec9:: with SMTP id l192mr17383064vki.21.1600667598769;
 Sun, 20 Sep 2020 22:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <160040692945.25320.13233625491405115889.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160040692945.25320.13233625491405115889.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 21 Sep 2020 11:23:07 +0530
Message-ID: <CA+G9fYud7x0TfTDNWHa_0hzYHNQyet-a2==gQzDaZKXywY1meg@mail.gmail.com>
Subject: Re: [PATCH v2] dm: Call proper helper to determine dax support
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>
Message-ID-Hash: Y44BN2EFV3UGFSH3BO3FMY5VKUHKM5HE
X-Message-ID-Hash: Y44BN2EFV3UGFSH3BO3FMY5VKUHKM5HE
X-MailFrom: naresh.kamboju@linaro.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, mpatocka@redhat.com, lkft-triage@lists.linaro.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y44BN2EFV3UGFSH3BO3FMY5VKUHKM5HE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAxOCBTZXAgMjAyMCBhdCAxMToxOCwgRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFt
c0BpbnRlbC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBKYW4gS2FyYSA8amFja0BzdXNlLmN6Pg0K
Pg0KPiBETSB3YXMgY2FsbGluZyBnZW5lcmljX2ZzZGF4X3N1cHBvcnRlZCgpIHRvIGRldGVybWlu
ZSB3aGV0aGVyIGEgZGV2aWNlDQo+IHJlZmVyZW5jZWQgaW4gdGhlIERNIHRhYmxlIHN1cHBvcnRz
IERBWC4gSG93ZXZlciB0aGlzIGlzIGEgaGVscGVyIGZvciAibGVhZiIgZGV2aWNlIGRyaXZlcnMg
c28gdGhhdA0KPiB0aGV5IGRvbid0IGhhdmUgdG8gZHVwbGljYXRlIGNvbW1vbiBnZW5lcmljIGNo
ZWNrcy4gSGlnaCBsZXZlbCBjb2RlDQo+IHNob3VsZCBjYWxsIGRheF9zdXBwb3J0ZWQoKSBoZWxw
ZXIgd2hpY2ggdGhhdCBjYWxscyBpbnRvIGFwcHJvcHJpYXRlDQo+IGhlbHBlciBmb3IgdGhlIHBh
cnRpY3VsYXIgZGV2aWNlLiBUaGlzIHByb2JsZW0gbWFuaWZlc3RlZCBpdHNlbGYgYXMNCj4ga2Vy
bmVsIG1lc3NhZ2VzOg0KPg0KPiBkbS0zOiBlcnJvcjogZGF4IGFjY2VzcyBmYWlsZWQgKC05NSkN
Cj4NCj4gd2hlbiBsdm0yLXRlc3RzdWl0ZSBydW4gaW4gY2FzZXMgd2hlcmUgYSBETSBkZXZpY2Ug
d2FzIHN0YWNrZWQgb24gdG9wIG9mDQo+IGFub3RoZXIgRE0gZGV2aWNlLg0KPg0KPiBGaXhlczog
N2JmN2VhYzhkNjQ4ICgiZGF4OiBBcnJhbmdlIGZvciBkYXhfc3VwcG9ydGVkIGNoZWNrIHRvIHNw
YW4gbXVsdGlwbGUgZGV2aWNlcyIpDQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4g
VGVzdGVkLWJ5OiBBZHJpYW4gSHVhbmcgPGFodWFuZzEyQGxlbm92by5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+DQo+IEFja2VkLWJ5OiBNaWtlIFNuaXR6ZXIg
PHNuaXR6ZXJAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4u
ai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIHNpbmNlIHYxIFsxXToNCj4g
LSBBZGQgbWlzc2luZyBkYXhfcmVhZF9sb2NrKCkgYXJvdW5kIGRheF9zdXBwb3J0ZWQoKQ0KPg0K
PiBbMV06IGh0dHA6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIwMDkxNjE1MTQ0NS40NTAtMS1qYWNr
QHN1c2UuY3oNCj4NCj4gIGRyaXZlcnMvZGF4L3N1cGVyLmMgICB8ICAgIDQgKysrKw0KPiAgZHJp
dmVycy9tZC9kbS10YWJsZS5jIHwgICAxMCArKysrKysrLS0tDQo+ICBpbmNsdWRlL2xpbnV4L2Rh
eC5oICAgfCAgIDExICsrKysrKysrKy0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RheC9zdXBl
ci5jIGIvZHJpdmVycy9kYXgvc3VwZXIuYw0KPiBpbmRleCBlNTc2N2M4M2VhMjMuLmI2Mjg0YzVj
YWUwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kYXgvc3VwZXIuYw0KPiArKysgYi9kcml2ZXJz
L2RheC9zdXBlci5jDQo+IEBAIC0zMjUsMTEgKzMyNSwxNSBAQCBFWFBPUlRfU1lNQk9MX0dQTChk
YXhfZGlyZWN0X2FjY2Vzcyk7DQo+ICBib29sIGRheF9zdXBwb3J0ZWQoc3RydWN0IGRheF9kZXZp
Y2UgKmRheF9kZXYsIHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsDQo+ICAgICAgICAgICAgICAg
ICBpbnQgYmxvY2tzaXplLCBzZWN0b3JfdCBzdGFydCwgc2VjdG9yX3QgbGVuKQ0KPiAgew0KPiAr
ICAgICAgIGlmICghZGF4X2RldikNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
Kw0KPiAgICAgICAgIGlmICghZGF4X2FsaXZlKGRheF9kZXYpKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPg0KPiAgICAgICAgIHJldHVybiBkYXhfZGV2LT5vcHMtPmRheF9zdXBw
b3J0ZWQoZGF4X2RldiwgYmRldiwgYmxvY2tzaXplLCBzdGFydCwgbGVuKTsNCj4gIH0NCj4gK0VY
UE9SVF9TWU1CT0xfR1BMKGRheF9zdXBwb3J0ZWQpOw0KDQphcm0gYnVpbGQgZXJyb3Igd2hpbGUg
YnVpbGRpbmcgd2l0aCBhbGxtb2Rjb25maWcuDQoNCi4uL2RyaXZlcnMvZGF4L3N1cGVyLmM6MzI1
OjY6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYZGF4X3N1cHBvcnRlZOKAmQ0KICAzMjUgfCBi
b29sIGRheF9zdXBwb3J0ZWQoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsIHN0cnVjdA0KYmxv
Y2tfZGV2aWNlICpiZGV2LA0KICAgICAgfCAgICAgIF5+fn5+fn5+fn5+fn4NCkluIGZpbGUgaW5j
bHVkZWQgZnJvbSAuLi9kcml2ZXJzL2RheC9zdXBlci5jOjE2Og0KLi4vaW5jbHVkZS9saW51eC9k
YXguaDoxNjI6MjA6IG5vdGU6IHByZXZpb3VzIGRlZmluaXRpb24gb2YNCuKAmGRheF9zdXBwb3J0
ZWTigJkgd2FzIGhlcmUNCiAgMTYyIHwgc3RhdGljIGlubGluZSBib29sIGRheF9zdXBwb3J0ZWQo
c3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsDQogICAgICB8ICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+fn5+DQptYWtlWzNdOiAqKiogWy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6Mjgz
OiBkcml2ZXJzL2RheC9zdXBlci5vXSBFcnJvciAxDQoNClJlcG9ydGVkLWJ5OiBOYXJlc2ggS2Ft
Ym9qdSA8bmFyZXNoLmthbWJvanVAbGluYXJvLm9yZz4NCg0KUmVmOg0KaHR0cHM6Ly9idWlsZHMu
dHV4YnVpbGQuY29tL0lPNjkwakZRRHAwcVA5ekZ1V0JxcEEvYnVpbGQubG9nCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5n
IGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFu
IGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
