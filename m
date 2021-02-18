Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8931EC2D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Feb 2021 17:20:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5590100EBB9C;
	Thu, 18 Feb 2021 08:20:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07692100EBB96
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 08:20:19 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A6C61606;
	Thu, 18 Feb 2021 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1613665218;
	bh=GHp96I/gVd4EmUFAptDHDpHWkNykmmfyndnECL0NAbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eyayc5+YfPPtm0uaK+Eoc1D452WYMv+Gsf/tSxdxcgIBxZ47Sz4L0Yy8hVK/SLqx6
	 XO/kXCl8dDL5C/rADkEKSc8s4mF1h1M9xk6GJieFChIq611ekNwu520by4ngKi9Uby
	 5Jkkh9IZ/FM3Dq6PiiUBUQDvkRQFGFJxeYPu2GzlIm2GGGkbYOaTBSbmp/Zu7sH8M+
	 5zJuAWQtKw0mt4Qm5XdwLhrzBFUZmIYmx0gUxsOEJi3AAUQYJnPjqP3SmvfrudqHl3
	 DcnpOpt/ULK5VHeAqy8g9d6NbAjYHgry/RNbogkUYu6b26kGS+4zN6U7HzRiK/aCtQ
	 vcPx7EI2hpCkA==
Date: Thu, 18 Feb 2021 08:20:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210218162018.GT7193@magnolia>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
 <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
 <20210209093438.GA630@lst.de>
 <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
 <20210210131928.GA30109@lst.de>
 <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b00cfda5-464c-6161-77c6-6a25b1cc7a77@cn.fujitsu.com>
