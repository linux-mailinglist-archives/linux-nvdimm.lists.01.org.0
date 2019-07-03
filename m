Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCC55E29C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 13:10:05 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84A7E212ACEB4;
	Wed,  3 Jul 2019 04:10:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 147C72194EB7B
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 04:10:00 -0700 (PDT)
Received: by mail-ot1-f65.google.com with SMTP id r6so1926387oti.3
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 04:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3l/bO62w26zXZAlUZYkV8q6eMPbcBKeEDraPxglT07M=;
 b=LC7JXwFA/CSdM+bMl+n4Vbkpmgf3uF2YdBy08Sy+W/gRffPIHka3ghyzIPJPfG0TRj
 CoDo3EDmlzInPmth78r0rx/Y7nlvGFifywfBiA75JiqfTkLskKwrEI6jYx7REHsptk32
 tB9muOFM88HfrcRnE5775usF0LeqGtr95lCO0hUQFHeNPGVWiQ4UqFrbEYMJmmRhLpfG
 4JSf/6i5I3eruEc2b+Y9Iwd9SLtdbyDVnm94UBVlLqy5nHTmc3mRJ+zkdh2kkxk4CH58
 YxiugWgSQZTDtFae1hzkMi8GqBzQAl+WO11jwshrPL9GVuwPUKlzMlUBKpS5k7N9vzFN
 BCdg==
X-Gm-Message-State: APjAAAVyGAPZfcYfhdKZGwCbUva9TLCbFiG6zDRFCqn9EKrBxNwnFCoV
 GbeR2YugznfMxrnFspXJ9tLBS1GlQkv7eiSI1rw=
X-Google-Smtp-Source: APXvYqyfmS6fsdItQl+DKVh+2Zs4EBjIM/eii732Yz1zcF7I/b7XZW8DBg+y9GBhSz8SDoqgZByKeQAQ9PuDzoY/RgM=
X-Received: by 2002:a05:6830:1516:: with SMTP id
 k22mr8592291otp.189.1562152199626; 
 Wed, 03 Jul 2019 04:09:59 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140037171.2951909.7432584124511649643.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2019 13:09:48 +0200
Message-ID: <CAJZ5v0jnV_Gw5QJ5kX1z+Aiz8DMswgkv76rdpNCo6FVtP_m5Rw@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] acpi/numa: Establish a new drivers/acpi/numa/
 directory
To: Dan Williams <dan.j.williams@intel.com>
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
Cc: the arch/x86 maintainers <x86@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 24, 2019 at 8:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Currently hmat.c lives under an "hmat" directory which does not enhance
> the description of the file. The initial motivation for giving hmat.c
> its own directory was to delineate it as mm functionality in contrast to
> ACPI device driver functionality.
>
> As ACPI continues to play an increasing role in conveying
> memory location and performance topology information to the OS take the
> opportunity to co-locate these NUMA relevant tables in a combined
> directory.
>
> numa.c is renamed to srat.c and moved to drivers/acpi/numa/ along with
> hmat.c.
>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/Kconfig       |    9 +--------
>  drivers/acpi/Makefile      |    3 +--
>  drivers/acpi/hmat/Makefile |    2 --
>  drivers/acpi/numa/Kconfig  |    7 ++++++-
>  drivers/acpi/numa/Makefile |    3 +++
>  drivers/acpi/numa/hmat.c   |    0
>  drivers/acpi/numa/srat.c   |    0
>  7 files changed, 11 insertions(+), 13 deletions(-)
>  delete mode 100644 drivers/acpi/hmat/Makefile
>  rename drivers/acpi/{hmat/Kconfig => numa/Kconfig} (72%)
>  create mode 100644 drivers/acpi/numa/Makefile
>  rename drivers/acpi/{hmat/hmat.c => numa/hmat.c} (100%)
>  rename drivers/acpi/{numa.c => numa/srat.c} (100%)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 283ee94224c6..82c4a31c8701 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -321,12 +321,6 @@ config ACPI_THERMAL
>           To compile this driver as a module, choose M here:
>           the module will be called thermal.
>
> -config ACPI_NUMA
> -       bool "NUMA support"
> -       depends on NUMA
> -       depends on (X86 || IA64 || ARM64)
> -       default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
> -
>  config ACPI_CUSTOM_DSDT_FILE
>         string "Custom DSDT Table file to include"
>         default ""
> @@ -475,8 +469,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
>           If you are unsure what to do, do not enable this option.
>
>  source "drivers/acpi/nfit/Kconfig"
> -source "drivers/acpi/hmat/Kconfig"
> -
> +source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 5d361e4e3405..f08a661274e8 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -55,7 +55,6 @@ acpi-$(CONFIG_X86)            += acpi_cmos_rtc.o
>  acpi-$(CONFIG_X86)             += x86/apple.o
>  acpi-$(CONFIG_X86)             += x86/utils.o
>  acpi-$(CONFIG_DEBUG_FS)                += debugfs.o
> -acpi-$(CONFIG_ACPI_NUMA)       += numa.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y                         += acpi_lpat.o
>  acpi-$(CONFIG_ACPI_LPIT)       += acpi_lpit.o
> @@ -80,7 +79,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)  += processor.o
>  obj-$(CONFIG_ACPI)             += container.o
>  obj-$(CONFIG_ACPI_THERMAL)     += thermal.o
>  obj-$(CONFIG_ACPI_NFIT)                += nfit/
> -obj-$(CONFIG_ACPI_HMAT)                += hmat/
> +obj-$(CONFIG_ACPI_NUMA)                += numa/
>  obj-$(CONFIG_ACPI)             += acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     += battery.o
> diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
> deleted file mode 100644
> index 1c20ef36a385..000000000000
> --- a/drivers/acpi/hmat/Makefile
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_ACPI_HMAT) := hmat.o
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/numa/Kconfig
> similarity index 72%
> rename from drivers/acpi/hmat/Kconfig
> rename to drivers/acpi/numa/Kconfig
> index 95a29964dbea..d14582387ed0 100644
> --- a/drivers/acpi/hmat/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,4 +1,9 @@
> -# SPDX-License-Identifier: GPL-2.0
> +config ACPI_NUMA
> +       bool "NUMA support"
> +       depends on NUMA
> +       depends on (X86 || IA64 || ARM64)
> +       default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
> +
>  config ACPI_HMAT
>         bool "ACPI Heterogeneous Memory Attribute Table Support"
>         depends on ACPI_NUMA
> diff --git a/drivers/acpi/numa/Makefile b/drivers/acpi/numa/Makefile
> new file mode 100644
> index 000000000000..517a6c689a94
> --- /dev/null
> +++ b/drivers/acpi/numa/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_NUMA) += srat.o
> +obj-$(CONFIG_ACPI_HMAT) += hmat.o
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/numa/hmat.c
> similarity index 100%
> rename from drivers/acpi/hmat/hmat.c
> rename to drivers/acpi/numa/hmat.c
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa/srat.c
> similarity index 100%
> rename from drivers/acpi/numa.c
> rename to drivers/acpi/numa/srat.c
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
