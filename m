Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C52E9A28
	for <lists+linux-nvdimm@lfdr.de>; Mon,  4 Jan 2021 17:12:42 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2EE8100EC1DF;
	Mon,  4 Jan 2021 08:12:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7481B100EC1CD
	for <linux-nvdimm@lists.01.org>; Mon,  4 Jan 2021 08:12:37 -0800 (PST)
IronPort-SDR: N86Dii2MFo9YsvCAZ0hqj/AxyBfNB9eAKIll4gxGyBxHYsa5jFrvUMOOsF8Tuyuyj4QR9r4Gge
 lI3rtsodG24Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="176192300"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400";
   d="scan'208";a="176192300"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:12:36 -0800
IronPort-SDR: G4qPXJ/u5P7tzi0LQVR3bnnVjEt8/+JF5VfHTuJGXPNUaBkbM3EQCfJ8JGG7X1LE/P/0DsZhkr
 CrUb9zAWHYxg==
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400";
   d="scan'208";a="378471325"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 08:12:36 -0800
Date: Mon, 4 Jan 2021 08:12:36 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] fs/dax: include <asm/page.h> to fix build error on ARC
Message-ID: <20210104161236.GE3097896@iweiny-DESK2.sc.intel.com>
References: <20210101042914.5313-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210101042914.5313-1-rdunlap@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: R2KR3GQCV36QCCSNKQPHEHWAT222HCII
X-Message-ID-Hash: R2KR3GQCV36QCCSNKQPHEHWAT222HCII
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Vineet Gupta <vgupts@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R2KR3GQCV36QCCSNKQPHEHWAT222HCII/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 31, 2020 at 08:29:14PM -0800, Randy Dunlap wrote:
> fs/dax.c uses copy_user_page() but ARC does not provide that interface,
> resulting in a build error.
> 
> Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
> add <asm/page.h> to fs/dax.c to fix the build error.
> 
> ../fs/dax.c: In function 'copy_cow_page_dax':
> ../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]
> 
> Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Looks reasonable
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Vineet Gupta <vgupts@synopsys.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> ---
> v2: rebase, add more Cc:
> 
>  arch/arc/include/asm/page.h |    1 +
>  fs/dax.c                    |    1 +
>  2 files changed, 2 insertions(+)
> 
> --- lnx-511-rc1.orig/fs/dax.c
> +++ lnx-511-rc1/fs/dax.c
> @@ -25,6 +25,7 @@
>  #include <linux/sizes.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/iomap.h>
> +#include <asm/page.h>
>  #include <asm/pgalloc.h>
>  
>  #define CREATE_TRACE_POINTS
> --- lnx-511-rc1.orig/arch/arc/include/asm/page.h
> +++ lnx-511-rc1/arch/arc/include/asm/page.h
> @@ -10,6 +10,7 @@
>  #ifndef __ASSEMBLY__
>  
>  #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
> +#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
>  #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
>  
>  struct vm_area_struct;
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
