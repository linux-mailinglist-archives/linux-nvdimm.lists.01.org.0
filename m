Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AE924921F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 03:08:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45DAA13093FEA;
	Tue, 18 Aug 2020 18:08:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D555613093FE8
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 18:08:05 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 55D2713F051FD3159F59;
	Wed, 19 Aug 2020 09:08:01 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 09:07:59 +0800
Subject: Re: [PATCH 1/3] libnvdimm: Fix memory leaks in of_pmem.c
To: Markus Elfring <Markus.Elfring@web.de>, <linux-nvdimm@lists.01.org>
References: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <fdbd9d2d-2e5d-8190-5d7c-eec5c4cdadbb@huawei.com>
Date: Wed, 19 Aug 2020 09:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5ca9f6e3-38d7-fc65-5010-22c992ecf851@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: DEHC4SLPZFSMI77AO26WVS4U2YHVFST3
X-Message-ID-Hash: DEHC4SLPZFSMI77AO26WVS4U2YHVFST3
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Oliver@ml01.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DEHC4SLPZFSMI77AO26WVS4U2YHVFST3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQoNCk9uIDgvMTkvMjAyMCAzOjAwIEFNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToNCj4+IFRoZSBt
ZW1vcnkgcHJpdi0+YnVzX2Rlc2MucHJvdmlkZXJfbmFtZSBhbGxvY2F0ZWQgYnkga3N0cmR1cCgp
IHNob3VsZCBiZQ0KPj4gZnJlZWQuDQo+IA0KPiAqIFdvdWxkIGFuIGltcGVyYXRpdmUgd29yZGlu
ZyBiZSBwcmVmZXJyZWQgZm9yIHRoZSBjaGFuZ2UgZGVzY3JpcHRpb24/DQo+IA0KPiAqIEkgcHJv
cG9zZSB0byBhZGQgdGhlIHRhZyDigJxGaXhlc+KAnSB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQpU
aGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxsIGFkZCBpdCBpbiB2Mi4NCg0KRml4ZXM6
IDQ5YmRkYzczZDE1YyAoImxpYm52ZGltbS9vZl9wbWVtOiBQcm92aWRlIGEgdW5pcXVlIG5hbWUg
Zm9yIGJ1cyBwcm92aWRlciIpDQoNCg0KPiANCj4gUmVnYXJkcywNCj4gTWFya3VzDQo+IA0KPiAN
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNj
cmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
