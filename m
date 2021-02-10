Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC423167CC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 14:19:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CBFC100EAB4C;
	Wed, 10 Feb 2021 05:19:34 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E4C63100EB32C
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 05:19:31 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id E84686736F; Wed, 10 Feb 2021 14:19:28 +0100 (CET)
Date: Wed, 10 Feb 2021 14:19:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210210131928.GA30109@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com> <20210208151920.GE12872@lst.de> <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com> <20210209093438.GA630@lst.de> <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79b0d65c-95dd-4821-e412-ab27c8cb6942@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: 4XNKDV3C57O4YRW6HC4TEM53DWPKP2MQ
X-Message-ID-Hash: 4XNKDV3C57O4YRW6HC4TEM53DWPKP2MQ
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4XNKDV3C57O4YRW6HC4TEM53DWPKP2MQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMDU6NDY6MTNQTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPg0KPg0KPiBPbiAyMDIxLzIvOSDkuIvljYg1OjM0LCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4+IE9uIFR1ZSwgRmViIDA5LCAyMDIxIGF0IDA1OjE1OjEzUE0gKzA4MDAsIFJ1YW4g
U2hpeWFuZyB3cm90ZToNCj4+PiBUaGUgZGF4IGRlZHVwZSBjb21wYXJpc29uIG5lZWQgdGhlIGlv
bWFwX29wcyBwb2ludGVyIGFzIGFyZ3VtZW50LCBzbyBteQ0KPj4+IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCB3ZSBkb24ndCBtb2RpZnkgdGhlIGFyZ3VtZW50IGxpc3Qgb2YNCj4+PiBnZW5lcmljX3Jl
bWFwX2ZpbGVfcmFuZ2VfcHJlcCgpLCBidXQgbW92ZSBpdHMgY29kZSBpbnRvDQo+Pj4gX19nZW5l
cmljX3JlbWFwX2ZpbGVfcmFuZ2VfcHJlcCgpIHdob3NlIGFyZ3VtZW50IGxpc3QgY2FuIGJlIG1v
ZGlmaWVkIHRvDQo+Pj4gYWNjZXB0cyB0aGUgaW9tYXBfb3BzIHBvaW50ZXIuICBUaGVuIGl0IGxv
b2tzIGxpa2UgdGhpczoNCj4+DQo+PiBJJ2Qgc2F5IGp1c3QgYWRkIHRoZSBpb21hcF9vcHMgcG9p
bnRlciB0bw0KPj4gZ2VuZXJpY19yZW1hcF9maWxlX3JhbmdlX3ByZXAgYW5kIGRvIGF3YXkgd2l0
aCB0aGUgZXh0cmEgd3JhcHBlcnMuICBXZQ0KPj4gb25seSBoYXZlIHRocmVlIGNhbGxlcnMgYW55
d2F5Lg0KPg0KPiBPSy4NCg0KU28gbG9va2luZyBhdCB0aGlzIGFnYWluIEkgdGhpbmsgeW91ciBw
cm9wb3NhbCBhY3RhdWxseSBpcyBiZXR0ZXIsDQpnaXZlbiB0aGF0IHRoZSBpb21hcCB2YXJpYW50
IGlzIHN0aWxsIERBWCBzcGVjaWZpYy4gIFNvcnJ5IGZvcg0KdGhlIG5vaXNlLg0KDQpBbHNvIEkg
dGhpbmsgZGF4X2ZpbGVfcmFuZ2VfY29tcGFyZSBzaG91bGQgdXNlIGlvbWFwX2FwcGx5IGluc3Rl
YWQNCm9mIG9wZW4gY29kaW5nIGl0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
