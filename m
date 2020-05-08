Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A081CBB6D
	for <lists+linux-nvdimm@lfdr.de>; Sat,  9 May 2020 01:53:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCAEC11853120;
	Fri,  8 May 2020 16:51:03 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 379A01183DF43
	for <linux-nvdimm@lists.01.org>; Fri,  8 May 2020 16:51:00 -0700 (PDT)
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C36D12063A;
	Fri,  8 May 2020 23:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588981987;
	bh=HhHKaurLAmb7NjsgrxbGjxSSVFmDRRfuuN9UCDjB39o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NlxsLycULu/0pDE5VncKMqsY68TvDzrBX4Z64itAzdFVs23jjGQe08PfomP/NtWT8
	 t+PlAdQE7wuMV/9rpzTnihUcJMRtJqlsdArVibUT/u4A0ZhILXtPYgryyu3m8JvFgO
	 cvEh5TrYedonuRC3JSEcG71eqRoSLBbbgIM2fD/M=
Date: Fri, 8 May 2020 16:53:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 1/4] device-dax: Don't leak kernel memory to user
 space after unloading kmem
Message-Id: <20200508165306.7cd806f7e451c5c9bc2a40ac@linux-foundation.org>
In-Reply-To: <20200508084217.9160-2-david@redhat.com>
References: <20200508084217.9160-1-david@redhat.com>
	<20200508084217.9160-2-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Message-ID-Hash: 6W7QSPE7ZEWAL6ZYR4TGD3UL33C4XWVE
