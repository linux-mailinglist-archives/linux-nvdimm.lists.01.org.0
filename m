Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C36AB16FA23
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 10:01:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DBE4810FC360C;
	Wed, 26 Feb 2020 01:02:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.32.98.231; helo=19.mo3.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from 19.mo3.mail-out.ovh.net (19.mo3.mail-out.ovh.net [178.32.98.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2DA1110FC360A
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 01:02:45 -0800 (PST)
Received: from player779.ha.ovh.net (unknown [10.108.35.210])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 19D98244E8B
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 10:01:50 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
	(Authenticated sender: groug@kaod.org)
	by player779.ha.ovh.net (Postfix) with ESMTPSA id 0A2DBFBF0C51;
	Wed, 26 Feb 2020 09:01:06 +0000 (UTC)
Date: Wed, 26 Feb 2020 10:01:02 +0100
From: Greg Kurz <groug@kaod.org>
To: "Alastair D'Silva" <alastair@d-silva.org>
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Message-ID: <20200226100102.0aab7dda@bahia.home>
In-Reply-To: <4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	<20200221032720.33893-5-alastair@au1.ibm.com>
	<20200226081447.GH4937@MiWiFi-R3L-srv>
	<4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Ovh-Tracer-Id: 3746431942902978839
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleefgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhvughimhhmsehlihhsthhsrddtuddrohhrgh
Message-ID-Hash: 3JLBHC5YRGIDKXSWDRR6PXLR5UWZMFPN
X-Message-ID-Hash: 3JLBHC5YRGIDKXSWDRR6PXLR5UWZMFPN
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: 'Baoquan He' <bhe@redhat.com>, 'Alastair D'Silva' <alastair@au1.ibm.com>, "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, "'Frederic Barrat'  <fbarrat@linux.ibm.com>,  'Andrew Donnellan'  <ajd@linux.ibm.com>, 'Arnd Bergmann'" <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, "'Andrew Morton'  <akpm@linux-foundation.org>,  'Mauro Carvalho Chehab' " <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?UTF-8?B?J0PDqWRyaWM=?= Le Goater' <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, "'Hari Bathini'  <hbathini@linux.ibm.com>,  'Thomas Gleixner' " <tglx@linutronix.de>, 'Nicholas Piggin' <npig
 gin@gmail.com>, "'Masahiro Yamada'  <yamada.masahiro@socionext.com>,  'Alexey Kardashevskiy' " <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3JLBHC5YRGIDKXSWDRR6PXLR5UWZMFPN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyNiBGZWIgMjAyMCAxOToyNjozNCArMTEwMA0KIkFsYXN0YWlyIEQnU2lsdmEiIDxh
bGFzdGFpckBkLXNpbHZhLm9yZz4gd3JvdGU6DQoNCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0KPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgMjYgRmVicnVhcnkgMjAyMCA3OjE1IFBNDQo+ID4gVG86IEFsYXN0YWlyIEQnU2ls
dmEgPGFsYXN0YWlyQGF1MS5pYm0uY29tPg0KPiA+IENjOiBhbGFzdGFpckBkLXNpbHZhLm9yZzsg
QW5lZXNoIEt1bWFyIEsgLiBWDQo+ID4gPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPjsgT2xp
dmVyIE8nSGFsbG9yYW4gPG9vaGFsbEBnbWFpbC5jb20+Ow0KPiA+IEJlbmphbWluIEhlcnJlbnNj
aG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz47IFBhdWwgTWFja2VycmFzDQo+ID4gPHBh
dWx1c0BzYW1iYS5vcmc+OyBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+OyBG
cmVkZXJpYw0KPiA+IEJhcnJhdCA8ZmJhcnJhdEBsaW51eC5pYm0uY29tPjsgQW5kcmV3IERvbm5l
bGxhbiA8YWpkQGxpbnV4LmlibS5jb20+Ow0KPiA+IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIu
ZGU+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+
OyBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT47DQo+ID4gVmlzaGFsIFZl
cm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBEYXZlIEppYW5nDQo+ID4gPGRhdmUuamlh
bmdAaW50ZWwuY29tPjsgSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPjsgQW5kcmV3IE1v
cnRvbg0KPiA+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWF1cm8gQ2FydmFsaG8gQ2hl
aGFiDQo+ID4gPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3JnPjsgRGF2aWQgUy4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gPiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
QW50b24gQmxhbmNoYXJkIDxhbnRvbkBvemxhYnMub3JnPjsNCj4gPiBLcnp5c3p0b2YgS296bG93
c2tpIDxrcnprQGtlcm5lbC5vcmc+OyBNYWhlc2ggU2FsZ2Fvbmthcg0KPiA+IDxtYWhlc2hAbGlu
dXgudm5ldC5pYm0uY29tPjsgTWFkaGF2YW4gU3Jpbml2YXNhbg0KPiA+IDxtYWRkeUBsaW51eC52
bmV0LmlibS5jb20+OyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3JnPjsgQW5qdSBUDQo+
ID4gU3VkaGFrYXIgPGFuanVAbGludXgudm5ldC5pYm0uY29tPjsgSGFyaSBCYXRoaW5pDQo+ID4g
PGhiYXRoaW5pQGxpbnV4LmlibS5jb20+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT47IEdyZWcNCj4gPiBLdXJ6IDxncm91Z0BrYW9kLm9yZz47IE5pY2hvbGFzIFBpZ2dpbiA8
bnBpZ2dpbkBnbWFpbC5jb20+OyBNYXNhaGlybw0KPiA+IFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJv
QHNvY2lvbmV4dC5jb20+OyBBbGV4ZXkgS2FyZGFzaGV2c2tpeQ0KPiA+IDxhaWtAb3psYWJzLnJ1
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+ID4gZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmc7IGxpbnV4LW1tQGt2YWNrLm9y
Zw0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDQvMjddIG9jeGw6IFJlbW92ZSB1bm5lY2Vz
c2FyeSBleHRlcm5zDQo+ID4gDQo+ID4gT24gMDIvMjEvMjAgYXQgMDI6MjZwbSwgQWxhc3RhaXIg
RCdTaWx2YSB3cm90ZToNCj4gPiA+IEZyb206IEFsYXN0YWlyIEQnU2lsdmEgPGFsYXN0YWlyQGQt
c2lsdmEub3JnPg0KPiA+ID4NCj4gPiA+IEZ1bmN0aW9uIGRlY2xhcmF0aW9ucyBkb24ndCBuZWVk
IGV4dGVybnMsIHJlbW92ZSB0aGUgZXhpc3Rpbmcgb25lcyBzbw0KPiA+ID4gdGhleSBhcmUgY29u
c2lzdGVudCB3aXRoIG5ld2VyIGNvZGUNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbGFz
dGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gIGFy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oIHwgMzIgKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0NCj4gPiA+ICBpbmNsdWRlL21pc2Mvb2N4bC5oICAgICAgICAgICAgICAgICB8
ICA2ICsrKy0tLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMjAg
ZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9wbnYtb2N4bC5oDQo+ID4gPiBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYt
b2N4bC5oDQo+ID4gPiBpbmRleCAwYjJhNjcwN2U1NTUuLmIyM2M5OWJjMGM4NCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+ID4gPiArKysg
Yi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiA+ID4gQEAgLTksMjkgKzks
MjcgQEANCj4gPiA+ICAjZGVmaW5lIFBOVl9PQ1hMX1RMX0JJVFNfUEVSX1JBVEUgICAgICAgNA0K
PiA+ID4gICNkZWZpbmUgUE5WX09DWExfVExfUkFURV9CVUZfU0laRQ0KPiA+ICgoUE5WX09DWExf
VExfTUFYX1RFTVBMQVRFKzEpICogUE5WX09DWExfVExfQklUU19QRVJfUkFURSAvIDgpDQo+ID4g
Pg0KPiA+ID4gLWV4dGVybiBpbnQgcG52X29jeGxfZ2V0X2FjdGFnKHN0cnVjdCBwY2lfZGV2ICpk
ZXYsIHUxNiAqYmFzZSwgdTE2DQo+ID4gKmVuYWJsZWQsDQo+ID4gPiAtCQkJdTE2ICpzdXBwb3J0
ZWQpOw0KPiA+IA0KPiA+IEl0IHdvcmtzIHcgb3Igdy9vIGV4dGVybiB3aGVuIGRlY2xhcmUgZnVu
Y3Rpb25zLiBTZWFyY2hpbmcgJ2V4dGVybicNCj4gPiB1bmRlciBpbmNsdWRlIGNhbiBmaW5kIHNv
IG1hbnkgZnVuY3Rpb25zIHdpdGggJ2V4dGVybicgYWRkaW5nLiBEbyB3ZSBoYXZlDQo+IGENCj4g
PiBleHBsaWNpdCBzdGFuZGFyZCBpZiB3ZSBzaG91bGQgYWRkIG9yIHJlbW92ZSAnZXh0ZXInIGlu
IGZ1bmN0aW9uDQo+IGRlY2xhcmF0aW9uPw0KPiA+IA0KPiA+IEkgaGF2ZSBubyBvYmplY3Rpb24g
dG8gdGhpcyBwYXRjaCwganVzdCB3YW50IHRvIG1ha2UgY2xlYXIgc28gdGhhdCBJIGNhbg0KPiBo
YW5kbGUNCj4gPiBpdCB3L28gY29uZnVzaW9uLg0KPiA+IA0KPiA+IFRoYW5rcw0KPiA+IEJhb3F1
YW4NCj4gPiANCj4gDQo+IEZvciB0aGUgT3BlbkNBUEkgZHJpdmVyLCB3ZSBoYXZlIHNldHRsZWQg
b24gbm90IGhhdmluZyAnZXh0ZXJuJyBvbg0KPiBmdW5jdGlvbnMuDQo+IA0KPiBJIGRvbid0IHRo
aW5rIEkndmUgc2VlbiBhIHN0YW5kYXJkIHRoYXQgc3VwcG9ydHMgb3IgcmVmdXRlcyB0aGlzLCBi
dXQgaXQNCj4gZG9lcyBub3QgdmFsdWUgYWRkLg0KPiANCg0KRldJVyB0aGlzIGlzIGEgd2Fybmlu
ZyBjb25kaXRpb24gZm9yIGNoZWNrcGF0Y2g6DQoNCiQgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwg
LS1zdHJpY3QgLWYgaW5jbHVkZS9taXNjL29jeGwuaA0KDQpbLi4uXQ0KDQpDSEVDSzogZXh0ZXJu
IHByb3RvdHlwZXMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmggZmlsZXMNCiMxNzY6IEZJTEU6IGlu
Y2x1ZGUvbWlzYy9vY3hsLmg6MTc2Og0KK2V4dGVybiBpbnQgb2N4bF9hZnVfaXJxX2FsbG9jKHN0
cnVjdCBvY3hsX2NvbnRleHQgKmN0eCwgaW50ICppcnFfaWQpOw0KDQpbLi4uXQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
