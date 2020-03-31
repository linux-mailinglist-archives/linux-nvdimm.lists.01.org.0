Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A019A0ED
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 23:38:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CFAE10FC38A0;
	Tue, 31 Mar 2020 14:38:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DF4310FC36EA
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 14:38:54 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w26so27098383edu.7
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/S6mKyvK/9h9eec5jGC1hT/GCbR11EkaitnfXiq39U=;
        b=IJHWSXws99YhEHheHI5kRV8NLqU6W6/5tz8Uipf33E9JQ1iKRzKa3LpDQ2PW05y1Xe
         rSVfw66Gd9e2RTq83J2AuxUNWXR1r83mTX1DB+aps66pn3fGTruX+jVTFFQj1+gxlZel
         9+98cXExS5hqdjnC/hwXaSVewhiqR/VQaQU4/e+0dvapQ5dBdsX41CfSGuwqU91yfsBz
         vjJU164qQSVP/zu06VZdwSXdWBJfpTvcDRp4Id0ocxGg8XD7UsL2m0qiq2NdXIuQcQZG
         4rFxFin0ebvl7JOT1EUo+fYODHDLDYu1kIfSPwOJ/BNrUvwwNS4ivB88r8IAvuiM7eLi
         N1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/S6mKyvK/9h9eec5jGC1hT/GCbR11EkaitnfXiq39U=;
        b=F3JjwqhbfGFfFyiF2+UN7kFfSK4DnvsC7FmxpJ0oR/MBBiZavcQM0b0XTTQqrmviEY
         MMBFLpwy7M2kp8sG+xjEaxXJcs5sYkvPm0RQZJ/xgEdLpyYJhoWwXpG5U+WlZpomI6+L
         BFr6FC3ppMxxUWcZcZOcngkqLS/rIKy7TT4FRKInHxCO4ArcE8aZZH6k2xFv05UOhYPw
         VFyLruS+Do2jxlePpbaFlR6eDq6WYUiqREuT1MEQppzMcxvJ71Xsc7hH5/M/NmLqpr6i
         E/A4x4UsL44AA/4eOSeiGpE1oPZpR98i6mCp7cN71lOJs+HLMi0TrfMpMy+J+LuNMDI6
         YP+A==
X-Gm-Message-State: ANhLgQ0/WewayilsSqAO2D3J/Hsh3otbBYY4bqmik/KELIRlZx59idXn
	fessLEzzZy+ihM8nBirjVie3teyn+67W3vJ9yT+/Xg==
X-Google-Smtp-Source: ADFU+vtySOXZOcJqcg/5FIQUydOo+YFpr2bWXtHsUgzLWBkS96QXJ4PMaKC5awNcgr4FWwIwB7hRuxNNcLTQPD2NtKc=
X-Received: by 2002:aa7:c609:: with SMTP id h9mr17634840edq.93.1585690682636;
 Tue, 31 Mar 2020 14:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200114054051.4115790-1-santosh@fossix.org>
In-Reply-To: <20200114054051.4115790-1-santosh@fossix.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 14:37:47 -0700
Message-ID: <CAPcyv4gPmr0qTfnW3OX+79os+BGO5VczuhBoT6eRd+8XHvEBfQ@mail.gmail.com>
Subject: Re: [PATCH] tools/test/nvdimm: Fix out of tree build
To: Santosh Sivaraj <santosh@fossix.org>
Message-ID-Hash: ZDJYCDH7AO4EBVAMIQOMX63NT5TL6WZU
X-Message-ID-Hash: ZDJYCDH7AO4EBVAMIQOMX63NT5TL6WZU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDJYCDH7AO4EBVAMIQOMX63NT5TL6WZU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jan 13, 2020 at 9:41 PM Santosh Sivaraj <santosh@fossix.org> wrote:
>
> Out of tree build using
>
>    make M=tools/test/nvdimm O=/tmp/build -C /tmp/build
>
> fails with the following error
>
> make: Entering directory '/tmp/build'
>   CC [M]  tools/testing/nvdimm/test/nfit.o
> linux/tools/testing/nvdimm/test/nfit.c:19:10: fatal error: nd-core.h: No such file or directory
>    19 | #include <nd-core.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
>
> That is because the kbuild file uses $(src) which points to
> tools/testing/nvdimm, $(srctree) correctly points to root of the linux
> source tree.

Looks good to me, applied.

>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> ---
>  tools/testing/nvdimm/Kbuild      | 4 ++--
>  tools/testing/nvdimm/test/Kbuild | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
> index 6aca8d5be159..0615fa3d9f7e 100644
> --- a/tools/testing/nvdimm/Kbuild
> +++ b/tools/testing/nvdimm/Kbuild
> @@ -22,8 +22,8 @@ DRIVERS := ../../../drivers
>  NVDIMM_SRC := $(DRIVERS)/nvdimm
>  ACPI_SRC := $(DRIVERS)/acpi/nfit
>  DAX_SRC := $(DRIVERS)/dax
> -ccflags-y := -I$(src)/$(NVDIMM_SRC)/
> -ccflags-y += -I$(src)/$(ACPI_SRC)/
> +ccflags-y := -I$(srctree)/drivers/nvdimm/
> +ccflags-y += -I$(srctree)/drivers/acpi/nfit/
>
>  obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
>  obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
> diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
> index fb3c3d7cdb9b..75baebf8f4ba 100644
> --- a/tools/testing/nvdimm/test/Kbuild
> +++ b/tools/testing/nvdimm/test/Kbuild
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -I$(src)/../../../../drivers/nvdimm/
> -ccflags-y += -I$(src)/../../../../drivers/acpi/nfit/
> +ccflags-y := -I$(srctree)/drivers/nvdimm/
> +ccflags-y += -I$(srctree)/drivers/acpi/nfit/
>
>  obj-m += nfit_test.o
>  obj-m += nfit_test_iomap.o
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
