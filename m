Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2960F1BB62E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 08:09:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28BD1110B9ADC;
	Mon, 27 Apr 2020 23:09:00 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 83825110B9ADA
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 23:08:56 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,326,1583164800";
   d="scan'208";a="90612535"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Apr 2020 14:09:50 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id A9EE050A9991;
	Tue, 28 Apr 2020 14:09:48 +0800 (CST)
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 28 Apr 2020 14:09:47 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::15e2:f6f4:7314:fd88])
 by G08CNEXMBPEKD05.g08.fujitsu.local ([fe80::15e2:f6f4:7314:fd88%14]) with
 mapi id 15.00.1497.000; Tue, 28 Apr 2020 14:09:47 +0800
From: "Ruan, Shiyang" <ruansy.fnst@cn.fujitsu.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: =?utf-8?B?5Zue5aSNOiBSZTogW1JGQyBQQVRDSCAwLzhdIGRheDogQWRkIGEgZGF4LXJt?=
 =?utf-8?Q?ap_tree_to_support_reflink?=
Thread-Topic: Re: [RFC PATCH 0/8] dax: Add a dax-rmap tree to support reflink
Thread-Index: AQHWHHCrvTehP1uFMkqHUwaMK6beO6iMX8EAgAEofYA=
Date: Tue, 28 Apr 2020 06:09:47 +0000
Message-ID: <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
In-Reply-To: <20200427122836.GD29705@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.167.225.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <431D96282EC2FB4DA394D352951FF28C@fujitsu.local>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: A9EE050A9991.AE63C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: J3SQ6VFD67QPEWX3ZYTXE2TVZQQJEJCV
X-Message-ID-Hash: J3SQ6VFD67QPEWX3ZYTXE2TVZQQJEJCV
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: "Ruan, Shiyang" <ruansy.fnst@cn.fujitsu.com>
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J3SQ6VFD67QPEWX3ZYTXE2TVZQQJEJCV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQrlnKggMjAyMC80LzI3IDIwOjI4OjM2LCAiTWF0dGhldyBXaWxjb3giIDx3aWxseUBpbmZyYWRl
YWQub3JnPiDlhpnpgZM6DQoNCj5PbiBNb24sIEFwciAyNywgMjAyMCBhdCAwNDo0Nzo0MlBNICsw
ODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+PiAgVGhpcyBwYXRjaHNldCBpcyBhIHRyeSB0byBy
ZXNvbHZlIHRoZSBzaGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9yDQo+PiAgZnNkYXguDQo+
Pg0KPj4gIEluIG9yZGVyIHRvIHRyYWNrIG11bHRpcGxlIG1hcHBpbmdzIGFuZCBpbmRleGVzIG9u
IG9uZSBwYWdlLCBJDQo+PiAgaW50cm9kdWNlZCBhIGRheC1ybWFwIHJiLXRyZWUgdG8gbWFuYWdl
IHRoZSByZWxhdGlvbnNoaXAuICBBIGRheCBlbnRyeQ0KPj4gIHdpbGwgYmUgYXNzb2NpYXRlZCBt
b3JlIHRoYW4gb25jZSBpZiBpcyBzaGFyZWQuICBBdCB0aGUgc2Vjb25kIHRpbWUgd2UNCj4+ICBh
c3NvY2lhdGUgdGhpcyBlbnRyeSwgd2UgY3JlYXRlIHRoaXMgcmItdHJlZSBhbmQgc3RvcmUgaXRz
IHJvb3QgaW4NCj4+ICBwYWdlLT5wcml2YXRlKG5vdCB1c2VkIGluIGZzZGF4KS4gIEluc2VydCAo
LT5tYXBwaW5nLCAtPmluZGV4KSB3aGVuDQo+PiAgZGF4X2Fzc29jaWF0ZV9lbnRyeSgpIGFuZCBk
ZWxldGUgaXQgd2hlbiBkYXhfZGlzYXNzb2NpYXRlX2VudHJ5KCkuDQo+DQo+RG8gd2UgcmVhbGx5
IHdhbnQgdG8gdHJhY2sgYWxsIG9mIHRoaXMgb24gYSBwZXItcGFnZSBiYXNpcz8gIEkgd291bGQN
Cj5oYXZlIHRob3VnaHQgYSBwZXItZXh0ZW50IGJhc2lzIHdhcyBtb3JlIHVzZWZ1bC4gIEVzc2Vu
dGlhbGx5LCBjcmVhdGUNCj5hIG5ldyBhZGRyZXNzX3NwYWNlIGZvciBlYWNoIHNoYXJlZCBleHRl
bnQuICBQZXIgcGFnZSBqdXN0IHNlZW1zIGxpa2UNCj5hIGh1Z2Ugb3ZlcmhlYWQuDQo+DQpQZXIt
ZXh0ZW50IHRyYWNraW5nIGlzIGEgbmljZSBpZGVhIGZvciBtZS4gIEkgaGF2ZW4ndCB0aG91Z2h0
IG9mIGl0IA0KeWV0Li4uDQoNCkJ1dCB0aGUgZXh0ZW50IGluZm8gaXMgbWFpbnRhaW5lZCBieSBm
aWxlc3lzdGVtLiAgSSB0aGluayB3ZSBuZWVkIGEgd2F5IA0KdG8gb2J0YWluIHRoaXMgaW5mbyBm
cm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0IA0KY29tcGxpY2F0
ZWQuICBMZXQgbWUgdGhpbmsgYWJvdXQgaXQuLi4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5
YW5nLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
