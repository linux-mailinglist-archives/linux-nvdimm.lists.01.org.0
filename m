Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EAF216C82
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 14:07:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4D7B1108DED2;
	Tue,  7 Jul 2020 05:06:58 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DC74B1108DEAA
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 05:06:56 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 25CCBAE53;
	Tue,  7 Jul 2020 12:06:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 7AB361E12AF; Tue,  7 Jul 2020 14:06:54 +0200 (CEST)
Date: Tue, 7 Jul 2020 14:06:54 +0200
From: Jan Kara <jack@suse.cz>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH] dax: print error message by pr_info() in
 __generic_fsdax_supported()
Message-ID: <20200707120654.GB25069@quack2.suse.cz>
References: <20200706172626.5554-1-colyli@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200706172626.5554-1-colyli@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: TJOAGCHFQ3QPVDDSBQYGRK53PMQ4QCBQ
X-Message-ID-Hash: TJOAGCHFQ3QPVDDSBQYGRK53PMQ4QCBQ
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Michal Suchanek <msuchanek@suse.com>, Jan Kara <jack@suse.com>, Anthony Iliopoulos <ailiopoulos@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TJOAGCHFQ3QPVDDSBQYGRK53PMQ4QCBQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 07-07-20 01:26:26, Coly Li wrote:
> In struct dax_operations, the callback routine dax_supported() returns
> a bool type result. For false return value, the caller has no idea
> whether the device does not support dax at all, or it is just some mis-
> configuration issue.
> 
> An example is formatting an Ext4 file system on pmem device on top of
> a NVDIMM namespace by,
>  # mkfs.ext4 /dev/pmem0
> If the fs block size does not match kernel space memory page size (which
> is possible on non-x86 platform), mount this Ext4 file system will fail,
>   # mount -o dax /dev/pmem0 /mnt
>   mount: /mnt: wrong fs type, bad option, bad superblock on /dev/pmem0,
>   missing codepage or helper program, or other error.
> And from the dmesg output there is only the following information,
>   [  307.853148] EXT4-fs (pmem0): DAX unsupported by block device.
> 
> The above information is quite confusing. Because definiately the pmem0
> device supports dax operation, and the super block is consistent as how
> it was created by mkfs.ext4.
> 
> Indeed the failure is from __generic_fsdax_supported() by the following
> code piece,
>         if (blocksize != PAGE_SIZE) {
>                pr_debug("%s: error: unsupported blocksize for dax\n",
>                                 bdevname(bdev, buf));
>                 return false;
>         }
> It is because the Ext4 block size is 4KB and kernel page size is 8KB or
> 16KB.
> 
> It is not simple to make dax_supported() from struct dax_operations
> or __generic_fsdax_supported() to return exact failure type right now.
> So the simplest fix is to use pr_info() to print all the error messages
> inside __generic_fsdax_supported(). Then users may find informative clue
> from the kernel message at least.
> 
> Message printed by pr_debug() is very easy to be ignored by users. This
> patch prints error message by pr_info() in __generic_fsdax_supported(),
> when then mount fails, following lines can be found from dmesg output,
>  [ 2705.500885] pmem0: error: unsupported blocksize for dax
>  [ 2705.500888] EXT4-fs (pmem0): DAX unsupported by block device.
> Now the users may have idea the mount failure is from pmem driver for
> unsupported block size.
> 
> Reported-by: Michal Suchanek <msuchanek@suse.com>
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Anthony Iliopoulos <ailiopoulos@suse.com>

Yes, the patch looks good to me. There's just the slight concern that
somebody could call bdev_dax_supported() frequently (e.g. on each ioctl(2)
call) and that would then spam the logs but currently it is only ever
called from the mount functions so printing the message does the right
thing and I think it is a usability improvement... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/dax/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 8e32345be0f7..de0d02ec0347 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -80,14 +80,14 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  	int err, id;
>  
>  	if (blocksize != PAGE_SIZE) {
> -		pr_debug("%s: error: unsupported blocksize for dax\n",
> +		pr_info("%s: error: unsupported blocksize for dax\n",
>  				bdevname(bdev, buf));
>  		return false;
>  	}
>  
>  	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
>  	if (err) {
> -		pr_debug("%s: error: unaligned partition for dax\n",
> +		pr_info("%s: error: unaligned partition for dax\n",
>  				bdevname(bdev, buf));
>  		return false;
>  	}
> @@ -95,7 +95,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
>  	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
>  	if (err) {
> -		pr_debug("%s: error: unaligned partition for dax\n",
> +		pr_info("%s: error: unaligned partition for dax\n",
>  				bdevname(bdev, buf));
>  		return false;
>  	}
> @@ -106,7 +106,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  	dax_read_unlock(id);
>  
>  	if (len < 1 || len2 < 1) {
> -		pr_debug("%s: error: dax access failed (%ld)\n",
> +		pr_info("%s: error: dax access failed (%ld)\n",
>  				bdevname(bdev, buf), len < 1 ? len : len2);
>  		return false;
>  	}
> @@ -139,7 +139,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
>  	}
>  
>  	if (!dax_enabled) {
> -		pr_debug("%s: error: dax support not enabled\n",
> +		pr_info("%s: error: dax support not enabled\n",
>  				bdevname(bdev, buf));
>  		return false;
>  	}
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
