Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875062EC1DB
	for <lists+linux-nvdimm@lfdr.de>; Wed,  6 Jan 2021 18:14:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5503100EB326;
	Wed,  6 Jan 2021 09:14:33 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FF5F100EB323
	for <linux-nvdimm@lists.01.org>; Wed,  6 Jan 2021 09:14:31 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 05EF5ACAF;
	Wed,  6 Jan 2021 17:14:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id A0C771E0816; Wed,  6 Jan 2021 18:14:29 +0100 (CET)
Date: Wed, 6 Jan 2021 18:14:29 +0100
From: Jan Kara <jack@suse.cz>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 08/10] md: Implement ->corrupted_range()
Message-ID: <20210106171429.GE29271@quack2.suse.cz>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com>
 <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-9-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: O4CGJ6HJJ4F4ZTJYMPVTMRE2YNZY44QB
X-Message-ID-Hash: O4CGJ6HJJ4F4ZTJYMPVTMRE2YNZY44QB
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/O4CGJ6HJJ4F4ZTJYMPVTMRE2YNZY44QB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu 31-12-20 00:55:59, Shiyang Ruan wrote:
> With the support of ->rmap(), it is possible to obtain the superblock on
> a mapped device.
> 
> If a pmem device is used as one target of mapped device, we cannot
> obtain its superblock directly.  With the help of SYSFS, the mapped
> device can be found on the target devices.  So, we iterate the
> bdev->bd_holder_disks to obtain its mapped device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>

Thanks for the patch. Two comments below.

> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4688bff19c20..9f9a2f3bf73b 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -256,21 +256,16 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>  static int pmem_corrupted_range(struct gendisk *disk, struct block_device *bdev,
>  				loff_t disk_offset, size_t len, void *data)
>  {
> -	struct super_block *sb;
>  	loff_t bdev_offset;
>  	sector_t disk_sector = disk_offset >> SECTOR_SHIFT;
> -	int rc = 0;
> +	int rc = -ENODEV;
>  
>  	bdev = bdget_disk_sector(disk, disk_sector);
>  	if (!bdev)
> -		return -ENODEV;
> +		return rc;
>  
>  	bdev_offset = (disk_sector - get_start_sect(bdev)) << SECTOR_SHIFT;
> -	sb = get_super(bdev);
> -	if (sb && sb->s_op->corrupted_range) {
> -		rc = sb->s_op->corrupted_range(sb, bdev, bdev_offset, len, data);
> -		drop_super(sb);
> -	}
> +	rc = bd_corrupted_range(bdev, bdev_offset, bdev_offset, len, data);
>  
>  	bdput(bdev);
>  	return rc;

This (and the fs/block_dev.c change below) is just refining the function
you've implemented in the patch 6. I think it's confusing to split changes
like this - why not implement things correctly from the start in patch 6?

> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 9e84b1928b94..0e50f0e8e8af 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1171,6 +1171,27 @@ struct bd_holder_disk {
>  	int			refcnt;
>  };
>  
> +static int bd_disk_holder_corrupted_range(struct block_device *bdev, loff_t off,
> +					  size_t len, void *data)
> +{
> +	struct bd_holder_disk *holder;
> +	struct gendisk *disk;
> +	int rc = 0;
> +
> +	if (list_empty(&(bdev->bd_holder_disks)))
> +		return -ENODEV;

This will not compile for !CONFIG_SYSFS kernels. Not that it would be
common but still. Also I'm not sure whether using bd_holder_disks like this
is really the right thing to do (when it seems to be only a sysfs thing),
although admittedly I'm not aware of a better way of getting this
information.

								Honza

> +
> +	list_for_each_entry(holder, &bdev->bd_holder_disks, list) {
> +		disk = holder->disk;
> +		if (disk->fops->corrupted_range) {
> +			rc = disk->fops->corrupted_range(disk, bdev, off, len, data);
> +			if (rc != -ENODEV)
> +				break;
> +		}
> +	}
> +	return rc;
> +}
> +
>  static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>  						  struct gendisk *disk)
>  {
> @@ -1378,6 +1399,22 @@ void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
>  }
>  EXPORT_SYMBOL(bd_set_nr_sectors);
>  
> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off, loff_t bdev_off, size_t len, void *data)
> +{
> +	struct super_block *sb = get_super(bdev);
> +	int rc = 0;
> +
> +	if (!sb) {
> +		rc = bd_disk_holder_corrupted_range(bdev, disk_off, len, data);
> +		return rc;
> +	} else if (sb->s_op->corrupted_range)
> +		rc = sb->s_op->corrupted_range(sb, bdev, bdev_off, len, data);
> +	drop_super(sb);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(bd_corrupted_range);
> +
>  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
>  
>  int bdev_disk_changed(struct block_device *bdev, bool invalidate)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index ed06209008b8..42290470810d 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -376,6 +376,8 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose);
>  bool bdev_check_media_change(struct block_device *bdev);
>  int __invalidate_device(struct block_device *bdev, bool kill_dirty);
>  void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors);
> +int bd_corrupted_range(struct block_device *bdev, loff_t disk_off,
> +		       loff_t bdev_off, size_t len, void *data);
>  
>  /* for drivers/char/raw.c: */
>  int blkdev_ioctl(struct block_device *, fmode_t, unsigned, unsigned long);
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
