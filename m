Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D62DAC81
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 13:00:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4DA61100EBBBF;
	Tue, 15 Dec 2020 04:00:36 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 4239C100EBBB9
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 04:00:32 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400";
   d="scan'208";a="102419797"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Dec 2020 20:00:29 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 928374CE600B;
	Tue, 15 Dec 2020 20:00:26 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Dec
 2020 20:00:25 +0800
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
To: Jane Chu <jane.chu@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-mm@kvack.org>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
Date: Tue, 15 Dec 2020 19:58:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 928374CE600B.AB884
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: QQANITIMF5JGYY5EYFVEHBERAIHD5D3O
X-Message-ID-Hash: QQANITIMF5JGYY5EYFVEHBERAIHD5D3O
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QQANITIMF5JGYY5EYFVEHBERAIHD5D3O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgSmFuZQ0KDQpPbiAyMDIwLzEyLzE1IOS4iuWNiDQ6NTgsIEphbmUgQ2h1IHdyb3RlOg0KPiBI
aSwgU2hpeWFuZywNCj4gDQo+IE9uIDExLzIyLzIwMjAgNDo0MSBQTSwgU2hpeWFuZyBSdWFuIHdy
b3RlOg0KPj4gVGhpcyBwYXRjaHNldCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBwcm9ibGVtIG9m
IHRyYWNraW5nIHNoYXJlZCBwYWdlDQo+PiBmb3IgZnNkYXguDQo+Pg0KPj4gQ2hhbmdlIGZyb20g
djE6DQo+PiDCoMKgIC0gSW50b3JkdWNlIC0+YmxvY2tfbG9zdCgpIGZvciBibG9jayBkZXZpY2UN
Cj4+IMKgwqAgLSBTdXBwb3J0IG1hcHBlZCBkZXZpY2UNCj4+IMKgwqAgLSBBZGQgJ25vdCBhdmFp
bGFibGUnIHdhcm5pbmcgZm9yIHJlYWx0aW1lIGRldmljZSBpbiBYRlMNCj4+IMKgwqAgLSBSZWJh
c2VkIHRvIHY1LjEwLXJjMQ0KPj4NCj4+IFRoaXMgcGF0Y2hzZXQgbW92ZXMgb3duZXIgdHJhY2tp
bmcgZnJvbSBkYXhfYXNzb2NhaXRlX2VudHJ5KCkgdG8gcG1lbQ0KPj4gZGV2aWNlLCBieSBpbnRy
b2R1Y2luZyBhbiBpbnRlcmZhY2UgLT5tZW1vcnlfZmFpbHVyZSgpIG9mIHN0cnVjdA0KPj4gcGFn
ZW1hcC7CoCBUaGUgaW50ZXJmYWNlIGlzIGNhbGxlZCBieSBtZW1vcnlfZmFpbHVyZSgpIGluIG1t
LCBhbmQNCj4+IGltcGxlbWVudGVkIGJ5IHBtZW0gZGV2aWNlLsKgIFRoZW4gcG1lbSBkZXZpY2Ug
Y2FsbHMgaXRzIC0+YmxvY2tfbG9zdCgpDQo+PiB0byBmaW5kIHRoZSBmaWxlc3lzdGVtIHdoaWNo
IHRoZSBkYW1hZ2VkIHBhZ2UgbG9jYXRlZCBpbiwgYW5kIGNhbGwNCj4+IC0+c3RvcmFnZV9sb3N0
KCkgdG8gdHJhY2sgZmlsZXMgb3IgbWV0YWRhdGEgYXNzb2NhaXRlZCB3aXRoIHRoaXMgcGFnZS4N
Cj4+IEZpbmFsbHkgd2UgYXJlIGFibGUgdG8gdHJ5IHRvIGZpeCB0aGUgZGFtYWdlZCBkYXRhIGlu
IGZpbGVzeXN0ZW0gYW5kIGRvDQo+IA0KPiBEb2VzIHRoYXQgbWVhbiBjbGVhcmluZyBwb2lzb24/
IGlmIHNvLCB3b3VsZCB5b3UgbWluZCB0byBlbGFib3JhdGUgDQo+IHNwZWNpZmljYWxseSB3aGlj
aCBjaGFuZ2UgZG9lcyB0aGF0Pw0KDQpSZWNvdmVyaW5nIGRhdGEgZm9yIGZpbGVzeXN0ZW0gKG9y
IHBtZW0gZGV2aWNlKSBoYXMgbm90IGJlZW4gZG9uZSBpbiANCnRoaXMgcGF0Y2hzZXQuLi4gIEkg
anVzdCB0cmlnZ2VyZWQgdGhlIGhhbmRsZXIgZm9yIHRoZSBmaWxlcyBzaGFyaW5nIHRoZSANCmNv
cnJ1cHRlZCBwYWdlIGhlcmUuDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCg0KPiAN
Cj4gVGhhbmtzIQ0KPiAtamFuZQ0KPiANCj4+IG90aGVyIG5lY2Vzc2FyeSBwcm9jZXNzaW5nLCBz
dWNoIGFzIGtpbGxpbmcgcHJvY2Vzc2VzIHdobyBhcmUgdXNpbmcgdGhlDQo+PiBmaWxlcyBhZmZl
Y3RlZC4NCj4gDQo+IA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4w
MS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVA
bGlzdHMuMDEub3JnCg==
