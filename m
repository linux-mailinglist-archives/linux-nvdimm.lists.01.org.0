Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B279B318A0E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Feb 2021 13:07:36 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C34F1100EA2A9;
	Thu, 11 Feb 2021 04:07:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=david@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3AFC6100EA2A2
	for <linux-nvdimm@lists.01.org>; Thu, 11 Feb 2021 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1613045249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxdQiOdDrI0lN+ynkHsa9xjwUnD3y3w6sb41lTRrq7A=;
	b=KEp6mbGO452Aa13L/XsJPyLboNBxjMDXzEHL14zg0eHqU3oEq20XMpFkITBBTTeNobFoVf
	Ts0VL/ZRxyqxVuT1c5ISawLgboTxQuJcalB9YHah2DH1Y+0ue5LzHH5R0ue/2AmOsqNoTt
	FK78o3ivO8np5LJbBU7EXDAnRajPB34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-HGb2gjz-PHmITs_HU4BpDA-1; Thu, 11 Feb 2021 07:07:25 -0500
X-MC-Unique: HGb2gjz-PHmITs_HU4BpDA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51157192AB79;
	Thu, 11 Feb 2021 12:07:20 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 001DD60C0F;
	Thu, 11 Feb 2021 12:07:10 +0000 (UTC)
To: Mike Rapoport <rppt@kernel.org>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org> <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org> <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
 <20210209090938.GP299309@linux.ibm.com> <YCKLVzBR62+NtvyF@dhcp22.suse.cz>
 <20210211071319.GF242749@kernel.org> <YCTtSrCEvuBug2ap@dhcp22.suse.cz>
 <0d66baec-1898-987b-7eaf-68a015c027ff@redhat.com>
 <20210211112702.GI242749@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <05082284-bd85-579f-2b3e-9b1af663eb6f@redhat.com>
Date: Thu, 11 Feb 2021 13:07:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210211112702.GI242749@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Message-ID-Hash: ZNMV5GDIKA3V7QPJV7Z4VUAMJYMRHOEI
X-Message-ID-Hash: ZNMV5GDIKA3V7QPJV7Z4VUAMJYMRHOEI
X-MailFrom: david@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Anders
 en <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZNMV5GDIKA3V7QPJV7Z4VUAMJYMRHOEI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

