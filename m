Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5363BCDD1D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Oct 2019 10:20:53 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8FA5110FC575E;
	Mon,  7 Oct 2019 01:23:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=brendanhiggins@google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 592DF10FC575C
	for <linux-nvdimm@lists.01.org>; Mon,  7 Oct 2019 01:23:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c3so5030831plo.2
        for <linux-nvdimm@lists.01.org>; Mon, 07 Oct 2019 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ote0/C1JReGNWp+FkearLP+n5iZPIKVYgqsUmtRTjFs=;
        b=ucHtKJn0UJ/TfFDX+4FXj4mOFaUq1DsFLZGjyuBNxfgLXveZezTTcBAH3AoBOIOBEU
         9Q68fJQlIZMn6KrlKTDzJpjNG8TqWULiaH2rlCAcf0lZ+nNuMEV+zgZrBiY1Dw9yJ+u+
         CnikzZLmoBcE6hsbUbbZy61X/2MSIy8UU9KMfv7H8WYsp7Inq5RegXOks3+X+J8jqMPm
         hKQmH60pRG9T9rirx2yP0hvm85sKqjotn7r05OGpiU9g/AO8TGbcjQmonzZgKOXmk0sp
         Q/OF6iGuie1Fhf7sgCtf3kcTPs1M9fwLUXXUhWuFlWamP+XzN2k7qw0YD2qXx5TZ+Lra
         z5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ote0/C1JReGNWp+FkearLP+n5iZPIKVYgqsUmtRTjFs=;
        b=f1yjo1+vq6rBY66d4/XUFUdFvvzzRGQe3xYZtmG2jPijmbotubq0ZNspbkoH+pcibU
         zjnm66aS4/Fzu6gv6dbFn5DELbyeq8YI9So9Smh0MJVF/wp9jA7uJQ7GG22CHFBG7iID
         OF5yq8V0PnqVF/r0RxRd0KnEIxax4Y+7o00We/4n/CY8lZ8QgIFTmwEO6OKObYvE4Z3I
         6IoLt//+EBCbPYDj3KOvqyu/LXkLh8ie7lIY1iVFZnJ5yUbYMN+ODcoy4r0sjaPuZT8l
         7meq6fMoRl1jmhLS1/8fSiZHchLy1M5zxCx8MFhVRzEoCRJekJACkgOApmIkiOjDO0hM
         k1Aw==
X-Gm-Message-State: APjAAAXz2jglWV/yjKyw1U4QevmHsYftK0X8abQHGC3PVOkSU+LNuF5A
	og02UykI9GNGy446hsEicvIPnbuBDWxJ92ZLJIYWzA==
X-Google-Smtp-Source: APXvYqx8Yk5sgQkWXnFQm4/CGRSWyRMpxzmUgLAHY9vWCZW1JOEviLWEyRGwfm5yzonhZdNlXfXkmD5OjjAPHS+whBM=
X-Received: by 2002:a17:902:8f88:: with SMTP id z8mr28990175plo.232.1570436445413;
 Mon, 07 Oct 2019 01:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org> <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu>
In-Reply-To: <20191006165436.GA29585@mit.edu>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 7 Oct 2019 01:20:34 -0700
Message-ID: <CAFd5g47XogYaO24fHnRR9wyki_r4oQg0qSWo9kOgnXpyTuJAWw@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID-Hash: 2ABHV5QDSTM2256BHEXSY2KVYARYA3GV
X-Message-ID-Hash: 2ABHV5QDSTM2256BHEXSY2KVYARYA3GV
X-MailFrom: brendanhiggins@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: shuah <shuah@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsoft.com>,
  "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2ABHV5QDSTM2256BHEXSY2KVYARYA3GV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 04, 2019 at 06:18:04PM -0700, Brendan Higgins wrote:
> > > Let's talk about current state. Right now kunit is in linux-next and
> > > we want to add a few more tests. We will have to coordinate the effort.
> > > Once kunit get into mainline, then the need for this coordination goes
> > > down.
> >
> > Sure, I was just thinking that getting other people to write the tests
> > would be better. Since not only is it then useful to someone else, it
> > provides the best possible exercise of KUnit.
>
> Well, one thing we *can* do is if (a) if we can create a kselftest
> branch which we know is stable and won't change, and (b) we can get
> assurances that Linus *will* accept that branch during the next merge
> window, those subsystems which want to use kself test can simply pull
> it into their tree.

Yeah, I can't think of any reason that you haven't outlined already
why that might not work, but that seems kind of like circumventing
Linus.

> We've done this before in the file system world, when there has been
> some common set of changes needed to improve, say, Direct I/O, where
> the changes are put into a standalone branch, say, in the xfs tree,
> and those file systems which need it as a building block can pull it
> into their tree, and then add the changes needed to use those changes
> into their file system git tree.  These changes are generally not
> terribly controversial, and we've not had to worry about people want
> to bikeshed the changes.
>
> There is a risk with doing this of course, which is that if the branch
> *is* controversial, or gets bike-shedded for some reason, then Linus
> gets upset and any branches which depended on said branch will get
> rejected at the next merge window.  Which is the requirement for (a)
> and (b) above.  Presumably, the fact that people were unwilling to let
> Kunit land during this merge window might will *because* we think more
> changes might be pending?

My understanding, based on what I have been told, is that we were
simply unlucky with the timing when Linus pulled the branch in the
first week of the 5.4 merge window (Friday), such that once I fixed
the directory naming issue, the updated changes didn't spend enough
time in linux-next. And now with this issue fixed and KUnit back in
linux-next, if nothing interesting happens between now and 5.5, it
will be accepted in the 5.5 merge window. I do not think that anyone
is expecting anymore changes before merging.

Shuah, Linus, is my understanding correct?

> The other thing I suppose I can do is to let the ext4 kunit tests land
> in ext4 tree, but with the necessary #ifdef's around things like
> "#include <kunit/test.h>" so that the build won't blow up w/o kunit
> changes being in the tree that I'm building.  It means I won't be able
> to run the tests without creating a test integration branch and
> merging in kunit by hand, which will super-annoying, of course.  And
> if some of the bike-shedding is in Kunit's interfaces, then that
> becomes problematic as well, since any tests that are in ext4.git tree
> might change if people want to rename Kunit's publically exported
> functions (for example).

Yeah, that seems even worse. I'm sorry to have caused this frustration.

> > Hey Ted, do you know if that ext4 timestamp test can go in through
> > linux-kselftest? It seemed fairly self-contained. Or is that what you
> > were saying wouldn't work for you?
>
> Well, I was hoping that we might start creating more tests beyond just
> the ext4 timestamp tests....

Okay, that's what I thought (and what I hoped) you were saying :-)

I hope we can figure out something that will work for you. Or
otherwise that you won't mind waiting until 5.5.

Sorry
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
