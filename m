Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC77B19CEF6
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 Apr 2020 05:52:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82965100F227C;
	Thu,  2 Apr 2020 20:53:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id A5BB0100F227B
	for <linux-nvdimm@lists.01.org>; Thu,  2 Apr 2020 20:53:39 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id EB1792DC3D2F;
	Fri,  3 Apr 2020 14:52:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585885969;
	bh=/qbrUZJLw49Px53fHH61XOP2eWqn8wkHBEx+KDSvrvU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=Up9Nr+GrEKkMUmYftzGW5Z/K773hVH2gCzSh13cEdpBqugKJMdGjipoexqX61BLky
	 ayKBdVIkDJ3AWvztbbnCAMuWghuRpEFqwjwO7ZCBySBD1og/S2moYgXWRLdsSxX+/a
	 KJgQMUpBu1dvVGv3RzD7CKJW6Ql/YjGtVRIEdQhmeVNyq1ucOVrbsqPcxHsZ+5jnri
	 Uv3gZ/TiZUFYse5Ms95Z1Isf9lqt5FiL5KglNeH/kJ9Lgfiemfl0uqNeXdpg5ODP5o
	 u6tP8fDctVbvByp+bOWemuDuloxT4MdnLoEHoVlKW+W9vSHWIHNQXZ20e1h7GgTyf7
	 Up1xIESuRDLpJxy9TskeAI2MQyLG89eASMl4ymxz8xf3P8kJzlpEdTImYRU3qypGCP
	 vghn0zggG+R2Y8UxG2Kx7ibgXj6dwDdOJWPptZ0Sk1ktQRdv5asJnawbE1/uJnBT9/
	 m5GTdMJ5I51IJ95FMhLNN61RTqmrzxxb+realllSuHBu5Bjn+Nc1OCOOHGq7OPg5Vf
	 O1E57PRzyRKY5TIWerTom3GmJfKugyUp+sax+i4x7dqJt/gevtV73WHliEnb/jCfAa
	 VXnRR+uAepbur0PMxUSeNhrd8VYWuGsIiSzvW4k9HoPd6oeU1HKABrDdyxr7r8tDrB
	 qLLBCAUjvg7BTg/sH/3ifbfg=