T24gMTEuMDIuMjEgMTI6MjcsIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+IE9uIFRodSwgRmViIDEx
LCAyMDIxIGF0IDEwOjAxOjMyQU0gKzAxMDAsIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4g
T24gMTEuMDIuMjEgMDk6MzksIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4+PiBPbiBUaHUgMTEtMDIt
MjEgMDk6MTM6MTksIE1pa2UgUmFwb3BvcnQgd3JvdGU6DQo+Pj4+IE9uIFR1ZSwgRmViIDA5LCAy
MDIxIGF0IDAyOjE3OjExUE0gKzAxMDAsIE1pY2hhbCBIb2NrbyB3cm90ZToNCj4+Pj4+IE9uIFR1
ZSAwOS0wMi0yMSAxMTowOTozOCwgTWlrZSBSYXBvcG9ydCB3cm90ZToNCj4+PiBbLi4uXQ0KPj4+
Pj4+IENpdGluZyBteSBvbGRlciBlbWFpbDoNCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgIEkndmUgaGVz
aXRhdGVkIHdoZXRoZXIgdG8gY29udGludWUgdG8gdXNlIG5ldyBmbGFncyB0byBtZW1mZF9jcmVh
dGUoKSBvciB0bw0KPj4+Pj4+ICAgICAgIGFkZCBhIG5ldyBzeXN0ZW0gY2FsbCBhbmQgSSd2ZSBk
ZWNpZGVkIHRvIHVzZSBhIG5ldyBzeXN0ZW0gY2FsbCBhZnRlciBJJ3ZlDQo+Pj4+Pj4gICAgICAg
c3RhcnRlZCB0byBsb29rIGludG8gbWFuIHBhZ2VzIHVwZGF0ZS4gVGhlcmUgd291bGQgaGF2ZSBi
ZWVuIHR3byBjb21wbGV0ZWx5DQo+Pj4+Pj4gICAgICAgaW5kZXBlbmRlbnQgZGVzY3JpcHRpb25z
IGFuZCBJIHRoaW5rIGl0IHdvdWxkIGhhdmUgYmVlbiB2ZXJ5IGNvbmZ1c2luZy4NCj4+Pj4+DQo+
Pj4+PiBDb3VsZCB5b3UgZWxhYm9yYXRlPyBVbm1hcHBpbmcgZnJvbSB0aGUga2VybmVsIGFkZHJl
c3Mgc3BhY2UgY2FuIHdvcmsNCj4+Pj4+IGJvdGggZm9yIHNlYWxlZCBvciBodWdldGxiIG1lbWZk
cywgbm8/IFRob3NlIGZlYXR1cmVzIGFyZSBjb21wbGV0ZWx5DQo+Pj4+PiBvcnRob2dvbmFsIEFG
QUlDUy4gV2l0aCBhIGRlZGljYXRlZCBzeXNjYWxsIHlvdSB3aWxsIG5lZWQgdG8gaW50cm9kdWNl
DQo+Pj4+PiB0aGlzIGZ1bmN0aW9uYWxpdHkgb24gdG9wIGlmIHRoYXQgaXMgcmVxdWlyZWQuIEhh
dmUgeW91IGNvbnNpZGVyZWQgdGhhdD8NCj4+Pj4+IEkgbWVhbiBodWdldGxiIHBhZ2VzIGFyZSB1
c2VkIHRvIGJhY2sgZ3Vlc3QgbWVtb3J5IHZlcnkgb2Z0ZW4uIElzIHRoaXMNCj4+Pj4+IHNvbWV0
aGluZyB0aGF0IHdpbGwgYmUgYSBzZWNyZXQgbWVtb3J5IHVzZWNhc2U/DQo+Pj4+Pg0KPj4+Pj4g
UGxlYXNlIGJlIHJlYWxseSBzcGVjaWZpYyB3aGVuIGdpdmluZyBhcmd1bWVudHMgdG8gYmFjayBh
IG5ldyBzeXNjYWxsDQo+Pj4+PiBkZWNpc2lvbi4NCj4+Pj4NCj4+Pj4gSXNuJ3QgInN5c2NhbGxz
IGhhdmUgY29tcGxldGVseSBpbmRlcGVuZGVudCBkZXNjcmlwdGlvbiIgc3BlY2lmaWMgZW5vdWdo
Pw0KPj4+DQo+Pj4gTm8sIGl0J3Mgbm90IGFzIHlvdSBjYW4gc2VlIGZyb20gcXVlc3Rpb25zIEkn
dmUgaGFkIGFib3ZlLiBNb3JlIG9uIHRoYXQNCj4+PiBiZWxvdy4NCj4+Pg0KPj4+PiBXZSBhcmUg
dGFsa2luZyBhYm91dCBBUEkgaGVyZSwgbm90IHRoZSBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzIHdo
ZXRoZXINCj4+Pj4gc2VjcmV0bWVtIHN1cHBvcnRzIGxhcmdlIHBhZ2VzIG9yIG5vdC4NCj4+Pj4N
Cj4+Pj4gVGhlIHB1cnBvc2Ugb2YgbWVtZmRfY3JlYXRlKCkgaXMgdG8gY3JlYXRlIGEgZmlsZS1s
aWtlIGFjY2VzcyB0byBtZW1vcnkuDQo+Pj4+IFRoZSBwdXJwb3NlIG9mIG1lbWZkX3NlY3JldCgp
IGlzIHRvIGNyZWF0ZSBhIHdheSB0byBhY2Nlc3MgbWVtb3J5IGhpZGRlbg0KPj4+PiBmcm9tIHRo
ZSBrZXJuZWwuDQo+Pj4+DQo+Pj4+IEkgZG9uJ3QgdGhpbmsgb3ZlcmxvYWRpbmcgbWVtZmRfY3Jl
YXRlKCkgd2l0aCB0aGUgc2VjcmV0bWVtIGZsYWdzIGJlY2F1c2UNCj4+Pj4gdGhleSBoYXBwZW4g
dG8gcmV0dXJuIGEgZmlsZSBkZXNjcmlwdG9yIHdpbGwgYmUgYmV0dGVyIGZvciB1c2VycywgYnV0
DQo+Pj4+IHJhdGhlciB3aWxsIGJlIG1vcmUgY29uZnVzaW5nLg0KPj4+DQo+Pj4gVGhpcyBpcyBx
dWl0ZSBhIHN1YmplY3RpdmUgY29uY2x1c2lvbi4gSSBjb3VsZCB2ZXJ5IHdlbGwgYXJndWUgdGhh
dCBpdA0KPj4+IHdvdWxkIGJlIG11Y2ggYmV0dGVyIHRvIGhhdmUgYSBzaW5nbGUgc3lzY2FsbCB0
byBnZXQgYSBmZCBiYWNrZWQgbWVtb3J5DQo+Pj4gd2l0aCBzcGVkaWZpYyByZXF1aXJlbWVudHMg
KHNlYWxpbmcsIHVubWFwcGluZyBmcm9tIHRoZSBrZXJuZWwgYWRkcmVzcw0KPj4+IHNwYWNlKS4g
TmVpdGhlciBvZiB1cyB3b3VsZCBiZSBjbGVhcmx5IHJpZ2h0IG9yIHdyb25nLiBBIG1vcmUgaW1w
b3J0YW50DQo+Pj4gcG9pbnQgaXMgYSBmdXR1cmUgZXh0ZW5zaWJpbGl0eSBhbmQgdXNhYmlsaXR5
LCB0aG91Z2guIFNvIGxldCdzIGp1c3QNCj4+PiB0aGluayBvZiBmZXcgdXNlY2FzZXMgSSBoYXZl
IG91dGxpbmVkIGFib3ZlLiBJcyBpdCB1bnJlYWxpc3RpYyB0byBleHBlY3QNCj4+PiB0aGF0IHNl
Y3JldCBtZW1vcnkgc2hvdWxkIGJlIHNlYWxhYmxlPyBXaGF0IGFib3V0IGh1Z2V0bGI/IEJlY2F1
c2UgaWYNCj4+PiB0aGUgYW5zd2VyIGlzIG5vIHRoZW4gYSBuZXcgQVBJIGlzIGEgY2xlYXIgd2lu
IGFzIHRoZSBjb21iaW5hdGlvbiBvZg0KPj4+IGZsYWdzIHdvdWxkIG5ldmVyIHdvcmsgYW5kIHRo
ZW4gd2Ugd291bGQganVzdCBzdWZmZXIgZnJvbSB0aGUgc3lzY2FsbA0KPj4+IG11bHRpcGxleGlu
ZyB3aXRob3V0IG11Y2ggZ2Fpbi4gT24gdGhlIG90aGVyIGhhbmQgaWYgY29tYmluYXRpb24gb2Yg
dGhlDQo+Pj4gZnVuY3Rpb25hbGl0eSBpcyB0byBiZSBleHBlY3RlZCB0aGVuIHlvdSB3aWxsIGhh
dmUgdG8gamFtIGl0IGludG8NCj4+PiBtZW1mZF9jcmVhdGUgYW5kIGNvcHkgdGhlIGludGVyZmFj
ZSBsaWtlbHkgY2F1c2luZyBtb3JlIGNvbmZ1c2lvbi4gU2VlDQo+Pj4gd2hhdCBJIG1lYW4/DQo+
Pj4NCj4+PiBJIGJ5IG5vIG1lYW5zIGRvIG5vdCBpbnNpc3Qgb25lIHdheSBvciB0aGUgb3RoZXIg
YnV0IGZyb20gd2hhdCBJIGhhdmUNCj4+PiBzZWVuIHNvIGZhciBJIGhhdmUgYSBmZWVsaW5nIHRo
YXQgdGhlIGludGVyZmFjZSBoYXNuJ3QgYmVlbiB0aG91Z2h0DQo+Pj4gdGhyb3VnaCBlbm91Z2gu
IFN1cmUgeW91IGhhdmUgbGFuZGVkIHdpdGggZmQgYmFzZWQgYXBwcm9hY2ggYW5kIHRoYXQNCj4+
PiBzZWVtcyBmYWlyLiBCdXQgaG93IHRvIGdldCB0aGF0IGZkIHNlZW1zIHRvIHN0aWxsIGhhdmUg
c29tZSBnYXBzIElNSE8uDQo+Pj4NCj4+DQo+PiBJIGFncmVlIHdpdGggTWljaGFsLiBUaGlzIGhh
cyBiZWVuIHJhaXNlZCBieSBkaWZmZXJlbnQNCj4+IHBlb3BsZSBhbHJlYWR5LCBpbmNsdWRpbmcg
b24gTFdOIChodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODM1MzQyLykuDQo+Pg0KPj4gSSBjYW4g
Zm9sbG93IE1pa2UncyByZWFzb25pbmcgKG1hbiBwYWdlKSwgYW5kIEkgYW0gYWxzbyBmaW5lIGlm
IHRoZXJlIGlzDQo+PiBhIHZhbGlkIHJlYXNvbi4gSG93ZXZlciwgSU1ITyB0aGUgYmFzaWMgZGVz
Y3JpcHRpb24gc2VlbXMgdG8gbWF0Y2ggcXVpdGUgZ29vZDoNCj4+DQo+PiAgICAgICAgIG1lbWZk
X2NyZWF0ZSgpIGNyZWF0ZXMgYW4gYW5vbnltb3VzIGZpbGUgYW5kIHJldHVybnMgYSBmaWxlIGRl
c2NyaXB0b3IgdGhhdCByZWZlcnMgdG8gaXQuICBUaGUNCj4+ICAgICAgICAgZmlsZSBiZWhhdmVz
IGxpa2UgYSByZWd1bGFyIGZpbGUsIGFuZCBzbyBjYW4gYmUgbW9kaWZpZWQsIHRydW5jYXRlZCwg
bWVtb3J5LW1hcHBlZCwgYW5kIHNvIG9uLg0KPj4gICAgICAgICBIb3dldmVyLCAgdW5saWtlIGEg
cmVndWxhciBmaWxlLCBpdCBsaXZlcyBpbiBSQU0gYW5kIGhhcyBhIHZvbGF0aWxlIGJhY2tpbmcg
c3RvcmFnZS4gIE9uY2UgYWxsDQo+PiAgICAgICAgIHJlZmVyZW5jZXMgdG8gdGhlIGZpbGUgYXJl
IGRyb3BwZWQsIGl0IGlzIGF1dG9tYXRpY2FsbHkgcmVsZWFzZWQuICBBbm9ueW1vdXMgIG1lbW9y
eSAgaXMgIHVzZWQNCj4+ICAgICAgICAgZm9yICBhbGwgIGJhY2tpbmcgcGFnZXMgb2YgdGhlIGZp
bGUuICBUaGVyZWZvcmUsIGZpbGVzIGNyZWF0ZWQgYnkgbWVtZmRfY3JlYXRlKCkgaGF2ZSB0aGUg
c2FtZQ0KPj4gICAgICAgICBzZW1hbnRpY3MgYXMgb3RoZXIgYW5vbnltb3VzIG1lbW9yeSBhbGxv
Y2F0aW9ucyBzdWNoIGFzIHRob3NlIGFsbG9jYXRlZCB1c2luZyBtbWFwKDIpIHdpdGggdGhlDQo+
PiAgICAgICAgIE1BUF9BTk9OWU1PVVMgZmxhZy4NCj4gDQo+IEV2ZW4gZGVzcGl0ZSBteSBsYXpp
bmVzcyBhbmQgaHVnZSBhbW91bnQgb2YgY29weS1wYXN0ZSB5b3UgY2FuIHNwb3QgdGhlDQo+IGRp
ZmZlcmVuY2VzICh0aGlzIGlzIGEgdmVyeSBvbGQgdmVyc2lvbiwgdXBkYXRlIGlzIGR1ZSk6DQo+
IA0KPiAgICAgICAgIG1lbWZkX3NlY3JldCgpICBjcmVhdGVzIGFuIGFub255bW91cyBmaWxlIGFu
ZCByZXR1cm5zIGEgZmlsZSBkZXNjcmlwdG9yDQo+ICAgICAgICAgdGhhdCByZWZlcnMgdG8gaXQu
ICBUaGUgZmlsZSBjYW4gb25seSBiZSBtZW1vcnktbWFwcGVkOyB0aGUgIG1lbW9yeSAgaW4NCj4g
ICAgICAgICBzdWNoICBtYXBwaW5nICB3aWxsICBoYXZlICBzdHJvbmdlciBwcm90ZWN0aW9uIHRo
YW4gdXN1YWwgbWVtb3J5IG1hcHBlZA0KPiAgICAgICAgIGZpbGVzLCBhbmQgc28gaXQgY2FuIGJl
IHVzZWQgdG8gc3RvcmUgYXBwbGljYXRpb24gIHNlY3JldHMuICAgVW5saWtlICBhDQo+ICAgICAg
ICAgcmVndWxhciBmaWxlLCBhIGZpbGUgY3JlYXRlZCB3aXRoIG1lbWZkX3NlY3JldCgpIGxpdmVz
IGluIFJBTSBhbmQgaGFzIGENCj4gICAgICAgICB2b2xhdGlsZSBiYWNraW5nIHN0b3JhZ2UuICBP
bmNlIGFsbCByZWZlcmVuY2VzIHRvIHRoZSBmaWxlIGFyZSBkcm9wcGVkLA0KPiAgICAgICAgIGl0
ICBpcyAgYXV0b21hdGljYWxseSByZWxlYXNlZC4gIFRoZSBpbml0aWFsIHNpemUgb2YgdGhlIGZp
bGUgaXMgc2V0IHRvDQo+ICAgICAgICAgMC4gIEZvbGxvd2luZyB0aGUgY2FsbCwgdGhlIGZpbGUg
c2l6ZSBzaG91bGQgYmUgc2V0IHVzaW5nIGZ0cnVuY2F0ZSgyKS4NCj4gDQo+ICAgICAgICAgVGhl
IG1lbW9yeSBhcmVhcyBvYnRhaW5lZCB3aXRoIG1tYXAoMikgZnJvbSB0aGUgZmlsZSBkZXNjcmlw
dG9yIGFyZSBleOKAkA0KPiAgICAgICAgIGNsdXNpdmUgdG8gdGhlIG93bmluZyBjb250ZXh0LiAg
VGhlc2UgYXJlYXMgYXJlIHJlbW92ZWQgZnJvbSB0aGUga2VybmVsDQo+ICAgICAgICAgcGFnZSB0
YWJsZXMgYW5kIG9ubHkgdGhlIHBhZ2UgdGFibGUgb2YgdGhlIHByb2Nlc3MgaG9sZGluZyB0aGUg
ZmlsZSBkZeKAkA0KPiAgICAgICAgIHNjcmlwdG9yIG1hcHMgdGhlIGNvcnJlc3BvbmRpbmcgcGh5
c2ljYWwgbWVtb3J5Lg0KPiAgIA0KDQpTbyBsZXQncyB0YWxrIGFib3V0IHRoZSBtYWluIHVzZXIt
dmlzaWJsZSBkaWZmZXJlbmNlcyB0byBvdGhlciBtZW1mZCANCmZpbGVzIChlc3BlY2lhbGx5LCBv
dGhlciBwdXJlbHkgdmlydHVhbCBmaWxlcyBsaWtlIGh1Z2V0bGJmcykuIFdpdGggDQpzZWNyZXRt
ZW06DQoNCi0gRmlsZSBjb250ZW50IGNhbiBvbmx5IGJlIHJlYWQvd3JpdHRlbiB2aWEgbWVtb3J5
IG1hcHBpbmdzLg0KLSBGaWxlIGNvbnRlbnQgY2Fubm90IGJlIHN3YXBwZWQgb3V0Lg0KDQpJIHRo
aW5rIHRoZXJlIGFyZSBzdGlsbCB2YWxpZCB3YXlzIHRvIG1vZGlmeSBmaWxlIGNvbnRlbnQgdXNp
bmcgDQpzeXNjYWxsczogZS5nLiwgZmFsbG9jYXRlKFBVTkNIX0hPTEUpLiBUaGluZ3MgbGlrZSB0
cnVuY2F0ZSBhbHNvIHNlZW1zIA0KdG8gd29yayBqdXN0IGZpbmUuDQoNCldoYXQgZWxzZT8NCg0K
DQo+PiBBRkFJS1MsIHdlIHdvdWxkIG5lZWQgTUZEX1NFQ1JFVCBhbmQgZGlzYWxsb3cNCj4+IE1G
RF9BTExPV19TRUFMSU5HIGFuZCBNRkRfSFVHRVRMQi4NCj4gDQo+IFNvIGhlcmUgd2Ugc3RhcnQg
dG8gbXVsdGlwbGV4Lg0KDQpZZXMuIEFuZCBhcyBNaWNoYWwgc2FpZCwgbWF5YmUgd2UgY2FuIHN1
cHBvcnQgY29tYmluYXRpb25zIGluIHRoZSBmdXR1cmUuDQoNCj4gDQo+PiBJbiBhZGRpdGlvbiwg
d2UgY291bGQgYWRkIE1GRF9TRUNSRVRfTkVWRVJfTUFQLCB3aGljaCBjb3VsZCBkaXNhbGxvdyBh
bnkga2luZCBvZg0KPj4gdGVtcG9yYXJ5IG1hcHBpbmdzIChlb3IgbWlncmF0aW9uKS4gVEJDLg0K
PiANCj4gTmV2ZXIgbWFwIGlzIHRoZSBkZWZhdWx0LiBXaGVuIHdlJ2xsIG5lZWQgdG8gbWFwIHdl
J2xsIGFkZCBhbiBleHBsaWNpdCBmbGFnDQo+IGZvciBpdC4NCg0KTm8gc3Ryb25nIG9waW5pb24u
IChJJ2QgdHJ5IHRvIGh1cnQgdGhlIGtlcm5lbCBsZXNzIGFzIGRlZmF1bHQpDQoNCi0tIA0KVGhh
bmtzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGlt
bUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRp
bW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
