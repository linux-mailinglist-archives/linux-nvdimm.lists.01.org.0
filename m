Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20413038D0
	for <lists+linux-nvdimm@lfdr.de>; Tue, 26 Jan 2021 10:20:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BD76100EBB94;
	Tue, 26 Jan 2021 01:20:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=rppt@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7250D100EBB94
	for <linux-nvdimm@lists.01.org>; Tue, 26 Jan 2021 01:20:29 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E799F23104;
	Tue, 26 Jan 2021 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1611652828;
	bh=bRC3SR9LJ18SWaWmVRerAdHAiKyQlnV1tKBjwhOnPS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMudgeWS8EFR4uZOodLooioJQHSO0U8pMo3JByI0WkzeCLds2rL8dDBKPdMIET6wU
	 NikHEJLu6mMPo3tSd4JLNAkh4YqDqIqAawEF4n7/5E0DpJcUj6JlJzfXjlARC2mrq+
	 CruSYC+Gj4FeoDXNsygqJGE7OxywyVzS/Nn8h+qL2ObhBOyIjfhuWkMbt9RXhvqlR9
	 sIvn3CEW/XJ7CY9dZPZIilb4D2ZP3U4aA+EJ7+3rtsmP4/R1ZB/lnI26RwNUiGucdL
	 kTLxonDh/eLTOLxPU2kPm5Hg1de9FuFM6fyMMsw0V869lvcbyEy9tpZfl7U/HLU3MC
	 6HV9bZva2SpZg==
Date: Tue, 26 Jan 2021 11:20:11 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v16 06/11] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210126092011.GP6332@kernel.org>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-7-rppt@kernel.org>
 <20210125170122.GU827@dhcp22.suse.cz>
 <20210125213618.GL6332@kernel.org>
 <20210126071614.GX827@dhcp22.suse.cz>
 <20210126083311.GN6332@kernel.org>
 <20210126090013.GF827@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126090013.GF827@dhcp22.suse.cz>
Message-ID-Hash: 2TA6WM3YDYQGXXWUOHLJCTMTYQQSSG3K
X-Message-ID-Hash: 2TA6WM3YDYQGXXWUOHLJCTMTYQQSSG3K
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho 
 Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2TA6WM3YDYQGXXWUOHLJCTMTYQQSSG3K/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 26, 2021 at 10:00:13AM +0100, Michal Hocko wrote:
> On Tue 26-01-21 10:33:11, Mike Rapoport wrote:
> > On Tue, Jan 26, 2021 at 08:16:14AM +0100, Michal Hocko wrote:
> > > On Mon 25-01-21 23:36:18, Mike Rapoport wrote:
> > > > On Mon, Jan 25, 2021 at 06:01:22PM +0100, Michal Hocko wrote:
> > > > > On Thu 21-01-21 14:27:18, Mike Rapoport wrote:
> > > > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > > > 
> > > > > > Introduce "memfd_secret" system call with the ability to create memory
> > > > > > areas visible only in the context of the owning process and not mapped not
> > > > > > only to other processes but in the kernel page tables as well.
> > > > > > 
> > > > > > The user will create a file descriptor using the memfd_secret() system
> > > > > > call. The memory areas created by mmap() calls from this file descriptor
> > > > > > will be unmapped from the kernel direct map and they will be only mapped in
> > > > > > the page table of the owning mm.
> > > > > > 
> > > > > > The secret memory remains accessible in the process context using uaccess
> > > > > > primitives, but it is not accessible using direct/linear map addresses.
> > > > > > 
> > > > > > Functions in the follow_page()/get_user_page() family will refuse to return
> > > > > > a page that belongs to the secret memory area.
> > > > > > 
> > > > > > A page that was a part of the secret memory area is cleared when it is
> > > > > > freed.
> > > > > > 
> > > > > > The following example demonstrates creation of a secret mapping (error
> > > > > > handling is omitted):
> > > > > > 
> > > > > > 	fd = memfd_secret(0);
> > > > > > 	ftruncate(fd, MAP_SIZE);
> > > > > > 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> > > > > 
> > > > > I do not see any access control or permission model for this feature.
> > > > > Is this feature generally safe to anybody?
> > > > 
> > > > The mappings obey memlock limit. Besides, this feature should be enabled
> > > > explicitly at boot with the kernel parameter that says what is the maximal
> > > > memory size secretmem can consume.
> > > 
> > > Why is such a model sufficient and future proof? I mean even when it has
> > > to be enabled by an admin it is still all or nothing approach. Mlock
> > > limit is not really useful because it is per mm rather than per user.
> > > 
> > > Is there any reason why this is allowed for non-privileged processes?
> > > Maybe this has been discussed in the past but is there any reason why
> > > this cannot be done by a special device which will allow to provide at
> > > least some permission policy?
> >  
> > Why this should not be allowed for non-privileged processes? This behaves
> > similarly to mlocked memory, so I don't see a reason why secretmem should
> > have different permissions model.
> 
> Because appart from the reclaim aspect it fragments the direct mapping
> IIUC. That might have an impact on all others, right?

It does fragment the direct map, but first it only splits 1G pages to 2M
pages and as was discussed several times already it's not that clear which
page size in the direct map is the best and this is very much workload
dependent.

These are the results of the benchmarks I've run with the default direct
mapping covered with 1G pages, with disabled 1G pages using "nogbpages" in
the kernel command line and with the entire direct map forced to use 4K
pages using a simple patch to arch/x86/mm/init.c.

https://docs.google.com/spreadsheets/d/1tdD-cu8e93vnfGsTFxZ5YdaEfs2E1GELlvWNOGkJV2U/edit?usp=sharing

-- 
Sincerely yours,
Mike.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
