Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCBE2EA417
	for <lists+linux-nvdimm@lfdr.de>; Tue,  5 Jan 2021 04:50:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2534100EBBAB;
	Mon,  4 Jan 2021 19:50:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C2B53100EC1FA
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 19:50:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g24so29613783edw.9
        for <linux-nvdimm@lists.01.org>; Mon, 04 Jan 2021 19:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3i2DWNklZVjsl2UAKCa7AqbN0KVFXiRrj/Leq+WDOM=;
        b=QaoV+dt85/SIxPaD152+bpRXhieIfNZjXCLFUmnjYeOVSlH2J6hfzWGAON68nNBgrD
         /TguU7C/InTWFGCWhMMaUvR7E8YseVqLQhvWeGBHfIum06L67uPE7MK4PTnqxNrhKbi0
         Top9zLT03LMVUN9t9xou9mOwcAu0SfHQ8vG3cNhJZ94pMrW4w26tG2JgcA4Vz2Cr4+HC
         8m1ps6dEEn5wYPuqceRcDZBtkNqB42Io6Hq+8OWaLe+fItq9KgaSbkU3ML5wcpih3N4Z
         i36QU52gQvhylBwEKNULGyufAdMV0f6PG3GdI2IvKEIxPWba7I2olzRfKUvZqdepRwUn
         agJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3i2DWNklZVjsl2UAKCa7AqbN0KVFXiRrj/Leq+WDOM=;
        b=sq2TiNapnB/In9TI8iuXdQtQn4XqAZhX9t2SGG9kCESfV/jfDp1Hd3SJRaOqHyDLDs
         1nQT1XKGq/4JFX6NT7KHacZalzFkcZouLXFsvpiPmXMz1X8YNILmv7pqxnPtQVXpOajr
         l4YQE3HZQh09TmtUOroYJr2/aAlapQWxSCz9FCLLBYAEOkTMiOPpNE0LeRUoOqPz9CfI
         MKW+4zd8aDm4Soi8TDTS0mJ9Bxay6VRUkV8wqYDZGLg6ezQJcJhx8IkWwxyazFvGNeFe
         FmGtxPzKTEG2ZVPyvieKVgSJFYI2+QoB2XQZ0X2rTxnUFCWrf228LGTP3o9rOTKIZGfB
         8Gbw==
X-Gm-Message-State: AOAM532ObL3kCaMmGdg4RtW3cyeIDO3W3yHSZp8j/ThwRojTr4Rz9PMy
	YmWu6np7WiOimPML3kjbROCUrwacPECNyF6a0rye7w==
X-Google-Smtp-Source: ABdhPJwknNce1uVDk7EBKnwBvIlU5uz+2znHV465a20iudsxykeAovWJHlAtM2Cs1s+X+Z7S8tkSSZkk+wewPh3CAo8=
X-Received: by 2002:aa7:df0f:: with SMTP id c15mr75010622edy.354.1609818645726;
 Mon, 04 Jan 2021 19:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20210101042914.5313-1-rdunlap@infradead.org> <CAPcyv4jAiqyFg_BUHh_bJRG-BqzvOwthykijRapB_8i6VtwTmQ@mail.gmail.com>
 <f7803685-e255-7cfe-5259-e2a7dc5ab581@infradead.org>
In-Reply-To: <f7803685-e255-7cfe-5259-e2a7dc5ab581@infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 4 Jan 2021 19:50:39 -0800
Message-ID: <CAPcyv4jPwk_xjeVjv0LhXr_d9+dbcEDJ_YOF+qrX97e_CE8yRA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
To: Randy Dunlap <rdunlap@infradead.org>
Message-ID-Hash: JGAXDMDWMC57FEP6KGJEMMKWRZDJIICQ
X-Message-ID-Hash: JGAXDMDWMC57FEP6KGJEMMKWRZDJIICQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JGAXDMDWMC57FEP6KGJEMMKWRZDJIICQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 4, 2021 at 7:47 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 1/4/21 12:13 PM, Dan Williams wrote:
> > On Thu, Dec 31, 2020 at 8:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> >> resulting in a build error.
> >>
> >> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> >> add <asm/page.h> to fs/dax.c to fix the build error.
> >>
> >> ../fs/dax.c: In function 'copy_cow_page_dax':
> >> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]
> >>
> >> Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Vineet Gupta <vgupta@synopsys.com>
> >> Cc: linux-snps-arc@lists.infradead.org
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Acked-by: Vineet Gupta <vgupts@synopsys.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Matthew Wilcox <willy@infradead.org>
> >> Cc: Jan Kara <jack@suse.cz>
> >> Cc: linux-fsdevel@vger.kernel.org
> >> Cc: linux-nvdimm@lists.01.org
> >> ---
> >> v2: rebase, add more Cc:
> >>
> >>  arch/arc/include/asm/page.h |    1 +
> >>  fs/dax.c                    |    1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> --- lnx-511-rc1.orig/fs/dax.c
> >> +++ lnx-511-rc1/fs/dax.c
> >> @@ -25,6 +25,7 @@
> >>  #include <linux/sizes.h>
> >>  #include <linux/mmu_notifier.h>
> >>  #include <linux/iomap.h>
> >> +#include <asm/page.h>
> >
> > I would expect this to come from one of the linux/ includes like
> > linux/mm.h. asm/ headers are implementation linux/ headers are api.
> >
> > Once you drop that then the subject of this patch can just be "arc:
> > add a copy_user_page() implementation", and handled by the arc
> > maintainer (or I can take it with Vineet's ack).
>
> Got it. Thanks.
> Vineet is copied. I expect that he will take the v3 patch.
>
> >>  #include <asm/pgalloc.h>
> >
> > Yes, this one should have a linux/ api header to front it, but that's
> > a cleanup for another day.
>
> That line is only part of the contextual diff in this patch.
> I guess you are just commenting in general, along with your earlier
> paragraph.

Yes, I was prefetching a "...hey, but, there's an asm/ include right
below this one?"
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
