Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A611D4B8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 18:59:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80CE31011366B;
	Thu, 12 Dec 2019 10:03:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD5FA1011366A
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 10:02:59 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 77so2881673oty.6
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 09:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hyvqVUw30+SZX29bM7+V3jqwHKdXckZsARui5p8wXkE=;
        b=aj/3kNTYpNtUKR7EbJSlbIR7OuvgLrMsg2A0F6fYB2/hgfbnnbl9+8LyBrDy8shOr8
         5jTRk/BMXhnudMowqBHH0S5NYKRgQ9rFxuCKeSDofqeXcfx7uhKtC17UdE8kpSWquJTK
         2BEC9fGPeKSZClELYV/QJzc4je45MeCqEmu8+jh7SGQ9Wn9umQYfHEoAt/brB+rXFcDd
         KNSUTD9SOFqgEMRxqF9sBEz3w7SpWD6Io1lcnEy62y2YhXxStP+4qcvBAPnvD6CQZpO5
         OXEG8ziZSWTPQLVmfvYXsVj6zS+izGC5yMNZ51Z9Ts6g9RBxBSIb8XJVb/S+wzWyoaQQ
         FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hyvqVUw30+SZX29bM7+V3jqwHKdXckZsARui5p8wXkE=;
        b=t8NwrDIbiwYkYHaR0P5CuonqldgsRC1OB6RLRee25LPDQnFCtCDsajcqBCp/CUA707
         SF13iGxs1mgtWhCbAN+u6DBP5Ip8iS5E8PVxVei4qsgIPlQP1a/Jl+1FOrj++91iXqEs
         GLztZ1UAl3Y+Ne+u5pJBdG7kiFg81Bn0O+12qpbVMzFLu7LndjW0k/P4MeNSb5JPteIF
         adkumTFK6aZ2iWzovT8UBcfNCJ1mgj38LJrA/GofSkKxw4ULqk0UFZ4YHn+ShB5F+/XQ
         BW7fHluBWbuXWRjxQC5Gf4PkwBjLJDS0H7ipuQnOzExnFHFwHCLRvg6mbEcAGuoDHfsQ
         Pymg==
X-Gm-Message-State: APjAAAUvj6EbppNeIKS9w+BWqndBGKhK1835p6I1KhIDabvA7Z9z9KG3
	lbpc61xJrXQk0CVCKwycSEe0QyAumYKCX1QJuXjsdA==
X-Google-Smtp-Source: APXvYqyspLymJk5JMISgtjN43ATBp0Ct1Ma15zdcNgSN1GXL58ve4+5Bo2yaPsSdIlPxIzbTPZlJpTFkdzRW2z7T/rk=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr9356386otq.126.1576173576479;
 Thu, 12 Dec 2019 09:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20191211213207.215936-1-brho@google.com> <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com> <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
 <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
