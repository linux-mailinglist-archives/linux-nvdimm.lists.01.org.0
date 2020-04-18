Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA51AF349
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BFA1E10FC62CF;
	Sat, 18 Apr 2020 11:41:45 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 04EBF10FC62C4
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=LOicRCPeL82g+7UhQ7W6knJ0Xcg7BEBtrZpHvQi2Xvs=; b=qUPAX78GmStmrzI/GjQeS30C2C
	pf+JS26rMvDzwnc2Eicv/E6iYddiBqeB8nvkVcgSW2j/uHe3NwddNiMvUjPHgrYQrMTB6NBEJ6Q4j
	Rmevyte62j1lID7vgkcJqqYHGR2MOeuzttD0VlNCXVRCcyTVd3GSoufQdGDlcNf+0ThcfvOl9CRWa
	Ht+LS8ZEFX/rH894i3z4iad3ZPVXY1Udf3RqCd/qSxW56OPRStx5/BhopFFsaYXhXitaPPN84WLos
	fDoyVBiGWJ7uO4FMNjLq8+6J2A3ZeS/prafMTg+o4HUDBJXsY7KFv8UjH8Xb/sVT1g7Gs5uV5n4n7
	om//euPw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsOz-0007rZ-FM; Sat, 18 Apr 2020 18:41:17 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] sound: fix empty-body warning in vx_core.c
Date: Sat, 18 Apr 2020 11:41:06 -0700
Message-Id: <20200418184111.13401-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: KGU2PFCWWZNXJ5FCYZIAEJKLXULX7K2C
X-Message-ID-Hash: KGU2PFCWWZNXJ5FCYZIAEJKLXULX7K2C
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KGU2PFCWWZNXJ5FCYZIAEJKLXULX7K2C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL3Nv
dW5kL2RyaXZlcnMvdngvdnhfY29yZS5jOjUxNTozOiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBh
cm91bmQgZW1wdHkgYm9keSBpbiBhbiDigJhpZuKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0N
Cg0KU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpD
YzogSmFyb3NsYXYgS3lzZWxhIDxwZXJleEBwZXJleC5jej4NCkNjOiBUYWthc2hpIEl3YWkgPHRp
d2FpQHN1c2UuY29tPg0KQ2M6IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZw0KQ2M6IExpbnVz
IFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KLS0tDQogc291bmQvZHJpdmVycy92eC92
eF9jb3JlLmMgfCAgICAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KLS0tIGxpbnV4LW5leHQtMjAyMDAzMjcub3JpZy9zb3VuZC9kcml2ZXJz
L3Z4L3Z4X2NvcmUuYw0KKysrIGxpbnV4LW5leHQtMjAyMDAzMjcvc291bmQvZHJpdmVycy92eC92
eF9jb3JlLmMNCkBAIC0xMyw2ICsxMyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiAj
aW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQor
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAj
aW5jbHVkZSA8bGludXgvaW8uaD4NCiAjaW5jbHVkZSA8c291bmQvY29yZS5oPg0KQEAgLTUxMiw3
ICs1MTMsNyBAQCBpcnFyZXR1cm5fdCBzbmRfdnhfdGhyZWFkZWRfaXJxX2hhbmRsZXIoDQogCSAq
IHJlY2VpdmVkIGJ5IHRoZSBib2FyZCBpcyBlcXVhbCB0byBvbmUgb2YgdGhvc2UgZ2l2ZW4gdG8g
aXQpLg0KIAkgKi8NCiAJaWYgKGV2ZW50cyAmIFRJTUVfQ09ERV9FVkVOVF9QRU5ESU5HKQ0KLQkJ
OyAvKiBzbyBmYXIsIG5vdGhpbmcgdG8gZG8geWV0ICovDQorCQlkb19lbXB0eSgpOyAvKiBzbyBm
YXIsIG5vdGhpbmcgdG8gZG8geWV0ICovDQogDQogCS8qIFRoZSBmcmVxdWVuY3kgaGFzIGNoYW5n
ZWQgb24gdGhlIGJvYXJkIChVRVIgbW9kZSkuICovDQogCWlmIChldmVudHMgJiBGUkVRVUVOQ1lf
Q0hBTkdFX0VWRU5UX1BFTkRJTkcpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxp
c3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1s
ZWF2ZUBsaXN0cy4wMS5vcmcK
