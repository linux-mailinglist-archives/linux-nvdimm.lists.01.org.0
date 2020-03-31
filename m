Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCB819A188
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 00:00:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 67FAB10FC38BB;
	Tue, 31 Mar 2020 15:01:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4819C10FC38A0
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 15:01:22 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id bd14so27135208edb.10
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 15:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojxiAu/FCFqTkzhngt9HlaCcT6MN2axphIIDAEYdjhY=;
        b=DXp73Kre0WHHcaFNScLALczu3lu1R/hzFk0USqMn4cc2gxSbLb6LTkMotSPbhIEKCz
         2o1ZvmlDMiKXISpDTC38wGvnw8IfJPuBeQ8qifTkUI/NZKWz+cN81qbGkurvGQkjo9J4
         hJGVmK6UzHZdxhhxziVTm6kCc+kdOwYgU97PP4Dw3cd5TESj8jHwSpujx1oBmZQymooi
         glX4lX/Sl+u2rov186UsowzRBSiiyq9k/Hl1sbi6G363t0U2mgkQOXTPOyVNc4ZRIw1J
         r+ZFkLSsMiHfl1hJF2G2KUcK/reeM6GPsCdDkWMDupJNb/NhicYj43azNT2R6qLBdJJ1
         mHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojxiAu/FCFqTkzhngt9HlaCcT6MN2axphIIDAEYdjhY=;
        b=nrLQjycr0sk+B4MbZh3oRVu4qkrTqXQjwqrHN/w5SSghuQd2JEM2Efhg+tbg2ve7un
         qtWaG7zLSXwh2eHZhgvsjml4I4CohKbw6UKYjs8/0CNXnb5cJkLDOuOPr9R/wBtFptLW
         GBn/GGFiSP0je62EO3W4SNW2MK0cDGFMkiJBY2ejFLYl0E9a137L6dRLqoRVir1PZS9H
         UN3vvbU+c9fCFY8rMzVbOmL3jm4U1IxqCA4qkfyNdIxp/hUq5fuGXJyvtGmnD2S+j/6t
         575dlndqKduXgLbLhwqESSEIWGrdcE3W0tX8XztzGjlIbeV7XFVtAJT3FUzp2feZOnUD
         vPKw==
X-Gm-Message-State: ANhLgQ03xg0ABelP7mei2uNiOb9NfLmIHZacgnnNuH3WaGjD826ViQwr
	XNnYXcpd+czfApclZyXhCY+kcUCfo9z+zTi9lbRODDie
X-Google-Smtp-Source: ADFU+vtXo5KE+mKAumYJmyeiBk8BYhL5REQSACSWtKMDiNqEgJ4HuDD2zNKhq6fioeCx5GzslCdUnfB/hUheuOueB90=
X-Received: by 2002:a17:906:dbd4:: with SMTP id yc20mr17302602ejb.335.1585692030849;
 Tue, 31 Mar 2020 15:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200324034821.60869-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200324034821.60869-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 15:00:19 -0700
Message-ID: <CAPcyv4gwnAqxA4naKD0BLfj6Qmcw5J0WhAmvvgKOszk68ZfjFg@mail.gmail.com>
Subject: Re: [PATCH v3] libnvdimm: Update persistence domain value for of_pmem
 and papr_scm device
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: IF2YG3J6LNFWBA4OFZNH5CVQ2ZWHCD3X
X-Message-ID-Hash: IF2YG3J6LNFWBA4OFZNH5CVQ2ZWHCD3X
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IF2YG3J6LNFWBA4OFZNH5CVQ2ZWHCD3X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 23, 2020 at 8:48 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Currently, kernel shows the below values
>         "persistence_domain":"cpu_cache"
>         "persistence_domain":"memory_controller"
>         "persistence_domain":"unknown"
>
> "cpu_cache" indicates no extra instructions is needed to ensure the persistence
> of data in the pmem media on power failure.
>
> "memory_controller" indicates cpu cache flush instructions are required to flush
> the data. Platform provides mechanisms to automatically flush outstanding
> write data from memory controler to pmem on system power loss.
>
> Based on the above use memory_controller for non volatile regions on ppc64.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from V1:
> * update commit message and retain ADR details in comment

Looks good to me, applied.

>
>  arch/powerpc/platforms/pseries/papr_scm.c | 4 +++-
>  drivers/nvdimm/of_pmem.c                  | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 0b4467e378e5..922a4fc3b61b 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -361,8 +361,10 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>
>         if (p->is_volatile)
>                 p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
> -       else
> +       else {
> +               set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>                 p->region = nvdimm_pmem_region_create(p->bus, &ndr_desc);
> +       }
>         if (!p->region) {
>                 dev_err(dev, "Error registering region %pR from %pOF\n",
>                                 ndr_desc.res, p->dn);
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..6826a274a1f1 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -62,8 +62,10 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>
>                 if (is_volatile)
>                         region = nvdimm_volatile_region_create(bus, &ndr_desc);
> -               else
> +               else {
> +                       set_bit(ND_REGION_PERSIST_MEMCTRL, &ndr_desc.flags);
>                         region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +               }
>
>                 if (!region)
>                         dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> --
> 2.25.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
