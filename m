Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C492813644
	for <lists+linux-nvdimm@lfdr.de>; Sat,  4 May 2019 01:41:27 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB6E82124B93F;
	Fri,  3 May 2019 16:41:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8EFC72194EB7C
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 16:41:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o39so6790591ota.6
 for <linux-nvdimm@lists.01.org>; Fri, 03 May 2019 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mKALN1OkcwtQhcysb+FWH3t2vFKNjrdMKVQt2ijO0Po=;
 b=uHwVMflHMaQY3whJ1EE4nVizGRxOy/tr5WOjeZAzMUNneEi1VOxLR7ILboGXaDspKX
 EZdcTnWDLsjH5Xuv6Dpbla+mLd+ZOej6UTDsdicbg1f2NGRfNWvT53QLlViJ91MtO47Y
 +NMNZSv0/KOCCjGp/8Z6JcV8oAgctk1uHe5BjikYU+meECnNZzF0Xtb+m6Lql1RyQZ+f
 6pOCAlUul4FDKtOsuwcFiCf6Z4SU4Q97jpl1Ljx2pJqKs6Ok7cLSU5UcjCBf989disYo
 L1k/caWEqmSpv8hm8mIrQVDY6SOrZ43BcimXmBjT67ScyO4HOEunsbiGdbsaE+Lu0zj7
 pGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mKALN1OkcwtQhcysb+FWH3t2vFKNjrdMKVQt2ijO0Po=;
 b=VZ1olrmIsLo48xFVbF44ZEEHx/J+8GZiq5UO01c1zB9QKb4euv0rfFqsu8qV30yRSk
 SLKZzObuUxRZbv7lPmPEKXFiWDJGUAid9At+V5DAYGn8K3q+kmURyD6+g70J1QaHa2cC
 5PGm42z2y/DRX50lUGEFLMIfoZbk9sXgjFPseXFG8b3W14p9B9MHTObjYptVxRBafDcN
 LnvR3lEZ9yYouQVfFt1V9cYcxBEC24h1s6CprxDSWe8cLzC5g7sYXPTJS0OVOHMuCa8x
 RDu5Je7pgbLm2QaX9LCX7w5OetNmTT4OKBoXJ7FT3KuMjjzf7EDhfZ4etN2Z4fBCMqVc
 VfLA==
X-Gm-Message-State: APjAAAXaTvQqLE1tOIl8lWdSelSNFT0Z9e0sSFl6A9K/QEBMMXGUBxuH
 qLuNseDXKywUgYSk9nxjiFcd8KmKB/ppuvxkpRGX/g==
X-Google-Smtp-Source: APXvYqzBloPRnX50VrJGlf0zwqZMx4kE8jlcjkF1A4MmAb/1CmwV6C22Krcs7y2A5uFCH7cqu5h7HYnPPCqLvVBMptw=
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr8335667oti.338.1556926881968; 
 Fri, 03 May 2019 16:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com>
 <20190502110347.GE12416@kroah.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
 <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com>
 <20190503064241.GC20723@kroah.com>
In-Reply-To: <20190503064241.GC20723@kroah.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 3 May 2019 16:41:10 -0700
Message-ID: <CAFd5g44NrKM9WQCF1xW-BWpFNsC05UAS9jt1-S+vNRuBDZVsHQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
To: Greg KH <gregkh@linuxfoundation.org>
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
Cc: Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Iurii Zaikin <yzaikin@google.com>, Jeff Dike <jdike@addtoit.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> On Thu, May 02, 2019 at 11:45:43AM -0700, Brendan Higgins wrote:
> > On Thu, May 2, 2019 at 11:15 AM <Tim.Bird@sony.com> wrote:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Greg KH
> > > >
> > > > On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > > > > From: Iurii Zaikin <yzaikin@google.com>
> > > > >
> > > > > KUnit tests for initialized data behavior of proc_dointvec that is
> > > > > explicitly checked in the code. Includes basic parsing tests including
> > > > > int min/max overflow.
> > > > >
> > > > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > > > ---
> > > > >  kernel/Makefile      |   2 +
> > > > >  kernel/sysctl-test.c | 292
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > > >  lib/Kconfig.debug    |   6 +
> > > > >  3 files changed, 300 insertions(+)
> > > > >  create mode 100644 kernel/sysctl-test.c
> > > > >
> > > > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > > > index 6c57e78817dad..c81a8976b6a4b 100644
> > > > > --- a/kernel/Makefile
> > > > > +++ b/kernel/Makefile
> > > > > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> > > > >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> > > > >  obj-$(CONFIG_RSEQ) += rseq.o
> > > > >
> > > > > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> > > >
> > > > You are going to have to have a "standard" naming scheme for test
> > > > modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> > > > that's fine, we should just be consistant and document it somewhere.
> > > >
> > > > Personally, I'd prefer "test-foo", but that's just me, naming is hard...
> > >
> > > My preference would be "test-foo" as well.  Just my 2 cents.
> >
> > I definitely agree we should be consistent. My personal bias
> > (unsurprisingly) is "foo-test," but this is just because that is the
> > convention I am used to in other projects I have worked on.
> >
> > On an unbiased note, we are currently almost evenly split between the
> > two conventions with *slight* preference for "foo-test": I ran the two
> > following grep commands on v5.1-rc7:
> >
> > grep -Hrn --exclude-dir="build" -e "config [a-zA-Z_0-9]\+_TEST$" | wc -l
> > grep -Hrn --exclude-dir="build" -e "config TEST_[a-zA-Z_0-9]\+" | wc -l
> >
> > "foo-test" has 36 occurrences.
> > "test-foo" has 33 occurrences.
> >
> > The things I am more concerned about is how this would affect file
> > naming. If we have a unit test for foo.c, I think foo_test.c is more
> > consistent with our namespacing conventions. The other thing, is if we
> > already have a Kconfig symbol called FOO_TEST (or TEST_FOO) what
> > should we name the KUnit test in this case? FOO_UNIT_TEST?
> > FOO_KUNIT_TEST, like I did above?
>
> Ok, I can live with "foo-test", as you are right, in a directory listing
> and config option, it makes more sense to add it as a suffix.

Cool, so just for future reference, if we already have a Kconfig
symbol called FOO_TEST (or TEST_FOO) what should we name the KUnit
test in this case? FOO_UNIT_TEST? FOO_KUNIT_TEST, like I did above?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
