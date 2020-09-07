Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 744E625F5E1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Sep 2020 11:00:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2D81F13A5DD18;
	Mon,  7 Sep 2020 02:00:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 77D0D139E64D8
	for <linux-nvdimm@lists.01.org>; Mon,  7 Sep 2020 02:00:39 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id DC6C6AD56;
	Mon,  7 Sep 2020 09:00:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id E3FFA1E12D1; Mon,  7 Sep 2020 11:00:37 +0200 (CEST)
Date: Mon, 7 Sep 2020 11:00:37 +0200
From: Jan Kara <jack@suse.cz>
To: Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 1/2] ext2: don't update mtime on COW faults
Message-ID: <20200907090037.GB16559@quack2.suse.cz>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050811200.12419@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2009050811200.12419@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 773OWM2TGW5HJRRLBJNVDGH4HCBZWRGS
X-Message-ID-Hash: 773OWM2TGW5HJRRLBJNVDGH4HCBZWRGS
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Dave Chinner <dchinner@redhat.com>, Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>, Oleg Nesterov <oleg@redhat.com>, Kirill Shutemov <kirill@shutemov.name>, Theodore Ts'o <tytso@mit.edu>, Andrea Arcangeli <aarcange@redhat.com>, Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/773OWM2TGW5HJRRLBJNVDGH4HCBZWRGS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat 05-09-20 08:12:01, Mikulas Patocka wrote:
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the ext2 filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.
> 
> This breaks building of the Linux kernel.
> How to reproduce:
> 1. extract the Linux kernel tree on dax-mounted ext2 filesystem
> 2. run make clean
> 3. run make -j12
> 4. run make -j12
> - at step 4, make would incorrectly rebuild the whole kernel (although it
>   was already built in step 3).
> 
> The reason for the breakage is that almost all object files depend on
> objtool. When we run objtool, it takes COW page fault on its .data
> section, and these faults will incorrectly update the timestamp of the
> objtool binary. The updated timestamp causes make to rebuild the whole
> tree.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org

Thanks. Good spotting! Linus has already merged this so nothing more to do
here.

								Honza

> 
> ---
>  fs/ext2/file.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/fs/ext2/file.c
> ===================================================================
> --- linux-2.6.orig/fs/ext2/file.c	2020-09-05 10:01:41.000000000 +0200
> +++ linux-2.6/fs/ext2/file.c	2020-09-05 13:09:50.000000000 +0200
> @@ -93,8 +93,10 @@ static vm_fault_t ext2_dax_fault(struct
>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>  	struct ext2_inode_info *ei = EXT2_I(inode);
>  	vm_fault_t ret;
> +	bool write = (vmf->flags & FAULT_FLAG_WRITE) &&
> +		(vmf->vma->vm_flags & VM_SHARED);
>  
> -	if (vmf->flags & FAULT_FLAG_WRITE) {
> +	if (write) {
>  		sb_start_pagefault(inode->i_sb);
>  		file_update_time(vmf->vma->vm_file);
>  	}
> @@ -103,7 +105,7 @@ static vm_fault_t ext2_dax_fault(struct
>  	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
>  
>  	up_read(&ei->dax_sem);
> -	if (vmf->flags & FAULT_FLAG_WRITE)
> +	if (write)
>  		sb_end_pagefault(inode->i_sb);
>  	return ret;
>  }
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
