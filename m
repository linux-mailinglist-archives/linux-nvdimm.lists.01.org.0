Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52592B6844
	for <lists+linux-nvdimm@lfdr.de>; Tue, 17 Nov 2020 16:10:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A763100ED494;
	Tue, 17 Nov 2020 07:10:03 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD0F4100ED492
	for <linux-nvdimm@lists.01.org>; Tue, 17 Nov 2020 07:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1605625798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avqgkPhMAEZAPZkBU6g1zM+EphNhv69bq0mDQ2MSyGE=;
	b=S8TAwo3s+rzbgiROW+UXpjWuAMeWLY0T/ao/dlLpi6P3/fzg/Cy+miIIhYAZUuSqIcENSN
	JWwM/sonGHJvetmLJA/OD2cFD8YmR/3UEHYlN3hUx2LzUobkeP+BViO5M+M3/JccFmehoQ
	ZJqn+FlptXuQGX05cWf+j/YCY8V4G1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-K75Q0U6RPOe3OPIwoMgYvA-1; Tue, 17 Nov 2020 10:09:53 -0500
X-MC-Unique: K75Q0U6RPOe3OPIwoMgYvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87EF157090;
	Tue, 17 Nov 2020 15:09:49 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BF2366BF6B;
	Tue, 17 Nov 2020 15:09:40 +0000 (UTC)
Subject: Re: [PATCH v8 2/9] mmap: make mlock_future_check() global
To: Mike Rapoport <rppt@kernel.org>
References: <20201112190827.GP4758@kernel.org>
 <7A16CA44-782D-4ABA-8D93-76BDD0A90F94@redhat.com>
 <20201115082625.GT4758@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d47fdd2e-a8fa-6792-ca8f-e529be76340c@redhat.com>
Date: Tue, 17 Nov 2020 16:09:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201115082625.GT4758@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: GPLWAOSQIKJM7WEOEOEW72AIFRISVKTR
X-Message-ID-Hash: GPLWAOSQIKJM7WEOEOEW72AIFRISVKTR
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.ker
 nel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GPLWAOSQIKJM7WEOEOEW72AIFRISVKTR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTUuMTEuMjAgMDk6MjYsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIFRodSwgTm92IDEy
