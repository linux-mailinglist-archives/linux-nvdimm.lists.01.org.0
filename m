Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B01FBB863
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 17:48:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1CEBB21962301;
	Mon, 23 Sep 2019 08:51:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B8718202EF27C
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M6naaO3eN2JtKgsodjGmbFEb7omduasR6eHtDOBj/YU=; b=WDxDdSVtxB4MQheuYDglZVo77
 ITnMkIz7R+0s/TcK9u0iB564ZvSW2OG/lJv1lRwdjnxBatB+wSX35svuC1yd5Ea1AxQ52gRn6cmF2
 /83K/HFVn4+skc/Wt6uGE+DwUbc77iTcslmEjK/CRAvgV+6YQUkzJbtlBrr5Q+8JJKlmrTyBq44/u
 TJiHeSIwQ3VM6J44S1d1yNryMKLsQ8iZf1OrD6FnYs6OHkND8aMMMkrLPNGm6nhYxiQsA6gnvmund
 vT7S7hcNSvEXvCDhPF31ee1v2WxWOnkGIihjEU+7pqNLhV5/Kty9KSYUOFACXDa3f7vCTTX3UOnh6
 bZwx9NxQw==;
Received: from [2601:1c0:6280:3f0::9a1f]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCQZ9-00063q-MO; Mon, 23 Sep 2019 15:47:55 +0000
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for
 KUnit
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
Date: Mon, 23 Sep 2019 08:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923090249.127984-16-brendanhiggins@google.com>
Content-Language: en-US
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
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com,
 Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com, joel@jms.id.au,
 rientjes@google.com, jdike@addtoit.com, dan.carpenter@oracle.com,
 devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org, Tim.Bird@sony.com,
 linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr,
 kunit-dev@googlegroups.com, richard@nod.at, torvalds@linux-foundation.org,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/23/19 2:02 AM, Brendan Higgins wrote:
> Add documentation for KUnit, the Linux kernel unit testing framework.
> - Add intro and usage guide for KUnit
> - Add API reference
> 
> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  Documentation/dev-tools/index.rst           |   1 +
>  Documentation/dev-tools/kunit/api/index.rst |  16 +
>  Documentation/dev-tools/kunit/api/test.rst  |  11 +
>  Documentation/dev-tools/kunit/faq.rst       |  62 +++
>  Documentation/dev-tools/kunit/index.rst     |  79 +++
>  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
>  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
>  7 files changed, 925 insertions(+)
>  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
>  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
>  create mode 100644 Documentation/dev-tools/kunit/faq.rst
>  create mode 100644 Documentation/dev-tools/kunit/index.rst
>  create mode 100644 Documentation/dev-tools/kunit/start.rst
>  create mode 100644 Documentation/dev-tools/kunit/usage.rst


> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> new file mode 100644
> index 000000000000..6dc229e46bb3
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -0,0 +1,180 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +Getting Started
> +===============
> +
> +Installing dependencies
> +=======================
> +KUnit has the same dependencies as the Linux kernel. As long as you can build
> +the kernel, you can run KUnit.
> +
> +KUnit Wrapper
> +=============
> +Included with KUnit is a simple Python wrapper that helps format the output to
> +easily use and read KUnit output. It handles building and running the kernel, as
> +well as formatting the output.
> +
> +The wrapper can be run with:
> +
> +.. code-block:: bash
> +
> +   ./tools/testing/kunit/kunit.py run
> +
> +Creating a kunitconfig
> +======================
> +The Python script is a thin wrapper around Kbuild as such, it needs to be

                                       around Kbuild. As such,

> +configured with a ``kunitconfig`` file. This file essentially contains the
> +regular Kernel config, with the specific test targets as well.
> +
> +.. code-block:: bash
> +
> +	git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> +	cd $PATH_TO_LINUX_REPO
> +	ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> +
> +You may want to add kunitconfig to your local gitignore.
> +
> +Verifying KUnit Works
> +---------------------
> +
> +To make sure that everything is set up correctly, simply invoke the Python
> +wrapper from your kernel repo:
> +
> +.. code-block:: bash
> +
> +	./tools/testing/kunit/kunit.py
> +
> +.. note::
> +   You may want to run ``make mrproper`` first.

I normally use O=builddir when building kernels.
Does this support using O=builddir ?

> +
> +If everything worked correctly, you should see the following:
> +
> +.. code-block:: bash
> +
> +	Generating .config ...
> +	Building KUnit Kernel ...
> +	Starting KUnit Kernel ...
> +
> +followed by a list of tests that are run. All of them should be passing.
> +
> +.. note::
> +   Because it is building a lot of sources for the first time, the ``Building
> +   kunit kernel`` step may take a while.
> +
> +Writing your first test
> +=======================

[snip]

> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> new file mode 100644
> index 000000000000..c6e69634e274
> --- /dev/null
> +++ b/Documentation/dev-tools/kunit/usage.rst

TBD...


-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
