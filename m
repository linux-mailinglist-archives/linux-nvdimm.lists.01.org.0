Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7103E2A12C3
	for <lists+linux-nvdimm@lfdr.de>; Sat, 31 Oct 2020 02:54:58 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80B46165A98D3;
	Fri, 30 Oct 2020 18:54:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::641; helo=mail-ej1-x641.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2EDAC165A98D2
	for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 18:54:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so11134593eji.4
        for <linux-nvdimm@lists.01.org>; Fri, 30 Oct 2020 18:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vpps4QHXRxAMWPFAR6czMYTEeayKSB9a8gYwfl7iFEI=;
        b=xMgBvat1GLEvW0fGY01bhphopLs3WOKfAtrbUsY+cIPkQa45srH0eqnAFGv+z08azC
         kLefbpLW4GHeuhi4n9L8s0a7Hp1yRDuYfCE5eqONmCQYvqOZNspfKmeYiNuqLRRx/U2/
         ai0YXm9lzf6GW4Z0HeXsoMYwnli+NS/cskD5riX/1B5U75T/v4TJmHSaTn0nN+trNjpo
         GtZbPEuUCosr3tosa7RcWprdV0O/9YYkSMYac0jc00VaI0E2OGVqIeokbrJJCHgb8xPe
         lH0V2nUPonZ5QoXAxaOC263dFHbuAz81zEhNMK+h9JQGygXyPtMBvipltnVwIj+qCkDt
         8yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vpps4QHXRxAMWPFAR6czMYTEeayKSB9a8gYwfl7iFEI=;
        b=bzk1Ckq4SbdfLy8nkfmL9iEyTPs5zbVlY/esWGhuPViS4cXU9x5xc/dtcrc5i6Wcpq
         f9dsFH5MOdv/N/roBbykRCQijP1WlVhy3BypMllNRDyodylvk20G23mg31iBEIchvQ4d
         nrTemO7Mq2wfdEKvp4YG5sdH6o309wvfxHXCozSb/0vHVXIvqUXLr4soswx2uGAF38CK
         r+B+c6HMmcLTPYjOyzoxQwIFF2Rtr9j0uSbWRxlusOg7SrQgxLYEUHVZLzd+yH4J88yL
         RdM//36jybN9TgLzH+Im3xwxBOaJ1+AeyeqLp6LZA81Ji3EXXtjvQWwZaZm+tFom1cQZ
         10CA==
X-Gm-Message-State: AOAM5312hwiM25mLwDxCUTk/FRcNrBvmCCNP7tK0aJsl4SHfZu5qqO3H
	oS7VyoKGVOCh0qxFP8L/bC80BsztHtX+JcWIUWyOyQ==
X-Google-Smtp-Source: ABdhPJwE7ZPoBTwgrT+kma8o/mNUUfsoxmBQwgeIO/t7I9Hk1RYtvCMijglyFYF+OEPZDKqXOEuytkR6bSX2Ogh4528=
X-Received: by 2002:a17:906:d92c:: with SMTP id rn12mr2910812ejb.472.1604109290015;
 Fri, 30 Oct 2020 18:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <160402498564.4173389.2743697400148832021.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 30 Oct 2020 18:54:35 -0700
Message-ID: <CAPcyv4iw_ZuHdhrGHUPh+iBYuO7sN_omEGb8RMmOKVzSCpbT0g@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Fix phys_to_target_node() export
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID-Hash: D3DFBT6MYNMLSUZCRHNPKAWTGR5TEOTV
X-Message-ID-Hash: D3DFBT6MYNMLSUZCRHNPKAWTGR5TEOTV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, kernel test robot <lkp@intel.com>, Joao Martins <joao.m.martins@oracle.com>, X86 ML <x86@kernel.org>, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D3DFBT6MYNMLSUZCRHNPKAWTGR5TEOTV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Oct 29, 2020 at 7:29 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The core-mm has a default __weak implementation of phys_to_target_node()
> when the architecture does not override it. That symbol is exported
> for modules. However, while the export in mm/memory_hotplug.c exported
> the symbol in the configuration cases of:
>
>         CONFIG_NUMA_KEEP_MEMINFO=y
>         CONFIG_MEMORY_HOTPLUG=y
>
> ...and:
>
>         CONFIG_NUMA_KEEP_MEMINFO=n
>         CONFIG_MEMORY_HOTPLUG=y
>
> ...it failed to export the symbol in the case of:
>
>         CONFIG_NUMA_KEEP_MEMINFO=y
>         CONFIG_MEMORY_HOTPLUG=n
>
> Always export the symbol from the CONFIG_NUMA_KEEP_MEMINFO section of
> arch/x86/mm/numa.c, and teach mm/memory_hotplug.c to optionally export
> in case arch/x86/mm/numa.c has already performed the export.
>
> The dependency on NUMA_KEEP_MEMINFO for DEV_DAX_HMEM_DEVICES is invalid
> now that the symbol is properly exported in all combinations of
> CONFIG_NUMA_KEEP_MEMINFO and CONFIG_MEMORY_HOTPLUG. Note that in the
> CONFIG_NUMA=n case no export is needed since their is a dummy static
> inline implementation of phys_to_target_node() in that case.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: a035b6bf863e ("mm/memory_hotplug: introduce default phys_to_target_node() implementation")
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thomas, do you want to ack this so Andrew can pick it up, or I can
take it through as a device-dax update, but either way the diffstat
warrants x86 + mm acks.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
