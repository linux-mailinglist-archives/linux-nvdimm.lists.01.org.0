Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A268201EFF
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Jun 2020 02:12:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 39E1A10FCB710;
	Fri, 19 Jun 2020 17:12:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5DD6110FC72A6
	for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 17:12:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so12056822ejb.11
        for <linux-nvdimm@lists.01.org>; Fri, 19 Jun 2020 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Jipj0RLYrkbL/mDDaktO2bULYibUvO5Gf5PxTB7pgo=;
        b=krhCNNcqvD2ZrGEvYnHUxpXMDnu2RtZtgiOPFCmMDxcRK+xt4Du+TayDdYX7Cu0MMx
         Ga5Qb+4huGEHn26J4GheFINQ4a4uz84BhABAoVI++hmy/z9w9Ph0OG/piU/rjg/MP0A7
         8Ld8s4fGsnPVWd1hnZfps/ECTmKQZl4u16gadImO9b+1kmO5PQDqKiqO/qTSPdUh+UDc
         My0TDSyaIy8ZowaxZChQI02Wu+Infb+VGrlMpMxKrQQUwG9aMX1THggzCX00koFPjY6R
         /+kMB/1pn8ujV9ov1wr5fFbkyDv9PJV/RBYkmNQwM4UkUJLeyMUP6lzlkO73hFUaHvLI
         UdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Jipj0RLYrkbL/mDDaktO2bULYibUvO5Gf5PxTB7pgo=;
        b=JVd/6nbCxkd2Ve9kwosNbyZ3VDoaUC20FdDCoumGwjLZ3zVtK6vb26+cq9aqTqHEjn
         zCHiDkJHr4E5eoqnsBHI9wTNHc3gjaV3/NX+GD5T3XtRxTebDXHaoEZG5uTDl2OCaZLG
         yJqZpFRzrDUfvRQn7GfjNah20AKbTdW4dVjGCoIbUouw+Btgx3JTZjIbz9RIZO9tRyD7
         1iV+92no4imL8Xkx+AacnFSanLsSUoiWrvU0doJ823wfsvMZBnNWxHoxIBjpGcL4Porx
         fn0mgFqfqUjoO+N8def0u81DNb4al4jOtrFC4pYwFDbSq/Hjra/bhPoz2eg2FP/HoSZb
         VlNQ==
X-Gm-Message-State: AOAM532nzTJhYjN3NnRWBRJhPJH65a02jJfUQSND+ufR0kD3DmEBaMeq
	N/nRckKGIyHcmQo2bCtFIqU4QyU7In1GvsjOoW5zUGD/
X-Google-Smtp-Source: ABdhPJz4ZK6DQGYeVkjchN2nf5oSIWI7M/A8Zv1tzlxry0WrjNuqJcrPN2wYhJP+kEjVxRZZi0w92o34tmmqFmEXpcI=
X-Received: by 2002:a17:906:fac8:: with SMTP id lu8mr5785353ejb.432.1592611922967;
 Fri, 19 Jun 2020 17:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR04MB4310650471DD3C25D77BEA6394980@BYAPR04MB4310.namprd04.prod.outlook.com>
 <CAPcyv4jDgD82S9VHWb-P5iP+UH-gqdsYcNmA=aMFNhKrdSEUqg@mail.gmail.com> <BYAPR04MB4310B8A76F318E50237447E294980@BYAPR04MB4310.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4310B8A76F318E50237447E294980@BYAPR04MB4310.namprd04.prod.outlook.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Jun 2020 17:11:51 -0700
Message-ID: <CAPcyv4gLX1p5Amz_9V7SGurX+aTQfmPdTp8DSTm53u2Qgtgj=A@mail.gmail.com>
Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)
To: "Ananth, Rajesh" <Rajesh.Ananth@smartm.com>
Message-ID-Hash: DKMNCS5LPVOKYAQN5BHO2NR3NYYA55QK
X-Message-ID-Hash: DKMNCS5LPVOKYAQN5BHO2NR3NYYA55QK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DKMNCS5LPVOKYAQN5BHO2NR3NYYA55QK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

[ add back linux-nvdimm as others may hit the same issue too and I
want this in the archives ]

On Fri, Jun 19, 2020 at 4:49 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
>
> Dan,
>
> Thank you so much for your response.  Our PLATFORM is totally NFIT compliant and does not use the Type-12/E820 maps.

Ah, great.

>
> We have 2 NVDIMMs interleaved in the same Memory Channel, each 16 GB in size.
>
> This is what the 4.7.9 Kernel reports for the for "/proc/iomem":

Can you post the output of:

acpdump -n NFIT

...?

Labels can't create new regions, so there must be a behavior
difference in how these kernels are parsing this NFIT.

