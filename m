Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11661853D0
	for <lists+linux-nvdimm@lfdr.de>; Sat, 14 Mar 2020 02:21:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 20BC910FC36E4;
	Fri, 13 Mar 2020 18:22:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A752410FC3363
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 18:22:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id c144so6326716pfb.10
        for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 18:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=fjTjSXUTPxmhKb/gbbaGR/OvXETYgB9qnJBZykBuEHk=;
        b=V65RGzBW+IeTWu5NJDyA35IYArEjNBxFfw850IA/HZ7mBksKfV9wWMmHcJpQ8Na1s7
         vp0xXnPyxVWpGkY95PlODgUnKeNQJwQ8gRsdDYAKFg80TmywIASU39HTgve9KfOq8aEt
         OXEM4mJLFlJ4z/7H0GNnDE59fzO2N3EoqMzKKtMALFSMXnNO/zLpHbpK+Ra6H8zjXVtX
         2w8qyNSRoRvhxfU4wziiVD/hn1cGudFsMPjC1lMC0xdxT+aIhqPpQTmPxVXEDzmlKk+j
         WYeFiBgiOHK8BqwsIODMESxLzbyw4WvKcImobXRccHxMwlsflhqKsiPBTEtcXQrEfviB
         zXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fjTjSXUTPxmhKb/gbbaGR/OvXETYgB9qnJBZykBuEHk=;
        b=rRg2COMakRSnUAvSXCksd1fO14akltfdjaenurVQMk6zOdOBLaaYUJWJ+DzJ+n5DbA
         SywKbCVBi79CWRTEP+dZEIwAz1VI8wzHqO+EteCtL+DljquAbWf8Z3FxEV6noRlGfpJl
         FqZQYztV9rsmP1ueGjHNqr5CTABb6/+JbRgusjBGqjyzWIeLYX+0JfXsxHsPIdvOSM5o
         caomosKRYG3ch2T1u9PHWQEQtcYD9XSD6mXp9MF23GSInPKIonwzyhwCHWzvjaXdNuoE
         DfqygO3mULaidlCn2kK5En4e+GPHfDWjnOmWt4XnkiO7InvQ33FHC3LhqG8XvDGZMKQ2
         muLA==
X-Gm-Message-State: ANhLgQ3K3ccKpXp3bX0x5yq8QHI4rsu5vCgqyD/8Ana7ieIUbax7T3x8
	4RDja39+7O+ilbtbleDv7RgVadud1pM=
X-Google-Smtp-Source: ADFU+vsuZ1ZXIO875/31n4+qmjr6zBqC2VdgnKYR/4sw4SMGUhUhNWw5nplyXlACoAKO1F7fZLGuvQ==
X-Received: by 2002:a63:a06e:: with SMTP id u46mr15524375pgn.140.1584148889696;
        Fri, 13 Mar 2020 18:21:29 -0700 (PDT)
Received: from localhost ([111.125.192.41])
        by smtp.gmail.com with ESMTPSA id n22sm12568658pjq.36.2020.03.13.18.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 18:21:28 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] tools/test/nvdimm: Fix out of tree build
In-Reply-To: <20200114054051.4115790-1-santosh@fossix.org>
References: <20200114054051.4115790-1-santosh@fossix.org>
Date: Sat, 14 Mar 2020 06:51:26 +0530
Message-ID: <87d09fenop.fsf@santosiv.in.ibm.com>
MIME-Version: 1.0
Message-ID-Hash: UBFOZAVOTBIT473YBGPGVI4Z454EIRKR
X-Message-ID-Hash: UBFOZAVOTBIT473YBGPGVI4Z454EIRKR
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UBFOZAVOTBIT473YBGPGVI4Z454EIRKR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Dan,

Any comments on the below patch to fix builds that use KBUILD_OUT?

Thanks,
Santosh

Santosh Sivaraj <santosh@fossix.org> writes:

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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
