Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FFB1AF34D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:46 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 08D1310FC62DA;
	Sat, 18 Apr 2020 11:41:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5D95810FC3BBA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=a1s3aPpvGKpLdiCJSF1xLoCWRs8yNfGARacikYyrDtI=; b=jiUzn1PA4booMrgyt5t3GsYFr/
	ZqbT1yqWuAseTRoPR1cZ03WbQhbWrvrfb3Shktw7TgEPLJPejITeFAbVpfnenXWRmF7BSdlw5fufc
	5xVlLn5sdiZQghsGwMmWWL3arC3NhWrkyBajNutMr9ImoAPpM5lUCW04FYz0kBfqOP3r4nEhct+h+
	TCAeoRiWqPwZ5aMwlmi2X9WUo2e8C3nduhVceISsZ3l3t8Xh7FJIDIIpigt0+kncqSYZfrE4lZsBt
	6TUBNG1H8zQfQhU58PLzemrg6gBhYWrYtkQmRG8kcbMriC/faW7nNfRC00eH2Qpc13GljIFfSJ2mg
	RiFLp/YA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsP1-0007rZ-9Y; Sat, 18 Apr 2020 18:41:19 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
Date: Sat, 18 Apr 2020 11:41:08 -0700
Message-Id: <20200418184111.13401-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: IJWQ2PKT77QZ2WCGLXXHFLJ7DUHQYCMC
X-Message-ID-Hash: IJWQ2PKT77QZ2WCGLXXHFLJ7DUHQYCMC
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IJWQ2PKT77QZ2WCGLXXHFLJ7DUHQYCMC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Zz
L25mc2QvbmZzNHN0YXRlLmM6Mzg5ODozOiB3YXJuaW5nOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQg
ZW1wdHkgYm9keSBpbiBhbiDigJhlbHNl4oCZIHN0YXRlbWVudCBbLVdlbXB0eS1ib2R5XQ0KDQpT
aWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCkNjOiBM
aW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiAiSi4gQnJ1Y2UgRmllbGRz
IiA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+DQpDYzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+DQpDYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KLS0tDQogZnMvbmZzZC9u
ZnM0c3RhdGUuYyB8ICAgIDMgKystDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KDQotLS0gbGludXgtbmV4dC0yMDIwMDQxNy5vcmlnL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCisrKyBsaW51eC1uZXh0LTIwMjAwNDE3L2ZzL25mc2QvbmZzNHN0YXRlLmMNCkBA
IC0zNCw2ICszNCw3IEBADQogDQogI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4NCiAjaW5jbHVkZSA8
bGludXgvZnMuaD4NCisjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQogI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvbmFtZWkuaD4NCiAjaW5jbHVkZSA8bGludXgvc3dh
cC5oPg0KQEAgLTM4OTUsNyArMzg5Niw3IEBAIG5mc2Q0X3NldGNsaWVudGlkKHN0cnVjdCBzdmNf
cnFzdCAqcnFzdHANCiAJCWNvcHlfY2xpZChuZXcsIGNvbmYpOw0KIAkJZ2VuX2NvbmZpcm0obmV3
LCBubik7DQogCX0gZWxzZSAvKiBjYXNlIDQgKG5ldyBjbGllbnQpIG9yIGNhc2VzIDIsIDMgKGNs
aWVudCByZWJvb3QpOiAqLw0KLQkJOw0KKwkJZG9fZW1wdHkoKTsNCiAJbmV3LT5jbF9taW5vcnZl
cnNpb24gPSAwOw0KIAlnZW5fY2FsbGJhY2sobmV3LCBzZXRjbGlkLCBycXN0cCk7DQogCWFkZF90
b191bmNvbmZpcm1lZChuZXcpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
