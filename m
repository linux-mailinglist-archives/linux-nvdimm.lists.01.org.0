Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615B4333CA0
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Mar 2021 13:31:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE588100EB32D;
	Wed, 10 Mar 2021 04:31:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b34; helo=mail-yb1-xb34.google.com; envelope-from=ngompa13@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27208100EB32A
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 04:31:19 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x19so17692195ybe.0
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 04:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=atKgvCAVpItHVZX4pm9LPMJMeABJeY6Z3gkRYABn5yM=;
        b=CqUqoL9kkvx+9GPDQrx/onWS2YqBsmUkD9RdH3kHKTKq0Cer4EZT4m88Jw1x4Fr3ay
         TiaLyhLOVS3KIjiESjXT/yUrAY3W1sZdEm6TSmA+7EtxpUAPl9UGLAHN1LPhHptz8M4W
         awatnKWJUohL/31zVJXD5w/KHKFHyP/tXqk0Ma2sIXDK6kPy8Zt1D+Va9Mfmvz7UOItG
         5/DBwezK/etsdPHs3GV7GnvF0RLpA9aHGTPlINFPjl6Ceem8bSrdhpjAxCNFrmKNSnM1
         3zAQJZQbW2rR8gGM7xa5X45SmKRn206FsjxUb9Z4X7woqN6A1P+KAmARKYNbS/6aUl9Z
         5FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=atKgvCAVpItHVZX4pm9LPMJMeABJeY6Z3gkRYABn5yM=;
        b=RGPserkyaBugDjfeb7BdrCWiS4wrkAGt9BIbc3/dDIUyUUjWnxlTGJH4UjEYh2MlGE
         wtN3KjK3FLbqkQ6kq8NYL8Mgcao5LxXbmEcJkUUdKVFDIagIOz5v5+hqAuJ+je6pclwW
         86CTbfaguh2s8kuCugmfBzs+iHOe8pBekBWPMUYsPAQSw56rSjxdgP/Z0mfYOY2yHsRr
         mTwLrb1O7dhADdrgoGv9VKGkcOeNXX+VnqBesHAsO9aMlnG+At2B26QwlYNIZIFkNeb1
         K5LW3wTgDFUFMMhDO1TqKKK4mrgDd2X7B8m5vvoHRSrNe58EOLakan42ZtBEwqDNXnIv
         CfIQ==
X-Gm-Message-State: AOAM531c4wpQZBrdkrZeSARi9jpUXcsF3H9SzENWMKzu9XLgtgtanxVQ
	rWc3b7L3YWJ+TxsamuS2fDajPGaVOeFkvX4A3oc=
X-Google-Smtp-Source: ABdhPJx2QY4l9cQe75nptZ7Pf1Zho+J5rcKWrpKzrd9BmVRKh3Mvj6bvtkk6JVBRVJMnA8nldnylsisoMg5a0XbleWs=
X-Received: by 2002:a05:6902:1001:: with SMTP id w1mr3859288ybt.176.1615379477739;
 Wed, 10 Mar 2021 04:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Wed, 10 Mar 2021 07:30:41 -0500
