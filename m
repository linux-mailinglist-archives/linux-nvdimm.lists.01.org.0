Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9455B56
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 00:36:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 44C48212A36EA;
	Tue, 25 Jun 2019 15:36:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.215.194; helo=mail-pg1-f194.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A23B32129DB92
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:33:15 -0700 (PDT)
Received: by mail-pg1-f194.google.com with SMTP id w10so139901pgj.7
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TnzcHfb/rGR5D/vErJu8w17aFeeUcfwDXLuZxpFdgZc=;
 b=axfhgH1SkFvqMgAlhhROLbajIid9gxbugMQBS2fJFEs/FvAD+oZsM10LATP5DgoPJv
 UOT1SyetRrLKJnTnBe2as7QHQOfErkeyqvuG8xj9YAT5I29w3dVO8jCJ9/blj+6dp3zw
 vJrQuxrZFSQtJ2Hndu2oCbxEaXP98eEhDYuXuhchPtk/xz1RJ7MZeQ9G9xAyzpBjhxzp
 omCN0BrVP+2elHFveIzNC2F3h6gcuIjYKRYUX2bY6yLHExEcmRKwA3E2Mj+N6mKFX3jo
 alQ4rdPSj4t1EikRv/10jCrsW6ef19AXlW1cQFTXDdyeP5prU+bGqkexR6hI6JxTAjOH
 1vcQ==
X-Gm-Message-State: APjAAAV3CDc+Tcv57sYuf5pOCemMhcOLsPtvflK7d84ZvBubJcv10NpL
 IbOYKrUi/rMiP38Ksr982S8=
X-Google-Smtp-Source: APXvYqz8tePzVjq6qydlXc6fHsQtBqVBfz39DV20JLDT6sqkzfdOgtSxbEsBu2vrr4nNjRf5f7IpUg==
X-Received: by 2002:a17:90a:e397:: with SMTP id
 b23mr267009pjz.140.1561501994728; 
 Tue, 25 Jun 2019 15:33:14 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id p67sm23643298pfg.124.2019.06.25.15.33.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 15:33:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id CD044401EB; Tue, 25 Jun 2019 22:33:12 +0000 (UTC)
Date: Tue, 25 Jun 2019 22:33:12 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190625223312.GP19023@42.do-not-panic.com>
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190617082613.109131-2-brendanhiggins@google.com>
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
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
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

On Mon, Jun 17, 2019 at 01:25:56AM -0700, Brendan Higgins wrote:
> +/**
> + * module_test() - used to register a &struct kunit_module with KUnit.
> + * @module: a statically allocated &struct kunit_module.
> + *
> + * Registers @module with the test framework. See &struct kunit_module for more
> + * information.
> + */
> +#define module_test(module) \
> +		static int module_kunit_init##module(void) \
> +		{ \
> +			return kunit_run_tests(&module); \
> +		} \
> +		late_initcall(module_kunit_init##module)

Becuase late_initcall() is used, if these modules are built-in, this
would preclude the ability to test things prior to this part of the
kernel under UML or whatever architecture runs the tests. So, this
limits the scope of testing. Small detail but the scope whould be
documented.

> +static void kunit_print_tap_version(void)
> +{
> +	if (!kunit_has_printed_tap_version) {
> +		kunit_printk_emit(LOGLEVEL_INFO, "TAP version 14\n");

What is this TAP thing? Why should we care what version it is on?
Why are we printing this?

> +		kunit_has_printed_tap_version = true;
> +	}
> +}
> +
> +static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> +{
> +	struct kunit_case *test_case;
> +	size_t len = 0;
> +
> +	for (test_case = test_cases; test_case->run_case; test_case++)

If we make the last test case NULL, we'd just check for test_case here,
and save ourselves an extra few bytes per test module. Any reason why
the last test case cannot be NULL?

> +void kunit_init_test(struct kunit *test, const char *name)
> +{
> +	spin_lock_init(&test->lock);
> +	test->name = name;
> +	test->success = true;
> +}
> +
> +/*
> + * Performs all logic to run a test case.
> + */
> +static void kunit_run_case(struct kunit_module *module,
> +			   struct kunit_case *test_case)
> +{
> +	struct kunit test;
> +	int ret = 0;
> +
> +	kunit_init_test(&test, test_case->name);
> +
> +	if (module->init) {
> +		ret = module->init(&test);

I believe if we used struct kunit_module *kmodule it would be much
clearer who's init this is.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
