Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F7F26C3EE
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 17:00:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB54513FE81AA;
	Wed, 16 Sep 2020 08:00:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 85B7813FE81A8
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 08:00:14 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 3F569AC98;
	Wed, 16 Sep 2020 15:00:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 96E861E12E1; Wed, 16 Sep 2020 17:00:12 +0200 (CEST)
Date: Wed, 16 Sep 2020 17:00:12 +0200
From: Jan Kara <jack@suse.cz>
To: Adrian Huang <adrianhuang0701@gmail.com>
Subject: Re: [PATCH v2 1/1] dax: Fix stack overflow when mounting fsdax pmem
 device
Message-ID: <20200916150012.GI3607@quack2.suse.cz>
References: <20200916133923.31-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916133923.31-1-adrianhuang0701@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MLYEM3U3YQ4MBJ2FWCFLN6ITAJRVSGXW
X-Message-ID-Hash: MLYEM3U3YQ4MBJ2FWCFLN6ITAJRVSGXW
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, Coly Li <colyli@suse.de>, Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MLYEM3U3YQ4MBJ2FWCFLN6ITAJRVSGXW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 16-09-20 21:39:23, Adrian Huang wrote:
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
> [1] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/
> [2] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/
> [3] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/
> [4] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/
> 
> Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
> Cc: Coly Li <colyli@suse.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: John Pittman <jpittman@redhat.com>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1->v2
> * Remove the checking for the returned value '-EOPNOTSUPP' of
>   dax_direct_access(). Jan has prepared a patch to address the
>   issue in dm.
> ---
>  drivers/dax/super.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index e5767c83ea23..11d0541e6f8f 100644
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
> @@ -100,12 +106,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
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
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
