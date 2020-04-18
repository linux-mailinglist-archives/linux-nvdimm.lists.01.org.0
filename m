Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC21AF34C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E84FC10FC62D6;
	Sat, 18 Apr 2020 11:41:45 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 05C0810FC62C5
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=RAwgh7dK6Aq2GUmD2z2q67RSpKe0Qba5fsNnenVzxMI=; b=j5q/SQ1+k3/+/NWSTV/WCIkHyr
	zch6FAcwYZsrW1PmSwaW8sUH6ZWeOC45ea2Cw5ovOtRwJLJOkQhRg13tWis5r+icV/DhjmdEjwv79
	s2h+fCIcRl3RnLCdtSGFczimDTd9m/8AzLPWV2hp+UzgF8z2XnH0R/f/a5DQg9nNd3Y73Ad9ZrO4P
	SE8YtJq+oauVuVNS6MyEi2RLVp6TVtw40sWJHw1JEOXlVu7aGBz0X1bug3Vw49BLE3fO57MGGN/q0
	Pmq5oXAMF6sIRcv8GgeZALDInNNSJ4NKJzYxSO84gAsonX87pABbmdSy94HL9m+wa0jkyxTrzud66
	2h6YWfaA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsP3-0007rZ-5p; Sat, 18 Apr 2020 18:41:21 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] dax: fix empty-body warnings in bus.c
Date: Sat, 18 Apr 2020 11:41:10 -0700
Message-Id: <20200418184111.13401-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: NO3P4NNRPVVXEV7P426RPJDODFBPX22E
X-Message-ID-Hash: NO3P4NNRPVVXEV7P426RPJDODFBPX22E
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NO3P4NNRPVVXEV7P426RPJDODFBPX22E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Ry
aXZlcnMvZGF4L2J1cy5jOjkzOjI3OiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgZW1w
dHkgYm9keSBpbiBhbiDigJhlbHNl4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0KLi4vZHJp
dmVycy9kYXgvYnVzLmM6OTg6Mjk6IHdhcm5pbmc6IHN1Z2dlc3QgYnJhY2VzIGFyb3VuZCBlbXB0
eSBib2R5IGluIGFuIOKAmGVsc2XigJkgc3RhdGVtZW50IFstV2VtcHR5LWJvZHldDQoNClNpZ25l
ZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KQ2M6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KQ2M6IFZpc2hhbCBWZXJtYSA8dmlz
aGFsLmwudmVybWFAaW50ZWwuY29tPg0KQ2M6IERhdmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwu
Y29tPg0KQ2M6IGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcNCkNjOiBMaW51cyBUb3J2YWxkcyA8
dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCi0tLQ0KIGRyaXZlcnMvZGF4L2J1cy5jIHwgICAgNSArKyst
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCi0t
LSBsaW51eC1uZXh0LTIwMjAwNDE3Lm9yaWcvZHJpdmVycy9kYXgvYnVzLmMNCisrKyBsaW51eC1u
ZXh0LTIwMjAwNDE3L2RyaXZlcnMvZGF4L2J1cy5jDQpAQCAtMiw2ICsyLDcgQEANCiAvKiBDb3B5
cmlnaHQoYykgMjAxNy0yMDE4IEludGVsIENvcnBvcmF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVk
LiAqLw0KICNpbmNsdWRlIDxsaW51eC9tZW1yZW1hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9kZXZp
Y2UuaD4NCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4L211dGV4
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0K
QEAgLTkwLDEyICs5MSwxMiBAQCBzdGF0aWMgc3NpemVfdCBkb19pZF9zdG9yZShzdHJ1Y3QgZGV2
aWNlDQogCQkJfSBlbHNlDQogCQkJCXJjID0gLUVOT01FTTsNCiAJCX0gZWxzZQ0KLQkJCS8qIG5v
dGhpbmcgdG8gcmVtb3ZlICovOw0KKwkJCWRvX2VtcHR5KCk7IC8qIG5vdGhpbmcgdG8gcmVtb3Zl
ICovDQogCX0gZWxzZSBpZiAoYWN0aW9uID09IElEX1JFTU9WRSkgew0KIAkJbGlzdF9kZWwoJmRh
eF9pZC0+bGlzdCk7DQogCQlrZnJlZShkYXhfaWQpOw0KIAl9IGVsc2UNCi0JCS8qIGRheF9pZCBh
bHJlYWR5IGFkZGVkICovOw0KKwkJZG9fZW1wdHkoKTsgLyogZGF4X2lkIGFscmVhZHkgYWRkZWQg
Ki8NCiAJbXV0ZXhfdW5sb2NrKCZkYXhfYnVzX2xvY2spOw0KIA0KIAlpZiAocmMgPCAwKQpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0g
bWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUg
c2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
