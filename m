Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5B57BBC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 08:10:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6D0B821962301;
	Wed, 26 Jun 2019 23:10:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.214.194; helo=mail-pl1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0E0E32129F038
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 23:10:31 -0700 (PDT)
Received: by mail-pl1-f194.google.com with SMTP id a93so679690pla.7
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 23:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZwcXPCGwZbn09o1uwc7hniPSeMrN6eJpmY4d6Wfxi5c=;
 b=l+Wgs6HHe9/BGEIXb1QJmVdtG/9oNcz6CB/26LJxqZzy9ALddUM7uT8fjN45I4aQ9t
 FIT7eI+tC1Nbn3xDeuhi/xbJLRt5GGid8/ONrR8HuQGxrTr5lKP5T87MKBJzTw8OTSR4
 2kDljPEn8EoyouXD2XrUwfRS1BicU3LgOO3sZTuVnfKJo0oQdcBzMEEqDvGWRfbcrRR+
 LiFjDyGVudl1QQ3L7A9Ob+WP4tiOfUQ1EKFgRNj2O2ZWoqQcNKJ8R+ccJV3+/04iLkJv
 pRUD1GV54jQLsGeh52VoZRwKOEZkBqN5AiJ4xgliULJc+0KG+ITP9txJWzJ7e+GTXOMN
 DCpQ==
X-Gm-Message-State: APjAAAVTsM4GeZl5kf82mqjnG34aU9JH+nMoAruiCqO1ElaLxYtTdGqk
 kIATwWGwsw8jAYkA3XlnqCS1KBVivA0=
X-Google-Smtp-Source: APXvYqwfDFSlOkWhmFZzzgQYetrDxzZaKzvd9ZX5n/88iknHRTMqvTXQfyQDDioGRxixBQmy4Bo+mg==
X-Received: by 2002:a17:902:8489:: with SMTP id
 c9mr2593873plo.327.1561615831154; 
 Wed, 26 Jun 2019 23:10:31 -0700 (PDT)
Received: from 42.do-not-panic.com ([157.230.128.187])
 by smtp.gmail.com with ESMTPSA id u21sm1323644pfm.70.2019.06.26.23.10.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 23:10:27 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 7944140256; Thu, 27 Jun 2019 06:10:21 +0000 (UTC)
Date: Thu, 27 Jun 2019 06:10:21 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Iurii Zaikin <yzaikin@google.com>, linux-api@vger.kernel.org,
 "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190627061021.GE19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-18-brendanhiggins@google.com>
 <20190626021744.GU19023@42.do-not-panic.com>
 <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAXuY3p+kVhjQ4LYtzormqVcH2vKu1abc_K9Z0XY=JX=bp8NcQ@mail.gmail.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, peterz@infradead.org,
 amir73il@gmail.com, Brendan Higgins <brendanhiggins@google.com>,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 yamada.masahiro@socionext.com, mpe@ellerman.id.au,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org,
 linux-nvdimm@lists.01.org, frowand.list@gmail.com, knut.omang@oracle.com,
 kieran.bingham@ideasonboard.com, wfg@linux.intel.com, joel@jms.id.au,
 David Rientjes <rientjes@google.com>, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 09:07:43PM -0700, Iurii Zaikin wrote:
> On Tue, Jun 25, 2019 at 7:17 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > +static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = 0,
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     size_t len;
> > > +     loff_t pos;
> > > +
> > > +     len = 1234;
> > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > +     len = 1234;
> > > +     KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, (size_t)0, len);
> > > +}
> >
> > In a way this is also testing for general kernel API changes. This is and the
> > last one were good examples. So this is not just testing functionality
> > here. There is no wrong or write answer if 0 or -EINVAL was returned
> > other than the fact that we have been doing this for years.
> >
> > Its a perhaps small but important difference for some of these tests.  I
> > *do* think its worth clarifying through documentation which ones are
> > testing for API consistency Vs proper correctness.
>
> You make a good point that the test codifies the existing behavior of
> the function in lieu of formal documentation.  However, the test cases
> were derived from examining the source code of the function under test
> and attempting to cover all branches. The assertions were added only
> for the values that appeared to be set deliberately in the
> implementation. And it makes sense to me to test that the code does
> exactly what the implementation author intended.

I'm not arguing against adding them. I'm suggesting that it is different
to test for API than for correctness of intended functionality, and
it would be wise to make it clear which test cases are for API and which
for correctness.

