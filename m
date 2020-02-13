Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D4415B723
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Feb 2020 03:28:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CCF3C10FC3398;
	Wed, 12 Feb 2020 18:31:45 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DE5B10FC338F
	for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 18:31:42 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id z9so4109326oth.5
        for <linux-nvdimm@lists.01.org>; Wed, 12 Feb 2020 18:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hAsIRHvvpbi9rt/0W0BIpJsAiPhpdF9DzTF7MWukEo=;
        b=zJGAaqSk9K45xDEtrZiv/eOt/Ret00uN1fgyVdZproL1adSyD3VrZY3pR4XpqymNJW
         ApzlQ7myJviaJFmW3r7/Rllj9Ed0UUxk9+C/DmXXheJZiTXT59ftF8p36g6LzIjRvBqc
         ZZj8JVPNGEWHyHxZgOBNL4iiF2vOzApFiqufTlM2/EZ0C4uNM7S6XcLqNDt34xO3N+G7
         KuDK8VjJO/tRGg66BRphEyinEj+iy3Ly1mTDvflzMjfNHldnPcKlZkIAlfIIRFGatD/D
         7ccyMkJKacDSLOnpGVgbb/n2hoaVk/ayop78E+SWsmesilm15DqWiamjefiCPjDYyvmz
         ivPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hAsIRHvvpbi9rt/0W0BIpJsAiPhpdF9DzTF7MWukEo=;
        b=XkITdEoO5LNUVIZ721dMI7DX/2oxPyyaFFiHHOG2wWn2mo/fT0L0ER4ytCiAmiCSpG
         yOxrzkBbU8uLimwxe1J3JmEb9oOc8AwLtS8UkSg5/7wO74zwuequ42ZR7dtycrFhZO5r
         cvgCzj9/KkuxSieHsETL0URoS8wASzjliXdN9FqpDASei1kRSZfR+UHpNLPgeASVYgyk
         cQwgM6lDbVSONM0Y5pD0BkCFcmFvmpkBI1eEx4m4RP9oGtXZga3npFkktCTOZ83UbflG
         vGma8dSO5zn1LaRnicluFfxr1wZ5EH1J3j4U7EQ4R7+ar0CC6eLAFdaWzMbEbVvI5ArB
         Ijpg==
X-Gm-Message-State: APjAAAWRpVTCDz50o5dGCiv8ZfnZcTVU7LjEWBoCH/3I8bnEc4r2w8so
	/gnHFdhU5CsqQpSUUVFsyUa6HvYLzBBqmQ3xB3mYIA==
X-Google-Smtp-Source: APXvYqyB1g28ziokD8TaCIEowARkDkHag634xZ0PYBC6lk0WvB8JgTYQ6kgB8A/dwCYa7XBhGmjNCjcVRl0Q06TnwKU=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr11611078otq.126.1581560903990;
 Wed, 12 Feb 2020 18:28:23 -0800 (PST)
MIME-Version: 1.0
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Feb 2020 18:28:12 -0800
Message-ID: <CAPcyv4j8ouOpaAEXELzKdr1m6cPWw=XOeRg4FqXPAgV3ZqUJoA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Memory Hierarchy: Enable target node lookups for
 reserved memory
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID-Hash: 6YOYARQITYIXUUXR5DBANAISBBYEAMX6
X-Message-ID-Hash: 6YOYARQITYIXUUXR5DBANAISBBYEAMX6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kbuild test robot <lkp@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michal Hocko <mhocko@suse.com>, Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>, Dave Hansen <dave.hansen@linux.intel.com>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6YOYARQITYIXUUXR5DBANAISBBYEAMX6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 21, 2020 at 7:20 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Changes since v3 [1]:
> - Cleanup numa_map_to_online_node() to remove redundant "if
>   (!node_online(node))" (Aneesh)
>
> [1]: http://lore.kernel.org/r/157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com
>
> ---
>
> Merge notes:
>
> x86 folks: This has an ack from Rafael for ACPI, and Michael for Power.
> With an x86 ack I plan to take this through the libnvdimm tree provided
> the x86 touches look ok to you.

Ping x86 folks. There's no additional changes identified for this
series. Can I request an ack to take it through libnvdimm.git? Do you
need a resend?

    x86/mm: Introduce CONFIG_KEEP_NUMA
    x86/numa: Provide a range-to-target_node lookup facility


>
> ---
>
> Cover:
>
> Arrange for platform numa info to be preserved for determining
> 'target_node' data. Where a 'target_node' is the node a reserved memory
> range will become when it is onlined.
>
> This new infrastructure is expected to be more valuable over time for
> Memory Tiers / Hierarchy management as more platforms (via the ACPI HMAT
> and EFI Specific Purpose Memory) publish reserved or "soft-reserved"
> ranges to Linux. Linux system administrators will expect to be able to
> interact with those ranges with a unique numa node number when/if that
> memory is onlined via the dax_kmem driver [2].
>
> One configuration that currently fails to properly convey the target
> node for the resulting memory hotplug operation is persistent memory
> defined by the memmap=nn!ss parameter. For example, today if node1 is a
> memory only node, and all the memory from node1 is specified to
> memmap=nn!ss and subsequently onlined, it will end up being onlined as
> node0 memory. As it stands, memory_add_physaddr_to_nid() can only
> identify online nodes and since node1 in this example has no online cpus
> / memory the target node is initialized node0.
>
> The fix is to preserve rather than discard the numa_meminfo entries that
> are relevant for reserved memory ranges, and to uplevel the node
> distance helper for determining the "local" (closest) node relative to
> an initiator node.
>
> [2]: https://pmem.io/ndctl/daxctl-reconfigure-device.html
>
> ---
>
> Dan Williams (6):
>       ACPI: NUMA: Up-level "map to online node" functionality
>       mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
>       powerpc/papr_scm: Switch to numa_map_to_online_node()
>       x86/mm: Introduce CONFIG_KEEP_NUMA
>       x86/numa: Provide a range-to-target_node lookup facility
>       libnvdimm/e820: Retrieve and populate correct 'target_node' info
>
>
>  arch/powerpc/platforms/pseries/papr_scm.c |   21 --------
>  arch/x86/Kconfig                          |    1
>  arch/x86/mm/numa.c                        |   74 +++++++++++++++++++++++------
>  drivers/acpi/numa/srat.c                  |   41 ----------------
>  drivers/nvdimm/e820.c                     |   18 ++-----
>  include/linux/acpi.h                      |   23 +++++++++
>  include/linux/numa.h                      |   23 +++++++++
>  mm/Kconfig                                |    5 ++
>  mm/mempolicy.c                            |   31 ++++++++++++
>  9 files changed, 145 insertions(+), 92 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
