Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E298C26A100
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 10:37:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0421B141048F6;
	Tue, 15 Sep 2020 01:37:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BFD70141048F4
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 01:37:18 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B4E16AFA9;
	Tue, 15 Sep 2020 08:37:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 025AB1E12EF; Tue, 15 Sep 2020 10:37:16 +0200 (CEST)
Date: Tue, 15 Sep 2020 10:37:16 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH 1/1] dax: Fix stack overflow when mounting fsdax pmem
 device
Message-ID: <20200915083716.GA29863@quack2.suse.cz>
References: <20200915075729.12518-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915075729.12518-1-adrianhuang0701@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: P4SC5YWCLMJHM3M4WKTK6FJCNATJRGA7
X-Message-ID-Hash: P4SC5YWCLMJHM3M4WKTK6FJCNATJRGA7
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/P4SC5YWCLMJHM3M4WKTK6FJCNATJRGA7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 15-09-20 15:57:29, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> When mounting fsdax pmem device, commit 6180bb446ab6 ("dax: fix
> detection of dax support for non-persistent memory block devices")
> introduces the stack overflow [1][2]. Here is the call path for
> mounting ext4 file system:
>   ext4_fill_super
>     bdev_dax_supported
>       __bdev_dax_supported
>         dax_supported
>           generic_fsdax_supported
>             __generic_fsdax_supported
>               bdev_dax_supported
> 
> The call path leads to the infinite calling loop, so we cannot
> call bdev_dax_supported() in __generic_fsdax_supported(). The sanity
> checking of the variable 'dax_dev' is moved prior to the two
> bdev_dax_pgoff() checks [3][4].
> 
> To fix the issue triggered by lvm2-testsuite (the issue that the
> above-mentioned commit wants to fix), this patch does not print the
> "error: dax access failed" message if the physical disk does not
> support DAX (dax_dev is NULL). The detail info is described as follows:

Thanks for looking into this!

> 
>   1. The dax_dev of the dm devices (dm-0, dm-1..) is always allocated
>      in alloc_dev() [drivers/md/dm.c].
>   2. When calling __generic_fsdax_supported() with dm-0 device, the
>      call path is shown as follows (the physical disks of dm-0 do
>      not support DAX):
>         dax_direct_access (valid dax_dev with dm-0)
>           dax_dev->ops->direct_access
>             dm_dax_direct_access
>               ti->type->direct_access
>                 linear_dax_direct_access (assume the target is linear)
>                   dax_direct_access (dax_dev is NULLL with ram0, or sdaX)

I'm not sure how you can get __generic_fsdax_supported() called for dm-0?
Possibly because there's another dm device stacked on top of it and
dm_table_supports_dax() calls generic_fsdax_supported()? That actually
seems to be a bug in dm_table_supports_dax() (device_supports_dax() in
particular). I'd think it should be calling dax_supported() instead of
generic_fsdax_supported() so that proper device callback gets called when
determining whether a device supports DAX or not.

>   3. The call 'dax_direct_access()' in __generic_fsdax_supported() gets
>      the returned value '-EOPNOTSUPP'.

I don't think this should happen under any normal conditions after the
above bug is fixed. -EOPNOTSUPP is returned when dax_dev is NULL and that
should have been caught earlier... So at this poing I don't think your
changes to printing errors after dax_direct_access() are needed.

								Honza

>   4. However, the message 'dm-3: error: dax access failed (-5)' is still
>      printed for the dm target 'error' since io_err_dax_direct_access()
>      always returns the status '-EIO'. Cc' device mapper maintainers to
>      see if they have concerns.
> 
> [1] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/
> [2] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/
> [3] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/
> [4] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/
> 
> Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
> Cc: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Pittman <jpittman@redhat.com>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/dax/super.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e5767c83ea23..fb151417ec10 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -85,6 +85,12 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  		return false;
>  	}
>  
> +	if (!dax_dev) {
> +		pr_debug("%s: error: dax unsupported by block device\n",
> +				bdevname(bdev, buf));
> +		return false;
> +	}
> +
>  	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
>  	if (err) {
>  		pr_info("%s: error: unaligned partition for dax\n",
> @@ -100,19 +106,22 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  		return false;
>  	}
>  
> -	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
> -		pr_debug("%s: error: dax unsupported by block device\n",
> -				bdevname(bdev, buf));
> -		return false;
> -	}
> -
>  	id = dax_read_lock();
>  	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
>  	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
>  
>  	if (len < 1 || len2 < 1) {
> -		pr_info("%s: error: dax access failed (%ld)\n",
> +		/*
> +		 * Only print the real error message: do not need to print
> +		 * the message for the underlying raw disk (physical disk)
> +		 * that does not support DAX (dax_dev = NULL). This case
> +		 * is observed when physical disks are configured by
> +		 * lvm2 (device mapper).
> +		 */
> +		if (len != -EOPNOTSUPP && len2 != -EOPNOTSUPP) {
> +			pr_info("%s: error: dax access failed (%ld)\n",
>  				bdevname(bdev, buf), len < 1 ? len : len2);
> +		}
>  		dax_read_unlock(id);
>  		return false;
>  	}
> -- 
> 2.17.1
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
