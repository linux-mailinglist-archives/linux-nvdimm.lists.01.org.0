Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A641031D452
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 04:48:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D085F100EAB4A;
	Tue, 16 Feb 2021 19:48:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB99F100EAB48
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:48:50 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id do6so9527457ejc.3
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6GN7npjxxTr3rPYtuepca6vGbGAXTsJ8Kzpp5ATUsdw=;
        b=h47RlX7opZlJG4D8MxnmNnpo3auKP9Kj9EbZRpdIYVLuZGBrnLY8j8c1VqLq7TvaLX
         RG1sE5E5XniB9TLlFY/BBXMRfvP9Q/vWJJe4xBJ0I6llgk94KjaN90THNwkBSscqaBud
         jEEoVoAftrYwVwRJzDLpa6bK0vxsGH3irp9Atu8ttwahyY7gj+ZKhScFeXEBg/lJUIE7
         LBaZOqGh8dAEHfH8Wam/0/Q3Vh4DaAAdZKLV+ak4dmQnVNDwWC0cYI+v+1hsL7EA4TmF
         X/oQTq9erjqEAktuWQU27LmLMm6OEO4mSn43/xIQJ9EycfijywRzyVb/HtmsTZNXiVnq
         7jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6GN7npjxxTr3rPYtuepca6vGbGAXTsJ8Kzpp5ATUsdw=;
        b=uDJVoVadvd1VheBen2PWR0eXuGu3pqppGAegDiUp2pMzdAIKohtH710JntfQGvh3GT
         FtzxuCk/NEfumZTngH22MyiELl5rlBK+EuqHS/bPYKVIK9RcuH+t1WyNyzak3u56KNb9
         1hdllDBzhaMRJabdfZMigGgmSF5Gr6zFKeoKptVTak/9Itv8WL6lIl6hJrLUG/0I2luU
         Z03xtw32O3UhMndbUS85V4w27lCV3ktsMUzt9ZKssDiwlgcxqlLh5xUQMPB/CVAu87LH
         xuomnpUDqlYsojWHEoHh4InbDssaE0EuyeGYD/9aiOrHCm4GzEGnbSQfIFyY9NUIH034
         GCLw==
X-Gm-Message-State: AOAM533TNlzw4yyhdg4wy+ZsFpl3ni5j1UwEFS89rX8mYC+9EQKlmivZ
	nMe+R545cFRIRWGzuPpvdV9AYY2GbEa4ZOMKpyQPVw==
X-Google-Smtp-Source: ABdhPJyjO2B4hXY24WEEGwlIuPpg4FfTezqFCUS4ic4R2uhx2bTJMEpR+dYhDb9s1MeW4T4D6mGCJLUny6JoCNgf/Ls=
X-Received: by 2002:a17:906:5655:: with SMTP id v21mr5417109ejr.264.1613533729091;
 Tue, 16 Feb 2021 19:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20210205222842.34896-1-uwe@kleine-koenig.org>
In-Reply-To: <20210205222842.34896-1-uwe@kleine-koenig.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Feb 2021 19:48:39 -0800
Message-ID: <CAPcyv4gMg7ksLS6vWR3Ya=bZd5wBiRLtSGxf6mc3yqf+3rA_TQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] dax-device: Some cleanups
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Message-ID-Hash: NY4HLP6ZBIVP2MTFGPYRBHZLDVVIPV3H
X-Message-ID-Hash: NY4HLP6ZBIVP2MTFGPYRBHZLDVVIPV3H
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NY4HLP6ZBIVP2MTFGPYRBHZLDVVIPV3H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBGZWIgNSwgMjAyMSBhdCAyOjI5IFBNIFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xl
aW5lLWtvZW5pZy5vcmc+IHdyb3RlOg0KPg0KPiBIZWxsbywNCj4NCj4gSSBkaWRuJ3QgZ2V0IGFu
eSBmZWVkYmFjayBmb3IgdGhlIChpbXBsaWNpdCkgdjEgb2YgdGhpcyBzZXJpZXMgdGhhdA0KPiBz
dGFydGVkIHdpdGggTWVzc2FnZS1JZDogMjAyMTAxMjcyMzAxMjQuMTA5NTIyLTEtdXdlQGtsZWlu
ZS1rb2VuaWcub3JnLA0KPiBidXQgSSBpZGVudGlmaWVkIGEgZmV3IGltcHJvdmVtZW50cyBteXNl
bGY6DQo+DQo+ICAtIFVzZSAiZGF4LWRldmljZSIgY29uc2lzdGVudGx5IGFzIGEgcHJlZml4DQo+
ICAtIEluc3RlYWQgb2YgcmVxdWlyaW5nIGEgLnJlbW92ZSBjYWxsYmFjaywgbWFrZSBpdCBleHBs
aWNpdGx5DQo+ICAgIG9wdGlvbmFsLiAoRHJvcCBjaGVja2luZyBmb3IgLnJlbW92ZSBmcm9tIGZv
cm1lciBwYXRjaCAxLCBpbnRyb2R1Y2UNCj4gICAgbmV3IHBhdGNoICJQcm9wZXJseSBoYW5kbGUg
ZHJpdmVycyB3aXRob3V0IHJlbW92ZSBjYWxsYmFjayIpDQo+ICAtIFRoZSBuZXcgcGF0Y2ggYWJv
dXQgcmVtb3ZlIGJlaW5nIG9wdGlvbmFsIGFsbG93cyB0byBzaW1wbGlmeSBvbmUgb2YNCj4gICAg
dGhlIHR3byBkYXggZHJpdmVycyB3aGljaCBpcyBpbXBsZW1lbnRlZCBpbiBwYXRjaCA0DQo+ICAt
IFBhdGNoIDUgZ290IGEgYml0IHNtYWxsZXIgYmVjYXVzZSB3ZSBub3cgaGF2ZSBvbmUgZHJpdmVy
IGxlc3Mgd2l0aCBhDQo+ICAgIHJlbW92ZSBjYWxsYmFjay4NCj4gIC0gQWRkZWQgQW5kcmV3IHRv
IFRvOiBhcyBoZSBtZXJnZWQgZGF4IGRyaXZlcnMgaW4gdGhlIHBhc3QuDQo+DQo+IEFuZHJldzog
QXNzdW1pbmcgeW91IGNvbnNpZGVyIHRoZXNlIHBhdGNoZXMgdXNlZnVsLCB3b3VsZCB5b3UgcGxl
YXNlDQo+IGNhcmUgZm9yIG1lcmdpbmcgdGhlbT8NCg0KSSd2ZSByb3V0ZWQgZGV2aWNlLWRheCBw
YXRjaGVzIHRocm91Z2ggQW5kcmV3IHdoZW4gdGhleSBoYWQgY29yZS1tbQ0KZW50YW5nbGVtZW50
cywgYnV0IGEgcHVyZSBkZXZpY2UtZGF4IHNlcmllcyBsaWtlIHRoaXMgSSBjYW4gdGFrZQ0KdGhy
b3VnaCBteSB0cmVlLg0KDQpPbmUgc21hbGwgY29tbWVudCBvbiBwYXRjaDUsIG90aGVyd2lzZSBs
b29rcyBnb29kLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udmRpbW0gbWFpbGluZyBsaXN0IC0tIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcK
VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBsaW51eC1udmRpbW0tbGVhdmVAbGlzdHMu
MDEub3JnCg==
