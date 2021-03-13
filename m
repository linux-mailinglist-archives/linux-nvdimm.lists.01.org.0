Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33E4339F14
	for <lists+linux-nvdimm@lfdr.de>; Sat, 13 Mar 2021 17:24:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D32F2100ED480;
	Sat, 13 Mar 2021 08:24:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::b33; helo=mail-yb1-xb33.google.com; envelope-from=ngompa13@gmail.com; receiver=<UNKNOWN> 
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DA498100EF250
	for <linux-nvdimm@lists.01.org>; Sat, 13 Mar 2021 08:24:37 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id u75so28670400ybi.10
        for <linux-nvdimm@lists.01.org>; Sat, 13 Mar 2021 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXi6zxmykvKGGuEUIknBGQuu/CrpF+OFk8aqg1g8+Js=;
        b=Hv71HUzmf0Lv3L07Y9vPI88fr2tkUa/1JbFZGy51jjbh9n4cRQ+P6rLbvPAhZMLbg5
         ixsUkRYdDUhei4YCiRy0287CIkP8b3Jg9TpHICyCGV2xDgcQFoYiRrPDp0LcPbNyPobt
         e2mB8WjIyZJjUgnIK3eEg9rREEgBthIupmC5k7TJkMd1BdMNglR5MTBljFc4WnZL0Tv/
         2A5yFWAf2SP7q2tspr8wPFHgGP1dhWKjLEJrKe1jxyEujMO/6QhrAuiX6efY9Q0tZhFG
         jbv3PaYMyafnqAK7BZW4C9hHl2HDt27Z0jCW48yq0cRe9cKlFDPeNt9KBY4Z6kTHjtIk
         4+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXi6zxmykvKGGuEUIknBGQuu/CrpF+OFk8aqg1g8+Js=;
        b=peSl/wT3DNTuPUWddx/wGQotSwtjpdncQacVH5gcTLNNbMCGEwcLcOrHjsHGHQTuWK
         ZL/pcG/brKeQEKrEmmaURXvnIvHJhiZhFy4AlOU2SVQYa6MyymSUZoFjQgPXEqY7GnPh
         VKHyzl4z7ajWmRLScbdgue0Dp3791pSGXrK9JZsTmuqahBsnpBiZdhX/S/6vd9YhhuFs
         E9uRpKon+Ekiz9xeqeREW7+qYxVO0bcXQnDlQsueO5RzQsPgTpUR/LJMh85YolfypA80
         J93638hfsGwYK03NAwthSd/4Vy2ZVmNRgT77XHPukOiCiRKir+7zeUDzBM9Np1aSH36O
         tSbA==
X-Gm-Message-State: AOAM5313wKY3XT9eWLhSaBt8ZLPwVQkMKKN2kWOLrtDoJI5QXh1qjoNl
	zGazSiQ2/L2vTO+6WYnafEMiZwfc1/Z/qClz4HI=
X-Google-Smtp-Source: ABdhPJwtKc3ckDh1wM2gREfAQUcazj9bOTqT8gJ/CC1jACL5d+N8mbIM5sD/vFtR/QEb1ipgGC33qgcC6cjdF7XgPjg=
X-Received: by 2002:a25:424f:: with SMTP id p76mr27228411yba.109.1615652676401;
 Sat, 13 Mar 2021 08:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <CAEg-Je-OLidbfzHCJvY55x+-cOfiUxX8CJ1AeN8VxXAVuVyxKQ@mail.gmail.com>
 <20210310130227.GN3479805@casper.infradead.org> <20210310142159.kudk7q2ogp4yqn36@fiona>
 <20210310142643.GQ3479805@casper.infradead.org> <YEy4+SPUvQkL44PQ@angband.pl>
In-Reply-To: <YEy4+SPUvQkL44PQ@angband.pl>
From: Neal Gompa <ngompa13@gmail.com>
Date: Sat, 13 Mar 2021 11:24:00 -0500
Message-ID: <CAEg-Je-JCW5xa6w5Z9n7+UNnLju251SmqnXiReA2v41fFaXAtw@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
To: Adam Borowski <kilobyte@angband.pl>
Message-ID-Hash: FMDI5AYB3FZAMFNAZGD6LSAFSHTS763W
X-Message-ID-Hash: FMDI5AYB3FZAMFNAZGD6LSAFSHTS763W
X-MailFrom: ngompa13@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>, ocfs2-devel@oss.oracle.com, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FMDI5AYB3FZAMFNAZGD6LSAFSHTS763W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gU2F0LCBNYXIgMTMsIDIwMjEgYXQgODowOSBBTSBBZGFtIEJvcm93c2tpIDxraWxvYnl0ZUBh
bmdiYW5kLnBsPiB3cm90ZToNCj4NCj4gT24gV2VkLCBNYXIgMTAsIDIwMjEgYXQgMDI6MjY6NDNQ
TSArMDAwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6DQo+ID4gT24gV2VkLCBNYXIgMTAsIDIwMjEg
YXQgMDg6MjE6NTlBTSAtMDYwMCwgR29sZHd5biBSb2RyaWd1ZXMgd3JvdGU6DQo+ID4gPiBEQVgg
b24gYnRyZnMgaGFzIGJlZW4gYXR0ZW1wdGVkWzFdLiBPZiBjb3Vyc2UsIHdlIGNvdWxkIG5vdA0K
PiA+DQo+ID4gQnV0IHdoeT8gIEEgY29tcGxldGVuZXNzIGZldGlzaD8gIEkgZG9uJ3QgdW5kZXJz
dGFuZCB3aHkgeW91IGRlY2lkZWQNCj4gPiB0byBkbyB0aGlzIHdvcmsuDQo+DQo+ICogeGZzIGNh
biBzaGFwc2hvdCBvbmx5IHNpbmdsZSBmaWxlcywgYnRyZnMgZW50aXJlIHN1YnZvbHVtZXMNCj4g
KiBidHJmcy1zZW5kfHJlY2VpdmUNCj4gKiBlbnVtZXJhdGlvbiBvZiBjaGFuZ2VkIHBhcnRzIG9m
IGEgZmlsZQ0KPg0KDQpYRlMgY2Fubm90IGRvIHNuYXBzaG90cyBzaW5jZSBpdCBsYWNrcyBtZXRh
ZGF0YSBDT1cuIFhGUyByZWZsaW5raW5nIGlzDQpwcmltYXJpbHkgZm9yIHNwYWNlIGVmZmljaWVu
Y3kuDQoNCg0KDQotLSANCuecn+Wun+OBr+OBhOOBpOOCguS4gOOBpO+8gS8gQWx3YXlzLCB0aGVy
ZSdzIG9ubHkgb25lIHRydXRoIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0
cy4wMS5vcmcKVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVh
dmVAbGlzdHMuMDEub3JnCg==
