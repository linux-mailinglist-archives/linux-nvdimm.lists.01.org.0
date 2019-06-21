Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9484F00C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Jun 2019 22:35:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F3492212A36C4;
	Fri, 21 Jun 2019 13:35:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2A9DC2129F10F
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 13:35:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id x21so7497858otq.12
 for <linux-nvdimm@lists.01.org>; Fri, 21 Jun 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=F6N4vzXYO45VrrxREuSle642/F5pE0F/ACcjS4mEnlQ=;
 b=njYNoPS18hXaxkC3YGE+AqCazLdeIo2/cWKB3hIPgn4u04NPPFQdNq7MiKBw9g28ZC
 TDSPMO74uiVh19htSBPeEuLPPpEfbSqb+ixgzUAbMjG3vWKZetmsnwsl3A1elZbZ9Gug
 UFl8VTrGiL5UM+uz3n6ftPJeq2f03VmtpipPbaXcUjEyr06YQxLE0w38exZKyokYjJTs
 JnoNfM52zcdA90Qjk2Yfm5NmOzh+l37okU+SEuoafDF9qgT2+24SWw8iA08wiWyg5YCE
 WWz+HxXWw7kesykyoe/RvQGXNOac96qsEtgulvhXL3J6u665BXRNd5sXTyZrzUbw407V
 tp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=F6N4vzXYO45VrrxREuSle642/F5pE0F/ACcjS4mEnlQ=;
 b=WnCzoXOtCkQwavmMFrkL8c266mpKt1iOzEt+EYohXKCUU985QSD2bPhiW0txNx4Hnf
 VJg0L+tbW5C2kCb5UpIKzen/rP8CMYVhznf0HvjouHssKAVhXwJ0Xgl0mTdsfM40MyiA
 G8N6uQoD664i7fiWsY4UmlAN0K7J2SrOrHUaD8JF7Q98ul/efENruaNEU4v2A5TGbQf0
 /EN3rvsNyud5WcGwL+592H94MQRU8AytUngdBC1lZns1dO4dRRQi9sPIfdrZ24KLVw4s
 nRSzTfuayYvAp8afXO30EpQP7TmyH+9eAcJ5MbNyefTr+voEndeM8VmM+7WmSyLiyaQH
 yXSg==
X-Gm-Message-State: APjAAAWkIh+4msWBITiq4FgqrWKdkTWE42s5erKkay5ur1UmnNw6AbMo
 lMqC0Hv5Fhm+wYWEXsWsgQP7nnIlOsAHezeBXgY3pw==
X-Google-Smtp-Source: APXvYqyVIXwJLQJoHc1HCz5yxPWpUYSffjFt5ymtVvtrHSHsaR7IY2yiXFy/m/3qyTqddC2ne3tKGI+/g0x4KQ1ZATk=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr5297224otn.247.1561149352873; 
 Fri, 21 Jun 2019 13:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <155993563277.3036719.17400338098057706494.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155993567002.3036719.5748845658364934737.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190607202332.GB32656@bombadil.infradead.org>
In-Reply-To: <20190607202332.GB32656@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Jun 2019 13:35:42 -0700
Message-ID: <CAPcyv4iOKJEJu_dY3ZVmLou-GAxc1=RkhToyodR16LPvLQ3jfA@mail.gmail.com>
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

Ok, I think since these "memregion" objects tend to be closely related
to "device memory" I'll stash this in kernel/memremap.c with the rest
of the "ZONE_DEVICE" apis.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
