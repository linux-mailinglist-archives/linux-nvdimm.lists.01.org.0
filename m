Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E6BBAEC
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 20:06:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 41D5321962301;
	Mon, 23 Sep 2019 11:09:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6D529202ECFC2
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 11:09:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f19so6840511plr.3
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nhneKc2j612Q2N+13gaGbKUVRsMhSSxGH7dWRfDGMkM=;
 b=T1+NUcrIy3lmkEWKUYoZizpT4pz7k1bgugAw5x236rFYSY4jiXwwGSkW/t3eTOgxZZ
 BdFUIyPtNrmuOnFW8pMCBh0TOJ0ymwQs3hrr2tpjSwDy/Jn7hGK64HYhWlOR+Pme/Rjs
 q1skpdHUJIQUzoH1STCk8Qg+RNLa+nlemSvf5GuWwDF1JHGzH7MzOgvgGfuUDt1Yjlx+
 jLfCXyd8JabRhAP+sdDZJeube1e/2Pp2+w4UQdEthm0TnALHcGP03fa6VfY8gUFfbf65
 93WWIiL7H75Fl011ZWNdHPF+hL1hlBHne2JyK6E63p3OCh/BSVxvl8asUe8na9vlCXYJ
 Puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nhneKc2j612Q2N+13gaGbKUVRsMhSSxGH7dWRfDGMkM=;
 b=ltQIqxAfkQE9URWobOiolRTRIs3rbWKbcGHbC4lqWlQ+V6MlqLhQBqKATxqTPShFYL
 6YNs4H7o08sUjdPUe689k9qzuljJC5jYUvxDlRXCrH62FnlFhDbR0+f8PgsVVFQinGnF
 B3w7tU+SivVaH2acRAd0fG44Kz+8NT7MsrrLAr9tbcnHxvl5RJyWnzq0galiulgR0Fqz
 EyHV/h5Bu0KBVcJ4WmFvG2TNDYwms4QdMBcLBDCiBi6wBpxNb3d5lN4pPbxlWm1YCWQx
 vjvp2BTHHYFz78Dbz69Bo2zeWz11JsTU7CDMmXQ/6p4j2QLisUrsBMhi3BMJN1askN9S
 OIuA==
X-Gm-Message-State: APjAAAUWLIVdhE98aIr+2EoAehjsSexImWcRm4drSQJ2ciLo8n0HLuvk
 uf3sn69OBoV7Bf/dBEnkuhefNrHwkkE2wAv8Eg/Yyw==
X-Google-Smtp-Source: APXvYqwfsjyOL3n2LFVEPJm/qlWBl4UOe3/cXY8+uFis2YYWhVkjpN1GVmQ/ETS5lMq5TdaURd2f4h4p74UheIpwH8I=
X-Received: by 2002:a17:902:ff0e:: with SMTP id
 f14mr1025347plj.325.1569261990405; 
 Mon, 23 Sep 2019 11:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
 <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
In-Reply-To: <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 23 Sep 2019 11:06:19 -0700
Message-ID: <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To: Randy Dunlap <rdunlap@infradead.org>
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
 Linus Torvalds <torvalds@linux-foundation.org>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/23/19 2:02 AM, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  Documentation/dev-tools/index.rst           |   1 +
> >  Documentation/dev-tools/kunit/api/index.rst |  16 +
> >  Documentation/dev-tools/kunit/api/test.rst  |  11 +
> >  Documentation/dev-tools/kunit/faq.rst       |  62 +++
> >  Documentation/dev-tools/kunit/index.rst     |  79 +++
> >  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
> >  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
> >  7 files changed, 925 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
> >  create mode 100644 Documentation/dev-tools/kunit/faq.rst
> >  create mode 100644 Documentation/dev-tools/kunit/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/start.rst
> >  create mode 100644 Documentation/dev-tools/kunit/usage.rst
>
>
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > new file mode 100644
> > index 000000000000..6dc229e46bb3
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -0,0 +1,180 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Getting Started
> > +===============
> > +
> > +Installing dependencies
> > +=======================
> > +KUnit has the same dependencies as the Linux kernel. As long as you can build
> > +the kernel, you can run KUnit.
> > +
> > +KUnit Wrapper
> > +=============
> > +Included with KUnit is a simple Python wrapper that helps format the output to
> > +easily use and read KUnit output. It handles building and running the kernel, as
> > +well as formatting the output.
> > +
> > +The wrapper can be run with:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py run
> > +
> > +Creating a kunitconfig
> > +======================
> > +The Python script is a thin wrapper around Kbuild as such, it needs to be
>
>                                        around Kbuild. As such,

Thanks for pointing this out.

>
> > +configured with a ``kunitconfig`` file. This file essentially contains the
> > +regular Kernel config, with the specific test targets as well.
> > +
> > +.. code-block:: bash
> > +
> > +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> > +     cd $PATH_TO_LINUX_REPO
> > +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> > +
> > +You may want to add kunitconfig to your local gitignore.
> > +
> > +Verifying KUnit Works
> > +---------------------
> > +
> > +To make sure that everything is set up correctly, simply invoke the Python
> > +wrapper from your kernel repo:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py
> > +
> > +.. note::
> > +   You may want to run ``make mrproper`` first.
>
> I normally use O=builddir when building kernels.
> Does this support using O=builddir ?

Yep, it supports specifying a separate build directory.

> > +
> > +If everything worked correctly, you should see the following:
> > +
> > +.. code-block:: bash
> > +
> > +     Generating .config ...
> > +     Building KUnit Kernel ...
> > +     Starting KUnit Kernel ...
> > +
> > +followed by a list of tests that are run. All of them should be passing.
> > +
> > +.. note::
> > +   Because it is building a lot of sources for the first time, the ``Building
> > +   kunit kernel`` step may take a while.
> > +
> > +Writing your first test
> > +=======================
>
> [snip]
>
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > new file mode 100644
> > index 000000000000..c6e69634e274
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/usage.rst
>
> TBD...

What did you mean by this comment?

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
