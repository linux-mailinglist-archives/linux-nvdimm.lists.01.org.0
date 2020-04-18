Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDC91AF3E7
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:56:06 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9D57910FC62E1;
	Sat, 18 Apr 2020 11:56:12 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=216.40.44.186; helo=smtprelay.hostedemail.com; envelope-from=joe@perches.com; receiver=<UNKNOWN> 
Received: from smtprelay.hostedemail.com (smtprelay0186.hostedemail.com [216.40.44.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B2A0510FC62DF
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:56:10 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay06.hostedemail.com (Postfix) with ESMTP id BBBA618018500;
	Sat, 18 Apr 2020 18:56:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2895:3138:3139:3140:3141:3142:3353:3622:3865:3868:3870:3871:3874:4321:5007:6119:6742:6743:7875:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12895:12986:13069:13311:13357:13894:14096:14097:14181:14659:14721:21080:21451:21627:21660:21740:30054:30060:30064:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:14,LUA_SUMMARY:none
X-HE-Tag: money21_1707d78e8f515
X-Filterd-Recvd-Size: 3611
Received: from XPS-9350.home (unknown [47.151.136.130])
	(Authenticated sender: joe@perches.com)
	by omf03.hostedemail.com (Postfix) with ESMTPA;
	Sat, 18 Apr 2020 18:55:58 +0000 (UTC)
Message-ID: <6c796219ea79d87093409f2dd1d3bf8e4a157ed7.camel@perches.com>
Subject: Re: [PATCH 6/9] nfsd: fix empty-body warning in nfs4state.c
From: Joe Perches <joe@perches.com>
To: Chuck Lever <chuck.lever@oracle.com>, Randy Dunlap
 <rdunlap@infradead.org>
Date: Sat, 18 Apr 2020 11:53:44 -0700
In-Reply-To: <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
	 <20200418184111.13401-7-rdunlap@infradead.org>
	 <CDCF7717-7CBC-47CA-9E83-3A18ECB3AB89@oracle.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Message-ID-Hash: YTXPZ75HHDHC4EHZQWZQG5FAZLFCGOQ7
X-Message-ID-Hash: YTXPZ75HHDHC4EHZQWZQG5FAZLFCGOQ7
X-MailFrom: joe@perches.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Bruce Fields <bfields@fieldses.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org,
	"Martin K."@ml01.01.org, Petersen@ml01.01.org,
	" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, "@ml01.01.org,
	target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YTXPZ75HHDHC4EHZQWZQG5FAZLFCGOQ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCAyMDIwLTA0LTE4IGF0IDE0OjQ1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
PiBPbiBBcHIgMTgsIDIwMjAsIGF0IDI6NDEgUE0sIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZy
YWRlYWQub3JnPiB3cm90ZToNCj4gPiANCj4gPiBGaXggZ2NjIGVtcHR5LWJvZHkgd2FybmluZyB3
aGVuIC1XZXh0cmEgaXMgdXNlZDoNCj4gPiANCj4gPiAuLi9mcy9uZnNkL25mczRzdGF0ZS5jOjM4
OTg6Mzogd2FybmluZzogc3VnZ2VzdCBicmFjZXMgYXJvdW5kIGVtcHR5IGJvZHkgaW4gYW4g4oCY
ZWxzZeKAmSBzdGF0ZW1lbnQgWy1XZW1wdHktYm9keV0NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPiBDYzogTGludXMgVG9y
dmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiBBbmRyZXcgTW9y
dG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiA+IENjOiAiSi4gQnJ1Y2UgRmllbGRz
IiA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+DQo+ID4gQ2M6IENodWNrIExldmVyIDxjaHVjay5sZXZl
ckBvcmFjbGUuY29tPg0KPiA+IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBJ
IGhhdmUgYSBwYXRjaCBpbiBteSBxdWV1ZSB0aGF0IGFkZHJlc3NlcyB0aGlzIHBhcnRpY3VsYXIg
d2FybmluZywNCj4gYnV0IHlvdXIgY2hhbmdlIHdvcmtzIGZvciBtZSB0b28uDQo+IA0KPiBBY2tl
ZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBVbmxlc3Mg
QnJ1Y2Ugb2JqZWN0cy4NCj4gDQo+IA0KPiA+IC0tLQ0KPiA+IGZzL25mc2QvbmZzNHN0YXRlLmMg
fCAgICAzICsrLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPiANCj4gPiAtLS0gbGludXgtbmV4dC0yMDIwMDQxNy5vcmlnL2ZzL25mc2QvbmZz
NHN0YXRlLmMNCj4gPiArKysgbGludXgtbmV4dC0yMDIwMDQxNy9mcy9uZnNkL25mczRzdGF0ZS5j
DQo+ID4gQEAgLTM0LDYgKzM0LDcgQEANCj4gPiANCj4gPiAjaW5jbHVkZSA8bGludXgvZmlsZS5o
Pg0KPiA+ICNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgva2VybmVs
Lmg+DQo+ID4gI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAjaW5jbHVkZSA8bGludXgvbmFt
ZWkuaD4NCj4gPiAjaW5jbHVkZSA8bGludXgvc3dhcC5oPg0KPiA+IEBAIC0zODk1LDcgKzM4OTYs
NyBAQCBuZnNkNF9zZXRjbGllbnRpZChzdHJ1Y3Qgc3ZjX3Jxc3QgKnJxc3RwDQo+ID4gCQljb3B5
X2NsaWQobmV3LCBjb25mKTsNCj4gPiAJCWdlbl9jb25maXJtKG5ldywgbm4pOw0KPiA+IAl9IGVs
c2UgLyogY2FzZSA0IChuZXcgY2xpZW50KSBvciBjYXNlcyAyLCAzIChjbGllbnQgcmVib290KTog
Ki8NCj4gPiAtCQk7DQo+ID4gKwkJZG9fZW1wdHkoKTsNCj4gPiAJbmV3LT5jbF9taW5vcnZlcnNp
b24gPSAwOw0KPiA+IAlnZW5fY2FsbGJhY2sobmV3LCBzZXRjbGlkLCBycXN0cCk7DQo+ID4gCWFk
ZF90b191bmNvbmZpcm1lZChuZXcpOw0KDQpUaGlzIGVtcHR5IGVsc2Ugc2VlbXMgc2lsbHkgYW5k
IGNvdWxkIGxpa2VseSBiZSBiZXR0ZXIgaGFuZGxlZCBieQ0KYSBjb21tZW50IGFib3ZlIHRoZSBm
aXJzdCBpZiwgc29tZXRoaW5nIGxpa2U6DQoNCgkvKiBmb3Igbm93IG9ubHkgaGFuZGxlIGNhc2Ug
MTogcHJvYmFibGUgY2FsbGJhY2sgdXBkYXRlICovDQoJaWYgKGNvbmYgJiYgc2FtZV92ZXJmKCZj
b25mLT5jbF92ZXJpZmllciwgJmNsdmVyaWZpZXIpKSB7DQoJCWNvcHlfY2xpZChuZXcsIGNvbmYp
Ow0KCQlnZW5fY29uZmlybShuZXcsIG5uKTsNCgl9DQoNCndpdGggbm8gZWxzZSB1c2UuDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGlt
bSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmli
ZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
