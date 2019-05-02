Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29840117B1
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 12:58:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5418E21B02822;
	Thu,  2 May 2019 03:58:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A40D021237AAD
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 03:58:51 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B53B620656;
 Thu,  2 May 2019 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1556794731;
 bh=T+a6pMLcd5HD33Dp1GZ3s3ZyPMK+MqwsS3ME8Zht+Rk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xn9qtrH/6iSeajL86xHXikqGvmBkjkPTLd1nQIMw4pWMh7dALh2KSvL9dx0J57LgI
 quJUvnif3o9cb3481YZvUlkI6jUNhggJl4YQx1f7LdW6Giv789veSDWkw97Tu8zDGX
 B/7+uvqfWjfGoe3LMHNAL8STZruUkOlyRkyfu/So=
Date: Thu, 2 May 2019 12:58:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 07/17] kunit: test: add initial tests
Message-ID: <20190502105849.GB12416@kroah.com>
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-8-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190501230126.229218-8-brendanhiggins@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
 mpe@ellerman.id.au, linux-kselftest@vger.kernel.org, shuah@kernel.org,
 robh@kernel.org, linux-nvdimm@lists.01.org, frowand.list@gmail.com,
 knut.omang@oracle.com, kieran.bingham@ideasonboard.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, sboyd@kernel.org, linux-kernel@vger.kernel.org,
 mcgrof@kernel.org, daniel@ffwll.ch, keescook@google.com,
 linux-fsdevel@vger.kernel.org, khilman@baylibre.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, May 01, 2019 at 04:01:16PM -0700, Brendan Higgins wrote:
> Add a test for string stream along with a simpler example.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  kunit/Kconfig              | 12 ++++++
>  kunit/Makefile             |  4 ++
>  kunit/example-test.c       | 88 ++++++++++++++++++++++++++++++++++++++
>  kunit/string-stream-test.c | 61 ++++++++++++++++++++++++++
>  4 files changed, 165 insertions(+)
>  create mode 100644 kunit/example-test.c
>  create mode 100644 kunit/string-stream-test.c
> 
> diff --git a/kunit/Kconfig b/kunit/Kconfig
> index 64480092b2c24..5cb500355c873 100644
> --- a/kunit/Kconfig
> +++ b/kunit/Kconfig
> @@ -13,4 +13,16 @@ config KUNIT
>  	  special hardware. For more information, please see
>  	  Documentation/kunit/
>  
> +config KUNIT_TEST
> +	bool "KUnit test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables KUnit test to test KUnit.
> +
> +config KUNIT_EXAMPLE_TEST
> +	bool "Example test for KUnit"
> +	depends on KUNIT
> +	help
> +	  Enables example KUnit test to demo features of KUnit.

Can't these tests be module?

Or am I mis-reading the previous logic?

Anyway, just a question, nothing objecting to this as-is for now.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