Received: from Hawking (ntp.lan [10.0.1.1])
	(authenticated bits=0)
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTPSA id 0333qhBP097301
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 3 Apr 2020 14:52:43 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: "'Dan Williams'" <dan.j.williams@intel.com>
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-9-alastair@d-silva.org> <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
In-Reply-To: <CAPcyv4j4_owxEVjanwH5TiuMMJB3CaMannDzpXnaHedX7LuarQ@mail.gmail.com>
Subject: RE: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC memory was detected
Date: Fri, 3 Apr 2020 14:52:42 +1100
Message-ID: <303c01d6096b$541f33d0$fc5d9b70$@d-silva.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-au
Thread-Index: AQJ5L4Hn/mp5p0p1jYAFWLJ+xmWSbgKkO1ZLATOc+DmnAbiIwA==
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 03 Apr 2020 14:52:44 +1100 (AEDT)
Message-ID-Hash: TLZGNAXV4L5KGNDAZPBJWYWSNSZTHSZA
X-Message-ID-Hash: TLZGNAXV4L5KGNDAZPBJWYWSNSZTHSZA
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "'Aneesh Kumar K . V'" <aneesh.kumar@linux.ibm.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Paul Mackerras' <paulus@samba.org>, 'Michael Ellerman' <mpe@ellerman.id.au>, 'Frederic Barrat' <fbarrat@linux.ibm.com>, 'Andrew Donnellan' <ajd@linux.ibm.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Mauro Carvalho Chehab' <mchehab+samsung@kernel.org>, "'David S. Miller'" <davem@davemloft.net>, 'Rob Herring' <robh@kernel.org>, 'Anton Blanchard' <anton@ozlabs.org>, 'Krzysztof Kozlowski' <krzk@kernel.org>, 'Mahesh Salgaonkar' <mahesh@linux.vnet.ibm.com>, 'Madhavan Srinivasan' <maddy@linux.vnet.ibm.com>, =?utf-8?Q?'C=C3=A9dric_Le_Goater'?= <clg@kaod.org>, 'Anju T Sudhakar' <anju@linux.vnet.ibm.com>, 'Hari Bathini' <hbathini@linux.ibm.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Greg Kurz' <groug@kaod.org>, 'Nicholas Piggin' <npiggin@gmail.com>, 'Masahiro Yamada' <yamada.masahiro@socionex
 t.com>, 'Alexey Kardashevskiy' <aik@ozlabs.ru>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'linuxppc-dev' <linuxppc-dev@lists.ozlabs.org>, 'linux-nvdimm' <linux-nvdimm@lists.01.org>, 'Linux MM' <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TLZGNAXV4L5KGNDAZPBJWYWSNSZTHSZA/>
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
Y3Q6IFJlOiBbUEFUQ0ggdjQgMDgvMjVdIG9jeGw6IEVtaXQgYSBsb2cgbWVzc2FnZSBzaG93aW5n
IGhvdyBtdWNoDQo+IExQQyBtZW1vcnkgd2FzIGRldGVjdGVkDQo+IA0KPiBPbiBTdW4sIE1hciAy
OSwgMjAyMCBhdCAxMDoyMyBQTSBBbGFzdGFpciBEJ1NpbHZhIDxhbGFzdGFpckBkLXNpbHZhLm9y
Zz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIHBhdGNoIGVtaXRzIGEgbWVzc2FnZSBzaG93aW5n
IGhvdyBtdWNoIExQQyBtZW1vcnkgJiBzcGVjaWFsDQo+ID4gcHVycG9zZSBtZW1vcnkgd2FzIGRl
dGVjdGVkIG9uIGFuIE9DWEwgZGV2aWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxhc3Rh
aXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+DQo+ID4gQWNrZWQtYnk6IEZyZWRlcmlj
IEJhcnJhdCA8ZmJhcnJhdEBsaW51eC5pYm0uY29tPg0KPiA+IEFja2VkLWJ5OiBBbmRyZXcgRG9u
bmVsbGFuIDxhamRAbGludXguaWJtLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9taXNjL29j
eGwvY29uZmlnLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5jIGIvZHJp
dmVycy9taXNjL29jeGwvY29uZmlnLmMNCj4gPiBpbmRleCBhNjJlM2Q3ZGIyYmYuLjY5Y2NhMzQx
ZDQ0NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21pc2Mvb2N4bC9jb25maWcuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvbWlzYy9vY3hsL2NvbmZpZy5jDQo+ID4gQEAgLTU2OCw2ICs1NjgsMTAgQEAg
c3RhdGljIGludCByZWFkX2FmdV9scGNfbWVtb3J5X2luZm8oc3RydWN0DQo+IHBjaV9kZXYgKmRl
diwNCj4gPiAgICAgICAgICAgICAgICAgYWZ1LT5zcGVjaWFsX3B1cnBvc2VfbWVtX3NpemUgPQ0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRvdGFsX21lbV9zaXplIC0gbHBjX21lbV9zaXpl
Ow0KPiA+ICAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGRldl9pbmZvKCZkZXYtPmRldiwg
IlByb2JlZCBMUEMgbWVtb3J5IG9mICUjbGx4IGJ5dGVzIGFuZCBzcGVjaWFsDQo+IHB1cnBvc2Ug
bWVtb3J5IG9mICUjbGx4IGJ5dGVzXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgYWZ1LT5scGNf
bWVtX3NpemUsIGFmdS0+c3BlY2lhbF9wdXJwb3NlX21lbV9zaXplKTsNCj4gDQo+IEEgcGF0Y2gg
Zm9yIGEgc2luZ2xlIGxvZyBtZXNzYWdlIGlzIHRvbyBmaW5lIGdyYWluZWQgZm9yIG15IHRhc3Rl
LCBsZXQncyBzcXVhc2gNCj4gdGhpcyBpbnRvIGFub3RoZXIgcGF0Y2ggaW4gdGhlIHNlcmllcy4N
Cj4gDQoNCkknbSBub3Qgc3VyZSB0aGVyZSdzIGEgZ3JlYXQgcGxhY2UgZm9yIGl0LiBBdCBhIHBp
bmNoLCBpdCBjb3VsZCB3aXRoIHRoZSBwcmV2aW91cyBwYXRjaCwgYnV0IHRoZXkgYXJlIHJlYWxs
eSBkaWZmZXJlbnQgbGF5ZXJzLg0KDQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPg0KPiA+IC0tDQo+ID4gMi4yNC4xDQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBUaGlzIGVt
YWlsIGhhcyBiZWVuIGNoZWNrZWQgZm9yIHZpcnVzZXMgYnkgQVZHLg0KPiBodHRwczovL3d3dy5h
dmcuY29tDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpU
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4w
MS5vcmcK
