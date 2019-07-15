Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F7869CB8
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jul 2019 22:24:28 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86657212B5EE6;
	Mon, 15 Jul 2019 13:26:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6D68721A070B8
 for <linux-nvdimm@lists.01.org>; Mon, 15 Jul 2019 13:26:54 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CE64C20665;
 Mon, 15 Jul 2019 20:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1563222265;
 bh=z/3S4xXt/Rio/ofj03vwkBIO5OR52dDSZ9Eeq6mO6XI=;
 h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
 b=BXkGMbTaQqFfurRCy1g8au7AeTtgOFutLGJt3puQKKnveCArE1l5n+TvNB5nyLQN2
 RewIrkkACOQLU4j8bdd/A1S3ea0t6aCgTcsSBEisWmgVGg22p/nmZ63GDKRcOxtMyZ
 60uqJ7tvYGN5awKtcLQiKpJWBRakwwDtbA+09H2w=
MIME-Version: 1.0
In-Reply-To: <20190712081744.87097-3-brendanhiggins@google.com>
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-3-brendanhiggins@google.com>
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
Subject: Re: [PATCH v9 02/18] kunit: test: add test resource management API
User-Agent: alot/0.8.1
Date: Mon, 15 Jul 2019 13:24:25 -0700
Message-Id: <20190715202425.CE64C20665@mail.kernel.org>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 Brendan Higgins <brendanhiggins@google.com>, dri-devel@lists.freedesktop.org,
 Alexander.Levin@microsoft.com, linux-kselftest@vger.kernel.org,
 linux-nvdimm@lists.01.org, khilman@baylibre.com, knut.omang@oracle.com,
 wfg@linux.intel.com, joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Quoting Brendan Higgins (2019-07-12 01:17:28)
> diff --git a/kunit/test.c b/kunit/test.c
> index 571e4c65deb5c..f165c9d8e10b0 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
> @@ -171,6 +175,96 @@ int kunit_run_tests(struct kunit_suite *suite)
>         return 0;
>  }
>  
> +struct kunit_resource *kunit_alloc_resource(struct kunit *test,
> +                                           kunit_resource_init_t init,
> +                                           kunit_resource_free_t free,
> +                                           void *context)
> +{
> +       struct kunit_resource *res;
> +       int ret;
> +
> +       res = kzalloc(sizeof(*res), GFP_KERNEL);

This uses GFP_KERNEL.

> +       if (!res)
> +               return NULL;
> +
> +       ret = init(res, context);
> +       if (ret)
> +               return NULL;
> +
> +       res->free = free;
> +       mutex_lock(&test->lock);

And this can sleep.

> +       list_add_tail(&res->node, &test->resources);
> +       mutex_unlock(&test->lock);
> +
> +       return res;
> +}
> +
> +void kunit_free_resource(struct kunit *test, struct kunit_resource *res)

Should probably add a note that we assume the test lock is held here, or
even add a lockdep_assert_held(&test->lock) into the function to
document that and assert it at the same time.

> +{
> +       res->free(res);
> +       list_del(&res->node);
> +       kfree(res);
> +}
> +
> +struct kunit_kmalloc_params {
> +       size_t size;
> +       gfp_t gfp;
> +};
> +
> +static int kunit_kmalloc_init(struct kunit_resource *res, void *context)
> +{
> +       struct kunit_kmalloc_params *params = context;
> +
> +       res->allocation = kmalloc(params->size, params->gfp);
> +       if (!res->allocation)
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
> +static void kunit_kmalloc_free(struct kunit_resource *res)
> +{
> +       kfree(res->allocation);
> +}
> +
> +void *kunit_kmalloc(struct kunit *test, size_t size, gfp_t gfp)
> +{
> +       struct kunit_kmalloc_params params;
> +       struct kunit_resource *res;
> +
> +       params.size = size;
> +       params.gfp = gfp;
> +
> +       res = kunit_alloc_resource(test,

This calls that sleeping function above...

> +                                  kunit_kmalloc_init,
> +                                  kunit_kmalloc_free,
> +                                  &params);

but this passes a GFP flags parameter through to the
kunit_kmalloc_init() function. How is this going to work if some code
uses GFP_ATOMIC, but then we try to allocate and sleep in
kunit_alloc_resource() with GFP_KERNEL? 

One solution would be to piggyback on all the existing devres allocation
logic we already have and make each struct kunit a device that we pass
into the devres functions. A far simpler solution would be to just
copy/paste what devres does and use a spinlock and an allocation
function that takes GFP flags.

> +
> +       if (res)
> +               return res->allocation;
> +
> +       return NULL;
> +}
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
