Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3C2324D20
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 10:45:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F395100F2270;
	Thu, 25 Feb 2021 01:45:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 22AFD100F226D
	for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 01:45:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z5so3261072pfe.3
        for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=hk9GCi+OwDFM8NtbnJNJU2KSnU6fknD2DtC3zfb/KO4=;
        b=qXetonuLtD/XT9xnPPwtJnoitVE+Z1O5WbHZbLifSuPttZgkkSs3BboYJPf25TROxi
         BSJ0vZCgtUZMCJas2cnYrUOoS+p9sa3hGMNFK3dLQ4k2tZEmA1DB7Bp4TislymfIRdra
         8ZjzACO0FhMtJz7yXrcsO2KTXjrfIYnh9wytPCfWz+5Me1cBht3T9GkOKCvJByJ/DCb1
         ieJ4n6qrTUAx0zt1KX0hnbMu/7poGFOYUaUpITiiV1XCEFwBcRP78cLr9VPi8lxSixgb
         Y5XwGr5zEQr/G15P4IKDocncKy/nhkYvDSziaqEMn5ADqzDYn7PgQFUzz/FuvCxyJni0
         aAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hk9GCi+OwDFM8NtbnJNJU2KSnU6fknD2DtC3zfb/KO4=;
        b=MlKlwF0JUl065AJg4bG1kpd+/w/MrxGxe0zUMhy6N4VsUesNHraVS7StEATzvqkwAj
         Dm9km/HjrwDtBCwhRMNjX3K9qU015litTW62IWHROy8GNAg8k8AMnRYfKm0rZSIXnPt5
         9UxBc9fKLj/tS7j6GOUM6rLuyq18qXYXokJ1VbQxkWIxmh9bUBrKBZ7ZbwL4cuhG+zGj
         cblOcK03VmBeRkYvyhD4YmjIuvh47J0fD5KYg2ymQzHMjIQ8/ogR60fp0pn6zue10WMv
         A54NBqmcTInQt2sXq9K9A1x/KxtCHGdZdtJFDXwpsJjwzXWsO/rZR+c7KJtbCDK6ykFp
         3qSw==
X-Gm-Message-State: AOAM5305H/dUFHM5IU0Blx48CSpIntz0PtZcLN+9HCMBeZVnxccB1m4h
	G5+In8zr4Q3qXt0z5B5PDBPYqg==
X-Google-Smtp-Source: ABdhPJxtp9aYVthuPv0wI4cM7/pqTEdRBLyiZICfT3IGitk/1ylaT9B9/ShOC9P/maO0itI/mH/veA==
X-Received: by 2002:a63:789:: with SMTP id 131mr2312141pgh.182.1614246313301;
        Thu, 25 Feb 2021 01:45:13 -0800 (PST)
Received: from localhost ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id v16sm5160432pfu.76.2021.02.25.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:45:11 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: QI Fuli <qi.fuli@fujitsu.com>, linux-nvdimm@lists.01.org
Subject: Re: [ndctl PATCH] ndctl/test: add checking the presence of jq
 command ahead
In-Reply-To: <20210203132108.6246-1-qi.fuli@fujitsu.com>
References: <20210203132108.6246-1-qi.fuli@fujitsu.com>
Date: Thu, 25 Feb 2021 15:15:08 +0530
Message-ID: <87ft1keb17.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: BRCEUJRSEP23VHWNGLCX2R7GJAZAFIXQ
X-Message-ID-Hash: BRCEUJRSEP23VHWNGLCX2R7GJAZAFIXQ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: QI Fuli <qi.fuli@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BRCEUJRSEP23VHWNGLCX2R7GJAZAFIXQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi QI,

QI Fuli <qi.fuli@fujitsu.com> writes:

> Due to the lack of jq command, the result of the test will be 'fail'.
> This patch adds checking the presence of jq commmand ahead.
> If there is no jq command in the system, the test will be marked as 'skip'.
>
> Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
> Link: https://github.com/pmem/ndctl/issues/141

Could this dependency be made part of configure.ac? Something like

diff --git a/configure.ac b/configure.ac
index 5ec8d2f..0f2c6c1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -65,6 +65,13 @@ fi
 AC_SUBST([XMLTO])
 fi
 
+AC_CHECK_PROG(JQ, [jq], [$(which jq)], [missing])
+if test "x$JQ" = xmissing; then
+       AC_MSG_ERROR([jq needed to validate tests])
+fi
+AC_SUBST([JQ])
+
+
 AC_C_TYPEOF
 AC_DEFINE([HAVE_STATEMENT_EXPR], 1, [Define to 1 if you have statement expressions.])

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