>
> 00001000-0009afff : System RAM
> 0009b000-0009ffff : reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c7fff : Video ROM
>   000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000c8dff : Adapter ROM
> 000c9000-000c9dff : Adapter ROM
> 000e0000-000fffff : reserved
>   000f0000-000fffff : System ROM
> 00100000-6984ffff : System RAM
>   2e000000-2e7f1922 : Kernel code
>   2e7f1923-2ed448ff : Kernel data
>   2eedb000-2f055fff : Kernel bss
> 69850000-6c1f8fff : reserved
>   6b1dd018-6b1dd018 : APEI ERST
>   6b1dd01c-6b1dd021 : APEI ERST
>   6b1dd028-6b1dd039 : APEI ERST
>   6b1dd040-6b1dd04c : APEI ERST
>   6b1dd050-6b1df04f : APEI ERST
> 6c1f9000-6c322fff : System RAM
> 6c323000-6ce83fff : ACPI Non-volatile Storage
> 6ce84000-6f2fcfff : reserved
> 6f2fd000-6f7fffff : System RAM
>  fec00000-fec003ff : IOAPIC 0
>   fec01000-fec013ff : IOAPIC 1
>   fec08000-fec083ff : IOAPIC 2
>   fec10000-fec103ff : IOAPIC 3
>   fec18000-fec183ff : IOAPIC 4
>   fec20000-fec203ff : IOAPIC 5
>   fec28000-fec283ff : IOAPIC 6
>   fec30000-fec303ff : IOAPIC 7
>   fec38000-fec383ff : IOAPIC 8
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed12000-fed1200f : pnp 00:01
> fed12010-fed1201f : pnp 00:01
> fed1b000-fed1bfff : pnp 00:01
> fed20000-fed44fff : reserved
> fed45000-fed8bfff : pnp 00:01
> fee00000-feefffff : pnp 00:01
>   fee00000-fee00fff : Local APIC
> ff000000-ffffffff : reserved
>   ff000000-ffffffff : pnp 00:01
> 100000000-407fffffff : System RAM
> 4080000000-487fffffff : Persistent Memory         <<<<<  PERSISTENT MEMORY
>   4080000000-487fffffff : namespace0.0
> 4880000000-887fffffff : System RAM
>
> The same system configuration under 4.16 Kernel (We just rebooted with a new Kernel):
>
> 00001000-0009afff : System RAM
> 0009b000-0009ffff : Reserved
> 000a0000-000bffff : PCI Bus 0000:00
> 000c0000-000c7fff : Video ROM
>   000c4000-000c7fff : PCI Bus 0000:00
> 000c8000-000c8dff : Adapter ROM
> 000c9000-000c9dff : Adapter ROM
> 000e0000-000fffff : Reserved
>   000f0000-000fffff : System ROM
> 00100000-6984ffff : System RAM
> 69850000-6c1f8fff : Reserved
>   6b1dd018-6b1dd018 : APEI ERST
>   6b1dd01c-6b1dd021 : APEI ERST
>   6b1dd028-6b1dd039 : APEI ERST
>   6b1dd040-6b1dd04c : APEI ERST
>   6b1dd050-6b1df04f : APEI ERST
> 6c1f9000-6c322fff : System RAM
> 6c323000-6ce83fff : ACPI Non-volatile Storage
> 6ce84000-6f2fcfff : Reserved
> 6f2fd000-6f7fffff : System RAM
> 6f800000-8fffffff : Reserved
>   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
> 90000000-9d7fffff : PCI Bus 0000:00
> fec18000-fec183ff : IOAPIC 4
>   fec20000-fec203ff : IOAPIC 5
>   fec28000-fec283ff : IOAPIC 6
>   fec30000-fec303ff : IOAPIC 7
>   fec38000-fec383ff : IOAPIC 8
> fed00000-fed003ff : HPET 0
>   fed00000-fed003ff : PNP0103:00
> fed12000-fed1200f : pnp 00:01
> fed12010-fed1201f : pnp 00:01
> fed1b000-fed1bfff : pnp 00:01
> fed20000-fed44fff : Reserved
> fed45000-fed8bfff : pnp 00:01
> fee00000-feefffff : pnp 00:01
>   fee00000-fee00fff : Local APIC
> ff000000-ffffffff : Reserved
>   ff000000-ffffffff : pnp 00:01
> 100000000-407fffffff : System RAM
> 4080000000-487fffffff : Persistent Memory             <<<  PERSISTENT MEMORY
>   4080000000-447fffffff : namespace0.0
>   4480000000-487fffffff : namespace1.0
> 4880000000-887fffffff : System RAM
>   4d15000000-4d15c031d0 : Kernel code
>   4d15c031d1-4d16387b7f : Kernel data
>   4d1692d000-4d16a82fff : Kernel bss
>
>
> Thanks,
> Rajesh
>
> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams@intel.com]
> Sent: Friday, June 19, 2020 4:34 PM
> To: Ananth, Rajesh
> Cc: linux-nvdimm@lists.01.org
> Subject: Re: Question on PMEM regions (Linux 4.9 Kernel & above)
>
> SMART Modular Security Checkpoint: External email. Please make sure you trust this source before clicking links or opening attachments.
>
> On Fri, Jun 19, 2020 at 4:18 PM Ananth, Rajesh <Rajesh.Ananth@smartm.com> wrote:
> >
> > I have a question on the default REGION creation (unlabeled NVDIMM) on the Interleave Sets.  I observe that for a Single Interleave Set, the Linux Kernels earlier to 4.9 create only one "Region0->namespace0.0" (pmem0 for the entire size), but in the later Kernels I observe for the same Interleave Set it creates "Region0->namespace0.0" and "Region1->namespace1.0" by default (pmem0, pmem1 for half the size of the Interleave set).
> >
> > I don't have any explicit labels created using the ndctl utilities. I just plug-in the fresh NVDIMM modules like I always do.
> >
> > I searched for and found the relevant information on that front regarding the nd_pmem driver and the support for multiple pmem namespaces.  I am wondering whether is there a way I could -- through Kernel Parameters or something -- get the default behavior the same as it existed before Kernel 4.9 driver changes.
>
> How is your platform BIOS indicating the persistent memory range? I
> suspect you might be using the non-standard Type-12 memory hack and
> are hitting this issue:
>
> 23446cb66c07 x86/e820: Don't merge consecutive E820_PRAM ranges
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=23446cb66c07
>
> For it to show up as one range the BIOS needs to tell Linux that it is
> one coherent range. You can force the kernel to override the BIOS
> provided memory map with the memmap= parameter. Some details of that
> here:
>
> https://nvdimm.wiki.kernel.org/how_to_choose_the_correct_memmap_kernel_parameter_for_pmem_on_your_system
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
