Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1F8AE58
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 07:02:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8C53B21314740;
	Mon, 12 Aug 2019 22:04:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ACBEC212E845A
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 22:04:22 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A49C206C2;
 Tue, 13 Aug 2019 05:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565672526;
 bh=VlB5crXiwSSXpj9OJzMKtvlRZYtABRaxOaHE9tvmNvQ=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=CWjDW5KmpM1E7Bx+UYTB4tyPDejc2fEUptE5IcAkuGvU7mUfDgTAAhTueY0gTM5ZJ
 Lf7aINsUW0IO9cUIA9NGU6yHEm7BhE7QOER+LlRbYnrOJlgvwyaBWpzcuKPKNq9Pqu
 6jAUm8V4d6UWvUCRS3+itnRHBDP2BfyVmt1mXiAY=
MIME-Version: 1.0
In-Reply-To: <20190813003352.GA235915@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
 <20190812235701.533E82063F@mail.kernel.org>
 <20190813003352.GA235915@google.com>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
User-Agent: alot/0.8.1
Date: Mon, 12 Aug 2019 22:02:05 -0700
Message-Id: <20190813050206.2A49C206C2@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-08-12 17:33:52)
> On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> > Quoting Brendan Higgins (2019-08-12 11:24:08)
> > > + */
> > > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> > 
> > A lot of these macros seem double indented.
> 
> In a case you pointed out in the preceding patch, I was just keeping the
> arguments column aligned.
> 
> In this case I am just indenting two tabs for a line continuation. I
> thought I found other instances in the kernel that did this early on
> (and that's also what the Linux kernel vim plugin wanted me to do).
> After a couple of spot checks, it seems like one tab for this kind of
> line continuation seems more common. I personally don't feel strongly
> about any particular version. I just want to know now what the correct
> indentation is for macros before I go through and change them all.
> 
> I think there are three cases:
> 
> #define macro0(param0, param1) \
>                 a_really_long_macro(...)
> 
> In this first case, I use two tabs for the first indent, I think you are
> telling me this should be one tab.

Yes. Should be one.

> 
> #define macro1(param0, param1) {                                               \
>         statement_in_a_block0;                                                 \
>         statement_in_a_block1;                                                 \
>         ...                                                                    \
> }
> 
> In this case, every line is in a block and is indented as it would be in
> a function body. I think you are okay with this, and now that I am
> thinking about it, what I think you are proposing for macro0 will make
> these two cases more consistent.
> 
> #define macro2(param0,                                                         \
>                param1,                                                         \
>                param2,                                                         \
>                param3,                                                         \
>                ...,                                                            \
>                paramn) ...                                                     \
> 
> In this last case, the body would be indented as in macro0, or macro1,
> but the parameters passed into the macro are column aligned, consistent
> with one of the acceptable ways of formatting function parameters that
> don't fit on a single line.
> 
> In all cases, I put 1 space in between the closing parameter paren and
> the line continuation `\`, if only one `\` is needed. Otherwise, I align
> all the `\s` to the 80th column. Is this okay, or would you prefer that
> I align them all to the 80th column, or something else?
> 

This all sounds fine and I'm not nitpicking this style. Just the double
tabs making lines longer than required.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
