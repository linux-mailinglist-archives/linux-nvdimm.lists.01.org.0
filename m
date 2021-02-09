Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CB63145D0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Feb 2021 02:51:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C3B2100EBB67;
	Mon,  8 Feb 2021 17:51:13 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id D1F65100EBB61
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 17:51:07 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,163,1610380800";
   d="scan'208";a="104350489"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 09:51:05 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 3C2874CE6F87;
	Tue,  9 Feb 2021 09:51:04 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 09:51:02 +0800
Subject: Re: [PATCH 0/7] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Jan Kara <jack@suse.cz>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210208153911.GE30081@quack2.suse.cz>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <31e9aa48-7830-efe2-837f-e31cba2da491@cn.fujitsu.com>
Date: Tue, 9 Feb 2021 09:50:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208153911.GE30081@quack2.suse.cz>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 3C2874CE6F87.AC9A2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 6GNYXCDAH2T24VYHEL43HYFUZNCP7NFW
X-Message-ID-Hash: 6GNYXCDAH2T24VYHEL43HYFUZNCP7NFW
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6GNYXCDAH2T24VYHEL43HYFUZNCP7NFW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjEvMi84IOS4i+WNiDExOjM5LCBKYW4gS2FyYSB3cm90ZToNCj4gT24gTW9uIDA4
LTAyLTIxIDAxOjA5OjE3LCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+PiBUaGlzIHBhdGNoc2V0IGlz
IGF0dGVtcHQgdG8gYWRkIENvVyBzdXBwb3J0IGZvciBmc2RheCwgYW5kIHRha2UgWEZTLA0KPj4g
d2hpY2ggaGFzIGJvdGggcmVmbGluayBhbmQgZnNkYXggZmVhdHVyZSwgYXMgYW4gZXhhbXBsZS4N
Cj4+DQo+PiBPbmUgb2YgdGhlIGtleSBtZWNoYW5pc20gbmVlZCB0byBiZSBpbXBsZW1lbnRlZCBp
biBmc2RheCBpcyBDb1cuICBDb3B5DQo+PiB0aGUgZGF0YSBmcm9tIHNyY21hcCBiZWZvcmUgd2Ug
YWN0dWFsbHkgd3JpdGUgZGF0YSB0byB0aGUgZGVzdGFuY2UNCj4+IGlvbWFwLiAgQW5kIHdlIGp1
c3QgY29weSByYW5nZSBpbiB3aGljaCBkYXRhIHdvbid0IGJlIGNoYW5nZWQuDQo+Pg0KPj4gQW5v
dGhlciBtZWNoYW5pc20gaXMgcmFuZ2UgY29tcGFyaXNvbiAuICBJbiBwYWdlIGNhY2hlIGNhc2Us
IHJlYWRwYWdlKCkNCj4+IGlzIHVzZWQgdG8gbG9hZCBkYXRhIG9uIGRpc2sgdG8gcGFnZSBjYWNo
ZSBpbiBvcmRlciB0byBiZSBhYmxlIHRvDQo+PiBjb21wYXJlIGRhdGEuICBJbiBmc2RheCBjYXNl
LCByZWFkcGFnZSgpIGRvZXMgbm90IHdvcmsuICBTbywgd2UgbmVlZA0KPj4gYW5vdGhlciBjb21w
YXJlIGRhdGEgd2l0aCBkaXJlY3QgYWNjZXNzIHN1cHBvcnQuDQo+Pg0KPj4gV2l0aCB0aGUgdHdv
IG1lY2hhbmlzbSBpbXBsZW1lbnRlZCBpbiBmc2RheCwgd2UgYXJlIGFibGUgdG8gbWFrZSByZWZs
aW5rDQo+PiBhbmQgZnNkYXggd29yayB0b2dldGhlciBpbiBYRlMuDQo+Pg0KPj4gU29tZSBvZiB0
aGUgcGF0Y2hlcyBhcmUgcGlja2VkIHVwIGZyb20gR29sZHd5bidzIHBhdGNoc2V0LiAgSSBtYWRl
IHNvbWUNCj4+IGNoYW5nZXMgdG8gYWRhcHQgdG8gdGhpcyBwYXRjaHNldC4NCj4gDQo+IEhvdyBk
byB5b3UgZGVhbCB3aXRoIEhXUG9pc29uIGNvZGUgdHJ5aW5nIHRvIHJldmVyc2UtbWFwIHN0cnVj
dCBwYWdlIGJhY2sNCj4gdG8gaW5vZGUtb2Zmc2V0IHBhaXI/IFRoaXMgYWxzbyBuZWVkcyB0byBi
ZSBmaXhlZCBmb3IgcmVmbGluayB0byB3b3JrIHdpdGgNCj4gREFYLg0KPiANCg0KSSBoYXZlIHBv
c3RlZCB2MyBwYXRjaHNldCB0byBhZGQgcmV2ZXJzZS1tYXAgc3VwcG9ydCBmb3IgZGF4IHBhZ2Ug
DQp5ZXN0ZXJkYXkuICBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhpczoNCg0KICAgaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMjEvMi84LzM0Nw0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcu
DQoNCj4gCQkJCQkJCQlIb256YQ0KPiANCj4+DQo+PiAoUmViYXNlZCBvbiB2NS4xMCkNCj4+ID09
DQo+Pg0KPj4gU2hpeWFuZyBSdWFuICg3KToNCj4+ICAgIGZzZGF4OiBPdXRwdXQgYWRkcmVzcyBp
biBkYXhfaW9tYXBfcGZuKCkgYW5kIHJlbmFtZSBpdA0KPj4gICAgZnNkYXg6IEludHJvZHVjZSBk
YXhfY29weV9lZGdlcygpIGZvciBDb1cNCj4+ICAgIGZzZGF4OiBDb3B5IGRhdGEgYmVmb3JlIHdy
aXRlDQo+PiAgICBmc2RheDogUmVwbGFjZSBtbWFwIGVudHJ5IGluIGNhc2Ugb2YgQ29XDQo+PiAg
ICBmc2RheDogRGVkdXAgZmlsZSByYW5nZSB0byB1c2UgYSBjb21wYXJlIGZ1bmN0aW9uDQo+PiAg
ICBmcy94ZnM6IEhhbmRsZSBDb1cgZm9yIGZzZGF4IHdyaXRlKCkgcGF0aA0KPj4gICAgZnMveGZz
OiBBZGQgZGVkdXBlIHN1cHBvcnQgZm9yIGZzZGF4DQo+Pg0KPj4gICBmcy9idHJmcy9yZWZsaW5r
LmMgICAgIHwgICAzICstDQo+PiAgIGZzL2RheC5jICAgICAgICAgICAgICAgfCAxODggKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+ICAgZnMvb2NmczIvZmlsZS5j
ICAgICAgICB8ICAgMiArLQ0KPj4gICBmcy9yZW1hcF9yYW5nZS5jICAgICAgIHwgIDE0ICstLQ0K
Pj4gICBmcy94ZnMveGZzX2JtYXBfdXRpbC5jIHwgICA2ICstDQo+PiAgIGZzL3hmcy94ZnNfZmls
ZS5jICAgICAgfCAgMzAgKysrKysrLQ0KPj4gICBmcy94ZnMveGZzX2lub2RlLmMgICAgIHwgICA4
ICstDQo+PiAgIGZzL3hmcy94ZnNfaW5vZGUuaCAgICAgfCAgIDEgKw0KPj4gICBmcy94ZnMveGZz
X2lvbWFwLmMgICAgIHwgICAzICstDQo+PiAgIGZzL3hmcy94ZnNfaW9wcy5jICAgICAgfCAgMTEg
KystDQo+PiAgIGZzL3hmcy94ZnNfcmVmbGluay5jICAgfCAgMjMgKysrKy0NCj4+ICAgaW5jbHVk
ZS9saW51eC9kYXguaCAgICB8ICAgNSArKw0KPj4gICBpbmNsdWRlL2xpbnV4L2ZzLmggICAgIHwg
ICA5ICstDQo+PiAgIDEzIGZpbGVzIGNoYW5nZWQsIDI3MCBpbnNlcnRpb25zKCspLCAzMyBkZWxl
dGlvbnMoLSkNCj4+DQo+PiAtLSANCj4+IDIuMzAuMA0KPj4NCj4+DQo+Pg0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
