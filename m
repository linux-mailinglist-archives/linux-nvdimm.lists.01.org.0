Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574A0312A39
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 06:49:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36944100ED480;
	Sun,  7 Feb 2021 21:49:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id AAD63100EF276
	for <linux-nvdimm@lists.01.org>; Sun,  7 Feb 2021 21:49:42 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800";
   d="scan'208";a="104316295"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Feb 2021 13:49:40 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id B970C4CE6F74;
	Mon,  8 Feb 2021 13:49:37 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 13:49:40 +0800
Subject: Re: [PATCH] dax: fix default return code of range_parse()
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
To: <linux-nvdimm@lists.01.org>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <dave.jiang@intel.com>
References: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
Message-ID: <49788459-f42d-5173-c77a-f0a33558a58e@cn.fujitsu.com>
Date: Mon, 8 Feb 2021 13:49:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210126021331.1059933-1-ruansy.fnst@cn.fujitsu.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: B970C4CE6F74.AAECC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: IRHU5DJOBZX5XMCW2ZQIYKS5IJ46KHVG
X-Message-ID-Hash: IRHU5DJOBZX5XMCW2ZQIYKS5IJ46KHVG
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IRHU5DJOBZX5XMCW2ZQIYKS5IJ46KHVG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

cGluZw0KDQpPbiAyMDIxLzEvMjYg5LiK5Y2IMTA6MTMsIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4g
VGhlIHJldHVybiB2YWx1ZSBvZiByYW5nZV9wYXJzZSgpIGluZGljYXRlcyB0aGUgc2l6ZSB3aGVu
IGl0IGlzDQo+IHBvc2l0aXZlLiAgVGhlIGVycm9yIGNvZGUgc2hvdWxkIGJlIG5lZ2F0aXZlLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBjbi5mdWppdHN1
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9kYXgvYnVzLmMgfCAyICstDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9kYXgvYnVzLmMgYi9kcml2ZXJzL2RheC9idXMuYw0KPiBpbmRleCA3MzdiMjA3Yzll
MzAuLjMwMDM1NThjMWE4YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kYXgvYnVzLmMNCj4gKysr
IGIvZHJpdmVycy9kYXgvYnVzLmMNCj4gQEAgLTEwMzgsNyArMTAzOCw3IEBAIHN0YXRpYyBzc2l6
ZV90IHJhbmdlX3BhcnNlKGNvbnN0IGNoYXIgKm9wdCwgc2l6ZV90IGxlbiwgc3RydWN0IHJhbmdl
ICpyYW5nZSkNCj4gICB7DQo+ICAgCXVuc2lnbmVkIGxvbmcgbG9uZyBhZGRyID0gMDsNCj4gICAJ
Y2hhciAqc3RhcnQsICplbmQsICpzdHI7DQo+IC0Jc3NpemVfdCByYyA9IEVJTlZBTDsNCj4gKwlz
c2l6ZV90IHJjID0gLUVJTlZBTDsNCj4gICANCj4gICAJc3RyID0ga3N0cmR1cChvcHQsIEdGUF9L
RVJORUwpOw0KPiAgIAlpZiAoIXN0cikNCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4
LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
