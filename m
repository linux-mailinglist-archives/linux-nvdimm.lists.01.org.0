Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD2196F3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 05:05:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 70D1021260A79;
	Thu,  9 May 2019 20:05:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=210.131.2.90; helo=conssluserg-05.nifty.com;
 envelope-from=yamada.masahiro@socionext.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C0A8721260A75
 for <linux-nvdimm@lists.01.org>; Thu,  9 May 2019 20:05:04 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x4A34XPp006181
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 12:04:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x4A34XPp006181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1557457474;
 bh=DYJ0GRwyv9LQw+wYut+AKlESUHW5OcD/mZsMQ0v23g4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jupzuktqIfQz0vJS1GaSpRqu2LQlIojIZ6l/TI0jmjH+y1VkJRBs89e7uRAv6B1Ef
 uHXWjQCyh3QM1FLLkbOfmNDmcIDMv3Oq/FlPK1nJiwjkiN5C9tudnBuh0F8evz5qm8
 ZorME1HYwlKxsObBT8LwUNg5l1Fi86fQ7ffUtVkUvXf1TvrufFpYms99rIymu6dL/K
 hIlycbAJXfNN986oEc9iUdGhQ9gZ5CSC7yKV9BeU183dZd8/MJ0EQhq+4AgJe2J6jP
 TyF0SLqvX8D3dQhEIQDaNOjnh/QC3NF0r7D48IC/P5jvWFHuMVUbINwaFq0DbE19/a
 SQYZWBc5p+oIQ==
X-Nifty-SrcIP: [209.85.221.172]
Received: by mail-vk1-f172.google.com with SMTP id t74so1131648vke.2
 for <linux-nvdimm@lists.01.org>; Thu, 09 May 2019 20:04:34 -0700 (PDT)
X-Gm-Message-State: APjAAAU0OXVivyO5Q4Q0VLl8WvE9JcAn4TIRQ3EeWegwu/UuW4MDEsFd
 xwjaHkGDUgDNERSGgUg3nuSUbm0uydiE6jBVzRE=
X-Google-Smtp-Source: APXvYqy2m1+g4N+7CIk2iyVkz9i+viWE9nsO8OqKDhs3ADzAs5NWYmvIdraov4KIA0ibHwe/v+Jg8QmbzOy0PS2UyFc=
X-Received: by 2002:a1f:d585:: with SMTP id m127mr3859437vkg.34.1557457473272; 
 Thu, 09 May 2019 20:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-7-brendanhiggins@google.com>
In-Reply-To: <20190501230126.229218-7-brendanhiggins@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 10 May 2019 12:03:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
Message-ID: <CAK7LNAQ+SRMn8UFjW1dZv_TrL0qjD2v2S=rXgtUpiA-urr1DDA@mail.gmail.com>
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
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, amir73il@gmail.com,
 dri-devel <dri-devel@lists.freedesktop.org>, Alexander.Levin@microsoft.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "Cc: Shuah Khan" <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm@lists.01.org, Frank Rowand <frowand.list@gmail.com>,
 Knut Omang <knut.omang@oracle.com>, kieran.bingham@ideasonboard.com,
 wfg@linux.intel.com, Joel Stanley <joel@jms.id.au>, rientjes@google.com,
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

On Thu, May 2, 2019 at 8:03 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add KUnit to root Kconfig and Makefile allowing it to actually be built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

You need to make sure
to not break git-bisect'abililty.


With this commit, I see build error.

  CC      kunit/test.o
kunit/test.c:11:10: fatal error: os.h: No such file or directory
 #include <os.h>
          ^~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.build;279: kunit/test.o] Error 1
make: *** [Makefile;1763: kunit/] Error 2








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
> index 2b99679148dc7..77368f498d84c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -969,7 +969,7 @@ endif
>  PHONY += prepare0
>
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y         += kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>
>  vmlinux-dirs   := $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>                      $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> --
> 2.21.0.593.g511ec345e18-goog
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
