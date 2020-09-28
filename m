Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A427A52A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Sep 2020 03:19:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 87F9F13E2CA99;
	Sun, 27 Sep 2020 18:19:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.32; helo=huawei.com; envelope-from=yanaijie@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 934A413E2CA96
	for <linux-nvdimm@lists.01.org>; Sun, 27 Sep 2020 18:19:06 -0700 (PDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 49DBDFEEC1A57C9430DB;
	Mon, 28 Sep 2020 09:19:04 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 09:18:56 +0800
Subject: Re: [PATCH] device-dax: include bus.h in super.c
From: Jason Yan <yanaijie@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
References: <20200925091806.1860663-1-yanaijie@huawei.com>
 <CAPcyv4jgCp4_rSWs2SipiR3Jhz2jbSGWuLjtPExGDdTOEztAXA@mail.gmail.com>
 <306e724d-00f1-648c-9018-0ec1f3be9da4@huawei.com>
Message-ID: <c08024ea-425e-b286-c84a-d25f95acd291@huawei.com>
Date: Mon, 28 Sep 2020 09:18:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <306e724d-00f1-648c-9018-0ec1f3be9da4@huawei.com>
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
Message-ID-Hash: S7MTA5KW6TSSIOTQFBVQFWOF76D5QHPF
X-Message-ID-Hash: S7MTA5KW6TSSIOTQFBVQFWOF76D5QHPF
X-MailFrom: yanaijie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S7MTA5KW6TSSIOTQFBVQFWOF76D5QHPF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCuWcqCAyMDIwLzkvMjggOToxNSwgSmFzb24gWWFuIOWGmemBkzoNCj4gSGkgRGFu77yMDQo+
IA0KPiDlnKggMjAyMC85LzI2IDI6MjQsIERhbiBXaWxsaWFtcyDlhpnpgZM6DQo+PiBPbiBGcmks
IFNlcCAyNSwgMjAyMCBhdCAyOjE3IEFNIEphc29uIFlhbiA8eWFuYWlqaWVAaHVhd2VpLmNvbT4g
d3JvdGU6DQo+Pj4NCj4+PiBUaGlzIGFkZHJlc3NlcyB0aGUgZm9sbG93aW5nIHNwYXJzZSB3YXJu
aW5nOg0KPj4+DQo+Pj4gZHJpdmVycy9kYXgvc3VwZXIuYzo0NTI6Njogd2FybmluZzogc3ltYm9s
ICdydW5fZGF4JyB3YXMgbm90IGRlY2xhcmVkLg0KPj4+IFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+
Pg0KPj4gcnVuX2RheCgpIGlzIGEgY29yZSBoZWxwZXIgZGVmaW5lZCBpbiBkcml2ZXJzL2RheC9z
dXBlci5jIHRoYXQgaXMNCj4+IG1lYW50IHRvIGhpZGUgdGhlIGRlZmluaXRpb24gb2YgJ3N0cnVj
dCBkYXhfZGV2aWNlJyBmcm9tIHRoZSB3aWRlcg0KPj4ga2VybmVsIHRoYXQgZG9lcyBub3QgbmVl
ZCB0byBwb2tlIGludG8gaXRzIGludGVybmFscy4gVGhlcmUncyBhbHNvIG5vDQo+PiBuZWVkIGZv
ciBkcml2ZXJzL2RheC9zdXBlci5jIHRvIGJlIGdpdmVuIGtub3dsZWRnZSBvZiBvdGhlciBjb3Jl
DQo+PiBkZXRhaWxzIHRoYXQgYXJlIGNvbnRhaW5lZCB3aXRoaW4gYnVzLmguIFNvLCBJIHRoaW5r
IHRoaXMgcGF0Y2gNCj4+IHByb3ZpZGVzIG5vIHZhbHVlIGFuZCBnb2VzIGFnYWluc3QgdGhlIHBy
aW5jaXBsZSBvZiBsZWFzdCBwcml2aWxlZ2UNCj4+IChodHRwczovL2VuLndpa2lwZWRpYS5vcmcv
d2lraS9QcmluY2lwbGVfb2ZfbGVhc3RfcHJpdmlsZWdlKQ0KPj4NCj4gDQo+IFNvcnJ5IEkgZGlk
IG5vdCBnZXQgd2hhdCB5b3UgbWVhbi4gSSBvbmx5IGluY2x1ZGVkIHRoZSBpbnRlcm5hbCBidXMu
aA0KPiB3aGljaCBpcyBkcml2ZXJzL2RheC9idXMuaC4gV2h5IGlzIHRoaXMgYWZmZWN0aW5nIHRo
ZSBvdGhlciBwYXJ0IG9mIHRoZQ0KPiBrZXJuZWw/DQo+IA0KDQpBbmQgSSBkaWQgdGhhdCBiZWNh
dXNlIG9mIHJ1bl9kYXgoKSBpcyBkZWNsYXJlZCBpbiB0aGUgZHJpdmVycy9kYXgvYnVzLmggDQph
bmQgZGVmaW5lZCBpbiBkcml2ZXJzL2RheC9zdXBlci5jLiBUaGUgaXMgdG90YWxseSBhbiBpbnRl
cm5hbCBjaGFuZ2UgaW4gDQpkYXggYW5kIGNhbiBmaXggdGhlIHNwYXJzZSB3YXJuaW5nLg0KDQo+
IFRoYW5rcywNCj4gSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMu
MDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZl
QGxpc3RzLjAxLm9yZwo=