Message-ID: <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID-Hash: K7EJCFIHVRN7NS65GUR5Z2AJF2OIOA4Y
X-Message-ID-Hash: K7EJCFIHVRN7NS65GUR5Z2AJF2OIOA4Y
X-MailFrom: ngompa13@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K7EJCFIHVRN7NS65GUR5Z2AJF2OIOA4Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBGZWIgMjUsIDIwMjEgYXQgNzoyMyBQTSBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0
QGZ1aml0c3UuY29tPiB3cm90ZToNCj4NCj4gVGhpcyBwYXRjaHNldCBpcyBhdHRlbXB0IHRvIGFk
ZCBDb1cgc3VwcG9ydCBmb3IgZnNkYXgsIGFuZCB0YWtlIFhGUywNCj4gd2hpY2ggaGFzIGJvdGgg
cmVmbGluayBhbmQgZnNkYXggZmVhdHVyZSwgYXMgYW4gZXhhbXBsZS4NCj4NCj4gQ2hhbmdlcyBm
cm9tIFYxOg0KPiAgLSBGYWN0b3Igc29tZSBoZWxwZXIgZnVuY3Rpb25zIHRvIHNpbXBsaWZ5IGRh
eCBmYXVsdCBjb2RlDQo+ICAtIEludHJvZHVjZSBpb21hcF9hcHBseTIoKSBmb3IgZGF4X2RlZHVw
ZV9maWxlX3JhbmdlX2NvbXBhcmUoKQ0KPiAgLSBGaXggbWlzdGFrZXMgYW5kIG90aGVyIHByb2Js
ZW1zDQo+ICAtIFJlYmFzZWQgb24gdjUuMTENCj4NCj4gT25lIG9mIHRoZSBrZXkgbWVjaGFuaXNt
IG5lZWQgdG8gYmUgaW1wbGVtZW50ZWQgaW4gZnNkYXggaXMgQ29XLiAgQ29weQ0KPiB0aGUgZGF0
YSBmcm9tIHNyY21hcCBiZWZvcmUgd2UgYWN0dWFsbHkgd3JpdGUgZGF0YSB0byB0aGUgZGVzdGFu
Y2UNCj4gaW9tYXAuICBBbmQgd2UganVzdCBjb3B5IHJhbmdlIGluIHdoaWNoIGRhdGEgd29uJ3Qg
YmUgY2hhbmdlZC4NCj4NCj4gQW5vdGhlciBtZWNoYW5pc20gaXMgcmFuZ2UgY29tcGFyaXNvbi4g
IEluIHBhZ2UgY2FjaGUgY2FzZSwgcmVhZHBhZ2UoKQ0KPiBpcyB1c2VkIHRvIGxvYWQgZGF0YSBv
biBkaXNrIHRvIHBhZ2UgY2FjaGUgaW4gb3JkZXIgdG8gYmUgYWJsZSB0bw0KPiBjb21wYXJlIGRh
dGEuICBJbiBmc2RheCBjYXNlLCByZWFkcGFnZSgpIGRvZXMgbm90IHdvcmsuICBTbywgd2UgbmVl
ZA0KPiBhbm90aGVyIGNvbXBhcmUgZGF0YSB3aXRoIGRpcmVjdCBhY2Nlc3Mgc3VwcG9ydC4NCj4N
Cj4gV2l0aCB0aGUgdHdvIG1lY2hhbmlzbSBpbXBsZW1lbnRlZCBpbiBmc2RheCwgd2UgYXJlIGFi
bGUgdG8gbWFrZSByZWZsaW5rDQo+IGFuZCBmc2RheCB3b3JrIHRvZ2V0aGVyIGluIFhGUy4NCj4N
Cj4NCj4gU29tZSBvZiB0aGUgcGF0Y2hlcyBhcmUgcGlja2VkIHVwIGZyb20gR29sZHd5bidzIHBh
dGNoc2V0LiAgSSBtYWRlIHNvbWUNCj4gY2hhbmdlcyB0byBhZGFwdCB0byB0aGlzIHBhdGNoc2V0
Lg0KPg0KPiAoUmViYXNlZCBvbiB2NS4xMSkNCg0KRm9yZ2l2ZSBteSBpZ25vcmFuY2UsIGJ1dCBp
cyB0aGVyZSBhIHJlYXNvbiB3aHkgdGhpcyBpc24ndCB3aXJlZCB1cCB0bw0KQnRyZnMgYXQgdGhl
IHNhbWUgdGltZT8gSXQgc2VlbXMgd2VpcmQgdG8gbWUgdGhhdCBhZGRpbmcgYSBmZWF0dXJlDQps
aWtlIERBWCB0byB3b3JrIHdpdGggQ29XIGZpbGVzeXN0ZW1zIGlzIG5vdCBiZWluZyB3aXJlZCBp
bnRvICp0aGUqDQpDb1cgZmlsZXN5c3RlbSBpbiB0aGUgTGludXgga2VybmVsIHRoYXQgZnVsbHkg
dGFrZXMgYWR2YW50YWdlIG9mDQpjb3B5LW9uLXdyaXRlLiBJJ20gYXdhcmUgdGhhdCBYRlMgc3Vw
cG9ydHMgcmVmbGlua3MgYW5kIGRvZXMgc29tZQ0KZGF0YWNvdyBzdHVmZiwgYnV0IEkgZG9uJ3Qg
a25vdyBpZiBJIHdvdWxkIGNvbnNpZGVyIFhGUyBpbnRlZ3JhdGlvbg0Kc3VmZmljaWVudCBmb3Ig
aW50ZWdyYXRpbmcgdGhpcyBmZWF0dXJlIG5vdywgZXNwZWNpYWxseSBpZiBpdCdzDQpwb3NzaWJs
ZSB0aGF0IHRoZSBkZXNpZ24gbWlnaHQgbm90IHdvcmsgd2l0aCBCdHJmcyAoSSBoYWRuJ3Qgc2Vl
biBhbnkNCmZlZWRiYWNrIGZyb20gQnRyZnMgZGV2ZWxvcGVycywgdGhvdWdoIGdpdmVuIGhvdyBt
dWNoIGVtYWlsIHRoZXJlIGlzDQpoZXJlLCBpdCdzIGVudGlyZWx5IHBvc3NpYmxlIHRoYXQgSSBt
aXNzZWQgaXQpLg0KDQoNCi0tIA0K55yf5a6f44Gv44GE44Gk44KC5LiA44Gk77yBLyBBbHdheXMs
IHRoZXJlJ3Mgb25seSBvbmUgdHJ1dGghCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBtYWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1t
QGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGlt
bS1sZWF2ZUBsaXN0cy4wMS5vcmcK
