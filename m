Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8532019B8AC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 00:51:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67A3710FC453F;
	Wed,  1 Apr 2020 15:52:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 78BEF10FC453D
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 15:52:38 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 563302DC3330;
	Thu,  2 Apr 2020 09:51:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585781508;
	bh=FgXrMZd5jgFgYwvk1rKNQ23NCAQq9Sxrzfkt7yVUPjk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=QYGtk3AH0W2GW3xDqwILT4tWdRvwfukt/wtJfKxP3GeMIkwOcvxi4+bFTLeK7yG+2
	 QK6xQdg24HsMsrO96pzQzp7thT9OnH+T4/yu3go19x9bxZsYO5NlJv0CgTU9pVxohW
	 KQJ7ZDAHLWkxg0LJ1OqUPhVMKcRhKtqvaK49TPOa4J4swSpzhvwUlGWHpq8nMLY9Ly
	 Vu3DiOuAL2gubxA9ZbFj1JqQ4K9IlkSRcenYLBtTXq75bzFD851m4uhGrpdiUVXn/C
	 xYFvA/Rmp5IP5yiGKQYiTLklvSDRR5jvaZQIEyqlOE1mS5D0AvD28BhaUjAKTArCoN
	 xLLK+baQf/RyPZIGfFrlZcSyldovGznoCpUkK/BkN4eWPPuv3B4poiPOfQgWwQSfQg
	 sHkxPI/TVU4tfkhNhDZIguM19nktovwPOgel+sGFHwKc3FPYkVGpat3Dr1kExYM2vc
	 JJoWJhUH+zFmC6FT0WZMRa1HPdgoqc9nDa26VkS6riRQurzPFP7TrD10cEg99H5sMs
	 U2tRswqCKr3RZ+yNiF41Vk8wrSpOlJFKm/gwDUHJhB93pS3IQx3r0NyJOFU6P009EI
	 4HDOv8cMGWuycKRawzl/BzpGQYXFmELX9appWWgEVeqyT8RUVn5oEkkYgQzQdJlkgd
	 jakKdOir6MI9bh8Dme2Lw/KY=
Received: from Hawking (ntp.lan [10.0.1.1])
	(authenticated bits=0)
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 031Mpf9D088148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Apr 2020 09:51:41 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Dan Williams'" <dan.j.williams@intel.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-2-alastair@d-silva.org> <CAPcyv4hX9RTWKSLB8OcYY6MK-z5u5WWSaYSGa-8oqPbWU7st8w@mail.gmail.com>
In-Reply-To: <CAPcyv4hX9RTWKSLB8OcYY6MK-z5u5WWSaYSGa-8oqPbWU7st8w@mail.gmail.com>
Subject: RE: [PATCH v4 01/25] powerpc/powernv: Add OPAL calls for LPC memory alloc/release
Date: Thu, 2 Apr 2020 09:51:40 +1100
Message-ID: <2d6d01d60878$1c8c68f0$55a53ad0$@d-silva.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AQJ5L4Hn/mp5p0p1jYAFWLJ+xmWSbgKnRjTFARH8J02nAMbrEA==
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 02 Apr 2020 09:51:42 +1100 (AEDT)
Message-ID-Hash: 62IPH4HXTKP7WMM47TPBMKROERX2WJ2V
X-Message-ID-Hash: 62IPH4HXTKP7WMM47TPBMKROERX2WJ2V
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socionex
 t.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'linuxppc-dev' <linuxppc-dev@lists.ozlabs.org>, 'linux-nvdimm' <linux-nvdimm@lists.01.org>, 'Linux MM' <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/62IPH4HXTKP7WMM47TPBMKROERX2WJ2V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxIEFwcmlsIDIwMjAgNzo0
