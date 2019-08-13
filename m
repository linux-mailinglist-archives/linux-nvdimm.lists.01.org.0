Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 007928ABF9
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 02:34:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D490B21329966;
	Mon, 12 Aug 2019 17:36:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7141121324684
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 17:36:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l21so50311620pgm.3
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 17:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Zq6yHL2C60RwcDmlpshxa1wOQkUxi3yYyWuvX6Jr4HM=;
 b=namSPmDWPujc9+lfquW9m9ZpboLlU1GpXC90hrm7My2wALTeQGovCGeuZeoLPKDSjJ
 DPnzh7Y+F6ZapREAMTLVxQZrviv1eRlvHMlffAnktNPvtsaYfgv/HuEgBsY2QrOo0MZs
 nE5JrVUKP9CgWZePaSr61slKkLrb+gpW5RLUbSyHEZcmQpKomsq1IAcpf8aQcFR1ZzcC
 pbhJzddvNnULPjOfPycV2nj/vsXw3HM0ePAOrnoYPxMcKCNqqjXJyNERbNaXrHH4I6Qe
 8XEuxJNNe0v8zBXjNRU7Pd1TCUbPC3LGaWGg1bvuBHstTQGPVL0WQxCYeaoFZfNh0X+l
 HFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Zq6yHL2C60RwcDmlpshxa1wOQkUxi3yYyWuvX6Jr4HM=;
 b=nlQAX/06dECPIC/iEplFJSW5E6q2jC7NRgUK8Zv5bFoK/HmYHt5fb56axnR1otcwU4
 7Ix27btpN/s5C6HsdRGPVxrFq+cN4/EDPpr8W8uOvJUXO3/eG7f4xjlpenme4/HonocK
 PjCRkPlLaastRXt18K8velzjwxNpEnL/7pziduAHQYTLv/OIGqRhvytvoGxk9RVkcK9a
 eKYtogq/zVEWScpmNchGFnP1uzdg74n4A59B3QxJKGnRRlkFPKk4T4TVNIftjGwRIuLL
 y9KJAFIYT2hMxLNmH5H5BSSVqUnNftvNpSJcOQ6Q/0otnmQjYUHQD55qDk9r2ZEiax+K
 pyMA==
X-Gm-Message-State: APjAAAXtr1T472XJleuYU4r2FDKX3bYhi0Y0iaH1vLnZpOweyeawBQ+F
 16F3GtRp0uavrAP5K+/wcCQoQg==
X-Google-Smtp-Source: APXvYqzfHrFqfVRu0MgZ/V5gvwVgMJn7qSDV7sNF8V3DEvMYQp7KqAKffNLgf1l1YpJPVE1awdWI2Q==
X-Received: by 2002:a63:5402:: with SMTP id i2mr32378986pgb.414.1565656437536; 
 Mon, 12 Aug 2019 17:33:57 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
 by smtp.gmail.com with ESMTPSA id 97sm661739pjz.12.2019.08.12.17.33.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 17:33:56 -0700 (PDT)
Date: Mon, 12 Aug 2019 17:33:52 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v12 05/18] kunit: test: add the concept of expectations
Message-ID: <20190813003352.GA235915@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-6-brendanhiggins@google.com>
 <20190812235701.533E82063F@mail.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190812235701.533E82063F@mail.kernel.org>
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
 kunit-dev@googlegroups.com, tytso@mit.edu, richard@nod.at,
 gregkh@linuxfoundation.org, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, mcgrof@kernel.org, daniel@ffwll.ch,
 keescook@google.com, linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Aug 12, 2019 at 04:57:00PM -0700, Stephen Boyd wrote:
> Quoting Brendan Higgins (2019-08-12 11:24:08)
> > Add support for expectations, which allow properties to be specified and
> > then verified in tests.
> > 
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> Just some minor nits again.
> 
> > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > index d0bf112910caf..2625bcfeb19ac 100644
> > --- a/include/kunit/test.h
> > +++ b/include/kunit/test.h
> > @@ -9,8 +9,10 @@
> >  #ifndef _KUNIT_TEST_H
> >  #define _KUNIT_TEST_H
> >  
> > +#include <linux/kernel.h>
> >  #include <linux/types.h>
> >  #include <linux/slab.h>
> > +#include <kunit/assert.h>
> 
> Can you alphabet sort these?

Sure. Will fix.

> >  
> >  struct kunit_resource;
> >  
> > @@ -319,4 +321,845 @@ void __printf(3, 4) kunit_printk(const char *level,
> >  #define kunit_err(test, fmt, ...) \
> >                 kunit_printk(KERN_ERR, test, fmt, ##__VA_ARGS__)
> >  
> > +/*
> > + * Generates a compile-time warning in case of comparing incompatible types.
> > + */
> > +#define __kunit_typecheck(lhs, rhs) \
> > +       ((void) __typecheck(lhs, rhs))
> 
> Is there a reason why this can't be inlined and the __kunit_typecheck()
> macro can't be removed?

No real reason anymore. I used it in multiple places before and we
weren't sure if we wanted to stick with the warnings that __typecheck
produces long term, but now that it is only used in one place, I guess
that doesn't make sense anymore. Will fix.

> > +
> > +/**
> > + * KUNIT_SUCCEED() - A no-op expectation. Only exists for code clarity.
> > + * @test: The test context object.
> [...]
> > + * @condition: an arbitrary boolean expression. The test fails when this does
> > + * not evaluate to true.
> > + *
> > + * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
> > + * to fail when the specified condition is not met; however, it will not prevent
> > + * the test case from continuing to run; this is otherwise known as an
> > + * *expectation failure*.
> > + */
> > +#define KUNIT_EXPECT_TRUE(test, condition) \
> > +               KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
> 
> A lot of these macros seem double indented.

In a case you pointed out in the preceding patch, I was just keeping the
arguments column aligned.

In this case I am just indenting two tabs for a line continuation. I
thought I found other instances in the kernel that did this early on
(and that's also what the Linux kernel vim plugin wanted me to do).
After a couple of spot checks, it seems like one tab for this kind of
line continuation seems more common. I personally don't feel strongly
about any particular version. I just want to know now what the correct
indentation is for macros before I go through and change them all.

I think there are three cases:

#define macro0(param0, param1) \
		a_really_long_macro(...)

In this first case, I use two tabs for the first indent, I think you are
telling me this should be one tab.

#define macro1(param0, param1) {					       \
	statement_in_a_block0;						       \
	statement_in_a_block1;						       \
	...								       \
}

In this case, every line is in a block and is indented as it would be in
a function body. I think you are okay with this, and now that I am
thinking about it, what I think you are proposing for macro0 will make
these two cases more consistent.

#define macro2(param0,							       \
	       param1,							       \
	       param2,							       \
	       param3,							       \
	       ...,							       \
	       paramn) ...						       \

In this last case, the body would be indented as in macro0, or macro1,
but the parameters passed into the macro are column aligned, consistent
with one of the acceptable ways of formatting function parameters that
don't fit on a single line.

In all cases, I put 1 space in between the closing parameter paren and
the line continuation `\`, if only one `\` is needed. Otherwise, I align
all the `\s` to the 80th column. Is this okay, or would you prefer that
I align them all to the 80th column, or something else?

> > +
> > +#define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)                      \
> > +               KUNIT_TRUE_MSG_ASSERTION(test,                                 \
> > +                                        KUNIT_EXPECTATION,                    \
> > +                                        condition,                            \
> > +                                        fmt,                                  \
> > +                                        ##__VA_ARGS__)
> > +
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
