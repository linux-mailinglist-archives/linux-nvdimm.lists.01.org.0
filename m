Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AEE1EEF5C
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 04:12:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA0CA100A22F9;
	Thu,  4 Jun 2020 19:07:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 55D7F100A22F8
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 19:07:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.73,474,1583164800";
   d="scan'208";a="93871124"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Jun 2020 10:12:12 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
	by cn.fujitsu.com (Postfix) with ESMTP id DF8CC4BCC8A8;
	Fri,  5 Jun 2020 10:12:07 +0800 (CST)
Received: from [10.167.225.141] (10.167.225.141) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 5 Jun 2020 10:12:08 +0800
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IFtSRkMgUEFUQ0ggMC84XSBkYXg6IEFkZCBh?=
 =?UTF-8?Q?_dax-rmap_tree_to_support_reflink?=
To: "Darrick J. Wong" <darrick.wong@oracle.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
 <20200604145107.GA1334206@magnolia>
From: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <b9f3e089-476d-b31f-c2f2-0dfb8741b584@cn.fujitsu.com>
Date: Fri, 5 Jun 2020 10:11:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604145107.GA1334206@magnolia>
Content-Language: en-US
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: DF8CC4BCC8A8.AF5BC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: T2EF7PWON535IGRHEDBZYCHAIOA3XF4I
X-Message-ID-Hash: T2EF7PWON535IGRHEDBZYCHAIOA3XF4I
X-MailFrom: ruansy.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T2EF7PWON535IGRHEDBZYCHAIOA3XF4I/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

