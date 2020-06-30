Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E420EB1E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 03:52:51 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A579A11202ACB;
	Mon, 29 Jun 2020 18:52:49 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED715111FF49A
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:52:46 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so5671737edr.5
        for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 18:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSu0Ell6P0MrB/9DAeZ/V2BO5gb+7FgIDWCLlMlaRYs=;
        b=ohq8OaI0k2AvszzjZB4BBqCWu+OfyYpDsZhWDlOEvIfKLBxTpuNAs3yIo6dwUSDjCz
         drPEeQf/qaDJSd9w3sQJndOcce3Yp0tBgA7DOvHIme/mb0yw8pbcDlilpq/OIZaRJCs4
         fqYYSneC3SuUKToqogPMSJg0BZLa2vY/47ULwen6yESRrXbgcIXdhUsRghofEv18JWJ2
         wBToktCV1X8nNUmMm9sjvYW9s3oYKGNSvJHt7R63lE79gRYmgC8WvAQnRBhX1N8xp/1h
         84jQ4TleWhRVZOaiXBMN81mNw4hTanSrK3X4QByY760QchmuwKBm3/ERzFEwHpxMkPWw
         NcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSu0Ell6P0MrB/9DAeZ/V2BO5gb+7FgIDWCLlMlaRYs=;
        b=i9nvbRdcvXp5FUrtBIoS6uiKzS4zioVIphuWsgYdAtvG4QuFoED65FCudpi4e/lhbx
         1EPEnguay1xZhQ8MP39LCb9FQ8wSy2dhwplvuO9OIs1NUid1Tymo223suBV9uAtbOF3l
         G5IgrR/5Ps0YzeK6S7IUoQq5qWlALLXC77m/YEa/r/U0IYZF8AUhQ1xPvkch9yZmjfyt
         Lg2SWVSMakCjBASXqdjo3QZ5wNsfcLRKwf3ufhVfTVcVD6AT0c/ZZyBx8wO8G8ZRnXht
         QLfFcuDB9IuKnpIS19G50BY+8Kb3WzVhG7q/uiXoUyKfSNgGxPR5WmiMlM1oenxdVxRg
         26bg==
X-Gm-Message-State: AOAM530Bzn0/r3C63lPYV0xkCX4p3svpJDS4tvuXTFtXOTOa5Q0+bcse
	9aJbOoPlZWmX0GnWfp1gPPBzw9k8On+gH3XnS1FiJioS
X-Google-Smtp-Source: ABdhPJxTK5XbT/DoIEjaMHdgVN+m2sGq+xniwDyaWvWCE6GNjQRyUH9oHCWmF4Dkteb1EWY4bbVaEaxayjiZqufomLo=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr21541325edo.123.1593481965462;
 Mon, 29 Jun 2020 18:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com> <20200629135722.73558-8-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200629135722.73558-8-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jun 2020 18:52:34 -0700
Message-ID: <CAPcyv4giMdgjNVudw1q7p-UpyLMTHTqTad=2Ks8ATNo==edKvQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] powerpc/pmem: Add WARN_ONCE to catch the wrong
 usage of pmem flush functions.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: INKB3M35R5QVI6M5OQP6M3DZDPZJJPVN
X-Message-ID-Hash: INKB3M35R5QVI6M5OQP6M3DZDPZJJPVN
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/INKB3M35R5QVI6M5OQP6M3DZDPZJJPVN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jun 29, 2020 at 6:58 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> We only support persistent memory on P8 and above. This is enforced by the
> firmware and further checked on virtualzied platform during platform init.
> Add WARN_ONCE in pmem flush routines to catch the wrong usage of these.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h | 2 ++
>  arch/powerpc/lib/pmem.c               | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
> index 95782f77d768..1ab0fa660497 100644
> --- a/arch/powerpc/include/asm/cacheflush.h
> +++ b/arch/powerpc/include/asm/cacheflush.h
> @@ -103,6 +103,8 @@ static inline void  arch_pmem_flush_barrier(void)
>  {
>         if (cpu_has_feature(CPU_FTR_ARCH_207S))
>                 asm volatile(PPC_PHWSYNC ::: "memory");
> +       else
> +               WARN_ONCE(1, "Using pmem flush on older hardware.");

This seems too late to be making this determination. I'd expect the
driver to fail to successfully bind default if this constraint is not
met.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
