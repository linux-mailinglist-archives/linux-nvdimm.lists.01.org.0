Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 025936431B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 09:50:33 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63A28212B207C;
	Wed, 10 Jul 2019 00:50:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Softfail (domain owner discourages use of this host)
 identity=mailfrom; client-ip=210.131.2.81; helo=conssluserg-02.nifty.com;
 envelope-from=yamada.masahiro@socionext.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 369F221959CB2
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:50:30 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x6A7o7aT007106
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 16:50:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x6A7o7aT007106
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562745008;
 bh=PI9vAU5DZ4pm8uk/LZDalZiWfwOYBnqaRPHYLckDX4g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=w5GILrEzqG9QlS6RZMKoQ+TxsVYj6AbqrRo9R4/qXciHnnGeEtP6k+w63dXtetcj/
 Xn6NAKlf8heOTJuAUmEALG9Whwr46Y8aldwwTqaASxABPKyU4DzeaJFtd8vtz0jU/c
 +jWBilSzUMoEElhEZGQd/JPFPEwiRPRfHYIjk4ajD0wWByqOPvBar9WY7dbCfcDdi4
 Wjod5ApEpPIoKqPqNoJhXo484ulGXFa6J5zsl096hZmZIKS+2TfdDqJrByp/HtDa2D
 lfX401sqMeHtu6CQ0Roycgg7O2PZ7+gKmQLTnMijt+3tvbOQKweRcnve6x1E1IhZhv
 MVmVq54Wkjd4Q==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id 190so888251vsf.9
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 00:50:08 -0700 (PDT)
X-Gm-Message-State: APjAAAW/Q/sYrOMGTdhBFmeBqdCSIf4k/TjDC4q7g78Q8zwfH59ewc/m
 PVBuKkwigSKz0VkssuUvkl7/wYR8uIUV+lDyIIU=
X-Google-Smtp-Source: APXvYqw2lrh+5DK/jJwMNeRrzarB0aSECJBPOWsWFIa2/e5Dx+WrHYOuiqBpjnzOBa000Fw4cKQimfq9Auvs/nIayt0=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr17019011vsd.215.1562745007249; 
 Wed, 10 Jul 2019 00:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190710071508.173491-1-brendanhiggins@google.com>
 <20190710071508.173491-7-brendanhiggins@google.com>
In-Reply-To: <20190710071508.173491-7-brendanhiggins@google.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 10 Jul 2019 16:49:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASywq+RhEisuPbqOjFoBh7WNvMEgy55iacizrgNB-uBfA@mail.gmail.com>
Message-ID: <CAK7LNASywq+RhEisuPbqOjFoBh7WNvMEgy55iacizrgNB-uBfA@mail.gmail.com>
Subject: Re: [PATCH v8 06/18] kbuild: enable building KUnit
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

On Wed, Jul 10, 2019 at 4:16 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> KUnit is a new unit testing framework for the kernel and when used is
> built into the kernel as a part of it. Add KUnit to the root Kconfig and
> Makefile to allow it to be actually built.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please feel free to replace this with:

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Cc: Michal Marek <michal.lkml@markovi.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
