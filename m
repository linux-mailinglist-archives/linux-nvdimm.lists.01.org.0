Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC97C2115E
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 02:38:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4368F2126D822;
	Thu, 16 May 2019 17:38:50 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9D72D21244A13
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 17:38:47 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0962F2082E;
 Fri, 17 May 2019 00:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558053527;
 bh=h7x4s8lT+SFQAKT2oROUOwG99nmbA/iuhNAdlGK/1zk=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=pwJefM32rVyc17BV4NKTMNz9bAtRXF3fs8QXDQmfCoQ8dGWwvrJtKIhWefJVALK8E
 uExHbjAOgbiFZVFaM8n4hSxNXniqu1kMlprj5ffN87QHOgHX7iyfmP5RLT5V0AIfD4
 Pob5g1PWM6wWtC9518tZ1d/0IihjJAgMh1BsvFf4=
MIME-Version: 1.0
In-Reply-To: <20190514221711.248228-3-brendanhiggins@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-3-brendanhiggins@google.com>
Subject: Re: [PATCH v4 02/18] kunit: test: add test resource management API
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date: Thu, 16 May 2019 17:38:46 -0700
Message-Id: <20190517003847.0962F2082E@mail.kernel.org>
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

Quoting Brendan Higgins (2019-05-14 15:16:55)
> diff --git a/kunit/test.c b/kunit/test.c
> index 86f65ba2bcf92..a15e6f8c41582 100644
> --- a/kunit/test.c
> +++ b/kunit/test.c
[..]
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
> +                                  kunit_kmalloc_init,
> +                                  kunit_kmalloc_free,
> +                                  &params);
> +
> +       if (res)
> +               return res->allocation;
> +       else
> +               return NULL;

Can be written as

	if (res)
		return ....
	return 

and some static analysis tools prefer this.

> +}
> +
> +void kunit_cleanup(struct kunit *test)
> +{
> +       struct kunit_resource *resource, *resource_safe;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&test->lock, flags);

Ah ok, test->lock is protecting everything now? Does it need to be a
spinlock, or can it be a mutex?

> +       list_for_each_entry_safe(resource,
> +                                resource_safe,
> +                                &test->resources,
> +                                node) {
> +               kunit_free_resource(test, resource);
> +       }
> +       spin_unlock_irqrestore(&test->lock, flags);
> +}
> +
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
