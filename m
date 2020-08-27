Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258B253C5B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Aug 2020 05:54:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 36D6312527FA5;
	Wed, 26 Aug 2020 20:54:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.191; helo=huawei.com; envelope-from=yuehaibing@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CA78C12527FA3
	for <linux-nvdimm@lists.01.org>; Wed, 26 Aug 2020 20:54:11 -0700 (PDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 55A1047872667942D41D;
	Thu, 27 Aug 2020 11:54:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 11:54:05 +0800
Subject: Re: [PATCH] libnvdimm/e820: Fix build error without MEMORY_HOTPLUG
To: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<dave.jiang@intel.com>, <ira.weiny@intel.com>, <mingo@kernel.org>
References: <20200826121800.732-1-yuehaibing@huawei.com>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <c1b6d720-513d-10de-364f-46c7f5b750fc@huawei.com>
Date: Thu, 27 Aug 2020 11:54:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200826121800.732-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Message-ID-Hash: HKMQQGCVOCCZTG6BYOYCFOFVQ7YOLQYT
X-Message-ID-Hash: HKMQQGCVOCCZTG6BYOYCFOFVQ7YOLQYT
X-MailFrom: yuehaibing@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HKMQQGCVOCCZTG6BYOYCFOFVQ7YOLQYT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

UGxzIGlnbm9yZSB0aGlzDQoNCkl0IGhhcyBiZSBmaXhlZCBpbiBjb21taXQgZGJiODczM2FiYjFj
ICgibW0tbWVtb3J5X2hvdHBsdWctaW50cm9kdWNlLWRlZmF1bHQtcGh5c190b190YXJnZXRfbm9k
ZS1pbXBsZW1lbnRhdGlvbi1maXgiKQ0KDQpPbiAyMDIwLzgvMjYgMjA6MTgsIFl1ZUhhaWJpbmcg
d3JvdGU6DQo+IElmIE1FTU9SWV9IT1RQTFVHIGlzIG4sIGJ1aWxkIGZhaWxzOg0KPiANCj4gZHJp
dmVycy9udmRpbW0vZTgyMC5jOiBJbiBmdW5jdGlvbiDigJhlODIwX3JlZ2lzdGVyX29uZeKAmToN
Cj4gZHJpdmVycy9udmRpbW0vZTgyMC5jOjI0OjEyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24g4oCYcGh5c190b190YXJnZXRfbm9kZeKAmTsgZGlkIHlvdSBtZWFuIOKA
mHNldF9wYWdlX25vZGXigJk/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9u
XQ0KPiAgIGludCBuaWQgPSBwaHlzX3RvX3RhcmdldF9ub2RlKHJlcy0+c3RhcnQpOw0KPiAgICAg
ICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgICAgICAgIHNldF9wYWdlX25vZGUN
Cj4gDQo+IEZpeGVzOiA3YjI3YTg2MjJmODAgKCJsaWJudmRpbW0vZTgyMDogUmV0cmlldmUgYW5k
IHBvcHVsYXRlIGNvcnJlY3QgJ3RhcmdldF9ub2RlJyBpbmZvIikNCj4gU2lnbmVkLW9mZi1ieTog
WXVlSGFpYmluZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbnZk
aW1tL2U4MjAuYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL2U4MjAuYyBiL2RyaXZlcnMvbnZk
aW1tL2U4MjAuYw0KPiBpbmRleCA0Y2QxOGJlOWQwZTkuLmM3NDFmMDI5ZjIxNSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9udmRpbW0vZTgyMC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2U4MjAu
Yw0KPiBAQCAtMTcsNiArMTcsMTMgQEAgc3RhdGljIGludCBlODIwX3BtZW1fcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gKyNp
Zm5kZWYgQ09ORklHX01FTU9SWV9IT1RQTFVHDQo+ICtzdGF0aWMgaW5saW5lIGludCBwaHlzX3Rv
X3RhcmdldF9ub2RlKHU2NCBzdGFydCkNCj4gK3sNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKyNl
bmRpZg0KPiArDQo+ICBzdGF0aWMgaW50IGU4MjBfcmVnaXN0ZXJfb25lKHN0cnVjdCByZXNvdXJj
ZSAqcmVzLCB2b2lkICpkYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBuZF9yZWdpb25fZGVzYyBuZHJf
ZGVzYzsNCj4gDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
