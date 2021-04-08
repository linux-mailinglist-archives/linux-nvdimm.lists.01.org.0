Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2277E35901F
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 01:04:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62C99100EAB6E;
	Thu,  8 Apr 2021 16:04:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7D621100EAB6A
	for <linux-nvdimm@lists.01.org>; Thu,  8 Apr 2021 16:04:53 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D384561008;
	Thu,  8 Apr 2021 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1617923092;
	bh=gAipAkTN6AtEe1gij2s1vx61dm91467A68DAZyZCvVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH3UphuNtw6xsYLk53E2CzGC2Ceth2lPveEwnvqFfhH9LYH2BSOCMC5OD1RMf1ppm
	 mFSpAS/E1KLUZCqjtA/XahEgOhaA+kxpzj7rUcUQ99v8W0p+2vy8UOjCbI4nkOMeWi
	 +qR0w3hNA4Qa36M9JtPKk6tR6Ck0d2EngNGdI9QGMf3qpYfbK68ocMvycqW3nsbcbt
	 FaFno7zh1qsAf9m7dKdhSaZ1lNzE3G8BmnpRtL+SL6RXWgEs59HQJxLXgk8yFy0NBl
	 VJHC1U4l0xsM0NMG0tNaN0bqQ8GTGZ8RE+FNe2szPXkt/eFqqNFWuFOVeCX9i8KhMz
	 CV3M5lwPJ7jAQ==
Date: Thu, 8 Apr 2021 16:04:51 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Message-ID: <20210408230451.GD3957620@magnolia>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408120432.1063608-8-ruansy.fnst@fujitsu.com>
Message-ID-Hash: JDKOBKHDSQPRIQ6HOOOTTO2ZOZISV5OG
X-Message-ID-Hash: JDKOBKHDSQPRIQ6HOOOTTO2ZOZISV5OG
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JDKOBKHDSQPRIQ6HOOOTTO2ZOZISV5OG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 08, 2021 at 08:04:32PM +0800, Shiyang Ruan wrote:
> Add xfs_break_two_dax_layouts() to break layout for tow dax files.  Then
> call compare range function only when files are both DAX or not.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/xfs/xfs_file.c    | 20 ++++++++++++++++++++
>  fs/xfs/xfs_inode.c   |  8 +++++++-
>  fs/xfs/xfs_inode.h   |  1 +
>  fs/xfs/xfs_reflink.c |  5 +++--
>  4 files changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5795d5d6f869..1fd457167c12 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -842,6 +842,26 @@ xfs_break_dax_layouts(
>  			0, 0, xfs_wait_dax_page(inode));
>  }
>  
> +int
> +xfs_break_two_dax_layouts(
> +	struct inode		*src,
> +	struct inode		*dest)
> +{
> +	int			error;
> +	bool			retry = false;
> +
> +retry:
> +	error = xfs_break_dax_layouts(src, &retry);
> +	if (error || retry)
> +		goto retry;
> +
> +	error = xfs_break_dax_layouts(dest, &retry);
> +	if (error || retry)
> +		goto retry;
> +
> +	return error;
> +}
> +
>  int
>  xfs_break_layouts(
>  	struct inode		*inode,
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index f93370bd7b1e..c01786917eef 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -3713,8 +3713,10 @@ xfs_ilock2_io_mmap(
>  	struct xfs_inode	*ip2)
>  {
>  	int			ret;
> +	struct inode		*inode1 = VFS_I(ip1);
> +	struct inode		*inode2 = VFS_I(ip2);
>  
> -	ret = xfs_iolock_two_inodes_and_break_layout(VFS_I(ip1), VFS_I(ip2));
> +	ret = xfs_iolock_two_inodes_and_break_layout(inode1, inode2);
>  	if (ret)
>  		return ret;
>  	if (ip1 == ip2)
> @@ -3722,6 +3724,10 @@ xfs_ilock2_io_mmap(
>  	else
>  		xfs_lock_two_inodes(ip1, XFS_MMAPLOCK_EXCL,
>  				    ip2, XFS_MMAPLOCK_EXCL);
> +
> +	if (IS_DAX(inode1) && IS_DAX(inode2))
> +		ret = xfs_break_two_dax_layouts(inode1, inode2);

This is wrong on many levels.

The first problem is that xfs_break_two_dax_layouts calls
xfs_break_dax_layouts twice even if inode1 == inode2, which is
unnecessary.

The second problem is that xfs_break_dax_layouts can cycle the MMAPLOCK
on the inode that it's processing.  Since there are two inodes in play
here, you must be /very/ careful about maintaining correct locking order,
which for the MMAPLOCK is increasing order of xfs_inode.i_ino.  If you
drop the MMAPLOCK for the lower-numbered inode for any reason, you have
to drop both MMAPLOCKs and try again.

In other words, you have to replace all that nice MMAPLOCK code with a
new xfs_mmaplock_two_inodes_and_break_dax_layouts function that is
structured similarly to what xfs_iolock_two_inodes_and_break_layout
does for the IOLOCK and PNFS layouts.

> +
>  	return 0;
>  }
>  
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 88ee4c3930ae..5ef21924dddc 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -435,6 +435,7 @@ enum xfs_prealloc_flags {
>  
>  int	xfs_update_prealloc_flags(struct xfs_inode *ip,
>  				  enum xfs_prealloc_flags flags);
> +int	xfs_break_two_dax_layouts(struct inode *inode1, struct inode *inode2);
>  int	xfs_break_layouts(struct inode *inode, uint *iolock,
>  		enum layout_break_reason reason);
>  
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index a4cd6e8a7aa0..4426bcc8a985 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -29,6 +29,7 @@
>  #include "xfs_iomap.h"
>  #include "xfs_sb.h"
>  #include "xfs_ag_resv.h"
> +#include <linux/dax.h>

Why is this necessary?

--D

>  
>  /*
>   * Copy on Write of Shared Blocks
> @@ -1324,8 +1325,8 @@ xfs_reflink_remap_prep(
>  	if (XFS_IS_REALTIME_INODE(src) || XFS_IS_REALTIME_INODE(dest))
>  		goto out_unlock;
>  
> -	/* Don't share DAX file data for now. */
> -	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> +	/* Don't share DAX file data with non-DAX file. */
> +	if (IS_DAX(inode_in) != IS_DAX(inode_out))
>  		goto out_unlock;
>  
>  	if (!IS_DAX(inode_in))
> -- 
> 2.31.0
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
