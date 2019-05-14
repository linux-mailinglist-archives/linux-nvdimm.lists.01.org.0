Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D921C825
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 14:05:22 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AA862125ADCC;
	Tue, 14 May 2019 05:05:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=daniel.vetter@ffwll.ch; receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4FC672124B90F
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 05:05:18 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g16so12783533iom.9
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3cCt7Fv9PrSN+POfdDA9BhvmV9/m6Z9B8cT0V9l7bcU=;
 b=a7BcpiAa3cXS6NukeVFgCH7xf3ARmd8J6e/ULZ0a8xqTBwTNaq+N8QguChZh3uzW7f
 kWHSY7qQUZbeMlUwXYdXunYt1ZQd2SKBDUTXd3jKW+KmrJ1DqqIRVtLYOVb1f+tEQL2N
 W7DqiSEqrT+k9VDAEFt9iTN+c6I6bW1EG18JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3cCt7Fv9PrSN+POfdDA9BhvmV9/m6Z9B8cT0V9l7bcU=;
 b=Q9KdlbhWQW8tTm7Qmu0sBUIV5E4Mg9D2wZLCAl+dH8y6lANYbZfMUSmHsFoEqxQSAV
 lmf9iEVZjbvQL50NQlpSXXEp81EV4gOWm1zyXLvIO4FQdL1e425dUAveKF7V1ovttKgy
 ID29MUholk0Od7pi3Ig0gXK3FDiGwcdKNE7ZQqBoZXD7HxFGMWu35YlzWxa64SMmqjiE
 uoIh7Za2UQq7Eb6RTypthp/SOLHLmojgKLgelSnXZp3UdGQZ/dHTGKW2yStxOQ17hgzI
 kDt82uH7BMdkSVqk6GDuuXtYWDFPbW2WFxgsMFublWcUBinJodzBZZpdwfs8udLtwq3h
 T1Tg==
X-Gm-Message-State: APjAAAVVHxTt8jFvd2cWtpRRSpifsN0PUuOC+o4qWqyxY9FZNJgQUggm
 DbDic8vTic1MzvdZQu72Q05yqcJ13JbsUpsLvM+Yzw==
X-Google-Smtp-Source: APXvYqyhBqCsjjVPPpuo20Er/14b4Noh22uMAdPO6o3WUMvHLuILgjBTMJK3Dh0BqwvOEYcjDaa/KDS4xlT8iYcmIUQ=
X-Received: by 2002:a6b:b654:: with SMTP id g81mr3614153iof.34.1557835518050; 
 Tue, 14 May 2019 05:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
 <20190514060433.GA181462@google.com>
In-Reply-To: <20190514060433.GA181462@google.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 14 May 2019 14:05:05 +0200
Message-ID: <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Brendan Higgins <brendanhiggins@google.com>
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
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Shuah Khan <shuah@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-nvdimm@lists.01.org, Frank Rowand <frowand.list@gmail.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 jdike@addtoit.com, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>, linux-kbuild@vger.kernel.org,
 Tim.Bird@sony.com, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, sboyd@kernel.org,
 Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > is the context here) can be configured as built in instead of as
> > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > running the in-kernel tests before UML attempts to invoke the
> > > > init process.
> > >
> > > Um, Citation needed?
> > >
> > > I don't see any evidence for this in the kselftest documentation, nor
> > > do I see any evidence of this in the kselftest Makefiles.
> > >
> > > There exists test modules in the kernel that run before the init
> > > scripts run --- but that's not strictly speaking part of kselftests,
> > > and do not have any kind of infrastructure.  As noted, the
> > > kselftests_harness header file fundamentally assumes that you are
> > > running test code in userspace.
> >
> > Yeah I really like the "no userspace required at all" design of kunit,
> > while still collecting results in a well-defined way (unless the current
> > self-test that just run when you load the module, with maybe some
> > kselftest ad-hoc wrapper around to collect the results).
> >
> > What I want to do long-term is to run these kernel unit tests as part of
> > the build-testing, most likely in gitlab (sooner or later, for drm.git
>
> Totally! This is part of the reason I have been insisting on a minimum
> of UML compatibility for all unit tests. If you can suffiently constrain
> the environment that is required for tests to run in, it makes it much
> easier not only for a human to run your tests, but it also makes it a
> lot easier for an automated service to be able to run your tests.
>
> I actually have a prototype presubmit already working on my
> "stable/non-upstream" branch. You can checkout what presubmit results
> look like here[1][2].

ug gerrit :-)

> > only ofc). So that people get their pull requests (and patch series, we
> > have some ideas to tie this into patchwork) automatically tested for this
>
> Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> and he seemed pretty open to collaboration.
>
> Before I heard about Snowpatch, I had an intern write a translation
> layer that made Prow (the presubmit service that I used in the prototype
> above) work with LKML[4].

There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
a different one on freedesktop.org. It's a bit a mess :-/

> I am not married to either approach, but I think between the two of
> them, most of the initial legwork has been done to make presubmit on
> LKML a reality.

We do have presubmit CI working already with our freedesktop.org
patchwork. The missing glue is just tying that into gitlab CI somehow
(since we want to unify build testing more and make it easier for
contributors to adjust things).
-Daniel

> > super basic stuff.
>
> I am really excited to hear back on what you think!
>
> Cheers!
>
> [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> [3] https://developer.ibm.com/open/projects/snowpatch/
> [4] https://kunit.googlesource.com/prow-lkml/
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
