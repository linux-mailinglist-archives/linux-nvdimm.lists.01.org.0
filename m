Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE2155C0
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 May 2019 23:43:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4076B21250CB9;
	Mon,  6 May 2019 14:43:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A8D9521250C8A
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 14:43:05 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 143so10790145oii.4
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=94ZZFjAz8L6vodxrYz5ZCQ36NJZDWbAB/OOZ4duFwS4=;
 b=tLixckVpvUKIIP5RUjay0lZW7YNSS3dUAp/uUYFinYYsKHGVICkPCkOYGtF3sbBoWy
 WrEckQ4QP028zfHhbL5kBL+ohEGOP1dDKk+Bp5+VWfMsnb090NYGYzTdl/D4Y4BZg795
 E2qTT59iEGKQL66/nZu7o3rbn+PokHJnlfYdNIP/E2c/XuQzdE7pg9j0bvYzbCuwwxJL
 emPADFPM3ZOiA8e/GRITu0dcg4Os+e17Y3+CUGf4fPlweNagjJdF4OInhRnPReNkri5n
 LWQH1BOxdyyoBD4Yg62n/XVFQ/+F+SIAiTFtipiJC/QAUrtnzp2bJR8vq6aT+hCDGigV
 3HDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=94ZZFjAz8L6vodxrYz5ZCQ36NJZDWbAB/OOZ4duFwS4=;
 b=MsE12r6k1059cbh5kP8lERPWaO0wlywAOUIdOTdwnZ82BN+ORdyBXJ3qAMneZ6OwLU
 2v0r32sJsMO7uhoH0z7K0RMdhuUwXQzkOt22Qt1nSMTy/oxPdqIGs52nhC7HiAG2OOhs
 /m9EW65f9DPX4DeNB6oKMK481gciSZjuSLD51jMXmHEy9+dHCS2BRS3IEZh4h021QVXS
 MIsBxrObbGC6gY1l9HjwN8IYTlYU47vGJcJujRnQ7YvUBqt5DUeezzx7ea4zridqGota
 xVamCFQL2KN7mEyFf77tZrwW6zWoTiZu9xNL2JGQIE9zose8c5EAn9biCB+FeOrtFJ+u
 D7Ew==
X-Gm-Message-State: APjAAAWzrErHHjSE+zSRq2a7qJGgYGtUmaGAjTJ8SvcrmUGVlEv7Yg7K
 gFOA2AkxxCvTZPvo0D00TXlwL+GONwrXWLi/GgkL3Q==
X-Google-Smtp-Source: APXvYqyhYHswKnB+01odEGOhapU2d1ybkbO7OVGv0qMcxCiM57xMXMGlQ7Mu0aMV2CefJNmt9LchrL7CnYaGHRcRbVk=
X-Received: by 2002:aca:d4cf:: with SMTP id l198mr192007oig.137.1557178984528; 
 Mon, 06 May 2019 14:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com>
 <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com>
 <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com>
 <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
 <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
 <63f63c7c-6185-5e64-b338-6a5e7fb9e27c@gmail.com>
 <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
In-Reply-To: <CAGXu5jJpp2HyEWMtAde+VUt=9ni3HRu69NM4rUQJu4kBrnx9Kw@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 6 May 2019 14:42:53 -0700
Message-ID: <CAFd5g47d-e31NecDEbMud0rUH55EbhcS0wJpjB1PZZaX5Udqmw@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To: Kees Cook <keescook@google.com>
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
 Amir Goldstein <amir73il@gmail.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Sasha Levin <Alexander.Levin@microsoft.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Shuah Khan <shuah@kernel.org>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

> On Sun, May 5, 2019 at 5:19 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > You can see the full version 14 document in the submitter's repo:
> >
> >   $ git clone https://github.com/isaacs/testanything.github.io.git
> >   $ cd testanything.github.io
> >   $ git checkout tap14
> >   $ ls tap-version-14-specification.md
> >
> > My understanding is the the version 14 specification is not trying to
> > add new features, but instead capture what is already implemented in
> > the wild.
>
> Oh! I didn't know about the work on TAP 14. I'll go read through this.
>
> > > ## Here is what I propose for this patchset:
> > >
> > >  - Print out test number range at the beginning of each test suite.
> > >  - Print out log lines as soon as they happen as diagnostics.
> > >  - Print out the lines that state whether a test passes or fails as a
> > > ok/not ok line.
> > >
> > > This would be technically conforming with TAP13 and is consistent with
> > > what some kselftests have done.
>
> This is what I fixed kselftest to actually do (it wasn't doing correct
> TAP13), and Shuah is testing the series now:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=ksft-tap-refactor

Oh, cool! I guess this is an okay approach then.

Thanks!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
