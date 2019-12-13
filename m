Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B8D11E919
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Dec 2019 18:19:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E177610113694;
	Fri, 13 Dec 2019 09:23:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=sean.j.christopherson@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 82CA010113692
	for <linux-nvdimm@lists.01.org>; Fri, 13 Dec 2019 09:23:14 -0800 (PST)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 09:19:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,309,1571727600";
   d="scan'208";a="414351942"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 13 Dec 2019 09:19:50 -0800
Date: Fri, 13 Dec 2019 09:19:50 -0800
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v5 2/2] kvm: Use huge pages for DAX-backed files
Message-ID: <20191213171950.GA31552@linux.intel.com>
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-3-brho@google.com>
 <06108004-1720-41EB-BCAB-BFA8FEBF4772@oracle.com>
 <ED482280-CB47-4AB6-9E7E-EEE7848E0F8B@oracle.com>
 <f8e948ff-6a2a-a6d6-9d8e-92b93003354a@google.com>
 <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65FB6CC1-3AD2-4D6F-9481-500BD7037203@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Message-ID-Hash: GJEUD5G3J3YW4VSTNPLYAFPYSXZLJXZC
X-Message-ID-Hash: GJEUD5G3J3YW4VSTNPLYAFPYSXZLJXZC
X-MailFrom: sean.j.christopherson@intel.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Barret Rhoden <brho@google.com>, Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GJEUD5G3J3YW4VSTNPLYAFPYSXZLJXZC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBEZWMgMTMsIDIwMTkgYXQgMDM6MDc6MzFBTSArMDIwMCwgTGlyYW4gQWxvbiB3cm90
ZToNCj4gDQo+ID4gT24gMTIgRGVjIDIwMTksIGF0IDIxOjU1LCBCYXJyZXQgUmhvZGVuIDxicmhv
QGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+Pj4+IE5vdGUgdGhhdCBLVk0gYWxyZWFkeSBm
YXVsdGVkIGluIHRoZSBwYWdlIChvciBodWdlIHBhZ2UpIGluIHRoZSBob3N0J3MNCj4gPj4+PiBw
YWdlIHRhYmxlLCBhbmQgd2UgaG9sZCB0aGUgS1ZNIG1tdSBzcGlubG9jay4gIFdlIGdyYWJiZWQg
dGhhdCBsb2NrIGluDQo+ID4+Pj4ga3ZtX21tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3JhbmdlX2Vu
ZCwgYmVmb3JlIGNoZWNraW5nIHRoZSBtbXUgc2VxLg0KPiA+Pj4+IA0KPiA+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEJhcnJldCBSaG9kZW4gPGJyaG9AZ29vZ2xlLmNvbT4NCj4gPj4+IA0KPiA+Pj4gSSBk
b27igJl0IHRoaW5rIHRoZSByaWdodCBwbGFjZSB0byBjaGFuZ2UgZm9yIHRoaXMgZnVuY3Rpb25h
bGl0eSBpcw0KPiA+Pj4gdHJhbnNwYXJlbnRfaHVnZXBhZ2VfYWRqdXN0KCkgd2hpY2ggaXMgbWVh
bnQgdG8gaGFuZGxlIFBGTnMgdGhhdCBhcmUNCj4gPj4+IG1hcHBlZCBhcyBwYXJ0IG9mIGEgdHJh
bnNwYXJlbnQgaHVnZS1wYWdlLg0KPiA+Pj4gDQo+ID4+PiBGb3IgZXhhbXBsZSwgdGhpcyB3b3Vs
ZCBwcmV2ZW50IG1hcHBpbmcgREFYLWJhY2tlZCBmaWxlIHBhZ2UgYXMgMUdCLiAgQXMNCj4gPj4+
IHRyYW5zcGFyZW50X2h1Z2VwYWdlX2FkanVzdCgpIG9ubHkgaGFuZGxlcyB0aGUgY2FzZSAobGV2
ZWwgPT0NCj4gPj4+IFBUX1BBR0VfVEFCTEVfTEVWRUwpLg0KDQpUZWFjaGluZyB0aHBfYWRqdXN0
KCkgaG93IHRvIGhhbmRsZSAxR0Igd291bGRuJ3QgYmUgYSBiYWQgdGhpbmcuICBJdCdzDQp1bmxp
a2VseSBUSFAgaXRzZWxmIHdpbGwgc3VwcG9ydCAxR0IgcGFnZXMgYW55IHRpbWUgc29vbiwgYnV0
IGhhdmluZyB0aGUNCmxvZ2ljIHRoZXJlIHdvdWxkbid0IGh1cnQgYW55dGhpbmcuDQoNCj4gPj4+
IEFzIHlvdSBhcmUgcGFyc2luZyB0aGUgcGFnZS10YWJsZXMgdG8gZGlzY292ZXIgdGhlIHBhZ2Ut
c2l6ZSB0aGUgUEZOIGlzDQo+ID4+PiBtYXBwZWQgaW4sIEkgdGhpbmsgeW91IHNob3VsZCBpbnN0
ZWFkIG1vZGlmeSBrdm1faG9zdF9wYWdlX3NpemUoKSB0bw0KPiA+Pj4gcGFyc2UgcGFnZS10YWJs
ZXMgaW5zdGVhZCBvZiByZWx5IG9uIHZtYV9rZXJuZWxfcGFnZXNpemUoKSAoV2hpY2ggcmVsaWVz
DQo+ID4+PiBvbiB2bWEtPnZtX29wcy0+cGFnZXNpemUoKSkgaW4gY2FzZSBvZiBpc196b25lX2Rl
dmljZV9wYWdlKCkuDQo+ID4+Pg0KPiA+Pj4gVGhlIG1haW4gY29tcGxpY2F0aW9uIHRob3VnaCBv
ZiBkb2luZyB0aGlzIGlzIHRoYXQgYXQgdGhpcyBwb2ludCB5b3UNCj4gPj4+IGRvbuKAmXQgeWV0
IGhhdmUgdGhlIFBGTiB0aGF0IGlzIHJldHJpZXZlZCBieSB0cnlfYXN5bmNfcGYoKS4gU28gbWF5
YmUgeW91DQo+ID4+PiBzaG91bGQgY29uc2lkZXIgbW9kaWZ5aW5nIHRoZSBvcmRlciBvZiBjYWxs
cyBpbiB0ZHBfcGFnZV9mYXVsdCgpICYNCj4gPj4+IEZOQU1FKHBhZ2VfZmF1bHQpKCkuDQo+ID4+
PiANCj4gPj4+IC1MaXJhbg0KPiA+PiBPciBhbHRlcm5hdGl2ZWx5IHdoZW4gdGhpbmtpbmcgYWJv
dXQgaXQgbW9yZSwgbWF5YmUganVzdCByZW5hbWUNCj4gPj4gdHJhbnNwYXJlbnRfaHVnZXBhZ2Vf
YWRqdXN0KCkgdG8gbm90IGJlIHNwZWNpZmljIHRvIFRIUCBhbmQgYmV0dGVyIGhhbmRsZQ0KPiA+
PiB0aGUgY2FzZSBvZiBwYXJzaW5nIHBhZ2UtdGFibGVzIGNoYW5naW5nIG1hcHBpbmctbGV2ZWwg
dG8gMUdCLg0KPiA+PiBUaGF0IGlzIHByb2JhYmx5IGVhc2llciBhbmQgbW9yZSBlbGVnYW50Lg0K
DQpBZ3JlZWQuDQoNCj4gPiBJIGNhbiByZW5hbWUgaXQgdG8gaHVnZXBhZ2VfYWRqdXN0KCksIHNp
bmNlIGl0J3Mgbm90IGp1c3QgVEhQIGFueW1vcmUuDQoNCk9yIG1heWJlIGFsbG93ZWRfaHVnZXBh
Z2VfYWRqdXN0KCk/ICBUbyBwYWlyIHdpdGggZGlzYWxsb3dlZF9odWdlcGFnZV9hZGp1c3QoKSwN
CndoaWNoIGFkanVzdHMgS1ZNJ3MgcGFnZSBzaXplIGluIHRoZSBvcHBvc2l0ZSBkaXJlY3Rpb24g
dG8gYXZvaWQgdGhlIGlUTEINCm11bHRpLWhpdCBpc3N1ZS4NCg0KPiANCj4gU291bmRzIGdvb2Qu
DQo+IA0KPiA+IA0KPiA+IEkgd2FzIGEgbGl0dGxlIGhlc2l0YW50IHRvIGNoYW5nZSB0aGUgdGhp
cyB0byBoYW5kbGUgMSBHQiBwYWdlcyB3aXRoIHRoaXMNCj4gPiBwYXRjaHNldCBhdCBmaXJzdC4g
IEkgZGlkbid0IHdhbnQgdG8gYnJlYWsgdGhlIG5vbi1EQVggY2FzZSBzdHVmZiBieSBkb2luZw0K
PiA+IHNvLg0KPiANCj4gV2h5IHdvdWxkIGl0IGFmZmVjdCBub24tREFYIGNhc2U/DQo+IFlvdXIg
cGF0Y2ggc2hvdWxkIGp1c3QgbWFrZSBodWdlcGFnZV9hZGp1c3QoKSB0byBwYXJzZSBwYWdlLXRh
YmxlcyBvbmx5IGluIGNhc2UgaXNfem9uZV9kZXZpY2VfcGFnZSgpLiBPdGhlcndpc2UsIHBhZ2Ug
dGFibGVzIHNob3VsZG7igJl0IGJlIHBhcnNlZC4NCj4gaS5lLiBUSFAgbWVyZ2VkIHBhZ2VzIHNo
b3VsZCBzdGlsbCBiZSBkZXRlY3RlZCBieSBQYWdlVHJhbnNDb21wb3VuZE1hcCgpLg0KDQpJIHRo
aW5rIHdoYXQgQmFycmV0IGlzIHNheWluZyBpcyB0aGF0IHRlYWNoaW5nIHRocF9hZGp1c3QoKSBo
b3cgdG8gZG8gMWdiDQptYXBwaW5ncyB3b3VsZCBuYXR1cmFsbHkgYWZmZWN0IHRoZSBjb2RlIHBh
dGggZm9yIFRIUCBwYWdlcy4gIEJ1dCBJIGFncmVlDQp0aGF0IGl0IHdvdWxkIGJlIHN1cGVyZmlj
aWFsLg0KIA0KPiA+IFNwZWNpZmljYWxseSwgY2FuIGEgVEhQIHBhZ2UgYmUgMSBHQiwgYW5kIGlm
IHNvLCBob3cgY2FuIHlvdSB0ZWxsPyAgSWYgeW91DQo+ID4gY2FuJ3QgdGVsbCBlYXNpbHksIEkg
Y291bGQgd2FsayB0aGUgcGFnZSB0YWJsZSBmb3IgYWxsIGNhc2VzLCBpbnN0ZWFkIG9mDQo+ID4g
anVzdCB6b25lX2RldmljZSgpLg0KDQpObywgVEhQIGRvZXNuJ3QgY3VycmVudGx5IHN1cHBvcnQg
MWdiIHBhZ2VzLiAgRXhwbGljaXRpbmcgcmV0dXJuaW5nDQpQTURfU0laRSBvbiBQYWdlVHJhbnND
b21wb3VuZE1hcCgpIHdvdWxkIGJlIGEgZ29vZCB0aGluZyBmcm9tIGEgcmVhZGFiaWxpdHkNCnBl
cnNwZWN0aXZlLg0KDQo+IEkgcHJlZmVyIHRvIHdhbGsgcGFnZS10YWJsZXMgb25seSBmb3IgaXNf
em9uZV9kZXZpY2VfcGFnZSgpLg0KPiANCj4gPiANCj4gPiBJJ2QgYWxzbyBoYXZlIHRvIGRyb3Ag
dGhlICJsZXZlbCA9PSBQVF9QQUdFX1RBQkxFX0xFVkVMIiBjaGVjaywgSSB0aGluaywNCj4gPiB3
aGljaCB3b3VsZCBvcGVuIHRoaXMgdXAgdG8gaHVnZXRsYmZzIHBhZ2VzIChiYXNlZCBvbiB0aGUg
Y29tbWVudHMpLiAgSXMNCj4gPiB0aGVyZSBhbnkgcmVhc29uIHdoeSB0aGF0IHdvdWxkIGJlIGEg
YmFkIGlkZWE/DQoNCk5vLCB0aGUgImxldmVsID09IFBUX1BBR0VfVEFCTEVfTEVWRUwiIGNoZWNr
IGlzIHRvIGZpbHRlciBvdXQgdGhlIGNhc2UNCndoZXJlIEtWTSBpcyBhbHJlYWR5IHBsYW5uaW5n
IG9uIHVzaW5nIGEgbGFyZ2UgcGFnZSwgZS5nLiB3aGVuIHRoZSBtZW1vcnkNCmlzIGJhY2tlZCBi
eSBodWdldGxicy4NCg0KPiBLVk0gYWxyZWFkeSBzdXBwb3J0cyBtYXBwaW5nIDFHQiBodWdldGxi
ZnMgcGFnZXMuIEFzIGxldmVsIGlzIHNldCB0bw0KPiBQVUQtbGV2ZWwgYnkNCj4gdGRwX3BhZ2Vf
ZmF1bHQoKS0+bWFwcGluZ19sZXZlbCgpLT5ob3N0X21hcHBpbmdfbGV2ZWwoKS0+a3ZtX2hvc3Rf
cGFnZV9zaXplKCktPnZtYV9rZXJuZWxfcGFnZXNpemUoKS4NCj4gQXMgVk1BIHdoaWNoIGlzIG1t
YXAgb2YgaHVnZXRsYmZzIHNldHMgdm1hLT52bV9vcHMgdG8gaHVnZXRsYl92bV9vcHMoKSB3aGVy
ZQ0KPiBodWdldGxiX3ZtX29wX3BhZ2VzaXplKCkgd2lsbCByZXR1cm4gYXBwcm9wcmlhdGUgcGFn
ZS1zaXplLg0KPiANCj4gU3BlY2lmaWNhbGx5LCBJIGRvbuKAmXQgdGhpbmsgVEhQIGV2ZXIgbWVy
Z2VzIHNtYWxsIHBhZ2VzIHRvIDFHQiBwYWdlcy4gSSB0aGluaw0KPiB0aGlzIGlzIHdoeSB0cmFu
c3BhcmVudF9odWdlcGFnZV9hZGp1c3QoKSBjaGVja3MgUGFnZVRyYW5zQ29tcG91bmRNYXAoKSBv
bmx5DQo+IGluIGNhc2UgbGV2ZWwgPT0gUFRfUEFHRV9UQUJMRV9MRVZFTC4gSSB0aGluayB5b3Ug
c2hvdWxkIGtlZXAgdGhpcyBjaGVjayBpbg0KPiB0aGUgY2FzZSBvZiAhaXNfem9uZV9kZXZpY2Vf
cGFnZSgpLg0KDQpJIHdvdWxkIGFkZCAxZ2Igc3VwcG9ydCBmb3IgREFYIGFzIGEgdGhpcmQgcGF0
Y2ggaW4gdGhpcyBzZXJpZXMuICBUbyBwYXZlDQp0aGUgd2F5IGluIHBhdGNoIDIvMiwgY2hhbmdl
IGl0IHRvIHJlcGxhY2UgImJvb2wgcGZuX2lzX2h1Z2VfbWFwcGVkKCkiIHdpdGgNCiJpbnQgaG9z
dF9wZm5fbWFwcGluZ19sZXZlbCgpIiwgYW5kIG1heWJlIGFsc28gcmVuYW1pbmcgaG9zdF9tYXBw
aW5nX2xldmVsKCkNCnRvIGhvc3Rfdm1hX21hcHBpbmdfbGV2ZWwoKSB0byBhdm9pZCBjb25mdXNp
b24uDQoNClRoZW4gYWxsb3dlZF9odWdlcGFnZV9hZGp1c3QoKSB3b3VsZCBsb29rIHNvbWV0aGlu
ZyBsaWtlOg0KDQpzdGF0aWMgdm9pZCBhbGxvd2VkX2h1Z2VwYWdlX2FkanVzdChzdHJ1Y3Qga3Zt
X3ZjcHUgKnZjcHUsIGdmbl90IGdmbiwNCgkJCQkgICAga3ZtX3Bmbl90ICpwZm5wLCBpbnQgKmxl
dmVscCwgaW50IG1heF9sZXZlbCkNCnsNCglrdm1fcGZuX3QgcGZuID0gKnBmbnA7DQoJaW50IGxl
dmVsID0gKmxldmVscDsJDQoJdW5zaWduZWQgbG9uZyBtYXNrOw0KDQoJaWYgKGlzX2Vycm9yX25v
c2xvdF9wZm4ocGZuKSB8fCAha3ZtX2lzX3Jlc2VydmVkX3BmbihwZm4pIHx8DQoJICAgIGxldmVs
ID09IFBUX1BBR0VfVEFCTEVfTEVWRUwpDQoJCXJldHVybjsNCg0KCS8qDQoJICogbW11X25vdGlm
aWVyX3JldHJ5KCkgd2FzIHN1Y2Nlc3NmdWwgYW5kIG1tdV9sb2NrIGlzIGhlbGQsIHNvDQoJICog
dGhlIHBtZC9wdWQgY2FuJ3QgYmUgc3BsaXQgZnJvbSB1bmRlciB1cy4NCgkgKi8NCglsZXZlbCA9
IGhvc3RfcGZuX21hcHBpbmdfbGV2ZWwodmNwdS0+a3ZtLCBnZm4sIHBmbik7DQoNCgkqbGV2ZWxw
ID0gbGV2ZWwgPSBtaW4obGV2ZWwsIG1heF9sZXZlbCk7DQoJbWFzayA9IEtWTV9QQUdFU19QRVJf
SFBBR0UobGV2ZWwpIC0gMTsNCglWTV9CVUdfT04oKGdmbiAmIG1hc2spICE9IChwZm4gJiBtYXNr
KSk7DQoJKnBmbnAgPSBwZm4gJiB+bWFzazsNCn0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1u
dmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgt
bnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
