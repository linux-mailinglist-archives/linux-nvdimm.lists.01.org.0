Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C241F55E28
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 04:17:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 295062129F0ED;
	Tue, 25 Jun 2019 19:17:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.215.194; helo=mail-pg1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9698321962301
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:17:47 -0700 (PDT)
Received: by mail-pg1-f194.google.com with SMTP id 196so385394pgc.6
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 19:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VyBnghsaV/NWoPY4vBgPjL1xYkrIv4bjQFcVvdkRsg4=;
 b=iQYfZ2JWg8w2vkOkSEyv8JsrpHDOPAyl1//vWC8dgd41Z0NtFpjcvy8NtONIuYgy8P
 XeXRUACxrrhVkA6/u8HCy3vJfL3koqVGW/+mXt7hSiXrIsgotzW/NoGswHbvSVQOaA5f
 66HCjL04vy0QMQrxxzn2FplJOcqWkBhfWT3s1zYziJJsK5LXkBrSoquRdOIYNJkcCHwf
 7GtoiJhSWyMprmKbAPkEHopjHfdYRWPOB8xoGhJ8cbbiUAL253vE/b1Tad2Xg413Ts/G
 RyRP4XT+t+Id8Bgli48GJ+OeCQ3QI/um2sJF8gqR1eznWsMHA/gZwOu9mb67LmeEgbpl
 lFRQ==
X-Gm-Message-State: APjAAAUYbenqIcJo1px9jukyqMJ0oDF6WseqVkaDT5EIIJjXNtaT50N2
 fTPQm+NpyXunT7i2gs4bB54=
X-Google-Smtp-Source: APXvYqyHunsyeeZlXZ5a1sr4JFX2rJDdFE69Xw3ccr49IyydgkNF8rl4e0u5XLJ1Ee5939uhX5GRlw==
X-Received: by 2002:a63:dc11:: with SMTP id s17mr219320pgg.47.1561515466591;
 Tue, 25 Jun 2019 19:17:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id a16sm20045381pfd.68.2019.06.25.19.17.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 19:17:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 7320540336; Wed, 26 Jun 2019 02:17:44 +0000 (UTC)
Date: Wed, 26 Jun 2019 02:17:44 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 17/18] kernel/sysctl-test: Add null pointer test for
 sysctl.c:proc_dointvec()
Message-ID: <20190626021744.GU19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-18-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-18-brendanhiggins@google.com>
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
 amir73il@gmail.com, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, yamada.masahiro@socionext.com,
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, Iurii Zaikin <yzaikin@google.com>,
 jdike@addtoit.com, dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, jpoimboe@redhat.com,
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 01:26:12AM -0700, Brendan Higgins wrote:
> From: Iurii Zaikin <yzaikin@google.com>
> 
> KUnit tests for initialized data behavior of proc_dointvec that is
> explicitly checked in the code. Includes basic parsing tests including
> int min/max overflow.

First, thanks for this work! My review below.
> 
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
> Changes Since Last Revision:
>  - Iurii did some clean up (thanks Iurii!) as suggested by Stephen Boyd.
> ---
>  kernel/Makefile      |   2 +
>  kernel/sysctl-test.c | 242 +++++++++++++++++++++++++++++++++++++++++++
>  lib/Kconfig.debug    |  10 ++
>  3 files changed, 254 insertions(+)
>  create mode 100644 kernel/sysctl-test.c
> 
> diff --git a/kernel/Makefile b/kernel/Makefile
> index a8d923b5481ba..50fd511cd0ee0 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -114,6 +114,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
>  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
>  obj-$(CONFIG_RSEQ) += rseq.o
>  
> +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o

And we have lib/test_sysctl.c of selftests.

I'm fine with this going in as-is to its current place, but if we have
to learn from selftests I'd say we try to stick to a convention so
folks know what framework a test is for, and to ensure folks can
easily tell if its test code or not.

Perhaps simply a directory for kunit tests would suffice alone.

