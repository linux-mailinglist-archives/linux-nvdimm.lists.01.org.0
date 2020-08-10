Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB2240522
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 Aug 2020 13:17:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E0FB012E61409;
	Mon, 10 Aug 2020 04:17:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78C0712E61408
	for <linux-nvdimm@lists.01.org>; Mon, 10 Aug 2020 04:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=LF7J00zPGvE5+TvNb+kSZ/mLnQ6lmd1ykbbcKN0G5P0=; b=OCNWmeSiZDDpjF5Hgiofx6N6ON
	mkqo524ZrkTmjYeAH/LOzFSErW1eK+WyzkAZsFnVA34VOuSVBXoSGM7MZ+/9KklSyZN05mfuOyT0s
	2YhgWUkFXY+JSuAnnaw4NmrKz7wA57V3jBIlZHPNkZdhVqDXFnmhvk2JKjby9cP7BlVaWDfAzs53N
	lkQLlrm4o/LDXG8+jPi57WYiSsbgy1qMRGEEL8mYfBJh/Cz0n3tZebBXT9ZPwoMDjAhbgQ2MQPDaJ
	U4AvMZQcyGTR2UWCtkSXx4VKMEPJLjTvF5HALWCUljf51bkVR9AU8RSTIPChGPGHGBS0dNqkiVmpQ
	/ZGi0Vig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k55nV-0002Ra-ET; Mon, 10 Aug 2020 11:16:57 +0000
Date: Mon, 10 Aug 2020 12:16:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
Message-ID: <20200810111657.GL17456@casper.infradead.org>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
 <20200807133857.GC17456@casper.infradead.org>
 <9673ed3c-9e42-3d01-000b-b01cda9832ce@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9673ed3c-9e42-3d01-000b-b01cda9832ce@cn.fujitsu.com>
Message-ID-Hash: ULEYV6AKYI6P5YT5RTP544SNGUHOLHPX
X-Message-ID-Hash: ULEYV6AKYI6P5YT5RTP544SNGUHOLHPX
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ULEYV6AKYI6P5YT5RTP544SNGUHOLHPX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBBdWcgMTAsIDIwMjAgYXQgMDQ6MTU6NTBQTSArMDgwMCwgUnVhbiBTaGl5YW5nIHdy
b3RlOg0KPiANCj4gDQo+IE9uIDIwMjAvOC83IOS4i+WNiDk6MzgsIE1hdHRoZXcgV2lsY294IHdy
b3RlOg0KPiA+IE9uIEZyaSwgQXVnIDA3LCAyMDIwIGF0IDA5OjEzOjI4UE0gKzA4MDAsIFNoaXlh
bmcgUnVhbiB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2hzZXQgaXMgYSB0cnkgdG8gcmVzb2x2ZSB0
aGUgcHJvYmxlbSBvZiB0cmFja2luZyBzaGFyZWQgcGFnZQ0KPiA+ID4gZm9yIGZzZGF4Lg0KPiA+
ID4gDQo+ID4gPiBJbnN0ZWFkIG9mIHBlci1wYWdlIHRyYWNraW5nIG1ldGhvZCwgdGhpcyBwYXRj
aHNldCBpbnRyb2R1Y2VzIGEgcXVlcnkNCj4gPiA+IGludGVyZmFjZTogZ2V0X3NoYXJlZF9maWxl
cygpLCB3aGljaCBpcyBpbXBsZW1lbnRlZCBieSBlYWNoIEZTLCB0bw0KPiA+ID4gb2J0YWluIHRo
ZSBvd25lcnMgb2YgYSBzaGFyZWQgcGFnZS4gIEl0IHJldHVybnMgYW4gb3duZXIgbGlzdCBvZiB0
aGlzDQo+ID4gPiBzaGFyZWQgcGFnZS4gIFRoZW4sIHRoZSBtZW1vcnktZmFpbHVyZSgpIGl0ZXJh
dGVzIHRoZSBsaXN0IHRvIGJlIGFibGUNCj4gPiA+IHRvIG5vdGlmeSBlYWNoIHByb2Nlc3MgdXNp
bmcgZmlsZXMgdGhhdCBzaGFyaW5nIHRoaXMgcGFnZS4NCj4gPiA+IA0KPiA+ID4gVGhlIGRlc2ln
biBvZiB0aGUgdHJhY2tpbmcgbWV0aG9kIGlzIGFzIGZvbGxvdzoNCj4gPiA+IDEuIGRheF9hc3Nv
Y2FpdGVfZW50cnkoKSBhc3NvY2lhdGVzIHRoZSBvd25lcidzIGluZm8gdG8gdGhpcyBwYWdlDQo+
ID4gDQo+ID4gSSB0aGluayB0aGF0J3MgdGhlIGZpcnN0IHByb2JsZW0gd2l0aCB0aGlzIGRlc2ln
bi4gIGRheF9hc3NvY2lhdGVfZW50cnkgaXMNCj4gPiBhIGhvcnJlbmRvdXMgaWRlYSB3aGljaCBu
ZWVkcyB0byBiZSByaXBwZWQgb3V0LCBub3QgbWFkZSBtb3JlIGltcG9ydGFudC4NCj4gPiBJdCdz
IGFsbCBwYXJ0IG9mIHRoZSBnZW5lcmFsIHByb2JsZW0gb2YgdHJ5aW5nIHRvIGRvIHNvbWV0aGlu
ZyBvbiBhDQo+ID4gcGVyLXBhZ2UgYmFzaXMgaW5zdGVhZCBvZiBwZXItZXh0ZW50IGJhc2lzLg0K
PiA+IA0KPiANCj4gVGhlIG1lbW9yeS1mYWlsdXJlIG5lZWRzIHRvIHRyYWNrIG93bmVycyBpbmZv
IGZyb20gYSBkYXggcGFnZSwgc28gSSBzaG91bGQNCj4gYXNzb2NpYXRlIHRoZSBvd25lciB3aXRo
IHRoaXMgcGFnZS4gIEluIHRoaXMgdmVyc2lvbiwgSSBhc3NvY2lhdGUgdGhlIGJsb2NrDQo+IGRl
dmljZSB0byB0aGUgZGF4IHBhZ2UsIHNvIHRoYXQgdGhlIG1lbW9yeS1mYWlsdXJlIGlzIGFibGUg
dG8gaXRlcmF0ZSB0aGUNCj4gb3duZXJzIGJ5IHRoZSBxdWVyeSBpbnRlcmZhY2UgcHJvdmlkZWQg
YnkgZmlsZXN5c3RlbS4NCg0KTm8sIGl0IGRvZXNuJ3QgbmVlZCB0byB0cmFjayBvd25lciBpbmZv
IGZyb20gYSBEQVggcGFnZS4gIFdoYXQgaXQgbmVlZHMgdG8NCmRvIGlzIGFzayB0aGUgZmlsZXN5
c3RlbS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVu
c3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9y
Zwo=
