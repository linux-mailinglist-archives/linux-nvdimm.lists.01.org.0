Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0636363FC1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 06:00:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8A789212B5EE6;
	Tue,  9 Jul 2019 21:00:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=210.131.2.91; helo=conssluserg-06.nifty.com;
 envelope-from=yamada.masahiro@socionext.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E6C42212ABA4B
 for <linux-nvdimm@lists.01.org>; Tue,  9 Jul 2019 21:00:47 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x6A407JS008917
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 13:00:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x6A407JS008917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562731208;
 bh=KknRHaSkhBMpTs1BmzD59wJGTvSH88jZgscNwiE3MlQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Zcv8Y/m8P8X292YdVCGzvjt8eh3zKthkL/tKU8hgl0+kZFK/TCidt2YnUJeXwRY2C
 53gnnvfR1V5a/tZ3oft3dU87Wv/na0I6Cs7CUbLYQQ/tTgfsks7h1YrnLQlPvFedYE
 CUXVrkPfqD5VgYstJJ7CydXBopsxsIxYrwFsxgwx6d60uk5NaU0HmmUFrWcRa0Ma+X
 JP4vrMHlCl+oWvWoNYTtWzS8BRJaI99Vvewq8PDOryzMVp2NXYrBOU+OgPSCXtaQVR
 iBpoKf4mR5G2BIwMVbOsyg7IXjsTJdhgiZepcEUeuFghjpTnMBJ19Lf/0+rRb7AENC
 me1vWrlscZvww==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id 190so586476vsf.9
 for <linux-nvdimm@lists.01.org>; Tue, 09 Jul 2019 21:00:08 -0700 (PDT)
X-Gm-Message-State: APjAAAVE3QqdpMWlngL5vooZtvNbTSxnHZZB0jwgCs+dMSZMXn+cBaB6
 xsn+WFv4XEDZUNlJU1x6P9TV0qOMHEUwWY6sPCc=
X-Google-Smtp-Source: APXvYqzEJesQV2n3K1HZLU8Wx1IHWCC1QIw58D6BP7vlVU/X0PRT9+zSoni+Ubl8ut/dwkZUzYEjYnFrduUZ0sj9y38=
X-Received: by 2002:a67:f495:: with SMTP id o21mr16708917vsn.54.1562731207027; 
 Tue, 09 Jul 2019 21:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-7-brendanhiggins@google.com>
In-Reply-To: <20190709063023.251446-7-brendanhiggins@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 10 Jul 2019 12:59:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
Message-ID: <CAK7LNATx30AhZ51xozde=nO06-8UzuC0M9nfZXrqkyfmEFdu5w@mail.gmail.com>
Subject: Re: [PATCH v7 06/18] kbuild: enable building KUnit
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
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
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
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Michal Marek <michal.lkml@markovi.net>, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 9, 2019 at 3:34 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  Kconfig  | 2 ++
>  Makefile | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Kconfig b/Kconfig
> index 48a80beab6853..10428501edb78 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -30,3 +30,5 @@ source "crypto/Kconfig"
>  source "lib/Kconfig"
>
>  source "lib/Kconfig.debug"
> +
> +source "kunit/Kconfig"
> diff --git a/Makefile b/Makefile
> index 3e4868a6498b2..60cf4f0813e0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -991,7 +991,7 @@ endif
>  PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> --
> 2.22.0.410.gd8fdbe21b5-goog


This is so trivial, and do not need to get ack from me.

Just a nit.


When CONFIG_KUNIT is disable, is there any point in descending into kunit/ ?

core-$(CONFIG_KUNIT) += kunit/

... might be useful to skip kunit/ entirely.

If you look at the top-level Makefile, some entries are doing this:


init-y          := init/
drivers-y       := drivers/ sound/
drivers-$(CONFIG_SAMPLES) += samples/
drivers-$(CONFIG_KERNEL_HEADER_TEST) += include/
net-y           := net/
libs-y          := lib/
core-y          := usr/





--
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