> +
>  obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
>  KASAN_SANITIZE_stackleak.o := n
>  KCOV_INSTRUMENT_stackleak.o := n
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> new file mode 100644
> index 0000000000000..cb61ad3c7db63
> --- /dev/null
> +++ b/kernel/sysctl-test.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test of proc sysctl.
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/sysctl.h>
> +
> +static int i_zero;
> +static int i_one_hundred = 100;
> +
> +struct test_sysctl_data {
> +	int int_0001;
> +	int int_0002;
> +	int int_0003[4];
> +
> +	unsigned int uint_0001;
> +
> +	char string_0001[65];
> +};
> +
> +static struct test_sysctl_data test_data = {
> +	.int_0001 = 60,
> +	.int_0002 = 1,
> +
> +	.int_0003[0] = 0,
> +	.int_0003[1] = 1,
> +	.int_0003[2] = 2,
> +	.int_0003[3] = 3,
> +
> +	.uint_0001 = 314,
> +
> +	.string_0001 = "(none)",
> +};
> +
> +static void sysctl_test_dointvec_null_tbl_data(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	size_t len;
> +	loff_t pos;
> +
> +	len = 1234;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);

It is a bit odd, but it does happen, for a developer to be calling
proc_dointvec() directly, instead typically folks just register a table
and let it do its thing.  That said, someone not too familiar with proc
code would see this and really have no clue exactly what is being
tested.

Even as a maintainer, I had to read the code for proc_dointvec() a bit
to understand that the above is a *read* attempt to the .data field
being allocated. Because its a write, the len set to a bogus does not
matter as we are expecting the proc_dointvec() to update len for us.

If a test fails, it would be good to for anyone to easily grasp what is
being tested. So... a few words documenting each test case would be nice.

> +	len = 1234;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);

And this is a write...

A nice tests given the data on the table allocated is not assigned.

I don't see any other areas in the kernel where we open code a
proc_dointvec() call where the second argument is a digit, it
always is with a variable. As such there would be no need for
us to expose helpers to make it clear if one is a read or write.
But for *this* case, I think it would be useful to add two wrappers
inside this kunit test module which sprinkles the 0 or 1, this way
a reader can easily know what mode is being tested.

kunit_proc_dointvec_read()
kunit_proc_dointvec_write()

Or just use #define KUNIT_PROC_READ 0, #define KUNIT_PROC_WRITE 1.
Whatever makes this code more legible.

> +}
> +
> +static void sysctl_test_dointvec_table_maxlen_unset(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= 0,
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	size_t len;
> +	loff_t pos;
> +
> +	len = 1234;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);
> +	len = 1234;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);
> +}

In a way this is also testing for general kernel API changes. This is and the
last one were good examples. So this is not just testing functionality
here. There is no wrong or write answer if 0 or -EINVAL was returned
other than the fact that we have been doing this for years.

Its a perhaps small but important difference for some of these tests.  I
*do* think its worth clarifying through documentation which ones are
testing for API consistency Vs proper correctness.

> +
> +static void sysctl_test_dointvec_table_len_is_zero(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	size_t len;
> +	loff_t pos;
> +
> +	len = 0;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);
> +}

Likewise an API change test.

> +
> +static void sysctl_test_dointvec_table_read_but_position_set(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	void  *buffer = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	size_t len;
> +	loff_t pos;
> +
> +	len = 1234;
> +	pos = 1;
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 0, buffer, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, (size_t)0, len);
> +}

Likewise an API test.

All the above kunit test cases are currently testing this call on
__do_proc_dointvec():

        if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write))
	{
		*lenp = 0;
		return 0;
	}

Just an API test.

Perhaps use an api prefix or postfix for these to help distinguish
which are api tests Vs correctness. We want someone who runs into
a failure to *easily* determine *what* went wrong.

Right now this kunit test leaves no leashes around to help the reader.

> +
> +static void sysctl_test_dointvec_happy_single_positive(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	char input[] = "9";
> +	size_t len = sizeof(input) - 1;
> +	loff_t pos = 0;
> +
> +	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
> +	KUNIT_EXPECT_EQ(test, 9, ((int *)table.data)[0]);
> +}

Yeap, running these kunit test cases will surely be faster than stupid
shell :) nice!

