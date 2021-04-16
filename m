Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295A36276C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 20:05:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA6BA100EAB70;
	Fri, 16 Apr 2021 11:05:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.218.47; helo=mail-ej1-f47.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 826B9100EAB6E
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 11:05:49 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id w3so43425262ejc.4
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uc9tpLdABKe3k+bL9U1Q0ClltNGtCJ/DmDcgCrhYdYg=;
        b=K3Y4k6P9B2fQV4CiR+khvfZXow2zdY2hX27fW9sgnIblaRE2hi2taF7p9Q4+AVcl4s
         PfD8Ve5pKKASpKAll7IWIR3sutavY35ZyGnoSeGS8TSFfO7pt0sY4jZ2NOXX3aa+uGEt
         hS8GPNmg0Kma0AUOiHZGH3XRkgHpY3q9QceqDF/VvGGr6hxG6R/PlKMfXoOLDzdf8+FE
         JWH+eP92Afm41WhA/O1edLt5VLQcWd/s3RUB7P/6f157Rp/NIu9TD3WCQCkg/FgRiFYR
         csxIBYc1ZQnzWAR8kN1svzNl5N3wrbg/gOMMMDKcCXCLEOdXR8MKYtIJJrmNX1ZgDtAA
         gCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uc9tpLdABKe3k+bL9U1Q0ClltNGtCJ/DmDcgCrhYdYg=;
        b=el0NUkxOOHOQO2qBEkAqOHdf+xkVajbB2Kg52JjrlTHeRSxohv00eqVPbMq3f0z5st
         li7X98W+g1eyhF0/bePKK/IY1wq9B1XOLy4EzYKOhP218+uNTjBBU2KS+oq4/nozySnE
         ATLok10UPZL0Y3wJsYXS3qOKgl3vr4DhBFf+t3I3X1UkjPaneUpSF1f804r0CUytVm5i
         WrM7Xcb13ix8lxYgVBKNq/wtMNLKe5kZv/mLYFwA8+DpjEiDaOMgfo40pMNSPVxDY7s/
         eN7q3mlaYs4LX4JyJ0HStxNnZScKmtHxDwlx38zSr0THsWxYEFXVoLOa0vvJAoGXjaC2
         jLEA==
X-Gm-Message-State: AOAM533dy8xJCef+TOFrOvt/sRTuBgoQsOEjiF67E7YOGk3z6fq5QTiV
	RC5826MM54K/29GUCdSUQ3QZr+U8fFntjXO5VHpEZg==
X-Google-Smtp-Source: ABdhPJzkDt6LekTblXCPYAUVMDzlqIo96JgBbNZCYuPdE91LgUOXmqNtScSYjIQX27TBLJw8r7il/9ZzZaWobeHGEDM=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr9559800ejw.341.1618596287889;
 Fri, 16 Apr 2021 11:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com>
 <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
 <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
 <CAPcyv4jzg23CoQeqAyAR=PUjB4HG-FSnD8G0J7S=p22ANmzDMQ@mail.gmail.com> <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
In-Reply-To: <YHnKg4MHkZ4QIBHR@smile.fi.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 16 Apr 2021 11:04:36 -0700
Message-ID: <CAPcyv4j+66FaPHPLkF+ZPQq=uncYJ1Mx8JMzZnhp86qS=JewjQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID-Hash: DXQPE7V55NJXH2YDDKT2QN5AYVYFPYWQ
X-Message-ID-Hash: DXQPE7V55NJXH2YDDKT2QN5AYVYFPYWQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DXQPE7V55NJXH2YDDKT2QN5AYVYFPYWQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 10:34 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Apr 16, 2021 at 09:15:34AM -0700, Dan Williams wrote:
> > On Fri, Apr 16, 2021 at 1:58 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > > On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > Strictly speaking the comparison between guid_t and raw buffer
> > > > > is not correct. Import GUID to variable of guid_t type and then
> > > > > compare.
> > > >
> > > > Hmm, what about something like the following instead, because it adds
> > > > safety. Any concerns about evaluating x twice in a macro should be
> > > > alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> > > > not an array.
> > >
> > > ARRAY_SIZE doesn't check type.
> >
> > See __must_be_array.
> >
> > > I don't like hiding ugly casts like this.
> >
> > See PTR_ERR, ERR_PTR, ERR_CAST.
>
> It's special, i.e. error pointer case. We don't handle such here.
>
> > There's nothing broken about the way the code currently stands, so I'd
> > rather try to find something to move the implementation forward than
> > sideways.
>
> Submit a patch then. I rest my case b/c I consider that ugly castings worse
> than additional API call, although it's not ideal.

It sounds like you'll NAK that patch, and I'm not too enthusiastic
about these proposed changes either because I disagree that the code
is incorrect. Is there another compromise?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
