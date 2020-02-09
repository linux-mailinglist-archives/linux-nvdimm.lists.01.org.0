Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B21156B50
	for <lists+linux-nvdimm@lfdr.de>; Sun,  9 Feb 2020 17:12:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D299310FC3173;
	Sun,  9 Feb 2020 08:15:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CDD4B1003EC45
	for <linux-nvdimm@lists.01.org>; Sun,  9 Feb 2020 08:15:52 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c16so6952642oic.3
        for <linux-nvdimm@lists.01.org>; Sun, 09 Feb 2020 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvMojplJbmxwO1iOJeURmK+oFSfZngPcvYQJtCKHfW8=;
        b=meAEp81qSJVz7dXt4UnLtZry9PtoQbUBOr3GJLAIh4q5m8drJxQZ4Oz+ZMA5ur4PUC
         UdPdIf23+nN+1egnGk9fUuGOgUTAt8iIUDfU6C1x9447AJt6qIQJrRrolp30PMIUXib1
         YJdPJEjgBFr4wXpJhf5X0cmk/kohH2hx2ChcQbAa5VVfFEQ60Up89qZpEzJu2g/5xDsK
         DoG44ea5PKfE6Yzr6PhaNcLC0lu7Rw5gew+hKlwSAlv3auEIBw7RhLbVGULmgSVOqJy7
         W+MlNa8J3WNhrFIy9Krgcr0kiBjk8Nt3EA7DlS/aKCaygpuRKK3pVQmBYHKZK2w+du5l
         4ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvMojplJbmxwO1iOJeURmK+oFSfZngPcvYQJtCKHfW8=;
        b=kKiDxL/haEWhOEuTwj4ryPLNDze84Q1CAWPdx08RvhN04HxO1q6TXLLKEy+hNsuhut
         2IHccwp3pmlLUODdWq13eC0QMFLf/qKfj/dNlljnaqBAMdKMBxFpAC5UypinNiZ64jls
         YhVFCvKCHZVZVf3fjslv4BOwNpXk7I2ofBt32XcL+Dv7eI/QkjxeAPRvLO/CXLbxYRf+
         8KYEZQTsztdROToreFpU7VZHxAYc/7RXbNjaDvHKQ8bNdUgVCZ1oNOs6ksU9MztDjDhV
         3g9goi8X5zcwE+EUOzyZYqmuW1eKiuKFHebsnOU1ZqQfMsBMAk7xZvhMU9s+atHMwAIN
         y3cA==
X-Gm-Message-State: APjAAAVhvaLDehhQD1qPgE+LKFso69/kENKNsYBA46EmZNa69fNceA4c
	AzzT2eCXAvLFEOTsa4RF9IJ7S0ec9Q79E7bPpgpLbA==
X-Google-Smtp-Source: APXvYqwyEPi/dOmLjoXvgsgsmTkdL5NLyztYKH9eYBnWSndT/W/QfwtIhs+bu1bO2GnpffymtYHL9+iyQAVJ8EJwt98=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr8576458oij.0.1581264754089;
 Sun, 09 Feb 2020 08:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 9 Feb 2020 08:12:22 -0800
Message-ID: <CAPcyv4hBAk-dwO4=AT7cQm5YUwCBg0AECsZsiCjRJ_ZGWvWUAw@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: Update persistence domain value for of_pmem
 and papr_scm device
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: HMUXFZRKZOUI4JSXUZO4WBYTZEY4LDVB
X-Message-ID-Hash: HMUXFZRKZOUI4JSXUZO4WBYTZEY4LDVB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HMUXFZRKZOUI4JSXUZO4WBYTZEY4LDVB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 4, 2020 at 9:21 PM Aneesh Kumar K.V
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
> "memory_controller" indicates platform provided instructions need to be issued

No, it does not. The only requirement implied by "memory_controller"
is global visibility outside the cpu cache. If there are special
instructions beyond that then it isn't persistent memory, at least not
pmem that is safe for dax. virtio-pmem is an example of pmem-like
memory that is not enabled for userspace flushing (MAP_SYNC disabled).

> as per documented sequence to make sure data get flushed so that it is
> guaranteed to be on pmem media in case of system power loss.
>
> Based on the above use memory_controller for non volatile regions on ppc64.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c | 7 ++++++-
>  drivers/nvdimm/of_pmem.c                  | 4 +++-
>  include/linux/libnvdimm.h                 | 1 -
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 7525635a8536..ffcd0d7a867c 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -359,8 +359,13 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>
>         if (p->is_volatile)
>                 p->region = nvdimm_volatile_region_create(p->bus, &ndr_desc);
> -       else
> +       else {
> +               /*
> +                * We need to flush things correctly to guarantee persistance
> +                */

There are never guarantees. If you're going to comment what does
software need to flush, and how?

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
> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
> index 0f366706b0aa..771d888a5ed7 100644
> --- a/include/linux/libnvdimm.h
> +++ b/include/linux/libnvdimm.h
> @@ -54,7 +54,6 @@ enum {
>         /*
>          * Platform provides mechanisms to automatically flush outstanding
>          * write data from memory controler to pmem on system power loss.
> -        * (ADR)

I'd rather not delete critical terminology for a developer / platform
owner to be able to consult documentation, or their vendor. Can you
instead add the PowerPC equivalent term for this capability? I.e. list
(x86: ADR PowerPC: foo ...).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
