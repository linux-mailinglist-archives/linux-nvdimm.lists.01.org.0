Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DEC170110
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 15:21:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFC1E10FC3615;
	Wed, 26 Feb 2020 06:22:32 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=46.105.50.107; helo=6.mo69.mail-out.ovh.net; envelope-from=groug@kaod.org; receiver=<UNKNOWN> 
Received: from 6.mo69.mail-out.ovh.net (6.mo69.mail-out.ovh.net [46.105.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AA90A10FC3614
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 06:22:30 -0800 (PST)
Received: from player157.ha.ovh.net (unknown [10.110.171.5])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2C84E862DC
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 15:21:35 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
	(Authenticated sender: groug@kaod.org)
	by player157.ha.ovh.net (Postfix) with ESMTPSA id 898E0FCD5725;
	Wed, 26 Feb 2020 14:20:52 +0000 (UTC)
Date: Wed, 26 Feb 2020 15:20:50 +0100
From: Greg Kurz <groug@kaod.org>
To: 'Baoquan He' <bhe@redhat.com>
Subject: Re: [PATCH v3 04/27] ocxl: Remove unnecessary externs
Message-ID: <20200226152050.45547219@bahia.home>
In-Reply-To: <20200226141523.GI4937@MiWiFi-R3L-srv>
References: <20200221032720.33893-1-alastair@au1.ibm.com>
	<20200221032720.33893-5-alastair@au1.ibm.com>
	<20200226081447.GH4937@MiWiFi-R3L-srv>
	<4d49801d5ec7e$7a3e8610$6ebb9230$@d-silva.org>
	<20200226100102.0aab7dda@bahia.home>
	<20200226141523.GI4937@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Ovh-Tracer-Id: 9146529370105485748
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrleeggdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqheftdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvhguihhmmheslhhishhtshdrtddurdhorhhg
Message-ID-Hash: XKPPNUN3CLV7CFGUT5PO4YU7S4KDMQPC
X-Message-ID-Hash: XKPPNUN3CLV7CFGUT5PO4YU7S4KDMQPC
X-MailFrom: groug@kaod.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alastair D'Silva <alastair@d-silva.org>, 'Alastair D'Silva' <alastair@au1.ibm.com>, "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?UTF-8?B?J0PDqWRyaWM=?= Le Goater' <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Nicholas Piggin' <npiggin@g
 mail.com>, 'Masahiro Yamada' <yamada.masahiro@socionext.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XKPPNUN3CLV7CFGUT5PO4YU7S4KDMQPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCAyNiBGZWIgMjAyMCAyMjoxNToyMyArMDgwMA0KJ0Jhb3F1YW4gSGUnIDxiaGVAcmVk
aGF0LmNvbT4gd3JvdGU6DQoNCj4gT24gMDIvMjYvMjAgYXQgMTA6MDFhbSwgR3JlZyBLdXJ6IHdy
b3RlOg0KPiA+IE9uIFdlZCwgMjYgRmViIDIwMjAgMTk6MjY6MzQgKzExMDANCj4gPiAiQWxhc3Rh
aXIgRCdTaWx2YSIgPGFsYXN0YWlyQGQtc2lsdmEub3JnPiB3cm90ZToNCj4gPiANCj4gPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogQmFvcXVhbiBIZSA8Ymhl
QHJlZGhhdC5jb20+DQo+ID4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgMjYgRmVicnVhcnkgMjAyMCA3
OjE1IFBNDQo+ID4gPiA+IFRvOiBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBhdTEuaWJtLmNv
bT4NCj4gPiA+ID4gQ2M6IGFsYXN0YWlyQGQtc2lsdmEub3JnOyBBbmVlc2ggS3VtYXIgSyAuIFYN
Cj4gPiA+ID4gPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPjsgT2xpdmVyIE8nSGFsbG9yYW4g
PG9vaGFsbEBnbWFpbC5jb20+Ow0KPiA+ID4gPiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5o
QGtlcm5lbC5jcmFzaGluZy5vcmc+OyBQYXVsIE1hY2tlcnJhcw0KPiA+ID4gPiA8cGF1bHVzQHNh
bWJhLm9yZz47IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT47IEZyZWRlcmlj
DQo+ID4gPiA+IEJhcnJhdCA8ZmJhcnJhdEBsaW51eC5pYm0uY29tPjsgQW5kcmV3IERvbm5lbGxh
biA8YWpkQGxpbnV4LmlibS5jb20+Ow0KPiA+ID4gPiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRi
LmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA+IDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz47IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPjsNCj4gPiA+ID4g
VmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+OyBEYXZlIEppYW5nDQo+ID4g
PiA+IDxkYXZlLmppYW5nQGludGVsLmNvbT47IElyYSBXZWlueSA8aXJhLndlaW55QGludGVsLmNv
bT47IEFuZHJldyBNb3J0b24NCj4gPiA+ID4gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBN
YXVybyBDYXJ2YWxobyBDaGVoYWINCj4gPiA+ID4gPG1jaGVoYWIrc2Ftc3VuZ0BrZXJuZWwub3Jn
PjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsNCj4gPiA+ID4gUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEFudG9uIEJsYW5jaGFyZCA8YW50b25Ab3psYWJzLm9y
Zz47DQo+ID4gPiA+IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz47IE1haGVz
aCBTYWxnYW9ua2FyDQo+ID4gPiA+IDxtYWhlc2hAbGludXgudm5ldC5pYm0uY29tPjsgTWFkaGF2
YW4gU3Jpbml2YXNhbg0KPiA+ID4gPiA8bWFkZHlAbGludXgudm5ldC5pYm0uY29tPjsgQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0BrYW9kLm9yZz47IEFuanUgVA0KPiA+ID4gPiBTdWRoYWthciA8YW5q
dUBsaW51eC52bmV0LmlibS5jb20+OyBIYXJpIEJhdGhpbmkNCj4gPiA+ID4gPGhiYXRoaW5pQGxp
bnV4LmlibS5jb20+OyBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEdyZWcN
Cj4gPiA+ID4gS3VyeiA8Z3JvdWdAa2FvZC5vcmc+OyBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5A
Z21haWwuY29tPjsgTWFzYWhpcm8NCj4gPiA+ID4gWWFtYWRhIDx5YW1hZGEubWFzYWhpcm9Ac29j
aW9uZXh0LmNvbT47IEFsZXhleSBLYXJkYXNoZXZza2l5DQo+ID4gPiA+IDxhaWtAb3psYWJzLnJ1
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtDQo+ID4gPiA+IGRldkBs
aXN0cy5vemxhYnMub3JnOyBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnOyBsaW51eC1tbUBrdmFj
ay5vcmcNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwNC8yN10gb2N4bDogUmVtb3Zl
IHVubmVjZXNzYXJ5IGV4dGVybnMNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIDAyLzIxLzIwIGF0IDAy
OjI2cG0sIEFsYXN0YWlyIEQnU2lsdmEgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogQWxhc3RhaXIg
RCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBGdW5j
dGlvbiBkZWNsYXJhdGlvbnMgZG9uJ3QgbmVlZCBleHRlcm5zLCByZW1vdmUgdGhlIGV4aXN0aW5n
IG9uZXMgc28NCj4gPiA+ID4gPiB0aGV5IGFyZSBjb25zaXN0ZW50IHdpdGggbmV3ZXIgY29kZQ0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3RhaXIgRCdTaWx2YSA8YWxh
c3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGFyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oIHwgMzIgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0NCj4gPiA+ID4gPiAgaW5jbHVkZS9taXNjL29jeGwuaCAgICAgICAgICAgICAgICAgfCAgNiAr
KystLS0NCj4gPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAyMCBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiA+ID4gPiA+IGIvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL3Budi1vY3hsLmgNCj4gPiA+ID4gPiBpbmRleCAwYjJhNjcwN2U1NTUuLmIyM2M5OWJj
MGM4NCAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52
LW9jeGwuaA0KPiA+ID4gPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4
bC5oDQo+ID4gPiA+ID4gQEAgLTksMjkgKzksMjcgQEANCj4gPiA+ID4gPiAgI2RlZmluZSBQTlZf
T0NYTF9UTF9CSVRTX1BFUl9SQVRFICAgICAgIDQNCj4gPiA+ID4gPiAgI2RlZmluZSBQTlZfT0NY
TF9UTF9SQVRFX0JVRl9TSVpFDQo+ID4gPiA+ICgoUE5WX09DWExfVExfTUFYX1RFTVBMQVRFKzEp
ICogUE5WX09DWExfVExfQklUU19QRVJfUkFURSAvIDgpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAt
ZXh0ZXJuIGludCBwbnZfb2N4bF9nZXRfYWN0YWcoc3RydWN0IHBjaV9kZXYgKmRldiwgdTE2ICpi
YXNlLCB1MTYNCj4gPiA+ID4gKmVuYWJsZWQsDQo+ID4gPiA+ID4gLQkJCXUxNiAqc3VwcG9ydGVk
KTsNCj4gPiA+ID4gDQo+ID4gPiA+IEl0IHdvcmtzIHcgb3Igdy9vIGV4dGVybiB3aGVuIGRlY2xh
cmUgZnVuY3Rpb25zLiBTZWFyY2hpbmcgJ2V4dGVybicNCj4gPiA+ID4gdW5kZXIgaW5jbHVkZSBj
YW4gZmluZCBzbyBtYW55IGZ1bmN0aW9ucyB3aXRoICdleHRlcm4nIGFkZGluZy4gRG8gd2UgaGF2
ZQ0KPiA+ID4gYQ0KPiA+ID4gPiBleHBsaWNpdCBzdGFuZGFyZCBpZiB3ZSBzaG91bGQgYWRkIG9y
IHJlbW92ZSAnZXh0ZXInIGluIGZ1bmN0aW9uDQo+ID4gPiBkZWNsYXJhdGlvbj8NCj4gPiA+ID4g
DQo+ID4gPiA+IEkgaGF2ZSBubyBvYmplY3Rpb24gdG8gdGhpcyBwYXRjaCwganVzdCB3YW50IHRv
IG1ha2UgY2xlYXIgc28gdGhhdCBJIGNhbg0KPiA+ID4gaGFuZGxlDQo+ID4gPiA+IGl0IHcvbyBj
b25mdXNpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MNCj4gPiA+ID4gQmFvcXVhbg0KPiA+
ID4gPiANCj4gPiA+IA0KPiA+ID4gRm9yIHRoZSBPcGVuQ0FQSSBkcml2ZXIsIHdlIGhhdmUgc2V0
dGxlZCBvbiBub3QgaGF2aW5nICdleHRlcm4nIG9uDQo+ID4gPiBmdW5jdGlvbnMuDQo+ID4gPiAN
Cj4gPiA+IEkgZG9uJ3QgdGhpbmsgSSd2ZSBzZWVuIGEgc3RhbmRhcmQgdGhhdCBzdXBwb3J0cyBv
ciByZWZ1dGVzIHRoaXMsIGJ1dCBpdA0KPiA+ID4gZG9lcyBub3QgdmFsdWUgYWRkLg0KPiA+ID4g
DQo+ID4gDQo+ID4gRldJVyB0aGlzIGlzIGEgd2FybmluZyBjb25kaXRpb24gZm9yIGNoZWNrcGF0
Y2g6DQo+ID4gDQo+ID4gJCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLXN0cmljdCAtZiBpbmNs
dWRlL21pc2Mvb2N4bC5oDQo+IA0KPiBHb29kIHRvIGtub3csIHRoYW5rcy4NCj4gDQo+IEkgZGlk
bid0IGtub3cgY2hlY2twYXRjaC5wbCBjYW4gcnVuIG9uIGhlYWRlciBmaWxlIGRpcmVjdGx5LiBU
cmllZCB0bw0KPiBjaGVjayBwYXRjaCB3aXRoICctLXN0cmljdCAtZicsIHRoZSBiZWxvdyBpbmZv
IGRvZXNuJ3QgYXBwZWFyLiBCdXQgaXQNCg0KSG1tLi4uIC1mIGlzIHRvIGNoZWNrIGEgc291cmNl
IGZpbGUsIG5vdCBhIHBhdGNoLi4uIFdoYXQgZGlkIHlvdSB0cnkNCmV4YWN0bHkgPw0KDQo+IGRv
ZXMgZ2l2ZSBvdXQgYmVsb3cgaW5mb3JtYXRpb24gd2hlbiBydW4gb24gaGVhZGVyIGZpbGUuDQo+
IA0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gDQo+ID4gQ0hFQ0s6IGV4dGVybiBwcm90b3R5cGVzIHNo
b3VsZCBiZSBhdm9pZGVkIGluIC5oIGZpbGVzDQo+ID4gIzE3NjogRklMRTogaW5jbHVkZS9taXNj
L29jeGwuaDoxNzY6DQo+ID4gK2V4dGVybiBpbnQgb2N4bF9hZnVfaXJxX2FsbG9jKHN0cnVjdCBv
Y3hsX2NvbnRleHQgKmN0eCwgaW50ICppcnFfaWQpOw0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gDQo+
IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
