Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8045B19BB20
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 06:34:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EEED10FC574F;
	Wed,  1 Apr 2020 21:34:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 82BE810FC574F
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 21:34:49 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 010C02DC3330;
	Thu,  2 Apr 2020 15:33:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585802039;
	bh=WyxkApmW2+/IWEqXKjwy7I58nLQNzwtikErBlXfDT3Q=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=BHYxjj87wP/IsQs6UieDA8cxeJBZxTxKiSxENghzcmzSMZpSPhsAQQNVkHBCh/rfB
	 g7ScGNmMgJ7TS1WAS8eRSlAlB/0Frr6pvG3vhjFR0f1uqYXfGiFITdSo5QG8C2DIsZ
	 egC8SaZKrXrEf4Jz53nJWQoXMN602ZUir1fDzeogqVfh8ndQgtWVImAG76Mb9r3ycs
	 u1GX8A3IMfWuGyThtQ7dbfhSafC/ftvCHMkyeL3L7t0GAaX8zstriWiChEa/m74230
	 4UWgA2ZNOXQ1B9ZJ/j3a7p7NaT3hmM6a4gFROh3gnorICAPY8P+n6M2noyxaDe8pr9
	 lQr7CiTU27DEK/GR/yTDRUncYTn/rvArwvxVAsL2CqIMn97cu0iIDtPUaVvFtGBhuc
	 mKJnISs7kAV7HYQ+3GuwzPaGBpgip6Putd5qmUY5EYVd0D3UPKNCSMnk8nRbfa9UHz
	 MAr514VjrJNrc9bjWIlTBWIUTr68ptMZE+KIx42jjSMcILhYAkBVitC8UcZSoejF14
	 MkO8kx+nwuCWs8zlTy79mK4KG76AiKxv24+67Y+OluJWLkTZY19Sto4NeUfpWtM1HH
	 hrWuh2Gq2HwbwPM42+wEyE8mnZEicC17Te6snoR1CUo+UwUEHoWgJmSf76Mv4zfE9i
	 JKLM9Nqj9TrfJlG6dIWn3tC8=
