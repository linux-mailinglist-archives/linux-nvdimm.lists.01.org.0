Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8EF1AF3F3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:57:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0367110FC62E7;
	Sat, 18 Apr 2020 11:57:44 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AC37E10FC62D3
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=v6goMSiM3JqD5eRdn45ZDeyVAxJCt3W7fqpeEGrJJtc=; b=KyiJJMamxfOIjVFL72tLsYD7re
	sd31vDw2o9XAGj4cjlL0iY4LlaG6HfVp+RX/eAnF8cs7BFGA7rm1P50OIDl4CJaSxdZP9IFpIodWa
	qKFndBfM+66S0aonynhdQTK/wJPSVS1Y4GHEToI5QjfeKxEM5UcdrBqdzJ3gwI+cd+itnETKujVao
	no3xr+EdUuBl8Nn1gwFz9atcofq1XkfodTx5dSOb3avPvgI/1CgyqkUdIR/uY0+1yXAWS0ASg6Ion
	xZd3LmWJA+40BpAwWMUlGbYNQaWIgBlBDowZN86RmjMlnIBdG8kobJ5e86SBZIZs/svVAtt0wyDuC
	yjEBGuCw==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPseh-0000VM-7j; Sat, 18 Apr 2020 18:57:31 +0000
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To: Joe Perches <joe@perches.com>, Chuck Lever <chuck.lever@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
 <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c13ddc03-dfb4-9664-ce38-fc56389b67cd@infradead.org>
Date: Sat, 18 Apr 2020 11:57:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
Content-Language: en-US
Message-ID-Hash: NX46HTWICGR4UG2XZGFOUVTZI4ZXQMFF
X-Message-ID-Hash: NX46HTWICGR4UG2XZGFOUVTZI4ZXQMFF
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>, Linux NFS Mailing List <linux-nfs@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NX46HTWICGR4UG2XZGFOUVTZI4ZXQMFF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gNC8xOC8yMCAxMTo1MyBBTSwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+IE9uIFNhdCwgMjAyMC0w
NC0xOCBhdCAxNDo0NSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gT24gQXByIDE4LCAy
MDIwLCBhdCAyOjQxIFBNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4gd3Jv
dGU6DQo+Pj4NCj4+PiBGaXggZ2NjIGVtcHR5LWJvZHkgd2FybmluZyB3aGVuIC1XZXh0cmEgaXMg
dXNlZDoNCj4+Pg0KPj4+IC4uL2ZzL25mc2QvbmZzNHN0YXRlLmM6Mzg5ODozOiB3YXJuaW5nOiBz
dWdnZXN0IGJyYWNlcyBhcm91bmQgZW1wdHkgYm9keSBpbiBhbiDigJhlbHNl4oCZIHN0YXRlbWVu
dCBbLVdlbXB0eS1ib2R5XQ0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+Pj4gQ2M6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0Bs
aW51eC1mb3VuZGF0aW9uLm9yZz4NCj4+PiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz4NCj4+PiBDYzogIkouIEJydWNlIEZpZWxkcyIgPGJmaWVsZHNAZmllbGRz
ZXMub3JnPg0KPj4+IENjOiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+
PiBDYzogbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KPj4NCj4+IEkgaGF2ZSBhIHBhdGNoIGlu
IG15IHF1ZXVlIHRoYXQgYWRkcmVzc2VzIHRoaXMgcGFydGljdWxhciB3YXJuaW5nLA0KPj4gYnV0
IHlvdXIgY2hhbmdlIHdvcmtzIGZvciBtZSB0b28uDQo+Pg0KPj4gQWNrZWQtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4NCj4+IFVubGVzcyBCcnVjZSBvYmplY3Rz
Lg0KPj4NCj4+DQo+Pj4gLS0tDQo+Pj4gZnMvbmZzZC9uZnM0c3RhdGUuYyB8ICAgIDMgKystDQo+
Pj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+
Pj4gLS0tIGxpbnV4LW5leHQtMjAyMDA0MTcub3JpZy9mcy9uZnNkL25mczRzdGF0ZS5jDQo+Pj4g
KysrIGxpbnV4LW5leHQtMjAyMDA0MTcvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPj4+IEBAIC0zNCw2
ICszNCw3IEBADQo+Pj4NCj4+PiAjaW5jbHVkZSA8bGludXgvZmlsZS5oPg0KPj4+ICNpbmNsdWRl
IDxsaW51eC9mcy5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQo+Pj4gI2luY2x1
ZGUgPGxpbnV4L3NsYWIuaD4NCj4+PiAjaW5jbHVkZSA8bGludXgvbmFtZWkuaD4NCj4+PiAjaW5j
bHVkZSA8bGludXgvc3dhcC5oPg0KPj4+IEBAIC0zODk1LDcgKzM4OTYsNyBAQCBuZnNkNF9zZXRj
bGllbnRpZChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwDQo+Pj4gCQljb3B5X2NsaWQobmV3LCBjb25m
KTsNCj4+PiAJCWdlbl9jb25maXJtKG5ldywgbm4pOw0KPj4+IAl9IGVsc2UgLyogY2FzZSA0IChu
ZXcgY2xpZW50KSBvciBjYXNlcyAyLCAzIChjbGllbnQgcmVib290KTogKi8NCj4+PiAtCQk7DQo+
Pj4gKwkJZG9fZW1wdHkoKTsNCj4+PiAJbmV3LT5jbF9taW5vcnZlcnNpb24gPSAwOw0KPj4+IAln
ZW5fY2FsbGJhY2sobmV3LCBzZXRjbGlkLCBycXN0cCk7DQo+Pj4gCWFkZF90b191bmNvbmZpcm1l
ZChuZXcpOw0KPiANCj4gVGhpcyBlbXB0eSBlbHNlIHNlZW1zIHNpbGx5IGFuZCBjb3VsZCBsaWtl
bHkgYmUgYmV0dGVyIGhhbmRsZWQgYnkNCj4gYSBjb21tZW50IGFib3ZlIHRoZSBmaXJzdCBpZiwg
c29tZXRoaW5nIGxpa2U6DQo+IA0KPiAJLyogZm9yIG5vdyBvbmx5IGhhbmRsZSBjYXNlIDE6IHBy
b2JhYmxlIGNhbGxiYWNrIHVwZGF0ZSAqLw0KPiAJaWYgKGNvbmYgJiYgc2FtZV92ZXJmKCZjb25m
LT5jbF92ZXJpZmllciwgJmNsdmVyaWZpZXIpKSB7DQo+IAkJY29weV9jbGlkKG5ldywgY29uZik7
DQo+IAkJZ2VuX2NvbmZpcm0obmV3LCBubik7DQo+IAl9DQo+IA0KPiB3aXRoIG5vIGVsc2UgdXNl
Lg0KDQpJJ2xsIGp1c3QgbGV0IENodWNrIGhhbmRsZSBpdCB3aXRoIGhpcyBjdXJyZW50IHBhdGNo
LA0Kd2hhdGV2ZXIgaXQgaXMuDQoNCnRoYW5rcy4NCi0tIA0KflJhbmR5DQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBl
bWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEub3JnCg==