In-Reply-To: <F19843AB-1974-4E79-A85B-9AE00D58E192@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Dec 2019 09:59:25 -0800
Message-ID: <CAPcyv4i5ZaiA+KeraXzz-0vs25UGEmZ2ka9Z-PUT3T_7URAFMA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Liran Alon <liran.alon@oracle.com>
Message-ID-Hash: WOU2LDV5MRNGTKFQT4OFVY5G4535HF2P
X-Message-ID-Hash: WOU2LDV5MRNGTKFQT4OFVY5G4535HF2P
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WOU2LDV5MRNGTKFQT4OFVY5G4535HF2P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgOTozOSBBTSBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9y
YWNsZS5jb20+IHdyb3RlOg0KPg0KPg0KPg0KPiA+IE9uIDEyIERlYyAyMDE5LCBhdCAxODo1NCwg
RGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4g
T24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgNDozNCBBTSBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9y
YWNsZS5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gT24gMTEgRGVjIDIwMTks
IGF0IDIzOjMyLCBCYXJyZXQgUmhvZGVuIDxicmhvQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+Pj4N
Cj4gPj4+IFRoaXMgY2hhbmdlIGFsbG93cyBLVk0gdG8gbWFwIERBWC1iYWNrZWQgZmlsZXMgbWFk
ZSBvZiBodWdlIHBhZ2VzIHdpdGgNCj4gPj4+IGh1Z2UgbWFwcGluZ3MgaW4gdGhlIEVQVC9URFAu
DQo+ID4+Pg0KPiA+Pj4gREFYIHBhZ2VzIGFyZSBub3QgUGFnZVRyYW5zQ29tcG91bmQuICBUaGUg
ZXhpc3RpbmcgY2hlY2sgaXMgdHJ5aW5nIHRvDQo+ID4+PiBkZXRlcm1pbmUgaWYgdGhlIG1hcHBp
bmcgZm9yIHRoZSBwZm4gaXMgYSBodWdlIG1hcHBpbmcgb3Igbm90LiAgRm9yDQo+ID4+PiBub24t
REFYIG1hcHMsIGUuZy4gaHVnZXRsYmZzLCB0aGF0IG1lYW5zIGNoZWNraW5nIFBhZ2VUcmFuc0Nv
bXBvdW5kLg0KPiA+Pj4gRm9yIERBWCwgd2UgY2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlIGl0c2Vs
Zi4NCj4gPj4NCj4gPj4gRm9yIGh1Z2V0bGJmcyBwYWdlcywgdGRwX3BhZ2VfZmF1bHQoKSAtPiBt
YXBwaW5nX2xldmVsKCkgLT4gaG9zdF9tYXBwaW5nX2xldmVsKCkgLT4ga3ZtX2hvc3RfcGFnZV9z
aXplKCkgLT4gdm1hX2tlcm5lbF9wYWdlc2l6ZSgpDQo+ID4+IHdpbGwgcmV0dXJuIHRoZSBwYWdl
LXNpemUgb2YgdGhlIGh1Z2V0bGJmcyB3aXRob3V0IHRoZSBuZWVkIHRvIHBhcnNlIHRoZSBwYWdl
LXRhYmxlcy4NCj4gPj4gU2VlIHZtYS0+dm1fb3BzLT5wYWdlc2l6ZSgpIGNhbGxiYWNrIGltcGxl
bWVudGF0aW9uIGF0IGh1Z2V0bGJfdm1fb3BzLT5wYWdlc2l6ZSgpPT1odWdldGxiX3ZtX29wX3Bh
Z2VzaXplKCkuDQo+ID4+DQo+ID4+IE9ubHkgZm9yIHBhZ2VzIHRoYXQgd2VyZSBvcmlnaW5hbGx5
IG1hcHBlZCBhcyBzbWFsbC1wYWdlcyBhbmQgbGF0ZXIgbWVyZ2VkIHRvIGxhcmdlciBwYWdlcyBi
eSBUSFAsIHRoZXJlIGlzIGEgbmVlZCB0byBjaGVjayBmb3IgUGFnZVRyYW5zQ29tcG91bmQoKS4g
QWdhaW4sIGluc3RlYWQgb2YgcGFyc2luZyBwYWdlLXRhYmxlcy4NCj4gPj4NCj4gPj4gVGhlcmVm
b3JlLCBpdCBzZWVtcyBtb3JlIGxvZ2ljYWwgdG8gbWUgdGhhdDoNCj4gPj4gKGEpIElmIERBWC1i
YWNrZWQgZmlsZXMgYXJlIG1hcHBlZCBhcyBsYXJnZS1wYWdlcyB0byB1c2Vyc3BhY2UsIGl0IHNo
b3VsZCBiZSByZWZsZWN0ZWQgaW4gdm1hLT52bV9vcHMtPnBhZ2Vfc2l6ZSgpIG9mIHRoYXQgbWFw
cGluZy4gQ2F1c2luZyBrdm1faG9zdF9wYWdlX3NpemUoKSB0byByZXR1cm4gdGhlIHJpZ2h0IHNp
emUgd2l0aG91dCB0aGUgbmVlZCB0byBwYXJzZSB0aGUgcGFnZS10YWJsZXMuDQo+ID4NCj4gPiBB
IGdpdmVuIGRheC1tYXBwZWQgdm1hIG1heSBoYXZlIG1peGVkIHBhZ2Ugc2l6ZXMgc28gLT5wYWdl
X3NpemUoKQ0KPiA+IGNhbid0IGJlIHVzZWQgcmVsaWFibHkgdG8gZW51bWVyYXRpbmcgdGhlIG1h
cHBpbmcgc2l6ZS4NCj4NCj4gTmFpdmUgcXVlc3Rpb246IFdoeSBkb27igJl0IHNwbGl0IHRoZSBW
TUEgaW4gdGhpcyBjYXNlIHRvIG11bHRpcGxlIFZNQXMgd2l0aCBkaWZmZXJlbnQgcmVzdWx0cyBm
b3IgLT5wYWdlX3NpemUoKT8NCg0KRmlsZXN5c3RlbXMgdHJhZGl0aW9uYWxseSBoYXZlIG5vdCBw
b3B1bGF0ZWQgLT5wYWdlc2l6ZSgpIGluIHRoZWlyDQp2bV9vcGVyYXRpb25zLCB0aGVyZSB3YXMg
bm8gY29tcGVsbGluZyByZWFzb24gdG8gZ28gYWRkIGl0IGFuZCB0aGUNCmNvbXBsZXhpdHkgc2Vl
bXMgcHJvaGliaXRpdmUuDQoNCj4gV2hhdCB5b3UgYXJlIGRlc2NyaWJpbmcgc291bmRzIGxpa2Ug
REFYIGlzIGJyZWFraW5nIHRoaXMgY2FsbGJhY2sgc2VtYW50aWNzIGluIGFuIHVucHJlZGljdGFi
bGUgbWFubmVyLg0KDQpJdCdzIG5vdCB1bnByZWRpY3RhYmxlLiB2bWFfa2VybmVsX3BhZ2VzaXpl
KCkgcmV0dXJucyBQQUdFX1NJWkUuIEh1Z2UNCnBhZ2VzIGluIHRoZSBwYWdlIGNhY2hlIGhhcyBh
IHNpbWlsYXIgaXNzdWUuDQoNCj4gPj4gKGIpIElmIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFn
ZXMgY2FuIGJlIGxhdGVyIG1lcmdlZCB0byBsYXJnZS1wYWdlcyBieSBUSFAsIHRoZW4gdGhlIOKA
nHN0cnVjdCBwYWdl4oCdIG9mIHRoZXNlIHBhZ2VzIHNob3VsZCBiZSBtb2RpZmllZCBhcyB1c3Vh
bCB0byBtYWtlIFBhZ2VUcmFuc0NvbXBvdW5kKCkgcmV0dXJuIHRydWUgZm9yIHRoZW0uIEnigJlt
IG5vdCBoaWdobHkgZmFtaWxpYXIgd2l0aCB0aGlzIG1lY2hhbmlzbSwgYnV0IEkgd291bGQgZXhw
ZWN0IFRIUCB0byBiZSBhYmxlIHRvIG1lcmdlIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFnZXMg
dG8gbGFyZ2UtcGFnZXMgaW4gY2FzZSBEQVggcHJvdmlkZXMg4oCcc3RydWN0IHBhZ2XigJ0gZm9y
IHRoZSBEQVggcGFnZXMuDQo+ID4NCj4gPiBEQVggcGFnZXMgZG8gbm90IHBhcnRpY2lwYXRlIGlu
IFRIUCBhbmQgZG8gbm90IGhhdmUgdGhlDQo+ID4gUGFnZVRyYW5zQ29tcG91bmQgYWNjb3VudGlu
Zy4gVGhlIG9ubHkgbWVjaGFuaXNtIHRoYXQgcmVjb3JkcyB0aGUNCj4gPiBtYXBwaW5nIHNpemUg
Zm9yIGRheCBpcyB0aGUgcGFnZSB0YWJsZXMgdGhlbXNlbHZlcy4NCj4NCj4gV2hhdCBpcyB0aGUg
cmF0aW9uYWwgYmVoaW5kIHRoaXM/IEdpdmVuIHRoYXQgREFYIHBhZ2VzIGNhbiBiZSBkZXNjcmli
ZWQgd2l0aCDigJxzdHJ1Y3QgcGFnZeKAnSAoaS5lLiBaT05FX0RFVklDRSksIHdoYXQgcHJldmVu
dHMgVEhQIGZyb20gbWFuaXB1bGF0aW5nIHBhZ2UtdGFibGVzIHRvIG1lcmdlIG11bHRpcGxlIERB
WCBQRk5zIHRvIGEgbGFyZ2VyIHBhZ2U/DQoNClRIUCBhY2NvdW50aW5nIGlzIGEgZnVuY3Rpb24g
b2YgdGhlIHBhZ2UgYWxsb2NhdG9yLiBaT05FX0RFVklDRSBwYWdlcw0KYXJlIGV4Y2x1ZGVkIGZy
b20gdGhlIHBhZ2UgYWxsb2NhdG9yLiBaT05FX0RFVklDRSBpcyBqdXN0IGVub3VnaA0KaW5mcmFz
dHJ1Y3R1cmUgdG8gc3VwcG9ydCBwZm5fdG9fcGFnZSgpLCBwYWdlX2FkZHJlc3MoKSwgYW5kDQpn
ZXRfdXNlcl9wYWdlcygpLiBPdGhlciBwYWdlIGFsbG9jYXRvciBzZXJ2aWNlcyBiZXlvbmQgdGhh
dCBhcmUgbm90DQpwcmVzZW50LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
