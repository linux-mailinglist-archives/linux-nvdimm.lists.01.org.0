Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736341AF34B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96F9510FC62C4;
	Sat, 18 Apr 2020 11:41:44 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0334110FC3BBA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=PcYjWQQ7jWfjWjAXgVV1SYCf3duL2j5Dyqo6dTDCrvc=; b=JDXvnRUeifNZ+Ac5TUneCkXEfw
	xGm7FAIuWAOT5gimqOHdhp/grioqH8IcST+jg0KLZY3liAOqyk+QRxz88gfFrn1pGspjvVf4kn+9z
	6WnDEql0MbixpKyaGExg7dKQXpW5xcLjkR6Sghi8cCQI/hTO1yXq4UDTbsHmGn4nDqmEnHzJuU3K1
	xD7HyAbbCak26otzJily36UMy3pM+4gOlaaVkoFKBllnKTlL2HIrqBh3/P+uJ7g73UIIdgCRYZljh
	6KJkixDPOYB+DeexXaN99s1T3haGNSH+ia9YOZZ2bNW49PZ2AL6kZXsFv+3C4ILtQ3Sm08S03mSqL
	JJuwddgw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsP4-0007rZ-33; Sat, 18 Apr 2020 18:41:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] target: fix empty-body warning in target_core_pscsi.c
Date: Sat, 18 Apr 2020 11:41:11 -0700
Message-Id: <20200418184111.13401-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: NXJK2FL2TH52K6SEAVLYARBZVOKRN5QE
X-Message-ID-Hash: NXJK2FL2TH52K6SEAVLYARBZVOKRN5QE
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NXJK2FL2TH52K6SEAVLYARBZVOKRN5QE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Ry
aXZlcnMvdGFyZ2V0L3RhcmdldF9jb3JlX3BzY3NpLmM6NjI0OjU6IHdhcm5pbmc6IHN1Z2dlc3Qg
YnJhY2VzIGFyb3VuZCBlbXB0eSBib2R5IGluIGFuIOKAmGlm4oCZIHN0YXRlbWVudCBbLVdlbXB0
eS1ib2R5XQ0KDQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz4NCkNjOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+
DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiAiTWFy
dGluIEsuIFBldGVyc2VuIiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+DQpDYzogbGludXgt
c2NzaUB2Z2VyLmtlcm5lbC5vcmcNCkNjOiB0YXJnZXQtZGV2ZWxAdmdlci5rZXJuZWwub3JnDQot
LS0NCiBkcml2ZXJzL3RhcmdldC90YXJnZXRfY29yZV9wc2NzaS5jIHwgICAgMyArKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCi0tLSBsaW51eC1u
ZXh0LTIwMjAwNDE3Lm9yaWcvZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfcHNjc2kuYw0KKysr
IGxpbnV4LW5leHQtMjAyMDA0MTcvZHJpdmVycy90YXJnZXQvdGFyZ2V0X2NvcmVfcHNjc2kuYw0K
QEAgLTE4LDYgKzE4LDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxs
aW51eC9zcGlubG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9nZW5oZC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvY2Ryb20uaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcmF0ZWxpbWl0Lmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KQEAgLTYyMSw3ICs2
MjIsNyBAQCBzdGF0aWMgdm9pZCBwc2NzaV9jb21wbGV0ZV9jbWQoc3RydWN0IHNlDQogDQogCQkJ
YnVmID0gdHJhbnNwb3J0X2ttYXBfZGF0YV9zZyhjbWQpOw0KIAkJCWlmICghYnVmKQ0KLQkJCQk7
IC8qIFhYWDogVENNX0xPR0lDQUxfVU5JVF9DT01NVU5JQ0FUSU9OX0ZBSUxVUkUgKi8NCisJCQkJ
ZG9fZW1wdHkoKTsgLyogWFhYOiBUQ01fTE9HSUNBTF9VTklUX0NPTU1VTklDQVRJT05fRkFJTFVS
RSAqLw0KIA0KIAkJCWlmIChjZGJbMF0gPT0gTU9ERV9TRU5TRV8xMCkgew0KIAkJCQlpZiAoIShi
dWZbM10gJiAweDgwKSkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEu
b3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxp
c3RzLjAxLm9yZwo=
