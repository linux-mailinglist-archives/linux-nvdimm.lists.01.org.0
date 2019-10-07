Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C6CDD78
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Oct 2019 10:41:11 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF3EA10FC584E;
	Mon,  7 Oct 2019 01:43:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com; envelope-from=brendanhiggins@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 25F4C10FC584C
	for <linux-nvdimm@lists.01.org>; Mon,  7 Oct 2019 01:43:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q7so8168536pfh.8
        for <linux-nvdimm@lists.01.org>; Mon, 07 Oct 2019 01:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d00h7IdnG9Bs/4S91y4kH9nayVR/gCRtlft74BTzy6I=;
        b=AUmIkwxCvC2VEhvpzdAyuNovVm2KMJDpgDWO5MBAsHUd4584+mQuTJYZeAiA+9d8qf
         Cb8CstcWhfdXgmKTT8Jlla+OWOrkQkY1Q6jQNfjMg0AaTBOEx4pAXKvHC9GWvBLdZn5f
         azsN30/RzedzrQSkqzovoBINho5ERfih75S8sqKoNuhZtu7ZJ6mBbxw52wj46VIAfs+0
         /MI6tTyO9gi1ONrL9pd+19m5cKkMzvosoY+gvlO9IBXyVRyQi1ybU6t67GV8aiwd0d0e
         6C9JtrHHYWmRkyPJoTmdFUFF6AQSVURI2bOhzr9RF9ZKtLjjyBGodHKo0R5D8MzKfjXZ
         yRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d00h7IdnG9Bs/4S91y4kH9nayVR/gCRtlft74BTzy6I=;
        b=qh4rR89PmgBifIyef1vOuFGP6UsX3kKsuiijyhICqWx7sSERk0SHBcxIwmwD/0Zo0W
         whD1Off8gbV+iwksmoEbkaBHuBRlVhAd8Tz7/WzpGi3UCBdsE5UAybpvv/G3I/i5Q5fP
         yj0vykmP2tpxKUrRseMYmO8/ispVUdn+LIcH3wO5COnMzEuF6tkPZi/lBvDB79mBn9tF
         n6ft8S/4prJlopVHODjVzOinT0aBMbgQWW4aWHvolGQJFCVTGjM+OuCv6V3RLeont9fQ
         YHvlZ1dI/ecBO9lRsBOuMebbBS37VUiN5LtP0DejGmd/M2fTTKTkqfuaLstsa0XtwjGQ
         r00Q==
X-Gm-Message-State: APjAAAXSp+RXDXzsESkE5HjZjzJd1UIMvWrAavqLf9A2vsXCfTrwN1nP
	xI78ubD4INHlFmY8ra26SBVD7tQrG0dscVapMN1t9g==
X-Google-Smtp-Source: APXvYqwxXGxNWrOtyc6pCGXMSd6S1trXysWwf0BjsGf8IFVQEjIqe/b6qXijaBYnb2AJQF5sarq/ZPYHb1uY+bE9OzQ=
X-Received: by 2002:a17:90a:5d09:: with SMTP id s9mr32723780pji.131.1570437665358;
 Mon, 07 Oct 2019 01:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whX-JbpM2Sc85epng_GAgGGzxRAJ2SSKkMf9N1Lsqe+OA@mail.gmail.com>
 <56e2e1a7-f8fe-765b-8452-1710b41895bf@kernel.org> <20191004222714.GA107737@google.com>
 <ad800337-1ae2-49d2-e715-aa1974e28a10@kernel.org> <20191004232955.GC12012@mit.edu>
 <CAFd5g456rBSp177EkYAwsF+KZ0rxJa90mzUpW2M3R7tWbMAh9Q@mail.gmail.com>
 <63e59b0b-b51e-01f4-6359-a134a1f903fd@kernel.org> <CAFd5g47wji3T9RFmqBwt+jPY0tb83y46oj_ttOq=rTX_N1Ggyg@mail.gmail.com>
 <544bdfcb-fb35-5008-ec94-8d404a08fd14@kernel.org> <CAFd5g467PkfELixpU0JbaepEAAD_ugAA340-uORngC-eXsQQ-g@mail.gmail.com>
 <20191006165436.GA29585@mit.edu> <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
In-Reply-To: <CAHk-=wjcJxypxUOSF-jc=SQKT1CrOoTMyT7soYzbvK3965JmCA@mail.gmail.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 7 Oct 2019 01:40:53 -0700
Message-ID: <CAFd5g45djTX+FaXwn2abve1+6GbtNrv+8EJgDe_TXn1d+pzukA@mail.gmail.com>
Subject: Re: [PATCH v18 00/19] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID-Hash: VXBKHQJDCMKTHZUFKOGI6MBO2VLVN6F4
X-Message-ID-Hash: VXBKHQJDCMKTHZUFKOGI6MBO2VLVN6F4
X-MailFrom: brendanhiggins@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Theodore Y. Ts'o" <tytso@mit.edu>, shuah <shuah@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@google.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, devicetree <devicetree@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, kunit-dev@googlegroups.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-um@lists.infradead.org, Sasha Levin <Alexander.Levin@microsoft.com>, "Bird, Timo
 thy" <Tim.Bird@sony.com>, Amir Goldstein <amir73il@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>, Julia Lawall <julia.lawall@lip6.fr>, Kevin Hilman <khilman@baylibre.com>, Knut Omang <knut.omang@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Petr Mladek <pmladek@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, David Rientjes <rientjes@google.com>, Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VXBKHQJDCMKTHZUFKOGI6MBO2VLVN6F4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Oct 6, 2019 at 10:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Oct 6, 2019 at 9:55 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > Well, one thing we *can* do is if (a) if we can create a kselftest
> > branch which we know is stable and won't change, and (b) we can get
> > assurances that Linus *will* accept that branch during the next merge
> > window, those subsystems which want to use kself test can simply pull
> > it into their tree.
>
> Yes.
>
> At the same time, I don't think it needs to be even that fancy. Even
> if it's not a stable branch that gets shared between different
> developers, it would be good to just have people do a "let's try this"
> throw-away branch to use the kunit functionality and verify that
> "yeah, this is fairly convenient for ext4".
>
> It doesn't have to be merged in that form, but just confirmation that
> the infrastructure is helpful before it gets merged would be good.

I thought we already had done this satisfactorily.

We have one proof-of-concept test in the branch in the kselftest repo
(proc sysctl test) that went out in the pull request, and we also had
some other tests that were not in the pull request (there is the ext4
timestamp stuff mentioned above, and we also had one against the list
data structure), which we were planning on sending out for review once
Shuah's pull request was accepted. I know the apparmor people also
wrote some tests that they said were useful; however, I have not
coordinated with them on upstreaming their tests. I know of some other
people who are using it, but I don't think the tests are as far along
for upstreaming.

The point is: I thought we had plenty of signal that KUnit would be
useful to have merged into the mainline kernel. I thought the only
reason it was rejected for 5.4 was due to the directory name issue
combined with bad timing.

Please correct me if I missed anything.

Thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