DQoNCk9uIDIwMjAvNi80IOS4i+WNiDEwOjUxLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IE9u
IFRodSwgSnVuIDA0LCAyMDIwIGF0IDAzOjM3OjQyUE0gKzA4MDAsIFJ1YW4gU2hpeWFuZyB3cm90
ZToNCj4+DQo+Pg0KPj4gT24gMjAyMC80LzI4IOS4i+WNiDI6NDMsIERhdmUgQ2hpbm5lciB3cm90
ZToNCj4+PiBPbiBUdWUsIEFwciAyOCwgMjAyMCBhdCAwNjowOTo0N0FNICswMDAwLCBSdWFuLCBT
aGl5YW5nIHdyb3RlOg0KPj4+Pg0KPj4+PiDlnKggMjAyMC80LzI3IDIwOjI4OjM2LCAiTWF0dGhl
dyBXaWxjb3giIDx3aWxseUBpbmZyYWRlYWQub3JnPiDlhpnpgZM6DQo+Pj4+DQo+Pj4+PiBPbiBN
b24sIEFwciAyNywgMjAyMCBhdCAwNDo0Nzo0MlBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6
DQo+Pj4+Pj4gICAgVGhpcyBwYXRjaHNldCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBzaGFyZWQg
J3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9yDQo+Pj4+Pj4gICAgZnNkYXguDQo+Pj4+Pj4NCj4+Pj4+
PiAgICBJbiBvcmRlciB0byB0cmFjayBtdWx0aXBsZSBtYXBwaW5ncyBhbmQgaW5kZXhlcyBvbiBv
bmUgcGFnZSwgSQ0KPj4+Pj4+ICAgIGludHJvZHVjZWQgYSBkYXgtcm1hcCByYi10cmVlIHRvIG1h
bmFnZSB0aGUgcmVsYXRpb25zaGlwLiAgQSBkYXggZW50cnkNCj4+Pj4+PiAgICB3aWxsIGJlIGFz
c29jaWF0ZWQgbW9yZSB0aGFuIG9uY2UgaWYgaXMgc2hhcmVkLiAgQXQgdGhlIHNlY29uZCB0aW1l
IHdlDQo+Pj4+Pj4gICAgYXNzb2NpYXRlIHRoaXMgZW50cnksIHdlIGNyZWF0ZSB0aGlzIHJiLXRy
ZWUgYW5kIHN0b3JlIGl0cyByb290IGluDQo+Pj4+Pj4gICAgcGFnZS0+cHJpdmF0ZShub3QgdXNl
ZCBpbiBmc2RheCkuICBJbnNlcnQgKC0+bWFwcGluZywgLT5pbmRleCkgd2hlbg0KPj4+Pj4+ICAg
IGRheF9hc3NvY2lhdGVfZW50cnkoKSBhbmQgZGVsZXRlIGl0IHdoZW4gZGF4X2Rpc2Fzc29jaWF0
ZV9lbnRyeSgpLg0KPj4+Pj4NCj4+Pj4+IERvIHdlIHJlYWxseSB3YW50IHRvIHRyYWNrIGFsbCBv
ZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJIHdvdWxkDQo+Pj4+PiBoYXZlIHRob3VnaHQg
YSBwZXItZXh0ZW50IGJhc2lzIHdhcyBtb3JlIHVzZWZ1bC4gIEVzc2VudGlhbGx5LCBjcmVhdGUN
Cj4+Pj4+IGEgbmV3IGFkZHJlc3Nfc3BhY2UgZm9yIGVhY2ggc2hhcmVkIGV4dGVudC4gIFBlciBw
YWdlIGp1c3Qgc2VlbXMgbGlrZQ0KPj4+Pj4gYSBodWdlIG92ZXJoZWFkLg0KPj4+Pj4NCj4+Pj4g
UGVyLWV4dGVudCB0cmFja2luZyBpcyBhIG5pY2UgaWRlYSBmb3IgbWUuICBJIGhhdmVuJ3QgdGhv
dWdodCBvZiBpdA0KPj4+PiB5ZXQuLi4NCj4+Pj4NCj4+Pj4gQnV0IHRoZSBleHRlbnQgaW5mbyBp
cyBtYWludGFpbmVkIGJ5IGZpbGVzeXN0ZW0uICBJIHRoaW5rIHdlIG5lZWQgYSB3YXkNCj4+Pj4g
dG8gb2J0YWluIHRoaXMgaW5mbyBmcm9tIEZTIHdoZW4gYXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5
IGJlIGEgYml0DQo+Pj4+IGNvbXBsaWNhdGVkLiAgTGV0IG1lIHRoaW5rIGFib3V0IGl0Li4uDQo+
Pj4NCj4+PiBUaGF0J3Mgd2h5IEkgd2FudCB0aGUgLXVzZXIgb2YgdGhpcyBhc3NvY2lhdGlvbi0g
dG8gZG8gYSBmaWxlc3lzdGVtDQo+Pj4gY2FsbG91dCBpbnN0ZWFkIG9mIGtlZXBpbmcgaXQncyBv
d24gbmFpdmUgdHJhY2tpbmcgaW5mcmFzdHJ1Y3R1cmUuDQo+Pj4gVGhlIGZpbGVzeXN0ZW0gY2Fu
IGRvIGFuIGVmZmljaWVudCwgb24tZGVtYW5kIHJldmVyc2UgbWFwcGluZyBsb29rdXANCj4+PiBm
cm9tIGl0J3Mgb3duIGV4dGVudCB0cmFja2luZyBpbmZyYXN0cnVjdHVyZSwgYW5kIHRoZXJlJ3Mg
emVybw0KPj4+IHJ1bnRpbWUgb3ZlcmhlYWQgd2hlbiB0aGVyZSBhcmUgbm8gZXJyb3JzIHByZXNl
bnQuDQo+Pg0KPj4gSGkgRGF2ZSwNCj4+DQo+PiBJIHJhbiBpbnRvIHNvbWUgZGlmZmljdWx0aWVz
IHdoZW4gdHJ5aW5nIHRvIGltcGxlbWVudCB0aGUgcGVyLWV4dGVudCBybWFwDQo+PiB0cmFja2lu
Zy4gIFNvLCBJIHJlLXJlYWQgeW91ciBjb21tZW50cyBhbmQgZm91bmQgdGhhdCBJIHdhcyBtaXN1
bmRlcnN0YW5kaW5nDQo+PiB3aGF0IHlvdSBkZXNjcmliZWQgaGVyZS4NCj4+DQo+PiBJIHRoaW5r
IHdoYXQgeW91IG1lYW4gaXM6IHdlIGRvbid0IG5lZWQgdGhlIGluLW1lbW9yeSBkYXgtcm1hcCB0
cmFja2luZyBub3cuDQo+PiBKdXN0IGFzayB0aGUgRlMgZm9yIHRoZSBvd25lcidzIGluZm9ybWF0
aW9uIHRoYXQgYXNzb2NpYXRlIHdpdGggb25lIHBhZ2UNCj4+IHdoZW4gbWVtb3J5LWZhaWx1cmUu
ICBTbywgdGhlIHBlci1wYWdlIChldmVuIHBlci1leHRlbnQpIGRheC1ybWFwIGlzDQo+PiBuZWVk
bGVzcyBpbiB0aGlzIGNhc2UuICBJcyB0aGlzIHJpZ2h0Pw0KPiANCj4gUmlnaHQuICBYRlMgYWxy
ZWFkeSBoYXMgaXRzIG93biBybWFwIHRyZWUuDQo+IA0KPj4gQmFzZWQgb24gdGhpcywgd2Ugb25s
eSBuZWVkIHRvIHN0b3JlIHRoZSBleHRlbnQgaW5mb3JtYXRpb24gb2YgYSBmc2RheCBwYWdlDQo+
PiBpbiBpdHMgLT5tYXBwaW5nIChieSBzZWFyY2hpbmcgZnJvbSBGUykuICBUaGVuIG9idGFpbiB0
aGUgb3duZXJzIG9mIHRoaXMNCj4+IHBhZ2UgKGFsc28gYnkgc2VhcmNoaW5nIGZyb20gRlMpIHdo
ZW4gbWVtb3J5LWZhaWx1cmUgb3Igb3RoZXIgcm1hcCBjYXNlDQo+PiBvY2N1cnMuDQo+IA0KPiBJ
IGRvbid0IGV2ZW4gdGhpbmsgeW91IG5lZWQgdGhhdCBtdWNoLiAgQWxsIHlvdSBuZWVkIGlzIHRo
ZSAicGh5c2ljYWwiDQo+IG9mZnNldCBvZiB0aGF0IHBhZ2Ugd2l0aGluIHRoZSBwbWVtIGRldmlj
ZSAoZS5nLiAndGhpcyBpcyB0aGUgMzA3dGggNGsNCj4gcGFnZSA9PSBvZmZzZXQgMTI1NzQ3MiBz
aW5jZSB0aGUgc3RhcnQgb2YgL2Rldi9wbWVtMCcpIGFuZCB4ZnMgY2FuIGxvb2sNCj4gdXAgdGhl
IG93bmVyIG9mIHRoYXQgcmFuZ2Ugb2YgcGh5c2ljYWwgc3RvcmFnZSBhbmQgZGVhbCB3aXRoIGl0
IGFzDQo+IG5lZWRlZC4NCg0KWWVzLCBJIHRoaW5rIHNvLg0KDQo+IA0KPj4gU28sIGEgZnNkYXgg
cGFnZSBpcyBubyBsb25nZXIgYXNzb2NpYXRlZCB3aXRoIGEgc3BlY2lmaWMgZmlsZSwgYnV0IHdp
dGggYQ0KPj4gRlMob3IgdGhlIHBtZW0gZGV2aWNlKS4gIEkgdGhpbmsgaXQncyBlYXNpZXIgdG8g
dW5kZXJzdGFuZCBhbmQgaW1wbGVtZW50Lg0KPiANCj4gWWVzLiAgSSBhbHNvIHN1c3BlY3QgdGhp
cyB3aWxsIGJlIG5lY2Vzc2FyeSB0byBzdXBwb3J0IHJlZmxpbmsuLi4NCj4gDQo+IC0tRA0KDQpP
SywgVGhhbmsgeW91IHZlcnkgbXVjaC4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0K
DQo+IA0KPj4NCj4+IC0tDQo+PiBUaGFua3MsDQo+PiBSdWFuIFNoaXlhbmcuDQo+Pj4NCj4+PiBB
dCB0aGUgbW9tZW50LCB0aGlzICJkYXggYXNzb2NpYXRpb24iIGlzIHVzZWQgdG8gInJlcG9ydCIg
YSBzdG9yYWdlDQo+Pj4gbWVkaWEgZXJyb3IgZGlyZWN0bHkgdG8gdXNlcnNwYWNlLiBJIHNheSAi
cmVwb3J0IiBiZWNhdXNlIHdoYXQgaXQNCj4+PiBkb2VzIGlzIGtpbGwgdXNlcnNwYWNlIHByb2Nl
c3NlcyBkZWFkLiBUaGUgc3RvcmFnZSBtZWRpYSBlcnJvcg0KPj4+IGFjdHVhbGx5IG5lZWRzIHRv
IGJlIHJlcG9ydGVkIHRvIHRoZSBvd25lciBvZiB0aGUgc3RvcmFnZSBtZWRpYSwNCj4+PiB3aGlj
aCBpbiB0aGUgY2FzZSBvZiBGUy1EQVggaXMgdGhlIGZpbGVzeXRlbS4NCj4+Pg0KPj4+IFRoYXQg
d2F5IHRoZSBmaWxlc3lzdGVtIGNhbiB0aGVuIGxvb2sgdXAgYWxsIHRoZSBvd25lcnMgb2YgdGhh
dCBiYWQNCj4+PiBtZWRpYSByYW5nZSAoaS5lLiB0aGUgZmlsZXN5c3RlbSBibG9jayBpdCBjb3Jy
ZXNwb25kcyB0bykgYW5kIHRha2UNCj4+PiBhcHByb3ByaWF0ZSBhY3Rpb24uIGUuZy4NCj4+Pg0K
Pj4+IC0gaWYgaXQgZmFsbHMgaW4gZmlsZXN5dGVtIG1ldGFkYXRhLCBzaHV0ZG93biB0aGUgZmls
ZXN5c3RlbQ0KPj4+IC0gaWYgaXQgZmFsbHMgaW4gdXNlciBkYXRhLCBjYWxsIHRoZSAia2lsbCB1
c2Vyc3BhY2UgZGVhZCIgcm91dGluZXMNCj4+PiAgICAgZm9yIGVhY2ggbWFwcGluZy9pbmRleCB0
dXBsZSB0aGUgZmlsZXN5c3RlbSBmaW5kcyBmb3IgdGhlIGdpdmVuDQo+Pj4gICAgIExCQSBhZGRy
ZXNzIHRoYXQgdGhlIG1lZGlhIGVycm9yIG9jY3VycmVkLg0KPj4+DQo+Pj4gUmlnaHQgbm93IGlm
IHRoZSBtZWRpYSBlcnJvciBpcyBpbiBmaWxlc3lzdGVtIG1ldGFkYXRhLCB0aGUNCj4+PiBmaWxl
c3lzdGVtIGlzbid0IGV2ZW4gdG9sZCBhYm91dCBpdC4gVGhlIGZpbGVzeXN0ZW0gY2FuJ3QgZXZl
biBzaHV0DQo+Pj4gZG93biAtIHRoZSBlcnJvciBpcyBqdXN0IGRyb3BwZWQgb24gdGhlIGZsb29y
IGFuZCBpdCB3b24ndCBiZSB1bnRpbA0KPj4+IHRoZSBmaWxlc3lzdGVtIG5leHQgdHJpZXMgdG8g
cmVmZXJlbmNlIHRoYXQgbWV0YWRhdGEgdGhhdCB3ZSBub3RpY2UNCj4+PiB0aGVyZSBpcyBhbiBp
c3N1ZS4NCj4+Pg0KPj4+IENoZWVycywNCj4+Pg0KPj4+IERhdmUuDQo+Pj4NCj4+DQo+Pg0KPiAN
Cj4gDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1
bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5v
cmcK
