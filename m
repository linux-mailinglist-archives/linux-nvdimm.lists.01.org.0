Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731D31682C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 14:41:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 50033100EAB05;
	Wed, 10 Feb 2021 05:41:07 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EDD2E100EAB5C
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 05:41:03 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 97BF768B02; Wed, 10 Feb 2021 14:41:00 +0100 (CET)
Date: Wed, 10 Feb 2021 14:41:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 06/11] mm, pmem: Implement ->memory_failure() in
 pmem driver
Message-ID: <20210210134100.GE30109@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-7-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208105530.3072869-7-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: EXA5ZZ6TMFCWRCXQ3JGZPBJCRCUWIQJR
X-Message-ID-Hash: EXA5ZZ6TMFCWRCXQ3JGZPBJCRCUWIQJR
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EXA5ZZ6TMFCWRCXQ3JGZPBJCRCUWIQJR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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

Would be nice to initialize this at the time of declaration:

	struct pmem_device *pdev =
		container_of(pgmap, struct pmem_device, pgmap);
	struct gendisk *disk = pdev->disk
	unsigned long size = page_size(pfn_to_page(pfn));

> +	if (!disk)
> +		return -ENXIO;
> +
> +	disk_offset = PFN_PHYS(pfn) - pdev->phys_addr - pdev->data_offset;
> +	if (disk->fops->corrupted_range) {
> +		rc = disk->fops->corrupted_range(disk, NULL, disk_offset,
> +						 size, &flags);
> +		if (rc == -ENODEV)
> +			rc = -ENXIO;
> +	} else
> +		rc = -EOPNOTSUPP;

Why do we need the disk and fops check here? A pgmap registered by pmem.c
should always have a disk with pmem_fops.  And more importantly this
has no business going through the block layer.

Instead the file system should deposit a callback when starting to use
the dax_device using fs_dax_get_by_bdev / dax_get_by_host and a private
data (the superblock), and we avoid all the lookup problems.

> +int mf_generic_kill_procs(unsigned long long pfn, int flags)

This function seems to be only used inside of memory-failure.c, so it
could be marked static.  Also I'd name it dax_generic_memory_failure
or something like that to match the naming of the ->memory_failure
pgmap operation.

Also maybe just splitting this out into a helper would be a nice prep
patch.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
