Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B653660F8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 22:34:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F068B100F227D;
	Tue, 20 Apr 2021 13:34:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BAC60100F227C
	for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 13:34:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u17so60286825ejk.2
        for <linux-nvdimm@lists.01.org>; Tue, 20 Apr 2021 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=eX+tArZrTN+puPDYkGABZ2V49+8iKQJiRylCO+bzXsU=;
        b=alcZeFZX2JvCPj8M6lWXxyotml+iOrJ+DVEPPFmgFgGlEM91gvcOh+46XVVVsOGjuo
         2PoZ95iXWphljYN6LKB/TTz23Q6ugTybuTJzuYmXFpczOiVGG27AVFwW/v4zkBSjokz0
         cCFZG5AXXgyg7BbhlUulYItI4fLgVwZWyKGnhd2T+dT41PQ1DLufnOBlxyZWtwgrxaVw
         0g/AI/woNFoboHEfl0nawbxoXCWSHR8ayX2LBCgRXTbZJqg9wLUoKgf0jBGRgBVf0VNN
         rtj5MAJ5ViIJK8BmhDorcmRhQdttODUmrZFm0XjFkS01u3kHiV4ODaMyHdxApAsb7foY
         N/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eX+tArZrTN+puPDYkGABZ2V49+8iKQJiRylCO+bzXsU=;
        b=dybvYfyhtlY3/nqv994lq8X7LK13wy7C8O3vmNxR2KR1WGv5LGHHDln/drzdnRGz5d
         ih8aBWdgDcWKYrom5WRPhvcKapAAAN7OB4kpGAuqsB483exgrYWk5ehFsBZrxIa7DBkp
         8e3z/igPEre1PHPud1bqRZRR3b+VXLLuoCQNIhClRm9AVxgIoa15+7qf0irp+2vCxZL9
         3EdthQHGS5Oqsp97E3MAXqfEfL2jO1+txNmoPYt9/t6RnoFxslhbZTz2l3ZgYzwY2DWu
         RGmCRE0sdAEOImZXKrx5AaugVUYN6yMpnQxwJgSwCwOe8ZHchhphZYnHO56vsgvFgkkw
         YGUQ==
X-Gm-Message-State: AOAM5308QBZgHQmgRkMeEdS0HPKEPHloUdl5iMrpVtxV+R1sTUbF+iOZ
	76Sme96H7zlpbCUGox5vVa1U+KzN++cMR8PB9LssnhaQJZ8ndQ==
X-Google-Smtp-Source: ABdhPJzAccSqZdvmxIwCwTUm+RAzULlEAI5dChg/ivduF2vXj97w9Xa6CHSaQVlGfUC9L8vKkFoLdA00bXUHcfqF/OY=
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr2974822ejj.523.1618950848934;
 Tue, 20 Apr 2021 13:34:08 -0700 (PDT)
MIME-Version: 1.0
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 20 Apr 2021 13:34:00 -0700
Message-ID: <CAPcyv4jyD57mTifvU5yCd6N3-pceyCC0=A83JovXuMR8=zVewQ@mail.gmail.com>
Subject: [ANNOUNCE] NVDIMM development move to nvdimm@lists.linux.dev
To: linux-nvdimm <linux-nvdimm@lists.01.org>
Message-ID-Hash: UMTDHEQ6ZJNPZNIGGFSUIBS5O7HWQJUG
X-Message-ID-Hash: UMTDHEQ6ZJNPZNIGGFSUIBS5O7HWQJUG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UMTDHEQ6ZJNPZNIGGFSUIBS5O7HWQJUG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There have been multiple occasions recently where people reported
trouble managing their subscription to linux-nvdimm@lists.01.org. The
spam filtering also appears less robust compared to other Linux
development lists.

There are also side benefits to being on kernel.org infrastructure as
it has a direct path to inject messages into the public-inbox
repository on lore, and feed the patchwork-bot.

You can find the subscription link here:

https://subspace.kernel.org/lists.linux.dev.html

For the v5.13 merge window I'll submit a patch to switch the list from
linux-nvdimm@lists.01.org to nvdimm@lists.linux.dev, and plan to
shutdown linux-nvdimm@ a couple months later around the v5.14 merge
window.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
