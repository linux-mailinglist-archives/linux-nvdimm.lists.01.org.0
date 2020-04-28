Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D194A1BBC2E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Apr 2020 13:16:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35C7A1007B7BB;
	Tue, 28 Apr 2020 04:15:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F43F1007B7B4
	for <linux-nvdimm@lists.01.org>; Tue, 28 Apr 2020 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u2H9SL+UMErMdRB2YXU6A5uO+y4zqg8b68UfJIqKHUU=; b=BbEv0tv/tpdRIsWJ5h4Vm4N5uQ
	N6PimFztig63e/oRDUJ0P7VhoKLjfva0KIy4rlZjQ2OheYN1i8n/GKpj2swy49MNk/3u3jcNMaGvn
	ye/iybuk4S7mglrs/hNIx6WJySktdeNKwPTGx/RPP0xLx6DFnyk4a0jqJCX6BncQiuHkzfusZOPPh
	bMgyUGN91SR7w+nOOebqqyYc7/cJ5mH98QgOYiw1Yk0d8xv1IGMzJwM0OBwI00wIucyImvp4Lg9um
	NaXoPXFKBqIYa/RLoTWaGGtZWGiiOvDLiQiQZFwaJAE7rHjxktGJjWcGK1wg+u+micKtkLYptCD2i
	cVFpmLJw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTOE8-0002zk-5p; Tue, 28 Apr 2020 11:16:36 +0000
Date: Tue, 28 Apr 2020 04:16:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBSZQ==?= =?utf-8?Q?=3A?= [RFC PATCH 0/8]
 dax: Add a dax-rmap tree to support reflink
Message-ID: <20200428111636.GK29705@bombadil.infradead.org>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
 <20200427122836.GD29705@bombadil.infradead.org>
 <em33c55fa5-15ca-4c46-8c27-6b0300fa4e51@g08fnstd180058>
 <20200428064318.GG2040@dread.disaster.area>
 <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <259fe633-e1ff-b279-cd8c-1a81eaa40941@cn.fujitsu.com>
