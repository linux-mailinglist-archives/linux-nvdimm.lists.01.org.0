Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04E1BB6F3
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 08:43:31 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DD884110BA995;
	Mon, 27 Apr 2020 23:42:33 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.246; helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
	by ml01.01.org (Postfix) with ESMTP id 8B6DB110BA994
	for <linux-nvdimm@lists.01.org>; Mon, 27 Apr 2020 23:42:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DD45E82080A;
	Tue, 28 Apr 2020 16:43:19 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1jTJxe-0002vq-9O; Tue, 28 Apr 2020 16:43:18 +1000
Date: Tue, 28 Apr 2020 16:43:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Ruan, Shiyang" <ruansy.fnst@cn.fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428064318.GG2040@dread.disaster.area>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
	a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
	a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=5KLPUuaC_9wA:10 a=JfrnYn6hAAAA:8
	a=7-415B0cAAAA:8 a=Kw4piam9Eq2nsQd2tG8A:9 a=93mTbiTF0b_u7Sz-:21
	a=KFoNIqDtwUuuseL_:21 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
	a=biEYGPWJfzWAr4FL6Ov7:22 a=pHzHmUro8NiASowvMSCR:22
	a=n87TN5wuljxrRezIQYnT:22
Message-ID-Hash: NO6M4VOMYF7MQZKQYTT7BAXWPJP4KZNN
X-Message-ID-Hash: NO6M4VOMYF7MQZKQYTT7BAXWPJP4KZNN
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NO6M4VOMYF7MQZKQYTT7BAXWPJP4KZNN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDY6MDk6NDdBTSArMDAwMCwgUnVhbiwgU2hpeWFuZyB3
cm90ZToNCj4gDQo+IOWcqCAyMDIwLzQvMjcgMjA6Mjg6MzYsICJNYXR0aGV3IFdpbGNveCIgPHdp
bGx5QGluZnJhZGVhZC5vcmc+IOWGmemBkzoNCj4gDQo+ID5PbiBNb24sIEFwciAyNywgMjAyMCBh
dCAwNDo0Nzo0MlBNICswODAwLCBTaGl5YW5nIFJ1YW4gd3JvdGU6DQo+ID4+ICBUaGlzIHBhdGNo
c2V0IGlzIGEgdHJ5IHRvIHJlc29sdmUgdGhlIHNoYXJlZCAncGFnZSBjYWNoZScgcHJvYmxlbSBm
b3INCj4gPj4gIGZzZGF4Lg0KPiA+Pg0KPiA+PiAgSW4gb3JkZXIgdG8gdHJhY2sgbXVsdGlwbGUg
bWFwcGluZ3MgYW5kIGluZGV4ZXMgb24gb25lIHBhZ2UsIEkNCj4gPj4gIGludHJvZHVjZWQgYSBk
YXgtcm1hcCByYi10cmVlIHRvIG1hbmFnZSB0aGUgcmVsYXRpb25zaGlwLiAgQSBkYXggZW50cnkN
Cj4gPj4gIHdpbGwgYmUgYXNzb2NpYXRlZCBtb3JlIHRoYW4gb25jZSBpZiBpcyBzaGFyZWQuICBB
dCB0aGUgc2Vjb25kIHRpbWUgd2UNCj4gPj4gIGFzc29jaWF0ZSB0aGlzIGVudHJ5LCB3ZSBjcmVh
dGUgdGhpcyByYi10cmVlIGFuZCBzdG9yZSBpdHMgcm9vdCBpbg0KPiA+PiAgcGFnZS0+cHJpdmF0
ZShub3QgdXNlZCBpbiBmc2RheCkuICBJbnNlcnQgKC0+bWFwcGluZywgLT5pbmRleCkgd2hlbg0K
PiA+PiAgZGF4X2Fzc29jaWF0ZV9lbnRyeSgpIGFuZCBkZWxldGUgaXQgd2hlbiBkYXhfZGlzYXNz
b2NpYXRlX2VudHJ5KCkuDQo+ID4NCj4gPkRvIHdlIHJlYWxseSB3YW50IHRvIHRyYWNrIGFsbCBv
ZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJIHdvdWxkDQo+ID5oYXZlIHRob3VnaHQgYSBw
ZXItZXh0ZW50IGJhc2lzIHdhcyBtb3JlIHVzZWZ1bC4gIEVzc2VudGlhbGx5LCBjcmVhdGUNCj4g
PmEgbmV3IGFkZHJlc3Nfc3BhY2UgZm9yIGVhY2ggc2hhcmVkIGV4dGVudC4gIFBlciBwYWdlIGp1
c3Qgc2VlbXMgbGlrZQ0KPiA+YSBodWdlIG92ZXJoZWFkLg0KPiA+DQo+IFBlci1leHRlbnQgdHJh
Y2tpbmcgaXMgYSBuaWNlIGlkZWEgZm9yIG1lLiAgSSBoYXZlbid0IHRob3VnaHQgb2YgaXQgDQo+
IHlldC4uLg0KPiANCj4gQnV0IHRoZSBleHRlbnQgaW5mbyBpcyBtYWludGFpbmVkIGJ5IGZpbGVz
eXN0ZW0uICBJIHRoaW5rIHdlIG5lZWQgYSB3YXkgDQo+IHRvIG9idGFpbiB0aGlzIGluZm8gZnJv
bSBGUyB3aGVuIGFzc29jaWF0aW5nIGEgcGFnZS4gIE1heSBiZSBhIGJpdCANCj4gY29tcGxpY2F0
ZWQuICBMZXQgbWUgdGhpbmsgYWJvdXQgaXQuLi4NCg0KVGhhdCdzIHdoeSBJIHdhbnQgdGhlIC11
c2VyIG9mIHRoaXMgYXNzb2NpYXRpb24tIHRvIGRvIGEgZmlsZXN5c3RlbQ0KY2FsbG91dCBpbnN0
ZWFkIG9mIGtlZXBpbmcgaXQncyBvd24gbmFpdmUgdHJhY2tpbmcgaW5mcmFzdHJ1Y3R1cmUuDQpU
aGUgZmlsZXN5c3RlbSBjYW4gZG8gYW4gZWZmaWNpZW50LCBvbi1kZW1hbmQgcmV2ZXJzZSBtYXBw
aW5nIGxvb2t1cA0KZnJvbSBpdCdzIG93biBleHRlbnQgdHJhY2tpbmcgaW5mcmFzdHJ1Y3R1cmUs
IGFuZCB0aGVyZSdzIHplcm8NCnJ1bnRpbWUgb3ZlcmhlYWQgd2hlbiB0aGVyZSBhcmUgbm8gZXJy
b3JzIHByZXNlbnQuDQoNCkF0IHRoZSBtb21lbnQsIHRoaXMgImRheCBhc3NvY2lhdGlvbiIgaXMg
dXNlZCB0byAicmVwb3J0IiBhIHN0b3JhZ2UNCm1lZGlhIGVycm9yIGRpcmVjdGx5IHRvIHVzZXJz
cGFjZS4gSSBzYXkgInJlcG9ydCIgYmVjYXVzZSB3aGF0IGl0DQpkb2VzIGlzIGtpbGwgdXNlcnNw
YWNlIHByb2Nlc3NlcyBkZWFkLiBUaGUgc3RvcmFnZSBtZWRpYSBlcnJvcg0KYWN0dWFsbHkgbmVl
ZHMgdG8gYmUgcmVwb3J0ZWQgdG8gdGhlIG93bmVyIG9mIHRoZSBzdG9yYWdlIG1lZGlhLA0Kd2hp
Y2ggaW4gdGhlIGNhc2Ugb2YgRlMtREFYIGlzIHRoZSBmaWxlc3l0ZW0uDQoNClRoYXQgd2F5IHRo
ZSBmaWxlc3lzdGVtIGNhbiB0aGVuIGxvb2sgdXAgYWxsIHRoZSBvd25lcnMgb2YgdGhhdCBiYWQN
Cm1lZGlhIHJhbmdlIChpLmUuIHRoZSBmaWxlc3lzdGVtIGJsb2NrIGl0IGNvcnJlc3BvbmRzIHRv
KSBhbmQgdGFrZQ0KYXBwcm9wcmlhdGUgYWN0aW9uLiBlLmcuDQoNCi0gaWYgaXQgZmFsbHMgaW4g
ZmlsZXN5dGVtIG1ldGFkYXRhLCBzaHV0ZG93biB0aGUgZmlsZXN5c3RlbQ0KLSBpZiBpdCBmYWxs
cyBpbiB1c2VyIGRhdGEsIGNhbGwgdGhlICJraWxsIHVzZXJzcGFjZSBkZWFkIiByb3V0aW5lcw0K
ICBmb3IgZWFjaCBtYXBwaW5nL2luZGV4IHR1cGxlIHRoZSBmaWxlc3lzdGVtIGZpbmRzIGZvciB0
aGUgZ2l2ZW4NCiAgTEJBIGFkZHJlc3MgdGhhdCB0aGUgbWVkaWEgZXJyb3Igb2NjdXJyZWQuDQoN
ClJpZ2h0IG5vdyBpZiB0aGUgbWVkaWEgZXJyb3IgaXMgaW4gZmlsZXN5c3RlbSBtZXRhZGF0YSwg
dGhlDQpmaWxlc3lzdGVtIGlzbid0IGV2ZW4gdG9sZCBhYm91dCBpdC4gVGhlIGZpbGVzeXN0ZW0g
Y2FuJ3QgZXZlbiBzaHV0DQpkb3duIC0gdGhlIGVycm9yIGlzIGp1c3QgZHJvcHBlZCBvbiB0aGUg
Zmxvb3IgYW5kIGl0IHdvbid0IGJlIHVudGlsDQp0aGUgZmlsZXN5c3RlbSBuZXh0IHRyaWVzIHRv
IHJlZmVyZW5jZSB0aGF0IG1ldGFkYXRhIHRoYXQgd2Ugbm90aWNlDQp0aGVyZSBpcyBhbiBpc3N1
ZS4NCg0KQ2hlZXJzLA0KDQpEYXZlLg0KLS0gDQpEYXZlIENoaW5uZXINCmRhdmlkQGZyb21vcmJp
dC5jb20KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
