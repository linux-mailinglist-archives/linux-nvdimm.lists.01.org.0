Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A88B34E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 11:04:59 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ACC3721329990;
	Tue, 13 Aug 2019 02:07:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 080B121329974
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 02:07:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m12so10402347plt.5
 for <linux-nvdimm@lists.01.org>; Tue, 13 Aug 2019 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QiUXy9T56EDLZHgM/ghmiZZKu3jldBkP3AywgOf7WrE=;
 b=MLD0OBKrmLSIMOt648B9mPAmsjWuHn6T9ywV6kHk53m2QAcx/5//33wzzGap97ISgd
 1n1dPQTH2aqoshjF311lPPF9RyircKfegESJ2xxxn2TBZss5XJTQKDNllI8Lep9L/7SF
 MM7idIRhDooM4kA4MSv9ueRH5hrjDJGGg0AgX0HqE87hvGQZOuRQRmqZQqIXAW5zi2XY
 qx3rKtyNkDR1tJcjwneeXBeG+UkkSb8i3ocoTOXfuDYPqL5L4LUf+dq11gIkuMFV1by4
 yd/+IqmaOAJsJPYvSatGT0S67lif/DCk+kAwLjTl1ZQp1oSabKWPVnDpLlDJM1jY/AYp
 VtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QiUXy9T56EDLZHgM/ghmiZZKu3jldBkP3AywgOf7WrE=;
 b=ImFuvvBPQQhBrD8fT1sBfjbIe3vfWF1Hfb9Iy2rJhWqZKPbwW7zJkgxnQjq19vMrid
 C9HQlkjt4VqUiFiGcql+oDogMHOp9Ad4IfOcI0waJT6k8UByWxr+38g5WnHLlxGurGls
 qM5pjXhOUybdVg7fXgVMMHBpy9hvW7uImRUtZQHNgEcKphB8XOOi4qEwpW4g/8nhIsUU
 MYWDMFDFP21A9T1hnUNjUdC+h2sJi+XKTN/Za92Ln3iA6h7CFUUDwR/8aQg2Ruxim4CG
 89kUQzF72nVz/8HOQFzdn6JgdVI300tDn8CIQgz3JjycrAUE76R+ztnVAIp7eUYktXLt
 mR7g==
X-Gm-Message-State: APjAAAUK8UTESF8BeG5tKt4GVEaQ5ms+sBJLWFRo38PFFli3hq5afrLR
 /Ismz2biYVordV8bqpP1Sr2YMZsirXzbM4MfBB89SQ==
X-Google-Smtp-Source: APXvYqwG2gN8zpP7bhFAP1u+fXAsfwR8jNJUVHpIzT9G6iZ0jAKs6Cy6kBh6Os478yKmPUZiHWGohGqW0T9u2YI3MZY=
X-Received: by 2002:a17:902:1024:: with SMTP id
 b33mr27760446pla.325.1565687095973; 
 Tue, 13 Aug 2019 02:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com>
 <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com>
 <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
 <20190813045623.F3D9520842@mail.kernel.org>
 <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
 <20190813053023.CC86120651@mail.kernel.org>
In-Reply-To: <20190813053023.CC86120651@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 13 Aug 2019 02:04:44 -0700
Message-ID: <CAFd5g47v7410QRAizPV8zaHrKrc95-Sk-GNzRRVngN741OKnvg@mail.gmail.com>
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

On Mon, Aug 12, 2019 at 10:30 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 22:02:59)
> > On Mon, Aug 12, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-08-12 17:41:05)
> > > > On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > > > > > devres_destroy) and use kunit_kfree here?
> > > > > >
> > > > >
> > > > > Yes, or drop the API entirely? Does anything need this functionality?
> > > >
> > > > Drop the kunit_resource API? I would strongly prefer not to.
> > >
> > > No. I mean this API, string_stream_clear(). Does anything use it?
> >
> > Oh, right. No.
> >
> > However, now that I added the kunit_resource_destroy, I thought it
> > might be good to free the string_stream after I use it in each call to
> > kunit_assert->format(...) in which case I will be using this logic.
> >
> > So I think the right thing to do is to expose string_stream_destroy so
> > kunit_do_assert can clean up when it's done, and then demote
> > string_stream_clear to static. Sound good?
>
> Ok, sure. I don't really see how clearing it explicitly when the
> assertion prints vs. never allocating it to begin with is really any
> different. Maybe I've missed something though.

It's for the case that we *do* print something out. Once we are doing
printing, we don't want the fragments anymore.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
