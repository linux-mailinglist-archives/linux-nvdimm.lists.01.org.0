Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E119BAE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 12:31:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 96FA7212657B5;
	Fri, 10 May 2019 03:31:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3E56F212657B0
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:31:34 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id x4AAV0X4008117
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 19:31:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x4AAV0X4008117
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1557484261;
 bh=3yJH+cglIjNQq6vK0eeyN++1KXd8VHZRN7FQJbPltS8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=QtaJmXuQJy7hctD/ahVAN5XPHN224n6/gqws6nJ/VotVw6eA+8vTJU3kSagTwyS1q
 DGlLyHog02uWurOxIIxKgcK7nayyO+bQha19Z/412N0ccdltUzKhcnlvU54r3rL2ZF
 /7yd3DaXEV3ThV74ZGgPMcATUIr2d8phlFXtq9OT03ColTy+eKxoiuz5y1uKzLvpMZ
 ALUOCKcCEOwtobtUg0Fk/k9pSf7fatmDB/w+cjz1n7pCZUkVL0J76Ro+TKCQTrlXnb
 Xi83Kavt+o++04Nbfu9iLvu2nvO+HmNfTEUZUgWP/kFkOPfZVl7zyvl75HUdzL9IoH
 xywoa2weFn44A==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id o10so3304209vsp.12
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 03:31:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWZz8pdFiAH+6bfa/QvXI8DxaHGMRjCq6iNbVeIsZnka1cNMeI5
 YNAZSJoaF++ugMEbEaP9V8M1gTc/m/0pFu3S6d8=
X-Google-Smtp-Source: APXvYqxQg+YuYHeAdyD+cmoEqdlV9x3SqXv2NvZ+DbME3bD71rpckfASo32QB3ghErivNtiJLmZIR4uDTrUdlUap+zw=
X-Received: by 2002:a67:f109:: with SMTP id n9mr5064876vsk.181.1557484260150; 
 Fri, 10 May 2019 03:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
 <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
 <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
In-Reply-To: <CAFd5g47BNZ0gRz4SXb37XjyXF_LyNZrSmoqDbzaaCUrTg3O7Yg@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 10 May 2019 19:30:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
Message-ID: <CAK7LNAR3DW5UxtsTNtW6mtQic8cukJwJ18=KitC2HX+jO5eo4g@mail.gmail.com>
Subject: Re: [PATCH v2 06/17] kbuild: enable building KUnit
To: Brendan Higgins <brendanhiggins@google.com>
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
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Frank Rowand <frowand.list@gmail.com>, Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 DTML <devicetree@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Tim Bird <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 7:27 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> > On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Add KUnit to root Kconfig and Makefile allowing it to actually be built.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > You need to make sure
> > to not break git-bisect'abililty.
> >
> >
> > With this commit, I see build error.
> >
> >   CC      kunit/test.o
> > kunit/test.c:11:10: fatal error: os.h: No such file or directory
> >  #include <os.h>
> >           ^~~~~~
> > compilation terminated.
> > make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
> > make: *** [Makefile;1763: kunit/] Error 2
>
> Nice catch! That header shouldn't even be in there.
>
> Sorry about that. I will have it fixed in the next revision.


BTW, I applied whole of this series
to my kernel.org repository.

0day bot started to report issues.
I hope several reports reached you,
and they are useful to fix your code.


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
