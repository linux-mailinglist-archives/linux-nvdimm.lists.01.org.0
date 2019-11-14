Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F918FBD2A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 01:47:53 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 367A6100DC437;
	Wed, 13 Nov 2019 16:49:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B4512100DC434
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 16:49:24 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id 14so3638142oir.12
        for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 16:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JM0dXEnMbhhl1OhBMrYQPa4kYdncN1u/Wddm5L/nHXY=;
        b=VFxT5Ht5WgclaogJt6FVDC9JnKcmVgOsS3Bzjz9RF7QJJNV/Xb1fHXe7C2P1cE8g1D
         NpiOedzfyNJBGjBn9IjMkX9VHTvoVZxFShBn/UZsMRN9mruaoPwn6CeF14i5gGZXnGjb
         EnokZzTGgPWLWltVH47ExnvwD8zOROPLm8ofoCDYhZDLgnVfJ9kyjvTWcD9XVG5pDQwC
         ELVfd7BB+s6Ix1tO+6nLC/EgJgB9kVCKsrLY6njjiUXymYwObN2N7qb7PyIXTgoVQU5I
         9u75Zl776E9b2e/VLB2WSX47ps086nsiXLTbMUdjJNptpUrDmVdlNZdMQuMQj5KM944e
         UAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JM0dXEnMbhhl1OhBMrYQPa4kYdncN1u/Wddm5L/nHXY=;
        b=PkRnINx8X+7itEHf7tr/xAzGogqtBeOrZh4g+N3IutVsN6AA+Wj4CQszG1X3QftsrX
         qhuX6rVBf0ETIwSS8Ux78CobSqnI0HJXisiVBl8X1Iu4l7K3jr0b4Cv025e3J7/FA8ks
         ZIn9EqtO2wlevXD3FtCD1gdFbB0g5gU2nXxoVV0tMQkTmR2JHitAMi1fPbt7pWpCrFI/
         EkBx1M83UtpLAb31o9vbSVlSvNl4N7E/3pCP7Aih2KzfN/PoJogmV5NdRS8x00Axiits
         81NbB4Y8ffR+wdR4tGaN32S46HoURPvaEu9MjU8Zdc4aR3hzs5kPWoM7jFB9aEzUsi61
         G3Cg==
X-Gm-Message-State: APjAAAXg3jmUG0FjfZO9kroC3HTp2euRqhq8FsEbcHUFV2iTqr6fxvMt
	410cN1QmSMzzzaVlSd8FLDb4c+UalSATqyQFMVFMhw==
X-Google-Smtp-Source: APXvYqxao2KBp8k4m1dwk99bHg4ow0Xhti2qQb0KE7VmDCDH1hUUcHJ0mFCvmDLVnPJgQ4jBH5R1W8RgJYKPFWsifvA=
X-Received: by 2002:aca:3d84:: with SMTP id k126mr1206841oia.70.1573692468621;
 Wed, 13 Nov 2019 16:47:48 -0800 (PST)
MIME-Version: 1.0
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
 <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
