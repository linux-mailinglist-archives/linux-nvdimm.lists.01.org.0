Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A13DBCC
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Jun 2019 22:29:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 504C621962301;
	Tue, 11 Jun 2019 13:29:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5AEB121295B30
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 13:29:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w34so7575021pga.12
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dhnwSrdCPnvzoEVfuuVGqE83p7TnkQ5Modn2BNCoQD0=;
 b=Pp0Hq+hd8QA6syECahlCWtYv82jhOxBm0sr+fZ9Dkk8nXtHe7nrSiSj+V8u0FaITQ7
 84fXuzNXkrhzDQgkHPp26EjnsIzrDKXg48+xvOTrPv1gFdJxgRLOvcs0dwgoU2BGvzqE
 Liz3+gL3rcT7wqBUJosubNY4aHZAru2eeUFG6CtPZ2mbKIzTjquHFKUIQcWXvVk4hMLI
 7UB1amIr3aRGarnBUHse/35CwxBlRRF3qifo7BnhaOJV61RWbVqr0wA4GIowlDaA6gfT
 pWINRb5VwbD/mtNfms9GrZfwha/4G8tSCCTtYnHFhjTrLaOGAdTroClIT1QeFCWuqloy
 NJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dhnwSrdCPnvzoEVfuuVGqE83p7TnkQ5Modn2BNCoQD0=;
 b=j6vHtuEl7AtQMv4qMsgalOxX5QchPTO4AobfmnwDkMobVJlBIQmJ6mP32FsUMzblXc
 SjDSshz5P7IK6yV0Z3LpNZSzlwdkpWZ5xmdCRXapv/C1c/Y9R8AR0d44eSwNyul0L4Xt
 24U4Xv6vtkhaljWDL4yWFDFxvkXlNtZ6nGdwNBz7FQmQoAuPwIZm5XCHt2WuEVIhpWVg
 sAh6Oin9XJct6EcTMb0n/hUfPsD9lnt9TdqcjNHom8ysZKHZfG8kS54oBI3BYjASSFk4
 Fuo989CPTOEuKViWKRw8WOTEMofgNAnzNj974Fe3oW9cPJXt/cl618G+klQkTd89cg7d
 e7Zw==
X-Gm-Message-State: APjAAAXcdmvIyCJibgPb7HlRq635ICVfOYX2/YjfGSEt07rcoWMFaGlt
 041h4KcsVi3RbPrcs4XuwPeb7H7GGw8Hk0bt/JCRyw==
X-Google-Smtp-Source: APXvYqycBtJ32qbIn8pTyxMIAID5Xv7JTruAR7oTyIED4r622bu9rIlLgVdk0eekxjLa2OE4wVYL1Pw8y64Cqw0kRwU=
X-Received: by 2002:a17:90a:2e89:: with SMTP id
 r9mr28553830pjd.117.1560284952085; 
 Tue, 11 Jun 2019 13:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
 <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
 <20190607190047.C3E7A20868@mail.kernel.org>
 <20190611175830.GA236872@google.com>
 <20190611185018.2E1C021744@mail.kernel.org>
In-Reply-To: <20190611185018.2E1C021744@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 11 Jun 2019 13:29:01 -0700
Message-ID: <CAFd5g47dmcHOCX41cr2v9Kaj3xa_5-PoqUPX_1=AoQLUG90NkQ@mail.gmail.com>
Subject: Re: [PATCH v4 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
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
 Iurii Zaikin <yzaikin@google.com>, Jeff Dike <jdike@addtoit.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
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

On Tue, Jun 11, 2019 at 11:50 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-11 10:58:30)
> > On Fri, Jun 07, 2019 at 12:00:47PM -0700, Stephen Boyd wrote:
> > > Quoting Iurii Zaikin (2019-06-05 18:29:42)
> > > > On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > Quoting Brendan Higgins (2019-05-14 15:17:10)
> > > > > > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > > > > > new file mode 100644
> > > > > > index 0000000000000..fe0f2bae66085
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/sysctl-test.c
> > > > > > +
> > > > > > +
> > > > > > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > > > > > +{
> > > > > > +       struct ctl_table table = {
> > > > > > +               .procname = "foo",
> > > > > > +               .data           = &test_data.int_0001,
> > > > > > +               .maxlen         = sizeof(int),
> > > > > > +               .mode           = 0644,
> > > > > > +               .proc_handler   = proc_dointvec,
> > > > > > +               .extra1         = &i_zero,
> > > > > > +               .extra2         = &i_one_hundred,
> > > > > > +       };
> > > > > > +       char input[] = "-9";
> > > > > > +       size_t len = sizeof(input) - 1;
> > > > > > +       loff_t pos = 0;
> > > > > > +
> > > > > > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > > > > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > > > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > > > > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > > > > > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
> > > > >
> > > > > Is the casting necessary? Or can the macro do a type coercion of the
> > > > > second parameter based on the first type?
> > > >  Data field is defined as void* so I believe casting is necessary to
> > > > dereference it as a pointer to an array of ints. I don't think the
> > > > macro should do any type coercion that == operator wouldn't do.
> > > >  I did change the cast to make it more clear that it's a pointer to an
> > > > array of ints being dereferenced.
> > >
> > > Ok, I still wonder if we should make KUNIT_EXPECT_EQ check the types on
> > > both sides and cause a build warning/error if the types aren't the same.
> > > This would be similar to our min/max macros that complain about
> > > mismatched types in the comparisons. Then if a test developer needs to
> > > convert one type or the other they could do so with a
> > > KUNIT_EXPECT_EQ_T() macro that lists the types to coerce both sides to
> > > explicitly.
> >
> > Do you think it would be better to do a phony compare similar to how
> > min/max used to work prior to 4.17, or to use the new __typecheck(...)
> > macro? This might seem like a dumb question (and maybe it is), but Iurii
> > and I thought the former created an error message that was a bit easier
> > to understand, whereas __typecheck is obviously superior in terms of
> > code reuse.
> >
> > This is what we are thinking right now; if you don't have any complaints
> > I will squash it into the relevant commits on the next revision:
>
> Can you provide the difference in error messages and describe that in
> the commit text? The commit message is where you "sell" the patch, so
> being able to compare the tradeoff of having another macro to do type
> comparisons vs. reusing the one that's there in kernel.h would be useful
> to allay concerns that we're duplicating logic for better error
> messages.

Oh sorry, I didn't think too hard about the commit message since I
figured it would get split up and squashed into the existing commits.
I just wanted to get it out sooner to discuss this before I post the
next revision (probably later this week).

> Honestly, I'd prefer we just use the macros that we've developed in
> kernel.h to do comparisons here so that we can get code reuse, but more
> importantly so that we don't trip over problems that caused those macros
> to be created in the first place. If the error message is bad, perhaps
> that can be fixed with some sort of compiler directive to make the error
> message a little more useful, i.e. compiletime_warning() thrown into
> __typecheck() or something.

That's a good point. I have no qualms sticking with __typecheck(...)
for now; if we later feel that it is causing problems, we can always
fix it later by supplying our own warning in the manner you suggest.

Iurii, do you have any additional thoughts on this?

>
> > ---
> > From: Iurii Zaikin <yzaikin@google.com>
> >
> > Adds a warning message when comparing values of different types similar
> > to what min() / max() macros do.
> >
> > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
