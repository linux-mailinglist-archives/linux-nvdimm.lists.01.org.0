Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F158E63A67
	for <lists+linux-nvdimm@lfdr.de>; Tue,  9 Jul 2019 20:01:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 113E3212B0827;
	Tue,  9 Jul 2019 11:01:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 56BB12194EB78
 for <linux-nvdimm@lists.01.org>; Tue,  9 Jul 2019 11:01:48 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u17so9352117pgi.6
 for <linux-nvdimm@lists.01.org>; Tue, 09 Jul 2019 11:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OUg57n/8w7Mlx4FSaThva6QRBMRQrC57aji70HqhlTs=;
 b=u9enlrUFhNo6CpHlrQV/HgMnM2prP/1x9AkLcEyZIZZ95VhPysZXNdVgTxFeHrQSyj
 D854QOHx1OOVg+bK1q0GL9M26yGnhrklGjHFU0YlePfBqyn8fol1vLU/0tJs5NO+XWNV
 6Qg4G47Yz8EAu+oXnFu1Mzex0KXUQSkc3dP89G7ycpwdK6vtjyVs4n/CA1F66BOgluWi
 cGrmqcEgZcaKnQ36vda5DA3xHSSM91ST4LQMohLGersiVfBM4MAAfBua5GuHtjmb28bv
 cNHp7EXFv/Be9TyDKlfByNT+SveMU7rOne9AoLQN+azT38ic+R4kxi1lUa+FZPUqI2ob
 eorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OUg57n/8w7Mlx4FSaThva6QRBMRQrC57aji70HqhlTs=;
 b=mZazhHLZupnHKJQsBjK+KLC3bN8Msz/7lx2NQWSg0sCd2dS6bKX4uGt8iuzq+jBmQW
 VXl7U6hDl8Szrr1pgRye2VhScZiW2LYyBubxyBYS1rvXNmWMvnFNkXuYDtGmiMZO6uD5
 6oWHXcJ2GP71neZT0ki9SMnDJHcX+stj1LKGS3k7fz0P/5ajRQhktixd3Y0g3ryVD9cR
 KQqjAjhYTN8kyCJsf8mhtFqJmlckQ4bZto6lbJffB/nBSVyIxDuEzfYUnWCGGb6M9s7r
 mt1C2TE8fTWd1wEDH7bSTC0xuwNcinIfVe8oOZgauphrZYs8an+Hd0U+TIqJg2oFYuTo
 VIew==
X-Gm-Message-State: APjAAAV8CnwfSu7bqMqxl5iiU8zTGmqAQswzXOtenLn1Z6rxVqiTCPsY
 d1TFe9NQdRHzLZpKDCqYYG49IFX8M/KtsdMkgue5pg==
X-Google-Smtp-Source: APXvYqw4HCjsVl+Amh2Teet2qtkXvGz99b/JiD+OyiCx/6U5M9oVU+FrejKuChE3TPRj4OZE1ZrjIBxXffNmybu5Pvg=
X-Received: by 2002:a63:205f:: with SMTP id r31mr32165059pgm.159.1562695307162; 
 Tue, 09 Jul 2019 11:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com>
 <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
In-Reply-To: <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 9 Jul 2019 11:01:35 -0700
Message-ID: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
Subject: Re: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
To: shuah <shuah@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
>
> On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > framework.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > ---
> >   MAINTAINERS | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 677ef41cb012c..48d04d180a988 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8599,6 +8599,17 @@ S:     Maintained
> >   F:  tools/testing/selftests/
> >   F:  Documentation/dev-tools/kselftest*
> >
> > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > +M:   Brendan Higgins <brendanhiggins@google.com>
> > +L:   linux-kselftest@vger.kernel.org
> > +L:   kunit-dev@googlegroups.com
> > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > +S:   Maintained
> > +F:   Documentation/dev-tools/kunit/
> > +F:   include/kunit/
> > +F:   kunit/
> > +F:   tools/testing/kunit/
> > +
> >   KERNEL USERMODE HELPER
> >   M:  Luis Chamberlain <mcgrof@kernel.org>
> >   L:  linux-kernel@vger.kernel.org
> >
>
> Thanks Brendan.
>
> I am good with this. I can take KUnit patches through kselftest
> with your Ack.

My acknowledgement? Sure! I thought we already agreed to that.

Also, do we need an ack from Masahiro or Michal for the Kbuild patch
[PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
[PATCH v7 08/18]?

Greg and Logan gave me a Reviewed-by for the Kbuild patch, so maybe
that's fine, but I don't have any reviews or acks for the objtool
patch.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
