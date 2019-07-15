Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D04ED69CCE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jul 2019 22:30:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CC7D212B5EF7;
	Mon, 15 Jul 2019 13:33:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 03455212B5EE6
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 13:33:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so8242578pgp.12
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Guk3L6+8PLdqP7pYPvzhoPuDjq05e+2mmqgYxycfTpo=;
 b=nmdIrQ2ZG9zLY+uPnHaC+zU9b/FYlCcJUklqPlgIEvxvjrncOHXB+C4uonVCMPNT5U
 RDlsPPFfFHanzQy12v9LKBzsgYs//6dy4qqJq9wWWyI4pDK3aCgJ1J/JgmQXwTE7LK3E
 iw5kJfsnm+yh+B2qKZbTQBSYW2yNi7ZyoDweAfKbzMv3dfSuT0useTynnAjypl5lf7/d
 jTEh9cq2DJ6lxhwAR1P3fF5Tm12yriac2Lepz1S6WLSn9ipeqXXdzi8KqMKw91pnk6DG
 ICc14afUNRCpD25tMKIn+kqhek6winXiVWbGXLe13YMzt6iQrEchkA/y8vKWAxCaJIaL
 ulxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Guk3L6+8PLdqP7pYPvzhoPuDjq05e+2mmqgYxycfTpo=;
 b=l0OxDmbMf2B8EtX/Nnzu8qxpKohN8LyKSrkhPRXRv1QRnOPCj9wL3I+03YrVxuXJFc
 KpG8IRRKzwsh0Pj0zwxdi/rhWvhX6nNO487mjuFH/kF7oy17KCGTwGZkIJDsD8WGpMdE
 pCn8n+Nvh7Sael5/oswdE7ymFQpxsyv0M6AbuUKcjlD9WPn9+j1HPX93UJbhhebavU6J
 +cavHBYfekKoqpochiqkqtnG704VqRARRlMYOvURQrcfVWJW9hVqwQjy4vkoyMQlZv5m
 ThIcDRQlgoyUCj8pnNUmOSbY/mM6p7YussXTkvIKxQJC5ChlPyXvCShAmtOGk+4xPSps
 qITg==
X-Gm-Message-State: APjAAAVQgpy68khrxjyuD2rRBH8Co5o98Q+eMw/jvm7VUe0SqvSdbhcv
 bOdd14LkbVMFWW6kPg7flDTe2LJI52bit7vP0E3vdw==
X-Google-Smtp-Source: APXvYqzKQuaXpGEOS+dMEmBo8FPFiuVIjj5hhYTkizz5+oKRzaBKQU1vUVyuyXBWxZXEb/U0Rw/0GC/2FiD36LZR+90=
X-Received: by 2002:a63:b919:: with SMTP id z25mr28642556pge.201.1563222633591; 
 Mon, 15 Jul 2019 13:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com>
 <20190715202425.CE64C20665@mail.kernel.org>
In-Reply-To: <20190715202425.CE64C20665@mail.kernel.org>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Mon, 15 Jul 2019 13:30:22 -0700
Message-ID: <CAFd5g45iHnMLOGQbXwzX6F74pkQGKBCSufkpYPOcw_iNSeiQKg@mail.gmail.com>
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
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
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
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

On Mon, Jul 15, 2019 at 1:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-12 01:17:28)
> > diff --git a/kunit/test.c b/kunit/test.c
> > index 571e4c65deb5c..f165c9d8e10b0 100644
> > --- a/kunit/test.c
> > +++ b/kunit/test.c
> > @@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
> >         return 0;
> >  }
> >
> > +struct kunit_resource *kunit_alloc_resource(struct kunit *test,
> > +                                           kunit_resource_init_t init,
> > +                                           kunit_resource_free_t free,
> > +                                           void *context)
> > +{
> > +       struct kunit_resource *res;
> > +       int ret;
> > +
> > +       res = kzalloc(sizeof(*res), GFP_KERNEL);
>
> This uses GFP_KERNEL.
>
> > +       if (!res)
> > +               return NULL;
> > +
> > +       ret = init(res, context);
> > +       if (ret)
> > +               return NULL;
> > +
> > +       res->free = free;
> > +       mutex_lock(&test->lock);
>
> And this can sleep.
>
> > +       list_add_tail(&res->node, &test->resources);
> > +       mutex_unlock(&test->lock);
> > +
> > +       return res;
> > +}
> > +
> > +void kunit_free_resource(struct kunit *test, struct kunit_resource *res)
>
> Should probably add a note that we assume the test lock is held here, or
> even add a lockdep_assert_held(&test->lock) into the function to
> document that and assert it at the same time.

Seems reasonable.

> > +{
> > +       res->free(res);
> > +       list_del(&res->node);
> > +       kfree(res);
> > +}
> > +
> > +struct kunit_kmalloc_params {
> > +       size_t size;
> > +       gfp_t gfp;
> > +};
> > +
> > +static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> > +{
> > +       struct kunit_kmalloc_params *params = context;
> > +
> > +       res->allocation = kmalloc(params->size, params->gfp);
> > +       if (!res->allocation)
> > +               return -ENOMEM;
> > +
> > +       return 0;
> > +}
> > +
> > +static void kunit_kmalloc_free(struct kunit_resource *res)
> > +{
> > +       kfree(res->allocation);
> > +}
> > +
> > +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> > +{
> > +       struct kunit_kmalloc_params params;
> > +       struct kunit_resource *res;
> > +
> > +       params.size = size;
> > +       params.gfp = gfp;
> > +
> > +       res = kunit_alloc_resource(test,
>
> This calls that sleeping function above...
>
> > +                                  kunit_kmalloc_init,
> > +                                  kunit_kmalloc_free,
> > +                                  &params);
>
> but this passes a GFP flags parameter through to the
> kunit_kmalloc_init() function. How is this going to work if some code
> uses GFP_ATOMIC, but then we try to allocate and sleep in
> kunit_alloc_resource() with GFP_KERNEL?

Yeah, that's an inconsistency. I need to fix that.

> One solution would be to piggyback on all the existing devres allocation
> logic we already have and make each struct kunit a device that we pass
> into the devres functions. A far simpler solution would be to just
> copy/paste what devres does and use a spinlock and an allocation
> function that takes GFP flags.

Yeah, that's what I did originally, but I thought from the discussion
on patch 01 that you thought a spinlock was overkill for struct kunit.
I take it you only meant in that initial patch?

> > +
> > +       if (res)
> > +               return res->allocation;
> > +
> > +       return NULL;
> > +}

Cheers
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
