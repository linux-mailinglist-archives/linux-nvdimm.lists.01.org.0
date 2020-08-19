Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9324A01A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 15:35:32 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 059D112F414B8;
	Wed, 19 Aug 2020 06:35:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2900912F414B5
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:35:28 -0700 (PDT)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 0BD7B6E4E73F1F088A22;
	Wed, 19 Aug 2020 21:35:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 21:35:21 +0800
Subject: Re: [PATCH v2 3/4] libnvdimm/bus: simplify walk_to_nvdimm_bus()
To: Markus Elfring <Markus.Elfring@web.de>, <linux-nvdimm@lists.01.org>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-4-thunder.leizhen@huawei.com>
 <ff1333cb-9917-6a2c-4454-325d161d8650@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ee3b1538-b19f-5dd9-d023-90eca4bfd9b7@huawei.com>
Date: Wed, 19 Aug 2020 21:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ff1333cb-9917-6a2c-4454-325d161d8650@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: YFV3A2YET3ARE3PA5TFZR33BGKDWUHTQ
X-Message-ID-Hash: YFV3A2YET3ARE3PA5TFZR33BGKDWUHTQ
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Oliver@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YFV3A2YET3ARE3PA5TFZR33BGKDWUHTQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQoNCk9uIDgvMTkvMjAyMCA4OjQwIFBNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToNCj4+IOKApiB3
aGVuIGlzX252ZGltbV9idXMoZGV2KSBzdWNjZXNzZWQuDQo+IA0KPiBJIGltYWdpbmUgdGhhdCB0
aGF0IGFuIG90aGVyIHdvcmRpbmcgd2lsbCBiZSBtb3JlIGFwcHJvcHJpYXRlIGhlcmUuDQoNCk9L
LCBJIHdpbGwgcmV3cml0ZSBpdC4NCg0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQo+IA0KPiAN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
