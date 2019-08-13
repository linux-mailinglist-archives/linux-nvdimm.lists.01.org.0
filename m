Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456258AC16
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 02:41:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6A5752132996C;
	Mon, 12 Aug 2019 17:43:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EC7172132469C
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 17:43:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y8so6425793plr.12
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 17:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o2YhU7ZI7zRBNkSqHEOZBShLAkxc14NOfVdnGmm5fKU=;
 b=jtHRbV2jvCMOrug1VL8DlniNesFQqe4mwKTZ3VzgssQ3VQs6b5LtUaNMVZsc5CuJDp
 Iw8whkhdXJ7rcwjGwBhO6bOb4R9HDy3aGxnSkB24MJ9hY0F8GUX42o4R2L5RbO1mHvNQ
 fgfZIIuryuM6MsMlE2FCQsFy9Ko0MwXC35YX0zFHFknsYf9vPZZbgUGmBgAsRIvp4Uqd
 60LKpvXh51SGPv9+hzg4POm9qQcvjpOv0jvCdTcXtAwCmnYW+REf4ctA9Xh3nN2C0Pk2
 Dfg6a9VXk1PXwpLh/pQidSNRP79rt83WW1lNCqDZaP/t4ID/ZKf6fmlxyUwdKcQccRx2
 iAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o2YhU7ZI7zRBNkSqHEOZBShLAkxc14NOfVdnGmm5fKU=;
 b=qE3kdk4FNGJ2iNLBePFzDIAsL9TTpfJSricbmuKeAyRJ2iK9BHWYjQOyGi10/zs/Go
 xff6FDQ1SpZ01x5iTtbBtmgrznI5V1JdA7Z11c5gfz/e0wtspGRwwKbG1air0qFlznR2
 DcgSyW4EFITvSEXXFro9DOYsUjUSlateAqgmTucFcg5Xzadvyx5rt0AYZWQ4x9cnm3Ly
 Aji9rpqG/XzGyWnHlUNYKZINdYBjR2GUJioakdZ1HIuHF6S1mUqQLfCuDdJe4AgHcwbT
 xn2SaFP3763QKtFTnhkkUfbVMqFmyt82Pnwr/iWsLOR3QFduSk5fAaYpFk03pdVKgNns
 1M7w==
X-Gm-Message-State: APjAAAU7yypjVS+f+xeQGNYsSYgsV2mN7YcZZ9dlswFVsdoxOSK2ZWGU
 9uIUgVACC5+J0KQPP5Wu+ruIQFbZVxg0rl2Dr3GTXw==
X-Google-Smtp-Source: APXvYqwMN7m1oxhncwRThnueyB+Cpwr7fkWXdNKhV0HMwJO6gvgJeykiY4kuCkE7DaZ3nG+H6w12tIuXT7ijhEgDApc=
X-Received: by 2002:a17:902:5983:: with SMTP id
 p3mr25962931pli.232.1565656877406; 
 Mon, 12 Aug 2019 17:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
 <20190812235940.100842063F@mail.kernel.org>
In-Reply-To: <20190812235940.100842063F@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 12 Aug 2019 17:41:05 -0700
Message-ID: <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
 like string builder
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 16:33:36)
> > On Mon, Aug 12, 2019 at 03:55:19PM -0700, Stephen Boyd wrote:
> > > Quoting Brendan Higgins (2019-08-12 11:24:06)
> > > > +void string_stream_clear(struct string_stream *stream)
> > > > +{
> > > > +       struct string_stream_fragment *frag_container, *frag_container_safe;
> > > > +
> > > > +       spin_lock(&stream->lock);
> > > > +       list_for_each_entry_safe(frag_container,
> > > > +                                frag_container_safe,
> > > > +                                &stream->fragments,
> > > > +                                node) {
> > > > +               list_del(&frag_container->node);
> > >
> > > Shouldn't we free the allocation here? Otherwise, if some test is going
> > > to add, add, clear, add, it's going to leak until the test is over?
> >
> > So basically this means I should add a kunit_kfree and
> > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > devres_destroy) and use kunit_kfree here?
> >
>
> Yes, or drop the API entirely? Does anything need this functionality?

Drop the kunit_resource API? I would strongly prefer not to.
string_stream uses it; the expectation stuff uses it via string
stream; some of the tests in this patchset allocate memory as part of
the test setup that uses it. The intention is that we would provide a
kunit_res_* version of many (hopefully eventually most) common
resources required by tests and it would be used in the same way that
the devm_* stuff is.

Nevertheless, I am fine adding the kunit_resource_destroy, etc. I just
wanted to make sure I understood what you were asking.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
