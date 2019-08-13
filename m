Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDDD8ADDD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 13 Aug 2019 06:39:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27BB021329969;
	Mon, 12 Aug 2019 21:41:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sboyd@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ED555213281D9
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 21:41:15 -0700 (PDT)
Received: from kernel.org (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 661F82054F;
 Tue, 13 Aug 2019 04:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565671139;
 bh=3xMxQdsEpxtjj+1yTxgV9WOlUO2WQ552exvs56/rr1o=;
 h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
 b=LR11it/I3O8CGTrv+Ng5zvucPa8uUkEfa3LmKFjw6O5u9qhsOj4v0EPjTnoOYONrH
 u/tnKqLjb2VOMamzmBD+bQ92PSyu/l9yjopx4tVHE3QOH9DwxrVN/Ixn8t2s8dlBob
 UQtw5MZJLoTm4I6qlCWqOvb7Iah3ocYPA4XTG7DY=
MIME-Version: 1.0
In-Reply-To: <20190812182421.141150-15-brendanhiggins@google.com>
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-15-brendanhiggins@google.com>
Subject: Re: [PATCH v12 14/18] kunit: defconfig: add defconfigs for building
 KUnit tests
From: Stephen Boyd <sboyd@kernel.org>
To: Brendan Higgins <brendanhiggins@google.com>, frowand.list@gmail.com,
 gregkh@linuxfoundation.org, jpoimboe@redhat.com, keescook@google.com,
 kieran.bingham@ideasonboard.com, mcgrof@kernel.org, peterz@infradead.org,
 robh@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
User-Agent: alot/0.8.1
Date: Mon, 12 Aug 2019 21:38:58 -0700
Message-Id: <20190813043859.661F82054F@mail.kernel.org>
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

Quoting Brendan Higgins (2019-08-12 11:24:17)
> diff --git a/arch/um/configs/kunit_defconfig b/arch/um/configs/kunit_defconfig
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/arch/um/configs/kunit_defconfig
> @@ -0,0 +1,8 @@
> +CONFIG_OF=y
> +CONFIG_OF_UNITTEST=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_I2C=y
> +CONFIG_I2C_MUX=y
> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_TEST=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> new file mode 100644
> index 0000000000000..bfe49689038f1
> --- /dev/null
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -0,0 +1,8 @@
> +CONFIG_OF=y
> +CONFIG_OF_UNITTEST=y
> +CONFIG_OF_OVERLAY=y
> +CONFIG_I2C=y
> +CONFIG_I2C_MUX=y

Are these above config options necessary? I don't think they're part of
the patch series anymore so it looks odd to enable the OF unittests and
i2c configs.

> +CONFIG_KUNIT=y
> +CONFIG_KUNIT_TEST=y
> +CONFIG_KUNIT_EXAMPLE_TEST=y
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
