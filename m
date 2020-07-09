Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25C2196BD
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jul 2020 05:38:49 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75B69111B33D6;
	Wed,  8 Jul 2020 20:38:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::544; helo=mail-ed1-x544.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6707F111661AC
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 20:38:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dg28so679724edb.3
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 20:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtjuErNIKJPKt6mfJPuDEE1udY89MBwcN8YDulEHHpA=;
        b=raobTJTpMajWWh1DB67I4/ixIZuCT8w3vl86Q6iXHe8AqyCsaVIQnEjEhi3xpXUVSY
         0sZ63uK1kh4Jq4GNjXjq1PXyhJBnXNVLrXeQybYWn7zcn8nuVxunI9SJNMAwua0zTL/6
         N1PoXUBA2cUrSZwgk8tTruN0Pzjo+BpZWuk8YT47mWs7NxF6eN2RJOPiPqaA5CBkqCrA
         cWuPO9IW3sP/7mhUWgqHI7r2h3+L5G+GEZ+152hw2pOUVzrPYQCm4q8Mtc4j2RtD39xc
         14zCSHFmqrXrZ7K1jR+L5WFLLufK7fsNNpNlnIegsjGENi2QENndj1DW7a2O57jMVMkS
         Kh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtjuErNIKJPKt6mfJPuDEE1udY89MBwcN8YDulEHHpA=;
        b=h0znW3j/0KmxsVr6ZNkA32zTpJXvoIlUpAmciyjZj0n4rY8c0h1z/r9vJ6CxsITgRi
         yroLR8Dp9RsqHaEwfygKsja9OfKokLco7QjSoLc140qUA16MIWQIQbAaOdI7JVLOUuv5
         4mL+NvIv4nXohT8CbKrUQCkMu05YFQLuBu8tnfeJLr2pdVAaHTgECnpjsV6IQNNr/cAH
         6AEObk4VBJpJv+aN45jAs588InrvubSRHFgE64rMZ2rspckhHK2vojUj5rDvX7sPyDCc
         MPDDbDVxQ3nC7y7eZOiG6Y/uNuQVJ4pnBcU7SAc4TLytPjhh+NwIt4PWZrxKjbObYGNY
         kOfg==
X-Gm-Message-State: AOAM530Qu/TxwYWRg7FkF823GJ1Ewg6yYnP/XGaT1N4G3MiI6HNlm+Te
	qeZuAUbAWqIdg69I+GN15yLZdhcBaxMaqb5hjDCINA==
X-Google-Smtp-Source: ABdhPJw5nGGUvNN51Fg2qfZAUYpiFgoQEWbsf39bUBkbdSfrldAhGBNqQDnuvj5zNJ0UqJqM9lo3PWsVoNPxBGZ10fU=
X-Received: by 2002:a05:6402:b79:: with SMTP id cb25mr49015887edb.154.1594265921222;
 Wed, 08 Jul 2020 20:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200709020629.91671-1-justin.he@arm.com> <20200709020629.91671-6-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-6-justin.he@arm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Jul 2020 20:38:30 -0700
Message-ID: <CAPcyv4gfVhHyo-c=9bXd=z3=9Xqy7ato30D8p2aNsKBUONosug@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is invalid
To: Jia He <justin.he@arm.com>
Message-ID-Hash: IXJ2RBL2MXAPQZS3YSQ4NPIBMPFPEM27
X-Message-ID-Hash: IXJ2RBL2MXAPQZS3YSQ4NPIBMPFPEM27
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>, X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org
 >, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IXJ2RBL2MXAPQZS3YSQ4NPIBMPFPEM27/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jul 8, 2020 at 7:07 PM Jia He <justin.he@arm.com> wrote:
>
> numa_off is set unconditionally at the end of dummy_numa_init(),
> even with a fake numa node. ACPI detects node id as NUMA_NO_NODE(-1) in
> acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
> node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
>
> Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT table
> isn't present:
> $ndctl create-namespace -fe namespace0.0 --mode=devdax --map=dev -s 1g -a 64K
> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invalid node: -1
> kmem: probe of dax0.0 failed with error -22
>
> This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  drivers/dax/kmem.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f87399..218f66057994 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -31,22 +31,23 @@ int dev_dax_kmem_probe(struct device *dev)
>         int numa_node;
>         int rc;
>
> +       /* Hotplug starting at the beginning of the next block: */
> +       kmem_start = ALIGN(res->start, memory_block_size_bytes());
> +
>         /*
>          * Ensure good NUMA information for the persistent memory.
>          * Without this check, there is a risk that slow memory
>          * could be mixed in a node with faster memory, causing
> -        * unavoidable performance issues.
> +        * unavoidable performance issues. Furthermore, fallback node
> +        * id can be used when numa_node is invalid.
>          */
>         numa_node = dev_dax->target_node;
>         if (numa_node < 0) {
> -               dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
> -                        res, numa_node);
> -               return -EINVAL;
> +               numa_node = memory_add_physaddr_to_nid(kmem_start);

I think this fixup belongs to the core to set a fallback value for
dev_dax->target_node.

I'm close to having patches to provide a functional
phys_addr_to_target_node() for arm64.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
