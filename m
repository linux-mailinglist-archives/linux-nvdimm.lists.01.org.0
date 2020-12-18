Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5F02DDD04
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Dec 2020 03:46:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADFF4100EB325;
	Thu, 17 Dec 2020 18:46:29 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 7BDD1100EB324
	for <linux-nvdimm@lists.01.org>; Thu, 17 Dec 2020 18:46:24 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,428,1599494400";
   d="scan'208";a="102694924"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Dec 2020 10:46:21 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 7787D48990D2;
	Fri, 18 Dec 2020 10:46:18 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 10:46:17 +0800
Subject: Re: [RFC PATCH v3 0/9] fsdax: introduce fs query to support reflink
To: Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-mm@kvack.org>
References: <20201215121414.253660-1-ruansy.fnst@cn.fujitsu.com>
 <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <a57c44dd-127a-3bd2-fcb3-f1373572de27@cn.fujitsu.com>
Date: Fri, 18 Dec 2020 10:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <7fc7ba7c-f138-4944-dcc7-ce4b3f097528@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 7787D48990D2.AC7A4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: V5T2HLKGDUSI65EK6DOIDYCK27ERPF7L
X-Message-ID-Hash: V5T2HLKGDUSI65EK6DOIDYCK27ERPF7L
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V5T2HLKGDUSI65EK6DOIDYCK27ERPF7L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvMTIvMTcg5LiK5Y2INDo1NSwgSmFuZSBDaHUgd3JvdGU6DQo+IEhpLCBTaGl5
YW5nLA0KPiANCj4gT24gMTIvMTUvMjAyMCA0OjE0IEFNLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+
PiBUaGUgY2FsbCB0cmFjZSBpcyBsaWtlIHRoaXM6DQo+PiBtZW1vcnlfZmFpbHVyZSgpDQo+PiDC
oCBwZ21hcC0+b3BzLT5tZW1vcnlfZmFpbHVyZSgpwqDCoMKgwqDCoCA9PiBwbWVtX3BnbWFwX21l
bW9yeV9mYWlsdXJlKCkNCj4+IMKgwqAgZ2VuZGlzay0+Zm9wcy0+Y29ycnVwdGVkX3JhbmdlKCkg
PT4gLSBwbWVtX2NvcnJ1cHRlZF9yYW5nZSgpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gbWRf
YmxrX2NvcnJ1cHRlZF9yYW5nZSgpDQo+PiDCoMKgwqAgc2ItPnNfb3BzLT5jdXJydXB0ZWRfcmFu
Z2UoKcKgwqDCoCA9PiB4ZnNfZnNfY29ycnVwdGVkX3JhbmdlKCkNCj4+IMKgwqDCoMKgIHhmc19y
bWFwX3F1ZXJ5X3JhbmdlKCkNCj4+IMKgwqDCoMKgwqAgeGZzX2N1cnJ1cHRfaGVscGVyKCkNCj4+
IMKgwqDCoMKgwqDCoCAqIGNvcnJ1cHRlZCBvbiBtZXRhZGF0YQ0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdHJ5IHRvIHJlY292ZXIgZGF0YSwgY2FsbCB4ZnNfZm9yY2Vfc2h1dGRvd24oKQ0KPj4g
wqDCoMKgwqDCoMKgICogY29ycnVwdGVkIG9uIGZpbGUgZGF0YQ0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgdHJ5IHRvIHJlY292ZXIgZGF0YSwgY2FsbCBtZl9kYXhfbWFwcGluZ19raWxsX3Byb2Nz
KCkNCj4+DQo+PiBUaGUgZnNkYXggJiByZWZsaW5rIHN1cHBvcnQgZm9yIFhGUyBpcyBub3QgY29u
dGFpbmVkIGluIHRoaXMgcGF0Y2hzZXQuDQo+Pg0KPj4gKFJlYmFzZWQgb24gdjUuMTApDQo+IA0K
PiBTbyBJIHRyaWVkIHRoZSBwYXRjaHNldCB3aXRoIHBtZW0gZXJyb3IgaW5qZWN0aW9uLCB0aGUg
U0lHQlVTIHBheWxvYWQNCj4gZG9lcyBub3QgbG9vayByaWdodCAtDQo+IA0KPiAqKiBTSUdCVVMo
Nyk6ICoqDQo+ICoqIHNpX2FkZHIoMHgobmlsKSksIHNpX2xzYigweEMpLCBzaV9jb2RlKDB4NCwg
QlVTX01DRUVSUl9BUikgKioNCj4gDQo+IEkgZXhwZWN0IHRoZSBwYXlsb2FkIGxvb2tzIGxpa2UN
Cj4gDQo+ICoqIHNpX2FkZHIoMHg3ZjM2NzJlMDAwMDApLCBzaV9sc2IoMHgxNSksIHNpX2NvZGUo
MHg0LCBCVVNfTUNFRVJSX0FSKSAqKg0KDQpUaGFua3MgZm9yIHRlc3RpbmcuICBJIHRlc3QgdGhl
IFNJR0JVUyBieSB3cml0aW5nIGEgcHJvZ3JhbSB3aGljaCBjYWxscyANCm1hZHZpc2UoLi4uICxN
QURWX0hXUE9JU09OKSB0byBpbmplY3QgbWVtb3J5LWZhaWx1cmUuICBJdCBqdXN0IHNob3dzIA0K
dGhhdCB0aGUgcHJvZ3JhbSBpcyBraWxsZWQgYnkgU0lHQlVTLiAgSSBjYW5ub3QgZ2V0IGFueSBk
ZXRhaWwgZnJvbSBpdC4gDQogIFNvLCBjb3VsZCB5b3UgcGxlYXNlIHNob3cgbWUgdGhlIHJpZ2h0
IHdheSh0ZXN0IHRvb2xzKSB0byB0ZXN0IGl0Pw0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlh
bmcuDQoNCj4gDQo+IHRoYW5rcywNCj4gLWphbmUNCj4gDQo+IA0KPiANCj4gDQo+IA0KPiANCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZk
aW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2Ny
aWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
