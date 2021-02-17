Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB431D44A
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 04:38:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2C10100EAB45;
	Tue, 16 Feb 2021 19:38:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 657FF100EAB42
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:38:10 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j9so4549460edp.1
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 19:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kL25i8Zz9G4d7AUFP51OG9jU0cPZgNzUVGr5+p5yT3A=;
        b=EZRAxdpojciOJtQmt+mWxk42W5j54FKU6esBNiyrMLkROt4kVy4rnatzjpn6EozfTs
         kVoJSAXlWtceQ0iWkT6OBSH4PdLxdnXfRDS6YWOsrGGA9yNKhUN3Q+s0BbqTi7obE9iF
         QaN3tCCpXd0dJhZrWt0A3xBdjGkaA4r4f1SXZygROYxP2Z3MJc/ip0GGC+EmN2nJr3MY
         MEkwjmobcosipCuOO/9yB/8L4a4DKUNIg9V2wPJx0KlbADUMWAFwBwTJ3fwzBOFlGcI2
         m7MlH43LPwpIz9S1l7g+PaBfSXCV6mMJTRFvQ3NgDHRLHcxbVB/BKrIBNFN2ETAc22PK
         khbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kL25i8Zz9G4d7AUFP51OG9jU0cPZgNzUVGr5+p5yT3A=;
        b=ai4XbL7HvreKkkeD/lmTuY8aKjSTjGMkq/OMRawf0HYS/wwbZdmHfNOr4hX6MdaJLL
         7uaMiNwafDM0U8Ehd8ToUYknS9RXSoOx4c3TLWE/YRFuEnzupTeGq8eLbYOlIpesz5in
         mbN2V9PgMhTlE94CJc/rta+aky7VOWaAngtPnapBP5ItvLyJDieKJAsTq0ocdyDQy640
         2lEuxMxql5V9cHrf6k1ooK+4BrwRHpcYM3n/mjjRGyNb4du0T1l2eW95AnK4Fmj0LdhD
         Gm7XU4Uq8eafSs/yJjn6eVUK+xyd12V4i2tX58ZLBKpsVHAjdR5kfBryd+x0pszbisS8
         FFMw==
X-Gm-Message-State: AOAM533EJ4Vu1XvfaLx1z8HZueGFOf6b+YT0PRQavJ7ddXKiNprphP1b
	ct8RsLPX/sYLCDPFl+jcxvrNwLor8Hmm/OwGR/owpQ==
X-Google-Smtp-Source: ABdhPJzmEDnNgd7IqCzjUQKrXhbKhY+f/9y2AvYFB6jH8yvpz7j9l35QNyenrz406rsJoK7+pFPQBYpfA9D0wos5jvA=
X-Received: by 2002:a05:6402:306c:: with SMTP id bs12mr24297164edb.348.1613533087806;
 Tue, 16 Feb 2021 19:38:07 -0800 (PST)
MIME-Version: 1.0
References: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de> <20210212171043.2136580-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210212171043.2136580-2-u.kleine-koenig@pengutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Feb 2021 19:37:58 -0800
Message-ID: <CAPcyv4jVw6o7Yznxs7UDMnSoJLozx86v5YCg6YZGeGm6emyooQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: Make remove callback return void
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID-Hash: T7ELI7XYX36MNULLEJNJP3FUS7IFHPW7
X-Message-ID-Hash: T7ELI7XYX36MNULLEJNJP3FUS7IFHPW7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T7ELI7XYX36MNULLEJNJP3FUS7IFHPW7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBGZWIgMTIsIDIwMjEgYXQgOToyMSBBTSBVd2UgS2xlaW5lLUvDtm5pZw0KPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQo+DQo+IEFsbCBkcml2ZXJzIHJldHVy
biAwIGluIHRoZWlyIHJlbW92ZSBjYWxsYmFjayBhbmQgdGhlIGRyaXZlciBjb3JlIGlnbm9yZXMN
Cj4gdGhlIHJldHVybiB2YWx1ZSBvZiBudmRpbW1fYnVzX3JlbW92ZSgpIGFueWhvdy4gU28gc2lt
cGxpZnkgYnkgY2hhbmdpbmcNCj4gdGhlIGRyaXZlciByZW1vdmUgY2FsbGJhY2sgdG8gcmV0dXJu
IHZvaWQgYW5kIHJldHVybiAwIHVuY29uZGl0aW9uYWxseQ0KPiB0byB0aGUgdXBwZXIgbGF5ZXIu
DQoNCkxvb2tzIGdvb2QsIHRoYW5rcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxpbmcgbGlzdCAtLSBsaW51eC1udmRpbW1A
bGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gbGludXgtbnZkaW1t
LWxlYXZlQGxpc3RzLjAxLm9yZwo=
