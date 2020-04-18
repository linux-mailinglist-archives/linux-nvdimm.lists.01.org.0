Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CD1AF55E
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 00:24:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 91C4B10FC62F4;
	Sat, 18 Apr 2020 15:24:52 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 547AA10FC62F3
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=6BmXyiqO0wHj5DxV76+E1WoB5x4GFAz5ggF5vJlCwBY=; b=oxhW+B4vRTgqQBsuDwIsLFMEct
	6TX5T83DboBf3ez7X7kXQJafr/mSIetsMcmkxbozwlNZhrGP3KaBhB72DD90MaxwSTxz0xRfULyL6
	AvX4zavVft8NqRBtfqcYE2kitI1mQMkez/vCA6TpAShj11oJMTOdbM7o15E8RRIiAPkVoHCWwXASe
	A1EetPGnTH+meja3KBvzdtPeq+Nbub1BjZ119BN61NVOGGhALPjPbS/siMH++8AT0x7QlOdGIK5G+
	q5LOp3OsdL8SPeD26SqecS+Gp7dn5PPGGDyyTbrH2nVd3ur5IgeGTiwFOjWwfijvCRV7dqo/d/V99
	/QQogknA==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPvt8-0003Nf-T0; Sat, 18 Apr 2020 22:24:39 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
 <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <144825af-536e-9f11-f055-7ff978ede505@infradead.org>
Date: Sat, 18 Apr 2020 15:24:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f097242a-1bf0-218b-4890-3ee82c5a0a23@acm.org>
Content-Language: en-US
Message-ID-Hash: FHV5SQKQL4PL46W4HAUDMACKLX6F5N6J
X-Message-ID-Hash: FHV5SQKQL4PL46W4HAUDMACKLX6F5N6J
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FHV5SQKQL4PL46W4HAUDMACKLX6F5N6J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gNC8xOC8yMCAzOjIwIFBNLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IE9uIDQvMTgvMjAg
MTE6NDEgQU0sIFJhbmR5IER1bmxhcCB3cm90ZToNCj4+IC0tLSBsaW51eC1uZXh0LTIwMjAwMzI3
Lm9yaWcvaW5jbHVkZS9saW51eC9rZXJuZWwuaA0KPj4gKysrIGxpbnV4LW5leHQtMjAyMDAzMjcv
aW5jbHVkZS9saW51eC9rZXJuZWwuaA0KPj4gQEAgLTQwLDYgKzQwLDE0IEBADQo+PiDCoCAjZGVm
aW5lIFJFQUTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDANCj4+IMKgICNkZWZpbmUgV1JJVEXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDENCj4+IMKgICsvKg0KPj4gKyAqIFdoZW4gdXNpbmcgLVdleHRy
YSwgYW4gImlmIiBzdGF0ZW1lbnQgZm9sbG93ZWQgYnkgYW4gZW1wdHkgYmxvY2sNCj4+ICsgKiAo
Y29udGFpbmluZyBvbmx5IGEgJzsnKSwgcHJvZHVjZXMgYSB3YXJuaW5nIGZyb20gZ2NjOg0KPj4g
KyAqIHdhcm5pbmc6IHN1Z2dlc3QgYnJhY2VzIGFyb3VuZCBlbXB0eSBib2R5IGluIGFuIOKAmGlm
4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0KPj4gKyAqIFJlcGxhY2UgdGhlIGVtcHR5IGJv
ZHkgd2l0aCBkb19lbXB0eSgpIHRvIHNpbGVuY2UgdGhpcyB3YXJuaW5nLg0KPj4gKyAqLw0KPj4g
KyNkZWZpbmUgZG9fZW1wdHkoKcKgwqDCoMKgwqDCoMKgIGRvIHsgfSB3aGlsZSAoMCkNCj4+ICsN
Cj4+IMKgIC8qKg0KPj4gwqDCoCAqIEFSUkFZX1NJWkUgLSBnZXQgdGhlIG51bWJlciBvZiBlbGVt
ZW50cyBpbiBhcnJheSBAYXJyDQo+PiDCoMKgICogQGFycjogYXJyYXkgdG8gYmUgc2l6ZWQNCj4g
DQo+IEknbSBsZXNzIHRoYW4gZW50aHVzaWFzdCBhYm91dCBpbnRyb2R1Y2luZyBhIG5ldyBtYWNy
byB0byBzdXBwcmVzcyAiZW1wdHkgYm9keSIgd2FybmluZ3MuIEFueW9uZSB3aG8gZW5jb3VudGVy
cyBjb2RlIGluIHdoaWNoIHRoaXMgbWFjcm8gaXMgdXNlZCB3aWxsIGhhdmUgdG8gbG9vayB1cCB0
aGUgZGVmaW5pdGlvbiBvZiB0aGlzIG1hY3JvIHRvIGxlYXJuIHdoYXQgaXQgZG9lcy4gSGFzIGl0
IGJlZW4gY29uc2lkZXJlZCB0byBzdXBwcmVzcyBlbXB0eSBib2R5IHdhcm5pbmdzIGJ5IGNoYW5n
aW5nIHRoZSBlbXB0eSBib2RpZXMgZnJvbSAiOyIgaW50byAie30iPw0KDQpJIG1lbnRpb25lZCB0
aGF0IHBvc3NpYmlsaXR5IGluIFBBVENIIDAvOSAoY292ZXIgbGV0dGVyKS4uLg0Kd2hpY2ggc2hv
dWxkIGhhdmUgYmVlbiBSRkMgUEFUQ0ggMC85Lg0KU28geWVzLCBpdCBpcyBwb3NzaWJsZS4NCg0K
WW91IGFyZSB0aGUgb25seSBvdGhlciBwZXJzb24gd2hvIGhhcyBtZW50aW9uZWQgaXQuDQoNCnRo
YW5rcy4NCi0tIA0KflJhbmR5DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
