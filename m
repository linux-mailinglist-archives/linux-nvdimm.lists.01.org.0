Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B373339E1F
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Mar 2021 14:11:45 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8EEF9100EF275;
	Sat, 13 Mar 2021 05:11:41 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=51.83.246.204; helo=tartarus.angband.pl; envelope-from=kilobyte@angband.pl; receiver=<UNKNOWN> 
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7BDB8100EF270
	for <linux-nvdimm@lists.01.org>; Sat, 13 Mar 2021 05:11:36 -0800 (PST)
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94)
	(envelope-from <kilobyte@angband.pl>)
	id 1lL3yz-00GJp4-Ak; Sat, 13 Mar 2021 14:07:05 +0100
Date: Sat, 13 Mar 2021 14:07:05 +0100
From: Adam Borowski <kilobyte@angband.pl>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Message-ID: <YEy4+SPUvQkL44PQ@angband.pl>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org>
 <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310142643.GQ3479805@casper.infradead.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Message-ID-Hash: 2ZS2WQJOFQPG3CPLF5ELK5WMLMTN6QQV
X-Message-ID-Hash: 2ZS2WQJOFQPG3CPLF5ELK5WMLMTN6QQV
X-MailFrom: kilobyte@angband.pl
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Goldwyn Rodrigues <rgoldwyn@suse.de>, Neal Gompa <ngompa13@gmail.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ZS2WQJOFQPG3CPLF5ELK5WMLMTN6QQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDI6MjY6NDNQTSArMDAwMCwgTWF0dGhldyBXaWxjb3gg
d3JvdGU6DQo+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0IDA4OjIxOjU5QU0gLTA2MDAsIEdvbGR3
eW4gUm9kcmlndWVzIHdyb3RlOg0KPiA+IERBWCBvbiBidHJmcyBoYXMgYmVlbiBhdHRlbXB0ZWRb
MV0uIE9mIGNvdXJzZSwgd2UgY291bGQgbm90DQo+IA0KPiBCdXQgd2h5PyAgQSBjb21wbGV0ZW5l
c3MgZmV0aXNoPyAgSSBkb24ndCB1bmRlcnN0YW5kIHdoeSB5b3UgZGVjaWRlZA0KPiB0byBkbyB0
aGlzIHdvcmsuDQoNCiogeGZzIGNhbiBzaGFwc2hvdCBvbmx5IHNpbmdsZSBmaWxlcywgYnRyZnMg
ZW50aXJlIHN1YnZvbHVtZXMNCiogYnRyZnMtc2VuZHxyZWNlaXZlDQoqIGVudW1lcmF0aW9uIG9m
IGNoYW5nZWQgcGFydHMgb2YgYSBmaWxlDQoNCg0KTWVvdyENCi0tIA0K4qKA4qO04qC+4qC74qK2
4qOm4qCAIEkndmUgcmVhZCBhbiBhcnRpY2xlIGFib3V0IGhvdyBsaXZlbHkgaGFwcHkgbXVzaWMg
Ym9vc3RzDQrio77ioIHioqDioJLioIDio7/ioYEgcHJvZHVjdGl2aXR5LiAgWW91IGNhbiByZWFk
IGl0LCB0b28sIHlvdSBqdXN0IG5lZWQgdGhlDQrior/ioYTioJjioLfioJrioIvioIAgcmlnaHQg
bXVzaWMgd2hpbGUgZG9pbmcgc28uICBJIHJlY29tbWVuZCBTa2VwdGljaXNtDQrioIjioLPio4Ti
oIDioIDioIDioIAgKGZ1bmVyYWwgZG9vbSBtZXRhbCkuCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGlu
dXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
bnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
