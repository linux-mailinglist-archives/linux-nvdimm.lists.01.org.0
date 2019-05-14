Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B761CF24
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 20:36:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B610E21275455;
	Tue, 14 May 2019 11:36:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DA83021275451
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:36:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w22so9043375pgi.6
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kgrCvI66v1eNqCFIEetHipPbY2Pg16O5TtUnu8MLeKU=;
 b=gUDKqjEsr8Qv/Y/RdIi8Q0i7FwdadH/D5if9+lYhE9eNQ7LD2B70LCDjDacGxm/FVd
 7kNk5FVNgjwADCYAgcq7jDXk1GJDmyZ0Kh9Gx1ZgwB42ZvxUY0Ix0Sc6YTHp4jc2OTit
 wIpv9ZoVwEXLXTtC0OYc2rhNj0FLGzUxHwUjYJgkKxJYgKIgxENPIfowWiBpTDqrDXJR
 aV5ZOSNgafVxar7tXD+7n837g3sPSNo8qbLCnklS6BGK4TPE6mpuNgU2xapU2LGoeVW3
 VHuSjX0KcDsjpdugWjGvtUgdMmqQOHw13R3aNbCEwTZebS+H4VHnLozq+d5p3UypFj6x
 1Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kgrCvI66v1eNqCFIEetHipPbY2Pg16O5TtUnu8MLeKU=;
 b=Q8DvA5LtEb5ILo/FOOy6Ud61hGr8RGdjBsyvlK8p5y8+tW+idW/ilokSj69+Dq3sOA
 6bh2OB9MLsotfuDYrD31Zff/F2baqpnMTgnR0uFgm/vbG0upHecbpLFbScV75SZ9Q+VX
 x5nnRFgSfr7QusTdcSPTg2JibCGwRPaRJPIu2Rr3x4vsbOi4v+hj7MQOWqeaBbZ+ceMe
 6kHSZdtlSN7DE6yHbWsLnNIjjhjHHzZeiP04lnYfW3+HcE91lbhIHHsr/P/tVGB8CJJ+
 nJ2NU+vH0cmUdjX99xM0JM+2kBQn4BJHdjrEj1u8obJTI51tZXZIxHYn6jERvs88L1zU
 PI7w==
X-Gm-Message-State: APjAAAV1iXjrbmlPu4XQFkU8f2Cj6a556pBNWrzo4fBBV1+F6XUNDT7O
 6bGOj2hj7+DYSdfGUfSnul1/5bTGS2KWkKuU
X-Google-Smtp-Source: APXvYqxx/zB3rhnaNxCnfVL/D4G9BC9H3ZRHO1zmfqf3pl1LMALbOUIKd0jSHjCRuQTB7Pn9vuxzCg==
X-Received: by 2002:a62:e205:: with SMTP id a5mr4433129pfi.40.1557858985424;
 Tue, 14 May 2019 11:36:25 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id u6sm10940875pfa.1.2019.05.14.11.36.23
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 14 May 2019 11:36:24 -0700 (PDT)
Date: Tue, 14 May 2019 11:36:18 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514183618.GC109557@google.com>
References: <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
 <20190514060433.GA181462@google.com>
 <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Tue, May 14, 2019 at 02:05:05PM +0200, Daniel Vetter wrote:
> On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > > is the context here) can be configured as built in instead of as
> > > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > > running the in-kernel tests before UML attempts to invoke the
> > > > > init process.
> > > >
> > > > Um, Citation needed?
> > > >
> > > > I don't see any evidence for this in the kselftest documentation, nor
> > > > do I see any evidence of this in the kselftest Makefiles.
> > > >
> > > > There exists test modules in the kernel that run before the init
> > > > scripts run --- but that's not strictly speaking part of kselftests,
> > > > and do not have any kind of infrastructure.  As noted, the
> > > > kselftests_harness header file fundamentally assumes that you are
> > > > running test code in userspace.
> > >
> > > Yeah I really like the "no userspace required at all" design of kunit,
> > > while still collecting results in a well-defined way (unless the current
> > > self-test that just run when you load the module, with maybe some
> > > kselftest ad-hoc wrapper around to collect the results).
> > >
> > > What I want to do long-term is to run these kernel unit tests as part of
> > > the build-testing, most likely in gitlab (sooner or later, for drm.git
> >
> > Totally! This is part of the reason I have been insisting on a minimum
> > of UML compatibility for all unit tests. If you can suffiently constrain
> > the environment that is required for tests to run in, it makes it much
> > easier not only for a human to run your tests, but it also makes it a
> > lot easier for an automated service to be able to run your tests.
> >
> > I actually have a prototype presubmit already working on my
> > "stable/non-upstream" branch. You can checkout what presubmit results
> > look like here[1][2].
> 
> ug gerrit :-)

Yeah, yeah, I know, but it is a lot easier for me to get a project set
up here using Gerrit, when we already use that for a lot of other
projects.

Also, Gerrit has gotten a lot better over the last two years or so. Two
years ago, I wouldn't touch it with a ten foot pole. It's not so bad
anymore, at least if you are used to using a web UI to review code.

> > > only ofc). So that people get their pull requests (and patch series, we
> > > have some ideas to tie this into patchwork) automatically tested for this
> >
> > Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> > and he seemed pretty open to collaboration.
> >
> > Before I heard about Snowpatch, I had an intern write a translation
> > layer that made Prow (the presubmit service that I used in the prototype
> > above) work with LKML[4].
> 
> There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
> a different one on freedesktop.org. It's a bit a mess :-/

Oh, I didn't realize that. I found your patchwork instance here[5], but
do you have a place where I can see the changes you have added to
support presubmit?

> > I am not married to either approach, but I think between the two of
> > them, most of the initial legwork has been done to make presubmit on
> > LKML a reality.
> 
> We do have presubmit CI working already with our freedesktop.org
> patchwork. The missing glue is just tying that into gitlab CI somehow
> (since we want to unify build testing more and make it easier for
> contributors to adjust things).

I checked out a couple of your projects on your patchwork instance: AMD
X.Org drivers, DRI devel, and Wayland. I saw the tab you added for
tests, but none of them actually had any test results. Can you point me
at one that does?

Cheers!

[5] https://patchwork.freedesktop.org/

> > > super basic stuff.
> >
> > I am really excited to hear back on what you think!
> >
> > Cheers!
> >
> > [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> > [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> > [3] https://developer.ibm.com/open/projects/snowpatch/
> > [4] https://kunit.googlesource.com/prow-lkml/
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
