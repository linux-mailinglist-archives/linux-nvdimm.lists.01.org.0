Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1512329609
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 06:20:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 128CA100EB834;
	Mon,  1 Mar 2021 21:20:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50661100EB832
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 21:20:52 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l2so13136023pgb.1
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 21:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=kmtPXq6M62BY/Onb9JbO5BZzweWyCKjCHOkJ/cLGpjc=;
        b=uuj3oEqXP2ujZxWDuKTj6iom3No2Ceyake+1BGVD+xMqKIAMbN3KWulWaRKuB1gHkB
         b/WmQ7dUDDblAB+C+oHiMumzNaSM6wo1uK7cx9x/kh4oUGTzdfoxhRfmm64tTmvLY2LX
         Q9twI6dh/vPggLTGpAXEk6QtXupyH1XerbcSH5g2ZOx7s6Pyw8t1NV5PXxiAzByKjCDM
         d0WZEVYRsQeEUZZznSsMlrTYS6g4hcVQhTdjbijhj9BuObzpVMZPMfhJaAYdUwijEQBK
         2Bv20SXgpzpwvvE74fcKOfv5/ps2Lw7whyiduao/kvZaJx68HSIwNzXU5PLeXfTKBiLt
         oH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=kmtPXq6M62BY/Onb9JbO5BZzweWyCKjCHOkJ/cLGpjc=;
        b=UcfchMfHq77p+gHLm82f3VDGJlxw44DtSM6lChgZafu6NsTqIYfF1WWS2vlGNfPV0Y
         CTwG6AS6w/jxgo/p8mzdZBEZ0KcK2+LI5kofnfMvk61vvmgYkRcc0yonDXrnqJBTzgTh
         0H+g5Nbc9rsJ0nG8HiAUciCzIJ+tJ3WaX6e7ZmurKVq6L8ct+zzLoDmjRJB4OYJWk9mK
         UEPJniHEXQs9G2pXnxhBB1x4Bf/9rn1vxKdhFGssrl2e5EDzLE1oggE4+7++do+1BazZ
         IucFKjC9L9oeXNet8wSfFxJc8g/PWqgnslRWiTUDUDXn5UnfOx7kQXe/o4jspQvUOaDg
         yh5A==
X-Gm-Message-State: AOAM530unID+/axamrCcxTNw5VW9VTa0yfVtF87fhMbHMar3q2DrlxQA
	zSoD3FoW2v2eJT+aAupTz98hlQ==
X-Google-Smtp-Source: ABdhPJzuc2eD6Yb+UEdKn8VPQmqGSuQdF7IX2cZlU0eUOe27NaZlj/i8Y3y2Irhqfdy2epFcqEnXiw==
X-Received: by 2002:a62:8051:0:b029:1ed:d704:1f11 with SMTP id j78-20020a6280510000b02901edd7041f11mr1770670pfd.41.1614662451740;
        Mon, 01 Mar 2021 21:20:51 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id x6sm17658763pfd.12.2021.03.01.21.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 21:20:51 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: QI Fuli <fukuri.sai@gmail.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH 2/2] ndctl/test: add checking the presence of jq
 command ahead
In-Reply-To: <20210301172540.1511-2-qi.fuli@fujitsu.com>
References: <20210301172540.1511-1-qi.fuli@fujitsu.com>
 <20210301172540.1511-2-qi.fuli@fujitsu.com>
Date: Tue, 02 Mar 2021 10:50:48 +0530
Message-ID: <87lfb6w2q7.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: AY5IKZDBOGDE6T2DMO5LDJ3PXRKED7B7
X-Message-ID-Hash: AY5IKZDBOGDE6T2DMO5LDJ3PXRKED7B7
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AY5IKZDBOGDE6T2DMO5LDJ3PXRKED7B7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

QI Fuli <fukuri.sai@gmail.com> writes:

> Due to the lack of jq command, the result of the test will be 'fail'.
> This patch adds checking the presence of jq commmand ahead.
> If there is no jq command in the system, the test will be marked as 'skip'.
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Link: https://github.com/pmem/ndctl/issues/141

Though it looks slightly redundant after having the check in configure.ac, not
against having additional checks.