In-Reply-To: <913133b7-58d8-9645-fc89-c2819825e1ee@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 13 Nov 2019 16:47:38 -0800
Message-ID: <CAPcyv4hK1hkDn9WohRn4F8JkAOBu94jzOJtU+43PP2qSX77Fqg@mail.gmail.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
To: John Hubbard <jhubbard@nvidia.com>
Message-ID-Hash: YJX6SD5JGEKSSQJSWVNUQB6MGSDHDRSW
X-Message-ID-Hash: YJX6SD5JGEKSSQJSWVNUQB6MGSDHDRSW
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YJX6SD5JGEKSSQJSWVNUQB6MGSDHDRSW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBOb3YgMTMsIDIwMTkgYXQgNDo0MiBQTSBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52
aWRpYS5jb20+IHdyb3RlOg0KPg0KPiBPbiAxMS8xMy8xOSA0OjA3IFBNLCBEYW4gV2lsbGlhbXMg
d3JvdGU6DQo+ID4gQWZ0ZXIgdGhlIHJlbW92YWwgb2YgdGhlIGRldmljZS1wdWJsaWMgaW5mcmFz
dHJ1Y3R1cmUgdGhlcmUgYXJlIG9ubHkgMg0KPiA+IC0+cGFnZV9mcmVlKCkgY2FsbCBiYWNrcyBp
biB0aGUga2VybmVsLiBPbmUgb2YgdGhvc2UgaXMgYSBkZXZpY2UtcHJpdmF0ZQ0KPiA+IGNhbGxi
YWNrIGluIHRoZSBub3V2ZWF1IGRyaXZlciwgdGhlIG90aGVyIGlzIGEgZ2VuZXJpYyB3YWtldXAg
bmVlZGVkIGluDQo+ID4gdGhlIERBWCBjYXNlLiBJbiB0aGUgaG9wZXMgdGhhdCBhbGwgLT5wYWdl
X2ZyZWUoKSBjYWxsYmFja3MgY2FuIGJlDQo+ID4gbWlncmF0ZWQgdG8gY29tbW9uIGNvcmUga2Vy
bmVsIGZ1bmN0aW9uYWxpdHksIG1vdmUgdGhlIGRldmljZS1wcml2YXRlDQo+ID4gc3BlY2lmaWMg
YWN0aW9ucyBpbiBfX3B1dF9kZXZtYXBfbWFuYWdlZF9wYWdlKCkgdW5kZXIgdGhlDQo+ID4gaXNf
ZGV2aWNlX3ByaXZhdGVfcGFnZSgpIGNvbmRpdGlvbmFsLCBpbmNsdWRpbmcgdGhlIC0+cGFnZV9m
cmVlKCkNCj4gPiBjYWxsYmFjay4gRm9yIHRoZSBvdGhlciBwYWdlIHR5cGVzIGp1c3Qgb3Blbi1j
b2RlIHRoZSBnZW5lcmljIHdha2V1cC4NCj4gPg0KPiA+IFllcywgdGhlIHdha2V1cCBpcyBvbmx5
IG5lZWRlZCBpbiB0aGUgTUVNT1JZX0RFVklDRV9GU0RBWCBjYXNlLCBidXQgaXQNCj4gPiBkb2Vz
IG5vIGhhcm0gaW4gdGhlIE1FTU9SWV9ERVZJQ0VfREVWREFYIGFuZCBNRU1PUllfREVWSUNFX1BD
SV9QMlBETUENCj4gPiBjYXNlLg0KPiA+DQo+ID4gQ2M6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
DQo+ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+IENjOiBJcmEgV2Vp
bnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+ID4gQ2M6IErDqXLDtG1lIEdsaXNzZSA8amdsaXNz
ZUByZWRoYXQuY29tPg0KPiA+IENjOiBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gSGkgSm9obiwNCj4gPg0KPiA+IFRoaXMgYXBwbGllcyBvbiB0b3Ag
b2YgdG9kYXkncyBsaW51eC1uZXh0IGFuZCBwYXNzZXMgbXkgbnZkaW1tIHVuaXQNCj4gPiB0ZXN0
cy4gVGhhdCB0ZXN0aW5nIG5vdGljZWQgdGhhdCBkZXZtYXBfbWFuYWdlZF9lbmFibGVfZ2V0KCkg
bmVlZGVkIGENCj4gPiBzbWFsbCBmaXh1cCBhcyB3ZWxsLg0KPg0KPiBHb3QgaXQuIFRoaXMgd2ls
bCBhcHBlYXIgaW4gdGhlIG5leHQgcG9zdGVkIHZlcnNpb24gb2YgbXkgIm1tL2d1cDogdHJhY2sN
Cj4gZG1hLXBpbm5lZCBwYWdlczogRk9MTF9QSU4sIEZPTExfTE9OR1RFUk0iIHBhdGNoc2V0Lg0K
DQpUaGFua3MhDQoNCj4NCj4NCj4gPg0KPiA+ICAgZHJpdmVycy9udmRpbW0vcG1lbS5jIHwgICAg
NiAtLS0tLS0NCj4gPiAgIG1tL21lbXJlbWFwLmMgICAgICAgICB8ICAgMjIgKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxNiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9wbWVtLmMg
Yi9kcml2ZXJzL252ZGltbS9wbWVtLmMNCj4gPiBpbmRleCBmOWY3NmY2YmEwN2IuLjIxZGIxY2U4
YzBhZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252ZGltbS9wbWVtLmMNCj4gPiArKysgYi9k
cml2ZXJzL252ZGltbS9wbWVtLmMNCj4gPiBAQCAtMzM4LDEzICszMzgsNyBAQCBzdGF0aWMgdm9p
ZCBwbWVtX3JlbGVhc2VfZGlzayh2b2lkICpfX3BtZW0pDQo+ID4gICAgICAgcHV0X2Rpc2socG1l
bS0+ZGlzayk7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgcG1lbV9wYWdlbWFwX3Bh
Z2VfZnJlZShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiAtew0KPiA+IC0gICAgIHdha2VfdXBfdmFy
KCZwYWdlLT5fcmVmY291bnQpOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkZXZfcGFnZW1hcF9vcHMgZnNkYXhfcGFnZW1hcF9vcHMgPSB7DQo+ID4gLSAgICAgLnBh
Z2VfZnJlZSAgICAgICAgICAgICAgPSBwbWVtX3BhZ2VtYXBfcGFnZV9mcmVlLA0KPiA+ICAgICAg
IC5raWxsICAgICAgICAgICAgICAgICAgID0gcG1lbV9wYWdlbWFwX2tpbGwsDQo+ID4gICAgICAg
LmNsZWFudXAgICAgICAgICAgICAgICAgPSBwbWVtX3BhZ2VtYXBfY2xlYW51cCwNCj4gPiAgIH07
DQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbXJlbWFwLmMgYi9tbS9tZW1yZW1hcC5jDQo+ID4gaW5k
ZXggMDIyZTc4ZTY4ZWEwLi42ZTZmM2Q2ZmRiNzMgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtcmVt
YXAuYw0KPiA+ICsrKyBiL21tL21lbXJlbWFwLmMNCj4gPiBAQCAtMjcsNyArMjcsOCBAQCBzdGF0
aWMgdm9pZCBkZXZtYXBfbWFuYWdlZF9lbmFibGVfcHV0KHZvaWQpDQo+ID4NCj4gPiAgIHN0YXRp
YyBpbnQgZGV2bWFwX21hbmFnZWRfZW5hYmxlX2dldChzdHJ1Y3QgZGV2X3BhZ2VtYXAgKnBnbWFw
KQ0KPiA+ICAgew0KPiA+IC0gICAgIGlmICghcGdtYXAtPm9wcyB8fCAhcGdtYXAtPm9wcy0+cGFn
ZV9mcmVlKSB7DQo+ID4gKyAgICAgaWYgKCFwZ21hcC0+b3BzIHx8IChwZ21hcC0+dHlwZSA9PSBN
RU1PUllfREVWSUNFX1BSSVZBVEUNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
JiAhcGdtYXAtPm9wcy0+cGFnZV9mcmVlKSkgew0KPg0KPg0KPiBPSywgc28gb25seSBNRU1PUllf
REVWSUNFX1BSSVZBVEUgaGFzIC5wYWdlX2ZyZWUgb3BzLiBUaGF0IGxvb2tzDQo+IGNvcnJlY3Qg
dG8gbWUsIGJhc2VkIG9uIGxvb2tpbmcgYXQgdGhlIC5wYWdlX2ZyZWUgc2V0dGVycy0tSQ0KPiBv
bmx5IHNlZSBOb3V2ZWF1IHNldHRpbmcgaXQuDQoNCkNvcnJlY3QuIFRoZSBGU0RBWCBjYXNlIHN0
aWxsIG5lZWRzIHRvIGVuYWJsZSB0aGUgJ2Rldm1hcF9tYW5hZ2VkX2tleScNCnN0YXRpYyBrZXks
IGJ1dCBvdGhlciB0aGFuIHRoYXQgdGhlIGNvcmUgd2lsbCBoYW5kbGUgYWxsIHRoZSBmb2xsb3ct
b24NCmRldGFpbHMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9y
ZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0
cy4wMS5vcmcK
