Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D271B1AF34E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2BDF810FC62DD;
	Sat, 18 Apr 2020 11:41:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67FE910FC3BBA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=Z/ABBV2vtDLyfRcjamC38HwxTrQtSwsZcb0OzbkWsUE=; b=rJ3FSC6+DaZYG5qDC0wUPtN1SQ
	6kc24pbTmZHwpWQG5VbJcOvhSND5w9lvWyU0STq3J5awSJ+mQGR6mBrLgoi2n3O6n9Jw35QUg9Y74
	9mmpZhqsG2g9ClzjoUATTOR7PYeSeWpeoKr+IpZYuUcbVJVRFfFgNbPYgpOz2vwvO1ArJnNTugkXf
	e5UqMYAoTNEErclRAZHOgSgCt9idLwF4FUQ0aYMp3ZrqvF+UofS5GPLc/CzBRVxKIeIMKMq5oaCq0
	LHXEtvPs6ntRLkN71ahJU4FlZPCqVhnccZu4pp1C/uv0wBPvLn5xg26bBKm46QINfwvrPOOMyxieh
	11sA8ibQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsP2-0007rZ-8t; Sat, 18 Apr 2020 18:41:20 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] drivers/base: fix empty-body warnings in devcoredump.c
Date: Sat, 18 Apr 2020 11:41:09 -0700
Message-Id: <20200418184111.13401-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: DH36BQH6C5XLRSVLFSKEEV4VZVZTA47L
X-Message-ID-Hash: DH36BQH6C5XLRSVLFSKEEV4VZVZTA47L
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DH36BQH6C5XLRSVLFSKEEV4VZVZTA47L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

Rml4IGdjYyBlbXB0eS1ib2R5IHdhcm5pbmcgd2hlbiAtV2V4dHJhIGlzIHVzZWQ6DQoNCi4uL2Ry
aXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jOjI5Nzo0Mjogd2FybmluZzogc3VnZ2VzdCBicmFjZXMg
YXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCYaWbigJkgc3RhdGVtZW50IFstV2VtcHR5LWJvZHld
DQouLi9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYzozMDE6NDI6IHdhcm5pbmc6IHN1Z2dlc3Qg
YnJhY2VzIGFyb3VuZCBlbXB0eSBib2R5IGluIGFuIOKAmGlm4oCZIHN0YXRlbWVudCBbLVdlbXB0
eS1ib2R5XQ0KDQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz4NCkNjOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KQ2M6
IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCkNjOiBBbmRy
ZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KLS0tDQogZHJpdmVycy9iYXNl
L2RldmNvcmVkdW1wLmMgfCAgICA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCg0KLS0tIGxpbnV4LW5leHQtMjAyMDA0MTcub3JpZy9kcml2
ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYw0KKysrIGxpbnV4LW5leHQtMjAyMDA0MTcvZHJpdmVycy9i
YXNlL2RldmNvcmVkdW1wLmMNCkBAIC05LDYgKzksNyBAQA0KICAqDQogICogQXV0aG9yOiBKb2hh
bm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KICAqLw0KKyNpbmNsdWRlIDxs
aW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9kZXZjb3JlZHVtcC5oPg0KQEAgLTI5NCwx
MSArMjk1LDExIEBAIHZvaWQgZGV2X2NvcmVkdW1wbShzdHJ1Y3QgZGV2aWNlICpkZXYsIHMNCiAN
CiAJaWYgKHN5c2ZzX2NyZWF0ZV9saW5rKCZkZXZjZC0+ZGV2Y2RfZGV2LmtvYmosICZkZXYtPmtv
YmosDQogCQkJICAgICAgImZhaWxpbmdfZGV2aWNlIikpDQotCQkvKiBub3RoaW5nIC0gc3ltbGlu
ayB3aWxsIGJlIG1pc3NpbmcgKi87DQorCQlkb19lbXB0eSgpOyAvKiBub3RoaW5nIC0gc3ltbGlu
ayB3aWxsIGJlIG1pc3NpbmcgKi8NCiANCiAJaWYgKHN5c2ZzX2NyZWF0ZV9saW5rKCZkZXYtPmtv
YmosICZkZXZjZC0+ZGV2Y2RfZGV2LmtvYmosDQogCQkJICAgICAgImRldmNvcmVkdW1wIikpDQot
CQkvKiBub3RoaW5nIC0gc3ltbGluayB3aWxsIGJlIG1pc3NpbmcgKi87DQorCQlkb19lbXB0eSgp
OyAvKiBub3RoaW5nIC0gc3ltbGluayB3aWxsIGJlIG1pc3NpbmcgKi8NCiANCiAJSU5JVF9ERUxB
WUVEX1dPUksoJmRldmNkLT5kZWxfd2ssIGRldmNkX2RlbCk7DQogCXNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmZGV2Y2QtPmRlbF93aywgREVWQ0RfVElNRU9VVCk7Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0g
bGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRv
IGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
