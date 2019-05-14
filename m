Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92001E589
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 01:25:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2EBF2127779B;
	Tue, 14 May 2019 16:25:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=brendanhiggins@google.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 77DFB21277795
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 16:25:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t87so307439pfa.2
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 16:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=4Jy0W2AOE8X2G5DhaX0aRTRku/ISFojI4Jx+xxzmku0=;
 b=MQyJklXnbo6c96JLKB7QksEJHkSpFBHsrJS476t6XQjCpcmGuNq+IaehI46rq7cwoT
 5/83MudsTcPwLAbJQi+E/WmVnctS8ig6t3ILH9hcfgEVCDySDpa/WBKmvGuT+TW4+eQ/
 S0mwkFbAjmxc5fsPkl2wQBiW7k+GUPaiQJ2GyWSoGs0PuW8MdgL5cUCvBhefg1tJKEs1
 qTdCbxKYYLs1akDBll4MhMba7K4eHfr7lI87DpyzfvZwtlscx4zjYkzIKYzvyEhxi2i1
 yOVJ7B7mk2BP2yJFkPIlDEqeXR3rL1YA08yj2q7YWAYVfzf7Fawslh7NINITcHYKajd3
 6xGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4Jy0W2AOE8X2G5DhaX0aRTRku/ISFojI4Jx+xxzmku0=;
 b=Wi0aWrEE96c9wyfpL/TvvFRMyi8Xj36ncKwdGZGtdc8ehHA5cXBTOBYsT7IYYFRMSr
 CSXixV/P6kiuQaBe71B31nze2C/yXmZnQT43LpzVHxKWZ3kFaKbeVmmimw9QB92oNfmu
 BwsBmLTTm3oerpGKJajggWXpz93mAd0b6ES25aAAYDycg9SnLVew1NgE2KdtI3I7W9vy
 9JecSAdn5tAIVmX1iz/3m+vc8lsx8kjGg1b3Y3608vlR2woi06GEIIPFexuCrVESZCn8
 l4dGiWiw7yago87OAamCQKdZlmSUQSv0n+J8RL24KJPOLOwLyrxN7ZZPPWXhVnXgZpzr
 D5vQ==
X-Gm-Message-State: APjAAAXiA0zG+JpKaov1jG8VuEINcTfdVCsH4cOlNbcDhw60U6CAagQ0
 64rCXamX+TiAGwpUGhFofVT13w==
X-Google-Smtp-Source: APXvYqwFT36xTe7xIV4JHHBk0GWoU89u5XYlVl2IpbZ1GuRL1xHoENSFO5jHtT0PWOMWGfK71tbjWA==
X-Received: by 2002:a62:6585:: with SMTP id z127mr4445645pfb.179.1557876312369; 
 Tue, 14 May 2019 16:25:12 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
 by smtp.gmail.com with ESMTPSA id 2sm205811pgc.49.2019.05.14.16.25.10
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 14 May 2019 16:25:11 -0700 (PDT)
Date: Tue, 14 May 2019 16:25:06 -0700
From: Brendan Higgins <brendanhiggins@google.com>
To: frowand.list@gmail.com, gregkh@linuxfoundation.org, jpoimboe@redhat.com,
 keescook@google.com, kieran.bingham@ideasonboard.com,
 mcgrof@kernel.org, peterz@infradead.org, robh@kernel.org,
 sboyd@kernel.org, shuah@kernel.org, tytso@mit.edu,
 yamada.masahiro@socionext.com
Subject: Re: [PATCH v4 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
Message-ID: <20190514232506.GA16788@google.com>
References: <20190514221711.248228-1-brendanhiggins@google.com>
 <20190514221711.248228-17-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190514221711.248228-17-brendanhiggins@google.com>
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
Cc: pmladek@suse.com, linux-doc@vger.kernel.org, amir73il@gmail.com,
 dri-devel@lists.freedesktop.org, Alexander.Levin@microsoft.com,
 linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
 khilman@baylibre.com, knut.omang@oracle.com, wfg@linux.intel.com,
 joel@jms.id.au, rientjes@google.com, jdike@addtoit.com,
 dan.carpenter@oracle.com, devicetree@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Tim.Bird@sony.com, linux-um@lists.infradead.org,
 rostedt@goodmis.org, julia.lawall@lip6.fr, kunit-dev@googlegroups.com,
 richard@nod.at, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 daniel@ffwll.ch, mpe@ellerman.id.au, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 14, 2019 at 03:17:09PM -0700, Brendan Higgins wrote:
> Add myself as maintainer of KUnit, the Linux kernel's unit testing
> framework.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c2fce72e694f..8a91887c8d541 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8448,6 +8448,17 @@ S:	Maintained
>  F:	tools/testing/selftests/
>  F:	Documentation/dev-tools/kselftest*
>  
> +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> +M:	Brendan Higgins <brendanhiggins@google.com>
> +L:	linux-kselftest@vger.kernel.org
> +L:	kunit-dev@googlegroups.com
> +W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
> +S:	Maintained
> +F:	Documentation/kunit/

Dang it! I forgot to update the documentation path...

Will fix in next revision.

> +F:	include/kunit/
> +F:	kunit/
> +F:	tools/testing/kunit/
> +
>  KERNEL USERMODE HELPER
>  M:	Luis Chamberlain <mcgrof@kernel.org>
>  L:	linux-kernel@vger.kernel.org
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
