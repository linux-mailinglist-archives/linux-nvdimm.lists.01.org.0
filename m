Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298A1EEF0E
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jun 2020 03:30:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B3F9100A22F7;
	Thu,  4 Jun 2020 18:25:34 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.42; helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au [211.29.132.42])
	by ml01.01.org (Postfix) with ESMTP id 42A75100A22F6
	for <linux-nvdimm@lists.01.org>; Thu,  4 Jun 2020 18:25:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-124-177.pa.nsw.optusnet.com.au [49.180.124.177])
	by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id CA2095AB25B;
	Fri,  5 Jun 2020 11:30:32 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1jh1Bf-00026O-Bh; Fri, 05 Jun 2020 11:30:23 +1000
Date: Fri, 5 Jun 2020 11:30:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200605013023.GZ2040@dread.disaster.area>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <153e13e6-8685-fb0d-6bd3-bb553c06bf51@cn.fujitsu.com>
 <20200604145107.GA1334206@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200604145107.GA1334206@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
	a=k3aV/LVJup6ZGWgigO6cSA==:117 a=k3aV/LVJup6ZGWgigO6cSA==:17
	a=IkcTkHD0fZMA:10 a=nTHF0DUjJn0A:10 a=5KLPUuaC_9wA:10 a=JfrnYn6hAAAA:8
	a=7-415B0cAAAA:8 a=Ta0clAhtVI-YSBJ3DlQA:9 a=J8Q19hsgq330FmqU:21
	a=uNIap141QPGCy0-l:21 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
	a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: WVW2WB2AXZP63X6T6MDPXUY2XSHK6S55