> +static void sysctl_test_dointvec_happy_single_negative(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	char input[] = "-9";
> +	size_t len = sizeof(input) - 1;
> +	loff_t pos = 0;
> +
> +	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	KUNIT_EXPECT_EQ(test, 0, proc_dointvec(&table, 1, input, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, (size_t)pos);
> +	KUNIT_EXPECT_EQ(test, -9, ((int *)table.data)[0]);
> +}
> +
> +static void sysctl_test_dointvec_single_less_int_min(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	char input[32];
> +	size_t len = sizeof(input) - 1;
> +	loff_t pos = 0;
> +	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
> +					     - (INT_MAX + INT_MIN) + 1;
> +
> +	KUNIT_EXPECT_LT(test,
> +			(size_t)snprintf(input, sizeof(input), "-%lu",
> +					 abs_of_less_than_min),
> +			sizeof(input));
> +
> +	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	KUNIT_EXPECT_EQ(test, -EINVAL,
> +			proc_dointvec(&table, 1, input, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +	KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> +}

API test.

> +static void sysctl_test_dointvec_single_greater_int_max(struct kunit *test)
> +{
> +	struct ctl_table table = {
> +		.procname = "foo",
> +		.data		= &test_data.int_0001,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= &i_zero,
> +		.extra2         = &i_one_hundred,
> +	};
> +	char input[32];
> +	size_t len = sizeof(input) - 1;
> +	loff_t pos = 0;
> +	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
> +
> +	KUNIT_EXPECT_GT(test, greater_than_max, (unsigned long)INT_MAX);
> +	KUNIT_EXPECT_LT(test, (size_t)snprintf(input, sizeof(input), "%lu",
> +					       greater_than_max),
> +			sizeof(input));
> +	table.data = kunit_kzalloc(test, sizeof(int), GFP_USER);
> +	KUNIT_EXPECT_EQ(test, -EINVAL,
> +			proc_dointvec(&table, 1, input, &len, &pos));
> +	KUNIT_EXPECT_EQ(test, sizeof(input) - 1, len);
> +	KUNIT_EXPECT_EQ(test, 0, ((int *)table.data)[0]);
> +}
> +

API test.

> +static struct kunit_case sysctl_test_cases[] = {
> +	KUNIT_CASE(sysctl_test_dointvec_null_tbl_data),
> +	KUNIT_CASE(sysctl_test_dointvec_table_maxlen_unset),
> +	KUNIT_CASE(sysctl_test_dointvec_table_len_is_zero),
> +	KUNIT_CASE(sysctl_test_dointvec_table_read_but_position_set),
> +	KUNIT_CASE(sysctl_test_dointvec_happy_single_positive),
> +	KUNIT_CASE(sysctl_test_dointvec_happy_single_negative),
> +	KUNIT_CASE(sysctl_test_dointvec_single_less_int_min),
> +	KUNIT_CASE(sysctl_test_dointvec_single_greater_int_max),
> +	{}
> +};

Oh all are API tests.. perhaps then just rename then
sysctl_test_cases to sysctl_api_test_cases.

Would be good to add at least *two* other tests cases for this
example, one which does a valid read and one which does a valid write.

If that is done either we add another kunit test module for correctness
or just extend the above and use prefix / postfixes on the functions
to distinguish between API / correctness somehow.

> +
> +static struct kunit_module sysctl_test_module = {
> +	.name = "sysctl_test",
> +	.test_cases = sysctl_test_cases,
> +};
> +
> +module_test(sysctl_test_module);
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cbdfae3798965..389b8986f5b77 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1939,6 +1939,16 @@ config TEST_SYSCTL
>  
>  	  If unsure, say N.
>  
> +config SYSCTL_KUNIT_TEST
> +	bool "KUnit test for sysctl"
> +	depends on KUNIT
> +	help
> +	  This builds the proc sysctl unit test, which runs on boot. For more
> +	  information on KUnit and unit tests in general please refer to the
> +	  KUnit documentation in Documentation/dev-tools/kunit/.

A little more description here would help. It is testing for API and
hopefully also correctness (if extended with those two examples I
mentioned).

> +
> +	  If unsure, say N.
> +
>  config TEST_UDELAY
>  	tristate "udelay test driver"
>  	help
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

Thanks for the work, it is very much appreciated and gives a clearer
appreciation of value of kunit and what can be done and not. Another
random test idea that comes up, would be to use different memory types
for the table data. In case the kernel API users does something odd,
we should be ensuring we do something proper.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