LCAyMDIwIGF0IDA5OjE1OjE4UE0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4N
Cj4+PiBBbSAxMi4xMS4yMDIwIHVtIDIwOjA4IHNjaHJpZWIgTWlrZSBSYXBvcG9ydCA8cnBwdEBr
ZXJuZWwub3JnPjoNCj4+Pg0KPj4+IO+7v09uIFRodSwgTm92IDEyLCAyMDIwIGF0IDA1OjIyOjAw
UE0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+Pj4gT24gMTAuMTEuMjAgMTk6
MDYsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4+PiBPbiBUdWUsIE5vdiAxMCwgMjAyMCBhdCAw
NjoxNzoyNlBNICswMTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+Pj4+PiBPbiAxMC4x
MS4yMCAxNjoxNCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4+Pj4+Pj4gRnJvbTogTWlrZSBSYXBv
cG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJdCB3aWxsIGJlIHVz
ZWQgYnkgdGhlIHVwY29taW5nIHNlY3JldCBtZW1vcnkgaW1wbGVtZW50YXRpb24uDQo+Pj4+Pj4+
DQo+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNv
bT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+ICAgIG1tL2ludGVybmFsLmggfCAzICsrKw0KPj4+Pj4+
PiAgICBtbS9tbWFwLmMgICAgIHwgNSArKy0tLQ0KPj4+Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAt
LWdpdCBhL21tL2ludGVybmFsLmggYi9tbS9pbnRlcm5hbC5oDQo+Pj4+Pj4+IGluZGV4IGM0M2Nj
ZGRkYjBmNi4uYWUxNDZhMjYwYjE0IDEwMDY0NA0KPj4+Pj4+PiAtLS0gYS9tbS9pbnRlcm5hbC5o
DQo+Pj4+Pj4+ICsrKyBiL21tL2ludGVybmFsLmgNCj4+Pj4+Pj4gQEAgLTM0OCw2ICszNDgsOSBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgbXVubG9ja192bWFfcGFnZXNfYWxsKHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hKQ0KPj4+Pj4+PiAgICBleHRlcm4gdm9pZCBtbG9ja192bWFfcGFnZShzdHJ1
Y3QgcGFnZSAqcGFnZSk7DQo+Pj4+Pj4+ICAgIGV4dGVybiB1bnNpZ25lZCBpbnQgbXVubG9ja192
bWFfcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSk7DQo+Pj4+Pj4+ICtleHRlcm4gaW50IG1sb2NrX2Z1
dHVyZV9jaGVjayhzdHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBmbGFncywNCj4+
Pj4+Pj4gKyAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbGVuKTsNCj4+Pj4+Pj4gKw0K
Pj4+Pj4+PiAgICAvKg0KPj4+Pj4+PiAgICAgKiBDbGVhciB0aGUgcGFnZSdzIFBhZ2VNbG9ja2Vk
KCkuICBUaGlzIGNhbiBiZSB1c2VmdWwgaW4gYSBzaXR1YXRpb24gd2hlcmUNCj4+Pj4+Pj4gICAg
ICogd2Ugd2FudCB0byB1bmNvbmRpdGlvbmFsbHkgcmVtb3ZlIGEgcGFnZSBmcm9tIHRoZSBwYWdl
Y2FjaGUgLS0gZS5nLiwNCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAu
Yw0KPj4+Pj4+PiBpbmRleCA2MWY3MmIwOWQ5OTAuLmM0ODFmMDg4YmQ1MCAxMDA2NDQNCj4+Pj4+
Pj4gLS0tIGEvbW0vbW1hcC5jDQo+Pj4+Pj4+ICsrKyBiL21tL21tYXAuYw0KPj4+Pj4+PiBAQCAt
MTM0OCw5ICsxMzQ4LDggQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHJvdW5kX2hpbnRf
dG9fbWluKHVuc2lnbmVkIGxvbmcgaGludCkNCj4+Pj4+Pj4gICAgICAgIHJldHVybiBoaW50Ow0K
Pj4+Pj4+PiAgICB9DQo+Pj4+Pj4+IC1zdGF0aWMgaW5saW5lIGludCBtbG9ja19mdXR1cmVfY2hl
Y2soc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+Pj4+Pj4+IC0gICAgICAgICAgICAgICAgICAgICB1
bnNpZ25lZCBsb25nIGZsYWdzLA0KPj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgdW5zaWdu
ZWQgbG9uZyBsZW4pDQo+Pj4+Pj4+ICtpbnQgbWxvY2tfZnV0dXJlX2NoZWNrKHN0cnVjdCBtbV9z
dHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nIGZsYWdzLA0KPj4+Pj4+PiArICAgICAgICAgICAgICAg
dW5zaWduZWQgbG9uZyBsZW4pDQo+Pj4+Pj4+ICAgIHsNCj4+Pj4+Pj4gICAgICAgIHVuc2lnbmVk
IGxvbmcgbG9ja2VkLCBsb2NrX2xpbWl0Ow0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU28sIGFu
IGludGVyZXN0aW5nIHF1ZXN0aW9uIGlzIGlmIHlvdSBhY3R1YWxseSB3YW50IHRvIGNoYXJnZSBz
ZWNyZXRtZW0NCj4+Pj4+PiBwYWdlcyBhZ2FpbnN0IG1sb2NrIG5vdywgb3IgaWYgeW91IHdhbnQg
YSBkZWRpY2F0ZWQgc2VjcmV0bWVtIGNncm91cA0KPj4+Pj4+IGNvbnRyb2xsZXIgaW5zdGVhZD8N
Cj4+Pj4+DQo+Pj4+PiBXZWxsLCB3aXRoIHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIHRoZXJl
IGFyZSB0aHJlZSBsaW1pdHMgYW4NCj4+Pj4+IGFkbWluaXN0cmF0b3IgY2FuIHVzZSB0byBjb250
cm9sIHNlY3JldG1lbSBsaW1pdHM6IG1sb2NrLCBtZW1jZyBhbmQNCj4+Pj4+IGtlcm5lbCBwYXJh
bWV0ZXIuDQo+Pj4+Pg0KPj4+Pj4gVGhlIGtlcm5lbCBwYXJhbWV0ZXIgcHV0cyBhIGdsb2JhbCB1
cHBlciBsaW1pdCBmb3Igc2VjcmV0bWVtIHVzYWdlLA0KPj4+Pj4gbWVtY2cgYWNjb3VudHMgYWxs
IHNlY3JldG1lbSBhbGxvY2F0aW9ucywgaW5jbHVkaW5nIHRoZSB1bnVzZWQgbWVtb3J5IGluDQo+
Pj4+PiBsYXJnZSBwYWdlcyBjYWNoaW5nIGFuZCBtbG9jayBhbGxvd3MgcGVyIHRhc2sgbGltaXQg
Zm9yIHNlY3JldG1lbQ0KPj4+Pj4gbWFwcGluZ3MsIHdlbGwsIGxpa2UgbWxvY2sgZG9lcy4NCj4+
Pj4+DQo+Pj4+PiBJIGRpZG4ndCBjb25zaWRlciBhIGRlZGljYXRlZCBjZ3JvdXAsIGFzIGl0IHNl
ZW1zIHdlIGFscmVhZHkgaGF2ZSBlbm91Z2gNCj4+Pj4+IGV4aXN0aW5nIGtub2JzIGFuZCBhIG5l
dyBvbmUgd291bGQgYmUgdW5uZWNlc3NhcnkuDQo+Pj4+DQo+Pj4+IFRvIG1lIGl0IGZlZWxzIGxp
a2UgdGhlIG1sb2NrKCkgbGltaXQgaXMgYSB3cm9uZyBmaXQgZm9yIHNlY3JldG1lbS4gQnV0DQo+
Pj4+IG1heWJlIHRoZXJlIGFyZSBvdGhlciBjYXNlcyBvZiB1c2luZyB0aGUgbWxvY2soKSBsaW1p
dCB3aXRob3V0IGFjdHVhbGx5DQo+Pj4+IGRvaW5nIG1sb2NrKCkgdGhhdCBJIGFtIG5vdCBhd2Fy
ZSBvZiAobW9zdCBwcm9iYWJseSA6KSApPw0KPj4+DQo+Pj4gU2VjcmV0bWVtIGRvZXMgbm90IGV4
cGxpY2l0bHkgY2FsbHMgdG8gbWxvY2soKSBidXQgaXQgZG9lcyB3aGF0IG1sb2NrKCkNCj4+PiBk
b2VzIGFuZCBhIGJpdCBtb3JlLiBDaXRpbmcgbWxvY2soMik6DQo+Pj4NCj4+PiAgIG1sb2NrKCks
ICBtbG9jazIoKSwgIGFuZCAgbWxvY2thbGwoKSAgbG9jayAgcGFydCAgb3IgYWxsIG9mIHRoZSBj
YWxsaW5nDQo+Pj4gICBwcm9jZXNzJ3MgdmlydHVhbCBhZGRyZXNzIHNwYWNlIGludG8gUkFNLCBw
cmV2ZW50aW5nIHRoYXQgIG1lbW9yeSAgZnJvbQ0KPj4+ICAgYmVpbmcgcGFnZWQgdG8gdGhlIHN3
YXAgYXJlYS4NCj4+Pg0KPj4+IFNvLCBiYXNlZCBvbiB0aGF0IHNlY3JldG1lbSBwYWdlcyBhcmUg
bm90IHN3YXBwYWJsZSwgSSB0aGluayB0aGF0DQo+Pj4gUkxJTUlUX01FTUxPQ0sgaXMgYXBwcm9w
cmlhdGUgaGVyZS4NCj4+Pg0KPj4NCj4+IFRoZSBwYWdlIGV4cGxpY2l0bHkgbGlzdHMgbWxvY2so
KSBzeXN0ZW0gY2FsbHMuDQo+IA0KPiBXZWxsLCBpdCdzIG1sb2NrKCkgbWFuIHBhZ2UsIGlzbid0
IGl0PyA7LSkNCg0KOykNCg0KPiANCj4gTXkgdGhpbmtpbmcgd2FzIHRoYXQgc2luY2Ugc2VjcmV0
bWVtIGRvZXMgd2hhdCBtbG9jaygpIGRvZXMgd3J0DQo+IHN3YXBhYmlsaXR5LCBpdCBzaG91bGQg
YXQgbGVhc3Qgb2JleSB0aGUgc2FtZSBsaW1pdCwgaS5lLg0KPiBSTElNSVRfTUVNTE9DSy4NCg0K
UmlnaHQsIGJ1dCBhdCBsZWFzdCBjdXJyZW50bHksIGl0IGJlaGF2ZXMgbGlrZSBhbnkgb3RoZXIg
Q01BIGFsbG9jYXRpb24gDQooSUlSQyB0aGV5IGFyZSBhbGwgdW5tb3ZhYmxlIGFuZCwgdGhlcmVm
b3JlLCBub3Qgc3dhcHBhYmxlKS4gSW4gdGhlIA0KZnV0dXJlLCBpZiBwYWdlcyB3b3VsZCBiZSBt
b3ZhYmxlIChidXQgbm90IHN3YXBwYWJsZSksIEkgZ3Vlc3MgaXQgbWlnaHQgDQptYWtlcyBtb3Jl
IHNlbnNlLiBJIGFzc3VtZSB3ZSBuZXZlciBldmVyIHdhbnQgdG8gc3dhcCBzZWNyZXRtZW0uDQoN
CiJtYW4gZ2V0cmxpbWl0IiBzdGF0ZXMgZm9yIFJMSU1JVF9NRU1MT0NLOg0KDQoiVGhpcyBpcyB0
aGUgbWF4aW11bSBudW1iZXIgb2YgYnl0ZXMgb2YgbWVtb3J5IHRoYXQgbWF5IGJlDQogIGxvY2tl
ZCBpbnRvIFJBTS4gIFsuLi5dIFRoaXMgbGltaXQgYWZmZWN0cw0KICBtbG9jaygyKSwgbWxvY2th
bGwoMiksIGFuZCB0aGUgbW1hcCgyKSBNQVBfTE9DS0VEIG9wZXJhdGlvbi4NCiAgU2luY2UgTGlu
dXggMi42LjksIGl0IGFsc28gYWZmZWN0cyB0aGUgc2htY3RsKDIpIFNITV9MT0NLIG9w4oCQDQog
IGVyYXRpb24gWy4uLl0iDQoNClNvIHRoYXQgcGxhY2UgaGFzIHRvIGJlIHVwZGF0ZWQgYXMgd2Vs
bCBJIGd1ZXNzPyBPdGhlcndpc2UgdGhpcyBtaWdodCANCmNvbWUgYXMgYSBzdXJwcmlzZSBmb3Ig
dXNlcnMuDQoNCj4gDQo+PiBFLmcuLCB3ZSBhbHNvIGRvbuKAmHQNCj4+IGFjY291bnQgZm9yIGdp
Z2FudGljIHBhZ2VzIC0gd2hpY2ggbWlnaHQgYmUgYWxsb2NhdGVkIGZyb20gQ01BIGFuZCBhcmUN
Cj4+IG5vdCBzd2FwcGFibGUuDQo+ICAgDQo+IERvIHlvdSBtZWFuIGdpZ2FudGljIHBhZ2VzIGlu
IGh1Z2V0bGJmcz8NCg0KWWVzDQoNCj4gSXQgc2VlbXMgdG8gbWUgdGhhdCBodWdldGxiZnMgYWNj
b3VudGluZyBpcyBhIGNvbXBsZXRlbHkgZGlmZmVyZW50DQo+IHN0b3J5Lg0KDQpJJ2Qgc2F5IGl0
IGlzIHJpZ2h0IG5vdyBjb21wYXJhYmxlIHRvIHNlY3JldG1lbSAtIHdoaWNoIGlzIHdoeSBJIHRo
b3VnaCANCnNpbWlsYXIgYWNjb3VudGluZyB3b3VsZCBtYWtlIHNlbnNlLg0KDQoNCi0tIA0KVGhh
bmtzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