Reviewed-by: Santosh Sivaraj <santosh@fossix.org>

Thanks,
Santosh

> ---
>  test/daxdev-errors.sh           | 1 +
>  test/inject-error.sh            | 2 ++
>  test/inject-smart.sh            | 1 +
>  test/label-compat.sh            | 1 +
>  test/max_available_extent_ns.sh | 1 +
>  test/monitor.sh                 | 2 ++
>  test/multi-dax.sh               | 1 +
>  test/sector-mode.sh             | 2 ++
>  8 files changed, 11 insertions(+)
>
> diff --git a/test/daxdev-errors.sh b/test/daxdev-errors.sh
> index 6281f32..9547d78 100755
> --- a/test/daxdev-errors.sh
> +++ b/test/daxdev-errors.sh
> @@ -9,6 +9,7 @@ rc=77
>  . $(dirname $0)/common
>
>  check_min_kver "4.12" || do_skip "lacks dax dev error handling"
> +check_prereq "jq"
>
>  trap 'err $LINENO' ERR
>
> diff --git a/test/inject-error.sh b/test/inject-error.sh
> index c636033..7d0b826 100755
> --- a/test/inject-error.sh
> +++ b/test/inject-error.sh
> @@ -11,6 +11,8 @@ err_count=8
>
>  . $(dirname $0)/common
>
> +check_prereq "jq"
> +
>  trap 'err $LINENO' ERR
>
>  # sample json:
> diff --git a/test/inject-smart.sh b/test/inject-smart.sh
> index 94705df..4ca83b8 100755
> --- a/test/inject-smart.sh
> +++ b/test/inject-smart.sh
> @@ -166,6 +166,7 @@ do_tests()
>  }
>
>  check_min_kver "4.19" || do_skip "kernel $KVER may not support smart (un)injection"
> +check_prereq "jq"
>  modprobe nfit_test
>  rc=1
>
> diff --git a/test/label-compat.sh b/test/label-compat.sh
> index 340b93d..8ab2858 100755
> --- a/test/label-compat.sh
> +++ b/test/label-compat.sh
> @@ -10,6 +10,7 @@ BASE=$(dirname $0)
>  . $BASE/common
>
>  check_min_kver "4.11" || do_skip "may not provide reliable isetcookie values"
> +check_prereq "jq"
>
>  trap 'err $LINENO' ERR
>
> diff --git a/test/max_available_extent_ns.sh b/test/max_available_extent_ns.sh
> index 14d741d..343f3c9 100755
> --- a/test/max_available_extent_ns.sh
> +++ b/test/max_available_extent_ns.sh
> @@ -9,6 +9,7 @@ rc=77
>  trap 'err $LINENO' ERR
>
>  check_min_kver "4.19" || do_skip "kernel $KVER may not support max_available_size"
> +check_prereq "jq"
>
>  init()
>  {
> diff --git a/test/monitor.sh b/test/monitor.sh
> index cdab5e1..28c5541 100755
> --- a/test/monitor.sh
> +++ b/test/monitor.sh
> @@ -13,6 +13,8 @@ smart_supported_bus=""
>
>  . $(dirname $0)/common
>
> +check_prereq "jq"
> +
>  trap 'err $LINENO' ERR
>
>  check_min_kver "4.15" || do_skip "kernel $KVER may not support monitor service"
> diff --git a/test/multi-dax.sh b/test/multi-dax.sh
> index e932569..8496619 100755
> --- a/test/multi-dax.sh
> +++ b/test/multi-dax.sh
> @@ -9,6 +9,7 @@ rc=77
>  . $(dirname $0)/common
>
>  check_min_kver "4.13" || do_skip "may lack multi-dax support"
> +check_prereq "jq"
>
>  trap 'err $LINENO' ERR
>
> diff --git a/test/sector-mode.sh b/test/sector-mode.sh
> index dd7013e..54fa806 100755
> --- a/test/sector-mode.sh
> +++ b/test/sector-mode.sh
> @@ -6,6 +6,8 @@ rc=77
>
>  . $(dirname $0)/common
>
> +check_prereq "jq"
> +
>  set -e
>  trap 'err $LINENO' ERR
>
> --
> 2.29.2
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
