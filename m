Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF201AF575
	for <lists+linux-nvdimm@lfdr.de>; Sun, 19 Apr 2020 00:32:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 675E010FC62FA;
	Sat, 18 Apr 2020 15:32:31 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECF2710FC62F8
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=zyG1QPS3RY2nWyGdHwcEoZL1dyrlEFupJ3Qi8VlAHRo=; b=loO7QmrtjVUfmmDDXVlI56bim3
	vaQVMQJheKFM/fE/1PTtCTTNe5XzeE/U7X2nTTSIWa2jsTphcpKDjL38BHOFJmFjIERkw1AXdISWE
	voAskfcYnobN2Cg1+P9xUb2INjXTpWf5cHvlbdHJX8AvFR/Nh2KWcL+zidNsbp7aa5RWLcbm4tdBY
	Q0wqgJei4sy2H6/qPY4WvoBul6hgnZd/9ZU74LcYk0mKxiyoJ+abZZmI+6EKaHmhxW62rGd+bzcYi
	uN5aQpL4TxGWtDU3C4cNci1ZCHm1UWwy33ZzvpUBRGHVtwzMJ6QU7jRANEHTNyCknHb8PG26nUhi/
	eFavfSdg==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPw0Q-0000cZ-8H; Sat, 18 Apr 2020 22:32:10 +0000
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
To: Trond Myklebust <trondmy@hammerspace.com>,
 "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-7-rdunlap@infradead.org>
 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
 <d2e2f7967804446a825ec0ff61095e6640b5a968.camel@hammerspace.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c838fc1d-3973-9cd8-ecc6-8739af514dd0@infradead.org>
Date: Sat, 18 Apr 2020 15:32:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d2e2f7967804446a825ec0ff61095e6640b5a968.camel@hammerspace.com>
Content-Language: en-US
Message-ID-Hash: MS5TA7WHCNB22E4SDWENQARE7J4VOQS6
X-Message-ID-Hash: MS5TA7WHCNB22E4SDWENQARE7J4VOQS6
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "bfields@fieldses.org" <bfields@fieldses.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "zzy@zzywysm.com" <zzy@zzywysm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "johannes@sipsolutions.net" <johannes@sipsolutions.net>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alsa-deve
 l@alsa-project.org" <alsa-devel@alsa-project.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MS5TA7WHCNB22E4SDWENQARE7J4VOQS6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gNC8xOC8yMCAzOjI4IFBNLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+IE9uIFNhdCwgMjAy
MC0wNC0xOCBhdCAxNDo0NSAtMDQwMCwgQ2h1Y2sgTGV2ZXIgd3JvdGU6DQo+Pj4gT24gQXByIDE4
LCAyMDIwLCBhdCAyOjQxIFBNLCBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4N
Cj4+PiB3cm90ZToNCj4+Pg0KPj4+IEZpeCBnY2MgZW1wdHktYm9keSB3YXJuaW5nIHdoZW4gLVdl
eHRyYSBpcyB1c2VkOg0KPj4+DQo+Pj4gLi4vZnMvbmZzZC9uZnM0c3RhdGUuYzozODk4OjM6IHdh
cm5pbmc6IHN1Z2dlc3QgYnJhY2VzIGFyb3VuZCBlbXB0eQ0KPj4+IGJvZHkgaW4gYW4g4oCYZWxz
ZeKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFJh
bmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPj4+IENjOiBMaW51cyBUb3J2YWxk
cyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+Pj4gQ2M6IEFuZHJldyBNb3J0b24g
PGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+Pj4gQ2M6ICJKLiBCcnVjZSBGaWVsZHMiIDxi
ZmllbGRzQGZpZWxkc2VzLm9yZz4NCj4+PiBDYzogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9y
YWNsZS5jb20+DQo+Pj4gQ2M6IGxpbnV4LW5mc0B2Z2VyLmtlcm5lbC5vcmcNCj4+DQo+PiBJIGhh
dmUgYSBwYXRjaCBpbiBteSBxdWV1ZSB0aGF0IGFkZHJlc3NlcyB0aGlzIHBhcnRpY3VsYXIgd2Fy
bmluZywNCj4+IGJ1dCB5b3VyIGNoYW5nZSB3b3JrcyBmb3IgbWUgdG9vLg0KPj4NCj4+IEFja2Vk
LWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xlLmNvbT4NCj4+DQo+PiBVbmxlc3Mg
QnJ1Y2Ugb2JqZWN0cy4NCj4+DQo+Pg0KPj4+IC0tLQ0KPj4+IGZzL25mc2QvbmZzNHN0YXRlLmMg
fCAgICAzICsrLQ0KPj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+Pg0KPj4+IC0tLSBsaW51eC1uZXh0LTIwMjAwNDE3Lm9yaWcvZnMvbmZzZC9uZnM0
c3RhdGUuYw0KPj4+ICsrKyBsaW51eC1uZXh0LTIwMjAwNDE3L2ZzL25mc2QvbmZzNHN0YXRlLmMN
Cj4+PiBAQCAtMzQsNiArMzQsNyBAQA0KPj4+DQo+Pj4gI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4N
Cj4+PiAjaW5jbHVkZSA8bGludXgvZnMuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPj4+ICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQo+Pj4gI2luY2x1ZGUgPGxpbnV4L25hbWVp
Lmg+DQo+Pj4gI2luY2x1ZGUgPGxpbnV4L3N3YXAuaD4NCj4+PiBAQCAtMzg5NSw3ICszODk2LDcg
QEAgbmZzZDRfc2V0Y2xpZW50aWQoc3RydWN0IHN2Y19ycXN0ICpycXN0cA0KPj4+IAkJY29weV9j
bGlkKG5ldywgY29uZik7DQo+Pj4gCQlnZW5fY29uZmlybShuZXcsIG5uKTsNCj4+PiAJfSBlbHNl
IC8qIGNhc2UgNCAobmV3IGNsaWVudCkgb3IgY2FzZXMgMiwgMyAoY2xpZW50IHJlYm9vdCk6ICov
DQo+Pj4gLQkJOw0KPj4+ICsJCWRvX2VtcHR5KCk7DQo+IA0KPiBVcmdoLi4uIFRoaXMgaXMganVz
dCBmb3IgZG9jdW1lbnRhdGlvbiBwdXJwb3NlcyBhbnl3YXksIHNvIHdoeSBub3QganVzdA0KPiB0
dXJuIGl0IGFsbCBpbnRvIGEgY29tbWVudCBieSBtb3ZpbmcgdGhlICdlbHNlJyBpbnRvIHRoZSBj
b21tZW50IGZpZWxkPw0KPiANCj4gaS5lLg0KPiAJfSAvKiBlbHNlIGNhc2UgNCAoLi4uLiAqLw0K
PiANCj4gCW5ldy0+Y2xfbWlub3J2ZXJzaW9uID0gMDsNCj4+PiAJZ2VuX2NhbGxiYWNrKG5ldywg
c2V0Y2xpZCwgcnFzdHApOw0KPj4+IAlhZGRfdG9fdW5jb25maXJtZWQobmV3KTsNCg0KTGlrZSBJ
IHNhaWQgZWFybGllciwgc2luY2UgQ2h1Y2sgaGFzIGEgcGF0Y2ggdGhhdCBhZGRyZXNzZXMgdGhp
cywNCmxldCdzIGp1c3QgZ28gd2l0aCB0aGF0Lg0KDQp0aGFua3MuDQotLSANCn5SYW5keQ0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1t
IG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJl
IHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
