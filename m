Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 252DC1EEF7E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 04:31:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 319FD100A22FA;
	Thu,  4 Jun 2020 19:26:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 306B5100A22F9
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 19:26:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800";
   d="scan'208";a="93872612"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jun 2020 10:31:16 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id BB1894BCC8B9;
	Fri,  5 Jun 2020 10:31:13 +0800 (CST)
Received: from [10.167.225.141] (10.167.225.141) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 5 Jun 2020 10:31:13 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtSRkMgUEFUQ0ggMC84XSBkYXg6IEFkZCBh?=
 =?UTF-8?Q?_dax-rmap_tree_to_support_reflink?=
To: Dave Chinner <david@fromorbit.com>, "Darrick J. Wong"
	<darrick.wong@oracle.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
 <20200604145107.GA1334206@magnolia>
 <20200605013023.GZ2040@dread.disaster.area>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <841a9dbb-daa7-3827-6bf9-664187e45a94@cn.fujitsu.com>
Date: Fri, 5 Jun 2020 10:30:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200605013023.GZ2040@dread.disaster.area>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: BB1894BCC8B9.AEB9F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: DWZREJPF5PPQBFKGD7PBNXRO4TF73VG2
X-Message-ID-Hash: DWZREJPF5PPQBFKGD7PBNXRO4TF73VG2
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DWZREJPF5PPQBFKGD7PBNXRO4TF73VG2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvNi81IOS4iuWNiDk6MzAsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gT24gVGh1
LCBKdW4gMDQsIDIwMjAgYXQgMDc6NTE6MDdBTSAtMDcwMCwgRGFycmljayBKLiBXb25nIHdyb3Rl
Og0KPj4gT24gVGh1LCBKdW4gMDQsIDIwMjAgYXQgMDM6Mzc6NDJQTSArMDgwMCwgUnVhbiBTaGl5
YW5nIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAyMDIwLzQvMjgg5LiL5Y2IMjo0MywgRGF2ZSBD
aGlubmVyIHdyb3RlOg0KPj4+PiBPbiBUdWUsIEFwciAyOCwgMjAyMCBhdCAwNjowOTo0N0FNICsw
MDAwLCBSdWFuLCBTaGl5YW5nIHdyb3RlOg0KPj4+Pj4NCj4+Pj4+IOWcqCAyMDIwLzQvMjcgMjA6
Mjg6MzYsICJNYXR0aGV3IFdpbGNveCIgPHdpbGx5QGluZnJhZGVhZC5vcmc+IOWGmemBkzoNCj4+
Pj4+DQo+Pj4+Pj4gT24gTW9uLCBBcHIgMjcsIDIwMjAgYXQgMDQ6NDc6NDJQTSArMDgwMCwgU2hp
eWFuZyBSdWFuIHdyb3RlOg0KPj4+Pj4+PiAgICBUaGlzIHBhdGNoc2V0IGlzIGEgdHJ5IHRvIHJl
c29sdmUgdGhlIHNoYXJlZCAncGFnZSBjYWNoZScgcHJvYmxlbSBmb3INCj4+Pj4+Pj4gICAgZnNk
YXguDQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgIEluIG9yZGVyIHRvIHRyYWNrIG11bHRpcGxlIG1hcHBp
bmdzIGFuZCBpbmRleGVzIG9uIG9uZSBwYWdlLCBJDQo+Pj4+Pj4+ICAgIGludHJvZHVjZWQgYSBk
YXgtcm1hcCByYi10cmVlIHRvIG1hbmFnZSB0aGUgcmVsYXRpb25zaGlwLiAgQSBkYXggZW50cnkN
Cj4+Pj4+Pj4gICAgd2lsbCBiZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJl
ZC4gIEF0IHRoZSBzZWNvbmQgdGltZSB3ZQ0KPj4+Pj4+PiAgICBhc3NvY2lhdGUgdGhpcyBlbnRy
eSwgd2UgY3JlYXRlIHRoaXMgcmItdHJlZSBhbmQgc3RvcmUgaXRzIHJvb3QgaW4NCj4+Pj4+Pj4g
ICAgcGFnZS0+cHJpdmF0ZShub3QgdXNlZCBpbiBmc2RheCkuICBJbnNlcnQgKC0+bWFwcGluZywg
LT5pbmRleCkgd2hlbg0KPj4+Pj4+PiAgICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0
ZSBpdCB3aGVuIGRheF9kaXNhc3NvY2lhdGVfZW50cnkoKS4NCj4+Pj4+Pg0KPj4+Pj4+IERvIHdl
IHJlYWxseSB3YW50IHRvIHRyYWNrIGFsbCBvZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJ
IHdvdWxkDQo+Pj4+Pj4gaGF2ZSB0aG91Z2h0IGEgcGVyLWV4dGVudCBiYXNpcyB3YXMgbW9yZSB1
c2VmdWwuICBFc3NlbnRpYWxseSwgY3JlYXRlDQo+Pj4+Pj4gYSBuZXcgYWRkcmVzc19zcGFjZSBm
b3IgZWFjaCBzaGFyZWQgZXh0ZW50LiAgUGVyIHBhZ2UganVzdCBzZWVtcyBsaWtlDQo+Pj4+Pj4g
YSBodWdlIG92ZXJoZWFkLg0KPj4+Pj4+DQo+Pj4+PiBQZXItZXh0ZW50IHRyYWNraW5nIGlzIGEg
bmljZSBpZGVhIGZvciBtZS4gIEkgaGF2ZW4ndCB0aG91Z2h0IG9mIGl0DQo+Pj4+PiB5ZXQuLi4N
Cj4+Pj4+DQo+Pj4+PiBCdXQgdGhlIGV4dGVudCBpbmZvIGlzIG1haW50YWluZWQgYnkgZmlsZXN5
c3RlbS4gIEkgdGhpbmsgd2UgbmVlZCBhIHdheQ0KPj4+Pj4gdG8gb2J0YWluIHRoaXMgaW5mbyBm
cm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0DQo+Pj4+PiBjb21w
bGljYXRlZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPj4+Pg0KPj4+PiBUaGF0J3Mgd2h5
IEkgd2FudCB0aGUgLXVzZXIgb2YgdGhpcyBhc3NvY2lhdGlvbi0gdG8gZG8gYSBmaWxlc3lzdGVt
DQo+Pj4+IGNhbGxvdXQgaW5zdGVhZCBvZiBrZWVwaW5nIGl0J3Mgb3duIG5haXZlIHRyYWNraW5n
IGluZnJhc3RydWN0dXJlLg0KPj4+PiBUaGUgZmlsZXN5c3RlbSBjYW4gZG8gYW4gZWZmaWNpZW50
LCBvbi1kZW1hbmQgcmV2ZXJzZSBtYXBwaW5nIGxvb2t1cA0KPj4+PiBmcm9tIGl0J3Mgb3duIGV4
dGVudCB0cmFja2luZyBpbmZyYXN0cnVjdHVyZSwgYW5kIHRoZXJlJ3MgemVybw0KPj4+PiBydW50
aW1lIG92ZXJoZWFkIHdoZW4gdGhlcmUgYXJlIG5vIGVycm9ycyBwcmVzZW50Lg0KPj4+DQo+Pj4g
SGkgRGF2ZSwNCj4+Pg0KPj4+IEkgcmFuIGludG8gc29tZSBkaWZmaWN1bHRpZXMgd2hlbiB0cnlp
bmcgdG8gaW1wbGVtZW50IHRoZSBwZXItZXh0ZW50IHJtYXANCj4+PiB0cmFja2luZy4gIFNvLCBJ
IHJlLXJlYWQgeW91ciBjb21tZW50cyBhbmQgZm91bmQgdGhhdCBJIHdhcyBtaXN1bmRlcnN0YW5k
aW5nDQo+Pj4gd2hhdCB5b3UgZGVzY3JpYmVkIGhlcmUuDQo+Pj4NCj4+PiBJIHRoaW5rIHdoYXQg
eW91IG1lYW4gaXM6IHdlIGRvbid0IG5lZWQgdGhlIGluLW1lbW9yeSBkYXgtcm1hcCB0cmFja2lu
ZyBub3cuDQo+Pj4gSnVzdCBhc2sgdGhlIEZTIGZvciB0aGUgb3duZXIncyBpbmZvcm1hdGlvbiB0
aGF0IGFzc29jaWF0ZSB3aXRoIG9uZSBwYWdlDQo+Pj4gd2hlbiBtZW1vcnktZmFpbHVyZS4gIFNv
LCB0aGUgcGVyLXBhZ2UgKGV2ZW4gcGVyLWV4dGVudCkgZGF4LXJtYXAgaXMNCj4+PiBuZWVkbGVz
cyBpbiB0aGlzIGNhc2UuICBJcyB0aGlzIHJpZ2h0Pw0KPj4NCj4+IFJpZ2h0LiAgWEZTIGFscmVh
ZHkgaGFzIGl0cyBvd24gcm1hcCB0cmVlLg0KPiANCj4gKm5vZCoNCj4gDQo+Pj4gQmFzZWQgb24g
dGhpcywgd2Ugb25seSBuZWVkIHRvIHN0b3JlIHRoZSBleHRlbnQgaW5mb3JtYXRpb24gb2YgYSBm
c2RheCBwYWdlDQo+Pj4gaW4gaXRzIC0+bWFwcGluZyAoYnkgc2VhcmNoaW5nIGZyb20gRlMpLiAg
VGhlbiBvYnRhaW4gdGhlIG93bmVycyBvZiB0aGlzDQo+Pj4gcGFnZSAoYWxzbyBieSBzZWFyY2hp
bmcgZnJvbSBGUykgd2hlbiBtZW1vcnktZmFpbHVyZSBvciBvdGhlciBybWFwIGNhc2UNCj4+PiBv
Y2N1cnMuDQo+Pg0KPj4gSSBkb24ndCBldmVuIHRoaW5rIHlvdSBuZWVkIHRoYXQgbXVjaC4gIEFs
bCB5b3UgbmVlZCBpcyB0aGUgInBoeXNpY2FsIg0KPj4gb2Zmc2V0IG9mIHRoYXQgcGFnZSB3aXRo
aW4gdGhlIHBtZW0gZGV2aWNlIChlLmcuICd0aGlzIGlzIHRoZSAzMDd0aCA0aw0KPj4gcGFnZSA9
PSBvZmZzZXQgMTI1NzQ3MiBzaW5jZSB0aGUgc3RhcnQgb2YgL2Rldi9wbWVtMCcpIGFuZCB4ZnMg
Y2FuIGxvb2sNCj4+IHVwIHRoZSBvd25lciBvZiB0aGF0IHJhbmdlIG9mIHBoeXNpY2FsIHN0b3Jh
Z2UgYW5kIGRlYWwgd2l0aCBpdCBhcw0KPj4gbmVlZGVkLg0KPiANCj4gUmlnaHQuIElmIHdlIGhh
dmUgdGhlIGRheCBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBwYWdlIHRoYXQgaGFkDQo+IHRo
ZSBmYWlsdXJlLCB0aGVuIHdlIGNhbiBkZXRlcm1pbmUgdGhlIG9mZnNldCBvZiB0aGUgcGFnZSBp
bnRvIHRoZQ0KPiBibG9jayBkZXZpY2UgYWRkcmVzcyBzcGFjZSBhbmQgdGhhdCdzIGFsbCB3ZSBu
ZWVkIHRvIGZpbmQgdGhlIG93bmVyDQo+IG9mIHRoZSBwYWdlIGluIHRoZSBmaWxlc3lzdGVtLg0K
PiANCj4gTm90ZSB0aGF0IHRoZXJlIG1heSBhY3R1YWxseSBiZSBubyBvd25lciAtIHRoZSBwYWdl
IHRoYXQgaGFkIHRoZQ0KPiBmYXVsdCBtaWdodCBsYW5kIGluIGZyZWUgc3BhY2UsIGluIHdoaWNo
IGNhc2Ugd2UgY2FuIHNpbXBseSB6ZXJvDQo+IHRoZSBwYWdlIGFuZCBjbGVhciB0aGUgZXJyb3Iu
DQoNCk9LLiAgVGhhbmtzIGZvciBwb2ludGluZyBvdXQuDQoNCj4gDQo+Pj4gU28sIGEgZnNkYXgg
cGFnZSBpcyBubyBsb25nZXIgYXNzb2NpYXRlZCB3aXRoIGEgc3BlY2lmaWMgZmlsZSwgYnV0IHdp
dGggYQ0KPj4+IEZTKG9yIHRoZSBwbWVtIGRldmljZSkuICBJIHRoaW5rIGl0J3MgZWFzaWVyIHRv
IHVuZGVyc3RhbmQgYW5kIGltcGxlbWVudC4NCj4gDQo+IEVmZmVjdGl2ZWx5LCB5ZXMuIEJ1dCB3
ZSBzaG91bGRuJ3QgbmVlZCB0byBhY3R1YWxseSBhc3NvY2lhdGUgdGhlDQo+IHBhZ2Ugd2l0aCBh
bnl0aGluZyBhdCB0aGUgZmlsZXN5c3RlbSBsZXZlbCBiZWNhdXNlIGl0IGlzIGFscmVhZHkNCj4g
YXNzb2NpYXRlZCB3aXRoIGEgREFYIGRldmljZSBhdCBhIGxvd2VyIGxldmVsIHZpYSBhIGRldl9w
YWdlbWFwLg0KPiBUaGUgaGFyZHdhcmUgcGFnZSBmYXVsdCBhbHJlYWR5IHJ1bnMgdGhvdWdodCB0
aGlzIGNvZGUNCj4gbWVtb3J5X2ZhaWx1cmVfZGV2X3BhZ2VtYXAoKSBiZWZvcmUgaXQgZ2V0cyB0
byB0aGUgREFYIGNvZGUsIHNvDQo+IHJlYWxseSBhbGwgd2UgbmVlZCB0byBpcyBoYXZlIHRoYXQg
ZnVuY3Rpb24gcGFzcyB1cyB0aGUgcGFnZSwgb2Zmc2V0DQo+IGludG8gdGhlIGRldmljZSBhbmQs
IHNheSwgdGhlIHN0cnVjdCBkYXhfZGV2aWNlIGFzc29jaWF0ZWQgd2l0aCB0aGF0DQo+IHBhZ2Ug
c28gd2UgY2FuIGdldCB0byB0aGUgZmlsZXN5c3RlbSBzdXBlcmJsb2NrIHdlIGNhbiB0aGVuIHVz
ZSBmb3INCj4gcm1hcCBsb29rdXBzIG9uLi4uDQo+IA0KDQpPSy4gIEkgd2FzIGp1c3QgdGhpbmtp
bmcgYWJvdXQgaG93IGNhbiBJIGV4ZWN1dGUgdGhlIEZTIHJtYXAgc2VhcmNoIGZyb20gDQp0aGUg
bWVtb3J5LWZhaWx1cmUuICBUaGFua3MgYWdhaW4gZm9yIHBvaW50aW5nIG91dC4gOikNCg0KDQot
LQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0KDQo+IENoZWVycywNCj4gDQo+IERhdmUuDQo+IA0K
DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
