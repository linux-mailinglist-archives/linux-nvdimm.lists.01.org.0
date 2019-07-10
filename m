Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90A64D87
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 22:27:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EB46C212B6D70;
	Wed, 10 Jul 2019 13:30:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6C5CF212B6D6C
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 13:30:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r1so1600909pfq.12
 for <linux-nvdimm@lists.01.org>; Wed, 10 Jul 2019 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
 b=DXE2TyoaAsiT9dgVdMLJlwnFOJG+VPwltPNRpKt3x1FLvKASU/iQDS/su9pWcI6ZPd
 MXkkWpKWuusX2P8emSJdJDlt30oE5SxYRezHyYxpjjVp3ZbcLi8A3iWXovzH83yYRc8k
 fjxQns6K5/tsiMazqiGGWLPX8o1RPbeCk84rZYGhBrbKZfsdxcSVvoPDO0y7puTr2iGH
 fQNI4xvqDUtOGBpEZRrc5xNRkpC2AFKD+tShr+e3Bwk8ghWvxHexXjknk4e4/Fuddr4K
 h5eIBtrjZWB7rbYTWe1Z8/fz44NvT2DlWtjdcUYum8NYmtJkqcBIajW2gxCHzFBMqhlz
 2q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
 b=hL4b746GkoZsaTSoDKSyhTz59lQQkm33eS7VYhvXbFbmOM+OBtWnLp53Oon4GYTq3p
 QHcuwZZGGGWZs2bMgkZG6XpcYdwSn6jt67pkdlH9CGnxy+YLURCv/U4Telx76DCXF6BD
 HlSZQjFpJZBe+MzSOTAPvRMN2FgRNB+TSSTg3Y05LOSsoH9OxBHLAqp6i7ZWQ/KQYdfo
 Bvsiw4cpf/t+u+McVOdfBAUDxOYzxYCY8QAQdKLaF4JIMPVLfDX6kFt6LMafvrrpxvb2
 nezcumvPXkWIWuD2pUIbOOWh1EGpVLPlLwBE1Z4EQ8N0JmejEH6rWzvc2Vs7Ko6ANLLQ
 DjkA==
X-Gm-Message-State: APjAAAWpd484ueYvaUtUTrVA5vlFjzOfCowVda0He02h4/FJuDpl4O4n
 vBrjQADXljbqPOZ1JxpJufzFpqebOcz0irPHetbCVA==
X-Google-Smtp-Source: APXvYqzZdlWhCkBvFW8XUuT2KDhsG6TgutjUsDP74lsWb4XjESrHCjQll9Q/yu+3XrTs4ARL+yM6pPyLsGbtB4DuWT0=
X-Received: by 2002:a63:205f:: with SMTP id r31mr109331pgm.159.1562790473396; 
 Wed, 10 Jul 2019 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com>
 <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
 <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
In-Reply-To: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 10 Jul 2019 13:27:42 -0700
Message-ID: <CAFd5g45zFhBN-yrJbRt6KnFkYKxVqjs9qeQULCSD6z89vvG-Tg@mail.gmail.com>
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

On Tue, Jul 9, 2019 at 11:01 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
> >
> > On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > > framework.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > ---
> > >   MAINTAINERS | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 677ef41cb012c..48d04d180a988 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8599,6 +8599,17 @@ S:     Maintained
> > >   F:  tools/testing/selftests/
> > >   F:  Documentation/dev-tools/kselftest*
> > >
> > > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > > +M:   Brendan Higgins <brendanhiggins@google.com>
> > > +L:   linux-kselftest@vger.kernel.org
> > > +L:   kunit-dev@googlegroups.com
> > > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > > +S:   Maintained
> > > +F:   Documentation/dev-tools/kunit/
> > > +F:   include/kunit/
> > > +F:   kunit/
> > > +F:   tools/testing/kunit/
> > > +
> > >   KERNEL USERMODE HELPER
> > >   M:  Luis Chamberlain <mcgrof@kernel.org>
> > >   L:  linux-kernel@vger.kernel.org
> > >
> >
> > Thanks Brendan.
> >
> > I am good with this. I can take KUnit patches through kselftest
> > with your Ack.
>
> My acknowledgement? Sure! I thought we already agreed to that.
>
> Also, do we need an ack from Masahiro or Michal for the Kbuild patch
> [PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
> [PATCH v7 08/18]?

By the way, I am guessing you have already seen it, but I uploaded a
new version to incorporate a suggestion made by Masahiro on patch
06/18. In addition, I have gotten acks on the two patches mentioned
above. So I think we are good to go.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