X-Message-ID-Hash: WVW2WB2AXZP63X6T6MDPXUY2XSHK6S55
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WVW2WB2AXZP63X6T6MDPXUY2XSHK6S55/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBKdW4gMDQsIDIwMjAgYXQgMDc6NTE6MDdBTSAtMDcwMCwgRGFycmljayBKLiBXb25n
IHdyb3RlOg0KPiBPbiBUaHUsIEp1biAwNCwgMjAyMCBhdCAwMzozNzo0MlBNICswODAwLCBSdWFu
IFNoaXlhbmcgd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gT24gMjAyMC80LzI4IOS4i+WNiDI6NDMs
IERhdmUgQ2hpbm5lciB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0IDA2OjA5
OjQ3QU0gKzAwMDAsIFJ1YW4sIFNoaXlhbmcgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiDlnKgg
MjAyMC80LzI3IDIwOjI4OjM2LCAiTWF0dGhldyBXaWxjb3giIDx3aWxseUBpbmZyYWRlYWQub3Jn
PiDlhpnpgZM6DQo+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI3LCAyMDIwIGF0IDA0
OjQ3OjQyUE0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiA+ID4gPiA+ICAgVGhpcyBw
YXRjaHNldCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBzaGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2Js
ZW0gZm9yDQo+ID4gPiA+ID4gPiAgIGZzZGF4Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAg
IEluIG9yZGVyIHRvIHRyYWNrIG11bHRpcGxlIG1hcHBpbmdzIGFuZCBpbmRleGVzIG9uIG9uZSBw
YWdlLCBJDQo+ID4gPiA+ID4gPiAgIGludHJvZHVjZWQgYSBkYXgtcm1hcCByYi10cmVlIHRvIG1h
bmFnZSB0aGUgcmVsYXRpb25zaGlwLiAgQSBkYXggZW50cnkNCj4gPiA+ID4gPiA+ICAgd2lsbCBi
ZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJlZC4gIEF0IHRoZSBzZWNvbmQg
dGltZSB3ZQ0KPiA+ID4gPiA+ID4gICBhc3NvY2lhdGUgdGhpcyBlbnRyeSwgd2UgY3JlYXRlIHRo
aXMgcmItdHJlZSBhbmQgc3RvcmUgaXRzIHJvb3QgaW4NCj4gPiA+ID4gPiA+ICAgcGFnZS0+cHJp
dmF0ZShub3QgdXNlZCBpbiBmc2RheCkuICBJbnNlcnQgKC0+bWFwcGluZywgLT5pbmRleCkgd2hl
bg0KPiA+ID4gPiA+ID4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0ZSBpdCB3aGVu
IGRheF9kaXNhc3NvY2lhdGVfZW50cnkoKS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBEbyB3ZSBy
ZWFsbHkgd2FudCB0byB0cmFjayBhbGwgb2YgdGhpcyBvbiBhIHBlci1wYWdlIGJhc2lzPyAgSSB3
b3VsZA0KPiA+ID4gPiA+IGhhdmUgdGhvdWdodCBhIHBlci1leHRlbnQgYmFzaXMgd2FzIG1vcmUg
dXNlZnVsLiAgRXNzZW50aWFsbHksIGNyZWF0ZQ0KPiA+ID4gPiA+IGEgbmV3IGFkZHJlc3Nfc3Bh
Y2UgZm9yIGVhY2ggc2hhcmVkIGV4dGVudC4gIFBlciBwYWdlIGp1c3Qgc2VlbXMgbGlrZQ0KPiA+
ID4gPiA+IGEgaHVnZSBvdmVyaGVhZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gUGVyLWV4dGVudCB0
cmFja2luZyBpcyBhIG5pY2UgaWRlYSBmb3IgbWUuICBJIGhhdmVuJ3QgdGhvdWdodCBvZiBpdA0K
PiA+ID4gPiB5ZXQuLi4NCj4gPiA+ID4gDQo+ID4gPiA+IEJ1dCB0aGUgZXh0ZW50IGluZm8gaXMg
bWFpbnRhaW5lZCBieSBmaWxlc3lzdGVtLiAgSSB0aGluayB3ZSBuZWVkIGEgd2F5DQo+ID4gPiA+
IHRvIG9idGFpbiB0aGlzIGluZm8gZnJvbSBGUyB3aGVuIGFzc29jaWF0aW5nIGEgcGFnZS4gIE1h
eSBiZSBhIGJpdA0KPiA+ID4gPiBjb21wbGljYXRlZC4gIExldCBtZSB0aGluayBhYm91dCBpdC4u
Lg0KPiA+ID4gDQo+ID4gPiBUaGF0J3Mgd2h5IEkgd2FudCB0aGUgLXVzZXIgb2YgdGhpcyBhc3Nv
Y2lhdGlvbi0gdG8gZG8gYSBmaWxlc3lzdGVtDQo+ID4gPiBjYWxsb3V0IGluc3RlYWQgb2Yga2Vl
cGluZyBpdCdzIG93biBuYWl2ZSB0cmFja2luZyBpbmZyYXN0cnVjdHVyZS4NCj4gPiA+IFRoZSBm
aWxlc3lzdGVtIGNhbiBkbyBhbiBlZmZpY2llbnQsIG9uLWRlbWFuZCByZXZlcnNlIG1hcHBpbmcg
bG9va3VwDQo+ID4gPiBmcm9tIGl0J3Mgb3duIGV4dGVudCB0cmFja2luZyBpbmZyYXN0cnVjdHVy
ZSwgYW5kIHRoZXJlJ3MgemVybw0KPiA+ID4gcnVudGltZSBvdmVyaGVhZCB3aGVuIHRoZXJlIGFy
ZSBubyBlcnJvcnMgcHJlc2VudC4NCj4gPiANCj4gPiBIaSBEYXZlLA0KPiA+IA0KPiA+IEkgcmFu
IGludG8gc29tZSBkaWZmaWN1bHRpZXMgd2hlbiB0cnlpbmcgdG8gaW1wbGVtZW50IHRoZSBwZXIt
ZXh0ZW50IHJtYXANCj4gPiB0cmFja2luZy4gIFNvLCBJIHJlLXJlYWQgeW91ciBjb21tZW50cyBh
bmQgZm91bmQgdGhhdCBJIHdhcyBtaXN1bmRlcnN0YW5kaW5nDQo+ID4gd2hhdCB5b3UgZGVzY3Jp
YmVkIGhlcmUuDQo+ID4gDQo+ID4gSSB0aGluayB3aGF0IHlvdSBtZWFuIGlzOiB3ZSBkb24ndCBu
ZWVkIHRoZSBpbi1tZW1vcnkgZGF4LXJtYXAgdHJhY2tpbmcgbm93Lg0KPiA+IEp1c3QgYXNrIHRo
ZSBGUyBmb3IgdGhlIG93bmVyJ3MgaW5mb3JtYXRpb24gdGhhdCBhc3NvY2lhdGUgd2l0aCBvbmUg
cGFnZQ0KPiA+IHdoZW4gbWVtb3J5LWZhaWx1cmUuICBTbywgdGhlIHBlci1wYWdlIChldmVuIHBl
ci1leHRlbnQpIGRheC1ybWFwIGlzDQo+ID4gbmVlZGxlc3MgaW4gdGhpcyBjYXNlLiAgSXMgdGhp
cyByaWdodD8NCj4gDQo+IFJpZ2h0LiAgWEZTIGFscmVhZHkgaGFzIGl0cyBvd24gcm1hcCB0cmVl
Lg0KDQoqbm9kKg0KDQo+ID4gQmFzZWQgb24gdGhpcywgd2Ugb25seSBuZWVkIHRvIHN0b3JlIHRo
ZSBleHRlbnQgaW5mb3JtYXRpb24gb2YgYSBmc2RheCBwYWdlDQo+ID4gaW4gaXRzIC0+bWFwcGlu
ZyAoYnkgc2VhcmNoaW5nIGZyb20gRlMpLiAgVGhlbiBvYnRhaW4gdGhlIG93bmVycyBvZiB0aGlz
DQo+ID4gcGFnZSAoYWxzbyBieSBzZWFyY2hpbmcgZnJvbSBGUykgd2hlbiBtZW1vcnktZmFpbHVy
ZSBvciBvdGhlciBybWFwIGNhc2UNCj4gPiBvY2N1cnMuDQo+IA0KPiBJIGRvbid0IGV2ZW4gdGhp
bmsgeW91IG5lZWQgdGhhdCBtdWNoLiAgQWxsIHlvdSBuZWVkIGlzIHRoZSAicGh5c2ljYWwiDQo+
IG9mZnNldCBvZiB0aGF0IHBhZ2Ugd2l0aGluIHRoZSBwbWVtIGRldmljZSAoZS5nLiAndGhpcyBp
cyB0aGUgMzA3dGggNGsNCj4gcGFnZSA9PSBvZmZzZXQgMTI1NzQ3MiBzaW5jZSB0aGUgc3RhcnQg
b2YgL2Rldi9wbWVtMCcpIGFuZCB4ZnMgY2FuIGxvb2sNCj4gdXAgdGhlIG93bmVyIG9mIHRoYXQg
cmFuZ2Ugb2YgcGh5c2ljYWwgc3RvcmFnZSBhbmQgZGVhbCB3aXRoIGl0IGFzDQo+IG5lZWRlZC4N
Cg0KUmlnaHQuIElmIHdlIGhhdmUgdGhlIGRheCBkZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoZSBw
YWdlIHRoYXQgaGFkDQp0aGUgZmFpbHVyZSwgdGhlbiB3ZSBjYW4gZGV0ZXJtaW5lIHRoZSBvZmZz
ZXQgb2YgdGhlIHBhZ2UgaW50byB0aGUNCmJsb2NrIGRldmljZSBhZGRyZXNzIHNwYWNlIGFuZCB0
aGF0J3MgYWxsIHdlIG5lZWQgdG8gZmluZCB0aGUgb3duZXINCm9mIHRoZSBwYWdlIGluIHRoZSBm
aWxlc3lzdGVtLg0KDQpOb3RlIHRoYXQgdGhlcmUgbWF5IGFjdHVhbGx5IGJlIG5vIG93bmVyIC0g
dGhlIHBhZ2UgdGhhdCBoYWQgdGhlDQpmYXVsdCBtaWdodCBsYW5kIGluIGZyZWUgc3BhY2UsIGlu
IHdoaWNoIGNhc2Ugd2UgY2FuIHNpbXBseSB6ZXJvDQp0aGUgcGFnZSBhbmQgY2xlYXIgdGhlIGVy
cm9yLg0KDQo+ID4gU28sIGEgZnNkYXggcGFnZSBpcyBubyBsb25nZXIgYXNzb2NpYXRlZCB3aXRo
IGEgc3BlY2lmaWMgZmlsZSwgYnV0IHdpdGggYQ0KPiA+IEZTKG9yIHRoZSBwbWVtIGRldmljZSku
ICBJIHRoaW5rIGl0J3MgZWFzaWVyIHRvIHVuZGVyc3RhbmQgYW5kIGltcGxlbWVudC4NCg0KRWZm
ZWN0aXZlbHksIHllcy4gQnV0IHdlIHNob3VsZG4ndCBuZWVkIHRvIGFjdHVhbGx5IGFzc29jaWF0
ZSB0aGUNCnBhZ2Ugd2l0aCBhbnl0aGluZyBhdCB0aGUgZmlsZXN5c3RlbSBsZXZlbCBiZWNhdXNl
IGl0IGlzIGFscmVhZHkNCmFzc29jaWF0ZWQgd2l0aCBhIERBWCBkZXZpY2UgYXQgYSBsb3dlciBs
ZXZlbCB2aWEgYSBkZXZfcGFnZW1hcC4NClRoZSBoYXJkd2FyZSBwYWdlIGZhdWx0IGFscmVhZHkg
cnVucyB0aG91Z2h0IHRoaXMgY29kZQ0KbWVtb3J5X2ZhaWx1cmVfZGV2X3BhZ2VtYXAoKSBiZWZv
cmUgaXQgZ2V0cyB0byB0aGUgREFYIGNvZGUsIHNvDQpyZWFsbHkgYWxsIHdlIG5lZWQgdG8gaXMg
aGF2ZSB0aGF0IGZ1bmN0aW9uIHBhc3MgdXMgdGhlIHBhZ2UsIG9mZnNldA0KaW50byB0aGUgZGV2
aWNlIGFuZCwgc2F5LCB0aGUgc3RydWN0IGRheF9kZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoYXQN
CnBhZ2Ugc28gd2UgY2FuIGdldCB0byB0aGUgZmlsZXN5c3RlbSBzdXBlcmJsb2NrIHdlIGNhbiB0
aGVuIHVzZSBmb3INCnJtYXAgbG9va3VwcyBvbi4uLg0KDQpDaGVlcnMsDQoNCkRhdmUuDQotLSAN
CkRhdmUgQ2hpbm5lcg0KZGF2aWRAZnJvbW9yYml0LmNvbQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxp
bnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBs
aW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
