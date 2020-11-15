Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E287B2B32E8
	for <lists+linux-nvdimm@lfdr.de>; Sun, 15 Nov 2020 09:26:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F729100EF26E;
	Sun, 15 Nov 2020 00:26:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28F0A100EF263
	for <linux-nvdimm@lists.01.org>; Sun, 15 Nov 2020 00:26:39 -0800 (PST)
Received: from kernel.org (unknown [77.125.7.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2B40D20825;
	Sun, 15 Nov 2020 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1605428798;
	bh=N8nX4EItu7ygJosleHRb6Se+RCkeKeuBhze7L0pxdoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzCqWMqjydzAb9tsTc50ml1otm0W+jgR45ewsq/G5RaHSABMkhoMFFhu9KCzP5EgM
	 H4hHM4CWx5jTJGIkXhhIkkUUbJjjG0LCaHvvN1Sygkt5FEaoKMH2vyKuxCD0ZXI6ak
	 TE0ypAnInCIfqSa2/EaG3mDDyN0He79bGRMwfBCI=
Date: Sun, 15 Nov 2020 10:26:25 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
Message-ID: <20201115082625.GT4758@kernel.org>
References: <20201112190827.GP4758@kernel.org>
 <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
Message-ID-Hash: DN74IX5ZKZO7LBJLY77FDMQMDPCDO7Q2
X-Message-ID-Hash: DN74IX5ZKZO7LBJLY77FDMQMDPCDO7Q2
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DN74IX5ZKZO7LBJLY77FDMQMDPCDO7Q2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBOb3YgMTIsIDIwMjAgYXQgMDk6MTU6MThQTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IA0KPiA+IEFtIDEyLjExLjIwMjAgdW0gMjA6MDggc2NocmllYiBNaWtlIFJh
cG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+Og0KPiA+IA0KPiA+IO+7v09uIFRodSwgTm92IDEyLCAy
MDIwIGF0IDA1OjIyOjAwUE0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPiA+Pj4g
T24gMTAuMTEuMjAgMTk6MDYsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+ID4+PiBPbiBUdWUsIE5v
diAxMCwgMjAyMCBhdCAwNjoxNzoyNlBNICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToN
Cj4gPj4+PiBPbiAxMC4xMS4yMCAxNjoxNCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4gPj4+Pj4g
RnJvbTogTWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiA+Pj4+PiANCj4gPj4+
Pj4gSXQgd2lsbCBiZSB1c2VkIGJ5IHRoZSB1cGNvbWluZyBzZWNyZXQgbWVtb3J5IGltcGxlbWVu
dGF0aW9uLg0KPiA+Pj4+PiANCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWlrZSBSYXBvcG9ydCA8
cnBwdEBsaW51eC5pYm0uY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gICBtbS9pbnRlcm5hbC5o
IHwgMyArKysNCj4gPj4+Pj4gICBtbS9tbWFwLmMgICAgIHwgNSArKy0tLQ0KPiA+Pj4+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pj4+PiAN
Cj4gPj4+Pj4gZGlmZiAtLWdpdCBhL21tL2ludGVybmFsLmggYi9tbS9pbnRlcm5hbC5oDQo+ID4+
Pj4+IGluZGV4IGM0M2NjZGRkYjBmNi4uYWUxNDZhMjYwYjE0IDEwMDY0NA0KPiA+Pj4+PiAtLS0g
YS9tbS9pbnRlcm5hbC5oDQo+ID4+Pj4+ICsrKyBiL21tL2ludGVybmFsLmgNCj4gPj4+Pj4gQEAg
LTM0OCw2ICszNDgsOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbXVubG9ja192bWFfcGFnZXNfYWxs
KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQ0KPiA+Pj4+PiAgIGV4dGVybiB2b2lkIG1sb2Nr
X3ZtYV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKTsNCj4gPj4+Pj4gICBleHRlcm4gdW5zaWduZWQg
aW50IG11bmxvY2tfdm1hX3BhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpOw0KPiA+Pj4+PiArZXh0ZXJu
IGludCBtbG9ja19mdXR1cmVfY2hlY2soc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxv
bmcgZmxhZ3MsDQo+ID4+Pj4+ICsgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIGxlbik7
DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gICAvKg0KPiA+Pj4+PiAgICAqIENsZWFyIHRoZSBwYWdlJ3Mg
UGFnZU1sb2NrZWQoKS4gIFRoaXMgY2FuIGJlIHVzZWZ1bCBpbiBhIHNpdHVhdGlvbiB3aGVyZQ0K
PiA+Pj4+PiAgICAqIHdlIHdhbnQgdG8gdW5jb25kaXRpb25hbGx5IHJlbW92ZSBhIHBhZ2UgZnJv
bSB0aGUgcGFnZWNhY2hlIC0tIGUuZy4sDQo+ID4+Pj4+IGRpZmYgLS1naXQgYS9tbS9tbWFwLmMg
Yi9tbS9tbWFwLmMNCj4gPj4+Pj4gaW5kZXggNjFmNzJiMDlkOTkwLi5jNDgxZjA4OGJkNTAgMTAw
NjQ0DQo+ID4+Pj4+IC0tLSBhL21tL21tYXAuYw0KPiA+Pj4+PiArKysgYi9tbS9tbWFwLmMNCj4g
Pj4+Pj4gQEAgLTEzNDgsOSArMTM0OCw4IEBAIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBy
b3VuZF9oaW50X3RvX21pbih1bnNpZ25lZCBsb25nIGhpbnQpDQo+ID4+Pj4+ICAgICAgIHJldHVy
biBoaW50Ow0KPiA+Pj4+PiAgIH0NCj4gPj4+Pj4gLXN0YXRpYyBpbmxpbmUgaW50IG1sb2NrX2Z1
dHVyZV9jaGVjayhzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gPj4+Pj4gLSAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MsDQo+ID4+Pj4+IC0gICAgICAgICAgICAgICAgICAg
ICB1bnNpZ25lZCBsb25nIGxlbikNCj4gPj4+Pj4gK2ludCBtbG9ja19mdXR1cmVfY2hlY2soc3Ry
dWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgZmxhZ3MsDQo+ID4+Pj4+ICsgICAgICAg
ICAgICAgICB1bnNpZ25lZCBsb25nIGxlbikNCj4gPj4+Pj4gICB7DQo+ID4+Pj4+ICAgICAgIHVu
c2lnbmVkIGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0Ow0KPiA+Pj4+PiANCj4gPj4+PiANCj4gPj4+
PiBTbywgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24gaXMgaWYgeW91IGFjdHVhbGx5IHdhbnQgdG8g
Y2hhcmdlIHNlY3JldG1lbQ0KPiA+Pj4+IHBhZ2VzIGFnYWluc3QgbWxvY2sgbm93LCBvciBpZiB5
b3Ugd2FudCBhIGRlZGljYXRlZCBzZWNyZXRtZW0gY2dyb3VwDQo+ID4+Pj4gY29udHJvbGxlciBp
bnN0ZWFkPw0KPiA+Pj4gDQo+ID4+PiBXZWxsLCB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uIHRoZXJlIGFyZSB0aHJlZSBsaW1pdHMgYW4NCj4gPj4+IGFkbWluaXN0cmF0b3IgY2FuIHVz
ZSB0byBjb250cm9sIHNlY3JldG1lbSBsaW1pdHM6IG1sb2NrLCBtZW1jZyBhbmQNCj4gPj4+IGtl
cm5lbCBwYXJhbWV0ZXIuDQo+ID4+PiANCj4gPj4+IFRoZSBrZXJuZWwgcGFyYW1ldGVyIHB1dHMg
YSBnbG9iYWwgdXBwZXIgbGltaXQgZm9yIHNlY3JldG1lbSB1c2FnZSwNCj4gPj4+IG1lbWNnIGFj
Y291bnRzIGFsbCBzZWNyZXRtZW0gYWxsb2NhdGlvbnMsIGluY2x1ZGluZyB0aGUgdW51c2VkIG1l
bW9yeSBpbg0KPiA+Pj4gbGFyZ2UgcGFnZXMgY2FjaGluZyBhbmQgbWxvY2sgYWxsb3dzIHBlciB0
YXNrIGxpbWl0IGZvciBzZWNyZXRtZW0NCj4gPj4+IG1hcHBpbmdzLCB3ZWxsLCBsaWtlIG1sb2Nr
IGRvZXMuDQo+ID4+PiANCj4gPj4+IEkgZGlkbid0IGNvbnNpZGVyIGEgZGVkaWNhdGVkIGNncm91
cCwgYXMgaXQgc2VlbXMgd2UgYWxyZWFkeSBoYXZlIGVub3VnaA0KPiA+Pj4gZXhpc3Rpbmcga25v
YnMgYW5kIGEgbmV3IG9uZSB3b3VsZCBiZSB1bm5lY2Vzc2FyeS4NCj4gPj4gDQo+ID4+IFRvIG1l
IGl0IGZlZWxzIGxpa2UgdGhlIG1sb2NrKCkgbGltaXQgaXMgYSB3cm9uZyBmaXQgZm9yIHNlY3Jl
dG1lbS4gQnV0DQo+ID4+IG1heWJlIHRoZXJlIGFyZSBvdGhlciBjYXNlcyBvZiB1c2luZyB0aGUg
bWxvY2soKSBsaW1pdCB3aXRob3V0IGFjdHVhbGx5DQo+ID4+IGRvaW5nIG1sb2NrKCkgdGhhdCBJ
IGFtIG5vdCBhd2FyZSBvZiAobW9zdCBwcm9iYWJseSA6KSApPw0KPiA+IA0KPiA+IFNlY3JldG1l
bSBkb2VzIG5vdCBleHBsaWNpdGx5IGNhbGxzIHRvIG1sb2NrKCkgYnV0IGl0IGRvZXMgd2hhdCBt
bG9jaygpDQo+ID4gZG9lcyBhbmQgYSBiaXQgbW9yZS4gQ2l0aW5nIG1sb2NrKDIpOg0KPiA+IA0K
PiA+ICBtbG9jaygpLCAgbWxvY2syKCksICBhbmQgIG1sb2NrYWxsKCkgIGxvY2sgIHBhcnQgIG9y
IGFsbCBvZiB0aGUgY2FsbGluZw0KPiA+ICBwcm9jZXNzJ3MgdmlydHVhbCBhZGRyZXNzIHNwYWNl
IGludG8gUkFNLCBwcmV2ZW50aW5nIHRoYXQgIG1lbW9yeSAgZnJvbQ0KPiA+ICBiZWluZyBwYWdl
ZCB0byB0aGUgc3dhcCBhcmVhLg0KPiA+IA0KPiA+IFNvLCBiYXNlZCBvbiB0aGF0IHNlY3JldG1l
bSBwYWdlcyBhcmUgbm90IHN3YXBwYWJsZSwgSSB0aGluayB0aGF0DQo+ID4gUkxJTUlUX01FTUxP
Q0sgaXMgYXBwcm9wcmlhdGUgaGVyZS4NCj4gPiANCj4gDQo+IFRoZSBwYWdlIGV4cGxpY2l0bHkg
bGlzdHMgbWxvY2soKSBzeXN0ZW0gY2FsbHMuDQoNCldlbGwsIGl0J3MgbWxvY2soKSBtYW4gcGFn
ZSwgaXNuJ3QgaXQ/IDstKQ0KDQpNeSB0aGlua2luZyB3YXMgdGhhdCBzaW5jZSBzZWNyZXRtZW0g
ZG9lcyB3aGF0IG1sb2NrKCkgZG9lcyB3cnQNCnN3YXBhYmlsaXR5LCBpdCBzaG91bGQgYXQgbGVh
c3Qgb2JleSB0aGUgc2FtZSBsaW1pdCwgaS5lLg0KUkxJTUlUX01FTUxPQ0suDQoNCj4gRS5nLiwg
d2UgYWxzbyBkb27igJh0DQo+IGFjY291bnQgZm9yIGdpZ2FudGljIHBhZ2VzIC0gd2hpY2ggbWln
aHQgYmUgYWxsb2NhdGVkIGZyb20gQ01BIGFuZCBhcmUNCj4gbm90IHN3YXBwYWJsZS4NCiANCkRv
IHlvdSBtZWFuIGdpZ2FudGljIHBhZ2VzIGluIGh1Z2V0bGJmcz8NCkl0IHNlZW1zIHRvIG1lIHRo
YXQgaHVnZXRsYmZzIGFjY291bnRpbmcgaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudA0Kc3Rvcnku
DQoNCj4gPj4gSSBtZWFuLCBteSBjb25jZXJuIGlzIG5vdCBlYXJ0aCBzaGF0dGVyaW5nLCB0aGlz
IGNhbiBiZSByZXdvcmtlZCBsYXRlci4gQXMgSQ0KPiA+PiBzYWlkLCBpdCBqdXN0IGZlZWxzIHdy
b25nLg0KPiA+PiANCj4gPj4gLS0gDQo+ID4+IFRoYW5rcywNCj4gPj4gDQo+ID4+IERhdmlkIC8g
ZGhpbGRlbmINCj4gPj4gDQo+ID4gDQo+ID4gLS0gDQo+ID4gU2luY2VyZWx5IHlvdXJzLA0KPiA+
IE1pa2UuDQo+ID4gDQo+IA0KDQotLSANClNpbmNlcmVseSB5b3VycywNCk1pa2UuCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
