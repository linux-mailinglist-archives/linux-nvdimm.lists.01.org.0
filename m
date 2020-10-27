Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBCC29C750
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Oct 2020 19:36:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9122C163D0220;
	Tue, 27 Oct 2020 11:36:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.167.195; helo=mail-oi1-f195.google.com; envelope-from=rjwysocki@gmail.com; receiver=<UNKNOWN> 
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDC6115CEE863
	for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 11:36:42 -0700 (PDT)
Received: by mail-oi1-f195.google.com with SMTP id f7so2317990oib.4
        for <linux-nvdimm@lists.01.org>; Tue, 27 Oct 2020 11:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWdnhay9ksmoARjhatTo1pVZzo/6EFH15ny3nNorPU8=;
        b=gNVOvcgHX+VHl+LzoQISZpt7ufggwPKH0fbptI5ukIEGpaQz9ckmc4POABJSYXFf2v
         8YptcQ1j+3/rcIXlA6qebnGNHvQKROgPWqJMo9FAzPPDwrS4GGw/wdCQcUC0zU0M+Iuh
         bvkPB2mOP9lSx3sIXUcSD32kKKrzcI1HEGe5D0nJaB4vMTntySBm295Xh4ghtpvWdEJx
         kN4sbIE5A2TzXC3SXaOA5qgnGrW7i38pG+zWpdHWDAW6m5bswVRsdIg18e6vT5tkD53o
         EwLbkw1wx+fonl8tJxHcmYCdaA9AN8KFaiipVsDtbioMVy8SDxVE7lhUDv8FHPQJccr7
         Aw8A==
X-Gm-Message-State: AOAM533V4Uv96YkoP+VaRZZlLuiSXJD/HnzRBKAbThqwqArKbzOTHdhd
	ok582K1nLuFWIq77EXNwz3poVp3zXGrVRIO1TMM=
X-Google-Smtp-Source: ABdhPJxMshyIWwUFtCfpHhd0rCICdS32Siqi1C1V11Yq4I6sSvbYKxzM8LKTPfweSPljLTEYrlA5UEbMvMd0aFCpA48=
X-Received: by 2002:aca:4c86:: with SMTP id z128mr2484538oia.71.1603823801932;
 Tue, 27 Oct 2020 11:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201027134901.65045-1-zhangqilong3@huawei.com>
In-Reply-To: <20201027134901.65045-1-zhangqilong3@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Oct 2020 19:36:30 +0100
Message-ID: <CAJZ5v0iNTV5p3UF+wXL8bTpb0C+hV4iQ1XiM_p_R+C=c6dKcYw@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: NFIT: Fix judgment of rc is '-ENXIO'
To: Zhang Qilong <zhangqilong3@huawei.com>
Message-ID-Hash: JYJU6V3YJX75IWK6CERQURQSNAEZMH3G
X-Message-ID-Hash: JYJU6V3YJX75IWK6CERQURQSNAEZMH3G
X-MailFrom: rjwysocki@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JYJU6V3YJX75IWK6CERQURQSNAEZMH3G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Oct 27, 2020 at 2:38 PM Zhang Qilong <zhangqilong3@huawei.com> wrote:
>
> Initial value of rc is '-ENXIO', and we should
> use the initial value to check it.
>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 756227837b3b..3a3c209ed3d3 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
>                                         le16_to_cpu(nfit_dcr->dcr->code));
>                         break;
>                 }
> -               if (rc != ENXIO)
> +               if (rc != -ENXIO)
>                         break;
>         }
>         mutex_unlock(&acpi_desc->init_mutex);
> --

Applied as 5.10-rc material with a subject edit, thanks!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
