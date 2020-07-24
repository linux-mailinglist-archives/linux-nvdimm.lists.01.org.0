Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 040D222CED0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 24 Jul 2020 21:44:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D5C8412517B01;
	Fri, 24 Jul 2020 12:44:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 282B512513344
	for <linux-nvdimm@lists.01.org>; Fri, 24 Jul 2020 12:43:57 -0700 (PDT)
IronPort-SDR: 05v58ygjmjcbSpanPm+dN+HhhlJ9DDN7FCGPHu2HmB/BIoYLwjYKgCwn9CmfaI4pQqMfhPzTlz
 f5oE0o4cKCyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="138832924"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800";
   d="scan'208";a="138832924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 12:43:56 -0700
IronPort-SDR: xw35vgWVMvuh2FxBDPdLOZ98hPNSo7kyjZ00bcaGwKX/k2DG8gIcu2MZetY8wt/D3BJ5XnscaB
 FrmYkinokGDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800";
   d="scan'208";a="272667289"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2020 12:43:56 -0700
Date: Fri, 24 Jul 2020 12:43:56 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across
 exceptions
Message-ID: <20200724194355.GA844234@iweiny-DESK2.sc.intel.com>
References: <20200724172344.GO844235@iweiny-DESK2.sc.intel.com>
 <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D866BD75-42A2-43B2-B07A-55BCC3781FEC@amacapital.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: ZXT3GIZU7PNW6MJKHZQSMOCREYES7HW7
