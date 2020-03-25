Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B65192510
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Mar 2020 11:05:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F63010FC36C4;
	Wed, 25 Mar 2020 03:06:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.193; helo=mail-oi1-f193.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 07F4810FC3603
	for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 03:06:38 -0700 (PDT)
Received: by mail-oi1-f193.google.com with SMTP id v134so1518085oie.11
        for <linux-nvdimm@lists.01.org>; Wed, 25 Mar 2020 03:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kx6zWzWlFb2q6tLbIGNUJ4/Vt+PrSLq5ud8xhYBRhgA=;
        b=uQnu6E5lRKcuKmGDDVzlSkpCiTSygPTgUi9G0x5FczfkPtndeNsIDk8drzBPuKt1C3
         g9fXY6dvQwt/WSDmcfFOUGQxeKz0CXg9Tc/9UHxhCcCz8w6DOhTP435F+9EOWvFsQTjx
         F7rBVztVVKZBjxggXAzPsgFNUQcZoIU066Qxxd2xfZEugh7UvKKO7B4wmNs0WaHloyhG
         VE7Ma3OEVN9rLHxtHaC9cJDe/+DCOHat80aWpt1GJVnzK2HimieQJXzubXo1U2b0qTkv
         9Y8O7CB3UMObnzAgHbbUlInliZaAPZJPfwMOTwJhMTotJIb34tLp5QW41Laoe4GBDBJr
         rYfQ==
X-Gm-Message-State: ANhLgQ2PWdCiqycATF6TCApUTPmbXreLlJnGmjyrwBE/TCHEP9c+h4RE
	dKJuKV5C87QW4wY02Ju4KEKnuIA5j1yzM1Z9Nbc=
X-Google-Smtp-Source: ADFU+vtOyDIGXvu5ZBYH6gJK0sVQRrbQ385r2m1A6DOdRsKzFm55S1la0Vnjw3U5JFdGNrLljxf66cKaHUbGIpXYluQ=
X-Received: by 2002:aca:f07:: with SMTP id 7mr215666oip.68.1585130747875; Wed,
 25 Mar 2020 03:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200319195046.GA452@embeddedor.com>
In-Reply-To: <20200319195046.GA452@embeddedor.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 25 Mar 2020 11:05:36 +0100
Message-ID: <CAJZ5v0iDVL1WWTmmQX+2JDmyAfu2e8nSdLSmCqA-WZV+7pBHvw@mail.gmail.com>
Subject: Re: [PATCH][next] acpi: nfit.h: Replace zero-length array with
 flexible-array member
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: P27KFE6ONRB6YNRGN5CAKMRN4BIUZRHD
X-Message-ID-Hash: P27KFE6ONRB6YNRGN5CAKMRN4BIUZRHD
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P27KFE6ONRB6YNRGN5CAKMRN4BIUZRHD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 19, 2020 at 9:15 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Dan,

I'm assuming that you will take care of this one or please let me know
otherwise.

Cheers!

> ---
>  drivers/acpi/nfit/nfit.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
> index 24241941181c..af09143ce403 100644
> --- a/drivers/acpi/nfit/nfit.h
> +++ b/drivers/acpi/nfit/nfit.h
> @@ -144,32 +144,32 @@ struct nfit_spa {
>         unsigned long ars_state;
>         u32 clear_err_unit;
>         u32 max_ars;
> -       struct acpi_nfit_system_address spa[0];
> +       struct acpi_nfit_system_address spa[];
>  };
>
>  struct nfit_dcr {
>         struct list_head list;
> -       struct acpi_nfit_control_region dcr[0];
> +       struct acpi_nfit_control_region dcr[];
>  };
>
>  struct nfit_bdw {
>         struct list_head list;
> -       struct acpi_nfit_data_region bdw[0];
> +       struct acpi_nfit_data_region bdw[];
>  };
>
>  struct nfit_idt {
>         struct list_head list;
> -       struct acpi_nfit_interleave idt[0];
> +       struct acpi_nfit_interleave idt[];
>  };
>
>  struct nfit_flush {
>         struct list_head list;
> -       struct acpi_nfit_flush_address flush[0];
> +       struct acpi_nfit_flush_address flush[];
>  };
>
>  struct nfit_memdev {
>         struct list_head list;
> -       struct acpi_nfit_memory_map memdev[0];
> +       struct acpi_nfit_memory_map memdev[];
>  };
>
>  enum nfit_mem_flags {
> --
> 2.23.0
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
