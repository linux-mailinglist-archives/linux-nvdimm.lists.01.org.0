Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21511EDE96
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jun 2020 09:38:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA82100F226C;
	Thu,  4 Jun 2020 00:33:00 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 4AA19100F2247
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 00:32:57 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800";
   d="scan'208";a="93814171"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 04 Jun 2020 15:37:58 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id 4E00950A9975;
	Thu,  4 Jun 2020 15:37:58 +0800 (CST)
Received: from [10.167.225.141] (10.167.225.141) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 4 Jun 2020 15:37:58 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtSRkMgUEFUQ0ggMC84XSBkYXg6IEFkZCBh?=
 =?UTF-8?Q?_dax-rmap_tree_to_support_reflink?=
To: Dave Chinner <david@fromorbit.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
Date: Thu, 4 Jun 2020 15:37:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200428064318.GG2040@dread.disaster.area>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: 4E00950A9975.AB7F6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: MKKT6ZMA7KCDFZ7W6LECQEGPN65FLT5I
X-Message-ID-Hash: MKKT6ZMA7KCDFZ7W6LECQEGPN65FLT5I
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MKKT6ZMA7KCDFZ7W6LECQEGPN65FLT5I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvNC8yOCDkuIvljYgyOjQzLCBEYXZlIENoaW5uZXIgd3JvdGU6DQo+IE9uIFR1
ZSwgQXByIDI4LCAyMDIwIGF0IDA2OjA5OjQ3QU0gKzAwMDAsIFJ1YW4sIFNoaXlhbmcgd3JvdGU6
DQo+Pg0KPj4g5ZyoIDIwMjAvNC8yNyAyMDoyODozNiwgIk1hdHRoZXcgV2lsY294IiA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4g5YaZ6YGTOg0KPj4NCj4+PiBPbiBNb24sIEFwciAyNywgMjAyMCBhdCAw
NDo0Nzo0MlBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+Pj4+ICAgVGhpcyBwYXRjaHNl
dCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBzaGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9y
DQo+Pj4+ICAgZnNkYXguDQo+Pj4+DQo+Pj4+ICAgSW4gb3JkZXIgdG8gdHJhY2sgbXVsdGlwbGUg
bWFwcGluZ3MgYW5kIGluZGV4ZXMgb24gb25lIHBhZ2UsIEkNCj4+Pj4gICBpbnRyb2R1Y2VkIGEg
ZGF4LXJtYXAgcmItdHJlZSB0byBtYW5hZ2UgdGhlIHJlbGF0aW9uc2hpcC4gIEEgZGF4IGVudHJ5
DQo+Pj4+ICAgd2lsbCBiZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJlZC4g
IEF0IHRoZSBzZWNvbmQgdGltZSB3ZQ0KPj4+PiAgIGFzc29jaWF0ZSB0aGlzIGVudHJ5LCB3ZSBj
cmVhdGUgdGhpcyByYi10cmVlIGFuZCBzdG9yZSBpdHMgcm9vdCBpbg0KPj4+PiAgIHBhZ2UtPnBy
aXZhdGUobm90IHVzZWQgaW4gZnNkYXgpLiAgSW5zZXJ0ICgtPm1hcHBpbmcsIC0+aW5kZXgpIHdo
ZW4NCj4+Pj4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0ZSBpdCB3aGVuIGRheF9k
aXNhc3NvY2lhdGVfZW50cnkoKS4NCj4+Pg0KPj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHRyYWNr
IGFsbCBvZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJIHdvdWxkDQo+Pj4gaGF2ZSB0aG91
Z2h0IGEgcGVyLWV4dGVudCBiYXNpcyB3YXMgbW9yZSB1c2VmdWwuICBFc3NlbnRpYWxseSwgY3Jl
YXRlDQo+Pj4gYSBuZXcgYWRkcmVzc19zcGFjZSBmb3IgZWFjaCBzaGFyZWQgZXh0ZW50LiAgUGVy
IHBhZ2UganVzdCBzZWVtcyBsaWtlDQo+Pj4gYSBodWdlIG92ZXJoZWFkLg0KPj4+DQo+PiBQZXIt
ZXh0ZW50IHRyYWNraW5nIGlzIGEgbmljZSBpZGVhIGZvciBtZS4gIEkgaGF2ZW4ndCB0aG91Z2h0
IG9mIGl0DQo+PiB5ZXQuLi4NCj4+DQo+PiBCdXQgdGhlIGV4dGVudCBpbmZvIGlzIG1haW50YWlu
ZWQgYnkgZmlsZXN5c3RlbS4gIEkgdGhpbmsgd2UgbmVlZCBhIHdheQ0KPj4gdG8gb2J0YWluIHRo
aXMgaW5mbyBmcm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0DQo+
PiBjb21wbGljYXRlZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiANCj4gVGhhdCdzIHdo
eSBJIHdhbnQgdGhlIC11c2VyIG9mIHRoaXMgYXNzb2NpYXRpb24tIHRvIGRvIGEgZmlsZXN5c3Rl
bQ0KPiBjYWxsb3V0IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2ZSB0cmFja2luZyBp
bmZyYXN0cnVjdHVyZS4NCj4gVGhlIGZpbGVzeXN0ZW0gY2FuIGRvIGFuIGVmZmljaWVudCwgb24t
ZGVtYW5kIHJldmVyc2UgbWFwcGluZyBsb29rdXANCj4gZnJvbSBpdCdzIG93biBleHRlbnQgdHJh
Y2tpbmcgaW5mcmFzdHJ1Y3R1cmUsIGFuZCB0aGVyZSdzIHplcm8NCj4gcnVudGltZSBvdmVyaGVh
ZCB3aGVuIHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2VudC4NCg0KSGkgRGF2ZSwNCg0KSSByYW4g
aW50byBzb21lIGRpZmZpY3VsdGllcyB3aGVuIHRyeWluZyB0byBpbXBsZW1lbnQgdGhlIHBlci1l
eHRlbnQgDQpybWFwIHRyYWNraW5nLiAgU28sIEkgcmUtcmVhZCB5b3VyIGNvbW1lbnRzIGFuZCBm
b3VuZCB0aGF0IEkgd2FzIA0KbWlzdW5kZXJzdGFuZGluZyB3aGF0IHlvdSBkZXNjcmliZWQgaGVy
ZS4NCg0KSSB0aGluayB3aGF0IHlvdSBtZWFuIGlzOiB3ZSBkb24ndCBuZWVkIHRoZSBpbi1tZW1v
cnkgZGF4LXJtYXAgdHJhY2tpbmcgDQpub3cuICBKdXN0IGFzayB0aGUgRlMgZm9yIHRoZSBvd25l
cidzIGluZm9ybWF0aW9uIHRoYXQgYXNzb2NpYXRlIHdpdGggDQpvbmUgcGFnZSB3aGVuIG1lbW9y
eS1mYWlsdXJlLiAgU28sIHRoZSBwZXItcGFnZSAoZXZlbiBwZXItZXh0ZW50KSANCmRheC1ybWFw
IGlzIG5lZWRsZXNzIGluIHRoaXMgY2FzZS4gIElzIHRoaXMgcmlnaHQ/DQoNCkJhc2VkIG9uIHRo
aXMsIHdlIG9ubHkgbmVlZCB0byBzdG9yZSB0aGUgZXh0ZW50IGluZm9ybWF0aW9uIG9mIGEgZnNk
YXggDQpwYWdlIGluIGl0cyAtPm1hcHBpbmcgKGJ5IHNlYXJjaGluZyBmcm9tIEZTKS4gIFRoZW4g
b2J0YWluIHRoZSBvd25lcnMgb2YgDQp0aGlzIHBhZ2UgKGFsc28gYnkgc2VhcmNoaW5nIGZyb20g
RlMpIHdoZW4gbWVtb3J5LWZhaWx1cmUgb3Igb3RoZXIgcm1hcCANCmNhc2Ugb2NjdXJzLg0KDQpT
bywgYSBmc2RheCBwYWdlIGlzIG5vIGxvbmdlciBhc3NvY2lhdGVkIHdpdGggYSBzcGVjaWZpYyBm
aWxlLCBidXQgd2l0aCANCmEgRlMob3IgdGhlIHBtZW0gZGV2aWNlKS4gIEkgdGhpbmsgaXQncyBl
YXNpZXIgdG8gdW5kZXJzdGFuZCBhbmQgaW1wbGVtZW50Lg0KDQoNCi0tDQpUaGFua3MsDQpSdWFu
IFNoaXlhbmcuDQo+IA0KPiBBdCB0aGUgbW9tZW50LCB0aGlzICJkYXggYXNzb2NpYXRpb24iIGlz
IHVzZWQgdG8gInJlcG9ydCIgYSBzdG9yYWdlDQo+IG1lZGlhIGVycm9yIGRpcmVjdGx5IHRvIHVz
ZXJzcGFjZS4gSSBzYXkgInJlcG9ydCIgYmVjYXVzZSB3aGF0IGl0DQo+IGRvZXMgaXMga2lsbCB1
c2Vyc3BhY2UgcHJvY2Vzc2VzIGRlYWQuIFRoZSBzdG9yYWdlIG1lZGlhIGVycm9yDQo+IGFjdHVh
bGx5IG5lZWRzIHRvIGJlIHJlcG9ydGVkIHRvIHRoZSBvd25lciBvZiB0aGUgc3RvcmFnZSBtZWRp
YSwNCj4gd2hpY2ggaW4gdGhlIGNhc2Ugb2YgRlMtREFYIGlzIHRoZSBmaWxlc3l0ZW0uDQo+IA0K
PiBUaGF0IHdheSB0aGUgZmlsZXN5c3RlbSBjYW4gdGhlbiBsb29rIHVwIGFsbCB0aGUgb3duZXJz
IG9mIHRoYXQgYmFkDQo+IG1lZGlhIHJhbmdlIChpLmUuIHRoZSBmaWxlc3lzdGVtIGJsb2NrIGl0
IGNvcnJlc3BvbmRzIHRvKSBhbmQgdGFrZQ0KPiBhcHByb3ByaWF0ZSBhY3Rpb24uIGUuZy4NCj4g
DQo+IC0gaWYgaXQgZmFsbHMgaW4gZmlsZXN5dGVtIG1ldGFkYXRhLCBzaHV0ZG93biB0aGUgZmls
ZXN5c3RlbQ0KPiAtIGlmIGl0IGZhbGxzIGluIHVzZXIgZGF0YSwgY2FsbCB0aGUgImtpbGwgdXNl
cnNwYWNlIGRlYWQiIHJvdXRpbmVzDQo+ICAgIGZvciBlYWNoIG1hcHBpbmcvaW5kZXggdHVwbGUg
dGhlIGZpbGVzeXN0ZW0gZmluZHMgZm9yIHRoZSBnaXZlbg0KPiAgICBMQkEgYWRkcmVzcyB0aGF0
IHRoZSBtZWRpYSBlcnJvciBvY2N1cnJlZC4NCj4gDQo+IFJpZ2h0IG5vdyBpZiB0aGUgbWVkaWEg
ZXJyb3IgaXMgaW4gZmlsZXN5c3RlbSBtZXRhZGF0YSwgdGhlDQo+IGZpbGVzeXN0ZW0gaXNuJ3Qg
ZXZlbiB0b2xkIGFib3V0IGl0LiBUaGUgZmlsZXN5c3RlbSBjYW4ndCBldmVuIHNodXQNCj4gZG93
biAtIHRoZSBlcnJvciBpcyBqdXN0IGRyb3BwZWQgb24gdGhlIGZsb29yIGFuZCBpdCB3b24ndCBi
ZSB1bnRpbA0KPiB0aGUgZmlsZXN5c3RlbSBuZXh0IHRyaWVzIHRvIHJlZmVyZW5jZSB0aGF0IG1l
dGFkYXRhIHRoYXQgd2Ugbm90aWNlDQo+IHRoZXJlIGlzIGFuIGlzc3VlLg0KPiANCj4gQ2hlZXJz
LA0KPiANCj4gRGF2ZS4NCj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