OCBQTQ0KPiBUbzogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IENj
OiBBbmVlc2ggS3VtYXIgSyAuIFYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPjsgT2xpdmVy
IE8nSGFsbG9yYW4NCj4gPG9vaGFsbEBnbWFpbC5jb20+OyBCZW5qYW1pbiBIZXJyZW5zY2htaWR0
DQo+IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+OyBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNh
bWJhLm9yZz47IE1pY2hhZWwNCj4gRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT47IEZyZWRl
cmljIEJhcnJhdCA8ZmJhcnJhdEBsaW51eC5pYm0uY29tPjsNCj4gQW5kcmV3IERvbm5lbGxhbiA8
YWpkQGxpbnV4LmlibS5jb20+OyBBcm5kIEJlcmdtYW5uDQo+IDxhcm5kQGFybmRiLmRlPjsgR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQo+IFZpc2hhbCBW
ZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPjsgRGF2ZSBKaWFuZw0KPiA8ZGF2ZS5qaWFu
Z0BpbnRlbC5jb20+OyBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+OyBBbmRyZXcgTW9y
dG9uDQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFi
DQo+IDxtY2hlaGFiK3NhbXN1bmdAa2VybmVsLm9yZz47IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1A
ZGF2ZW1sb2Z0Lm5ldD47DQo+IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBBbnRvbiBC
bGFuY2hhcmQgPGFudG9uQG96bGFicy5vcmc+Ow0KPiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnpr
QGtlcm5lbC5vcmc+OyBNYWhlc2ggU2FsZ2Fvbmthcg0KPiA8bWFoZXNoQGxpbnV4LnZuZXQuaWJt
LmNvbT47IE1hZGhhdmFuIFNyaW5pdmFzYW4NCj4gPG1hZGR5QGxpbnV4LnZuZXQuaWJtLmNvbT47
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAa2FvZC5vcmc+OyBBbmp1IFQNCj4gU3VkaGFrYXIgPGFu
anVAbGludXgudm5ldC5pYm0uY29tPjsgSGFyaSBCYXRoaW5pDQo+IDxoYmF0aGluaUBsaW51eC5p
Ym0uY29tPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBHcmVnDQo+IEt1
cnogPGdyb3VnQGthb2Qub3JnPjsgTmljaG9sYXMgUGlnZ2luIDxucGlnZ2luQGdtYWlsLmNvbT47
IE1hc2FoaXJvDQo+IFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+OyBBbGV4
ZXkgS2FyZGFzaGV2c2tpeQ0KPiA8YWlrQG96bGFicy5ydT47IExpbnV4IEtlcm5lbCBNYWlsaW5n
IExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBsaW51eHBwYy1kZXYgPGxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnPjsgbGludXgtbnZkaW1tIDxsaW51eC0NCj4gbnZk
aW1tQGxpc3RzLjAxLm9yZz47IExpbnV4IE1NIDxsaW51eC1tbUBrdmFjay5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjQgMDEvMjVdIHBvd2VycGMvcG93ZXJudjogQWRkIE9QQUwgY2FsbHMg
Zm9yIExQQw0KPiBtZW1vcnkgYWxsb2MvcmVsZWFzZQ0KPiANCj4gT24gU3VuLCBNYXIgMjksIDIw
MjAgYXQgMTA6MjMgUE0gQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+
IHdyb3RlOg0KPiA+DQo+ID4gQWRkIE9QQUwgY2FsbHMgZm9yIExQQyBtZW1vcnkgYWxsb2MvcmVs
ZWFzZQ0KPiA+DQo+IA0KPiBUaGlzIHNlZW1zIHRvIGJlIHJlZmVyZW5jaW5nIGFuIGV4aXN0aW5n
IGFwaSBkZWZpbml0aW9uLCBjYW4geW91IGluY2x1ZGUgYQ0KPiBwb2ludGVyIHRvIHRoZSBzcGVj
IGluIGNhc2Ugc29tZW9uZSB3YW50ZWQgdG8gdW5kZXJzdGFuZCB3aGF0IHRoZXNlDQo+IHJvdXRp
bmVzIGRvPyBJIHN1c3BlY3QgdGhpcyBpcyBub3QgYWxsb2NhdGluZyBtZW1vcnkgaW4gdGhlIHRy
YWRpdGlvbmFsIHNlbnNlIGFzDQo+IG11Y2ggYXMgaXQncyBhbGxvY2F0aW5nIHBoeXNpY2FsIGFk
ZHJlc3Mgc3BhY2UgZm9yIGEgZGV2aWNlIHRvIGJlIG1hcHBlZD8NCj4gDQoNClRoZXNlIEFQSSBj
YWxscyB3ZXJlIGludHJvZHVjZWQgaW4gdGhlIGZvbGxvd2luZyBza2lib290IGNvbW1pdDoNCmh0
dHBzOi8vZ2l0aHViLmNvbS9vcGVuLXBvd2VyL3NraWJvb3QvY29tbWl0LzFhNTQ4ODU3Y2UxZjAy
ZjQzNTg1YjMyNmE4OTFlZWQxOGE3YjQzYjMNCg0KSSdsbCBhZGQgaXQgdG8gdGhlIGRlc2NyaXB0
aW9uLg0KDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWly
QGQtc2lsdmEub3JnPg0KPiA+IEFja2VkLWJ5OiBBbmRyZXcgRG9ubmVsbGFuIDxhamRAbGludXgu
aWJtLmNvbT4NCj4gPiBBY2tlZC1ieTogRnJlZGVyaWMgQmFycmF0IDxmYmFycmF0QGxpbnV4Lmli
bS5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLWFwaS5o
ICAgICAgICB8IDIgKysNCj4gPiAgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL29wYWwuaCAgICAg
ICAgICAgIHwgMiArKw0KPiA+ICBhcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybnYvb3BhbC1j
YWxsLmMgfCAyICsrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL29wYWwtYXBpLmgNCj4g
PiBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLWFwaS5oDQo+ID4gaW5kZXggYzFmMjVh
NzYwZWIxLi45Mjk4ZTYwMzAwMWIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL29wYWwtYXBpLmgNCj4gPiArKysgYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vb3Bh
bC1hcGkuaA0KPiA+IEBAIC0yMDgsNiArMjA4LDggQEANCj4gPiAgI2RlZmluZSBPUEFMX0hBTkRM
RV9ITUkyICAgICAgICAgICAgICAgICAgICAgICAxNjYNCj4gPiAgI2RlZmluZSAgICAgICAgT1BB
TF9OWF9DT1BST0NfSU5JVCAgICAgICAgICAgICAgICAgICAgIDE2Nw0KPiA+ICAjZGVmaW5lIE9Q
QUxfWElWRV9HRVRfVlBfU1RBVEUgICAgICAgICAgICAgICAgIDE3MA0KPiA+ICsjZGVmaW5lIE9Q
QUxfTlBVX01FTV9BTExPQyAgICAgICAgICAgICAgICAgICAgIDE3MQ0KPiA+ICsjZGVmaW5lIE9Q
QUxfTlBVX01FTV9SRUxFQVNFICAgICAgICAgICAgICAgICAgIDE3Mg0KPiA+ICAjZGVmaW5lIE9Q
QUxfTVBJUExfVVBEQVRFICAgICAgICAgICAgICAgICAgICAgIDE3Mw0KPiA+ICAjZGVmaW5lIE9Q
QUxfTVBJUExfUkVHSVNURVJfVEFHICAgICAgICAgICAgICAgICAgICAgICAgMTc0DQo+ID4gICNk
ZWZpbmUgT1BBTF9NUElQTF9RVUVSWV9UQUcgICAgICAgICAgICAgICAgICAgMTc1DQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLmgNCj4gPiBiL2FyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9vcGFsLmggaW5kZXggOTk4NmFjMzRiOGUyLi4zMDFmZWE0NmM3Y2EN
Cj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vb3BhbC5oDQo+
ID4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL29wYWwuaA0KPiA+IEBAIC0zOSw2ICsz
OSw4IEBAIGludDY0X3Qgb3BhbF9ucHVfc3BhX2NsZWFyX2NhY2hlKHVpbnQ2NF90IHBoYl9pZCwN
Cj4gdWludDMyX3QgYmRmbiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IFBFX2hhbmRsZSk7ICBpbnQ2NF90DQo+ID4gb3BhbF9ucHVfdGxfc2V0KHVpbnQ2NF90
IHBoYl9pZCwgdWludDMyX3QgYmRmbiwgbG9uZyBjYXAsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgcmF0ZV9waHlzLCB1aW50MzJfdCBzaXplKTsNCj4gPiAraW50NjRfdCBv
cGFsX25wdV9tZW1fYWxsb2ModTY0IHBoYl9pZCwgdTMyIGJkZm4sIHU2NCBzaXplLCBfX2JlNjQN
Cj4gPiArKmJhcik7IGludDY0X3Qgb3BhbF9ucHVfbWVtX3JlbGVhc2UodTY0IHBoYl9pZCwgdTMy
IGJkZm4pOw0KPiA+DQo+ID4gIGludDY0X3Qgb3BhbF9jb25zb2xlX3dyaXRlKGludDY0X3QgdGVy
bV9udW1iZXIsIF9fYmU2NCAqbGVuZ3RoLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IHVpbnQ4X3QgKmJ1ZmZlcik7IGRpZmYgLS1naXQNCj4gPiBhL2FyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvcG93ZXJudi9vcGFsLWNhbGwuYw0KPiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jt
cy9wb3dlcm52L29wYWwtY2FsbC5jDQo+ID4gaW5kZXggNWNkMGY1MmQyNThmLi5mMjZlNThiNzJj
MDQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwt
Y2FsbC5jDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29wYWwtY2Fs
bC5jDQo+ID4gQEAgLTI4Nyw2ICsyODcsOCBAQCBPUEFMX0NBTEwob3BhbF9wY2lfc2V0X3BiY3Ff
dHVubmVsX2JhciwNCj4gT1BBTF9QQ0lfU0VUX1BCQ1FfVFVOTkVMX0JBUik7DQo+ID4gIE9QQUxf
Q0FMTChvcGFsX3NlbnNvcl9yZWFkX3U2NCwNCj4gT1BBTF9TRU5TT1JfUkVBRF9VNjQpOw0KPiA+
ICBPUEFMX0NBTEwob3BhbF9zZW5zb3JfZ3JvdXBfZW5hYmxlLA0KPiBPUEFMX1NFTlNPUl9HUk9V
UF9FTkFCTEUpOw0KPiA+ICBPUEFMX0NBTEwob3BhbF9ueF9jb3Byb2NfaW5pdCwgICAgICAgICAg
ICAgICAgIE9QQUxfTlhfQ09QUk9DX0lOSVQpOw0KPiA+ICtPUEFMX0NBTEwob3BhbF9ucHVfbWVt
X2FsbG9jLCAgICAgICAgICAgICAgICAgIE9QQUxfTlBVX01FTV9BTExPQyk7DQo+ID4gK09QQUxf
Q0FMTChvcGFsX25wdV9tZW1fcmVsZWFzZSwNCj4gT1BBTF9OUFVfTUVNX1JFTEVBU0UpOw0KPiA+
ICBPUEFMX0NBTEwob3BhbF9tcGlwbF91cGRhdGUsICAgICAgICAgICAgICAgICAgIE9QQUxfTVBJ
UExfVVBEQVRFKTsNCj4gPiAgT1BBTF9DQUxMKG9wYWxfbXBpcGxfcmVnaXN0ZXJfdGFnLA0KPiBP
UEFMX01QSVBMX1JFR0lTVEVSX1RBRyk7DQo+ID4gIE9QQUxfQ0FMTChvcGFsX21waXBsX3F1ZXJ5
X3RhZywNCj4gT1BBTF9NUElQTF9RVUVSWV9UQUcpOw0KPiA+IC0tDQo+ID4gMi4yNC4xDQo+ID4N
Cj4gDQo+IA0KPiAtLQ0KPiBUaGlzIGVtYWlsIGhhcyBiZWVuIGNoZWNrZWQgZm9yIHZpcnVzZXMg
YnkgQVZHLg0KPiBodHRwczovL3d3dy5hdmcuY29tDQoNCg0KLS0gDQpBbGFzdGFpciBEJ1NpbHZh
ICAgICAgICAgICBtb2I6IDA0MjMgNzYyIDgxOQ0Kc2t5cGU6IGFsYXN0YWlyX2RzaWx2YSAgICAg
bXNuOiBhbGFzdGFpckBkLXNpbHZhLm9yZw0KYmxvZzogaHR0cDovL2FsYXN0YWlyLmQtc2lsdmEu
b3JnICAgIFR3aXR0ZXI6IEBFdmlsRGVlY2UNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZk
aW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52
ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
