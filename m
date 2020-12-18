Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 724DE2DE04E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 10:15:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 877BA100EE8C8;
	Fri, 18 Dec 2020 01:15:21 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 5F656100EE8C6
	for <linux-nvdimm@lists.01.org>; Fri, 18 Dec 2020 01:15:19 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,430,1599494400";
   d="scan'208";a="102711642"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 17:15:17 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 61E5048990D2;
	Fri, 18 Dec 2020 17:15:15 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 17:15:15 +0800
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To: "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
 <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
 <20201218034907.GG6918@magnolia>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <16ac8000-2892-7491-26a0-84de4301f168@cn.fujitsu.com>
Date: Fri, 18 Dec 2020 17:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201218034907.GG6918@magnolia>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 61E5048990D2.AA872
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: VODWHXKZUGBYMXKUQJ3OBJKNESVMUHMD
X-Message-ID-Hash: VODWHXKZUGBYMXKUQJ3OBJKNESVMUHMD
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VODWHXKZUGBYMXKUQJ3OBJKNESVMUHMD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTgg5LiK5Y2IMTE6NDksIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4g
T24gRnJpLCBEZWMgMTgsIDIwMjAgYXQgMTA6NDQ6MjZBTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiAyMDIwLzEyLzE3IOS4iuWNiDQ6NTUsIEphbmUgQ2h1IHdyb3Rl
Og0KPj4+IEhpLCBTaGl5YW5nLA0KPj4+DQo+Pj4gT24gMTIvMTUvMjAyMCA0OjE0IEFNLCBTaGl5
YW5nIFJ1YW4gd3JvdGU6DQo+Pj4+IFRoZSBjYWxsIHRyYWNlIGlzIGxpa2UgdGhpczoNCj4+Pj4g
bWVtb3J5X2ZhaWx1cmUoKQ0KPj4+PiAgwqAgcGdtYXAtPm9wcy0+bWVtb3J5X2ZhaWx1cmUoKcKg
wqDCoMKgwqAgPT4gcG1lbV9wZ21hcF9tZW1vcnlfZmFpbHVyZSgpDQo+Pj4+ICDCoMKgIGdlbmRp
c2stPmZvcHMtPmNvcnJ1cHRlZF9yYW5nZSgpID0+IC0gcG1lbV9jb3JydXB0ZWRfcmFuZ2UoKQ0K
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIG1kX2Jsa19jb3JydXB0ZWRfcmFuZ2UoKQ0KPj4+
PiAgwqDCoMKgIHNiLT5zX29wcy0+Y3VycnVwdGVkX3JhbmdlKCnCoMKgwqAgPT4geGZzX2ZzX2Nv
cnJ1cHRlZF9yYW5nZSgpDQo+Pj4+ICDCoMKgwqDCoCB4ZnNfcm1hcF9xdWVyeV9yYW5nZSgpDQo+
Pj4+ICDCoMKgwqDCoMKgIHhmc19jdXJydXB0X2hlbHBlcigpDQo+Pj4+ICDCoMKgwqDCoMKgwqAg
KiBjb3JydXB0ZWQgb24gbWV0YWRhdGENCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyeSB0
byByZWNvdmVyIGRhdGEsIGNhbGwgeGZzX2ZvcmNlX3NodXRkb3duKCkNCj4+Pj4gIMKgwqDCoMKg
wqDCoCAqIGNvcnJ1cHRlZCBvbiBmaWxlIGRhdGENCj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRyeSB0byByZWNvdmVyIGRhdGEsIGNhbGwgbWZfZGF4X21hcHBpbmdfa2lsbF9wcm9jcygpDQo+
Pj4+DQo+Pj4+IFRoZSBmc2RheCAmIHJlZmxpbmsgc3VwcG9ydCBmb3IgWEZTIGlzIG5vdCBjb250
YWluZWQgaW4gdGhpcyBwYXRjaHNldC4NCj4+Pj4NCj4+Pj4gKFJlYmFzZWQgb24gdjUuMTApDQo+
Pj4NCj4+PiBTbyBJIHRyaWVkIHRoZSBwYXRjaHNldCB3aXRoIHBtZW0gZXJyb3IgaW5qZWN0aW9u
LCB0aGUgU0lHQlVTIHBheWxvYWQNCj4+PiBkb2VzIG5vdCBsb29rIHJpZ2h0IC0NCj4+Pg0KPj4+
ICoqIFNJR0JVUyg3KTogKioNCj4+PiAqKiBzaV9hZGRyKDB4KG5pbCkpLCBzaV9sc2IoMHhDKSwg
c2lfY29kZSgweDQsIEJVU19NQ0VFUlJfQVIpICoqDQo+Pj4NCj4+PiBJIGV4cGVjdCB0aGUgcGF5
bG9hZCBsb29rcyBsaWtlDQo+Pj4NCj4+PiAqKiBzaV9hZGRyKDB4N2YzNjcyZTAwMDAwKSwgc2lf
bHNiKDB4MTUpLCBzaV9jb2RlKDB4NCwgQlVTX01DRUVSUl9BUikgKioNCj4+DQo+PiBUaGFua3Mg
Zm9yIHRlc3RpbmcuICBJIHRlc3QgdGhlIFNJR0JVUyBieSB3cml0aW5nIGEgcHJvZ3JhbSB3aGlj
aCBjYWxscw0KPj4gbWFkdmlzZSguLi4gLE1BRFZfSFdQT0lTT04pIHRvIGluamVjdCBtZW1vcnkt
ZmFpbHVyZS4gIEl0IGp1c3Qgc2hvd3MgdGhhdA0KPj4gdGhlIHByb2dyYW0gaXMga2lsbGVkIGJ5
IFNJR0JVUy4gIEkgY2Fubm90IGdldCBhbnkgZGV0YWlsIGZyb20gaXQuICBTbywNCj4+IGNvdWxk
IHlvdSBwbGVhc2Ugc2hvdyBtZSB0aGUgcmlnaHQgd2F5KHRlc3QgdG9vbHMpIHRvIHRlc3QgaXQ/
DQo+IA0KPiBJJ20gYXNzdW1pbmcgdGhhdCBKYW5lIGlzIHVzaW5nIGEgcHJvZ3JhbSB0aGF0IGNh
bGxzIHNpZ2FjdGlvbiB0bw0KPiBpbnN0YWxsIGEgU0lHQlVTIGhhbmRsZXIsIGFuZCBkdW1wcyB0
aGUgZW50aXJlIHNpZ2luZm9fdCBzdHJ1Y3R1cmUNCj4gd2hlbmV2ZXIgaXQgcmVjZWl2ZXMgb25l
Li4uDQoNCk9LLiAgTGV0IG1lIHRyeSBpdCBhbmQgZmlndXJlIG91dCB3aGF0J3Mgd3JvbmcgaW4g
aXQuDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCg0KPiANCj4gLS1EDQo+IA0KPj4N
Cj4+IC0tDQo+PiBUaGFua3MsDQo+PiBSdWFuIFNoaXlhbmcuDQo+Pg0KPj4+DQo+Pj4gdGhhbmtz
LA0KPj4+IC1qYW5lDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4NCj4+Pg0KPj4+DQo+Pg0KPj4NCj4gDQo+
IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5z
dWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3Jn
Cg==
