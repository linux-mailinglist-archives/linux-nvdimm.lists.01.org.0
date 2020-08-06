Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9123DB51
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Aug 2020 17:20:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EEC9012A73074;
	Thu,  6 Aug 2020 08:20:06 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 20BA712A7306F
	for <linux-nvdimm@lists.01.org>; Thu,  6 Aug 2020 08:20:03 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id f24so30253085ejx.6
        for <linux-nvdimm@lists.01.org>; Thu, 06 Aug 2020 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27KOdDBMR58YvRnK7H5/nd9yUqjH+UuYcfpnQiwOOLU=;
        b=tGrB7Z7WS0HHtWrS+RAu0IAYwU8Nad8rwMZdG73SY5x2ARE0d1FqXwWCLzD3UMrdlR
         6Kn0kjJyU3Zbj6OubM+TRf7kg41JZspNfLxofrrUzUQMRrYpHgt6yi61+Rzw0TSxyySG
         ZrV978lfm55ZcESwNGZp975asvMxzL4xk01lDpBkj9kuUKt1y4ZnLs/xyWsATvELhJk1
         kFLFuZbHju979DVXXQ3lQhqftMpDMvL9oc++9T2qcgkhq/HPw08XX+JQDNIRTow6uAXN
         WiVbdduH+x+EmynnvVmeE/Jlm8OcHRV5jln6i5lJFo17YjLsUFxNhJ1YjoX3Mjouet1b
         4MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27KOdDBMR58YvRnK7H5/nd9yUqjH+UuYcfpnQiwOOLU=;
        b=mbjuD93MmBXElZSMfaDmO8EYbamJjuWWLrJ2QmYT+sALQ7Bo8gIcU3GS7Ug2C5Jsqo
         y8mMmx3Zn5oB/RvmoTc3tW+Bt+EdGsXbf0Yot7+6iRlqifCpPxqNuangTduCJ01Q4ARG
         RUTY/V5HO/sxW2uSR2BBO/L4jM+aRQG0XcoAWUuwSC0QErSlFnWzD257m9klr1R2aKoa
         etkl9YDLEAT3pV0hioOvDs4naUXNQQhyyMOe+unbFAF9i2FEcF1vBp1WtsPPivpa1g77
         PqjvhX4Q2Qfaui3ke70423UZOsXKFuWVUNnAf2WNJZJeyd+uOTZ5w+Br4pWGB1N0oDqx
         MbvA==
X-Gm-Message-State: AOAM531e5PYxgDzhuOagOt255zIQXPuN+wQoMcG/S48B3gfAOw9Oxm/X
	qnqeSW+i5Zcc+bWusFGAvhufdg5JoJ0d1csb46t1Kw==
X-Google-Smtp-Source: ABdhPJzrlkvHWWpq4WM0aG15rib8qGzmbNy1T+8TCAaz/ASsMen1gmJIqTYuiQwAEJfL8+D0y5EKRfUDgIokuAOiI0I=
X-Received: by 2002:a17:906:38d8:: with SMTP id r24mr4667542ejd.341.1596727202027;
 Thu, 06 Aug 2020 08:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <159630256804.3143511.8894023468833792004.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200803094257.GA23458@shao2-debian> <20200806133452.GA2077191@gmail.com>
In-Reply-To: <20200806133452.GA2077191@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Aug 2020 08:19:52 -0700
Message-ID: <CAPcyv4hS7K0Arrd+C0LhjrFH=yGJf3g55_WkHOET4z58AcWrJw@mail.gmail.com>
Subject: Re: [x86/copy_mc] a0ac629ebe: fio.read_iops -43.3% regression
To: Ingo Molnar <mingo@kernel.org>
Message-ID-Hash: RPEHRGZIAIGWSL2RBZJ5KGS46QGXHJVN
X-Message-ID-Hash: RPEHRGZIAIGWSL2RBZJ5KGS46QGXHJVN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: kernel test robot <rong.a.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, stable <stable@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, Erwin Tsaur <erwin.tsaur@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 0day robot <lkp@intel.com>, lkp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RPEHRGZIAIGWSL2RBZJ5KGS46QGXHJVN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 6, 2020 at 6:35 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * kernel test robot <rong.a.chen@intel.com> wrote:
>
> > Greeting,
> >
> > FYI, we noticed a -43.3% regression of fio.read_iops due to commit:
> >
> >
> > commit: a0ac629ebe7b3d248cb93807782a00d9142fdb98 ("x86/copy_mc: Introduce copy_mc_generic()")
> > url: https://github.com/0day-ci/linux/commits/Dan-Williams/Renovate-memcpy_mcsafe-with-copy_mc_to_-user-kernel/20200802-014046
> >
> >
> > in testcase: fio-basic
> > on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 256G memory
> > with following parameters:
>
> So this performance regression, if it isn't a spurious result, looks
> concerning. Is this expected?

This is not expected and I think delays these patches until I'm back
from leave in a few weeks. I know that we might lose some inlining
effect due to replacing native memcpy, but I did not expect it would
have an impact like this. In my testing I was seeing a performance
improvement from replacing the careful / open-coded copy with rep;
mov;, which increases the surprise of this result.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
