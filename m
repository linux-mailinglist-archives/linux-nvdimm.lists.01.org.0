Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2629249FF7
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 Aug 2020 15:30:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 271A612F414A1;
	Wed, 19 Aug 2020 06:30:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=huawei.com; envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BBDF132BCFF3
	for <linux-nvdimm@lists.01.org>; Wed, 19 Aug 2020 06:30:52 -0700 (PDT)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id C9E21510E0ACF87DB482;
	Wed, 19 Aug 2020 21:30:47 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 21:30:46 +0800
Subject: Re: [PATCH v2 0/4] bug fix and optimize for drivers/nvdimm
To: Markus Elfring <Markus.Elfring@web.de>, linux-nvdimm
	<linux-nvdimm@lists.01.org>
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <ce85d12b-f0bf-8cdd-0477-8ee87ff5a4c9@web.de>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6ae57740-afdf-d9fc-2f11-821de66fb357@huawei.com>
Date: Wed, 19 Aug 2020 21:30:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ce85d12b-f0bf-8cdd-0477-8ee87ff5a4c9@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Message-ID-Hash: L7KRND7YFIPAT4BFUF36P3NJKMG2YQ2D
X-Message-ID-Hash: L7KRND7YFIPAT4BFUF36P3NJKMG2YQ2D
X-MailFrom: thunder.leizhen@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/L7KRND7YFIPAT4BFUF36P3NJKMG2YQ2D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Transfer-Encoding: base64

DQoNCk9uIDgvMTkvMjAyMCA4OjIwIFBNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToNCj4+IHYxIC0t
PiB2MjoNCj4+IDEuIEFkZCBGaXhlcyBmb3IgUGF0Y2ggMS0yDQo+PiAyLiBTbGlnaHRseSBjaGFu
Z2UgdGhlIHN1YmplY3QgYW5kIGRlc2NyaXB0aW9uIG9mIFBhdGNoIDENCj4g4oCmDQo+PiAgIGxp
Ym52ZGltbTogZml4IG1lbW1vcnkgbGVha3MgaW4gb2ZfcG1lbS5jDQo+IOKApg0KPiANCj4gSSBz
dWdnZXN0IHRvIGF2b2lkIGEgdHlwbyBpbiBzdWNoIGEgcGF0Y2ggc3ViamVjdC4NCg0KT0ssIFRo
YW5rcyBmb3IgcmVtaW5kaW5nIG1lLg0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCj4gDQo+
IA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
