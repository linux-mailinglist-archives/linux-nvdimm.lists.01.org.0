Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A8E24034A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 Aug 2020 10:16:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78DB412E3301B;
	Mon, 10 Aug 2020 01:16:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id B9AE312AC438D
	for <linux-nvdimm@lists.01.org>; Mon, 10 Aug 2020 01:16:07 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.75,456,1589212800";
   d="scan'208";a="97927751"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Aug 2020 16:16:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 1A5144CE34E6;
	Mon, 10 Aug 2020 16:16:00 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 10 Aug
 2020 16:16:02 +0800
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
To: Matthew Wilcox <willy@infradead.org>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807133857.GC17456@casper.infradead.org>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9673ed3c-9e42-3d01-000b-b01cda9832ce@cn.fujitsu.com>
Date: Mon, 10 Aug 2020 16:15:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807133857.GC17456@casper.infradead.org>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 1A5144CE34E6.AAE60
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: EI4OE4YVE7H4QEEK5PT7MKBJPTZLJ6AT
X-Message-ID-Hash: EI4OE4YVE7H4QEEK5PT7MKBJPTZLJ6AT
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EI4OE4YVE7H4QEEK5PT7MKBJPTZLJ6AT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvOC83IOS4i+WNiDk6MzgsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiBPbiBG
cmksIEF1ZyAwNywgMjAyMCBhdCAwOToxMzoyOFBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6
DQo+PiBUaGlzIHBhdGNoc2V0IGlzIGEgdHJ5IHRvIHJlc29sdmUgdGhlIHByb2JsZW0gb2YgdHJh
Y2tpbmcgc2hhcmVkIHBhZ2UNCj4+IGZvciBmc2RheC4NCj4+DQo+PiBJbnN0ZWFkIG9mIHBlci1w
YWdlIHRyYWNraW5nIG1ldGhvZCwgdGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGEgcXVlcnkNCj4+
IGludGVyZmFjZTogZ2V0X3NoYXJlZF9maWxlcygpLCB3aGljaCBpcyBpbXBsZW1lbnRlZCBieSBl
YWNoIEZTLCB0bw0KPj4gb2J0YWluIHRoZSBvd25lcnMgb2YgYSBzaGFyZWQgcGFnZS4gIEl0IHJl
dHVybnMgYW4gb3duZXIgbGlzdCBvZiB0aGlzDQo+PiBzaGFyZWQgcGFnZS4gIFRoZW4sIHRoZSBt
ZW1vcnktZmFpbHVyZSgpIGl0ZXJhdGVzIHRoZSBsaXN0IHRvIGJlIGFibGUNCj4+IHRvIG5vdGlm
eSBlYWNoIHByb2Nlc3MgdXNpbmcgZmlsZXMgdGhhdCBzaGFyaW5nIHRoaXMgcGFnZS4NCj4+DQo+
PiBUaGUgZGVzaWduIG9mIHRoZSB0cmFja2luZyBtZXRob2QgaXMgYXMgZm9sbG93Og0KPj4gMS4g
ZGF4X2Fzc29jYWl0ZV9lbnRyeSgpIGFzc29jaWF0ZXMgdGhlIG93bmVyJ3MgaW5mbyB0byB0aGlz
IHBhZ2UNCj4gDQo+IEkgdGhpbmsgdGhhdCdzIHRoZSBmaXJzdCBwcm9ibGVtIHdpdGggdGhpcyBk
ZXNpZ24uICBkYXhfYXNzb2NpYXRlX2VudHJ5IGlzDQo+IGEgaG9ycmVuZG91cyBpZGVhIHdoaWNo
IG5lZWRzIHRvIGJlIHJpcHBlZCBvdXQsIG5vdCBtYWRlIG1vcmUgaW1wb3J0YW50Lg0KPiBJdCdz
IGFsbCBwYXJ0IG9mIHRoZSBnZW5lcmFsIHByb2JsZW0gb2YgdHJ5aW5nIHRvIGRvIHNvbWV0aGlu
ZyBvbiBhDQo+IHBlci1wYWdlIGJhc2lzIGluc3RlYWQgb2YgcGVyLWV4dGVudCBiYXNpcy4NCj4g
DQoNClRoZSBtZW1vcnktZmFpbHVyZSBuZWVkcyB0byB0cmFjayBvd25lcnMgaW5mbyBmcm9tIGEg
ZGF4IHBhZ2UsIHNvIEkgDQpzaG91bGQgYXNzb2NpYXRlIHRoZSBvd25lciB3aXRoIHRoaXMgcGFn
ZS4gIEluIHRoaXMgdmVyc2lvbiwgSSBhc3NvY2lhdGUgDQp0aGUgYmxvY2sgZGV2aWNlIHRvIHRo
ZSBkYXggcGFnZSwgc28gdGhhdCB0aGUgbWVtb3J5LWZhaWx1cmUgaXMgYWJsZSB0byANCml0ZXJh
dGUgdGhlIG93bmVycyBieSB0aGUgcXVlcnkgaW50ZXJmYWNlIHByb3ZpZGVkIGJ5IGZpbGVzeXN0
ZW0uDQoNCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCj4gDQo+IA0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
