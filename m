Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 955E411D2D9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 17:55:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29AA510113661;
	Thu, 12 Dec 2019 08:58:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B881B1011330F
	for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 08:58:33 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i4so2676913otr.3
        for <linux-nvdimm@lists.01.org>; Thu, 12 Dec 2019 08:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IjDUBfxBJhXNaC2BIeIEC43hkHaDAGwaiQqn3TQYiIk=;
        b=rgtrRVuq6mdTTp7elEykgE89Ca9kZfn8QGs2v++8uceH3hFUstkL2ayypXJmkZfxk1
         iEGWW63b5xe8cb11bY30cimjn6zlRLLAZ0SBZbITIqWmtK9ObULY/ZUjOhVQpHgy43tK
         vac8DIrdJ543HRUPfBajdEIZV1GmYiBat32AFIvi3TBXKX1su2WzlK2cncw5h6144hey
         kOBYwgTRo2VfskCO21DnFQr6uUTKWUqlPo51785MVMk82ugVbKBZDUbGNO7frgqCR7rY
         ZjPZecmpJa3QOFc0keUDCp2aSgzufXIt1iNv04Rl7hV1xbkD7RXbi3OjPTdOoMLxaXhC
         B4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IjDUBfxBJhXNaC2BIeIEC43hkHaDAGwaiQqn3TQYiIk=;
        b=sn81Ry+3j+tqbfVXSgyjct88jUzA7Ogr6vfu8SQoWPFMPHhHEwm1ndUaXUVZTKlO+g
         JJj7UkBC6R38xBt9az/SqRj3cosO5OospqdzIJvxGVN3H1vRUwqOBFgqc/9CT6dzUNme
         QwWspIEMuOeLH+ZkUDIZvwQ/fRbdobuzKAWzTDY6RzyjJD8lDS4UxTpqBtoxv1vI5+bs
         OuqYUbNjgHCZRp0Oonrp+XVwDXerBQKHk1NCoXfOyUTp89Kq2XS32RJ0E/lU87ZeZmRS
         LiHhFCoMG4xy5/IW/ocBQdk7kNbzKA4CYwJpvDmqP4eF7bIBtbQX/pV11wFFsQluRacD
         aSSw==
X-Gm-Message-State: APjAAAVdUfPvdHdi3+tVdm0WtqG0hZoKTAaC24QPNLjRSj1ZguWLkGIn
	cKZ6SN7vsLIFbwLg3vqmqooYUaSZVBQhq6h3GDgp5g==
X-Google-Smtp-Source: APXvYqyr1ygzuNz/tNcPyx+AVQmEEPaxXCSetasrTiHp3InGql8xutKQ6hNSEWwo2qQnFd4JZbh62sd3hFut1H3bUl0=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr9361501otk.363.1576169710137;
 Thu, 12 Dec 2019 08:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20191211213207.215936-1-brho@google.com> <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
