Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69B2EC0B3
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 16:55:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05E02100EB323;
	Wed,  6 Jan 2021 07:55:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1DE95100EBB67
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 07:55:34 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 73352AA35;
	Wed,  6 Jan 2021 15:55:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id DAFDD1E0812; Wed,  6 Jan 2021 16:55:32 +0100 (CET)
Date: Wed, 6 Jan 2021 16:55:32 +0100
From: Jan Kara <jack@suse.cz>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 05/10] mm, pmem: Implement ->memory_failure() in pmem
 driver
Message-ID: <20210106155532.GD29271@quack2.suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: K3MVPRCPZP7IKCF4YYKM7BT6RVL5ELSB
X-Message-ID-Hash: K3MVPRCPZP7IKCF4YYKM7BT6RVL5ELSB
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K3MVPRCPZP7IKCF4YYKM7BT6RVL5ELSB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 31-12-20 00:55:56, Shiyang Ruan wrote:
> Call the ->memory_failure() which is implemented by pmem driver, in
> order to finally notify filesystem to handle the corrupted data.  The
> old collecting and killing processes are moved into
> mf_dax_mapping_kill_procs(), which will be called by filesystem.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

I understand the intent but this patch breaks DAX hwpoison handling for
everybody at this point in the series (nobody implements ->memory_failure()
handler yet) so it is bisection unfriendly. This should really be the last
step in the series once all the other infrastructure is implemented.
Furthermore AFAIU it breaks DAX hwpoison handling terminally for all
filesystems which don't implement ->corrupted_range() - e.g. for ext4.
Your series needs to implement ->corrupted_range() for all filesystems
supporting DAX so that we don't regress current functionality...

								Honza

> ---
>  drivers/nvdimm/pmem.c | 24 +++++++++++++++++++++
>  mm/memory-failure.c   | 50 +++++--------------------------------------
>  2 files changed, 29 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 875076b0ea6c..4a114937c43b 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -363,9 +363,33 @@ static void pmem_release_disk(void *__pmem)
>  	put_disk(pmem->disk);
>  }
>  
> +static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
> +		unsigned long pfn, int flags)
> +{
> +	struct pmem_device *pdev;
> +	struct gendisk *disk;
> +	loff_t disk_offset;
> +	int rc = 0;
> +	unsigned long size = page_size(pfn_to_page(pfn));
> +
> +	pdev = container_of(pgmap, struct pmem_device, pgmap);
> +	disk = pdev->disk;
> +	if (!disk)
> +		return -ENXIO;
> +
> +	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
> +	if (disk->fops->corrupted_range) {
> +		rc = disk->fops->corrupted_range(disk, NULL, disk_offset, size, &flags);
> +		if (rc == -ENODEV)
> +			rc = -ENXIO;
> +	}
> +	return rc;
> +}
> +
>  static const struct dev_pagemap_ops fsdax_pagemap_ops = {
>  	.kill			= pmem_pagemap_kill,
>  	.cleanup		= pmem_pagemap_cleanup,
> +	.memory_failure		= pmem_pagemap_memory_failure,
>  };
>  
>  static int pmem_attach_disk(struct device *dev,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 37bc6e2a9564..0109ad607fb8 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1269,28 +1269,11 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		struct dev_pagemap *pgmap)
>  {
>  	struct page *page = pfn_to_page(pfn);
> -	const bool unmap_success = true;
> -	unsigned long size = 0;
> -	struct to_kill *tk;
> -	LIST_HEAD(to_kill);
>  	int rc = -EBUSY;
> -	loff_t start;
> -	dax_entry_t cookie;
> -
> -	/*
> -	 * Prevent the inode from being freed while we are interrogating
> -	 * the address_space, typically this would be handled by
> -	 * lock_page(), but dax pages do not use the page lock. This
> -	 * also prevents changes to the mapping of this pfn until
> -	 * poison signaling is complete.
> -	 */
> -	cookie = dax_lock_page(page);
> -	if (!cookie)
> -		goto out;
>  
>  	if (hwpoison_filter(page)) {
>  		rc = 0;
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> @@ -1298,7 +1281,7 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  		 * TODO: Handle HMM pages which may need coordination
>  		 * with device-side memory.
>  		 */
> -		goto unlock;
> +		goto out;
>  	}
>  
>  	/*
> @@ -1307,33 +1290,10 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	 */
>  	SetPageHWPoison(page);
>  
> -	/*
> -	 * Unlike System-RAM there is no possibility to swap in a
> -	 * different physical page at a given virtual address, so all
> -	 * userspace consumption of ZONE_DEVICE memory necessitates
> -	 * SIGBUS (i.e. MF_MUST_KILL)
> -	 */
> -	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
> -	collect_procs_file(page, page->mapping, page->index, &to_kill,
> -			   flags & MF_ACTION_REQUIRED);
> +	/* call driver to handle the memory failure */
> +	if (pgmap->ops->memory_failure)
> +		rc = pgmap->ops->memory_failure(pgmap, pfn, flags);
>  
> -	list_for_each_entry(tk, &to_kill, nd)
> -		if (tk->size_shift)
> -			size = max(size, 1UL << tk->size_shift);
> -	if (size) {
> -		/*
> -		 * Unmap the largest mapping to avoid breaking up
> -		 * device-dax mappings which are constant size. The
> -		 * actual size of the mapping being torn down is
> -		 * communicated in siginfo, see kill_proc()
> -		 */
> -		start = (page->index << PAGE_SHIFT) & ~(size - 1);
> -		unmap_mapping_range(page->mapping, start, start + size, 0);
> -	}
> -	kill_procs(&to_kill, flags & MF_MUST_KILL, !unmap_success, pfn, flags);
> -	rc = 0;
> -unlock:
> -	dax_unlock_page(page, cookie);
>  out:
>  	/* drop pgmap ref acquired in caller */
>  	put_dev_pagemap(pgmap);
> -- 
> 2.29.2
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