This will come up later for other kunit tests and it would be great
to set precendent so that other kunit tests can follow similar
practices to ensure its clear what is API realted Vs correctness of
intended functionality.

In fact, I'm not yet sure if its possible to test public kernel API to
userspace with kunit, but if it is possible... well, that could make
linux-api folks happy as they could enable us to codify interpreation of
what is expected into kunit test cases, and we'd ensure that the
codified interpretation is not only documented in man pages but also
through formal kunit test cases.

A regression in linux-api then could be formalized through a proper
kunit tests case. And if an API evolves, it would force developers to
update the respective kunit which codifies that contract.

> > > +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = sizeof(int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     char input[32];
> > > +     size_t len = sizeof(input) - 1;
> > > +     loff_t pos = 0;
> > > +     unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> > > +                                          - (INT_MAX + INT_MIN) + 1;
> > > +
> > > +     KUNIT_EXPECT_LT(test,
> > > +                     (size_t)snprintf(input, sizeof(input), "-%lu",
> > > +                                      abs_of_less_than_min),
> > > +                     sizeof(input));
> > > +
> > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > +}
> >
> > API test.
> >
> Not sure why.

Because you are codifying that we *definitely* return -EINVAL on
overlow. Some parts of the kernel return -ERANGE for overflows for
instance.

It would be a generic test for overflow if it would just test
for any error.

It is a fine and good test to keep. All these tests are good to keep.

> I believe there has been a real bug with int overflow in
> proc_dointvec.
> Covering it with test seems like a good idea.

Oh definitely.

> > > +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> > > +{
> > > +     struct ctl_table table = {
> > > +             .procname = "foo",
> > > +             .data           = &test_data.int_0001,
> > > +             .maxlen         = sizeof(int),
> > > +             .mode           = 0644,
> > > +             .proc_handler   = proc_dointvec,
> > > +             .extra1         = &i_zero,
> > > +             .extra2         = &i_one_hundred,
> > > +     };
> > > +     char input[32];
> > > +     size_t len = sizeof(input) - 1;
> > > +     loff_t pos = 0;
> > > +     unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> > > +
> > > +     KUNIT_EXPECT_GT(test, greater_than_max, (unsigned long)INT_MAX);
> > > +     KUNIT_EXPECT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
> > > +                                            greater_than_max),
> > > +                     sizeof(input));
> > > +     table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> > > +     KUNIT_EXPECT_EQ(test, -EINVAL,
> > > +                     proc_dointvec(&table, 1, input, &len, &pos));
> > > +     KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> > > +     KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> > > +}
> > > +
> >
> > API test.
> >
> > > +static struct kunit_case sysctl_test_cases[] = {
> > > +     KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> > > +     KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> > > +     KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> > > +     KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> > > +     KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> > > +     {}
> > > +};
> >
> > Oh all are API tests.. perhaps then just rename then
> > sysctl_test_cases to sysctl_api_test_cases.
> >
> > Would be good to add at least *two* other tests cases for this
> > example, one which does a valid read and one which does a valid write.
> Added valid reads. There already are 2 valid writes.

Thanks.

> > If that is done either we add another kunit test module for correctness
> > or just extend the above and use prefix / postfixes on the functions
> > to distinguish between API / correctness somehow.
> >
> > > +
> > > +static struct kunit_module sysctl_test_module = {
> > > +     .name = "sysctl_test",
> > > +     .test_cases = sysctl_test_cases,
> > > +};
> > > +
> > > +module_test(sysctl_test_module);
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index cbdfae3798965..389b8986f5b77 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -1939,6 +1939,16 @@ config TEST_SYSCTL
> > >
> > >         If unsure, say N.
> > >
> > > +config SYSCTL_KUNIT_TEST
> > > +     bool "KUnit test for sysctl"
> > > +     depends on KUNIT
> > > +     help
> > > +       This builds the proc sysctl unit test, which runs on boot. For more
> > > +       information on KUnit and unit tests in general please refer to the
> > > +       KUnit documentation in Documentation/dev-tools/kunit/.
> >
> > A little more description here would help. It is testing for API and
> > hopefully also correctness (if extended with those two examples I
> > mentioned).
> >
> Added "Tests the API contract and implementation correctness of sysctl."

Yes, much clearer, thanks!

  Luis

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