X-Message-ID-Hash: 6W7QSPE7ZEWAL6ZYR4TGD3UL33C4XWVE
X-MailFrom: akpm@linux-foundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, kexec@lists.infradead.org, Pavel Tatashin <pasha.tatashin@soleen.com>, stable@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6W7QSPE7ZEWAL6ZYR4TGD3UL33C4XWVE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCAgOCBNYXkgMjAyMCAxMDo0MjoxNCArMDIwMCBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2
aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQoNCj4gQXNzdW1lIHdlIGhhdmUga21lbSBjb25maWd1cmVk
IGFuZCBsb2FkZWQ6DQo+ICAgW3Jvb3RAbG9jYWxob3N0IH5dIyBjYXQgL3Byb2MvaW9tZW0NCj4g
ICAuLi4NCj4gICAxNDAwMDAwMDAtMzNmZmZmZmZmIDogUGVyc2lzdGVudCBNZW1vcnkkDQo+ICAg
ICAxNDAwMDAwMDAtMTQ4MWZmZmZmIDogbmFtZXNwYWNlMC4wDQo+ICAgICAxNTAwMDAwMDAtMzNm
ZmZmZmZmIDogZGF4MC4wDQo+ICAgICAgIDE1MDAwMDAwMC0zM2ZmZmZmZmYgOiBTeXN0ZW0gUkFN
DQo+IA0KPiBBc3N1bWUgd2UgdHJ5IHRvIHVubG9hZCBrbWVtLiBUaGlzIGZvcmNlLXVubG9hZGlu
ZyB3aWxsIHdvcmssIGV2ZW4gaWYNCj4gbWVtb3J5IGNhbm5vdCBnZXQgcmVtb3ZlZCBmcm9tIHRo
ZSBzeXN0ZW0uDQo+ICAgW3Jvb3RAbG9jYWxob3N0IH5dIyBybW1vZCBrbWVtDQo+ICAgWyAgIDg2
LjM4MDIyOF0gcmVtb3ZpbmcgbWVtb3J5IGZhaWxzLCBiZWNhdXNlIG1lbW9yeSBbMHgwMDAwMDAw
MTUwMDAwMDAwLTB4MDAwMDAwMDE1N2ZmZmZmZl0gaXMgb25saW5lZA0KPiAgIC4uLg0KPiAgIFsg
ICA4Ni40MzEyMjVdIGttZW0gZGF4MC4wOiBEQVggcmVnaW9uIFttZW0gMHgxNTAwMDAwMDAtMHgz
M2ZmZmZmZmZdIGNhbm5vdCBiZSBob3RyZW1vdmVkIHVudGlsIHRoZSBuZXh0IHJlYm9vdA0KPiAN
Cj4gTm93LCB3ZSBjYW4gcmVjb25maWd1cmUgdGhlIG5hbWVzcGFjZToNCj4gICBbcm9vdEBsb2Nh
bGhvc3Qgfl0jIG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLS1mb3JjZSAtLXJlY29uZmlnPW5hbWVz
cGFjZTAuMCAtLW1vZGU9ZGV2ZGF4DQo+ICAgWyAgMTMxLjQwOTM1MV0gbmRfcG1lbSBuYW1lc3Bh
Y2UwLjA6IGNvdWxkIG5vdCByZXNlcnZlIHJlZ2lvbiBbbWVtIDB4MTQwMDAwMDAwLTB4MzNmZmZm
ZmZmXWRheA0KPiAgIFsgIDEzMS40MTAxNDddIG5kX3BtZW06IHByb2JlIG9mIG5hbWVzcGFjZTAu
MCBmYWlsZWQgd2l0aCBlcnJvciAtMTZuYW1lc3BhY2UwLjAgLS1tb2RlPWRldmRheA0KPiAgIC4u
Lg0KPiANCj4gVGhpcyBmYWlscyBhcyBleHBlY3RlZCBkdWUgdG8gdGhlIGJ1c3kgbWVtb3J5IHJl
c291cmNlLCBhbmQgdGhlIG1lbW9yeQ0KPiBjYW5ub3QgYmUgdXNlZC4gSG93ZXZlciwgdGhlIGRh
eDAuMCBkZXZpY2UgaXMgcmVtb3ZlZCwgYW5kIGFsb25nIGl0cyBuYW1lLg0KPiANCj4gVGhlIG5h
bWUgb2YgdGhlIG1lbW9yeSByZXNvdXJjZSBub3cgcG9pbnRzIGF0IGZyZWVkIG1lbW9yeSAobmFt
ZSBvZiB0aGUNCj4gZGV2aWNlKS4NCj4gICBbcm9vdEBsb2NhbGhvc3Qgfl0jIGNhdCAvcHJvYy9p
b21lbQ0KPiAgIC4uLg0KPiAgIDE0MDAwMDAwMC0zM2ZmZmZmZmYgOiBQZXJzaXN0ZW50IE1lbW9y
eQ0KPiAgICAgMTQwMDAwMDAwLTE0ODFmZmZmZiA6IG5hbWVzcGFjZTAuMA0KPiAgICAgMTUwMDAw
MDAwLTMzZmZmZmZmZiA6IO+/vV/vv71eN1/vv73vv70vX++/ve+/vXdS77+977+9V1Hvv73vv73v
v71e77+977+977+9IC4uLg0KPiAgICAgMTUwMDAwMDAwLTMzZmZmZmZmZiA6IFN5c3RlbSBSQU0N
Cj4gDQo+IFdlIGhhdmUgdG8gbWFrZSBzdXJlIHRvIGR1cGxpY2F0ZSB0aGUgc3RyaW5nLiBXaGls
ZSBhdCBpdCwgcmVtb3ZlIHRoZQ0KPiBzdXBlcmZsdW91cyBzZXR0aW5nIG9mIHRoZSBuYW1lIGFu
ZCBmaXh1cCBhIHN0YWxlIGNvbW1lbnQuDQo+IA0KPiBGaXhlczogOWY5NjBkYTcyYjI1ICgiZGV2
aWNlLWRheDogIkhvdHJlbW92ZSIgcGVyc2lzdGVudCBtZW1vcnkgdGhhdCBpcyB1c2VkIGxpa2Ug
bm9ybWFsIFJBTSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMgdjUuMw0KDQpobS4N
Cg0KSXMgdGhpcyByZWFsbHkgLXN0YWJsZSBtYXRlcmlhbD8gIFRoZXNlIGFyZSBhbGwgcHJpdmls
ZWdlZCBvcGVyYXRpb25zLA0KSSBleHBlY3Q/DQoNCkFzc3VtaW5nICJ5ZXMiLCBJJ3ZlIHF1ZXVl
ZCB0aGlzIHNlcGFyYXRlbHksIHN0YWdlZCBmb3IgNS43LXJjWC4gIEknbGwNCnJlZG8gcGF0Y2hl
cyAyLTQgYXMgYSB0aHJlZS1wYXRjaCBzZXJpZXMgZm9yIDUuOC1yYzEuDQoNCj4gQ2M6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBDYzogVmlzaGFsIFZlcm1hIDx2
aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IENjOiBEYXZlIEppYW5nIDxkYXZlLmppYW5nQGlu
dGVsLmNvbT4NCj4gQ2M6IFBhdmVsIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBzb2xlZW4uY29t
Pg0KDQpSZXZpZXdlcnMsIHBsZWFzZSA7KQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52
ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1u
dmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
