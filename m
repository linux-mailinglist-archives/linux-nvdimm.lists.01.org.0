Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4822B189270
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Mar 2020 01:09:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E2261003E9BE;
	Tue, 17 Mar 2020 17:10:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 391541007A83C
	for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 17:10:02 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e19so2658744otj.7
        for <linux-nvdimm@lists.01.org>; Tue, 17 Mar 2020 17:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMwlQkIOIiahCzdJMcDAgkZw1PXO1TaHhQC1hHdlF40=;
        b=kGZyZEGu+kcB3XdOaTAZJM+rbcvTBpICmBPRE18yX/9MJPS66Ytxd7Gm3O3/3Lz55Q
         uFACPo9wGPnI6eO+iUQifq8oVaWyWo0VgR6LIsQdBzIMGZ/wsKCnDqZ/x6TolZxAyg1I
         FJt12qoJReN6PNsY1GOL3OhVCI7MHxaHFRL08jfk4efZyQHKo/X/2ZLHpiq65IrXN3gK
         CSV+tleFFwhhErVV3TFP0znqCHU1QEI/RoTHD38gDLk0At7DJutddsiqKB66BpLTriWO
         uPBtm0hIrgWWUQzC0YsHjdwX6Uk4pe8Z4vLovjAgJJKP8+tW3eLI3j7ZR73xujJ0Sx17
         dojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMwlQkIOIiahCzdJMcDAgkZw1PXO1TaHhQC1hHdlF40=;
        b=Z7jnC5dV/qHNzoem3KwLGdWuS0PFWNGj5p2s02SvKpWCq/wu+7NSKYitIaZIzoQn45
         wsBw1Oed9By23ta5nvRrc0Fsmdy/Rg8KtJepkIXqvw31/33nb5S29QEQc3qAj9aCmWxQ
         h5e2N/sGbrNP4hCNvXdOQ0GU6xQ9mory6Q/fkUBSSL81QLcA2wkE5c+G6JhCyzHQJM0q
         Kj8H6f1tTgqYquw3O42JIhR6WHbGXMgZ7mxJvoi3YcFuQmD8xOzgnX3MhtjpfgpU/NCM
         s6nFj46n+zuDDBdV4PFmgtrziGknUQS3FFxVzZkEMDBkmRr+fxwNdPUNXZEB/RLTBRmt
         sVlg==
X-Gm-Message-State: ANhLgQ2ggANBlVLzNdUrVDKk5lyA98D2Dxd7SnL9TWXXB8QQNqg1k/UI
	DjyRAeNYXET6eNJE2kHAoZfNeCg7SqIlm1YD9H185Q==
X-Google-Smtp-Source: ADFU+vvXy+eUUC+1ujXuIzLpqPYdUPYM4SLDYMYNliIhG5QA4cIByJRT9LCJJcYo4J8eRLDL8+WNi4hE85ZKjbdciSI=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr1641568otn.126.1584490149519;
 Tue, 17 Mar 2020 17:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Mar 2020 17:08:58 -0700
Message-ID: <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To: Linux ACPI <linux-acpi@vger.kernel.org>
Message-ID-Hash: GDKZTHWNMQXCPZOLRCGKIE26HRRRCHLH
X-Message-ID-Hash: GDKZTHWNMQXCPZOLRCGKIE26HRRRCHLH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: X86 ML <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GDKZTHWNMQXCPZOLRCGKIE26HRRRCHLH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Disable parsing of the HMAT for debug, to workaround broken platform
> instances, or cases where it is otherwise not wanted.

Rafael, any heartburn with this change to the numa= option?

...as I look at this I realize I failed to also update
Documentation/x86/x86_64/boot-options.rst, will fix.

>
> Cc: x86@kernel.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/numa.c       |    4 ++++
>  drivers/acpi/numa/hmat.c |    3 ++-
>  include/acpi/acpi_numa.h |    1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 59ba008504dc..22de2e2610c1 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
>  #ifdef CONFIG_ACPI_NUMA
>         if (!strncmp(opt, "noacpi", 6))
>                 acpi_numa = -1;
> +#ifdef CONFIG_ACPI_HMAT
> +       if (!strncmp(opt, "nohmat", 6))
> +               hmat_disable = 1;
> +#endif
>  #endif
>         return 0;
>  }
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..d3db121e393a 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -26,6 +26,7 @@
>  #include <linux/sysfs.h>
>
>  static u8 hmat_revision;
> +int hmat_disable __initdata;
>
>  static LIST_HEAD(targets);
>  static LIST_HEAD(initiators);
> @@ -814,7 +815,7 @@ static __init int hmat_init(void)
>         enum acpi_hmat_type i;
>         acpi_status status;
>
> -       if (srat_disabled())
> +       if (srat_disabled() || hmat_disable)
>                 return 0;
>
>         status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index fdebcfc6c8df..48ca468e9b61 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -18,6 +18,7 @@ extern int node_to_pxm(int);
>  extern int acpi_map_pxm_to_node(int);
>  extern unsigned char acpi_srat_revision;
>  extern int acpi_numa __initdata;
> +extern int hmat_disable __initdata;
>
>  extern void bad_srat(void);
>  extern int srat_disabled(void);
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
