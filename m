Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FB199F53
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 21:42:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8038A10FC38BE;
	Tue, 31 Mar 2020 12:43:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9E3A910FC38BB
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 12:43:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e5so26657740edq.5
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eFUT43ck5+5R1qbPUjuBcQdIh9wgFblamWMErw9KKfs=;
        b=je25YuKe3GdVdtwLOJijqDoBjgC4vcbMmwqpJBL7TftLf5Rf2uF6T28QN6UMibZRR/
         q3tIy09alG6RoDm0HtwfJG8wHEXCMnryizTVYiyQFGq3zUfj5W5ILRAcM2FqfkUlyBOJ
         Wihp9iwjComgRQpBvDEi+Tk7jz10b26UVroo31SMO+2ktSkZnbjiwRuUnEbEn/x/bYOn
         3qZALbEK3VGxUlFPkmkzvSeqRYruhXFuK/HJ7HE+VIsEUlUg+/glj/tAejPoe0QLvTiM
         7UJ/xVyWbstvIZcgdDe4zc3c6Iggoc0Dy9/QZYkZDh5t589XtzXCtP+kB/SK5xreo5dq
         PjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eFUT43ck5+5R1qbPUjuBcQdIh9wgFblamWMErw9KKfs=;
        b=a4T4NXHgtp3+2xjk+NI3S1LLjiDz2Zl+OlG+4q9r0mxzkXSY6PfuOjD/MBDKT75VU2
         BFvxQeRGqwuAsitknmKJVg0+c7+G/rHTAz8g1m0Fba/3oE39Pl9bILIaoTeKlkAmYelw
         CkxhTD2wDzcxXrbGTpkWInhqUGC6krjZ3kVytAwcpXE7m8l8FW7n5eIi6O3IHHWPBaoR
         wgotNYvruT8juHc7Ld6u3VhMLU26haEh2sxQMhRmeCmJEWx88FTOHMP4Wwyw+b4XH3hU
         SlXxvpWEEpKhzbsB4lLlsmWOi/X2rV4KZMu/TORxJuh55uAtH4PrlCTIUlhNwdx7ygWJ
         KMAw==
X-Gm-Message-State: ANhLgQ2HC3vadB5NjlX4jTp2YiI1navohIQqobNG2TJwhnvT8s6ZoLi1
	k2aKICzvTNeFMajkDYBgminiIrOf7qDbUOs6ea0XqQ==
X-Google-Smtp-Source: ADFU+vtgud1DPhJvy8MROSuueMDBRjBInsn6e61/cbeRbUBWdx+oWjjB73XjMAzsgm2c9WauM9poEgqR2PS/m48qJOs=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr16428941ejj.317.1585683759433;
 Tue, 31 Mar 2020 12:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200330141943.31696-1-yuehaibing@huawei.com> <20200331115024.31628-1-yuehaibing@huawei.com>
In-Reply-To: <20200331115024.31628-1-yuehaibing@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 12:42:28 -0700
Message-ID: <CAPcyv4i=vyAFiAkGRaRx=+fnGOq9Eebo8szobBDD2AZ+vy877A@mail.gmail.com>
Subject: Re: [PATCH v2 -next] libnvdimm/region: Fix build error
To: YueHaibing <yuehaibing@huawei.com>
Message-ID-Hash: GCQUUC4C2T62NKQULAAFNKTKSI5BM4ZO
X-Message-ID-Hash: GCQUUC4C2T62NKQULAAFNKTKSI5BM4ZO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GCQUUC4C2T62NKQULAAFNKTKSI5BM4ZO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBNYXIgMzEsIDIwMjAgYXQgNDo1MiBBTSBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1
YXdlaS5jb20+IHdyb3RlOg0KPg0KPiBPbiBDT05GSUdfUFBDMzI9eSBidWlsZCBmYWlsczoNCj4N
Cj4gZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYzoxMDM0OjE0OiBub3RlOiBpbiBleHBhbnNp
b24gb2YgbWFjcm8g4oCYZG9fZGl24oCZDQo+ICAgcmVtYWluZGVyID0gZG9fZGl2KHBlcl9tYXBw
aW5nLCBtYXBwaW5ncyk7DQo+ICAgICAgICAgICAgICAgXn5+fn5+DQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2dlbmVyYXRlZC9hc20vZGl2NjQuaDoxOjAs
DQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgva2VybmVsLmg6MTgsDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvYnVnLmg6MTksDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9idWcuaDox
MDksDQo+ICAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYnVnLmg6NSwNCj4g
ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oOjcsDQo+
ICAgICAgICAgICAgICAgICAgZnJvbSBkcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jOjU6DQo+
IC4vaW5jbHVkZS9hc20tZ2VuZXJpYy9kaXY2NC5oOjI0MzoyMjogZXJyb3I6IHBhc3NpbmcgYXJn
dW1lbnQgMSBvZiDigJhfX2RpdjY0XzMy4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlw
ZSBbLVdlcnJvcj1pbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10NCj4gICAgX19yZW0gPSBfX2Rp
djY0XzMyKCYobiksIF9fYmFzZSk7IFwNCj4NCj4gVXNlIGRpdl91NjQgaW5zdGVhZCBvZiBkb19k
aXYgdG8gZml4IHRoaXMuDQo+DQo+IEZpeGVzOiAyNTIyYWZiODZhOGMgKCJsaWJudmRpbW0vcmVn
aW9uOiBJbnRyb2R1Y2UgYW4gJ2FsaWduJyBhdHRyaWJ1dGUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBZ
dWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+IC0tLQ0KPiB2MjogdXNlIGRpdl91
NjRfcmVtIGFuZCBjb2RlIGNsZWFudXANCg0KTG9va3MgZ29vZCBub3csIHRoYW5rcywgYXBwbGll
ZC4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vi
c2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