Message-ID-Hash: 7PF3FIYWPNDS7VEDHC5NL52YLNZC7SIQ
X-Message-ID-Hash: 7PF3FIYWPNDS7VEDHC5NL52YLNZC7SIQ
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7PF3FIYWPNDS7VEDHC5NL52YLNZC7SIQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBGZWIgMTcsIDIwMjEgYXQgMTE6MjQ6MThBTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDIwMjEvMi8xMCDkuIvljYg5OjE5LCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4gPiBPbiBUdWUsIEZlYiAwOSwgMjAyMSBhdCAwNTo0NjoxM1BNICswODAwLCBS
dWFuIFNoaXlhbmcgd3JvdGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gMjAyMS8yLzkg5LiL
5Y2INTozNCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwgRmViIDA5
LCAyMDIxIGF0IDA1OjE1OjEzUE0gKzA4MDAsIFJ1YW4gU2hpeWFuZyB3cm90ZToNCj4gPiA+ID4g
PiBUaGUgZGF4IGRlZHVwZSBjb21wYXJpc29uIG5lZWQgdGhlIGlvbWFwX29wcyBwb2ludGVyIGFz
IGFyZ3VtZW50LCBzbyBteQ0KPiA+ID4gPiA+IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCB3ZSBkb24n
dCBtb2RpZnkgdGhlIGFyZ3VtZW50IGxpc3Qgb2YNCj4gPiA+ID4gPiBnZW5lcmljX3JlbWFwX2Zp
bGVfcmFuZ2VfcHJlcCgpLCBidXQgbW92ZSBpdHMgY29kZSBpbnRvDQo+ID4gPiA+ID4gX19nZW5l
cmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcCgpIHdob3NlIGFyZ3VtZW50IGxpc3QgY2FuIGJlIG1v
ZGlmaWVkIHRvDQo+ID4gPiA+ID4gYWNjZXB0cyB0aGUgaW9tYXBfb3BzIHBvaW50ZXIuICBUaGVu
IGl0IGxvb2tzIGxpa2UgdGhpczoNCj4gPiA+ID4gDQo+ID4gPiA+IEknZCBzYXkganVzdCBhZGQg
dGhlIGlvbWFwX29wcyBwb2ludGVyIHRvDQo+ID4gPiA+IGdlbmVyaWNfcmVtYXBfZmlsZV9yYW5n
ZV9wcmVwIGFuZCBkbyBhd2F5IHdpdGggdGhlIGV4dHJhIHdyYXBwZXJzLiAgV2UNCj4gPiA+ID4g
b25seSBoYXZlIHRocmVlIGNhbGxlcnMgYW55d2F5Lg0KPiA+ID4gDQo+ID4gPiBPSy4NCj4gPiAN
Cj4gPiBTbyBsb29raW5nIGF0IHRoaXMgYWdhaW4gSSB0aGluayB5b3VyIHByb3Bvc2FsIGFjdGF1
bGx5IGlzIGJldHRlciwNCj4gPiBnaXZlbiB0aGF0IHRoZSBpb21hcCB2YXJpYW50IGlzIHN0aWxs
IERBWCBzcGVjaWZpYy4gIFNvcnJ5IGZvcg0KPiA+IHRoZSBub2lzZS4NCj4gPiANCj4gPiBBbHNv
IEkgdGhpbmsgZGF4X2ZpbGVfcmFuZ2VfY29tcGFyZSBzaG91bGQgdXNlIGlvbWFwX2FwcGx5IGlu
c3RlYWQNCj4gPiBvZiBvcGVuIGNvZGluZyBpdC4NCj4gPiANCj4gDQo+IFRoZXJlIGFyZSB0d28g
ZmlsZXMsIHdoaWNoIGFyZSBub3QgcmVmbGlua2VkLCBuZWVkIHRvIGJlIGRpcmVjdF9hY2Nlc3Mo
KQ0KPiBoZXJlLiAgVGhlIGlvbWFwX2FwcGx5KCkgY2FuIGhhbmRsZSBvbmUgZmlsZSBlYWNoIHRp
bWUuICBTbywgaXQgc2VlbXMgdGhhdA0KPiBpb21hcF9hcHBseSgpIGlzIG5vdCBzdWl0YWJsZSBm
b3IgdGhpcyBjYXNlLi4uDQo+IA0KPiANCj4gVGhlIHBzZXVkbyBjb2RlIG9mIHRoaXMgcHJvY2Vz
cyBpcyBhcyBmb2xsb3dzOg0KPiANCj4gICBzcmNsZW4gPSBvcHMtPmJlZ2luKCZzcmNtYXApDQo+
ICAgZGVzdGxlbiA9IG9wcy0+YmVnaW4oJmRlc3RtYXApDQo+IA0KPiAgIGRpcmVjdF9hY2Nlc3Mo
JnNyY21hcCwgJnNhZGRyKQ0KPiAgIGRpcmVjdF9hY2Nlc3MoJmRlc3RtYXAsICZkYWRkcikNCj4g
DQo+ICAgc2FtZSA9IG1lbWNweShzYWRkciwgZGFkZHIsIG1pbihzcmNsZW4sZGVzdGxlbikpDQo+
IA0KPiAgIG9wcy0+ZW5kKCZkZXN0bWFwKQ0KPiAgIG9wcy0+ZW5kKCZzcmNtYXApDQo+IA0KPiBJ
IHRoaW5rIGEgbmVzdGVkIGNhbGwgbGlrZSB0aGlzIGlzIG5lY2Vzc2FyeS4gIFRoYXQncyB3aHkg
SSB1c2UgdGhlIG9wZW4NCj4gY29kZSB3YXkuDQoNClRoaXMgbWlnaHQgYmUgYSBnb29kIHBsYWNl
IHRvIGltcGxlbWVudCBhbiBpb21hcF9hcHBseTIoKSBsb29wIHRoYXQNCmFjdHVhbGx5IC9kb2Vz
LyB3YWxrIGFsbCB0aGUgZXh0ZW50cyBvZiBmaWxlMSBhbmQgZmlsZTIuICBUaGVyZSdzIG5vdw0K
dHdvIHVzZXJzIG9mIHRoaXMgaWRpb20uDQoNCihQb3NzaWJseSBzdHJ1Y3R1cmVkIGFzIGEgImdl
dCBuZXh0IG1hcHBpbmdzIGZyb20gYm90aCIgZ2VuZXJhdG9yDQpmdW5jdGlvbiBsaWtlIE1hdHRo
ZXcgV2lsY294IGtlZXBzIGFza2luZyBmb3IuIDopKQ0KDQotLUQNCg0KPiANCj4gLS0NCj4gVGhh
bmtzLA0KPiBSdWFuIFNoaXlhbmcuDQo+ID4gDQo+IA0KPiAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBs
aW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8g
bGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
