Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4101AF776
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 08:04:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3E7F10FC62CF;
	Sat, 18 Apr 2020 23:04:13 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E9E1210FC62CB
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 23:04:11 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 413BA2076A;
	Sun, 19 Apr 2020 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587276247;
	bh=agNi+92Rk4VTgZzA3ehgkSQ9y4v1a+tAYpxKg5s3wAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2a4P62AV1qdwRJhSwItZe45Wmyq7eJCSCexW9g0a3N4ujoGZ8gNWS52E9mXAEcDMu
	 MVTzEtKlOCze+k1ZHx9ZbgImXxdUJq4+HCQIb6h6A/d0jQvRT8FYmdVneCtPIDW3ea
	 oBSwXeCSPEAnzjcpBuad/kRHbvJ+xX2EHIlpiMHI=
Date: Sun, 19 Apr 2020 08:04:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200419060404.GB3535909@kroah.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200419060247.GA3535909@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200419060247.GA3535909@kroah.com>
Message-ID-Hash: ZAAYLYZE7XTODKK2XZ37KT2JZWMEG46T
X-Message-ID-Hash: ZAAYLYZE7XTODKK2XZ37KT2JZWMEG46T
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZAAYLYZE7XTODKK2XZ37KT2JZWMEG46T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU3VuLCBBcHIgMTksIDIwMjAgYXQgMDg6MDI6NDdBTSArMDIwMCwgR3JlZyBLcm9haC1IYXJ0
bWFuIHdyb3RlOg0KPiBPbiBTYXQsIEFwciAxOCwgMjAyMCBhdCAxMTo0MTowOUFNIC0wNzAwLCBS
YW5keSBEdW5sYXAgd3JvdGU6DQo+ID4gRml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAt
V2V4dHJhIGlzIHVzZWQ6DQo+ID4gDQo+ID4gLi4vZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmM6
Mjk3OjQyOiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBhbiDi
gJhpZuKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0NCj4gPiAuLi9kcml2ZXJzL2Jhc2UvZGV2
Y29yZWR1bXAuYzozMDE6NDI6IHdhcm5pbmc6IHN1Z2dlc3QgYnJhY2VzIGFyb3VuZCBlbXB0eSBi
b2R5IGluIGFuIOKAmGlm4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiA+IENj
OiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiA+IENjOiBMaW51
cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6IEFuZHJl
dyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvYmFzZS9kZXZjb3JlZHVtcC5jIHwgICAgNSArKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tLSBsaW51eC1uZXh0
LTIwMjAwNDE3Lm9yaWcvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gPiArKysgbGludXgt
bmV4dC0yMDIwMDQxNy9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYw0KPiA+IEBAIC05LDYgKzks
NyBAQA0KPiA+ICAgKg0KPiA+ICAgKiBBdXRob3I6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQ+DQo+ID4gICAqLw0KPiA+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+
DQo+IA0KPiBXaHkgdGhlIG5lZWQgZm9yIHRoaXMgLmggZmlsZSBiZWluZyBhZGRlZCBmb3IgcmVm
b3JtYXR0aW5nIHRoZSBjb2RlPw0KDQpBaCwgdGhlIGZ1bmN0aW9uIHlvdSBhZGQsIG5ldmVybWlu
ZCwgbmVlZCBtb3JlIGNvZmZlZS4uLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBs
aXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0t
bGVhdmVAbGlzdHMuMDEub3JnCg==
