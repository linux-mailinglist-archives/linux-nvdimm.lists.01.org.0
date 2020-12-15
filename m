Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E978C2DB6ED
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Dec 2020 00:10:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3D723100EF265;
	Tue, 15 Dec 2020 15:10:40 -0800 (PST)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.249; helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
	by ml01.01.org (Postfix) with ESMTP id 5B335100EF264
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 15:10:37 -0800 (PST)
Received: from dread.disaster.area (pa49-179-6-140.pa.nsw.optusnet.com.au [49.179.6.140])
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 1941F3C3F8B;
	Wed, 16 Dec 2020 10:10:29 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kpJSY-004N5L-QJ; Wed, 16 Dec 2020 10:10:22 +1100
Date: Wed, 16 Dec 2020 10:10:22 +1100
From: Dave Chinner <david@fromorbit.com>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [RFC PATCH v2 0/6] fsdax: introduce fs query to support reflink
Message-ID: <20201215231022.GL632069@dread.disaster.area>
References: <20201123004116.2453-1-ruansy.fnst@cn.fujitsu.com>
 <89ab4ec4-e4f0-7c17-6982-4f55bb40f574@oracle.com>
 <bb699996-ddc8-8f3a-dc8f-2422bf990b06@cn.fujitsu.com>
 <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b35604c-57e2-8cb5-da69-53508c998540@oracle.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
	a=uDU3YIYVKEaHT0eX+MXYOQ==:117 a=uDU3YIYVKEaHT0eX+MXYOQ==:17
	a=IkcTkHD0fZMA:10 a=zTNgK-yGK50A:10 a=7-415B0cAAAA:8
	a=1WtExyGbPUdzLH7rxhUA:9 a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: 34J5MQMRELT47Q2BNBMUEGX4BMDQGJQD