X-Message-ID-Hash: ZXT3GIZU7PNW6MJKHZQSMOCREYES7HW7
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZXT3GIZU7PNW6MJKHZQSMOCREYES7HW7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBKdWwgMjQsIDIwMjAgYXQgMTA6Mjk6MjNBTSAtMDcwMCwgQW5keSBMdXRvbWlyc2tp
IHdyb3RlOg0KPiANCj4gPiBPbiBKdWwgMjQsIDIwMjAsIGF0IDEwOjIzIEFNLCBJcmEgV2Vpbnkg
PGlyYS53ZWlueUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IO+7v09uIFRodSwgSnVsIDIz
LCAyMDIwIGF0IDEwOjE1OjE3UE0gKzAyMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gPj4g
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+IHdyaXRlczoNCj4gPj4gDQo+ID4+
PiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+IHdyaXRlczoNCj4gPj4+PiBPbiBGcmks
IEp1bCAxNywgMjAyMCBhdCAxMjowNjoxMFBNICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gPj4+Pj4+IE9uIEZyaSwgSnVsIDE3LCAyMDIwIGF0IDEyOjIwOjU2QU0gLTA3MDAsIGlyYS53
ZWlueUBpbnRlbC5jb20gd3JvdGU6DQo+ID4+Pj4+IEkndmUgYmVlbiByZWFsbHkgZGlnZ2luZyBp
bnRvIHRoaXMgdG9kYXkgYW5kIEknbSB2ZXJ5IGNvbmNlcm5lZCB0aGF0IEknbQ0KPiA+Pj4+PiBj
b21wbGV0ZWx5IG1pc3Npbmcgc29tZXRoaW5nIFdSVCBpZHRlbnRyeV9lbnRlcigpIGFuZCBpZHRl
bnRyeV9leGl0KCkuDQo+ID4+Pj4+IA0KPiA+Pj4+PiBJJ3ZlIGluc3RydW1lbnRlZCBpZHRfe3Nh
dmUscmVzdG9yZX1fcGtycygpLCBhbmQgX19kZXZfYWNjZXNzX3tlbixkaXN9YWJsZSgpDQo+ID4+
Pj4+IHdpdGggdHJhY2VfcHJpbnRrKCkncy4NCj4gPj4+Pj4gDQo+ID4+Pj4+IFdpdGggdGhpcyBk
ZWJ1ZyBjb2RlLCBJIGhhdmUgZm91bmQgYW4gaW5zdGFuY2Ugd2hlcmUgaXQgc2VlbXMgbGlrZQ0K
PiA+Pj4+PiBpZHRlbnRyeV9lbnRlcigpIGlzIGNhbGxlZCB3aXRob3V0IGEgY29ycmVzcG9uZGlu
ZyBpZHRlbnRyeV9leGl0KCkuICBUaGlzIGhhcw0KPiA+Pj4+PiBsZWZ0IHRoZSB0aHJlYWQgcmVm
IGNvdW50ZXIgYXQgMCB3aGljaCByZXN1bHRzIGluIHZlcnkgYmFkIHRoaW5ncyBoYXBwZW5pbmcN
Cj4gPj4+Pj4gd2hlbiBfX2Rldl9hY2Nlc3NfZGlzYWJsZSgpIGlzIGNhbGxlZCBhbmQgdGhlIHJl
ZiBjb3VudCBnb2VzIG5lZ2F0aXZlLg0KPiA+Pj4+PiANCj4gPj4+Pj4gRWZmZWN0aXZlbHkgdGhp
cyBzZWVtcyB0byBiZSBoYXBwZW5pbmc6DQo+ID4+Pj4+IA0KPiA+Pj4+PiAuLi4NCj4gPj4+Pj4g
ICAgLy8gcmVmID09IDANCj4gPj4+Pj4gICAgZGV2X2FjY2Vzc19lbmFibGUoKSAgLy8gcmVmICs9
IDEgPT0+IGRpc2FibGUgcHJvdGVjdGlvbg0KPiA+Pj4+PiAgICAgICAgLy8gZXhjZXB0aW9uICAo
d2hpY2ggb25lIEkgZG9uJ3Qga25vdykNCj4gPj4+Pj4gICAgICAgICAgICBpZHRlbnRyeV9lbnRl
cigpDQo+ID4+Pj4+ICAgICAgICAgICAgICAgIC8vIHJlZiA9IDANCj4gPj4+Pj4gICAgICAgICAg
ICAgICAgX2hhbmRsZXIoKSAvLyBvciB3aGF0ZXZlciBjb2RlLi4uDQo+ID4+Pj4+ICAgICAgICAg
ICAgLy8gKl9leGl0KCkgbm90IGNhbGxlZCBbYXQgbGVhc3QgdGhlcmUgaXMgbm8gdHJhY2VfcHJp
bnRrKCkgb3V0cHV0XS4uLg0KPiA+Pj4+PiAgICAgICAgICAgIC8vIFJlZ2FyZGxlc3Mgb2YgdHJh
Y2Ugb3V0cHV0LCB0aGUgcmVmIGlzIGxlZnQgYXQgMA0KPiA+Pj4+PiAgICBkZXZfYWNjZXNzX2Rp
c2FibGUoKSAvLyByZWYgLT0gMSA9PT4gLTEgPT0+IGRvZXMgbm90IGVuYWJsZSBwcm90ZWN0aW9u
DQo+ID4+Pj4+ICAgIChCYWQgc3R1ZmYgaXMgYm91bmQgdG8gaGFwcGVuIG5vdy4uLikNCj4gPj4+
IA0KPiA+Pj4gV2VsbCwgaWYgYW55IGV4Y2VwdGlvbiB3aGljaCBjYWxscyBpZHRlbnRyeV9lbnRl
cigpIHdvdWxkIHJldHVybiB3aXRob3V0DQo+ID4+PiBnb2luZyB0aHJvdWdoIGlkdGVudHJ5X2V4
aXQoKSB0aGVuIGxvdHMgb2YgYmFkIHN0dWZmIHdvdWxkIGhhcHBlbiBldmVuDQo+ID4+PiB3aXRo
b3V0IHlvdXIgcGF0Y2hlcy4NCj4gPj4+IA0KPiA+Pj4+IEFsc28gaXMgdGhlcmUgYW55IGNoYW5j
ZSB0aGF0IHRoZSBwcm9jZXNzIGNvdWxkIGJlIGdldHRpbmcgc2NoZWR1bGVkIGFuZCB0aGF0DQo+
ID4+Pj4gaXMgY2F1c2luZyBhbiBpc3N1ZT8NCj4gPj4+IA0KPiA+Pj4gT25seSBmcm9tICNQRiwg
YnV0IGFmdGVyIHRoZSBmYXVsdCBoYXMgYmVlbiByZXNvbHZlZCBhbmQgdGhlIHRhc2tzIGlzDQo+
ID4+PiBzY2hlZHVsZWQgaW4gYWdhaW4gdGhlbiB0aGUgdGFzayByZXR1cm5zIHRocm91Z2ggaWR0
ZW50cnlfZXhpdCgpIHRvIHRoZQ0KPiA+Pj4gcGxhY2Ugd2hlcmUgaXQgdG9vayB0aGUgZmF1bHQu
IFRoYXQncyBub3QgZ3VhcmFudGVlZCB0byBiZSBvbiB0aGUgc2FtZQ0KPiA+Pj4gQ1BVLiBJZiBz
Y2hlZHVsZSBpcyBub3QgYXdhcmUgb2YgdGhlIGZhY3QgdGhhdCB0aGUgZXhjZXB0aW9uIHR1cm5l
ZCBvZmYNCj4gPj4+IHN0dWZmIHRoZW4geW91IHN1cmVseSBnZXQgaW50byB0cm91YmxlLiBTbyB5
b3UgcmVhbGx5IHdhbnQgdG8gc3RvcmUgaXQNCj4gPj4+IGluIHRoZSB0YXNrIGl0c2VsZiB0aGVu
IHRoZSBjb250ZXh0IHN3aXRjaCBjb2RlIGNhbiBhY3R1YWxseSBzZWUgdGhlDQo+ID4+PiBzdGF0
ZSBhbmQgYWN0IGFjY29yZGluZ2x5Lg0KPiA+PiANCj4gPj4gQWN0dWFsbHkgdGhhdHMgbmFzdHkg
YXMgd2VsbCBhcyB5b3UgbmVlZCBhIHN0YWNrIG9mIFBLUlMgdmFsdWVzIHRvDQo+ID4+IGhhbmRs
ZSBuZXN0ZWQgZXhjZXB0aW9ucy4gQnV0IGl0IG1pZ2h0IGJlIHN0aWxsIHRoZSBtb3N0IHJlYXNv
bmFibGUNCj4gPj4gdGhpbmcgdG8gZG8uIDcgUEtSUyB2YWx1ZXMgcGx1cyBhbiBpbmRleCBzaG91
bGQgYmUgcmVhbGx5IHN1ZmZpY2llbnQsDQo+ID4+IHRoYXQncyAzMmJ5dGVzIHRvdGFsLCBub3Qg
dGhhdCBiYWQuDQo+ID4gDQo+ID4gSSd2ZSB0aG91Z2h0IGFib3V0IHRoaXMgYSBiaXQgbW9yZSBh
bmQgdW5sZXNzIEknbSB3cm9uZyBJIHRoaW5rIHRoZQ0KPiA+IGlkdGVudHJ5X3N0YXRlIHByb3Zp
ZGVzIGZvciB0aGF0IGJlY2F1c2UgZWFjaCBuZXN0ZWQgZXhjZXB0aW9uIGhhcyBpdCdzIG93bg0K
PiA+IGlkdGVudHJ5X3N0YXRlIGRvZXNuJ3QgaXQ/DQo+IA0KPiBPbmx5IHRoZSBvbmVzIHRoYXQg
dXNlIGlkdGVudHJ5X2VudGVyKCkgaW5zdGVhZCBvZiwgc2F5LCBubWlfZW50ZXIoKS4NCg0KT2gg
YWdyZWVkLi4uDQoNCkJ1dCB3aXRoIHRoaXMgcGF0Y2ggd2UgYXJlIHN0aWxsIGJldHRlciBvZmYg
dGhhbiBqdXN0IHByZXNlcnZpbmcgZHVyaW5nIGNvbnRleHQNCnN3aXRjaC4NCg0KSSBuZWVkIHRv
IHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgaGVyZSB0byBtYWtlIHRoaXMgY2xlYXIgdGhvdWdo
Lg0KDQpUaGFua3MsDQpJcmEKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