Message-ID-Hash: QV5BQJKDH4K26LUDDY3RM6TVYJUWXMV5
X-Message-ID-Hash: QV5BQJKDH4K26LUDDY3RM6TVYJUWXMV5
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Chinner <david@fromorbit.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "Qi, Fuli" <qi.fuli@fujitsu.com>, "Gotou, Yasunori" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QV5BQJKDH4K26LUDDY3RM6TVYJUWXMV5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMDU6MzI6NDFQTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPiBPbiAyMDIwLzQvMjgg5LiL5Y2IMjo0MywgRGF2ZSBDaGlubmVyIHdyb3RlOg0KPiA+
IE9uIFR1ZSwgQXByIDI4LCAyMDIwIGF0IDA2OjA5OjQ3QU0gKzAwMDAsIFJ1YW4sIFNoaXlhbmcg
d3JvdGU6DQo+ID4gPiDlnKggMjAyMC80LzI3IDIwOjI4OjM2LCAiTWF0dGhldyBXaWxjb3giIDx3
aWxseUBpbmZyYWRlYWQub3JnPiDlhpnpgZM6DQo+ID4gPiA+IE9uIE1vbiwgQXByIDI3LCAyMDIw
IGF0IDA0OjQ3OjQyUE0gKzA4MDAsIFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiA+ID4gPiAgIFRo
aXMgcGF0Y2hzZXQgaXMgYSB0cnkgdG8gcmVzb2x2ZSB0aGUgc2hhcmVkICdwYWdlIGNhY2hlJyBw
cm9ibGVtIGZvcg0KPiA+ID4gPiA+ICAgZnNkYXguDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICBJ
biBvcmRlciB0byB0cmFjayBtdWx0aXBsZSBtYXBwaW5ncyBhbmQgaW5kZXhlcyBvbiBvbmUgcGFn
ZSwgSQ0KPiA+ID4gPiA+ICAgaW50cm9kdWNlZCBhIGRheC1ybWFwIHJiLXRyZWUgdG8gbWFuYWdl
IHRoZSByZWxhdGlvbnNoaXAuICBBIGRheCBlbnRyeQ0KPiA+ID4gPiA+ICAgd2lsbCBiZSBhc3Nv
Y2lhdGVkIG1vcmUgdGhhbiBvbmNlIGlmIGlzIHNoYXJlZC4gIEF0IHRoZSBzZWNvbmQgdGltZSB3
ZQ0KPiA+ID4gPiA+ICAgYXNzb2NpYXRlIHRoaXMgZW50cnksIHdlIGNyZWF0ZSB0aGlzIHJiLXRy
ZWUgYW5kIHN0b3JlIGl0cyByb290IGluDQo+ID4gPiA+ID4gICBwYWdlLT5wcml2YXRlKG5vdCB1
c2VkIGluIGZzZGF4KS4gIEluc2VydCAoLT5tYXBwaW5nLCAtPmluZGV4KSB3aGVuDQo+ID4gPiA+
ID4gICBkYXhfYXNzb2NpYXRlX2VudHJ5KCkgYW5kIGRlbGV0ZSBpdCB3aGVuIGRheF9kaXNhc3Nv
Y2lhdGVfZW50cnkoKS4NCj4gPiA+ID4gDQo+ID4gPiA+IERvIHdlIHJlYWxseSB3YW50IHRvIHRy
YWNrIGFsbCBvZiB0aGlzIG9uIGEgcGVyLXBhZ2UgYmFzaXM/ICBJIHdvdWxkDQo+ID4gPiA+IGhh
dmUgdGhvdWdodCBhIHBlci1leHRlbnQgYmFzaXMgd2FzIG1vcmUgdXNlZnVsLiAgRXNzZW50aWFs
bHksIGNyZWF0ZQ0KPiA+ID4gPiBhIG5ldyBhZGRyZXNzX3NwYWNlIGZvciBlYWNoIHNoYXJlZCBl
eHRlbnQuICBQZXIgcGFnZSBqdXN0IHNlZW1zIGxpa2UNCj4gPiA+ID4gYSBodWdlIG92ZXJoZWFk
Lg0KPiA+ID4gPiANCj4gPiA+IFBlci1leHRlbnQgdHJhY2tpbmcgaXMgYSBuaWNlIGlkZWEgZm9y
IG1lLiAgSSBoYXZlbid0IHRob3VnaHQgb2YgaXQNCj4gPiA+IHlldC4uLg0KPiA+ID4gDQo+ID4g
PiBCdXQgdGhlIGV4dGVudCBpbmZvIGlzIG1haW50YWluZWQgYnkgZmlsZXN5c3RlbS4gIEkgdGhp
bmsgd2UgbmVlZCBhIHdheQ0KPiA+ID4gdG8gb2J0YWluIHRoaXMgaW5mbyBmcm9tIEZTIHdoZW4g
YXNzb2NpYXRpbmcgYSBwYWdlLiAgTWF5IGJlIGEgYml0DQo+ID4gPiBjb21wbGljYXRlZC4gIExl
dCBtZSB0aGluayBhYm91dCBpdC4uLg0KPiA+IA0KPiA+IFRoYXQncyB3aHkgSSB3YW50IHRoZSAt
dXNlciBvZiB0aGlzIGFzc29jaWF0aW9uLSB0byBkbyBhIGZpbGVzeXN0ZW0NCj4gPiBjYWxsb3V0
IGluc3RlYWQgb2Yga2VlcGluZyBpdCdzIG93biBuYWl2ZSB0cmFja2luZyBpbmZyYXN0cnVjdHVy
ZS4NCj4gPiBUaGUgZmlsZXN5c3RlbSBjYW4gZG8gYW4gZWZmaWNpZW50LCBvbi1kZW1hbmQgcmV2
ZXJzZSBtYXBwaW5nIGxvb2t1cA0KPiA+IGZyb20gaXQncyBvd24gZXh0ZW50IHRyYWNraW5nIGlu
ZnJhc3RydWN0dXJlLCBhbmQgdGhlcmUncyB6ZXJvDQo+ID4gcnVudGltZSBvdmVyaGVhZCB3aGVu
IHRoZXJlIGFyZSBubyBlcnJvcnMgcHJlc2VudC4NCj4gPiANCj4gPiBBdCB0aGUgbW9tZW50LCB0
aGlzICJkYXggYXNzb2NpYXRpb24iIGlzIHVzZWQgdG8gInJlcG9ydCIgYSBzdG9yYWdlDQo+ID4g
bWVkaWEgZXJyb3IgZGlyZWN0bHkgdG8gdXNlcnNwYWNlLiBJIHNheSAicmVwb3J0IiBiZWNhdXNl
IHdoYXQgaXQNCj4gPiBkb2VzIGlzIGtpbGwgdXNlcnNwYWNlIHByb2Nlc3NlcyBkZWFkLiBUaGUg
c3RvcmFnZSBtZWRpYSBlcnJvcg0KPiA+IGFjdHVhbGx5IG5lZWRzIHRvIGJlIHJlcG9ydGVkIHRv
IHRoZSBvd25lciBvZiB0aGUgc3RvcmFnZSBtZWRpYSwNCj4gPiB3aGljaCBpbiB0aGUgY2FzZSBv
ZiBGUy1EQVggaXMgdGhlIGZpbGVzeXRlbS4NCj4gDQo+IFVuZGVyc3Rvb2QuDQo+IA0KPiBCVFcs
IHRoaXMgaXMgdGhlIHVzYWdlIGluIG1lbW9yeS1mYWlsdXJlLCBzbyB3aGF0IGFib3V0IHJtYXA/
ICBJIGhhdmUgbm90DQo+IGZvdW5kIGhvdyB0byB1c2UgdGhpcyB0cmFja2luZyBpbiBybWFwLiAg
RG8geW91IGhhdmUgYW55IGlkZWFzPw0KPiANCj4gPiANCj4gPiBUaGF0IHdheSB0aGUgZmlsZXN5
c3RlbSBjYW4gdGhlbiBsb29rIHVwIGFsbCB0aGUgb3duZXJzIG9mIHRoYXQgYmFkDQo+ID4gbWVk
aWEgcmFuZ2UgKGkuZS4gdGhlIGZpbGVzeXN0ZW0gYmxvY2sgaXQgY29ycmVzcG9uZHMgdG8pIGFu
ZCB0YWtlDQo+ID4gYXBwcm9wcmlhdGUgYWN0aW9uLiBlLmcuDQo+IA0KPiBJIHRyaWVkIHdyaXRp
bmcgYSBmdW5jdGlvbiB0byBsb29rIHVwIGFsbCB0aGUgb3duZXJzJyBpbmZvIG9mIG9uZSBibG9j
ayBpbg0KPiB4ZnMgZm9yIG1lbW9yeS1mYWlsdXJlIHVzZS4gIEl0IHdhcyBkcm9wcGVkIGluIHRo
aXMgcGF0Y2hzZXQgYmVjYXVzZSBJIGZvdW5kDQo+IG91dCB0aGF0IHRoaXMgbG9va3VwIGZ1bmN0
aW9uIG5lZWRzICdybWFwYnQnIHRvIGJlIGVuYWJsZWQgd2hlbiBta2ZzLiAgQnV0DQo+IGJ5IGRl
ZmF1bHQsIHJtYXBidCBpcyBkaXNhYmxlZC4gIEkgYW0gbm90IHN1cmUgaWYgaXQgbWF0dGVycy4u
Lg0KDQpJJ20gcHJldHR5IHN1cmUgeW91IGNhbid0IGhhdmUgc2hhcmVkIGV4dGVudHMgb24gYW4g
WEZTIGZpbGVzeXN0ZW0gaWYgeW91DQpfZG9uJ3RfIGhhdmUgdGhlIHJtYXBidCBmZWF0dXJlIGVu
YWJsZWQuICBJIG1lYW4sIHRoYXQncyB3aHkgaXQgZXhpc3RzLgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0t
IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0
byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
