Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C011AF350
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:41:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 81D2A10FC62E5;
	Sat, 18 Apr 2020 11:41:49 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 36FA010FC62E1
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=g1ONOf6MGj3aToaUeBLhJbF3d+tY5CMeHHoXTtmPNsE=; b=RZ4Q2VGMoE1Bka/a+kMpugnl6V
	WMVry8MWAMKA0AfBSRZP5GbN9pJJeG4gjR6sud7qBmDPy8K3i6BprqmwPWH5lOuW2gqRr/Z6Cm0gD
	LgdYYpcS7u+9zN1adQU6TRExKq4DBbaLs/fZ8BFQwxY4cbSn3IER0BNxv3UJFdqify3T+1KdTD2Qi
	vrHfuHPH4Z0QFf2MXKCGJ5k6d3bNzMgrjkWWTemljZSz/KV2Pcv1AoZFf0+EUry4IuzRrudoMMT/C
	ei8L5wfK4u7V/ulhuTnRRFf6mMeS0g5tdTHkmzzebQf9iIBlwwM0f/XqpVSnBSOE3/pCfTfbCtZ3f
	SvwQIVLw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsOw-0007rZ-8d; Sat, 18 Apr 2020 18:41:14 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/9] kernel.h: add do_empty() macro
Date: Sat, 18 Apr 2020 11:41:03 -0700
Message-Id: <20200418184111.13401-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200418184111.13401-1-rdunlap@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID-Hash: TEVGPOZ6HTENYJGDUAKNBEOHGTCJQ7YJ
X-Message-ID-Hash: TEVGPOZ6HTENYJGDUAKNBEOHGTCJQ7YJ
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEVGPOZ6HTENYJGDUAKNBEOHGTCJQ7YJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWRkIHRoZSBkb19lbXB0eSgpIG1hY3JvIHRvIHNpbGVuY2UgZ2NjIHdhcm5pbmdzIGFib3V0IGFu
IGVtcHR5IGJvZHkNCmZvbGxvd2luZyBhbiAiaWYiIHN0YXRlbWVudCB3aGVuIC1XZXh0cmEgaXMg
dXNlZC4NCg0KSG93ZXZlciwgZm9yIGRlYnVnIHByaW50ayBjYWxscyB0aGF0IGFyZSBiZWluZyBk
aXNhYmxlZCwgdXNlIGVpdGhlcg0Kbm9fcHJpbnRrKCkgb3IgcHJfZGVidWcoKSBbYW5kIG9wdGlv
bmFsbHkgZHluYW1pYyBwcmludGsgZGVidWdnaW5nXQ0KaW5zdGVhZC4NCg0KU2lnbmVkLW9mZi1i
eTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpDYzogTGludXMgVG9ydmFs
ZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KQ2M6IEFuZHJldyBNb3J0b24gPGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQpDYzogQWxleGFuZGVyIFZpcm8gPHZpcm9AemVuaXYu
bGludXgub3JnLnVrPg0KQ2M6IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnDQpDYzogRG1p
dHJ5IFRvcm9raG92IDxkbWl0cnkudG9yb2tob3ZAZ21haWwuY29tPg0KQ2M6IGxpbnV4LWlucHV0
QHZnZXIua2VybmVsLm9yZw0KQ2M6IEphcm9zbGF2IEt5c2VsYSA8cGVyZXhAcGVyZXguY3o+DQpD
YzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmNvbT4NCkNjOiBhbHNhLWRldmVsQGFsc2EtcHJv
amVjdC5vcmcNCkNjOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPg0KQ2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCkNjOiAiSi4gQnJ1Y2UgRmllbGRz
IiA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+DQpDYzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+DQpDYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KQ2M6IEpvaGFubmVzIEJl
cmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQpDYzogRGFuIFdpbGxpYW1zIDxkYW4uai53
aWxsaWFtc0BpbnRlbC5jb20+DQpDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRl
bC5jb20+DQpDYzogRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+DQpDYzogbGludXgt
bnZkaW1tQGxpc3RzLjAxLm9yZw0KQ2M6ICJNYXJ0aW4gSy4gUGV0ZXJzZW4iIDxtYXJ0aW4ucGV0
ZXJzZW5Ab3JhY2xlLmNvbT4NCkNjOiBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZw0KQ2M6IHRh
cmdldC1kZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCkNjOiBaenkgV3lzbSA8enp5QHp6eXd5c20uY29t
Pg0KLS0tDQogaW5jbHVkZS9saW51eC9rZXJuZWwuaCB8ICAgIDggKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQoNCi0tLSBsaW51eC1uZXh0LTIwMjAwMzI3Lm9yaWcv
aW5jbHVkZS9saW51eC9rZXJuZWwuaA0KKysrIGxpbnV4LW5leHQtMjAyMDAzMjcvaW5jbHVkZS9s
aW51eC9rZXJuZWwuaA0KQEAgLTQwLDYgKzQwLDE0IEBADQogI2RlZmluZSBSRUFECQkJMA0KICNk
ZWZpbmUgV1JJVEUJCQkxDQogDQorLyoNCisgKiBXaGVuIHVzaW5nIC1XZXh0cmEsIGFuICJpZiIg
c3RhdGVtZW50IGZvbGxvd2VkIGJ5IGFuIGVtcHR5IGJsb2NrDQorICogKGNvbnRhaW5pbmcgb25s
eSBhICc7JyksIHByb2R1Y2VzIGEgd2FybmluZyBmcm9tIGdjYzoNCisgKiB3YXJuaW5nOiBzdWdn
ZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBhbiDigJhpZuKAmSBzdGF0ZW1lbnQgWy1X
ZW1wdHktYm9keV0NCisgKiBSZXBsYWNlIHRoZSBlbXB0eSBib2R5IHdpdGggZG9fZW1wdHkoKSB0
byBzaWxlbmNlIHRoaXMgd2FybmluZy4NCisgKi8NCisjZGVmaW5lIGRvX2VtcHR5KCkJCWRvIHsg
fSB3aGlsZSAoMCkNCisNCiAvKioNCiAgKiBBUlJBWV9TSVpFIC0gZ2V0IHRoZSBudW1iZXIgb2Yg
ZWxlbWVudHMgaW4gYXJyYXkgQGFycg0KICAqIEBhcnI6IGFycmF5IHRvIGJlIHNpemVkCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
