Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C816E1221E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 20:45:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0230212449E3;
	Thu,  2 May 2019 11:45:57 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B8ECB21243BDB
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 11:45:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w130so2124604oie.6
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=17OVt5sF62dgswwCTgJsxP7RAt3WsAf5VJ4Ut9AHOnQ=;
 b=P9mmkEctGFviK6NgZSHwMcUWXoaX/YoeIAK9bJMcE3Lx9wj9ioBeHG7azUaTRvfMEz
 TY2RHOx0ThWPnz2RyK/JeVea8tpHo/vQkabwSgIPQaucOPCDrRgdtpJvHIeyfXSXZIdh
 EEpMDUWFYZWhjIh9jDc8FJvMTlSL8vQ8VfgY4koM+if0RzgjLUM+G7N96Iar9oJO2RWW
 y2bZo1FvLirTsbvZcF5UvfSKsfdjWdxyGHNZOdT8DOFyQvGPVysWQaUTlUo3hkMnOD0e
 RSC2W/FJE39vCVMCViynhllAgBlnR6+D6q04cTiRfgx2IG0+4k0zkzJ9Spq984jh3G9l
 lWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=17OVt5sF62dgswwCTgJsxP7RAt3WsAf5VJ4Ut9AHOnQ=;
 b=bd9NtM5UOTwoF0AXnzLCo0wO5GxMMRirBjn98hOiKGy6RA07iyDhcJLOnLFv1qce01
 IeZc7mG4hasjLUm3yuS6kkMLcsnpoNyRxKJUrkJ2/8WfVmpDYvx9kfcwgPb5/yiQYRMy
 thV0eR+PwyiSMVurGgQZDKk7/qhJvihK09n+J7sMTZZ6RdazG8Im6+6ettseqAl5xtZl
 ZLuKXO/h6OLzZ64ZvyjxhnTiaOT9QCo7dB1ZMf8dB3LnEt8+JZ/kp2VLJ40Qrr4H2N1v
 u5kkBcWnCnWKz+S5QhUegYIAVeBu4lBIe9FJ3XsF3OosrG0pDgiCVCwBzVU8mRiqWSwB
 xakQ==
X-Gm-Message-State: APjAAAUfHlkmPHlqnTFtSMJ/xpOQWR94CyXtA6b8VK29OQFJ5a7Bjr2n
 DvJlR+slvMoL/1SlvSUQ+ZK7gbU7CQhkVKI9h3I1pg==
X-Google-Smtp-Source: APXvYqzC6lEhFzCwba9WNGtoNJlN2/sxNxsRqKIHnQJUgSQQ4oc4XCI9kW3OGRwazcEXau+lGinuQZlka+T3d8xNOxI=
X-Received: by 2002:aca:4586:: with SMTP id s128mr3264542oia.148.1556822754511; 
 Thu, 02 May 2019 11:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com>
 <20190502110347.GE12416@kroah.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 2 May 2019 11:45:43 -0700
Message-ID: <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
To: "Bird, Timothy" <Tim.Bird@sony.com>
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
 shuah@kernel.org, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Iurii Zaikin <yzaikin@google.com>, Kevin Hilman <khilman@baylibre.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, May 2, 2019 at 11:15 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Greg KH
> >
> > On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > > From: Iurii Zaikin <yzaikin@google.com>
> > >
> > > KUnit tests for initialized data behavior of proc_dointvec that is
> > > explicitly checked in the code. Includes basic parsing tests including
> > > int min/max overflow.
> > >
> > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  kernel/Makefile      |   2 +
> > >  kernel/sysctl-test.c | 292
> > +++++++++++++++++++++++++++++++++++++++++++
> > >  lib/Kconfig.debug    |   6 +
> > >  3 files changed, 300 insertions(+)
> > >  create mode 100644 kernel/sysctl-test.c
> > >
> > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > index 6c57e78817dad..c81a8976b6a4b 100644
> > > --- a/kernel/Makefile
> > > +++ b/kernel/Makefile
> > > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> > >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> > >  obj-$(CONFIG_RSEQ) += rseq.o
> > >
> > > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> >
> > You are going to have to have a "standard" naming scheme for test
> > modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> > that's fine, we should just be consistant and document it somewhere.
> >
> > Personally, I'd prefer "test-foo", but that's just me, naming is hard...
>
> My preference would be "test-foo" as well.  Just my 2 cents.

I definitely agree we should be consistent. My personal bias
(unsurprisingly) is "foo-test," but this is just because that is the
convention I am used to in other projects I have worked on.

On an unbiased note, we are currently almost evenly split between the
two conventions with *slight* preference for "foo-test": I ran the two
following grep commands on v5.1-rc7:

grep -Hrn --exclude-dir="build" -e "config [a-zA-Z_0-9]\+_TEST$" | wc -l
grep -Hrn --exclude-dir="build" -e "config TEST_[a-zA-Z_0-9]\+" | wc -l

"foo-test" has 36 occurrences.
"test-foo" has 33 occurrences.

The things I am more concerned about is how this would affect file
naming. If we have a unit test for foo.c, I think foo_test.c is more
consistent with our namespacing conventions. The other thing, is if we
already have a Kconfig symbol called FOO_TEST (or TEST_FOO) what
should we name the KUnit test in this case? FOO_UNIT_TEST?
FOO_KUNIT_TEST, like I did above?

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