In-Reply-To: <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Dec 2019 08:54:59 -0800
Message-ID: <CAPcyv4gpYF=D323G+69FhFZw4i5W-15_wTRa1xNPdmear0phTw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Liran Alon <liran.alon@oracle.com>
Message-ID-Hash: W5YBLERGMUMR5P7YYO6LDEZHBIZ5SLHZ
X-Message-ID-Hash: W5YBLERGMUMR5P7YYO6LDEZHBIZ5SLHZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Zeng, Jason" <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/W5YBLERGMUMR5P7YYO6LDEZHBIZ5SLHZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgNDozNCBBTSBMaXJhbiBBbG9uIDxsaXJhbi5hbG9uQG9y
YWNsZS5jb20+IHdyb3RlOg0KPg0KPg0KPg0KPiA+IE9uIDExIERlYyAyMDE5LCBhdCAyMzozMiwg
QmFycmV0IFJob2RlbiA8YnJob0Bnb29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgY2hh
bmdlIGFsbG93cyBLVk0gdG8gbWFwIERBWC1iYWNrZWQgZmlsZXMgbWFkZSBvZiBodWdlIHBhZ2Vz
IHdpdGgNCj4gPiBodWdlIG1hcHBpbmdzIGluIHRoZSBFUFQvVERQLg0KPiA+DQo+ID4gREFYIHBh
Z2VzIGFyZSBub3QgUGFnZVRyYW5zQ29tcG91bmQuICBUaGUgZXhpc3RpbmcgY2hlY2sgaXMgdHJ5
aW5nIHRvDQo+ID4gZGV0ZXJtaW5lIGlmIHRoZSBtYXBwaW5nIGZvciB0aGUgcGZuIGlzIGEgaHVn
ZSBtYXBwaW5nIG9yIG5vdC4gIEZvcg0KPiA+IG5vbi1EQVggbWFwcywgZS5nLiBodWdldGxiZnMs
IHRoYXQgbWVhbnMgY2hlY2tpbmcgUGFnZVRyYW5zQ29tcG91bmQuDQo+ID4gRm9yIERBWCwgd2Ug
Y2FuIGNoZWNrIHRoZSBwYWdlIHRhYmxlIGl0c2VsZi4NCj4NCj4gRm9yIGh1Z2V0bGJmcyBwYWdl
cywgdGRwX3BhZ2VfZmF1bHQoKSAtPiBtYXBwaW5nX2xldmVsKCkgLT4gaG9zdF9tYXBwaW5nX2xl
dmVsKCkgLT4ga3ZtX2hvc3RfcGFnZV9zaXplKCkgLT4gdm1hX2tlcm5lbF9wYWdlc2l6ZSgpDQo+
IHdpbGwgcmV0dXJuIHRoZSBwYWdlLXNpemUgb2YgdGhlIGh1Z2V0bGJmcyB3aXRob3V0IHRoZSBu
ZWVkIHRvIHBhcnNlIHRoZSBwYWdlLXRhYmxlcy4NCj4gU2VlIHZtYS0+dm1fb3BzLT5wYWdlc2l6
ZSgpIGNhbGxiYWNrIGltcGxlbWVudGF0aW9uIGF0IGh1Z2V0bGJfdm1fb3BzLT5wYWdlc2l6ZSgp
PT1odWdldGxiX3ZtX29wX3BhZ2VzaXplKCkuDQo+DQo+IE9ubHkgZm9yIHBhZ2VzIHRoYXQgd2Vy
ZSBvcmlnaW5hbGx5IG1hcHBlZCBhcyBzbWFsbC1wYWdlcyBhbmQgbGF0ZXIgbWVyZ2VkIHRvIGxh
cmdlciBwYWdlcyBieSBUSFAsIHRoZXJlIGlzIGEgbmVlZCB0byBjaGVjayBmb3IgUGFnZVRyYW5z
Q29tcG91bmQoKS4gQWdhaW4sIGluc3RlYWQgb2YgcGFyc2luZyBwYWdlLXRhYmxlcy4NCj4NCj4g
VGhlcmVmb3JlLCBpdCBzZWVtcyBtb3JlIGxvZ2ljYWwgdG8gbWUgdGhhdDoNCj4gKGEpIElmIERB
WC1iYWNrZWQgZmlsZXMgYXJlIG1hcHBlZCBhcyBsYXJnZS1wYWdlcyB0byB1c2Vyc3BhY2UsIGl0
IHNob3VsZCBiZSByZWZsZWN0ZWQgaW4gdm1hLT52bV9vcHMtPnBhZ2Vfc2l6ZSgpIG9mIHRoYXQg
bWFwcGluZy4gQ2F1c2luZyBrdm1faG9zdF9wYWdlX3NpemUoKSB0byByZXR1cm4gdGhlIHJpZ2h0
IHNpemUgd2l0aG91dCB0aGUgbmVlZCB0byBwYXJzZSB0aGUgcGFnZS10YWJsZXMuDQoNCkEgZ2l2
ZW4gZGF4LW1hcHBlZCB2bWEgbWF5IGhhdmUgbWl4ZWQgcGFnZSBzaXplcyBzbyAtPnBhZ2Vfc2l6
ZSgpDQpjYW4ndCBiZSB1c2VkIHJlbGlhYmx5IHRvIGVudW1lcmF0aW5nIHRoZSBtYXBwaW5nIHNp
emUuDQoNCj4gKGIpIElmIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFnZXMgY2FuIGJlIGxhdGVy
IG1lcmdlZCB0byBsYXJnZS1wYWdlcyBieSBUSFAsIHRoZW4gdGhlIOKAnHN0cnVjdCBwYWdl4oCd
IG9mIHRoZXNlIHBhZ2VzIHNob3VsZCBiZSBtb2RpZmllZCBhcyB1c3VhbCB0byBtYWtlIFBhZ2VU
cmFuc0NvbXBvdW5kKCkgcmV0dXJuIHRydWUgZm9yIHRoZW0uIEnigJltIG5vdCBoaWdobHkgZmFt
aWxpYXIgd2l0aCB0aGlzIG1lY2hhbmlzbSwgYnV0IEkgd291bGQgZXhwZWN0IFRIUCB0byBiZSBh
YmxlIHRvIG1lcmdlIERBWC1iYWNrZWQgZmlsZXMgc21hbGwtcGFnZXMgdG8gbGFyZ2UtcGFnZXMg
aW4gY2FzZSBEQVggcHJvdmlkZXMg4oCcc3RydWN0IHBhZ2XigJ0gZm9yIHRoZSBEQVggcGFnZXMu
DQoNCkRBWCBwYWdlcyBkbyBub3QgcGFydGljaXBhdGUgaW4gVEhQIGFuZCBkbyBub3QgaGF2ZSB0
aGUNClBhZ2VUcmFuc0NvbXBvdW5kIGFjY291bnRpbmcuIFRoZSBvbmx5IG1lY2hhbmlzbSB0aGF0
IHJlY29yZHMgdGhlDQptYXBwaW5nIHNpemUgZm9yIGRheCBpcyB0aGUgcGFnZSB0YWJsZXMgdGhl
bXNlbHZlcy4NCg0KDQo+DQo+ID4NCj4gPiBOb3RlIHRoYXQgS1ZNIGFscmVhZHkgZmF1bHRlZCBp
biB0aGUgcGFnZSAob3IgaHVnZSBwYWdlKSBpbiB0aGUgaG9zdCdzDQo+ID4gcGFnZSB0YWJsZSwg
YW5kIHdlIGhvbGQgdGhlIEtWTSBtbXUgc3BpbmxvY2suICBXZSBncmFiYmVkIHRoYXQgbG9jayBp
bg0KPiA+IGt2bV9tbXVfbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9lbmQsIGJlZm9yZSBjaGVj
a2luZyB0aGUgbW11IHNlcS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhcnJldCBSaG9kZW4g
PGJyaG9AZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiBhcmNoL3g4Ni9rdm0vbW11L21tdS5jIHwg
MzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ID4gMSBmaWxlIGNoYW5n
ZWQsIDMyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvYXJjaC94ODYva3ZtL21tdS9tbXUuYyBiL2FyY2gveDg2L2t2bS9tbXUvbW11LmMNCj4gPiBp
bmRleCA2ZjkyYjQwZDc5OGMuLmNkMDdiYzRlNTk1ZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4
Ni9rdm0vbW11L21tdS5jDQo+ID4gKysrIGIvYXJjaC94ODYva3ZtL21tdS9tbXUuYw0KPiA+IEBA
IC0zMzg0LDYgKzMzODQsMzUgQEAgc3RhdGljIGludCBrdm1faGFuZGxlX2JhZF9wYWdlKHN0cnVj
dCBrdm1fdmNwdSAqdmNwdSwgZ2ZuX3QgZ2ZuLCBrdm1fcGZuX3QgcGZuKQ0KPiA+ICAgICAgIHJl
dHVybiAtRUZBVUxUOw0KPiA+IH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBwZm5faXNfaHVnZV9t
YXBwZWQoc3RydWN0IGt2bSAqa3ZtLCBnZm5fdCBnZm4sIGt2bV9wZm5fdCBwZm4pDQo+ID4gK3sN
Cj4gPiArICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9IHBmbl90b19wYWdlKHBmbik7DQo+ID4gKyAg
ICAgdW5zaWduZWQgbG9uZyBodmE7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghaXNfem9uZV9kZXZp
Y2VfcGFnZShwYWdlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBQYWdlVHJhbnNDb21wb3Vu
ZE1hcChwYWdlKTsNCj4gPiArDQo+ID4gKyAgICAgLyoNCj4gPiArICAgICAgKiBEQVggcGFnZXMg
ZG8gbm90IHVzZSBjb21wb3VuZCBwYWdlcy4gIFRoZSBwYWdlIHNob3VsZCBoYXZlIGFscmVhZHkN
Cj4gPiArICAgICAgKiBiZWVuIG1hcHBlZCBpbnRvIHRoZSBob3N0LXNpZGUgcGFnZSB0YWJsZSBk
dXJpbmcgdHJ5X2FzeW5jX3BmKCksIHNvDQo+ID4gKyAgICAgICogd2UgY2FuIGNoZWNrIHRoZSBw
YWdlIHRhYmxlcyBkaXJlY3RseS4NCj4gPiArICAgICAgKi8NCj4gPiArICAgICBodmEgPSBnZm5f
dG9faHZhKGt2bSwgZ2ZuKTsNCj4gPiArICAgICBpZiAoa3ZtX2lzX2Vycm9yX2h2YShodmEpKQ0K
PiA+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiArICAgICAvKg0KPiA+
ICsgICAgICAqIE91ciBjYWxsZXIgZ3JhYmJlZCB0aGUgS1ZNIG1tdV9sb2NrIHdpdGggYSBzdWNj
ZXNzZnVsDQo+ID4gKyAgICAgICogbW11X25vdGlmaWVyX3JldHJ5LCBzbyB3ZSdyZSBzYWZlIHRv
IHdhbGsgdGhlIHBhZ2UgdGFibGUuDQo+ID4gKyAgICAgICovDQo+ID4gKyAgICAgc3dpdGNoIChk
ZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KGh2YSwgY3VycmVudC0+bW0pKSB7DQo+DQo+IERvZXNu
4oCZdCBkZXZfcGFnZW1hcF9tYXBwaW5nX3NoaWZ0KCkgZ2V0IOKAnHN0cnVjdCBwYWdl4oCdIGFz
IGZpcnN0IHBhcmFtZXRlcj8NCj4gV2FzIHRoaXMgY2hhbmdlZCBieSBhIGNvbW1pdCBJIG1pc3Nl
ZD8NCj4NCj4gLUxpcmFuDQo+DQo+ID4gKyAgICAgY2FzZSBQTURfU0hJRlQ6DQo+ID4gKyAgICAg
Y2FzZSBQVURfU0laRToNCj4gPiArICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICsgICAg
IH0NCj4gPiArICAgICByZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+ID4gc3RhdGljIHZv
aWQgdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdmbl90IGdmbiwga3ZtX3Bm
bl90ICpwZm5wLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50
ICpsZXZlbHApDQo+ID4gQEAgLTMzOTgsOCArMzQyNyw4IEBAIHN0YXRpYyB2b2lkIHRyYW5zcGFy
ZW50X2h1Z2VwYWdlX2FkanVzdChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsDQo+ID4gICAgICAgICog
aGVyZS4NCj4gPiAgICAgICAgKi8NCj4gPiAgICAgICBpZiAoIWlzX2Vycm9yX25vc2xvdF9wZm4o
cGZuKSAmJiAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pICYmDQo+ID4gLSAgICAgICAgICFrdm1f
aXNfem9uZV9kZXZpY2VfcGZuKHBmbikgJiYgbGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTCAm
Jg0KPiA+IC0gICAgICAgICBQYWdlVHJhbnNDb21wb3VuZE1hcChwZm5fdG9fcGFnZShwZm4pKSAm
Jg0KPiA+ICsgICAgICAgICBsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVMICYmDQo+ID4gKyAg
ICAgICAgIHBmbl9pc19odWdlX21hcHBlZCh2Y3B1LT5rdm0sIGdmbiwgcGZuKSAmJg0KPiA+ICAg
ICAgICAgICAhbW11X2dmbl9scGFnZV9pc19kaXNhbGxvd2VkKHZjcHUsIGdmbiwgUFRfRElSRUNU
T1JZX0xFVkVMKSkgew0KPiA+ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBtYXNrOw0KPiA+
ICAgICAgICAgICAgICAgLyoNCj4gPiBAQCAtNjAxNSw4ICs2MDQ0LDcgQEAgc3RhdGljIGJvb2wg
a3ZtX21tdV96YXBfY29sbGFwc2libGVfc3B0ZShzdHJ1Y3Qga3ZtICprdm0sDQo+ID4gICAgICAg
ICAgICAgICAgKiBtYXBwaW5nIGlmIHRoZSBpbmRpcmVjdCBzcCBoYXMgbGV2ZWwgPSAxLg0KPiA+
ICAgICAgICAgICAgICAgICovDQo+ID4gICAgICAgICAgICAgICBpZiAoc3AtPnJvbGUuZGlyZWN0
ICYmICFrdm1faXNfcmVzZXJ2ZWRfcGZuKHBmbikgJiYNCj4gPiAtICAgICAgICAgICAgICAgICAh
a3ZtX2lzX3pvbmVfZGV2aWNlX3BmbihwZm4pICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgUGFn
ZVRyYW5zQ29tcG91bmRNYXAocGZuX3RvX3BhZ2UocGZuKSkpIHsNCj4gPiArICAgICAgICAgICAg
ICAgICBwZm5faXNfaHVnZV9tYXBwZWQoa3ZtLCBzcC0+Z2ZuLCBwZm4pKSB7DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgIHB0ZV9saXN0X3JlbW92ZShybWFwX2hlYWQsIHNwdGVwKTsNCj4gPg0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICBpZiAoa3ZtX2F2YWlsYWJsZV9mbHVzaF90bGJfd2l0
aF9yYW5nZSgpKQ0KPiA+IC0tDQo+ID4gMi4yNC4wLjUyNS5nOGYzNmEzNTRhZS1nb29nDQo+ID4N
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
