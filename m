Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1561BA327
	for <lists+linux-nvdimm@lfdr.de>; Sun, 22 Sep 2019 18:29:23 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E068121962301;
	Sun, 22 Sep 2019 09:31:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3C74A202ECFC4
 for <linux-nvdimm@lists.01.org>; Sun, 22 Sep 2019 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rGqXLDwoxSJ+wMClTeqCK7DBN64mFNHAm3f7xeAfO/Y=; b=Jqrmyr//FV9HMLM96+iNkQrG9
 U4Uoy/pOrdbQVcKQBj9xPvAkV/nzrJpOJ1bdtxIXDSdsG2VLMEJv6TViNNLTSyi4UdBQYPKzaxcrJ
 2T4t8mrKe78jij/lNHM3wjTob7KcsjUa815F7f3Aihj/SleVztJIvrssWkutND3UYT6Rv/iySkIdf
 NfuXnPzxcoef19ZF0a6xFA3k17U3TqdtEDvk5uN2TMgl2RW2OQ0GTb2A3YN0AuqPW+csabIMBu0CZ
 MEZI3cTzBe5bCL5Kj08Onh8n/iaXULqCTmLm39f238LK0to8z19ySnG8XjQR5JizEmVVeaKJZ1gFo
 +Z/Ym2Tyg==;
Received: from [2601:1c0:6280:3f0::9a1f]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iC4iv-00076b-DS; Sun, 22 Sep 2019 16:28:33 +0000
Subject: Re: [PATCH v17 07/19] kunit: test: add initial tests
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
References: <20190921001855.200947-1-brendanhiggins@google.com>
 <20190921001855.200947-8-brendanhiggins@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <944ac47d-1411-9ebd-d0d4-a616c88c9c20@infradead.org>
Date: Sun, 22 Sep 2019 09:28:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190921001855.200947-8-brendanhiggins@google.com>
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
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/20/19 5:18 PM, Brendan Higgins wrote:
> Add a test for string stream along with a simpler example.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  lib/kunit/Kconfig              | 25 ++++++++++
>  lib/kunit/Makefile             |  4 ++
>  lib/kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++
>  lib/kunit/string-stream-test.c | 52 ++++++++++++++++++++
>  4 files changed, 169 insertions(+)
>  create mode 100644 lib/kunit/example-test.c
>  create mode 100644 lib/kunit/string-stream-test.c
> 
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 666b9cb67a74..3868c226cf31 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -11,3 +11,28 @@ menuconfig KUNIT
>  	  special hardware when using UML. Can also be used on most other
>  	  architectures. For more information, please see
>  	  Documentation/dev-tools/kunit/.
> +
> +if KUNIT

The 'if' above provides the dependency clause, so the 2 'depends on KUNIT'
below are not needed.  They are redundant.

> +
> +config KUNIT_TEST
> +	bool "KUnit test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables the unit tests for the KUnit test framework. These tests test
> +	  the KUnit test framework itself; the tests are both written using
> +	  KUnit and test KUnit. This option should only be enabled for testing
> +	  purposes by developers interested in testing that KUnit works as
> +	  expected.
> +
> +config KUNIT_EXAMPLE_TEST
> +	bool "Example test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables an example unit test that illustrates some of the basic
> +	  features of KUnit. This test only exists to help new users understand
> +	  what KUnit is and how it is used. Please refer to the example test
> +	  itself, lib/kunit/example-test.c, for more information. This option
> +	  is intended for curious hackers who would like to understand how to
> +	  use KUnit for kernel development.
> +
> +endif # KUNIT



-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
