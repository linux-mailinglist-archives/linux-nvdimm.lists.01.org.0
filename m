Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF830776B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 14:49:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D78A100EB858;
	Thu, 28 Jan 2021 05:49:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=mhocko@suse.com; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C1E3100EB855
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 05:49:37 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1611841775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=75llh3uw6L6UpTgmVsHlz+i8LHZJ84jNMGnauBZqITc=;
	b=RFEQmGK/LljkSM2oiWx77CIGoV0eKNOaEQIEAkrhzpN9jbb3MOKURRCYaRwYVt6/w/U/+e
	g4VVantqh8P7n2dKzYTMYQk4w9MXZKXSASL6hjd+n4xFytPepUsla6MMacf9DtnSP1AmZ/
	v2BcnFvMM+kSY0c0Ye3UOYH/R63VQ8Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 9E752AF78;
	Thu, 28 Jan 2021 13:49:35 +0000 (UTC)
Date: Thu, 28 Jan 2021 14:49:34 +0100
From: Michal Hocko <mhocko@suse.com>
To: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <YBLA7sEKn01HXd/U@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
 <20210121122723.3446-8-rppt@kernel.org>
 <20210126114657.GL827@dhcp22.suse.cz>
 <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
 <20210126120823.GM827@dhcp22.suse.cz>
 <20210128092259.GB242749@kernel.org>
 <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
 <alpine.DEB.2.22.394.2101281326360.10563@www.lameter.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2101281326360.10563@www.lameter.com>
Message-ID-Hash: NPTJ3PHCRD6NLYT5F6UQ3Q5LGHMEYI3H
X-Message-ID-Hash: NPTJ3PHCRD6NLYT5F6UQ3Q5LGHMEYI3H
X-MailFrom: mhocko@suse.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, James Bottomley <jejb@linux.ibm.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho And
 ersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>, Palmer Dabbelt <palmerdabbelt@google.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NPTJ3PHCRD6NLYT5F6UQ3Q5LGHMEYI3H/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 28-01-21 13:28:10, Cristopher Lameter wrote:
> On Thu, 28 Jan 2021, Michal Hocko wrote:
> 
> > > So, if I understand your concerns correct this implementation has two
> > > issues:
> > > 1) allocation failure at page fault that causes unrecoverable OOM and
> > > 2) a possibility for an unprivileged user to deplete secretmem pool and
> > > cause (1) to others
> > >
> > > I'm not really familiar with OOM internals, but when I simulated an
> > > allocation failure in my testing only the allocating process and it's
> > > parent were OOM-killed and then the system continued normally.
> >
> > If you kill the allocating process then yes, it would work, but your
> > process might be the very last to be selected.
> 
> OOMs are different if you have a "constrained allocation". In that case it
> is the fault of the process who wanted memory with certain conditions.
> That memory is not available. General memory is available though. In that
> case the allocating process is killed.

I do not see this implementation would do anything like that. Neither
anything like that implemented in the oom killer. Constrained
allocations (cpusets/memcg/mempolicy) only do restrict their selection
to processes which belong to the same domain. So I am not really sure
what you are referring to. The is only a global knob to _always_ kill
the allocating process on OOM.

-- 
Michal Hocko
SUSE Labs
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
