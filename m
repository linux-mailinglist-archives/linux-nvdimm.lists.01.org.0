Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2B49DD4D
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 07:49:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AF5E20215F75;
	Mon, 26 Aug 2019 22:51:16 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::344; helo=mail-ot1-x344.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02D9620213F09
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 22:51:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id r20so17553050ota.5
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 22:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7RBGb3OLJpAQau2j2snbl6ZXBD+gjXfBLYIYixGrB0c=;
 b=n7XMRyf/Ux88Ml8xjGhdXA9Q3iFgJtT0BpZPsWc98cEcFJ6TQiYB0p3+BFgdYbK0ks
 Eu6G39nq/TPJjUAhyfj0u+5OUinp0KQQSzJb09SUoRMsiIXwOyxTb5qs0uc/7EP8YyrJ
 W0wpqtSvCeW+9p6v4bb2bvW6uJsUMRjVaHF1W+6kItySBxerIkc2Qt5F8b8CAxBSG8f6
 beq5q5PWSa66mvnAnFGcQ60seo1+/Fc4DBSkpO6xcYSrysoRPzNKuhGk/92p3SlULFnL
 VitTGP0DJ0qVGff0ycBHaSWfSQ5vpt3KcbNH2fMIMCskHaD0I0YeRxiE1UqwrywY3q4F
 x3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7RBGb3OLJpAQau2j2snbl6ZXBD+gjXfBLYIYixGrB0c=;
 b=gojsQAhpmz8WOvd9f/1oyib6y0nWynANazz8TwgrYT8jgA6izitm6Pb7MmiDg5zjYn
 SOqlN4/HsCervDmdv+TAJztPssMVWOjNfO1oPprykAc1sle2Ls6dNIaddms9UelSUZtz
 D7OKfer0twT0vK6/Yn5FHZ6zockU3uxSKT6GpBDYHj0oSMshzV1O5MpywLbfL3vbCglR
 Acu0vOOwGz5iJrPtT6f5ufYEnvRmvfScQlr4SCFpYEwQ7bN4G0Qygy83OSHIeBuquzg9
 36liODV4Z2ZquBIpxt2kAKg8mUYBwEDjAzrM1gxExE8dUtS/Hxr1gZEgKDxH1E6BWgvQ
 m/KQ==
X-Gm-Message-State: APjAAAUyAJvm8XT2U9Fk3TlVQK+BQpF4fRS5kLOBfiNAjTvSfvRo0Fzv
 UPxVnNbIclAQOjXuBo//V4g5Z9nAWONRc3+iPDOoKA==
X-Google-Smtp-Source: APXvYqyHt3ylRYIOT6ImiUvFQ/SX/9gr7Aon0ozM+XiDQ3ga7QMUZtYdtrQMwzADy4l4V7UM7IwD4lDixKw+wDlCjEs=
X-Received: by 2002:a05:6830:458:: with SMTP id
 d24mr12220534otc.126.1566884941281; 
 Mon, 26 Aug 2019 22:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607202332.GB32656@bombadil.infradead.org>
In-Reply-To: <20190607202332.GB32656@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 26 Aug 2019 22:48:50 -0700
Message-ID: <CAPcyv4gU_AfUoh7certr31f+7eZWfkEVqmNLtY2v7H54BxZK1w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] lib/memregion: Uplevel the pmem "region" ida to
 a global allocator
To: Matthew Wilcox <willy@infradead.org>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: X86 ML <x86@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 7, 2019 at 1:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jun 07, 2019 at 12:27:50PM -0700, Dan Williams wrote:
> > diff --git a/lib/memregion.c b/lib/memregion.c
> > new file mode 100644
> > index 000000000000..f6c6a94c7921
> > --- /dev/null
> > +++ b/lib/memregion.c
> > @@ -0,0 +1,15 @@
> > +#include <linux/idr.h>
> > +
> > +static DEFINE_IDA(region_ids);
> > +
> > +int memregion_alloc(gfp_t gfp)
> > +{
> > +     return ida_alloc(&region_ids, gfp);
> > +}
> > +EXPORT_SYMBOL(memregion_alloc);
> > +
> > +void memregion_free(int id)
> > +{
> > +     ida_free(&region_ids, id);
> > +}
> > +EXPORT_SYMBOL(memregion_free);
>
> Does this trivial abstraction have to live in its own file?  I'd make
> memregion_alloc/free static inlines that live in a header file, then
> all you need do is find a suitable .c file to store memregion_ids in,
> and export that one symbol instead of two.

It turns out yes, this needs to live in its own file. It's an optional
library that does not fit anywhere else, everywhere I've thought to
stash it has either triggered obscure build errors based on idr.h
include dependencies or does not fit due to build dependencies.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