Received: from Hawking (ntp.lan [10.0.1.1])
	(authenticated bits=0)
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 0324Xi8h089946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Apr 2020 15:33:46 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Dan Williams'" <dan.j.williams@intel.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-3-alastair@d-silva.org> <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
In-Reply-To: <CAPcyv4h9uDxHDb0iN+zwhPB=By8Ps8cwTyipf6b64v+ruzhchg@mail.gmail.com>
Subject: RE: [PATCH v4 02/25] mm/memory_hotplug: Allow check_hotplug_memory_addressable to be called from drivers
Date: Thu, 2 Apr 2020 15:33:43 +1100
Message-ID: <2e7501d608a7$ea00cd10$be026730$@d-silva.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AQJ5L4Hn/mp5p0p1jYAFWLJ+xmWSbgIN9vctASc14KCnBUc6gA==
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 02 Apr 2020 15:33:54 +1100 (AEDT)
Message-ID-Hash: KF6O3MEBBG45WIOXTJSTM4UBOWD736QE
X-Message-ID-Hash: KF6O3MEBBG45WIOXTJSTM4UBOWD736QE
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socionex
 t.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'linuxppc-dev' <linuxppc-dev@lists.ozlabs.org>, 'linux-nvdimm' <linux-nvdimm@lists.01.org>, 'Linux MM' <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KF6O3MEBBG45WIOXTJSTM4UBOWD736QE/>
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
Y3Q6IFJlOiBbUEFUQ0ggdjQgMDIvMjVdIG1tL21lbW9yeV9ob3RwbHVnOiBBbGxvdw0KPiBjaGVj
a19ob3RwbHVnX21lbW9yeV9hZGRyZXNzYWJsZSB0byBiZSBjYWxsZWQgZnJvbSBkcml2ZXJzDQo+
IA0KPiBPbiBTdW4sIE1hciAyOSwgMjAyMCBhdCAxMDoyMyBQTSBBbGFzdGFpciBEJ1NpbHZhIDxh
bGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIHNldHRpbmcgdXAg
T3BlbkNBUEkgY29ubmVjdGVkIHBlcnNpc3RlbnQgbWVtb3J5LCB0aGUgcmFuZ2UgY2hlY2sNCj4g
PiBtYXkgbm90IGJlIHBlcmZvcm1lZCB1bnRpbCBxdWl0ZSBsYXRlIChvciBwZXJoYXBzIG5vdCBh
dCBhbGwsIGlmIHRoZQ0KPiA+IHVzZXIgZG9lcyBub3QgZXN0YWJsaXNoIGEgREFYIGRldmljZSku
DQo+ID4NCj4gPiBUaGlzIHBhdGNoIG1ha2VzIHRoZSByYW5nZSBjaGVjayBjYWxsYWJsZSBzbyB3
ZSBjYW4gcGVyZm9ybSB0aGUgY2hlY2sNCj4gPiB3aGlsZSBwcm9iaW5nIHRoZSBPcGVuQ0FQSSBQ
ZXJzaXN0ZW50IE1lbW9yeSBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGFzdGFp
ciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gPiBSZXZpZXdlZC1ieTogQW5kcmV3
IERvbm5lbGxhbiA8YWpkQGxpbnV4LmlibS5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGlu
dXgvbWVtb3J5X2hvdHBsdWcuaCB8IDUgKysrKysNCj4gPiAgbW0vbWVtb3J5X2hvdHBsdWcuYyAg
ICAgICAgICAgIHwgNCArKy0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWVt
b3J5X2hvdHBsdWcuaA0KPiA+IGIvaW5jbHVkZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oIGluZGV4
IGY0ZDU5MTU1ZjNkNC4uOWExOWFlMGQ3ZTMxDQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9saW51eC9tZW1vcnlfaG90cGx1Zy5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZW1vcnlf
aG90cGx1Zy5oDQo+ID4gQEAgLTMzNyw2ICszMzcsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIF9f
cmVtb3ZlX21lbW9yeShpbnQgbmlkLCB1NjQNCj4gPiBzdGFydCwgdTY0IHNpemUpIHt9ICBleHRl
cm4gdm9pZCBzZXRfem9uZV9jb250aWd1b3VzKHN0cnVjdCB6b25lDQo+ID4gKnpvbmUpOyAgZXh0
ZXJuIHZvaWQgY2xlYXJfem9uZV9jb250aWd1b3VzKHN0cnVjdCB6b25lICp6b25lKTsNCj4gPg0K
PiA+ICsjaWZkZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHX1NQQVJTRQ0KPiA+ICtpbnQgY2hlY2tf
aG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUodW5zaWduZWQgbG9uZyBwZm4sDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMpOyAj
ZW5kaWYNCj4gPiArLyogQ09ORklHX01FTU9SWV9IT1RQTFVHX1NQQVJTRSAqLw0KPiANCj4gTGV0
J3MgbW92ZSB0aGlzIHRvIGluY2x1ZGUvbGludXgvbWVtb3J5Lmggd2l0aCB0aGUgb3RoZXINCj4g
Q09ORklHX01FTU9SWV9IT1RQTFVHX1NQQVJTRSBkZWNsYXJhdGlvbnMsIGFuZCBhZGQgYSBkdW1t
eQ0KPiBpbXBsZW1lbnRhdGlvbiBmb3IgdGhlIENPTkZJR19NRU1PUllfSE9UUExVR19TUEFSU0U9
biBjYXNlLg0KPiANCj4gQWxzbywgdGhpcyBwYXRjaCBjYW4gYmUgc3F1YXNoZWQgd2l0aCB0aGUg
bmV4dCBvbmUsIG5vIG5lZWQgZm9yIGl0IHRvIGJlDQo+IHN0YW5kIGFsb25lLg0KPiANCg0KT2sN
Cg0KPiANCj4gPiArDQo+ID4gIGV4dGVybiB2b2lkIF9fcmVmIGZyZWVfYXJlYV9pbml0X2NvcmVf
aG90cGx1ZyhpbnQgbmlkKTsgIGV4dGVybiBpbnQNCj4gPiBfX2FkZF9tZW1vcnkoaW50IG5pZCwg
dTY0IHN0YXJ0LCB1NjQgc2l6ZSk7ICBleHRlcm4gaW50IGFkZF9tZW1vcnkoaW50DQo+ID4gbmlk
LCB1NjQgc3RhcnQsIHU2NCBzaXplKTsgZGlmZiAtLWdpdCBhL21tL21lbW9yeV9ob3RwbHVnLmMN
Cj4gPiBiL21tL21lbW9yeV9ob3RwbHVnLmMgaW5kZXggMGE1NGZmYWM4YzY4Li4xNDk0NWYwMzM1
OTQgMTAwNjQ0DQo+ID4gLS0tIGEvbW0vbWVtb3J5X2hvdHBsdWcuYw0KPiA+ICsrKyBiL21tL21l
bW9yeV9ob3RwbHVnLmMNCj4gPiBAQCAtMjc2LDggKzI3Niw4IEBAIHN0YXRpYyBpbnQgY2hlY2tf
cGZuX3NwYW4odW5zaWduZWQgbG9uZyBwZm4sDQo+IHVuc2lnbmVkIGxvbmcgbnJfcGFnZXMsDQo+
ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBpbnQgY2hlY2tf
aG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUodW5zaWduZWQgbG9uZyBwZm4sDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nIG5yX3Bh
Z2VzKQ0KPiA+ICtpbnQgY2hlY2tfaG90cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUodW5zaWduZWQg
bG9uZyBwZm4sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcgbnJfcGFnZXMpDQo+ID4gIHsNCj4gPiAgICAgICAgIGNvbnN0IHU2NCBtYXhfYWRk
ciA9IFBGTl9QSFlTKHBmbiArIG5yX3BhZ2VzKSAtIDE7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjQu
MQ0KPiA+DQoNCi0tIA0KQWxhc3RhaXIgRCdTaWx2YSAgICAgICAgICAgbW9iOiAwNDIzIDc2MiA4
MTkNCnNreXBlOiBhbGFzdGFpcl9kc2lsdmEgICAgIG1zbjogYWxhc3RhaXJAZC1zaWx2YS5vcmcN
CmJsb2c6IGh0dHA6Ly9hbGFzdGFpci5kLXNpbHZhLm9yZyAgICBUd2l0dGVyOiBARXZpbERlZWNl
DQogDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
