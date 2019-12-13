Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEB511E973
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 18:50:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9AF5A1011369C;
	Fri, 13 Dec 2019 09:53:57 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0559F10113699
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 09:53:55 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 09:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600";
   d="scan'208";a="415709726"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2019 09:50:31 -0800
Date: Fri, 13 Dec 2019 09:50:31 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20191213175031.GC31552@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
 <20191213171950.GA31552@linux.intel.com>
 <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A5E026D-53E6-4F30-A80D-B5E6AA07A786@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: Q2QGVLGTGBCUPVVMGDXX23NLNNSMYTUM
X-Message-ID-Hash: Q2QGVLGTGBCUPVVMGDXX23NLNNSMYTUM
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q2QGVLGTGBCUPVVMGDXX23NLNNSMYTUM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBEZWMgMTMsIDIwMTkgYXQgMDc6MzE6NTVQTSArMDIwMCwgTGlyYW4gQWxvbiB3cm90
ZToNCj4gDQo+ID4gT24gMTMgRGVjIDIwMTksIGF0IDE5OjE5LCBTZWFuIENocmlzdG9waGVyc29u
IDxzZWFuLmouY2hyaXN0b3BoZXJzb25AaW50ZWwuY29tPiB3cm90ZToNCj4gPiANCj4gPiBUaGVu
IGFsbG93ZWRfaHVnZXBhZ2VfYWRqdXN0KCkgd291bGQgbG9vayBzb21ldGhpbmcgbGlrZToNCj4g
PiANCj4gPiBzdGF0aWMgdm9pZCBhbGxvd2VkX2h1Z2VwYWdlX2FkanVzdChzdHJ1Y3Qga3ZtX3Zj
cHUgKnZjcHUsIGdmbl90IGdmbiwNCj4gPiAJCQkJICAgIGt2bV9wZm5fdCAqcGZucCwgaW50ICps
ZXZlbHAsIGludCBtYXhfbGV2ZWwpDQo+ID4gew0KPiA+IAlrdm1fcGZuX3QgcGZuID0gKnBmbnA7
DQo+ID4gCWludCBsZXZlbCA9ICpsZXZlbHA7CQ0KPiA+IAl1bnNpZ25lZCBsb25nIG1hc2s7DQo+
ID4gDQo+ID4gCWlmIChpc19lcnJvcl9ub3Nsb3RfcGZuKHBmbikgfHwgIWt2bV9pc19yZXNlcnZl
ZF9wZm4ocGZuKSB8fA0KPiA+IAkgICAgbGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTCkNCj4g
PiAJCXJldHVybjsNCj4gPiANCj4gPiAJLyoNCj4gPiAJICogbW11X25vdGlmaWVyX3JldHJ5KCkg
d2FzIHN1Y2Nlc3NmdWwgYW5kIG1tdV9sb2NrIGlzIGhlbGQsIHNvDQo+ID4gCSAqIHRoZSBwbWQv
cHVkIGNhbid0IGJlIHNwbGl0IGZyb20gdW5kZXIgdXMuDQo+ID4gCSAqLw0KPiA+IAlsZXZlbCA9
IGhvc3RfcGZuX21hcHBpbmdfbGV2ZWwodmNwdS0+a3ZtLCBnZm4sIHBmbik7DQo+ID4gDQo+ID4g
CSpsZXZlbHAgPSBsZXZlbCA9IG1pbihsZXZlbCwgbWF4X2xldmVsKTsNCj4gPiAJbWFzayA9IEtW
TV9QQUdFU19QRVJfSFBBR0UobGV2ZWwpIC0gMTsNCj4gPiAJVk1fQlVHX09OKChnZm4gJiBtYXNr
KSAhPSAocGZuICYgbWFzaykpOw0KPiA+IAkqcGZucCA9IHBmbiAmIH5tYXNrOw0KPiANCj4gV2h5
IGRvbuKAmXQgeW91IHN0aWxsIG5lZWQgdG8ga3ZtX3JlbGVhc2VfcGZuX2NsZWFuKCkgZm9yIG9y
aWdpbmFsIHBmbiBhbmQNCj4ga3ZtX2dldF9wZm4oKSBmb3IgbmV3IGh1Z2UtcGFnZSBzdGFydCBw
Zm4/DQoNClRoYXQgY29kZSBpcyBnb25lIGluIGt2bS9xdWV1ZS4gIHRocF9hZGp1c3QoKSBpcyBu
b3cgY2FsbGVkIGZyb20NCl9fZGlyZWN0X21hcCgpIGFuZCBGTkFNRShmZXRjaCksIGFuZCBzbyBp
dHMgcGZuIGFkanVzdG1lbnQgZG9lc24ndCBibGVlZA0KYmFjayB0byB0aGUgcGFnZSBmYXVsdCBo
YW5kbGVycy4gIFRoZSBvbmx5IHJlYXNvbiB0aGUgcHV0L2dldCBwZm4gY29kZQ0KZXhpc3RlZCB3
YXMgYmVjYXVzZSB0aGUgcGFnZSBmYXVsdCBoYW5kbGVycyBjYWxsZWQga3ZtX3JlbGVhc2VfcGZu
X2NsZWFuKCkNCm9uIHRoZSBwZm4sIGkuZS4gdGhleSB3b3VsZCBoYXZlIHB1dCB0aGUgd3Jvbmcg
cGZuLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
