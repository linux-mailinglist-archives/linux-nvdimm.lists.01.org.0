Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24656336DCA
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 09:26:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AE62100EBB7F;
	Thu, 11 Mar 2021 00:26:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b2c; helo=mail-yb1-xb2c.google.com; envelope-from=ngompa13@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73E8B100ED4BA
	for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 00:26:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f145so4453662ybg.11
        for <linux-nvdimm@lists.01.org>; Thu, 11 Mar 2021 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dcZpA35LpDkKjUY2Q5hXt+oRBTl1Po2J4cSvuFIykJg=;
        b=DjYTcGueHAZYsfVWcXtNSV5/l9b9KrnYrqF65jNsk2ArqmZWXRS3axR3334xSPnksJ
         KpInpw14LRvoI0+d1KhzvcgE1CFYNdwTtPm+IPG9P2ikH4U8Y2HwEyqtWWTY4ER9D/Im
         tKABJcbZPj/+aA08uogzlTecDmN9WzdnpKOTEHUNNs2ygRLg0SrzAX7flrL7Zs5WTL95
         kw2WWz8GXrociRGMY0y1D/4yVsKqKXYgxPoPv+sNtc5Xm8dDTSFxycSJnXP20MK63TZ6
         TgvHhcQztSCshrA1MwAHkYghauzH0gTLgczXbJccIkQGqcS726u4gIP0X3z9vKk7vBSX
         mPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dcZpA35LpDkKjUY2Q5hXt+oRBTl1Po2J4cSvuFIykJg=;
        b=PxfI9yWXqa1kcrOYDCxXZgFkYaXiPzNdNQ50UYoPPnJufNjrD14zarjXcaJoa8gIt/
         O3BBIChvYnNOo8/6vMm2aodTIlddcw2xozaSggNcobbi8UVyvzquRIXRS89a4/5s6U7i
         yGFxGu0vj7Eo+SW9jA+XdYLVfjoo6ZUQNlivG0yaG7VusMSN+imtbLq1/uGX36ZcD+7Y
         L6cJ3NZqSUZxzs1eQNFalNV1RtQ3BKkT4jTmwvTC6xxsfMvpxmE2O/RYQ7jm7rWjxX+X
         T/32q9Iw7LHkbMjLoJbdHuMNj0b3gR38111oskxQEczsKMV9EyLAKNT9ibM+1FNwUXNq
         JpxA==
X-Gm-Message-State: AOAM531XysTm6Kl0szg/jkdIYsoyIiW/8FUjYH/HEeGne2J6Fncj+oVP
	XVl1p2VOBdHkNh6XB2rZa+qH7u2dau8XLK9/7Rc=
X-Google-Smtp-Source: ABdhPJxDi0GRK2/QkVfeTJCzVq2zudoeSp/hgMaL164lMJ0uHqYkS0fpHT+H5oc1+Mf9DUZcBDo/d2853Fvi8jdJEdg=
X-Received: by 2002:a25:cc13:: with SMTP id l19mr9850423ybf.260.1615451207278;
 Thu, 11 Mar 2021 00:26:47 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org> <CAPcyv4i80GXjjoAD9G0AaRDWPbcTSLogJE9NokO4Eqpzt6UMkA@mail.gmail.com>
