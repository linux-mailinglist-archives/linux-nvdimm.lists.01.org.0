Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0360C19
	for <lists+linux-nvdimm@lfdr.de>; Fri,  5 Jul 2019 22:15:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F407E212B2054;
	Fri,  5 Jul 2019 13:15:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.214.196; helo=mail-pl1-f196.google.com;
 envelope-from=mcgrof@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 538CE212B0FD3
 for <linux-nvdimm@lists.01.org>; Fri,  5 Jul 2019 13:15:08 -0700 (PDT)
Received: by mail-pl1-f196.google.com with SMTP id b3so1745278plr.4
 for <linux-nvdimm@lists.01.org>; Fri, 05 Jul 2019 13:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dg5Yvvp7NUrUvKeik0ledTLe2yGcHUO+ZrIPV2huI9Y=;
 b=oDaNRyOink9INpvx5Ss4GvF/0NxsSzm8h5RME4BuF9KRwAPnJdNoiR2YTuLn7MZ3rO
 GwMbQS42x/bMr9ZvTj641Zop4g5xuSV4EMdB8r3Qqi7cvDcPuZpc0L4cDuaWlPlfXNpJ
 Mcrix5LjmKfhufNLgtFNhc0Xf0rAIz3X+CmGtPd36Y00z+z9lm+MLFNtbBwhnKeJmv5u
 8VbDQSrSw/oxUa2qVtUG8gVe0VyZeMAL6yeriFk9kUttzz7l62jMP/meDzDx0ZO2jdzU
 +z4z6vv1fGG7OkgUGOQI4ByRY1YyCpBlK7+j9T/yZjUkBkqt40JGZqvuSdpVFZZFolwz
 mliw==
X-Gm-Message-State: APjAAAXLtCkUUutAr6bV4m8DEmX7Y+sseL8T21F3yxLxv+/XTveUpCNo
 xqmTp6+tJ4d8Yn2qRryBSx8=
X-Google-Smtp-Source: APXvYqzH7c1mrZ0zttAPULzlg8jVTTmmhx/hVeHeJnG9PaMmHS0LdOn+bNDKbdY4NLyOIl1o3kOldA==
X-Received: by 2002:a17:902:2865:: with SMTP id
 e92mr7552625plb.264.1562357707679; 
 Fri, 05 Jul 2019 13:15:07 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id 10sm17424980pfb.30.2019.07.05.13.15.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 05 Jul 2019 13:15:06 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id C552E40190; Fri,  5 Jul 2019 20:15:05 +0000 (UTC)
Date: Fri, 5 Jul 2019 20:15:05 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v6 01/18] kunit: test: add KUnit test runner core
Message-ID: <20190705201505.GA19023@42.do-not-panic.com>
References: <20190704003615.204860-1-brendanhiggins@google.com>
 <20190704003615.204860-2-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190704003615.204860-2-brendanhiggins@google.com>
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

On Wed, Jul 03, 2019 at 05:35:58PM -0700, Brendan Higgins wrote:
> Add core facilities for defining unit tests; this provides a common way
> to define test cases, functions that execute code which is under test
> and determine whether the code under test behaves as expected; this also
> provides a way to group together related test cases in test suites (here
> we call them test_modules).
> 
> Just define test cases and how to execute them for now; setting
> expectations on code will be defined later.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

But a nitpick below, I think that can be fixed later with a follow up
patch.

> +/**
> + * struct kunit - represents a running instance of a test.
> + * @priv: for user to store arbitrary data. Commonly used to pass data created
> + * in the init function (see &struct kunit_suite).
> + *
> + * Used to store information about the current context under which the test is
> + * running. Most of this data is private and should only be accessed indirectly
> + * via public functions; the one exception is @priv which can be used by the
> + * test writer to store arbitrary data.
> + *
> + * A brief note on locking:
> + *
> + * First off, we need to lock because in certain cases a user may want to use an
> + * expectation in a thread other than the thread that the test case is running
> + * in.

This as a prefix to the struct without a lock seems odd. It would be
clearer I think if you'd explain here what locking mechanism we decided
to use and why it suffices today.

> +/**
> + * suite_test() - used to register a &struct kunit_suite with KUnit.

You mean kunit_test_suite()?

> + * @suite: a statically allocated &struct kunit_suite.
> + *
> + * Registers @suite with the test framework. See &struct kunit_suite for more
> + * information.
> + *
> + * NOTE: Currently KUnit tests are all run as late_initcalls; this means that
> + * they cannot test anything where tests must run at a different init phase. One
> + * significant restriction resulting from this is that KUnit cannot reliably
> + * test anything that is initialize in the late_init phase.
                            initialize prior to the late init phase.


That is, this is useless to test things running early.

> + *
> + * TODO(brendanhiggins@google.com): Don't run all KUnit tests as late_initcalls.
> + * I have some future work planned to dispatch all KUnit tests from the same
> + * place, and at the very least to do so after everything else is definitely
> + * initialized.

TODOs are odd to be adding to documentation, this is just not common
place practice. The NOTE should suffice for you.

  Luis
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
