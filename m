Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 722E113B955
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 07:02:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 280A110097DC1;
	Tue, 14 Jan 2020 22:06:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 803DB10097DBE
	for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 22:06:06 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c77so14313891oib.7
        for <linux-nvdimm@lists.01.org>; Tue, 14 Jan 2020 22:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WyKlBkScoVZ6BBeE/lvKOUnxM2fwU6k2+3ORlYeQ1JU=;
        b=HNS/MuCyM2Y0rPTycj0ERFuxRvMu1QHpp95g6CP0C2mcOOP17W3rjfRnyo8mZNws9l
         Bcv17zUUAkkGTvOLwd1IP1Q6kQdxkNC/BtRTUsWN9in2f4VRO4DjkljU1DghPGI42WVQ
         jUuVLY3zCBFOvviuNPlx0NRWZKXOYYWOD0An0XLByT1bn95S8DuHxEUEKSnrL30YhlyT
         +h+l0ymO2e0tgatyf84uKe0HDE06uZYrHOHGYewqXSfc7NmSlTYA6qssHrbd2ft+e7BG
         Ov/+58wifUZ6rKsf/zQwYB50hnJMVNNyZF84Dl5dZNk3GBE3TR4AQ7f8vv5m0rnBpM3q
         yzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WyKlBkScoVZ6BBeE/lvKOUnxM2fwU6k2+3ORlYeQ1JU=;
        b=rjQSJY8kN68RHFX1AJQhag20xrLtf6PTviza9LdFiwlpnyF5Wus0IkMr4RGVAOM8GJ
         I3IHiKmgsowtb3lUSFPqSfpM1zjt/iC4gUh/lIgR1QM/kecX/MwyYxu1z8gmuJYR67gP
         4LqhabJ+P9TcX2nkOkRCLSVZDtthicicSC3UZyjLr0kDV129Ozm4P7neFBGvhpkArWrb
         pMZVCdadeamGBpJrGysHxZrl52AiOZ7ly76KD6NGjg5SaBHS7p2lvg/H+nuClGKx7rHr
         hvdObsYWZzh3QJ86Ntic+pMNqRWTrPgYxZgnMhO76OrHmOCtFj+QxpM3CY4OMWwnNz6j
         Kn2g==
X-Gm-Message-State: APjAAAUDiqtnFuPXrnkf2Qgb2+pVl+3XS6wofN6SMmByWzIcACPWe5TJ
	LQDPCNbQ2Z1oul0acK+ImBmrPCndQniKoII5lrzK0A==
X-Google-Smtp-Source: APXvYqzeuAG8OGRFPj/VxBeMJvbxWakGlATFxZiTEHM5ApidHx987T6zad1F65AWRIeqz6hwenMYEqMe9i/yHCxcJeM=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr20144974oij.149.1579068165602;
 Tue, 14 Jan 2020 22:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
In-Reply-To: <20191225054227.gii6ctjkuddjnprs@xzhoux.usersys.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 14 Jan 2020 22:02:34 -0800
Message-ID: <CAPcyv4hMPh0C+_OV+vuiYQikb8ZvRanna4vXfKN=10yrAyCjDA@mail.gmail.com>
Subject: Re: [PATCH] mm: get rid of WARN if failed to cow user pages
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID-Hash: INW7MIJAQ3VZQ4QXPDGEDPFXKOOY557R
X-Message-ID-Hash: INW7MIJAQ3VZQ4QXPDGEDPFXKOOY557R
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Jia He <justin.he@arm.com>, Linux MM <linux-mm@kvack.org>, "Shutemov, Kirill" <kirill.shutemov@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/INW7MIJAQ3VZQ4QXPDGEDPFXKOOY557R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ drop Ross, add Kirill, linux-mm, and lkml ]

On Tue, Dec 24, 2019 at 9:42 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> By running xfstests with fsdax enabled, generic/437 always hits this
> warning[1] since this commit:
>
> commit 83d116c53058d505ddef051e90ab27f57015b025
> Author: Jia He <justin.he@arm.com>
> Date:   Fri Oct 11 22:09:39 2019 +0800
>
>     mm: fix double page fault on arm64 if PTE_AF is cleared
>
> Looking at the test program[2] generic/437 uses, it's pretty easy
> to hit this warning. Remove this WARN as it seems not necessary.

This is not sufficient justification. Does this same test fail without
DAX? If not, why not? At a minimum you need to explain why this is not
indicating a problem.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
