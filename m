Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599ACA13A
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Oct 2019 17:38:18 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4F64610FC524F;
	Thu,  3 Oct 2019 08:39:28 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=173.255.197.46; helo=fieldses.org; envelope-from=bfields@fieldses.org; receiver=<UNKNOWN> 
Received: from fieldses.org (fieldses.org [173.255.197.46])
	by ml01.01.org (Postfix) with ESMTP id 6F06210FC524E
	for <linux-nvdimm@lists.01.org>; Thu,  3 Oct 2019 08:39:26 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
	id 195AB322; Thu,  3 Oct 2019 11:37:43 -0400 (EDT)
Date: Thu, 3 Oct 2019 11:37:43 -0400
From: "J. Bruce Fields" <bfields@fieldses.org>
To: Jeff Layton <jlayton@kernel.org>
Subject: Re: Lease semantic proposal
Message-ID: <20191003153743.GA24657@fieldses.org>
References: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
 <5d5a93637934867e1b3352763da8e3d9f9e6d683.camel@kernel.org>
 <20191001181659.GA5500@iweiny-DESK2.sc.intel.com>
 <2b42cf4ae669cedd061c937103674babad758712.camel@kernel.org>
 <20191002192711.GA21386@fieldses.org>
 <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <df9022f0f5d18d71f37ed494a05eaa4509cf0a68.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Message-ID-Hash: SPR3EZXSL6U54LWPNKW6GFKX7B3KPJ7O
X-Message-ID-Hash: SPR3EZXSL6U54LWPNKW6GFKX7B3KPJ7O
X-MailFrom: bfields@fieldses.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SPR3EZXSL6U54LWPNKW6GFKX7B3KPJ7O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBPY3QgMDIsIDIwMTkgYXQgMDQ6MzU6NTVQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3Jv
dGU6DQo+IE9uIFdlZCwgMjAxOS0xMC0wMiBhdCAxNToyNyAtMDQwMCwgSi4gQnJ1Y2UgRmllbGRz
IHdyb3RlOg0KPiA+IE9uIFdlZCwgT2N0IDAyLCAyMDE5IGF0IDA4OjI4OjQwQU0gLTA0MDAsIEpl
ZmYgTGF5dG9uIHdyb3RlOg0KPiA+ID4gRm9yIHRoZSBieXRlIHJhbmdlcywgdGhlIGNhdGNoIHRo
ZXJlIGlzIHRoYXQgZXh0ZW5kaW5nIHRoZSB1c2VybGFuZA0KPiA+ID4gaW50ZXJmYWNlIGZvciB0
aGF0IGxhdGVyIHdpbGwgYmUgZGlmZmljdWx0Lg0KPiA+IA0KPiA+IFdoeSB3b3VsZCBpdCBiZSBk
aWZmaWN1bHQ/DQo+IA0KPiBMZWdhY3kgdXNlcmxhbmQgY29kZSB0aGF0IHdhbnRlZCB0byB1c2Ug
Ynl0ZSByYW5nZSBlbmFibGVkIGxheW91dHMgd291bGQNCj4gaGF2ZSB0byBiZSByZWJ1aWx0IHRv
IHRha2UgYWR2YW50YWdlIG9mIHRoZW0uIElmIHdlIHJlcXVpcmUgYSByYW5nZSBmcm9tDQo+IHRo
ZSBnZXQtZ28sIHRoZW4gdGhleSB3aWxsIGdldCB0aGUgYmVuZWZpdCBvZiB0aGVtIG9uY2UgdGhl
eSdyZQ0KPiBhdmFpbGFibGUuDQoNCkkgY2FuJ3Qgc2VlIHdyaXRpbmcgYnl0ZS1yYW5nZSBjb2Rl
IGZvciBhIGtlcm5lbCB0aGF0IGRvZXNuJ3Qgc3VwcG9ydA0KdGhhdCB5ZXQuICBIb3cgd291bGQg
SSB0ZXN0IGl0Pw0KDQo+ID4gPiBXaGF0IEknZCBwcm9iYWJseSBzdWdnZXN0DQo+ID4gPiAoYW5k
IHdoYXQgd291bGQgaml2ZSB3aXRoIHRoZSB3YXkgcE5GUyB3b3Jrcykgd291bGQgYmUgdG8gZ28g
YWhlYWQgYW5kDQo+ID4gPiBhZGQgYW4gb2Zmc2V0IGFuZCBsZW5ndGggdG8gdGhlIGFyZ3VtZW50
cyBhbmQgcmVzdWx0IChtYXliZSBhbHNvDQo+ID4gPiB3aGVuY2U/KS4NCj4gPiANCj4gPiBXaHkg
bm90IGFkZCBuZXcgY29tbWFuZHMgd2l0aCByYW5nZSBhcmd1bWVudHMgbGF0ZXIgaWYgaXQgdHVy
bnMgb3V0IHRvDQo+ID4gYmUgbmVjZXNzYXJ5Pw0KPiANCj4gV2UgY291bGQgZG8gdGhhdC4gSXQn
ZCBiZSBhIGxpdHRsZSB1Z2x5LCBJTU8sIHNpbXBseSBiZWNhdXNlIHRoZW4gd2UnZA0KPiBlbmQg
dXAgd2l0aCB0d28gaW50ZXJmYWNlcyB0aGF0IGRvIGFsbW9zdCB0aGUgZXhhY3Qgc2FtZSB0aGlu
Zy4NCj4gDQo+IFNob3VsZCBieXRlLXJhbmdlIGxheW91dHMgYXQgdGhhdCBwb2ludCBjb25mbGlj
dCB3aXRoIG5vbi1ieXRlIHJhbmdlDQo+IGxheW91dHMsIG9yIHNob3VsZCB0aGV5IGJlIGluIGRp
ZmZlcmVudCAic3BhY2VzIiAoYSdsYSBQT1NJWCBhbmQgZmxvY2sNCj4gbG9ja3MpPyBXaGVuIGl0
J3MgYWxsIG9uZSBpbnRlcmZhY2UsIHRob3NlIHNvcnRzIG9mIHF1ZXN0aW9ucyBzb3J0IG9mDQo+
IGFuc3dlciB0aGVtc2VsdmVzLiBXaGVuIHRoZXkgYXJlbid0IHdlJ2xsIGhhdmUgdG8gZG9jdW1l
bnQgdGhlbSBjbGVhcmx5DQo+IGFuZCBJIHRoaW5rIHRoZSByZXN1bHQgd2lsbCBiZSBtb3JlIGNv
bmZ1c2luZyBmb3IgdXNlcmxhbmQgcHJvZ3JhbW1lcnMuDQoNCkkgd2FzIGhvcGluZyB0aGV5J2Qg
YmUgaW4gdGhlIHNhbWUgc3BhY2UsIHdpdGggdGhlIG9sZCBpbnRlcmZhY2UganVzdA0KZGVmaW5l
ZCB0byBkZWFsIGluIGxvY2tzIHdpdGggcmFuZ2UgWzAs4oieKS4NCg0KSSdtIGp1c3Qgd29ycmll
ZCBhYm91dCBnZXR0aW5nIHRoZSBpbnRlcmZhY2Ugd3JvbmcgaWYgaXQncyBzcGVjaWZpZWQNCndp
dGhvdXQgYmVpbmcgaW1wbGVtZW50ZWQuICBNYXliZSB0aGlzIGlzIHN0cmFpZ2h0Zm9yd2FyZCBl
bm91Z2ggdGhhdA0KdGhlcmUncyBub3QgYSByaXNrLCBJIGRvbid0IGtub3cuDQoNCi0tYi4NCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
