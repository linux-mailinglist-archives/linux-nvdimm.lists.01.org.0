Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8289B2DCC67
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Dec 2020 07:19:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C4D5B100EBB9F;
	Wed, 16 Dec 2020 22:19:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 70651100EBBD7
	for <linux-nvdimm@lists.01.org>; Wed, 16 Dec 2020 22:19:00 -0800 (PST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CxMHn2k4Tz7Dyq;
	Thu, 17 Dec 2020 14:18:13 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 17 Dec 2020
 14:18:43 +0800
Subject: Re: [ndctl PATCH V2 0/8] fix serverl issues reported by Coverity
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
References: <3211fe8a-33fb-37ca-e192-ad1f116f4acd@huawei.com>
 <ac83df5da52b505371abeeac1396e92d68fdc2c8.camel@intel.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <446d9604-9f0e-d9cb-d5ae-d9117f87903c@huawei.com>
Date: Thu, 17 Dec 2020 14:18:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <ac83df5da52b505371abeeac1396e92d68fdc2c8.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: AUAQQTNJWHNLTY4BGEEPMJVYCEWWVRA3
X-Message-ID-Hash: AUAQQTNJWHNLTY4BGEEPMJVYCEWWVRA3
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linfeilong@huawei.com" <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AUAQQTNJWHNLTY4BGEEPMJVYCEWWVRA3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTcgMTE6NDEsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToNCj4gT24gV2Vk
LCAyMDIwLTExLTI1IGF0IDA5OjAwICswODAwLCBaaGlxaWFuZyBMaXUgd3JvdGU6DQo+PiBDaGFu
Z2VzOiBWMS0+VjINCj4+IC0gYWRkIG9uZSBlbXB0eSBsaW5lIGluIDEvOCBwYXRjaCBhcyBzdWdn
ZXN0ZWQgYnkgSmVmZiBNb3llciA8am1veWVyQHJlZGhhdC5jb20+Lg0KPj4NCj4+DQo+PiBSZWNl
bnRseSwgd2UgdXNlIENvdmVyaXR5IHRvIGFuYWx5c2lzIHRoZSBuZGN0bCBwYWNrYWdlLg0KPj4g
U2V2ZXJhbCBpc3N1ZXMgc2hvdWxkIGJlIHJlc29sdmVkIHRvIG1ha2UgQ292ZXJpdHkgaGFwcHku
DQo+Pg0KPj4gWmhpcWlhbmcgTGl1ICg4KToNCj4+ICAgbmFtZXNwYWNlOiBjaGVjayB3aGV0aGVy
IHBmbnxkYXh8YnR0IGlzIE5VTEwgaW4gc2V0dXBfbmFtZXNwYWNlDQo+PiAgIGxpYi9saWJuZGN0
bDogZml4IG1lbW9yeSBsZWFrYWdlIHByb2JsZW0gaW4gYWRkX2J1cw0KPj4gICBsaWJkYXhjdGw6
IGZpeCBtZW1vcnkgbGVha2FnZSBpbiBhZGRfZGF4X3JlZ2lvbigpDQo+PiAgIGRpbW06IGZpeCBw
b3RlbnRpYWwgZmQgbGVha2FnZSBpbiBkaW1tX2FjdGlvbigpDQo+PiAgIHV0aWwvaGVscDogY2hl
Y2sgd2hldGhlciBzdHJkdXAgcmV0dXJucyBOVUxMIGluIGV4ZWNfbWFuX2tvbnF1ZXJvcg0KPj4g
ICBsaWIvaW5qZWN0OiBjaGVjayB3aGV0aGVyIGNtZCBpcyBjcmVhdGVkIHN1Y2Nlc3NmdWxseQ0K
Pj4gICBsaWJuZGN0bDogY2hlY2sgd2hldGhlciBuZGN0bF9idHRfZ2V0X25hbWVzcGFjZSByZXR1
cm5zIE5VTEwgaW4NCj4+ICAgICBjYWxsZXJzDQo+PiAgIG5hbWVzcGFjZTogY2hlY2sgd2hldGhl
ciBzZWVkIGlzIE5VTEwgaW4gdmFsaWRhdGVfbmFtZXNwYWNlX29wdGlvbnMNCj4+DQo+PiAgZGF4
Y3RsL2xpYi9saWJkYXhjdGwuYyB8ICAzICsrKw0KPj4gIG5kY3RsL2RpbW0uYyAgICAgICAgICAg
fCAxMiArKysrKysrLS0tLS0NCj4+ICBuZGN0bC9saWIvaW5qZWN0LmMgICAgIHwgIDggKysrKysr
KysNCj4+ICBuZGN0bC9saWIvbGlibmRjdGwuYyAgIHwgIDEgKw0KPj4gIG5kY3RsL25hbWVzcGFj
ZS5jICAgICAgfCAyMyArKysrKysrKysrKysrKysrKystLS0tLQ0KPj4gIHRlc3QvbGlibmRjdGwu
YyAgICAgICAgfCAxNiArKysrKysrKysrKy0tLS0tDQo+PiAgdGVzdC9wYXJlbnQtdXVpZC5jICAg
ICB8ICAyICstDQo+PiAgdXRpbC9oZWxwLmMgICAgICAgICAgICB8ICA4ICsrKysrKystDQo+PiAg
dXRpbC9qc29uLmMgICAgICAgICAgICB8ICAzICsrKw0KPj4gIDkgZmlsZXMgY2hhbmdlZCwgNTkg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+Pg0KPiBIaSBaaGlxdWlhbmcsDQo+IA0K
PiBUaGUgcGF0Y2hlcyBsb29rIGdvb2QsIGFuZCBJJ3ZlIGFwcGxpZWQgdGhlbSBmb3IgdjcxLiBI
b3dldmVyIG9uZSB0aGluZw0KPiB0byBub3RlOg0KPiANCj4gSWYgeW91J3JlIHNlbmRpbmcgYSB2
MiwgaXQgaXMgcHJlZmVyYWJsZSB0byByZXNwaW4gdGhlIHdob2xlIHNlcmllcywNCj4gZXZlbiBp
ZiB5b3UncmUgb25seSBjaGFuZ2luZyBhIHN1YnNldCBvZiAoZXZlbiBhIHNpbmdsZSkgcGF0Y2gg
aW4gdGhlDQo+IHNlcmllcy4gVGhhdCBhbGxvd3MgdG9vbHMgbGlrZSAnYjQnIHRvIGp1c3QgRG8g
VGhlIFJpZ2h0IFRoaW5nLCBhbmQgbWFrZQ0KPiBzdXJlIGFsbCB0aGUgbGF0ZXN0IHBhdGNoZXMg
YXJlIGdyYWJiZWQuDQo+IA0KPiBJbiB0aGlzIGNhc2UsIGVzcGVjaWFsbHksIHlvdXIgY292ZXIg
bGV0dGVyIHByb21pc2VzIDggcGF0Y2hlcyAoMC84KSwNCj4gYnV0IHRoZXJlIGlzIG9ubHkgb25l
IHRoYXQgZm9sbG93cy4gVGhpcyBjb25mdXNlcyAnYjQnOg0KPiANCj4gICAgRVJST1I6IG1pc3Np
bmcgWzIvOF0hDQo+ICAgIEVSUk9SOiBtaXNzaW5nIFszLzhdIQ0KPiAgICBFUlJPUjogbWlzc2lu
ZyBbNC84XSENCj4gICAgLi4uZXRjDQo+IA0KPiBJJ3ZlIGZpeGVkIGl0IHVwIG1hbnVhbGx5IGZv
ciB0aGlzLCBidXQganVzdCBzb21lIHRoaW5ncyB0byBjb25zaWRlciBmb3INCj4gdGhlIGZ1dHVy
ZS4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb27jgIINCg0KUmVnYXJkcw0KWmhpcWlh
bmcgTGl1DQoNCj4gVGhhbmtzLA0KPiAtVmlzaGFsDQo+IA0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
