Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879401AF34F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 569AA10FC62E1;
	Sat, 18 Apr 2020 11:41:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DD5A10FC3BBA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=8++U0J0JftLda//wkFlmbDic7vW6wvPQj9vRP451qyE=; b=pyHV1YjuYgoOSvT5iNE2Y7QesB
	NXrQxVgUayq4HjgeqKsk2tapY3tZ0T5adrg2tRGVb9UDxjDW8Ymr23ZQvkVi+4TN/ycZwkIUkaudG
	oGMqI5Zd6s+C1gyru6NOrS5ZFX1JqPWuYEb45qk0a5RAHpEztnjpgk8xMtaZ2YEB2mXtj14HUzOUk
	LVAd8pg4/P6e1JpzKE3ulBSzOtFhS8JXHt+oL461ce4TL035IHm65XTXUhN54RnOcQ2jZv7YhSCS+
	V6nVFKIksP8CDgK7V6ubm5iolAEN2qiHG681gjIL3NBvd9hAfq4bMBMyPZ7R3p3jHd0ZxUtJLl1rc
	SIUUC5lg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsP0-0007rZ-CC; Sat, 18 Apr 2020 18:41:18 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
Date: Sat, 18 Apr 2020 11:41:07 -0700
Message-Id: <20200418184111.13401-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: VXQDOEDNAOVRDDT3ZSFIQTRZAF7YKQFS
X-Message-ID-Hash: VXQDOEDNAOVRDDT3ZSFIQTRZAF7YKQFS
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXQDOEDNAOVRDDT3ZSFIQTRZAF7YKQFS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Ry
aXZlcnMvdXNiL2NvcmUvc3lzZnMuYzogSW4gZnVuY3Rpb24g4oCYdXNiX2NyZWF0ZV9zeXNmc19p
bnRmX2ZpbGVz4oCZOg0KLi4vZHJpdmVycy91c2IvY29yZS9zeXNmcy5jOjEyNjY6Mzogd2Fybmlu
Zzogc3VnZ2VzdCBicmFjZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCYaWbigJkgc3RhdGVt
ZW50IFstV2VtcHR5LWJvZHldDQogICA7IC8qIFdlIGRvbid0IGFjdHVhbGx5IGNhcmUgaWYgdGhl
IGZ1bmN0aW9uIGZhaWxzLiAqLw0KICAgXg0KDQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPg0KQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBM
aW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCi0tLQ0KIGRyaXZlcnMvdXNiL2Nv
cmUvc3lzZnMuYyB8ICAgIDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KLS0tIGxpbnV4LW5leHQtMjAyMDAzMjcub3JpZy9kcml2ZXJzL3VzYi9j
b3JlL3N5c2ZzLmMNCisrKyBsaW51eC1uZXh0LTIwMjAwMzI3L2RyaXZlcnMvdXNiL2NvcmUvc3lz
ZnMuYw0KQEAgLTEyNjMsNyArMTI2Myw3IEBAIHZvaWQgdXNiX2NyZWF0ZV9zeXNmc19pbnRmX2Zp
bGVzKHN0cnVjdA0KIAlpZiAoIWFsdC0+c3RyaW5nICYmICEodWRldi0+cXVpcmtzICYgVVNCX1FV
SVJLX0NPTkZJR19JTlRGX1NUUklOR1MpKQ0KIAkJYWx0LT5zdHJpbmcgPSB1c2JfY2FjaGVfc3Ry
aW5nKHVkZXYsIGFsdC0+ZGVzYy5pSW50ZXJmYWNlKTsNCiAJaWYgKGFsdC0+c3RyaW5nICYmIGRl
dmljZV9jcmVhdGVfZmlsZSgmaW50Zi0+ZGV2LCAmZGV2X2F0dHJfaW50ZXJmYWNlKSkNCi0JCTsJ
LyogV2UgZG9uJ3QgYWN0dWFsbHkgY2FyZSBpZiB0aGUgZnVuY3Rpb24gZmFpbHMuICovDQorCQlk
b19lbXB0eSgpOyAvKiBXZSBkb24ndCBhY3R1YWxseSBjYXJlIGlmIHRoZSBmdW5jdGlvbiBmYWls
cy4gKi8NCiAJaW50Zi0+c3lzZnNfZmlsZXNfY3JlYXRlZCA9IDE7DQogfQ0KIApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGlu
ZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBh
biBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
