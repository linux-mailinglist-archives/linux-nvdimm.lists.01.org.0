Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 092A5563F1
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 10:03:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40C8221237804;
	Wed, 26 Jun 2019 01:03:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D10352194EB77
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 01:03:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f25so821131pgv.10
 for <linux-nvdimm@lists.01.org>; Wed, 26 Jun 2019 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nwcdyZlVJNYhzqAX8drYdwwlincSCC0RlYdtVUa7uAU=;
 b=IkHW2/q5zYf/AiFOwOUn62sZGCukGK93pV5qaXaFIqAD6rVurvvvVguZ0CQNqSK004
 PUW6XYRD1tpIvu/H8uK2xdNaMWkc3s+ZreXHoEsItZgP1H729MJ8nowT1aehVpl1AnJq
 rAPmVbRpyeOR+0aKXV1iywesPypOO3F4fwUcKnHNHDKkSlnXU9KrB33bQAymKu7tZx6G
 yt/Ix8apmwB+zPUY0f7g7GrCvvhKCA2B8FFf68JI9BW8d/snEU6oOmLqSE4EOwMnXWLP
 uFddQ1SWm8yfpnKxzglfseoQZZbmazxOSGTrgVrxfJIOk1+YhP4zhoDMctTsB330F1Sn
 /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nwcdyZlVJNYhzqAX8drYdwwlincSCC0RlYdtVUa7uAU=;
 b=Vgz0qmviCN6qNfA/Nc8cuEW4hAvjp2lrIUzJ6O3XnFQvdzUIACuaBIlXJDNugrUUwd
 8iw7RGPYtS2m2vghCsoyjclocnhEYWjQldZKemHLwd894lTEyOxn7SD5MhtAyGTUeWAF
 k6TnzLMcVGPj7qiziTrR7LqP6ZEGnlnfePDbymbsOB5DeBoCVM9TVjK91+bn4HqehMEv
 uONk+hUyo2SnKaJCaUOgrYIOcC7yzkSSCBxtUHMsl8PzPj87W1c87q3145jYC4G6dLQH
 yRr8VnDT6FVfMyXXfZ9VeGkCx2SznTxILlwnqcT6smLN+m4my3bXy+NkbyVWSzyr6C5e
 PfrQ==
X-Gm-Message-State: APjAAAXJ93jzsuRA3OfWkQaHyvspx+sBV84d2GUONYzmlNXgthibVPZU
 bhp7s+W5gAtHiJswrbss5l28h1VKm6wZnedrmjOyMw==
X-Google-Smtp-Source: APXvYqzSvFzyXqC4mv+sYfABQnmt0YNMhvFTkgdzLZZeovItyFY3wThgA7+iWx0YSEf5WS6vtdXjsfVxGyJkZN8WaD8=
X-Received: by 2002:a17:90a:9382:: with SMTP id
 q2mr3140021pjo.131.1561536186861; 
 Wed, 26 Jun 2019 01:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com>
 <20190626000150.GT19023@42.do-not-panic.com>
In-Reply-To: <20190626000150.GT19023@42.do-not-panic.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 26 Jun 2019 01:02:55 -0700
Message-ID: <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
To: Luis Chamberlain <mcgrof@kernel.org>
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
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
 Joel Stanley <joel@jms.id.au>, David Rientjes <rientjes@google.com>,
 Jeff Dike <jdike@addtoit.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, "Bird,
 Timothy" <Tim.Bird@sony.com>, linux-um@lists.infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, Julia Lawall <julia.lawall@lip6.fr>,
 Josh Poimboeuf <jpoimboe@redhat.com>, kunit-dev@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>, Richard Weinberger <richard@nod.at>,
 Stephen Boyd <sboyd@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Kees Cook <keescook@google.com>,
 linux-fsdevel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jun 25, 2019 at 5:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> >  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
> >  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig
>
> Why are these being added upstream? The commit log does not explain
> this.

Oh sorry, those are for testing purposes. I thought that was clear
from being in the test_data directory. I will reference it in the
commit log in the next revision.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
