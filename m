Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC4F99DF
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 Nov 2019 20:38:09 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E48E0100DC415;
	Tue, 12 Nov 2019 11:39:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 98835100EA628
	for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 11:39:48 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id e9so15941720oif.8
        for <linux-nvdimm@lists.01.org>; Tue, 12 Nov 2019 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WimPYMY4ElLHUFFKax8XxzUf794g+9qy+ZcVmaVuAcA=;
        b=HcnG05wnGXWAD3tJYg/lrbE1+BP8mZbcyUXiEhT/4H5cmFBXdm3LKznNrl7E06/RvD
         nrMvD1V15i3JWo6K7vp/VRjIrRS2nSyFSCYI8nPTTeGkVucNiA6+ctSfIUzcIIvV6fb6
         sDT8iHpdk7lXBXkPvyp7/GCIWbwBhDpNpfKVOvgcyOGje8Q4Yd0VyT7rd8EfPfmXIBp3
         ULNNC9ad1rTHxaWTGUMdDaaqTftk8ZZxHfUFcU2bpQpTuDHusLrARE7GHzz5nhrUAKYH
         C9yvDnR9ztR92XmKIaUbf3aKBrmVWX0DszAGA3L+zGW44LVsKSfSImwMdxaj4baUPBHh
         uYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WimPYMY4ElLHUFFKax8XxzUf794g+9qy+ZcVmaVuAcA=;
        b=ufe1Ayk5HqmWCgEM+JLZaXxXceYtp3a3Zac5Wrz1d+ggwbaQTN6X7WhGcFOdVt8I5u
         S5clpPklBj7OLLKbzo6wOmTd1hU2GHNOHYKGxDayB+4feOvyyEQXIyRdEw0wFtLjTumT
         ZM544Q8adeFYxoZQA0o49Ds6Fi17ZI3NazJRF6kSZTrwxaP5vhg9ylc96dLl/juRVOA4
         vu3LjDLP18CAKJcUmGI9hL/z1fnVuwm6L+KQnWKVf0AVwGMYWC020qWPvSHq4+JNAOOK
         KdHWhlNLCgJRfUb5k2iJT0K4Cd61dOvkJ3+Bae+MmOt8ONBr+GfJWrPnJBPayon/eCfH
         u/hQ==
X-Gm-Message-State: APjAAAXltY2FDoItG8yGVRuJFq0APjn1M7KMV9P//Uh9zt+YIxLtKc2E
	emYRpPD/qHu9aB2Qt0QF0p4aOQd2I2PCQ+w3TACoHA==
X-Google-Smtp-Source: APXvYqy4nVx5cqhvzWgLCkvoCxBoiErI2cm44tEsrTAKJ9s0rE6buD5AjAFCNien8s0flORShIZ0P4Y/eJ81VIPpwYo=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr550653oie.149.1573587482869;
 Tue, 12 Nov 2019 11:38:02 -0800 (PST)
MIME-Version: 1.0
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
 <8736ettj60.fsf@linux.ibm.com>
In-Reply-To: <8736ettj60.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 12 Nov 2019 11:37:51 -0800
Message-ID: <CAPcyv4iKE6x2uD0NUjivO8KFXQxcX_kWBysShXBf_p8PfFiMXA@mail.gmail.com>
Subject: Re: [PATCH 00/16] Memory Hierarchy: Enable target node lookups for
 reserved memory
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: LVPIKRRYIT5VUXXGMR37GJIQS4NTV36R
X-Message-ID-Hash: LVPIKRRYIT5VUXXGMR37GJIQS4NTV36R
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LVPIKRRYIT5VUXXGMR37GJIQS4NTV36R/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Nov 12, 2019 at 3:43 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Yes, this patch series looks like a pile of boring libnvdimm cleanups,
> > but buried at the end are some small gems that testing with libnvdimm
> > uncovered. These gems will prove more valuable over time for Memory
> > Hierarchy management as more platforms, via the ACPI HMAT and EFI
> > Specific Purpose Memory, publish reserved or "soft-reserved" ranges to
> > Linux. Linux system administrators will expect to be able to interact
> > with those ranges with a unique numa node number when/if that memory is
> > onlined via the dax_kmem driver [1].
> >
> > One configuration that currently fails to properly convey the target
> > node for the resulting memory hotplug operation is persistent memory
> > defined by the memmap=nn!ss parameter. For example, today if node1 is a
> > memory only node, and all the memory from node1 is specified to
> > memmap=nn!ss and subsequently onlined, it will end up being onlined as
> > node0 memory. As it stands, memory_add_physaddr_to_nid() can only
> > identify online nodes and since node1 in this example has no online cpus
> > / memory the target node is initialized node0.
> >
> > The fix is to preserve rather than discard the numa_meminfo entries that
> > are relevant for reserved memory ranges, and to uplevel the node
> > distance helper for determining the "local" (closest) node relative to
> > an initiator node.
> >
> > The first 12 patches are cleanups to make sure that all nvdimm devices
> > and their children properly export a numa_node attribute. The switch to
> > a device-type is less code and less error prone as a result.
>
>
> Will this still allow leaf driver to have platform specific attribute
> exposed via sysfs? Or do we want to still keep them in nvdimm core and
> control the visibility via is_visible() callback?

The leaf driver can still have platform specific attributes, see:

    acpi_nfit_attribute_groups
    acpi_nfit_dimm_attribute_groups
    acpi_nfit_region_attribute_groups

...that still exist after this conversion. This conversion simply
arranges for those to passed in without making the leaf driver also be
responsible for specifying the core attributes.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
