Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B45E29F
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 13:11:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CA881212ACEB5;
	Wed,  3 Jul 2019 04:11:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=rjwysocki@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EC41B212ACEAC
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 04:11:10 -0700 (PDT)
Received: by mail-oi1-f196.google.com with SMTP id g7so1708437oia.8
 for <linux-nvdimm@lists.01.org>; Wed, 03 Jul 2019 04:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5dj7wwiiT/uTLAOcQc9kC3UGFT63e367n3oRw7r2SNo=;
 b=ujSw2upvDI3+B2GTsvrzZMA1f0/4abI9JAxmwPzziJ3ci6z+jmGtJCd9UB1RlcRkjy
 ZLiHW6dP95FWW7HHCaWNCj0KPuzTRBQfpIJCX/465gygRvMjbXqA835jFFZlTDbOb8zY
 XV8jNtDRVizmzE85aDVXpMByIAs5W7ThJJhBm2blZ1EUsDgPGWXet6jumCwVchvr64o4
 Rvp0ZbgdI1TqhsBNO6oNzZbNByP05hzZRgeSV8fzOB3kJjxJ7teBnxsXS12mY50NDjYO
 BpmkgVctnbRlveBCwv9HR88cM0xt3CNUOsMVlFX7Tc/Xx9EUFhjJhrw7gmJduV9RvFS/
 3uoQ==
X-Gm-Message-State: APjAAAXsq//miY1yDgK/4qIUz2IZqn+7HgzvBq4uxn39AVrFWg33aTfA
 EV1ANcTBn8xau3uHZ/Rnr2iHivAYAaTD2Q3Ogb8=
X-Google-Smtp-Source: APXvYqymgr9Ny272krNuNKmRkdgKmiZYJjunZqxdcYHzBi9aN009dc+6dmS3hvuz0IX7ro5gfX21d95DOHEniSgtQv8=
X-Received: by 2002:aca:d907:: with SMTP id q7mr3109347oig.68.1562152269830;
 Wed, 03 Jul 2019 04:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <156140036490.2951909.1837804994781523185.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156140037770.2951909.3387200938880485927.stgit@dwillia2-desk3.amr.corp.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jul 2019 13:10:58 +0200
Message-ID: <CAJZ5v0gAVXxnu22it_YTTm1HQPiBj5DOuiC1YCg5Eem8RQW0Ww@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] acpi/numa/hmat: Skip publishing target info for
 nodes with no online memory
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 24, 2019 at 8:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> There are multiple scenarios where the HMAT may contain information
> about proximity domains that are not currently online. Rather than fail
> to report any HMAT data just elide those offline domains.
>
> If and when those domains are later onlined they can be added to the
> HMEM reporting at that point.
>
> This was found while testing EFI_MEMORY_SP support which reserves
> "specific purpose" memory from the general allocation pool. If that
> reservation results in an empty numa-node then the node is not marked
> online leading a spurious:
>
>     "acpi/hmat: Ignoring HMAT: Invalid table"
>
> ...result for HMAT parsing.
>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/hmat.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 96b7d39a97c6..2c220cb7b620 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -96,9 +96,6 @@ static __init void alloc_memory_target(unsigned int mem_pxm)
>  {
>         struct memory_target *target;
>
> -       if (pxm_to_node(mem_pxm) == NUMA_NO_NODE)
> -               return;
> -
>         target = find_mem_target(mem_pxm);
>         if (target)
>                 return;
> @@ -588,6 +585,17 @@ static __init void hmat_register_targets(void)
>         struct memory_target *target;
>
>         list_for_each_entry(target, &targets, node) {
> +               int nid = pxm_to_node(target->memory_pxm);
> +
> +               /*
> +                * Skip offline nodes. This can happen when memory
> +                * marked EFI_MEMORY_SP, "specific purpose", is applied
> +                * to all the memory in a promixity domain leading to
> +                * the node being marked offline / unplugged, or if
> +                * memory-only "hotplug" node is offline.
> +                */
> +               if (nid == NUMA_NO_NODE || !node_online(nid))
> +                       continue;
>                 hmat_register_target_initiators(target);
>                 hmat_register_target_perf(target);
>         }
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
