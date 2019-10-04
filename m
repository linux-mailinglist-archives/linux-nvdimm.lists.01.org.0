Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7428BCC63A
	for <lists+linux-nvdimm@lfdr.de>; Sat,  5 Oct 2019 01:10:46 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AD9E810FC3257;
	Fri,  4 Oct 2019 16:11:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=brendanhiggins@google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A354910FC3257
	for <linux-nvdimm@lists.01.org>; Fri,  4 Oct 2019 16:11:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f21so3792581plj.10
        for <linux-nvdimm@lists.01.org>; Fri, 04 Oct 2019 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tysgl1R46fdU3OksVKZHpW9zLqbqvPnl2oWqc0PQOqg=;
        b=oPja2LZ+ZjzWwIIgczPMTwtg+FNGcSbm7xxAV/JCINpx/yp1vQ08IQzQiHGs4wRyly
         YbCXc4ZHHHV54r6XkfIGN2kCtHFVjwM+le57/4du+XEYDcy5wbcSN0nM+dJDI0b12LcX
         ZikwBUxxg3PiGd3obfKj/XNiIWOlooyLyOV9DjUwS3qE50KzPo9cDH1z7dSJIljdr/Z7
         tZQByU/xEELr2sdcAOpmxavLs2sFF6O48uaUgeMrxepiwS44UUpA/LYAKV5RslwaYo6g
         n/2r9eiMcS73JaD7vmFn8z6h6xmtSUZ7znleGhm4+7S7T8FLqi/xStUsiRfiN3NRdDY9
         6J6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tysgl1R46fdU3OksVKZHpW9zLqbqvPnl2oWqc0PQOqg=;
        b=N6gIkhnXoatisCWYkCg1KYCMah6k+IFIoI1xsL3n9ckpyZuYL8XeWLwRg9/sn8G1O9
         YrCS+rXHBKCwYSikSPHrvofMgWxqpNevOUyb/CLordfwxt5cWZyUGj0N/R10KjOIJEEq
         Su2G/uAZdSPO4c9Q6+yrN5UNG5Yqf8kGCcRQcr3FJc2Ftaw6L+tRlyPr0D4d+ULaNjDr
         fEjxpHjYwLCNUXCLDjNApsll0ssCb4voQIVhm57z6fteUZx9Ajss47eOxSAX5p7XedL1
         NrafHOgc7xlTjQV6TDWncPJt1iF0lqFkYvrqSWiCS+1XiaYSxd1NH9+ssHe2Fag1gZcU
         GD9Q==
X-Gm-Message-State: APjAAAW2iFbtjVsSOldlv5Cm6NeNguw1AwVpT17FzZfC+AO8iTouqY66
	ArvLfyhWe4AxCxZqjokjoSnleG+l2U4EJr/kVWT/wQ==
X-Google-Smtp-Source: APXvYqy2qn5i4A0WcBwjew4hCMmMwzQqLgVpE7PF0Xq4XlJnxlfT1jMDjTbCtnSFUQdVesOmn5ze08RzDHkU7ftVGYQ=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr18021468plj.325.1570230641399;
 Fri, 04 Oct 2019 16:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20191004213812.GA24644@mit.edu> <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
In-Reply-To: <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Fri, 4 Oct 2019 16:10:30 -0700
Message-ID: <CAFd5g46pzu=Bh5X7-ttfhTP+NYNDCAxN16OCGFxc5ohjTL-v0g@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: shuah <shuah@kernel.org>
Message-ID-Hash: BMZJEGUYIPCXYILAZLTELDW4NMDA7KNI
X-Message-ID-Hash: BMZJEGUYIPCXYILAZLTELDW4NMDA7KNI
X-MailFrom: brendanhiggins@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@micro
 soft.com>, "Bird, Timothy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BMZJEGUYIPCXYILAZLTELDW4NMDA7KNI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 4, 2019 at 3:47 PM shuah <shuah@kernel.org> wrote:
>
> On 10/4/19 4:27 PM, Brendan Higgins wrote:
> > On Fri, Oct 04, 2019 at 03:59:10PM -0600, shuah wrote:
> >> On 10/4/19 3:42 PM, Linus Torvalds wrote:
> >>> On Fri, Oct 4, 2019 at 2:39 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>>>
> >>>> This question is primarily directed at Shuah and Linus....
> >>>>
> >>>> What's the current status of the kunit series now that Brendan has
> >>>> moved it out of the top-level kunit directory as Linus has requested?
> >>>
> >>
> >> The move happened smack in the middle of merge window and landed in
> >> linux-next towards the end of the merge window.
> >>
> >>> We seemed to decide to just wait for 5.5, but there is nothing that
> >>> looks to block that. And I encouraged Shuah to find more kunit cases
> >>> for when it _does_ get merged.
> >>>
> >>
> >> Right. I communicated that to Brendan that we could work on adding more
> >> kunit based tests which would help get more mileage on the kunit.
> >>
> >>> So if the kunit branch is stable, and people want to start using it
> >>> for their unit tests, then I think that would be a good idea, and then
> >>> during the 5.5 merge window we'll not just get the infrastructure,
> >>> we'll get a few more users too and not just examples.
> >
> > I was planning on holding off on accepting more tests/changes until
> > KUnit is in torvalds/master. As much as I would like to go around
> > promoting it, I don't really want to promote too much complexity in a
> > non-upstream branch before getting it upstream because I don't want to
> > risk adding something that might cause it to get rejected again.
> >
> > To be clear, I can understand from your perspective why getting more
> > tests/usage before accepting it is a good thing. The more people that
> > play around with it, the more likely that someone will find an issue
> > with it, and more likely that what is accepted into torvalds/master is
> > of high quality.
> >
> > However, if I encourage arbitrary tests/improvements into my KUnit
> > branch, it further diverges away from torvalds/master, and is more
> > likely that there will be a merge conflict or issue that is not related
> > to the core KUnit changes that will cause the whole thing to be
> > rejected again in v5.5.
> >
>
> The idea is that the new development will happen based on kunit in
> linux-kselftest next. It will work just fine. As we accepts patches,
> they will go on top of kunit that is in linux-next now.

But then wouldn't we want to limit what KUnit changes are going into
linux-kselftest next for v5.5? For example, we probably don't want to
do anymore feature development on it until it is in v5.5, since the
goal is to make it more stable, right?

I am guessing that it will probably be fine, but it still sounds like
we need to establish some ground rules, and play it *very* safe.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
