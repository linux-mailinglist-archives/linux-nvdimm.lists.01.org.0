Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2127C96B6B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Aug 2019 23:26:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B31F521962301;
	Tue, 20 Aug 2019 14:28:01 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4AED12020D300
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 14:28:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 196so4137309pfz.8
 for <linux-nvdimm@lists.01.org>; Tue, 20 Aug 2019 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kfF4vdGcFJm/Wf6JQ1wcuplxthXZW1HNbOa1JyPqpZg=;
 b=YezYmx2WChZMi1DRr1XoN8XfZITumH+PgqY3JQdS5w4u2vwKLbtcH66ah2vjoQnnog
 QyUxcFY+vLpiQeDhK9KTH5U7uOLNo0vnuD4a52N1MJjkiOZI294BDWFVvwrEEKdhPBaO
 XVT2+i53gVsOodGBAl0E+xI0gCcD/lVNo3bqvB93NFaE/xG/irV6qGiYAx5Sa0TgkhIz
 Derb91GymDQKbZ5lMgnZKtNSZMjrGXdFpCsjUGQOYWWslojKah3JT/incq30S9xuCblQ
 rssihHZxJUKUKjpEGuvFLm+OHFk0eFFOuKdMDTyPyJe4rypnj3lPr/tiL1vR+LS2dnzq
 EaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kfF4vdGcFJm/Wf6JQ1wcuplxthXZW1HNbOa1JyPqpZg=;
 b=YxkIzV6bM8n7s1EVwrKan5Dqsu33hgZskm2Yco5amj0YvgbQh4zipbHSj4YFzmjFy0
 MIp5VhL8oaVF3n7YHaMpFmJXrRG3kRoaXeHB0a2qud4O/q0W7G6cYzB7W1NMUya8le3B
 ybk5GGl6b2pfkRdyDgulaZKRUj+nJbFauWMuzSzzS42JhkebBMu0eGmCbC4ucgHfeng/
 N7XB6aQyLdNUHZ/9aCeyS8ir4eCGA49+vn1xak4q0osOK1y2sJxmOKLjvi3sf+Dupobh
 qxE7YWHDQM1AEidME0+GboqYNyyGAAebml9bmkiQ4iMbmWFgFN1c0MEuaJ8pFNA4P1qB
 6HZg==
X-Gm-Message-State: APjAAAXi/IQc8wBwltg+AD2wVkh7Ux9SFJ95jiJU6fRjAfKT85TFiQQO
 M3/FxDzHlneAFs5Z06FVjr4qEOJXsiIe/QVPkNahNA==
X-Google-Smtp-Source: APXvYqzLsasEUUNlQqQQsMBDlcH+Tp5YqnFlWE8k2udTHXgEapZH91qiWX0NVeTeH8163H7ZgTGtPG9Wj/vODuCC5PA=
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr32322000pfr.113.1566336403144; 
 Tue, 20 Aug 2019 14:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190814055108.214253-1-brendanhiggins@google.com>
 <5b880f49-0213-1a6e-9c9f-153e6ab91eeb@kernel.org>
 <20190820182450.GA38078@google.com>
 <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
In-Reply-To: <e8eaf28e-75df-c966-809a-2e3631353cc9@kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 20 Aug 2019 14:26:32 -0700
Message-ID: <CAFd5g44JT_KQ+OxjVdG0qMWuaEB0Zq5x=r6tLsqJdncwZ_zbGA@mail.gmail.com>
Subject: Re: [PATCH v13 00/18] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To: shuah <shuah@kernel.org>
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
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, Kevin Hilman <khilman@baylibre.com>,
 Knut Omang <knut.omang@oracle.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 kunit-dev@googlegroups.com, Theodore Ts'o <tytso@mit.edu>,
 Richard Weinberger <richard@nod.at>, Stephen Boyd <sboyd@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Kees Cook <keescook@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Aug 20, 2019 at 12:08 PM shuah <shuah@kernel.org> wrote:
>
> On 8/20/19 12:24 PM, Brendan Higgins wrote:
> > On Tue, Aug 20, 2019 at 11:24:45AM -0600, shuah wrote:
> >> On 8/13/19 11:50 PM, Brendan Higgins wrote:
> >>> ## TL;DR
> >>>
> >>> This revision addresses comments from Stephen and Bjorn Helgaas. Most
> >>> changes are pretty minor stuff that doesn't affect the API in anyway.
> >>> One significant change, however, is that I added support for freeing
> >>> kunit_resource managed resources before the test case is finished via
> >>> kunit_resource_destroy(). Additionally, Bjorn pointed out that I broke
> >>> KUnit on certain configurations (like the default one for x86, whoops).
> >>>
> >>> Based on Stephen's feedback on the previous change, I think we are
> >>> pretty close. I am not expecting any significant changes from here on
> >>> out.
> >>>
> >>
> >> Hi Brendan,
> >>
> >> I found checkpatch errors in one or two patches. Can you fix those and
> >> send v14.
> >
> > Hi Shuah,
> >
> > Are you refering to the following errors?
> >
> > ERROR: Macros with complex values should be enclosed in parentheses
> > #144: FILE: include/kunit/test.h:456:
> > +#define KUNIT_BINARY_CLASS \
> > +       kunit_binary_assert, KUNIT_INIT_BINARY_ASSERT_STRUCT
> >
> > ERROR: Macros with complex values should be enclosed in parentheses
> > #146: FILE: include/kunit/test.h:458:
> > +#define KUNIT_BINARY_PTR_CLASS \
> > +       kunit_binary_ptr_assert, KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT
> >
> > These values should *not* be in parentheses. I am guessing checkpatch is
> > getting confused and thinks that these are complex expressions, when
> > they are not.
> >
> > I ignored the errors since I figured checkpatch was complaining
> > erroneously.
> >
> > I could refactor the code to remove these macros entirely, but I think
> > the code is cleaner with them.
> >
>
> Please do. I am not veru sure what value these macros add.

Alright, I will have something for you later today.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
