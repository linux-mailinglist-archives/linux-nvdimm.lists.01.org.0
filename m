Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D719BB23
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 Apr 2020 06:36:39 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC9DD10FC58A1;
	Wed,  1 Apr 2020 21:37:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id A879E10FC575F
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 21:37:25 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id DF6822DC3330;
	Thu,  2 Apr 2020 15:36:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585802195;
	bh=NccxCUYjczr9RvJe6ZTHFYb1tTCAe/GnhOOeFES5kJE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=Jz8kb+ZqAkhBJz5YLsHaQKojre1PdBeC66XBqXJQ8a8X2PccH0Dv62iTVxCqzvGGQ
	 OeuYyWbib6UfsFA/H18d3WqaClbH81AFv+78QikStXxty8qAqEfLaqmBBk+wGtiyhF
	 i57SXsCyuhK6cEjCs9urekR21w+AaH456c0LDsahaYjkxgwMut1ThTSr6NXO95fDcw
	 9DRM0+cm19LAgtTE7XwJJNRAMAjttX6YHJhXBZEKnlpt2xkKzyVKbonW0ji2+d74q2
	 A9zVjvao5NUfXSYGc5mDoH4FzUOfj0JhAST5fHLLql3MZpnoEle4riAHhhABY7qOWc
	 wgttMOa3WsQQNz5WsdmJke9tHiMIlZlGmnn+hd0eldvP5sZkEZbyjFRrJtnI8t7sO3
	 5YfTreAKhMOakHe20beq/v+vsjO3AdceKXgubt8seYGhPVH3yj5BOE+NlYbHgISAtl
	 yaiStNEd9hUsx6lkUPZZpYysp9ejEhXJplbWCMDMUXeNnvOvcIZmkX/b8xMEARO6R4
	 zregEeDmv83PjfVNNrvC0D4C7pDNACeW+w/hd4o6zlBViUKQM5o6ERRGGWYkWQc2TS
	 cPUcSJ67/1Q9f91p+Mg1avH9moJVwb142w//tmZLr/vbbOeBnApG25uWljoO1XCyob
	 yeR3Byh0UdfSXnuOTHsK/Rz4=
Received: from Hawking (ntp.lan [10.0.1.1])
	(authenticated bits=0)
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 0324aU03089960
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 2 Apr 2020 15:36:30 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Dan Williams'" <dan.j.williams@intel.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-4-alastair@d-silva.org> <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
In-Reply-To: <CAPcyv4iGEHJpZctEm+Do1-kOZBUDeKKcREr=BqcK4kCvLWhAQQ@mail.gmail.com>
Subject: RE: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
Date: Thu, 2 Apr 2020 15:36:28 +1100
Message-ID: <2e7701d608a8$473a0140$d5ae03c0$@d-silva.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AQJ5L4Hn/mp5p0p1jYAFWLJ+xmWSbgIEmlkbAeDU20mm/8VSIA==
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Thu, 02 Apr 2020 15:36:30 +1100 (AEDT)
Message-ID-Hash: ZSDFI3PLSIMVKEGMFVSPSP74Z5TOUBQY
X-Message-ID-Hash: ZSDFI3PLSIMVKEGMFVSPSP74Z5TOUBQY
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socionex
 t.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'linuxppc-dev' <linuxppc-dev@lists.ozlabs.org>, 'linux-nvdimm' <linux-nvdimm@lists.01.org>, 'Linux MM' <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZSDFI3PLSIMVKEGMFVSPSP74Z5TOUBQY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCAxIEFwcmlsIDIwMjAgNzo0
