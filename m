Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF87E4F0
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 23:43:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB2992130309A;
	Thu,  1 Aug 2019 14:46:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C765A21303096
 for <linux-nvdimm@lists.01.org>; Thu,  1 Aug 2019 14:46:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y8so32783415plr.12
 for <linux-nvdimm@lists.01.org>; Thu, 01 Aug 2019 14:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tRJWWqPxe4v7OGh5SzFgwfV47CyOeIABo0H7U+M+pdg=;
 b=S/P5gz+a9jUw7SwOiz84JEbZSB3baAlVLSphUNs8eZlN3ZPowtpH0MpNodRchncDaL
 h/pwktm3ZoMM5ur9uIqRsyskaBqjhXhPvxaJG//b32Uphj0PG1ynA9CUTm1TW0sAsjm6
 HvrHFAepLSyokzes/1ht5wjMSnlrEgSRbO09yXW02SG1IbAd8mAQKhoiLKJYr6VkLWg+
 7rO55CqVAf6utB/oO5cCFpNjfcdHsW2PZ6e5nZCbdexwb5KuZDKGxSTHr3F16NHksaHQ
 xyoTxMhvtaSYfpReQiXJpspTpAAqnNeKDN71dNMH70NnoXLk5zU84jZ89voAQsdAyikW
 53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tRJWWqPxe4v7OGh5SzFgwfV47CyOeIABo0H7U+M+pdg=;
 b=epoRjsOtQZhwU4jL0/JYwqpn+IHWwhzbIrp2qyy3KOW58sf7CfO+a5+pVThaqVlQSp
 nYlmf2tJkUvHil2AJjLSIYrmDHeG4CIrzF+nfPgMpebO9aLeCZLN+kWJDpExDT5k2hDA
 1ymf5PgrsMauLYyuPmLmtgBeqXHNuVLyd40v4c0lpfLHEuT2DMIQz4yBBwp6YceNq+Ho
 /YhHFRTTm+A8Cds1Ns8kC34ZiUjxHLTi25khVHjFyCZyzzMm13oezhRv7OJAIZS7khKA
 7Mhwr5biV3R5oSmd9XMRO9K+xyirI2Hldcn90gFfLeSTDocd1w4lhW+Zym02Ld6Fyxc0
 9Fhw==
X-Gm-Message-State: APjAAAVObkw1tJXXaQ8+R6Gkgw3bMrHwXXVzyN+qwVfqQ1kenTh8K6H3
 5ua8MaAPlFMOsDRh9Ju3ktVQuc0gcxWIqziI49o5YA==
X-Google-Smtp-Source: APXvYqyQJ3oYuIkR4HxnjqcvX8HB7OCTCVhJ4Fku+hNPqOUYjGToK6i2G0j1xWhCd4v39RwFH1V7C/0k5dVHTOnW45I=
X-Received: by 2002:a17:902:347:: with SMTP id
 65mr32846391pld.232.1564695834770; 
 Thu, 01 Aug 2019 14:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190716175021.9CA412173C@mail.kernel.org>
 <20190719000834.GA3228@google.com>
 <20190722200347.261D3218C9@mail.kernel.org>
 <CAFd5g45hdCxEavSxirr0un_uLzo5Z-J4gHRA06qjzcQrTzmjVg@mail.gmail.com>
 <20190722235411.06C1320840@mail.kernel.org>
 <20190724073125.xyzfywctrcvg6fmh@pathway.suse.cz>
 <CAFd5g47v3Mr4GEGOjqyYy9Jwwm+ow7ypbu9j88rxEN06QCzdxQ@mail.gmail.com>
 <20190726083148.d4gf57w2nt5k7t6n@pathway.suse.cz>
 <CAFd5g46iAhDZ5C_chi7oYLVOkwcoj6+0nw+kPWuXhqWwWKd9jA@mail.gmail.com>
 <CAFd5g473iFfvBnJs2pcwuJYgY+DpgD6RLzyDFL1otUuScgKUag@mail.gmail.com>
 <20190801211447.6D3D7206A2@mail.kernel.org>
In-Reply-To: <20190801211447.6D3D7206A2@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Thu, 1 Aug 2019 14:43:42 -0700
Message-ID: <CAFd5g47tk8x5iet=xfPVO6MphD3SsLtYQLrCi5O2h0bvdXwHtA@mail.gmail.com>
Subject: Re: [PATCH v9 04/18] kunit: test: add kunit_stream a std::stream like
 logger
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
Cc: devicetree <devicetree@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 shuah <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Timothy Bird <Tim.Bird@sony.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Kevin Hilman <khilman@baylibre.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
 Julia Lawall <julia.lawall@lip6.fr>, Josh Poimboeuf <jpoimboe@redhat.com>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Aug 1, 2019 at 2:14 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-01 11:59:57)
> > On Thu, Aug 1, 2019 at 11:55 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Fri, Jul 26, 2019 at 1:31 AM Petr Mladek <pmladek@suse.com> wrote:
> > >
> > > > To be honest I do not fully understand KUnit design. I am not
> > > > completely sure how the tested code is isolated from the running
> > > > system. Namely, I do not know if the tested code shares
> > > > the same locks with the system running the test.
> > >
> > > No worries, I don't expect printk to be the hang up in those cases. It
> > > sounds like KUnit has a long way to evolve before printk is going to
> > > be a limitation.
> >
> > So Stephen, what do you think?
> >
> > Do you want me to go forward with the new kunit_assert API wrapping
> > the string_stream as I have it now? Would you prefer to punt this to a
> > later patch? Or would you prefer something else?
> >
>
> I like the struct based approach. If anything, it can be adjusted to
> make the code throw some records into a spinlock later on and delay the
> formatting of the assertion if need be.

That's a fair point.

> Can you resend with that
> approach? I don't think I'll have any more comments after that.

Cool, will do.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
