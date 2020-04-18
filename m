Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4301AF34A
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2BBB10FC62D3;
	Sat, 18 Apr 2020 11:41:45 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0691910FC62C6
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=SGvFqJlge/g9dh6ag6oSj2PmPKQuD0q8zfCwNpSxj1k=; b=px+muzACVI4ZR8Qma6/M2w08SW
	hySuB9tKA02KzaeL7Bz0hXOlFit5cPmIV408Ey2/X6DSkMu6cgZOGJNeXNArmsoAsUoc5WLXe/hw7
	PUb7y3czjGD9CQNnzOug4xBpyyS7F1rtcwnMYwldVZcEKIxxjt8fEjtiOCtqBiv/YhL1hpiEkcC32
	+Ial0oM3ilDiy7b15NOERaI8soL0uKgf7Q1zCQdIIn1pdo7wE4v1udirhHNffI5G2FWCaDzt7pqmn
	Os3cuV4r/Vol0BRefFeWzgu2YZhyihiwy2DDv2Uyg5GiuU2bN2PxS+V9KP2uy1ZGZchyZTVXk6HhJ
	OTstc49w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsOy-0007rZ-2e; Sat, 18 Apr 2020 18:41:16 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] input: fix empty-body warning in synaptics.c
Date: Sat, 18 Apr 2020 11:41:05 -0700
Message-Id: <20200418184111.13401-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: XZFFOWRVKRSHWT2JUACGH7STAL4OOEBD
X-Message-ID-Hash: XZFFOWRVKRSHWT2JUACGH7STAL4OOEBD
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XZFFOWRVKRSHWT2JUACGH7STAL4OOEBD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Ry
aXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmM6IEluIGZ1bmN0aW9uIOKAmHN5bmFwdGljc19w
cm9jZXNzX3BhY2tldOKAmToNCi4uL2RyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmM6MTEw
Njo2OiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBhbiDigJhp
ZuKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0NCiAgICAgIDsgICAvKiBOb3RoaW5nLCB0cmVh
dCBhIHBlbiBhcyBhIHNpbmdsZSBmaW5nZXIgKi8NCiAgICAgIF4NCg0KU2lnbmVkLW9mZi1ieTog
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpDYzogRG1pdHJ5IFRvcm9raG92
IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPg0KQ2M6IGxpbnV4LWlucHV0QHZnZXIua2VybmVs
Lm9yZw0KQ2M6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4N
CkNjOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KLS0tDQogZHJp
dmVycy9pbnB1dC9tb3VzZS9zeW5hcHRpY3MuYyB8ICAgIDMgKystDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQotLS0gbGludXgtbmV4dC0yMDIwMDMy
Ny5vcmlnL2RyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMNCisrKyBsaW51eC1uZXh0LTIw
MjAwMzI3L2RyaXZlcnMvaW5wdXQvbW91c2Uvc3luYXB0aWNzLmMNCkBAIC0yMCw2ICsyMCw3IEBA
DQogICogVHJhZGVtYXJrcyBhcmUgdGhlIHByb3BlcnR5IG9mIHRoZWlyIHJlc3BlY3RpdmUgb3du
ZXJzLg0KICAqLw0KIA0KKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQogI2luY2x1ZGUgPGxpbnV4
L2RtaS5oPg0KQEAgLTExMDMsNyArMTEwNCw3IEBAIHN0YXRpYyB2b2lkIHN5bmFwdGljc19wcm9j
ZXNzX3BhY2tldChzdHINCiAJCQkJYnJlYWs7DQogCQkJY2FzZSAyOg0KIAkJCQlpZiAoU1lOX01P
REVMX1BFTihpbmZvLT5tb2RlbF9pZCkpDQotCQkJCQk7ICAgLyogTm90aGluZywgdHJlYXQgYSBw
ZW4gYXMgYSBzaW5nbGUgZmluZ2VyICovDQorCQkJCQlkb19lbXB0eSgpOyAvKiBOb3RoaW5nLCB0
cmVhdCBhIHBlbiBhcyBhIHNpbmdsZSBmaW5nZXIgKi8NCiAJCQkJYnJlYWs7DQogCQkJY2FzZSA0
IC4uLiAxNToNCiAJCQkJaWYgKFNZTl9DQVBfUEFMTURFVEVDVChpbmZvLT5jYXBhYmlsaXRpZXMp
KQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJz
Y3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