OSBQTQ0KPiBUbzogQWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+IENj
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
Y3Q6IFJlOiBbUEFUQ0ggdjQgMDMvMjVdIHBvd2VycGMvcG93ZXJudjogTWFwICYgcmVsZWFzZSBP
cGVuQ0FQSQ0KPiBMUEMgbWVtb3J5DQo+IA0KPiBPbiBTdW4sIE1hciAyOSwgMjAyMCBhdCAxMDoy
MyBQTSBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9yZz4NCj4gd3JvdGU6DQo+
ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgT1BBTCBjYWxscyB0byBwb3dlcm52IHNvIHRoYXQgdGhl
IE9wZW5DQVBJIGRyaXZlciBjYW4NCj4gPiBtYXAgJiByZWxlYXNlIExQQyAoTG93ZXN0IFBvaW50
IG9mIENvaGVyZW5jeSkgIG1lbW9yeS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsYXN0YWly
IEQnU2lsdmEgPGFsYXN0YWlyQGQtc2lsdmEub3JnPg0KPiA+IFJldmlld2VkLWJ5OiBBbmRyZXcg
RG9ubmVsbGFuIDxhamRAbGludXguaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL3Budi1vY3hsLmggICB8ICAyICsrDQo+ID4gIGFyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcG93ZXJudi9vY3hsLmMgfCA0Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52LW9jeGwuaA0KPiA+IGIvYXJjaC9w
b3dlcnBjL2luY2x1ZGUvYXNtL3Budi1vY3hsLmgNCj4gPiBpbmRleCA3ZGU4MjY0N2U3NjEuLjU2
MGExOWJiNzFiNyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcG52
LW9jeGwuaA0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9wbnYtb2N4bC5oDQo+
ID4gQEAgLTMyLDUgKzMyLDcgQEAgZXh0ZXJuIGludA0KPiBwbnZfb2N4bF9zcGFfcmVtb3ZlX3Bl
X2Zyb21fY2FjaGUodm9pZA0KPiA+ICpwbGF0Zm9ybV9kYXRhLCBpbnQgcGVfaGFuZGxlKQ0KPiA+
DQo+ID4gIGV4dGVybiBpbnQgcG52X29jeGxfYWxsb2NfeGl2ZV9pcnEodTMyICppcnEsIHU2NCAq
dHJpZ2dlcl9hZGRyKTsNCj4gPiBleHRlcm4gdm9pZCBwbnZfb2N4bF9mcmVlX3hpdmVfaXJxKHUz
MiBpcnEpOw0KPiA+ICt1NjQgcG52X29jeGxfcGxhdGZvcm1fbHBjX3NldHVwKHN0cnVjdCBwY2lf
ZGV2ICpwZGV2LCB1NjQgc2l6ZSk7IHZvaWQNCj4gPiArcG52X29jeGxfcGxhdGZvcm1fbHBjX3Jl
bGVhc2Uoc3RydWN0IHBjaV9kZXYgKnBkZXYpOw0KPiA+DQo+ID4gICNlbmRpZiAvKiBfQVNNX1BO
Vl9PQ1hMX0ggKi8NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dl
cm52L29jeGwuYw0KPiA+IGIvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9wb3dlcm52L29jeGwuYw0K
PiA+IGluZGV4IDhjNjVhYWNkYTljOC4uZjEzMTE5YTdjMDI2IDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJudi9vY3hsLmMNCj4gPiArKysgYi9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zL3Bvd2VybnYvb2N4bC5jDQo+ID4gQEAgLTQ3NSw2ICs0NzUsNDkgQEAgdm9p
ZCBwbnZfb2N4bF9zcGFfcmVsZWFzZSh2b2lkICpwbGF0Zm9ybV9kYXRhKQ0KPiB9DQo+ID4gRVhQ
T1JUX1NZTUJPTF9HUEwocG52X29jeGxfc3BhX3JlbGVhc2UpOw0KPiA+DQo+ID4gK3U2NCBwbnZf
b2N4bF9wbGF0Zm9ybV9scGNfc2V0dXAoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHU2NCBzaXplKSB7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgcGNpX2NvbnRyb2xsZXIgKmhvc2UgPSBwY2lfYnVzX3RvX2hv
c3QocGRldi0+YnVzKTsNCj4gPiArICAgICAgIHN0cnVjdCBwbnZfcGhiICpwaGIgPSBob3NlLT5w
cml2YXRlX2RhdGE7DQo+IA0KPiBJcyBjYWxsaW5nIHRoZSBsb2NhbCB2YXJpYWJsZSAnaG9zZScg
aW5zdGVhZCBvZiAnaG9zdCcgb24gcHVycG9zZT8NCj4gDQoNClllcywgdGhpcyBmb2xsb3dzIHRo
ZSBjb252ZW50aW9uIHVzZWQgaW4gb3RoZXIgZnVuY3Rpb25zIGluIHRoaXMgZmlsZS4NCg0KPiA+
ICsgICAgICAgdTMyIGJkZm4gPSBwY2lfZGV2X2lkKHBkZXYpOw0KPiA+ICsgICAgICAgX19iZTY0
IGJhc2VfYWRkcl9iZTY0Ow0KPiA+ICsgICAgICAgdTY0IGJhc2VfYWRkcjsNCj4gPiArICAgICAg
IGludCByYzsNCj4gPiArDQo+ID4gKyAgICAgICByYyA9IG9wYWxfbnB1X21lbV9hbGxvYyhwaGIt
Pm9wYWxfaWQsIGJkZm4sIHNpemUsDQo+ICZiYXNlX2FkZHJfYmU2NCk7DQo+ID4gKyAgICAgICBp
ZiAocmMpIHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X3dhcm4oJnBkZXYtPmRldiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgIk9QQUwgY291bGQgbm90IGFsbG9jYXRlIExQQyBtZW1v
cnksIHJjPSVkXG4iLCByYyk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGJhc2VfYWRkciA9IGJlNjRfdG9fY3B1KGJhc2Vf
YWRkcl9iZTY0KTsNCj4gPiArDQo+ID4gKyNpZmRlZiBDT05GSUdfTUVNT1JZX0hPVFBMVUdfU1BB
UlNFDQo+IA0KPiBXaXRoIHRoZSBwcm9wb3NlZCBjbGVhbnVwIGluIHBhdGNoMiB0aGUgaWZkZWYg
Y2FuIGJlIGVsaWRlZCBoZXJlLg0KDQpPaw0KPiANCj4gPiArICAgICAgIHJjID0gY2hlY2tfaG90
cGx1Z19tZW1vcnlfYWRkcmVzc2FibGUoYmFzZV9hZGRyID4+IFBBR0VfU0hJRlQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemUgPj4gUEFHRV9T
SElGVCk7DQo+ID4gKyAgICAgICBpZiAocmMpDQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiANCj4gSXMgdGhpcyBhbiBlcnJvciB3b3J0aCBsb2dnaW5nIGlmIHNvbWVvbmUgaXMgd29u
ZGVyaW5nIHdoeSB0aGVpciBkZXZpY2UgaXMgbm90DQo+IHNob3dpbmcgdXA/DQo+IA0KDQpZZXMs
IEknbGwgYWRkIGEgbWVzc2FnZS4NCg0KPiANCj4gPiArI2VuZGlmDQo+ID4gKw0KPiA+ICsgICAg
ICAgcmV0dXJuIGJhc2VfYWRkcjsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChwbnZf
b2N4bF9wbGF0Zm9ybV9scGNfc2V0dXApOw0KPiA+ICsNCj4gPiArdm9pZCBwbnZfb2N4bF9wbGF0
Zm9ybV9scGNfcmVsZWFzZShzdHJ1Y3QgcGNpX2RldiAqcGRldikgew0KPiA+ICsgICAgICAgc3Ry
dWN0IHBjaV9jb250cm9sbGVyICpob3NlID0gcGNpX2J1c190b19ob3N0KHBkZXYtPmJ1cyk7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgcG52X3BoYiAqcGhiID0gaG9zZS0+cHJpdmF0ZV9kYXRhOw0KPiA+
ICsgICAgICAgdTMyIGJkZm4gPSBwY2lfZGV2X2lkKHBkZXYpOw0KPiA+ICsgICAgICAgaW50IHJj
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJjID0gb3BhbF9ucHVfbWVtX3JlbGVhc2UocGhiLT5vcGFs
X2lkLCBiZGZuKTsNCj4gPiArICAgICAgIGlmIChyYykNCj4gPiArICAgICAgICAgICAgICAgZGV2
X3dhcm4oJnBkZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgIk9QQUwgcmVw
b3J0ZWQgcmM9JWQgd2hlbiByZWxlYXNpbmcgTFBDDQo+ID4gK21lbW9yeVxuIiwgcmMpOyB9DQo+
IEVYUE9SVF9TWU1CT0xfR1BMKHBudl9vY3hsX3BsYXRmb3JtX2xwY19yZWxlYXNlKTsNCj4gPiAr
DQo+ID4gIGludCBwbnZfb2N4bF9zcGFfcmVtb3ZlX3BlX2Zyb21fY2FjaGUodm9pZCAqcGxhdGZv
cm1fZGF0YSwgaW50DQo+ID4gcGVfaGFuZGxlKSAgew0KPiA+ICAgICAgICAgc3RydWN0IHNwYV9k
YXRhICpkYXRhID0gKHN0cnVjdCBzcGFfZGF0YSAqKSBwbGF0Zm9ybV9kYXRhOw0KPiA+IC0tDQo+
ID4gMi4yNC4xDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBUaGlzIGVtYWlsIGhhcyBiZWVuIGNoZWNr
ZWQgZm9yIHZpcnVzZXMgYnkgQVZHLg0KPiBodHRwczovL3d3dy5hdmcuY29tDQoNCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
