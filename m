Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A0836931
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 03:30:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3BA61212909F4;
	Wed,  5 Jun 2019 18:30:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::444; helo=mail-wr1-x444.google.com;
 envelope-from=yzaikin@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 297892128DD56
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 18:30:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p11so611778wre.7
 for <linux-nvdimm@lists.01.org>; Wed, 05 Jun 2019 18:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZpGCO041Tg4SdQTzukwjDvK5uvTmFYR2PFl3r1dL9b8=;
 b=ejvHIsk4euV0ppc0epTzvVzKP6ja3YamlfuEnsYOlwGiRDpcKsu5blj9KswKc1lmHk
 FlHNai9oKCPDuqXa7TJVSlPeiKK3R0r+zHaoc0/vO+KgoYHspMWlx28mglyIxvgpaPHe
 hzizJY3TdPzpNMvRO3GLuNa2Z3bBIyLELT3tU3Ha3njuSlNB+l7YFoEZJGWDICks22rP
 Qed1+wFLqO11s+sVV1ovH/1qQeWozeg+0PR8715Yw5GgkDw0trU7l6zXsnXOhVJDNEMj
 aMz3quLWYhYCfEO9JKtWdOPTQc+vfT1SWWx3gQh089h7Li6omjAeHLZGPGCeWfbJrYgP
 eqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZpGCO041Tg4SdQTzukwjDvK5uvTmFYR2PFl3r1dL9b8=;
 b=ULdc5/58h70iY3tpHZ+Yu1fprhb0FRVTbcQuEQHQZZtIX2ga9vl3N+VaTRAecM1MjK
 WzYUXnxhWknIEFVWS1DWtZhcnCIaUPD5TrFwABKx6VeOeq6zbBErpVFk07Vzv1mO1zXv
 RnW4L3D/nWK+8eTirDvb9B8UnL1YBNal4LKEz4nLyDh7KrQ1CG7d1/rjFcNLhXs6ZDJ1
 JnB+e9GlmW0UPn9SA1fy7FLRbGzfVHEnmovIw3ip4SLOl3RxkTYn9UgaHPotp3e8FxOM
 FzR1ezmu8zPI6bWiSwh1Q4Bh1mRl0p/wFBinXjaUd06z9095zqltm/O8cYeTx2lcF9uG
 kZ0w==
X-Gm-Message-State: APjAAAWEOjV9YL2vu2LOafgMOXCzCQohg6VSmWpm1bx893xYwvVI+H1j
 Vh1UOQhnyKB3w9Udjme/OTQj+51Luk3MfnvPZ11n
X-Google-Smtp-Source: APXvYqwxpKa2J21eVqy9vuAUqWSndFyq+8Hj5f1fxZf/oyQGr75L3YoqW8zROuipuK2Zrr7VCYmxZRrq/mq2BI+GwQw=
X-Received: by 2002:adf:e352:: with SMTP id n18mr4855529wrj.82.1559784619871; 
 Wed, 05 Jun 2019 18:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-18-brendanhiggins@google.com>
 <20190517182254.548EA20815@mail.kernel.org>
In-Reply-To: <20190517182254.548EA20815@mail.kernel.org>
From: Iurii Zaikin <yzaikin@google.com>
Date: Wed, 5 Jun 2019 18:29:42 -0700
Message-ID: <CAAXuY3p4qhKVsSpQ44_kQeGDMfg7OuFLgFyxhcFWS3yf-5A_7g@mail.gmail.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 jpoimboe@redhat.com, kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 17, 2019 at 11:22 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-05-14 15:17:10)
> > diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> > new file mode 100644
> > index 0000000000000..fe0f2bae66085
> > --- /dev/null
> > +++ b/kernel/sysctl-test.c
> > @@ -0,0 +1,293 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * KUnit test of proc sysctl.
> > + */
> > +
> > +#include <kunit/test.h>
> > +#include <linux/printk.h>
>
> Is this include used?
  Deleted.
>
> > +#include <linux/sysctl.h>
> > +#include <linux/uaccess.h>
>
> Is this include used?
Deleted.
>
> > +
> > +
> > +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[] = "-9";
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, pos);
> > +       KUNIT_EXPECT_EQ(test, -9, *(int *)table.data);
>
> Is the casting necessary? Or can the macro do a type coercion of the
> second parameter based on the first type?
 Data field is defined as void* so I believe casting is necessary to
