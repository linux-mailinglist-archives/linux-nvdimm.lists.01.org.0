Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3630C19B6EC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 22:27:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C78010FC4031;
	Wed,  1 Apr 2020 13:28:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEC1810FC402E
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 13:27:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i16so1440482edy.11
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6qcM856obImsvuT5rUIEhvwVnK1DhMJt2Id7uvyK5Q=;
        b=Y3vyS0+7xmMlD2o1DE1joAP9And7I2d2qjY0yOuvGnXvyW98YWzWm7aa6SSnMW9fGv
         xmbCsUf8tHEs1igbgJL3MR2/QQ9CQsbFnA6iygRiBg0Wr89wbN2oYs93y2m0+MLBc9j0
         XZRVztiCpXL+RZE2oEq1MFt12hQvmpIntSCzUl1th3RBpoByO2/Fu41HxaGtFIdOelv6
         Z8TUAwfBiHAzT9ov8b0OI473ujkzD9NlE3o2pCzmz/Z3D+q+HTGIcrnaSwtBrsELjwyT
         RifPDZRqTf60vamEdkpnnVKHQZJPAHKj5NeFxs8bRaNtVcgXRIYIiN2JEGUUS+w9tUY6
         z8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6qcM856obImsvuT5rUIEhvwVnK1DhMJt2Id7uvyK5Q=;
        b=rx/RQhDXq+qX/PDvh+uGecRl5eHej2O5IHpV2Uca8XheRlwUIOuOo3SA/rMrpG1uK8
         vYvzMgKMPbwdSi6+DjvBWbxAqGf2d8CrKZPJcylcyR7ugo13qsCt4Iqcf6jnsVQv9drr
         N0aI7smQGauTtH4zkAQthnQ2Ejjcff7l2aMAAvgOhBVfSvMEA9FkOoTvH19GPUcGnUkt
         ruFT/U7/aSndrwR/6J6Z5E9aBqA7TLPVvcvzFR14sKLX7fMqqFZLzNlDAQTpwAPcch41
         JVZhUlvbIimWBmZ3gpzazZZ7xIdeUGCJFvHVO9vAjClLINjdP1CblguGo98dPR3KEDkO
         0JTA==
X-Gm-Message-State: ANhLgQ1Itj1AOJqz8G9VP+sb9i8fBoklWSZV6tGVlYHPk/YsIWC0dheN
	Hz0pj0UdGjYnhXlySGjQpSleKQuNhG4KIbFox1q3Cw==
X-Google-Smtp-Source: ADFU+vutl2hEQYOr7JEC/ZbBRPxrkS/63YVcKf/26iigKS0Nr226Yo7GAz0hCmuAa+otNRau6Kiz522Hbv7xnLvn8gw=
X-Received: by 2002:a50:d847:: with SMTP id v7mr22275521edj.154.1585772826833;
 Wed, 01 Apr 2020 13:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-12-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-12-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 13:26:55 -0700
Message-ID: <CAPcyv4gnU8t12V-mYXyxjb2+siej10xY-UVbxHxtCd8=28Yc6g@mail.gmail.com>
Subject: Re: [PATCH v4 11/25] powerpc: Enable the OpenCAPI Persistent Memory
 driver for powernv_defconfig
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: S2BWVA4PSUV5FMCDSOGG6D6ATC4LP4VF
X-Message-ID-Hash: S2BWVA4PSUV5FMCDSOGG6D6ATC4LP4VF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/S2BWVA4PSUV5FMCDSOGG6D6ATC4LP4VF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> This patch enables the OpenCAPI Persistent Memory driver, as well
> as DAX support, for the 'powernv' defconfig.
>
> DAX is not a strict requirement for the functioning of the driver, but it
> is likely that a user will want to create a DAX device on top of their
> persistent memory device.
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
> ---
>  arch/powerpc/configs/powernv_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index 71749377d164..921d77bbd3d2 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -348,3 +348,8 @@ CONFIG_KVM_BOOK3S_64=m
>  CONFIG_KVM_BOOK3S_64_HV=m
>  CONFIG_VHOST_NET=m
>  CONFIG_PRINTK_TIME=y
> +CONFIG_ZONE_DEVICE=y
> +CONFIG_OCXL_PMEM=m
> +CONFIG_DEV_DAX=m
> +CONFIG_DEV_DAX_PMEM=m
> +CONFIG_FS_DAX=y

These options have dependencies. I think it would better to implement
a top-level configuration question called something like
PERSISTENT_MEMORY_ALL that goes and selects all the bus providers and
infrastructure and lets other defaults follow along. For example,
CONFIG_DEV_DAX could grow a "default LIBNVDIMM" and then
CONFIG_DEV_DAX_PMEM would default on as well. If
CONFIG_PERSISTENT_MEMORY_ALL selected all the bus providers and
ZONE_DEVICE then the Kconfig system could prompt you to where the
dependencies are not satisfied.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
