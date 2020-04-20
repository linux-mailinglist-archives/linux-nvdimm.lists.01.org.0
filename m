Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F411B1665
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 21:58:48 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 54500100A0282;
	Mon, 20 Apr 2020 12:58:40 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com; envelope-from=zzy@zzywysm.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6324B100A0281
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 12:58:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l78so12125522qke.7
        for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zzywysm.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=DHwk8VKEaaVWe6umPwn75HeYPWa4/to4TPUyIyniHa8w0VjI4jbFRgfwiJbMPyVTBF
         XIxMCwftVuZ5LMDuVHb9gd/oo9bVOeOag3KnWsbyRKiBySEDw18VNG9po6wPOgaX+JV0
         U696lIpKGeSvPcCzw56gqM/agX1+2/QWVes4jWwOX1kSM0DMbVae9AqQEle3/5swq1WR
         3E0xc6MJg7TbdMO3xq2INKKP9cMKexf1GETBAnT4Wc/qvIJu4eZ79zfLThZbNisSrGcf
         uNvuImd6aWtDGh5xTm0hSIil3sDlm0TTj3TRSR1SEsiBL/e+4Ps6DP19SkF+CcVNT33D
         HkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1CahSbHOz6rwR75qjwbzvpk5/lxzAsXTVlJJFrluNmk=;
        b=NC6rzgdENsFGB0EpDIEptj6hOEbxbQwo6VHW1XKIB++Hotw1WG71tyLfxYLNAwD1AL
         PsebRgUNAwXHmo2EMWqUvpsO3i1KCbbBzRshQ/cLeveCZDhw4Nxd9irLA4seQ1B3FfQE
         ooeaWFYZBw/OItMlkllAFwhuEtGQdCCXeR/97bAZzfSYFCZUfuwiSd+az19HcYkPw8Wu
         RDsJFbqGbJj0eOySE2WRm5YVXZoLrFHajnErh2ya9+92tZPVAGuKLMarDroCjC9ZlgCe
         tCxag3xR4qCGFWbXHbE8X781AQ176BDvBU81eLaz+1Ua79o1dUzshLGC1Z/cv/TzV6C5
         hkow==
X-Gm-Message-State: AGi0PuaBVBJB9zbsCRcEH7YcNj9YyMabMugTf+UfjL08WNwSoYIdNbU2
	cOBIeZvs7yZspA5grX62mKNgFw==
X-Google-Smtp-Source: APiQypLbKFRt3y7j9cRt5ohxKGUgZ2cg5IXsM72wAdwrD/eEvlPuY2BnSQ46fW3IHvQ9kSE9m6xMag==
X-Received: by 2002:a37:5284:: with SMTP id g126mr18284316qkb.51.1587412716060;
        Mon, 20 Apr 2020 12:58:36 -0700 (PDT)
Received: from [10.19.49.2] (ec2-3-17-74-181.us-east-2.compute.amazonaws.com. [3.17.74.181])
        by smtp.gmail.com with ESMTPSA id j2sm241058qtp.5.2020.04.20.12.58.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:58:35 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 2/9] fix empty-body warning in posix_acl.c
From: Zzy Wysm <zzy@zzywysm.com>
In-Reply-To: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Date: Mon, 20 Apr 2020 14:58:31 -0500
Message-Id: <F8B969BE-A2B1-4E6D-8746-BBFBE6399328@zzywysm.com>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-3-rdunlap@infradead.org>
 <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Message-ID-Hash: 35D4JHUFJHUXDHRPAQL72PBTQQ4NR6I3
X-Message-ID-Hash: 35D4JHUFJHUXDHRPAQL72PBTQQ4NR6I3
X-MailFrom: zzy@zzywysm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-scsi <linux-scsi@vger.kernel.org>, target-devel <target-devel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/35D4JHUFJHUXDHRPAQL72PBTQQ4NR6I3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

DQo+IE9uIEFwciAxOCwgMjAyMCwgYXQgMTo1MyBQTSwgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gDQo+IFRoaXJkbHksIHRoZXJlJ3MgYSAq
cmVhc29uKiB3aHkgIi1XZXh0cmEiIGlzbid0IHVzZWQuDQo+IA0KPiBUaGUgd2FybmluZ3MgZW5h
YmxlZCBieSAtV2V4dHJhIGFyZSB1c3VhbGx5IGNvbXBsZXRlIGdhcmJhZ2UsIGFuZA0KPiB0cnlp
bmcgdG8gZml4IHRoZW0gb2Z0ZW4gbWFrZXMgdGhlIGNvZGUgd29yc2UuIEV4YWN0bHkgbGlrZSBo
ZXJlLg0KPiANCg0KQXMgdGhlIGluc3RpZ2F0b3Igb2YgdGhpcyB3YXJuaW5nIGNsZWFudXAgYWN0
aXZpdHksIGV2ZW4gX0lfIGRvbuKAmXQgcmVjb21tZW5kDQpidWlsZGluZyB3aXRoIGFsbCBvZiAt
V2V4dHJhLiAgRG9pbmcgc28gb24gYW4gYWxsbW9kY29uZmlnIGJ1aWxkIGdlbmVyYXRlcyANCjUw
MCBtZWdhYnl0ZXMgb2Ygd2FybmluZyB0ZXh0IChub3QgZXhhZ2dlcmF0aW5nKSwgcHJpbWFyaWx5
IGR1ZSB0byANCi1XdW51c2VkLXBhcmFtZXRlciBhbmQgV21pc3NpbmctZmllbGQtaW5pdGlhbGl6
ZXJzLg0KDQpJIHN0cm9uZ2x5IHJlY29tbWVuZCBkaXNhYmxpbmcgdGhlbSB3aXRoIC1Xbm8tdW51
c2VkLXBhcmFtZXRlciANCi1Xbm8tbWlzc2luZy1maWVsZC1pbml0aWFsaXplcnMgc2luY2UgdGhl
IHNwZXcgaXMgY29tcGxldGVseSB1bmFjdGlvbmFibGUuDQoNCk9uIHRoZSBvdGhlciBoYW5kLCAt
V292ZXJyaWRlLWluaXQgZm91bmQgYSBsZWdpdCBidWcgdGhhdCB3YXMgYnJlYWtpbmcgRFZEDQpk
cml2ZXMsIGZpeGVkIGluIGNvbW1pdCAwMzI2NGRkZGUyNDUzZjY4NzdhN2Q2MzdkODQwNjgwNzk2
MzJhM2M1Lg0KDQpJIGJlbGlldmUgZmluZGluZyBhIGdvb2Qgc2V0IG9mIGNvbXBpbGVyIHdhcm5p
bmcgc2V0dGluZ3MgY2FuIGxlYWQgdG8gbG90cyBvZiANCmdvb2QgYnVncyBiZWluZyBzcG90dGVk
IGFuZCAoaG9wZWZ1bGx5KSBmaXhlZC4gIFdoeSBsZXQgc3l6Ym90IGRvIGFsbCB0aGUgd29yaz8N
Cg0Kenp5DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcKVG8g
dW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMuMDEu
b3JnCg==
