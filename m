Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4EB1683
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Sep 2019 00:58:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AC03202E6E11;
	Thu, 12 Sep 2019 15:58:29 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=ndesaulniers@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5CDDB202E6E0C
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 15:58:28 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x15so14228482pgg.8
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 15:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QtcuvnqG4r2YqI4zyIzKkMUs7uL0jyuefwghC3YKW8k=;
 b=lQCZxf2wWj/TD7i+zM4x52/vcGK5ifsJjrjavtQIbd5PmjztGeExGDQxomnWHrphOB
 D/b/4Xm2CTnyaPHy4dZUJ3v7HBtU4EwyETt2D2kuo5QIp0uH52f7JYTDWDsLOI/ra7wo
 y2ug9CJE1vVyWHHyERvCW1WG/VwSFT0QTlVjDmHRrNl6zJ84sUCcXEkrKgWQpbt3/vtH
 bap3kGRCKwkycQUg8DMdT2aCQwUuPvJc7KvoQGGxEbD1nusDY2UowCwEy8SjbrSV+l8Y
 38Yy7ebxD1Kjv9rfsY98KICrdYKwehq1d+xx++tGhXaZog4YEDqokAuJ6C+q3tyKeHmw
 V66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QtcuvnqG4r2YqI4zyIzKkMUs7uL0jyuefwghC3YKW8k=;
 b=NB+BfSWXZK1hfeIuCaYp36BSAhLdOmFaokUZG5+rJYnuCg21NhHoplvf2QPSMa+eA6
 cagKpPaLSakm2ZUv/M7YNFm7Q0N2sXo3bpYW8gtSxwOoSJGL79jH3Xb4pGJMfOeSYiFb
 kDPyIDZcB1SMAYWGnFzSYcYGaDTd05qVE+iC60yb3DBEFFR77rAchwf5am5IcUjtlFBU
 VC/5zLZKrQgXdn+yE0Z7prcJ6b5mxoiXxdpGaUIWtRE6Iia7U4SQ16sloDZQr5aNO5LP
 7XSQU5OUBJg1R6WbVqCJZjLaX6hIaAsAbsqaePPa51t5wuLRF4g+DCUnKq/jkFI2ArOP
 wRGA==
X-Gm-Message-State: APjAAAU+q9rcluybFBOwNEMPbunYgcGAnb9r25rsnycLK4WfoQ2v4cOq
 Tb2I4PM1+o85iYWHgW1C+NbkccuPUAwpaCUbIevwGQ==
X-Google-Smtp-Source: APXvYqz6gVZGXvJhjhSW8JaLlu8jIhADm3zroXYMALeDqhcHJ4OAuXRJ56yt3mguafQUipBgMbVaMEZ3Jt2n9yKXuPE=
X-Received: by 2002:a62:5fc1:: with SMTP id t184mr19502919pfb.84.1568329108004; 
 Thu, 12 Sep 2019 15:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
 <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
 <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
 <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
 <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
In-Reply-To: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 12 Sep 2019 15:58:16 -0700
Message-ID: <CAKwvOd=OrAzUb0+c0jkR1OLCcjXh+QnrCHhk39+p3Fv2unBxjQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Sep 12, 2019 at 2:58 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> >
> > Please name the major projects and then point to their
> > .clang-format equivalents.
> >
> > Also note the size/scope/complexity of the major projects.
>
> Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> with the official clang-format, not sure if they enforce it.
>
> Same for Chromium/Chrome, but it looks like they indeed enforce it:
>
>   "A checkout should give you clang-format to automatically format C++
> code. By policy, Clang's formatting of code should always be accepted
> in code reviews."
>
> I would bet other Google projects do so as well (since Chandler
> Carruth has been giving talks about clang-format for 7+ years). Nick?

So Google3 (the internal monorepo that Android, Chromium, ChromiumOS,
Fuchsia are not a part of) is pretty sweet.  You cannot even post code
unless the linter has been run on it (presubmit hook), which for our
~350 millions LoC of C++ is clang-format.  If you bypass local
presubmit hooks, our code review tool ("critique") won't let you
submit code that fails lint presubmit checks.  I suspect the initial
conversion was probably committed by bots.

>
> I hope those are major enough. There is also precedent in other
> languages (e.g. Java, C#, Rust).

Yep! Other people coming to C/C++ from these languages find the
discussion about tabs vs spaces to be highly entertaining!  When you
have an automated code formatter and an agreed upon coding style (and
hopefully enforcement), you save so much time from avoided bikesheds!
Don't like the codebase's coding style?  Then write the code how you
like and just run the formatter when you're done (might not help with
conventions though, maybe that's where checkpatch.pl can shine).
Done! No more wasted time on what color to paint the bikeshed!
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
