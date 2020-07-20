Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F340C2270CF
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 23:39:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0A4E212405A26;
	Mon, 20 Jul 2020 14:39:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=216.12.86.13; helo=brightrain.aerifal.cx; envelope-from=dalias@libc.org; receiver=<UNKNOWN> 
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
	(using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B178012405A21
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 14:39:33 -0700 (PDT)
Date: Mon, 20 Jul 2020 17:39:13 -0400
From: Rich Felker <dalias@libc.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 3/6] sh/mm: use default dummy
 memory_add_physaddr_to_nid()
Message-ID: <20200720213913.GM14669@brightrain.aerifal.cx>
References: <20200709020629.91671-1-justin.he@arm.com>
 <20200709020629.91671-4-justin.he@arm.com>
 <f1a172b2-80c2-1ec7-483f-f3fba761ccb0@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1a172b2-80c2-1ec7-483f-f3fba761ccb0@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Message-ID-Hash: J5P5W6TGCPSWGCFQN2QTBYVBRLCKATGB
X-Message-ID-Hash: J5P5W6TGCPSWGCFQN2QTBYVBRLCKATGB
X-MailFrom: dalias@libc.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jia He <justin.he@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Chuhong Yuan <hslester96@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Kaly Xin <Kaly.Xin@arm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J5P5W6TGCPSWGCFQN2QTBYVBRLCKATGB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jul 09, 2020 at 11:10:36AM +0200, David Hildenbrand wrote:
> On 09.07.20 04:06, Jia He wrote:
> > After making default memory_add_physaddr_to_nid in mm/memory_hotplug,
> > there is no use to define a similar one in arch specific directory.
> > 
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  arch/sh/mm/init.c | 9 ---------
> >  1 file changed, 9 deletions(-)
> > 
> > diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> > index a70ba0fdd0b3..f75932ba87a6 100644
> > --- a/arch/sh/mm/init.c
> > +++ b/arch/sh/mm/init.c
> > @@ -430,15 +430,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >  	return ret;
> >  }
> >  
> > -#ifdef CONFIG_NUMA
> > -int memory_add_physaddr_to_nid(u64 addr)
> > -{
> > -	/* Node 0 for now.. */
> > -	return 0;
> > -}
> > -EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> > -#endif
> > -
> >  void arch_remove_memory(int nid, u64 start, u64 size,
> >  			struct vmem_altmap *altmap)
> >  {
> > 
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Acked-by: Rich Felker <dalias@libc.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