X-Message-ID-Hash: 34J5MQMRELT47Q2BNBMUEGX4BMDQGJQD
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/34J5MQMRELT47Q2BNBMUEGX4BMDQGJQD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBEZWMgMTUsIDIwMjAgYXQgMTE6MDU6MDdBTSAtMDgwMCwgSmFuZSBDaHUgd3JvdGU6
DQo+IE9uIDEyLzE1LzIwMjAgMzo1OCBBTSwgUnVhbiBTaGl5YW5nIHdyb3RlOg0KPiA+IEhpIEph
bmUNCj4gPiANCj4gPiBPbiAyMDIwLzEyLzE1IOS4iuWNiDQ6NTgsIEphbmUgQ2h1IHdyb3RlOg0K
PiA+ID4gSGksIFNoaXlhbmcsDQo+ID4gPiANCj4gPiA+IE9uIDExLzIyLzIwMjAgNDo0MSBQTSwg
U2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+ID4gPiBUaGlzIHBhdGNoc2V0IGlzIGEgdHJ5IHRvIHJl
c29sdmUgdGhlIHByb2JsZW0gb2YgdHJhY2tpbmcgc2hhcmVkIHBhZ2UNCj4gPiA+ID4gZm9yIGZz
ZGF4Lg0KPiA+ID4gPiANCj4gPiA+ID4gQ2hhbmdlIGZyb20gdjE6DQo+ID4gPiA+IMKgwqAgLSBJ
bnRvcmR1Y2UgLT5ibG9ja19sb3N0KCkgZm9yIGJsb2NrIGRldmljZQ0KPiA+ID4gPiDCoMKgIC0g
U3VwcG9ydCBtYXBwZWQgZGV2aWNlDQo+ID4gPiA+IMKgwqAgLSBBZGQgJ25vdCBhdmFpbGFibGUn
IHdhcm5pbmcgZm9yIHJlYWx0aW1lIGRldmljZSBpbiBYRlMNCj4gPiA+ID4gwqDCoCAtIFJlYmFz
ZWQgdG8gdjUuMTAtcmMxDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIHBhdGNoc2V0IG1vdmVzIG93
bmVyIHRyYWNraW5nIGZyb20gZGF4X2Fzc29jYWl0ZV9lbnRyeSgpIHRvIHBtZW0NCj4gPiA+ID4g
ZGV2aWNlLCBieSBpbnRyb2R1Y2luZyBhbiBpbnRlcmZhY2UgLT5tZW1vcnlfZmFpbHVyZSgpIG9m
IHN0cnVjdA0KPiA+ID4gPiBwYWdlbWFwLsKgIFRoZSBpbnRlcmZhY2UgaXMgY2FsbGVkIGJ5IG1l
bW9yeV9mYWlsdXJlKCkgaW4gbW0sIGFuZA0KPiA+ID4gPiBpbXBsZW1lbnRlZCBieSBwbWVtIGRl
dmljZS7CoCBUaGVuIHBtZW0gZGV2aWNlIGNhbGxzIGl0cyAtPmJsb2NrX2xvc3QoKQ0KPiA+ID4g
PiB0byBmaW5kIHRoZSBmaWxlc3lzdGVtIHdoaWNoIHRoZSBkYW1hZ2VkIHBhZ2UgbG9jYXRlZCBp
biwgYW5kIGNhbGwNCj4gPiA+ID4gLT5zdG9yYWdlX2xvc3QoKSB0byB0cmFjayBmaWxlcyBvciBt
ZXRhZGF0YSBhc3NvY2FpdGVkIHdpdGggdGhpcyBwYWdlLg0KPiA+ID4gPiBGaW5hbGx5IHdlIGFy
ZSBhYmxlIHRvIHRyeSB0byBmaXggdGhlIGRhbWFnZWQgZGF0YSBpbiBmaWxlc3lzdGVtIGFuZCBk
bw0KPiA+ID4gDQo+ID4gPiBEb2VzIHRoYXQgbWVhbiBjbGVhcmluZyBwb2lzb24/IGlmIHNvLCB3
b3VsZCB5b3UgbWluZCB0byBlbGFib3JhdGUNCj4gPiA+IHNwZWNpZmljYWxseSB3aGljaCBjaGFu
Z2UgZG9lcyB0aGF0Pw0KPiA+IA0KPiA+IFJlY292ZXJpbmcgZGF0YSBmb3IgZmlsZXN5c3RlbSAo
b3IgcG1lbSBkZXZpY2UpIGhhcyBub3QgYmVlbiBkb25lIGluDQo+ID4gdGhpcyBwYXRjaHNldC4u
LsKgIEkganVzdCB0cmlnZ2VyZWQgdGhlIGhhbmRsZXIgZm9yIHRoZSBmaWxlcyBzaGFyaW5nIHRo
ZQ0KPiA+IGNvcnJ1cHRlZCBwYWdlIGhlcmUuDQo+IA0KPiBUaGFua3MhIFRoYXQgY29uZmlybXMg
bXkgdW5kZXJzdGFuZGluZy4NCj4gDQo+IFdpdGggdGhlIGZyYW1ld29yayBwcm92aWRlZCBieSB0
aGUgcGF0Y2hzZXQsIGhvdyBkbyB5b3UgZW52aXNpb24gaXQgdG8NCj4gZWFzZS9zaW1wbGlmeSBw
b2lzb24gcmVjb3ZlcnkgZnJvbSB0aGUgdXNlcidzIHBlcnNwZWN0aXZlPw0KDQpBdCB0aGUgbW9t
ZW50LCBJJ2Qgc2F5IG5vIGNoYW5nZSB3aGF0LXNvLWV2ZXIuIFRIZSBiZWhhdmlvdXIgaXMNCm5l
Y2Vzc2FyeSBzbyB0aGF0IHdlIGNhbiBraWxsIHdoYXRldmVyIHVzZXIgYXBwbGljYXRpb24gbWFw
cw0KbXVsdGlwbHktc2hhcmVkIHBoeXNpY2FsIGJsb2NrcyBpZiB0aGVyZSdzIGEgbWVtb3J5IGVy
cm9yLiBUSGUNCnJlY292ZXJ5IG1ldGhvZCBmcm9tIHRoYXQgaXMgdW5jaGFuZ2VkLiBUaGUgb25s
eSBhZHZhbnRhZ2UgbWF5IGJlDQp0aGF0IHRoZSBmaWxlc3lzdGVtIChpZiBybWFwIGVuYWJsZWQp
IGNhbiB0ZWxsIHlvdSB0aGUgZXhhY3QgZmlsZQ0KYW5kIG9mZnNldCBpbnRvIHRoZSBmaWxlIHdo
ZXJlIGRhdGEgd2FzIGNvcnJ1cHRlZC4NCg0KSG93ZXZlciwgaXQgY2FuIGJlIHdvcnNlLCB0b286
IGl0IG1heSBhbHNvIG5vdyBjb21wbGV0ZWx5IHNodXQgZG93bg0KdGhlIGZpbGVzeXN0ZW0gaWYg
dGhlIGZpbGVzeXN0ZW0gZGlzY292ZXJzIHRoZSBlcnJvciBpcyBpbiBtZXRhZGF0YQ0KcmF0aGVy
IHRoYW4gdXNlciBkYXRhLiBUaGF0J3MgbXVjaCBtb3JlIGNvbXBsZXggdG8gcmVjb3ZlciBmcm9t
LCBhbmQNCnJpZ2h0IG5vdyB3aWxsIHJlcXVpcmUgZG93bnRpbWUgdG8gdGFrZSB0aGUgZmlsZXN5
c3RlbSBvZmZsaW5lIGFuZA0KcnVuIGZzY2sgdG8gY29ycmVjdCB0aGUgZXJyb3IuIFRoYXQgbWF5
IHRyYXNoIHdoYXRldmVyIHRoZSBtZXRhZGF0YQ0KdGhhdCBjYW4ndCBiZSByZWNvdmVyZWQgcG9p
bnRzIHRvLCBzbyB5b3Ugc3RpbGwgaGF2ZSBhIHVlc3IgZGF0YQ0KcmVjb3ZlcnkgcHJvY2VzcyB0
byBwZXJmb3JtIGFmdGVyIHRoaXMuLi4NCg0KPiBBbmQgaG93IGRvZXMgaXQgaGVscCBpbiBkZWFs
aW5nIHdpdGggcGFnZSBmYXVsdHMgdXBvbiBwb2lzb25lZA0KPiBkYXggcGFnZT8NCg0KSXQgZG9l
c24ndC4gSWYgdGhlIHBhZ2UgaXMgcG9pc29uZWQsIHRoZSBzYW1lIGJlaGF2aW91ciB3aWxsIG9j
Y3VyDQphcyBkb2VzIG5vdy4gVGhpcyBpcyBzaW1wbHkgZXJyb3IgcmVwb3J0aW5nIGluZnJhc3Ry
dWN0dXJlLCBub3QNCmVycm9yIGhhbmRsaW5nLg0KDQpGdXR1cmUgd29yayBtaWdodCBjaGFuZ2Ug
aG93IHdlIGNvcnJlY3QgdGhlIGZhdWx0cyBmb3VuZCBpbiB0aGUNCnN0b3JhZ2UsIGJ1dCBJIHRo
aW5rIHRoZSB1c2VyIHZpc2libGUgYmVoYXZpb3VyIGlzIGdvaW5nIHRvIGJlICJraWxsDQphcHBz
IG1hcHBpbmcgY29ycnVwdGVkIGRhdGEiIGZvciBhIGxvbmcgdGltZSB5ZXQuLi4uDQoNCkNoZWVy
cywNCg0KRGF2ZS4NCi0tIA0KRGF2ZSBDaGlubmVyDQpkYXZpZEBmcm9tb3JiaXQuY29tCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
