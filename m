Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E0133A18F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Mar 2021 23:05:29 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1B2F3100EC1D2;
	Sat, 13 Mar 2021 14:05:27 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.246.204; helo=tartarus.angband.pl; envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN> 
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF0A2100EC1CF
	for <linux-nvdimm@lists.01.org>; Sat, 13 Mar 2021 14:05:24 -0800 (PST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
	(envelope-from <kilobyte@angband.pl>)
	id 1lLCJc-00GN3W-3k; Sat, 13 Mar 2021 23:00:56 +0100
Date: Sat, 13 Mar 2021 23:00:56 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <YE02GArtVnwEeJML@angband.pl>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
 <YEy4+SPUvQkL44PQ@angband.pl>
 <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Message-ID-Hash: ARLG2ESXTQCBWRLRAC5PS4H4DJSCW4LT
X-Message-ID-Hash: ARLG2ESXTQCBWRLRAC5PS4H4DJSCW4LT
X-MailFrom: kilobyte@angband.pl
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ARLG2ESXTQCBWRLRAC5PS4H4DJSCW4LT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBNYXIgMTMsIDIwMjEgYXQgMTE6MjQ6MDBBTSAtMDUwMCwgTmVhbCBHb21wYSB3cm90
ZToNCj4gT24gU2F0LCBNYXIgMTMsIDIwMjEgYXQgODowOSBBTSBBZGFtIEJvcm93c2tpIDxraWxv
Ynl0ZUBhbmdiYW5kLnBsPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0
IDAyOjI2OjQzUE0gKzAwMDAsIE1hdHRoZXcgV2lsY294IHdyb3RlOg0KPiA+ID4gT24gV2VkLCBN
YXIgMTAsIDIwMjEgYXQgMDg6MjE6NTlBTSAtMDYwMCwgR29sZHd5biBSb2RyaWd1ZXMgd3JvdGU6
DQo+ID4gPiA+IERBWCBvbiBidHJmcyBoYXMgYmVlbiBhdHRlbXB0ZWRbMV0uIE9mIGNvdXJzZSwg
d2UgY291bGQgbm90DQo+ID4gPg0KPiA+ID4gQnV0IHdoeT8gIEEgY29tcGxldGVuZXNzIGZldGlz
aD8gIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IGRlY2lkZWQNCj4gPiA+IHRvIGRvIHRoaXMg
d29yay4NCj4gPg0KPiA+ICogeGZzIGNhbiBzaGFwc2hvdCBvbmx5IHNpbmdsZSBmaWxlcywgYnRy
ZnMgZW50aXJlIHN1YnZvbHVtZXMNCj4gPiAqIGJ0cmZzLXNlbmR8cmVjZWl2ZQ0KPiA+ICogZW51
bWVyYXRpb24gb2YgY2hhbmdlZCBwYXJ0cyBvZiBhIGZpbGUNCj4gDQo+IFhGUyBjYW5ub3QgZG8g
c25hcHNob3RzIHNpbmNlIGl0IGxhY2tzIG1ldGFkYXRhIENPVy4gWEZTIHJlZmxpbmtpbmcgaXMN
Cj4gcHJpbWFyaWx5IGZvciBzcGFjZSBlZmZpY2llbmN5Lg0KDQpBIHJlZmxpbmsgaXMgYSBzaW5n
bGUtZmlsZSBzbmFwc2hvdC4NCg0KTXkgd29yayB0ZWFtIHJlYWxseSB3YW50cyB0aGlzIHZlcnkg
cGF0Y2hzZXQgLS0gcmVmbGlua3Mgb24gREFYIGFsbG93DQpiYWNrdXBzIGFuZC9vciBjaGVja3Bv
aW50aW5nLCB3aXRob3V0IHN0b3BwaW5nIHRoZSB3b3JsZCAodGhlcmUncyBhIHNpbmdsZQ0KZmls
ZSwgInBvb2wiLCBoZXJlKS4NCg0KQmVzaWRlcywgeW91IGNhbiBzdGlsbCBnZXQgcG9vci1tYW4n
cyB3aG9sZS1zdWJ2b2x1bWUoL2RpcmVjdG9yeSkNCnNuYXBzaG90cyBieSBtYW51YWxseSB3YWxr
aW5nIHRoZSB0cmVlIGFuZCByZWZsaW5raW5nIGV2ZXJ5dGhpbmcuDQpUaGF0J3Mgbm90IGF0b21p
YyAtLSBidXQgcnN5bmMgaXNuJ3QgYXRvbWljIGVpdGhlci4gIFRoYXQncyBlbm91Z2ggZm9yDQpl
Zy4gZG5mL2Rwa2cgcHVycG9zZXMuDQoNCg0KTWVvdyENCi0tIA0K4qKA4qO04qC+4qC74qK24qOm
4qCADQrio77ioIHiorDioJLioIDio7/ioYENCuKiv+KhhOKgmOKgt+KgmuKgi+KggCBOQURJRSBh
bnRpY2lwYSBsYSBpbnF1aXNpY2nDs24gZGUgZXNwYcOxYSENCuKgiOKgs+KjhOKggOKggOKggOKg
gApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
