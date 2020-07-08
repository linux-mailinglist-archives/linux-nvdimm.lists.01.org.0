Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3381217FFC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 08:53:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3FA50110BC288;
	Tue,  7 Jul 2020 23:53:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BFC4110BC287
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 23:53:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n2so31703337edr.5
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jul 2020 23:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keyDLeonC8frLPJK5duQJ259ChXYsKspJF9lGM2JwDk=;
        b=TK82CEOeB8wUtoFdmxlPl9goWXQTwmwz3fiSr8+4rT8AzSHNNgiyKr9SzOXy/lyYf8
         gqaMKeXD87fSS3J+6QJP0+LSHMNW0ZGFc9up4RMVAmkS4jbaTwovaSj/bnXzH5YYTWw8
         XDbmrRbTJiWIB6TpHSeyaFpbpeKezLxVoHr4En1ZhFpTOC5hVD4ag6e27mzPFkzqDcUx
         fEwcJ3G7I38S0Hb6/vmtLJwq8ZclIrr/MY4Had/T7LOflv0eZNJVb/E797gXA1c3dP4I
         Y/LThtVQmuHWyMFoNWoxzJDPdam4biTa84cBlq8Ei4ajOKFco76rSfRzlkdhbIUINB4G
         kbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keyDLeonC8frLPJK5duQJ259ChXYsKspJF9lGM2JwDk=;
        b=mC1H/WZBV2jbyotGNfqUe5hrhGpKMDDVYVBsCsEomSb3MKYC/9XZaKn/lkWXkn1S5N
         2ukgmLov+5CgYbl/NvzuYn6cBtSEBwcUCpi3qo74PhazRBDDC8tU90vCqvkFVvYztAgG
         oXz7TR8mW9gBIDOItbATdYwP+EFEcXlJWqcHZuk41zDjqCfDE2XbZk7sMqY3bzHjPIpf
         5+H4wTGdC51jsH4fSINcDE3qDY8LjEf/NGjNXuu/jHDV4obgXdcGR0Utr300U6JXaSJO
         Njlke1b0ARPGGEIqQu4qhzPYsKbDAhwd1aQPzedDq4GmnDeorxvRUw8xJ9BmJEJiW47y
         DI3g==
X-Gm-Message-State: AOAM530gUwXODeZVfuxKq/rqAh2AWVKIHgUNvgNz/v0D9HQg9PtY2KUS
	VboxXv+I0Cbp4Col9q0UO7oHP5qFQjVtws4RjWoYSA==
X-Google-Smtp-Source: ABdhPJzWDULeQmA4RbfXyV27OZ4z7CGs9yHTVKdJ+99n4xIaX6QB9r7/8SCU1NxsX0FBfErjajvE/E1jaCZYv8t+S6M=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr62677191edj.93.1594191230511;
 Tue, 07 Jul 2020 23:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200707055917.143653-1-justin.he@arm.com> <20200707055917.143653-2-justin.he@arm.com>
 <20200707115454.GN5913@dhcp22.suse.cz> <AM6PR08MB406907F9F2B13DA6DC893AD9F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ipu4qwKhk4pzJ8nZB2sp+=AndahS8eCgUvFvVP6dEkeA@mail.gmail.com>
 <AM6PR08MB4069D0D1FD8FB31B6A56DDB5F7670@AM6PR08MB4069.eurprd08.prod.outlook.com>
 <CAPcyv4ivyJsyzcbkBWcqBYZMx3VdJF7+VPCNs177DU2rYqtz_A@mail.gmail.com> <20200708062217.GE386073@linux.ibm.com>
In-Reply-To: <20200708062217.GE386073@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jul 2020 23:53:39 -0700
Message-ID: <CAPcyv4iiHz7rofPKpKhiYMyPpf1ySQBW2HMwHcCtjb2wLiK7ZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64/numa: export memory_add_physaddr_to_nid as EXPORT_SYMBOL_GPL
To: Mike Rapoport <rppt@linux.ibm.com>
Message-ID-Hash: 2KWSZT7WVE3EF7FYP3Z2GICVATQPNZ64
X-Message-ID-Hash: 2KWSZT7WVE3EF7FYP3Z2GICVATQPNZ64
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Justin He <Justin.He@arm.com>, Michal Hocko <mhocko@kernel.org>, David Hildenbrand <david@redhat.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2KWSZT7WVE3EF7FYP3Z2GICVATQPNZ64/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jul 7, 2020 at 11:22 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
[..]
> > > Thanks for your suggestion,
> > > Could I wrap the codes and let memory_add_physaddr_to_nid simply invoke
> > > phys_to_target_node()?
> >
> > I think it needs to be the reverse. phys_to_target_node() should call
> > memory_add_physaddr_to_nid() by default, but fall back to searching
> > reserved memory address ranges in memblock. See phys_to_target_node()
> > in arch/x86/mm/numa.c. That one uses numa_meminfo instead of memblock,
> > but the principle is the same i.e. that a target node may not be
> > represented in memblock.memory, but memblock.reserved. I'm working on
> > a patch to provide a function similar to get_pfn_range_for_nid() that
> > operates on reserved memory.
>
> Do we really need yet another memblock iterator?
> I think only x86 has memory that is not in memblock.memory but only in
> memblock.reserved.

Well, that's what led me here. EFI has introduced a memory attribute
called "EFI Special Purpose Memory". I mapped it to a new Linux
concept called Soft Reserved memory (commit b617c5266eed "efi: Common
enable/disable infrastructure for EFI soft reservation"). The driver I
want to claim that memory, device-dax, wants to be able to look up
numa information for an address range that is marked reserved in
memblock. The device-dax facility has the ability to either let
userspace map a device, or assign the memory backing that device to
the page allocator. In both scenarios the driver needs numa info to
either populate the 'numa_node' property of the device in sysfs, or to
pass an node-id to add_memory_resource() when it is hot-plugged.

I was thwarted by the lack of phys_to_target_node() on arm64, and
rather than add another stub like memory_add_physaddr_to_nid() I
wanted to see if it could be solved properly / generically with
memblock data.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
