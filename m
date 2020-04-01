Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F5F19A7AB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Apr 2020 10:48:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B6EF010FC3BAA;
	Wed,  1 Apr 2020 01:49:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1FFC010FC377E
	for <linux-nvdimm@lists.01.org>; Wed,  1 Apr 2020 01:49:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a43so28677597edf.6
        for <linux-nvdimm@lists.01.org>; Wed, 01 Apr 2020 01:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtwLbCqmqvz42BIBfrvBd67JNfGvzVf9CtVg6xG0MDo=;
        b=1NQnvn8mdX9DuQU55yHb6kM7GOE2cZXTLfXFTFxLhUegcVz4S1+s3ZBa57yNaFgaL3
         Of91mzhfbjU3BHyMXm/x0yEhWTDO4TAOYRaNkO6T/LWY+pOTfeJwuvMM0Q/2Rk8OpA6d
         zFut98XrtA7J3P7P5yZ9wWZX1Gipxb4iC8phf5nmrtY6ZT+vPhTZtKBXAjVkEzVudyB2
         Hwz+whcmlJFAQ+A7PQcCxI9lhP5nffN9YpWYUM+Yg9pko1uKyCswbkhh+OOE189UCQGC
         mCDxtwyiXRmrVvL9V5gXcvmE1Qs1WIfL7JJwQvOCX/zR4/bV+SuAmYsH06eTMp1FGEL9
         05GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtwLbCqmqvz42BIBfrvBd67JNfGvzVf9CtVg6xG0MDo=;
        b=k5q3I2KTfefKtOqXfKIyFq6QYYfNry8El4uva0dCZLSKt3XbfhK9Wrmb6TeB8QzTsh
         PsNlI6PXhEPFG1boE/2RYkQODd2tVws/X8X5poA+/gy4dokpZ5fYNgfKNMIyXbgXNesu
         xCIeJOBeEDQxJZKH8xLO7gf6faAUbVfZesxdHwZGx/DYa240Utbt/+pSnxsCXX/lNWii
         DaON1hpPqLbuDnCJCyhwSlwuhhTAr8q4PDTUCcjC9njxWSt7+DNyOosAMYXckhjpcBHR
         2DHOb3wsgKnqqM658mGPRUmovaHVvH1AOCmEbCCF52w/cutEFSRMgACRrDAapH0Rnb3+
         WVJg==
X-Gm-Message-State: ANhLgQ3RQRDrwGQoGchAmSRF4yKbPhVJFT9nJQQ+QJMQfeoqwUmOUcZd
	fGDq3/4PdvP/ihNxjy6XiDI2+BRnsIstcrGZOcGOhA==
X-Google-Smtp-Source: ADFU+vuJwhmchfCPkTtH5Ynz0giXt5bXNBUEx5wVctahGqCgUow/QrKV4szBeXwU2Z8TB249fauEQ8jxV+fGCd1JPZA=
X-Received: by 2002:a05:6402:1c8b:: with SMTP id cy11mr7881800edb.102.1585730894443;
 Wed, 01 Apr 2020 01:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200327071202.2159885-1-alastair@d-silva.org> <20200327071202.2159885-2-alastair@d-silva.org>
In-Reply-To: <20200327071202.2159885-2-alastair@d-silva.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Apr 2020 01:48:03 -0700
Message-ID: <CAPcyv4hX9RTWKSLB8OcYY6MK-z5u5WWSaYSGa-8oqPbWU7st8w@mail.gmail.com>
Subject: Re: [PATCH v4 01/25] powerpc/powernv: Add OPAL calls for LPC memory alloc/release
To: "Alastair D'Silva" <alastair@d-silva.org>
Message-ID-Hash: MP45Q3LTPDWL2SZRJXVDIR5FSBIFPNOG
X-Message-ID-Hash: MP45Q3LTPDWL2SZRJXVDIR5FSBIFPNOG
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MP45Q3LTPDWL2SZRJXVDIR5FSBIFPNOG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Mar 29, 2020 at 10:23 PM Alastair D'Silva <alastair@d-silva.org> wrote:
>
> Add OPAL calls for LPC memory alloc/release
>

This seems to be referencing an existing api definition, can you
include a pointer to the spec in case someone wanted to understand
what these routines do? I suspect this is not allocating memory in the
traditional sense as much as it's allocating physical address space
for a device to be mapped?


> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/opal-api.h        | 2 ++
>  arch/powerpc/include/asm/opal.h            | 2 ++
>  arch/powerpc/platforms/powernv/opal-call.c | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
> index c1f25a760eb1..9298e603001b 100644
> --- a/arch/powerpc/include/asm/opal-api.h
> +++ b/arch/powerpc/include/asm/opal-api.h
> @@ -208,6 +208,8 @@
>  #define OPAL_HANDLE_HMI2                       166
>  #define        OPAL_NX_COPROC_INIT                     167
>  #define OPAL_XIVE_GET_VP_STATE                 170
> +#define OPAL_NPU_MEM_ALLOC                     171
> +#define OPAL_NPU_MEM_RELEASE                   172
>  #define OPAL_MPIPL_UPDATE                      173
>  #define OPAL_MPIPL_REGISTER_TAG                        174
>  #define OPAL_MPIPL_QUERY_TAG                   175
> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
> index 9986ac34b8e2..301fea46c7ca 100644
> --- a/arch/powerpc/include/asm/opal.h
> +++ b/arch/powerpc/include/asm/opal.h
> @@ -39,6 +39,8 @@ int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
>                                 uint64_t PE_handle);
>  int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
>                         uint64_t rate_phys, uint32_t size);
> +int64_t opal_npu_mem_alloc(u64 phb_id, u32 bdfn, u64 size, __be64 *bar);
> +int64_t opal_npu_mem_release(u64 phb_id, u32 bdfn);
>
>  int64_t opal_console_write(int64_t term_number, __be64 *length,
>                            const uint8_t *buffer);
> diff --git a/arch/powerpc/platforms/powernv/opal-call.c b/arch/powerpc/platforms/powernv/opal-call.c
> index 5cd0f52d258f..f26e58b72c04 100644
> --- a/arch/powerpc/platforms/powernv/opal-call.c
> +++ b/arch/powerpc/platforms/powernv/opal-call.c
> @@ -287,6 +287,8 @@ OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,             OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
>  OPAL_CALL(opal_sensor_read_u64,                        OPAL_SENSOR_READ_U64);
>  OPAL_CALL(opal_sensor_group_enable,            OPAL_SENSOR_GROUP_ENABLE);
>  OPAL_CALL(opal_nx_coproc_init,                 OPAL_NX_COPROC_INIT);
> +OPAL_CALL(opal_npu_mem_alloc,                  OPAL_NPU_MEM_ALLOC);
> +OPAL_CALL(opal_npu_mem_release,                        OPAL_NPU_MEM_RELEASE);
>  OPAL_CALL(opal_mpipl_update,                   OPAL_MPIPL_UPDATE);
>  OPAL_CALL(opal_mpipl_register_tag,             OPAL_MPIPL_REGISTER_TAG);
>  OPAL_CALL(opal_mpipl_query_tag,                        OPAL_MPIPL_QUERY_TAG);
> --
> 2.24.1
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
