Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E121AF76B
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 08:02:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BCFB10FC62CB;
	Sat, 18 Apr 2020 23:02:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CEC5A10FC62C9
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 23:02:55 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A4A4B2076A;
	Sun, 19 Apr 2020 06:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587276170;
	bh=r2AgjpwBy563/SvDhTEdOgTQsrTjb6KChd2dLbtCIIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTMv1wODwFpdjz0FVgzA+p2WSCpvCxj18+/q3aiIPhhtKR+jsjHHIdl5zJ2q2+RA3
	 +Tdmi8jGAiqk3VTvUYzIU3dTg9Q3SKwo6y6sZDkWyGvygbRRccfGpH1VpT4kAcKc5E
	 4lTNQxLSLwDJyeMo2kAEPugwsa59XjBdxg3VhiTs=
Date: Sun, 19 Apr 2020 08:02:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
Message-ID: <20200419060247.GA3535909@kroah.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200418184111.13401-8-rdunlap@infradead.org>
Message-ID-Hash: 7Q55C7LI3NY4R3Z2W4GTDRVCOHJWJA6H
X-Message-ID-Hash: 7Q55C7LI3NY4R3Z2W4GTDRVCOHJWJA6H
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7Q55C7LI3NY4R3Z2W4GTDRVCOHJWJA6H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBBcHIgMTgsIDIwMjAgYXQgMTE6NDE6MDlBTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOg0KPiBGaXggZ2NjIGVtcHR5LWJvZHkgd2FybmluZyB3aGVuIC1XZXh0cmEgaXMgdXNlZDoN
Cj4gDQo+IC4uL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jOjI5Nzo0Mjogd2FybmluZzogc3Vn
Z2VzdCBicmFjZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCYaWbigJkgc3RhdGVtZW50IFst
V2VtcHR5LWJvZHldDQo+IC4uL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jOjMwMTo0Mjogd2Fy
bmluZzogc3VnZ2VzdCBicmFjZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCYaWbigJkgc3Rh
dGVtZW50IFstV2VtcHR5LWJvZHldDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNp
cHNvbHV0aW9ucy5uZXQ+DQo+IENjOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91
bmRhdGlvbi5vcmc+DQo+IENjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24u
b3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jIHwgICAgNSArKystLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IC0tLSBsaW51eC1uZXh0LTIwMjAwNDE3Lm9yaWcvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMN
Cj4gKysrIGxpbnV4LW5leHQtMjAyMDA0MTcvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4g
QEAgLTksNiArOSw3IEBADQo+ICAgKg0KPiAgICogQXV0aG9yOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiAgICovDQo+ICsjaW5jbHVkZSA8bGludXgva2VybmVs
Lmg+DQoNCldoeSB0aGUgbmVlZCBmb3IgdGhpcyAuaCBmaWxlIGJlaW5nIGFkZGVkIGZvciByZWZv
cm1hdHRpbmcgdGhlIGNvZGU/DQoNCnRoYW5rcywNCg0KZ3JlZyBrLWgKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlz
dCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1h
aWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
