Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A767CC6B7
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Oct 2019 01:52:22 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1D6D10FC3271;
	Fri,  4 Oct 2019 16:53:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=brendanhiggins@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 55A6810FC326F
	for <linux-nvdimm@lists.01.org>; Fri,  4 Oct 2019 16:53:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q10so4859599pfl.0
        for <linux-nvdimm@lists.01.org>; Fri, 04 Oct 2019 16:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wcHN5cpuf6HpMyzE/JY4AhaHdZhoO4XBzATDbA0jQMo=;
        b=p7+dFuiZsziG+/e4IFX0rnW9SeflAmpaFKbEye7G4M1ebE6V8LeScytbqmMKERZtR5
         QjRbiuO/aToN8Or4WR9FYXEhSUYMDU1KJIn32SoOozMI77zF8vOjIzvvJABxh84RZR4C
         LlqSCR6sGDe79xZesgkxmXJeuJitrXFE1GdKXTKr6FLzSDlwKRRjm9ro2En4XOPnrsrV
         xLsx/eNVyd83B5NslZmLyCoW4U/8f74vR2BiTHdskJQYP0m+HIjZr9Gl8VnrLSnaKHoe
         M710bTEav+D5XHd2wKySIJSZ3eNrQ+KbhUxPLsZfRYOkqO1iB3sLZMsPtKh3vaYk8nMz
         tTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wcHN5cpuf6HpMyzE/JY4AhaHdZhoO4XBzATDbA0jQMo=;
        b=UFUgUEojMTEau1e1iT9HwpDOLU0IzMfWCmqU0VEnaEE8t0PoGQ0uRqz3mrJaIty0y0
         0MBKn5e1UfguchLbIRozTX6AAF4vvxmpJDdXS9i2//leyOP+u5VVh1HFsh+VkZwzJlO5
         sO+icLQz7zRkh7oXJc9Ixq45efCv4itCE3dv1UC0pDfEdFckTX0ts1VZHtSPkCK5aMey
         GwYaQPSTdtILxAsUu+EqNYHffnYnHg9T7EaxeVa/yGFz+KWQnTi2grDBmxi9co1+lDOa
         lCsMxLOKLnhbKLK8NH+z11F/HNrl+Kr7ybc4VcOerETMqukPAGB5Y9fBn2dXefhislaC
         7erA==
X-Gm-Message-State: APjAAAW5mZDFEwfkZKrRSQ1JLV3SG1BynMltV6UJV11t4nlro717tTGQ
	gwlBcXiL4NxO+J0AYHRYQaOtRZUVM2wkD48yAv0nGQ==
X-Google-Smtp-Source: APXvYqzN4VO3fXIRGyWeog6vTVGJnv5zTfx/ZRo8Xl3+1qWVt0nnbDwusWqIpAgUbEoU+x2bu2ZOdOWkMBCWH4UJxNQ=
X-Received: by 2002:a63:ba47:: with SMTP id l7mr17842240pgu.201.1570233137464;
 Fri, 04 Oct 2019 16:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
In-Reply-To: <20191004232955.GC12012@mit.edu>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 4 Oct 2019 16:52:06 -0700
Message-ID: <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID-Hash: WKFXTZHBDL6Q2APAVZHZJPCHKQFJZWWT
X-Message-ID-Hash: WKFXTZHBDL6Q2APAVZHZJPCHKQFJZWWT
X-MailFrom: brendanhiggins@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: shuah <shuah@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsoft.com>,
  "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WKFXTZHBDL6Q2APAVZHZJPCHKQFJZWWT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 4, 2019 at 4:30 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 04, 2019 at 04:47:09PM -0600, shuah wrote:
> > > However, if I encourage arbitrary tests/improvements into my KUnit
> > > branch, it further diverges away from torvalds/master, and is more
> > > likely that there will be a merge conflict or issue that is not related
> > > to the core KUnit changes that will cause the whole thing to be
> > > rejected again in v5.5.
> >
> > The idea is that the new development will happen based on kunit in
> > linux-kselftest next. It will work just fine. As we accepts patches,
> > they will go on top of kunit that is in linux-next now.
>
> I don't see how this would work.  If I add unit tests to ext4, they
> would be in fs/ext4.  And to the extent that I need to add test mocks
> to allow the unit tests to work, they will involve changes to existing
> files in fs/ext4.  I can't put them in the ext4.git tree without
> pulling in the kunit changes into the ext4 git tree.  And if they ext4
> unit tests land in the kunit tree, it would be a receipe for large
> numbers of merge conflicts.

That's where I was originally coming from.

So here's a dumb idea: what if we merged KUnit through the ext4 tree?
I imagine that could potentially get very confusing when we go back to
sending changes in through the kselftest tree, but at least it means
that ext4 can use it in the meantime, which means that it at least
gets to be useful to one group of people. Also, since Ted seems pretty
keen on using this, I imagine it is much more likely to produce real
world, immediately useful tests not written by me (I'm not being lazy,
I just think it is better to get other people's experiences other than
my own).

Thoughts?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
