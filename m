Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7921BBC5B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 13:24:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D245A110BD429;
	Tue, 28 Apr 2020 04:23:52 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.246; helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
	by ml01.01.org (Postfix) with ESMTP id CB5B21007B7BB
	for <linux-nvdimm@lists.01.org>; Tue, 28 Apr 2020 04:23:49 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C431082144B;
	Tue, 28 Apr 2020 21:24:42 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1jTOLx-0004Ur-Rg; Tue, 28 Apr 2020 21:24:41 +1000
Date: Tue, 28 Apr 2020 21:24:41 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428112441.GH2040@dread.disaster.area>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
 <20200428111636.GK29705@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428111636.GK29705@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
	a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
	a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=5KLPUuaC_9wA:10 a=JfrnYn6hAAAA:8
	a=7-415B0cAAAA:8 a=cxSUJwBmEXFeedIZ3DoA:9 a=QEXdDO2ut3YA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: 3YYA6JQNWJUQPG5XHMUM7WZW7BTMAVP4
X-Message-ID-Hash: 3YYA6JQNWJUQPG5XHMUM7WZW7BTMAVP4
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3YYA6JQNWJUQPG5XHMUM7WZW7BTMAVP4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDQ6MTY6MzZBTSAtMDcwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0IDA1OjMyOjQxUE0gKzA4MDAsIFJ1YW4g
U2hpeWFuZyB3cm90ZToNCj4gPiBPbiAyMDIwLzQvMjgg5LiL5Y2IMjo0MywgRGF2ZSBDaGlubmVy
IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDY6MDk6NDdBTSArMDAwMCwg
UnVhbiwgU2hpeWFuZyB3cm90ZToNCj4gPiA+ID4g5ZyoIDIwMjAvNC8yNyAyMDoyODozNiwgIk1h
dHRoZXcgV2lsY294IiA8d2lsbHlAaW5mcmFkZWFkLm9yZz4g5YaZ6YGTOg0KPiA+ID4gPiA+IE9u
IE1vbiwgQXByIDI3LCAyMDIwIGF0IDA0OjQ3OjQyUE0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90
ZToNCj4gPiA+ID4gPiA+ICAgVGhpcyBwYXRjaHNldCBpcyBhIHRyeSB0byByZXNvbHZlIHRoZSBz
aGFyZWQgJ3BhZ2UgY2FjaGUnIHByb2JsZW0gZm9yDQo+ID4gPiA+ID4gPiAgIGZzZGF4Lg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiAgIEluIG9yZGVyIHRvIHRyYWNrIG11bHRpcGxlIG1hcHBp
bmdzIGFuZCBpbmRleGVzIG9uIG9uZSBwYWdlLCBJDQo+ID4gPiA+ID4gPiAgIGludHJvZHVjZWQg
YSBkYXgtcm1hcCByYi10cmVlIHRvIG1hbmFnZSB0aGUgcmVsYXRpb25zaGlwLiAgQSBkYXggZW50
cnkNCj4gPiA+ID4gPiA+ICAgd2lsbCBiZSBhc3NvY2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlz
IHNoYXJlZC4gIEF0IHRoZSBzZWNvbmQgdGltZSB3ZQ0KPiA+ID4gPiA+ID4gICBhc3NvY2lhdGUg
dGhpcyBlbnRyeSwgd2UgY3JlYXRlIHRoaXMgcmItdHJlZSBhbmQgc3RvcmUgaXRzIHJvb3QgaW4N
Cj4gPiA+ID4gPiA+ICAgcGFnZS0+cHJpdmF0ZShub3QgdXNlZCBpbiBmc2RheCkuICBJbnNlcnQg
KC0+bWFwcGluZywgLT5pbmRleCkgd2hlbg0KPiA+ID4gPiA+ID4gICBkYXhfYXNzb2NpYXRlX2Vu
dHJ5KCkgYW5kIGRlbGV0ZSBpdCB3aGVuIGRheF9kaXNhc3NvY2lhdGVfZW50cnkoKS4NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBEbyB3ZSByZWFsbHkgd2FudCB0byB0cmFjayBhbGwgb2YgdGhpcyBv
biBhIHBlci1wYWdlIGJhc2lzPyAgSSB3b3VsZA0KPiA+ID4gPiA+IGhhdmUgdGhvdWdodCBhIHBl
ci1leHRlbnQgYmFzaXMgd2FzIG1vcmUgdXNlZnVsLiAgRXNzZW50aWFsbHksIGNyZWF0ZQ0KPiA+
ID4gPiA+IGEgbmV3IGFkZHJlc3Nfc3BhY2UgZm9yIGVhY2ggc2hhcmVkIGV4dGVudC4gIFBlciBw
YWdlIGp1c3Qgc2VlbXMgbGlrZQ0KPiA+ID4gPiA+IGEgaHVnZSBvdmVyaGVhZC4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gUGVyLWV4dGVudCB0cmFja2luZyBpcyBhIG5pY2UgaWRlYSBmb3IgbWUuICBJ
IGhhdmVuJ3QgdGhvdWdodCBvZiBpdA0KPiA+ID4gPiB5ZXQuLi4NCj4gPiA+ID4gDQo+ID4gPiA+
IEJ1dCB0aGUgZXh0ZW50IGluZm8gaXMgbWFpbnRhaW5lZCBieSBmaWxlc3lzdGVtLiAgSSB0aGlu
ayB3ZSBuZWVkIGEgd2F5DQo+ID4gPiA+IHRvIG9idGFpbiB0aGlzIGluZm8gZnJvbSBGUyB3aGVu
IGFzc29jaWF0aW5nIGEgcGFnZS4gIE1heSBiZSBhIGJpdA0KPiA+ID4gPiBjb21wbGljYXRlZC4g
IExldCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiA+ID4gDQo+ID4gPiBUaGF0J3Mgd2h5IEkgd2Fu
dCB0aGUgLXVzZXIgb2YgdGhpcyBhc3NvY2lhdGlvbi0gdG8gZG8gYSBmaWxlc3lzdGVtDQo+ID4g
PiBjYWxsb3V0IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2ZSB0cmFja2luZyBpbmZy
YXN0cnVjdHVyZS4NCj4gPiA+IFRoZSBmaWxlc3lzdGVtIGNhbiBkbyBhbiBlZmZpY2llbnQsIG9u
LWRlbWFuZCByZXZlcnNlIG1hcHBpbmcgbG9va3VwDQo+ID4gPiBmcm9tIGl0J3Mgb3duIGV4dGVu
dCB0cmFja2luZyBpbmZyYXN0cnVjdHVyZSwgYW5kIHRoZXJlJ3MgemVybw0KPiA+ID4gcnVudGlt
ZSBvdmVyaGVhZCB3aGVuIHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2VudC4NCj4gPiA+IA0KPiA+
ID4gQXQgdGhlIG1vbWVudCwgdGhpcyAiZGF4IGFzc29jaWF0aW9uIiBpcyB1c2VkIHRvICJyZXBv
cnQiIGEgc3RvcmFnZQ0KPiA+ID4gbWVkaWEgZXJyb3IgZGlyZWN0bHkgdG8gdXNlcnNwYWNlLiBJ
IHNheSAicmVwb3J0IiBiZWNhdXNlIHdoYXQgaXQNCj4gPiA+IGRvZXMgaXMga2lsbCB1c2Vyc3Bh
Y2UgcHJvY2Vzc2VzIGRlYWQuIFRoZSBzdG9yYWdlIG1lZGlhIGVycm9yDQo+ID4gPiBhY3R1YWxs
eSBuZWVkcyB0byBiZSByZXBvcnRlZCB0byB0aGUgb3duZXIgb2YgdGhlIHN0b3JhZ2UgbWVkaWEs
DQo+ID4gPiB3aGljaCBpbiB0aGUgY2FzZSBvZiBGUy1EQVggaXMgdGhlIGZpbGVzeXRlbS4NCj4g
PiANCj4gPiBVbmRlcnN0b29kLg0KPiA+IA0KPiA+IEJUVywgdGhpcyBpcyB0aGUgdXNhZ2UgaW4g
bWVtb3J5LWZhaWx1cmUsIHNvIHdoYXQgYWJvdXQgcm1hcD8gIEkgaGF2ZSBub3QNCj4gPiBmb3Vu
ZCBob3cgdG8gdXNlIHRoaXMgdHJhY2tpbmcgaW4gcm1hcC4gIERvIHlvdSBoYXZlIGFueSBpZGVh
cz8NCj4gPiANCj4gPiA+IA0KPiA+ID4gVGhhdCB3YXkgdGhlIGZpbGVzeXN0ZW0gY2FuIHRoZW4g
bG9vayB1cCBhbGwgdGhlIG93bmVycyBvZiB0aGF0IGJhZA0KPiA+ID4gbWVkaWEgcmFuZ2UgKGku
ZS4gdGhlIGZpbGVzeXN0ZW0gYmxvY2sgaXQgY29ycmVzcG9uZHMgdG8pIGFuZCB0YWtlDQo+ID4g
PiBhcHByb3ByaWF0ZSBhY3Rpb24uIGUuZy4NCj4gPiANCj4gPiBJIHRyaWVkIHdyaXRpbmcgYSBm
dW5jdGlvbiB0byBsb29rIHVwIGFsbCB0aGUgb3duZXJzJyBpbmZvIG9mIG9uZSBibG9jayBpbg0K
PiA+IHhmcyBmb3IgbWVtb3J5LWZhaWx1cmUgdXNlLiAgSXQgd2FzIGRyb3BwZWQgaW4gdGhpcyBw
YXRjaHNldCBiZWNhdXNlIEkgZm91bmQNCj4gPiBvdXQgdGhhdCB0aGlzIGxvb2t1cCBmdW5jdGlv
biBuZWVkcyAncm1hcGJ0JyB0byBiZSBlbmFibGVkIHdoZW4gbWtmcy4gIEJ1dA0KPiA+IGJ5IGRl
ZmF1bHQsIHJtYXBidCBpcyBkaXNhYmxlZC4gIEkgYW0gbm90IHN1cmUgaWYgaXQgbWF0dGVycy4u
Lg0KPiANCj4gSSdtIHByZXR0eSBzdXJlIHlvdSBjYW4ndCBoYXZlIHNoYXJlZCBleHRlbnRzIG9u
IGFuIFhGUyBmaWxlc3lzdGVtIGlmIHlvdQ0KPiBfZG9uJ3RfIGhhdmUgdGhlIHJtYXBidCBmZWF0
dXJlIGVuYWJsZWQuICBJIG1lYW4sIHRoYXQncyB3aHkgaXQgZXhpc3RzLg0KDQpZb3UncmUgY29u
ZnVzaW5nIHJlZmxpbmsgd2l0aCBybWFwLiA6KQ0KDQpybWFwYnQgZG9lcyBhbGwgdGhlIHJldmVy
c2UgbWFwcGluZyB0cmFja2luZywgcmVmbGluayBqdXN0IGRvZXMgdGhlDQpzaGFyZWQgZGF0YSBl
eHRlbnQgdHJhY2tpbmcuDQoNCkJ1dCBnaXZlbiB0aGF0IGFueW9uZSB3aG8gd2FudHMgdG8gdXNl
IERBWCB3aXRoIHJlZmxpbmsgaXMgZ29pbmcgdG8NCmhhdmUgdG8gbWtmcyB0aGVpciBmaWxlc3lz
dGVtIGFueXdheSAodG8gdHVybiBvbiByZWZsaW5rKSByZXF1aXJpbmcNCnRoYXQgcm1hcGJ0IGlz
IGFsc28gdHVybmVkIG9uIGlzIG5vdCBhIGJpZyBkZWFsLiBFc3BlY2lhbGx5IGFzIHdlDQpjYW4g
Y2hlY2sgaXQgYXQgbW91bnQgdGltZSBpbiB0aGUga2VybmVsLi4uDQoNCkNoZWVycywNCg0KRGF2
ZS4NCi0tIA0KRGF2ZSBDaGlubmVyDQpkYXZpZEBmcm9tb3JiaXQuY29tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxp
c3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
