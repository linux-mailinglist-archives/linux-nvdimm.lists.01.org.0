Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB6931D3D2
	for <lists+linux-nvdimm@lfdr.de>; Wed, 17 Feb 2021 02:41:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9C06A100EC1D7;
	Tue, 16 Feb 2021 17:41:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C04E6100ED4BC
	for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:41:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so19594945ejf.11
        for <linux-nvdimm@lists.01.org>; Tue, 16 Feb 2021 17:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aUUOJlgDQumqSSsn6b2nMo56O2uNsyRlZI5+0ZRl54U=;
        b=KqWjsFoguTrjWzkyFDr4S7tTXgUIqm3Y4PfT/ofs5LnJNHjNgmSKwxSugOcsMWm6+H
         BoTlzMwTcNvHP6B0Bnl3Xw5Fe2tGprhZ2GPvM0Rn5udBuHOtQcFGiGfqkHM0oyecYmCz
         cKX/9lGvNYEBWtBhHKAZXOmol7P8xRKTge5POr7MV4CoGSMG6hqh5BbhJL2+h+QGvnqW
         XRTkRKha1iNLzP1IjVsvvhGwzrFR4R8anK/4zjo6cMe7tEDTn+DyDAOKf/rR5EYO6O9x
         Py/EDa7UkNGrJnz+qr3Y2R1KVSjVymb7XbkoDsAlcn8nQDCNjTw6dBJlhYLqjZLQow/f
         jUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aUUOJlgDQumqSSsn6b2nMo56O2uNsyRlZI5+0ZRl54U=;
        b=VMZcD/Azc92jjaGocIydEIWey6CuwtqUzK45qinMcPRgjNfPy13QEqJoXmrTS+pQGe
         TeSANvRES8p0WVF6d7p447v9+ltoEPuuCOQkbvWvLih2uFt0ARiCfbFS46X4FEBXraMC
         9Xp2pBcapv/Mjcgl+VPICi+3dQF4wKsp7LKa2k0Fl62qQKau23kfPVpcsIiED68u7t/W
         hEREpV+ifhzc+icuKk9K4ePxDEsvja57OYvWoJ/eD/OINfs2Uhg5kI2vErgdtYlYLxq2
         qpe/Ylggkta0zR1k0fEQ41riYhjKk3tnWepUWe5FCVGYGCQfohDxQR4PPipxwNI0Nen0
         3mWQ==
X-Gm-Message-State: AOAM530r5tqMuTjH4M6MevtdH5neZ13T/hZT99JSreaqLd65/NaGG0b8
	E8SSvMiYzg4XndUpWFDCiCFqnMmyCqfCC7/OfySQVQ==
X-Google-Smtp-Source: ABdhPJz4EYHuN8wyWFuoFR7FSadeWSJslfOV5vc8kLUvyWmZnsOwRzCVfCl3RDFdPjy97HCFJP5rvSPOVwvdT+ExobU=
X-Received: by 2002:a17:906:1352:: with SMTP id x18mr17937904ejb.418.1613526062947;
 Tue, 16 Feb 2021 17:41:02 -0800 (PST)
MIME-Version: 1.0
References: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20210212171043.2136580-1-u.kleine-koenig@pengutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 16 Feb 2021 17:40:53 -0800
Message-ID: <CAPcyv4gqXpQK5ta9enky1MrGVYAGa09DaJHod5CK9Ybe59772w@mail.gmail.com>
Subject: Re: [PATCH 1/2] libnvdimm: simplify nvdimm_remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Message-ID-Hash: YADJ76FEPPRE3MDC7VR4OEOKNBTTIXIO
X-Message-ID-Hash: YADJ76FEPPRE3MDC7VR4OEOKNBTTIXIO
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YADJ76FEPPRE3MDC7VR4OEOKNBTTIXIO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gRnJpLCBGZWIgMTIsIDIwMjEgYXQgOToxMSBBTSBVd2UgS2xlaW5lLUvDtm5pZw0KPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4gd3JvdGU6DQo+DQo+IG52ZGltbV9yZW1vdmUgaXMg
b25seSBldmVyIGNhbGxlZCBhZnRlciBudmRpbW1fcHJvYmUoKSByZXR1cm5lZA0KPiBzdWNjZXNz
ZnVsbHkuIEluIHRoaXMgY2FzZSBkcml2ZXIgZGF0YSBpcyBhbHdheXMgc2V0IHRvIGEgbm9uLU5V
TEwgdmFsdWUNCj4gc28gdGhlIGNoZWNrIGZvciBkcml2ZXIgZGF0YSBiZWluZyBOVUxMIGNhbiBn
byBhd2F5IGFzIGl0J3MgYWx3YXlzIGZhbHNlLg0KDQpMb29rcyBnb29kLCB0aGFua3MuCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52ZGltbSBt
YWlsaW5nIGxpc3QgLS0gbGludXgtbnZkaW1tQGxpc3RzLjAxLm9yZwpUbyB1bnN1YnNjcmliZSBz
ZW5kIGFuIGVtYWlsIHRvIGxpbnV4LW52ZGltbS1sZWF2ZUBsaXN0cy4wMS5vcmcK
