Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4421AF351
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96BD710FC62E0;
	Sat, 18 Apr 2020 11:41:50 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F5C110FC62E4
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=d5zfrylOKoUmkiJ/VV8Fl3fzLkxXbmDEJr/3MIsevyo=; b=XCwSjlVez+qHxOPmcyTIK6oiMp
	olawr70vtpi0V1QI9XKQUEdNlzc7gZtydJwYjHnNgNwCiR0Y8ytqLU1885mYKcfU2nNRcSQ+hBEej
	MiJH64ZiTrBz5h80SHKV7B2XhV/8NA5dx2/XMstBP2kRcY+jAyFTPEP07dibSEvWPpw6URRhjEARq
	GsW6VSkFXNXfFpWKtacsKtxhxuNePEr2gYhZGljGT1rr1HkTT8hxKqdKHdiJLDwOvTjuHdAESVOeL
	NqEnuUJjyC5UmLntvc7lJwAg8Acv/O1w1fMRoAZtCHCPa4lyuiz4kTPN/HiIYqU17pqZ6fxYiBEQ9
	d15hNa1Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsOv-0007rZ-9I; Sat, 18 Apr 2020 18:41:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] fix -Wempty-body build warnings
Date: Sat, 18 Apr 2020 11:41:02 -0700
Message-Id: <20200418184111.13401-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Message-ID-Hash: YID4PI24KYYUGLOISMWCAHCX6HVIG523
X-Message-ID-Hash: YID4PI24KYYUGLOISMWCAHCX6HVIG523
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YID4PI24KYYUGLOISMWCAHCX6HVIG523/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCldoZW4gLVdleHRyYSBpcyB1c2VkLCBnY2MgZW1pdHMgbWFueSB3YXJuaW5ncyBhYm91
dCBhbiBlbXB0eSAnaWYnIG9yDQonZWxzZScgYm9keSwgbGlrZSB0aGlzOg0KDQouLi9mcy9wb3Np
eF9hY2wuYzogSW4gZnVuY3Rpb24g4oCYZ2V0X2FjbOKAmToNCi4uL2ZzL3Bvc2l4X2FjbC5jOjEy
NzoyMjogd2FybmluZzogc3VnZ2VzdCBicmFjZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCY
aWbigJkgc3RhdGVtZW50IFstV2VtcHR5LWJvZHldDQogICAvKiBmYWxsIHRocm91Z2ggKi8gOw0K
ICAgICAgICAgICAgICAgICAgICAgIF4NCg0KVG8gcXVpZXRlbiB0aGVzZSB3YXJuaW5ncywgYWRk
IGEgbmV3IG1hY3JvICJkb19lbXB0eSgpIi4NCkkgb3JpZ2luYWxseSB3YW50ZWQgdG8gdXNlIGRv
X25vdGhpbmcoKSwgYnV0IHRoYXQncyBhbHJlYWR5IGluIHVzZS4NCg0KSXQgd291bGQgc29ydGEg
YmUgbmljZSBpZiAiZmFsbHRocm91Z2giIGNvdWxkIGJlIGNvZXJjZWQgZm9yIHRoaXMNCmluc3Rl
YWQgb2YgdXNpbmcgc29tZXRoaW5nIGxpa2UgZG9fZW1wdHkoKS4NCg0KT3Igc2hvdWxkIHdlIGp1
c3QgdXNlICJ7fSIgaW4gcGxhY2Ugb2YgIjsiPw0KVGhpcyBjYXVzZXMgc29tZSBvZGQgY29kaW5n
IHN0eWxlIGlzc3VlIElNTy4gRS5nLiwgc2VlIHRoaXMgY2hhbmdlOg0KDQpvcmlnaW5hbDoNCiAJ
aWYgKGNtcHhjaGcocCwgQUNMX05PVF9DQUNIRUQsIHNlbnRpbmVsKSAhPSBBQ0xfTk9UX0NBQ0hF
RCkNCgkJLyogZmFsbCB0aHJvdWdoICovIDsNCg0Kd2l0aCBuZXcgbWFjcm86DQogCWlmIChjbXB4
Y2hnKHAsIEFDTF9OT1RfQ0FDSEVELCBzZW50aW5lbCkgIT0gQUNMX05PVF9DQUNIRUQpDQoJCWRv
X2VtcHR5KCk7IC8qIGZhbGwgdGhyb3VnaCAqLw0KDQp1c2luZyB7fToNCiAJaWYgKGNtcHhjaGco
cCwgQUNMX05PVF9DQUNIRUQsIHNlbnRpbmVsKSAhPSBBQ0xfTk9UX0NBQ0hFRCkNCgkJe30gLyog
ZmFsbCB0aHJvdWdoICovDQpvcg0KCQl7IC8qIGZhbGwgdGhyb3VnaCAqLyB9DQpvciBldmVuDQog
CWlmIChjbXB4Y2hnKHAsIEFDTF9OT1RfQ0FDSEVELCBzZW50aW5lbCkgIT0gQUNMX05PVF9DQUNI
RUQpIHsNCgkJLyogZmFsbCB0aHJvdWdoICovIH0NCm9yDQogCWlmIChjbXB4Y2hnKHAsIEFDTF9O
T1RfQ0FDSEVELCBzZW50aW5lbCkgIT0gQUNMX05PVF9DQUNIRUQpIHsNCgkJfSAvKiBmYWxsIHRo
cm91Z2ggKi8NCg0KDQogZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMgICAgICAgICB8ICAgIDUg
KysrLS0NCiBkcml2ZXJzL2RheC9idXMuYyAgICAgICAgICAgICAgICAgIHwgICAgNSArKystLQ0K
IGRyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMgICAgfCAgICAzICsrLQ0KIGRyaXZlcnMv
dGFyZ2V0L3RhcmdldF9jb3JlX3BzY3NpLmMgfCAgICAzICsrLQ0KIGRyaXZlcnMvdXNiL2NvcmUv
c3lzZnMuYyAgICAgICAgICAgfCAgICAyICstDQogZnMvbmZzZC9uZnM0c3RhdGUuYyAgICAgICAg
ICAgICAgICB8ICAgIDMgKystDQogZnMvcG9zaXhfYWNsLmMgICAgICAgICAgICAgICAgICAgICB8
ICAgIDIgKy0NCiBpbmNsdWRlL2xpbnV4L2tlcm5lbC5oICAgICAgICAgICAgIHwgICAgOCArKysr
KysrKw0KIHNvdW5kL2RyaXZlcnMvdngvdnhfY29yZS5jICAgICAgICAgfCAgICAzICsrLQ0KIDkg
ZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWls
aW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5k
IGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