In-Reply-To: <CAPcyv4i80GXjjoAD9G0AaRDWPbcTSLogJE9NokO4Eqpzt6UMkA@mail.gmail.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Thu, 11 Mar 2021 03:26:11 -0500
Message-ID: <CAEg-Je9e1R2NAqtZfryM99+Z98SGjxTSQjt-CMyKRMxvDwtsyg@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: NNAQCUQHSKGQJH3JFOCDJYWCSAFCHK2V
X-Message-ID-Hash: NNAQCUQHSKGQJH3JFOCDJYWCSAFCHK2V
X-MailFrom: ngompa13@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NNAQCUQHSKGQJH3JFOCDJYWCSAFCHK2V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgNzo1MyBQTSBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxp
YW1zQGludGVsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0IDY6Mjcg
QU0gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4g
T24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDg6MjE6NTlBTSAtMDYwMCwgR29sZHd5biBSb2RyaWd1
ZXMgd3JvdGU6DQo+ID4gPiBPbiAxMzowMiAxMC8wMywgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+
ID4gPiA+IE9uIFdlZCwgTWFyIDEwLCAyMDIxIGF0IDA3OjMwOjQxQU0gLTA1MDAsIE5lYWwgR29t
cGEgd3JvdGU6DQo+ID4gPiA+ID4gRm9yZ2l2ZSBteSBpZ25vcmFuY2UsIGJ1dCBpcyB0aGVyZSBh
IHJlYXNvbiB3aHkgdGhpcyBpc24ndCB3aXJlZCB1cCB0bw0KPiA+ID4gPiA+IEJ0cmZzIGF0IHRo
ZSBzYW1lIHRpbWU/IEl0IHNlZW1zIHdlaXJkIHRvIG1lIHRoYXQgYWRkaW5nIGEgZmVhdHVyZQ0K
PiA+ID4gPg0KPiA+ID4gPiBidHJmcyBkb2Vzbid0IHN1cHBvcnQgREFYLiAgb25seSBleHQyLCBl
eHQ0LCBYRlMgYW5kIEZVU0UgaGF2ZSBEQVggc3VwcG9ydC4NCj4gPiA+ID4NCj4gPiA+ID4gSWYg
eW91IHRoaW5rIGFib3V0IGl0LCBidHJmcyBhbmQgREFYIGFyZSBkaWFtZXRyaWNhbGx5IG9wcG9z
aXRlIHRoaW5ncy4NCj4gPiA+ID4gREFYIGlzIGFib3V0IGdpdmluZyByYXcgYWNjZXNzIHRvIHRo
ZSBoYXJkd2FyZS4gIGJ0cmZzIGlzIGFib3V0IG9mZmVyaW5nDQo+ID4gPiA+IGV4dHJhIHZhbHVl
IChSQUlELCBjaGVja3N1bXMsIC4uLiksIG5vbmUgb2Ygd2hpY2ggY2FuIGJlIGRvbmUgaWYgdGhl
DQo+ID4gPiA+IGZpbGVzeXN0ZW0gaXNuJ3QgaW4gdGhlIHJlYWQvd3JpdGUgcGF0aC4NCj4gPiA+
ID4NCj4gPiA+ID4gVGhhdCdzIHdoeSB0aGVyZSdzIG5vIERBWCBzdXBwb3J0IGluIGJ0cmZzLiAg
SWYgeW91IHdhbnQgREFYLCB5b3UgaGF2ZQ0KPiA+ID4gPiB0byBnaXZlIHVwIGFsbCB0aGUgZmVh
dHVyZXMgeW91IGxpa2UgaW4gYnRyZnMuICBTbyB5b3UgbWF5IGFzIHdlbGwgdXNlDQo+ID4gPiA+
IGEgZGlmZmVyZW50IGZpbGVzeXN0ZW0uDQo+ID4gPg0KPiA+ID4gREFYIG9uIGJ0cmZzIGhhcyBi
ZWVuIGF0dGVtcHRlZFsxXS4gT2YgY291cnNlLCB3ZSBjb3VsZCBub3QNCj4gPg0KPiA+IEJ1dCB3
aHk/ICBBIGNvbXBsZXRlbmVzcyBmZXRpc2g/ICBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHlvdSBk
ZWNpZGVkDQo+ID4gdG8gZG8gdGhpcyB3b3JrLg0KPg0KPiBJc24ndCBEQVggdXNlZnVsIGZvciBw
YWdlY2FjaGUgbWluaW1pemF0aW9uIG9uIHJlYWQgZXZlbiBpZiBpdCBpcw0KPiBhd2t3YXJkIGZv
ciBhIGNvcHktb24td3JpdGUgZnM/DQo+DQo+IFNlZW1zIGl0IHdvdWxkIGJlIGEgdXNlZnVsIGNh
c2UgdG8gaGF2ZSBDT1cnZCBWTSBpbWFnZXMgb24gQlRSRlMgdGhhdA0KPiBkb24ndCBuZWVkIHN1
cGVyZmx1b3VzIHBhZ2UgY2FjaGUgYWxsb2NhdGlvbnMuDQoNCkkgY291bGQgYWxzbyBzZWUgdGhp
cyBiZWluZyB1c2VmdWwgZm9yIGRhdGFiYXNlcyAoYW5kIG1heWJlIGV2ZW4gc3dhcA0KZmlsZXMh
KSBvbiBCdHJmcywgaWYgSSdtIHVuZGVyc3RhbmRpbmcgdGhpcyBmZWF0dXJlIGNvcnJlY3RseS4N
Cg0KDQotLSANCuecn+Wun+OBr+OBhOOBpOOCguS4gOOBpO+8gS8gQWx3YXlzLCB0aGVyZSdzIG9u
bHkgb25lIHRydXRoIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5v
cmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlz
dHMuMDEub3JnCg==
