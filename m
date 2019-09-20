Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03BB9AF1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 21 Sep 2019 01:52:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 10F1321962301;
	Fri, 20 Sep 2019 16:51:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0266202ECFBD
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:51:21 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d22so2618567pls.0
 for <linux-nvdimm@lists.01.org>; Fri, 20 Sep 2019 16:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8eg0Go6Vco6zmrMokIuCHT90eNcEj+1gkgwUozbRoOU=;
 b=C3ZFMMtvPf81TgLhiSeEgf2YDVeBRSaHW0FNEf+k4vFeia1DmItLwfEBHoOIfODtlF
 gEyN20SdH4KLHWwmhavoas54tR7qUqGUNdwwesdSM+wK3SyllrG5IxRh96WXtnnrfY7d
 pWKppGT1A1o2nr1VJ5fMakqYDf8QR5Hd9B9Tr6251H/ZqxARqyg4FG/IYVzwg6lZHgw9
 KjiL/8lm/frPH5jhCZqRRWZnbSsN2mWbWgq5azfITpuYNj1mNqmc8FRarPSRhSul8KEc
 RmmD1CROxNKOEtIbX+4Fprl/YK9aZC0HXh6DiK9VVU/3W0qEmA2PmqxFFb9ET+vFYLUq
 AVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8eg0Go6Vco6zmrMokIuCHT90eNcEj+1gkgwUozbRoOU=;
 b=AdbVMlDoRdryqLnhAzBAi6poMoe/cJ2HOa1BJ3ODc1LGr19TS8d5Z9/Q+6zPI+LAUE
 23E2JlURe6Q8a6yd7m1JshqIHWNC5eabv2t9M59JCMsEhPMI1FQ9K+pswEUKEmdz3fBl
 9XUwadah9tqyIJoxYQ1CHba4cSOBenCN0KnrBfHj95IW/8iDYxAL+IEejgsdpr7u1yu8
 0wySsflQ3kQ49U7ZzEgWpD6zCLZM5q8UGFV8fBQNvFss9EvYCu27vT8Rv7isiVq6l5+C
 5B59Al0Y0gbEbcSOoC4Knuti5l2OJEGIfPsA7kh97HcIE0NgW61DlQAs6a5wODdDXmGk
 AfpA==
X-Gm-Message-State: APjAAAW+xZObqNeGhtUSXEkgkTV0AWwz+DqdSpd/ZZ7lFXXK4iyqqIpe
 i7f+1eZtTBb/AKRVMPCCUEdNu7DdWD7wjg2wxBfk5Q==
X-Google-Smtp-Source: APXvYqxVNfOs4Ho/5kXpPZVj8oP5ezLhr8UaD2UCudmwUKwPDFfSFY4+sFjwQIeK+urY5OGR284WgAH5zN0eWfy9OQU=
X-Received: by 2002:a17:902:169:: with SMTP id
 96mr18912291plb.297.1569023545999; 
 Fri, 20 Sep 2019 16:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190920231923.141900-1-brendanhiggins@google.com>
 <20190920231923.141900-7-brendanhiggins@google.com>
 <20190920233600.48BBA20644@mail.kernel.org>
 <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
In-Reply-To: <CAFd5g46pndA_gOD9i8M5e5fb8x4mSL9mcgMDujN7XufeFs8bmQ@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 20 Sep 2019 16:52:14 -0700
Message-ID: <CAFd5g44E9Z=wRLarzcirAMudQ5=_3d4gnYfAwM9T2XB+sr+_qg@mail.gmail.com>
Subject: Re: [PATCH v16 06/19] lib: enable building KUnit in lib/
To: Stephen Boyd <sboyd@kernel.org>
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
Cc: Petr Mladek <pmladek@suse.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Sep 20, 2019 at 4:44 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Sep 20, 2019 at 4:36 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-09-20 16:19:10)
> > > KUnit is a new unit testing framework for the kernel and when used is
> > > built into the kernel as a part of it. Add KUnit to the lib Kconfig and
> > > Makefile to allow it to be actually built.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Cc: Randy Dunlap <rdunlap@infradead.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > ---
> > >  lib/Kconfig.debug | 2 ++
> > >  lib/Makefile      | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index 5960e2980a8a..5870fbe11e9b 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -2144,4 +2144,6 @@ config IO_STRICT_DEVMEM
> > >
> > >  source "arch/$(SRCARCH)/Kconfig.debug"
> > >
> > > +source "lib/kunit/Kconfig"
> > > +
> >
> > Perhaps this should go by the "Runtime Testing" part? Before or after.

Now I am actually thinking that it should be a menuconfig...

> > >  endmenu # Kernel hacking
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