dereference it as a pointer to an array of ints. I don't think the
macro should do any type coercion that == operator wouldn't do.
 I did change the cast to make it more clear that it's a pointer to an
array of ints being dereferenced.
>
> > +}
> > +
> > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[32];
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +       unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > +                                            - (INT_MAX + INT_MIN) + 1;
> > +
> > +       KUNIT_EXPECT_LT(test,
> > +                       snprintf(input, sizeof(input), "-%lu",
> > +                                abs_of_less_than_min),
> > +                       sizeof(input));
> > +
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                       proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> > +}
> > +
> > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > +{
> > +       struct ctl_table table = {
> > +               .procname = "foo",
> > +               .data           = &test_data.int_0001,
> > +               .maxlen         = sizeof(int),
> > +               .mode           = 0644,
> > +               .proc_handler   = proc_dointvec,
> > +               .extra1         = &i_zero,
> > +               .extra2         = &i_one_hundred,
> > +       };
> > +       char input[32];
> > +       size_t len = sizeof(input) - 1;
> > +       loff_t pos = 0;
> > +       unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > +
> > +       KUNIT_EXPECT_GT(test, greater_than_max, INT_MAX);
> > +       KUNIT_EXPECT_LT(test, snprintf(input, sizeof(input), "%lu",
> > +                                      greater_than_max),
> > +                       sizeof(input));
> > +       table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > +       KUNIT_EXPECT_EQ(test, -EINVAL,
> > +                       proc_dointvec(&table, 1, input, &len, &pos));
> > +       KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > +       KUNIT_EXPECT_EQ(test, 0, *(int *)table.data);
> > +}
> > +
> > +static int sysctl_test_init(struct kunit *test)
> > +{
> > +       return 0;
> > +}
> > +
> > +/*
> > + * This is run once after each test case, see the comment on example_test_module
> > + * for more information.
> > + */
> > +static void sysctl_test_exit(struct kunit *test)
> > +{
> > +}
> Can the above two be omitted? If they can be empty sometimes it would be
> nice to avoid the extra symbols and code by letting them be assigned to
> NULL in the kunit_module.
 Deleted.
>
> > +
> > +/*
> > + * Here we make a list of all the test cases we want to add to the test module
> > + * below.
> > + */
> > +static struct kunit_case sysctl_test_cases[] = {
> > +       /*
> > +        * This is a helper to create a test case object from a test case
> > +        * function; its exact function is not important to understand how to
> > +        * use KUnit, just know that this is how you associate test cases with a
> > +        * test module.
> > +        */
> > +       KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > +       KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > +       KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > +       KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > +       KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > +       KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > +       {},
> > +};
> > +
> > +/*
> > + * This defines a suite or grouping of tests.
> > + *
> > + * Test cases are defined as belonging to the suite by adding them to
> > + * `test_cases`.
> > + *
> > + * Often it is desirable to run some function which will set up things which
> > + * will be used by every test; this is accomplished with an `init` function
> > + * which runs before each test case is invoked. Similarly, an `exit` function
> > + * may be specified which runs after every test case and can be used to for
> > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > + *
> > + * module.init(test);
> > + * module.test_case[0](test);
> > + * module.exit(test);
> > + * module.init(test);
> > + * module.test_case[1](test);
> > + * module.exit(test);
> > + * ...;
>
> This comment (and the one above for "this is a helper") looks generic
> and should probably only be in some documentation somewhere and not for
> a sysctl test?
>
Deleted.
> > + */
> > +static struct kunit_module sysctl_test_module = {
> > +       .name = "sysctl_test",
> > +       .init = sysctl_test_init,
> > +       .exit = sysctl_test_exit,
> > +       .test_cases = sysctl_test_cases,
> > +};
> > +
> > +/*
> > + * This registers the above test module telling KUnit that this is a suite of
> > + * tests that need to be run.
> > + */
>
> Same comment about generic comment.
>
Deleted.
> > +module_test(sysctl_test_module);
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index d5a4a4036d2f8..772af4ec70111 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1908,6 +1908,12 @@ config TEST_SYSCTL
> >
> >           If unsure, say N.
> >
> > +config SYSCTL_KUNIT_TEST
> > +       bool "KUnit test for sysctl"
>
> Why not tristate?
>
I don't believe KUnit as a module is currently supported.
> > +       depends on KUNIT
> > +       help
> > +         Enables KUnit sysctl test.
> > +
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
