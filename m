Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A8B27A528
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 03:15:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3621513E2CA83;
	Sun, 27 Sep 2020 18:15:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C6C713E2CA81
	for <linux-nvdimm@lists.01.org>; Sun, 27 Sep 2020 18:15:13 -0700 (PDT)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 15C96901B7B793B28AB4;
	Mon, 28 Sep 2020 09:15:11 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 09:15:02 +0800
Subject: Re: [PATCH] device-dax: include bus.h in super.c
To: Dan Williams <dan.j.williams@intel.com>
References: <20200925091806.1860663-1-yanaijie@huawei.com>
 <CAPcyv4jgCp4_rSWs2SipiR3Jhz2jbSGWuLjtPExGDdTOEztAXA@mail.gmail.com>
From: Jason Yan <yanaijie@huawei.com>
Message-ID: <306e724d-00f1-648c-9018-0ec1f3be9da4@huawei.com>
Date: Mon, 28 Sep 2020 09:15:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jgCp4_rSWs2SipiR3Jhz2jbSGWuLjtPExGDdTOEztAXA@mail.gmail.com>
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
Message-ID-Hash: KV4UP6KDMIEUVPYJGFETNYQ3LNQJJPIQ
X-Message-ID-Hash: KV4UP6KDMIEUVPYJGFETNYQ3LNQJJPIQ
X-MailFrom: yanaijie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KV4UP6KDMIEUVPYJGFETNYQ3LNQJJPIQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGkgRGFu77yMDQoNCuWcqCAyMDIwLzkvMjYgMjoyNCwgRGFuIFdpbGxpYW1zIOWGmemBkzoNCj4g
T24gRnJpLCBTZXAgMjUsIDIwMjAgYXQgMjoxNyBBTSBKYXNvbiBZYW4gPHlhbmFpamllQGh1YXdl
aS5jb20+IHdyb3RlOg0KPj4NCj4+IFRoaXMgYWRkcmVzc2VzIHRoZSBmb2xsb3dpbmcgc3BhcnNl
IHdhcm5pbmc6DQo+Pg0KPj4gZHJpdmVycy9kYXgvc3VwZXIuYzo0NTI6Njogd2FybmluZzogc3lt
Ym9sICdydW5fZGF4JyB3YXMgbm90IGRlY2xhcmVkLg0KPj4gU2hvdWxkIGl0IGJlIHN0YXRpYz8N
Cj4gDQo+IHJ1bl9kYXgoKSBpcyBhIGNvcmUgaGVscGVyIGRlZmluZWQgaW4gZHJpdmVycy9kYXgv
c3VwZXIuYyB0aGF0IGlzDQo+IG1lYW50IHRvIGhpZGUgdGhlIGRlZmluaXRpb24gb2YgJ3N0cnVj
dCBkYXhfZGV2aWNlJyBmcm9tIHRoZSB3aWRlcg0KPiBrZXJuZWwgdGhhdCBkb2VzIG5vdCBuZWVk
IHRvIHBva2UgaW50byBpdHMgaW50ZXJuYWxzLiBUaGVyZSdzIGFsc28gbm8NCj4gbmVlZCBmb3Ig
ZHJpdmVycy9kYXgvc3VwZXIuYyB0byBiZSBnaXZlbiBrbm93bGVkZ2Ugb2Ygb3RoZXIgY29yZQ0K
PiBkZXRhaWxzIHRoYXQgYXJlIGNvbnRhaW5lZCB3aXRoaW4gYnVzLmguIFNvLCBJIHRoaW5rIHRo
aXMgcGF0Y2gNCj4gcHJvdmlkZXMgbm8gdmFsdWUgYW5kIGdvZXMgYWdhaW5zdCB0aGUgcHJpbmNp
cGxlIG9mIGxlYXN0IHByaXZpbGVnZQ0KPiAoaHR0cHM6Ly9lbi53aWtpcGVkaWEub3JnL3dpa2kv
UHJpbmNpcGxlX29mX2xlYXN0X3ByaXZpbGVnZSkNCj4gDQoNClNvcnJ5IEkgZGlkIG5vdCBnZXQg
d2hhdCB5b3UgbWVhbi4gSSBvbmx5IGluY2x1ZGVkIHRoZSBpbnRlcm5hbCBidXMuaA0Kd2hpY2gg
aXMgZHJpdmVycy9kYXgvYnVzLmguIFdoeSBpcyB0aGlzIGFmZmVjdGluZyB0aGUgb3RoZXIgcGFy
dCBvZiB0aGUNCmtlcm5lbD8NCg0KVGhhbmtzLA0KSmFzb24KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
