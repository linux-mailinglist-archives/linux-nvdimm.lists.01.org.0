Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359C2313750
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 16:24:39 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86503100EB35F;
	Mon,  8 Feb 2021 07:24:37 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FBFB100EBBCE
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 07:24:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3C0C868AFE; Mon,  8 Feb 2021 16:24:31 +0100 (CET)
Date: Mon, 8 Feb 2021 16:24:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 6/7] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210208152430.GF12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-7-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-7-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: KINVSZRO5YWZTZSO6W5DOORCM2SMKFNO
X-Message-ID-Hash: KINVSZRO5YWZTZSO6W5DOORCM2SMKFNO
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KINVSZRO5YWZTZSO6W5DOORCM2SMKFNO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -977,10 +977,14 @@ xfs_free_file_space(
>  	if (offset + len > XFS_ISIZE(ip))
>  		len = XFS_ISIZE(ip) - offset;
>  	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +		  IS_DAX(VFS_I(ip)) ?
> +		  &xfs_direct_write_iomap_ops : &xfs_buffered_write_iomap_ops);
>  	if (error)
>  		return error;
> +	if (xfs_is_reflink_inode(ip))
> +		xfs_reflink_end_cow(ip, offset, len);

Maybe we need to add (back) and xfs_zero_range helper that encapsulates
the details?

>  	trace_xfs_file_dax_write(ip, count, pos);
>  	ret = dax_iomap_rw(iocb, from, &xfs_direct_write_iomap_ops);
> -	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
> -		i_size_write(inode, iocb->ki_pos);
> -		error = xfs_setfilesize(ip, pos, ret);
> +	if (ret > 0) {
> +		if (iocb->ki_pos > i_size_read(inode)) {
> +			i_size_write(inode, iocb->ki_pos);
> +			error = xfs_setfilesize(ip, pos, ret);
> +		}
> +		if (xfs_is_cow_inode(ip))
> +			xfs_reflink_end_cow(ip, pos, ret);

Nitpick, but I'd just goto out for ret <= 0 to reduce the indentation a
bit.

>  	}
>  out:
>  	xfs_iunlock(ip, iolock);
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 7b9ff824e82d..d6d4cc0f084e 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -765,13 +765,14 @@ xfs_direct_write_iomap_begin(
>  		goto out_unlock;
>  
>  	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
> +		bool need_convert = flags & IOMAP_DIRECT || IS_DAX(inode);
>  		error = -EAGAIN;
>  		if (flags & IOMAP_NOWAIT)
>  			goto out_unlock;
>  
>  		/* may drop and re-acquire the ilock */
>  		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
> -				&lockmode, flags & IOMAP_DIRECT);
> +				&lockmode, need_convert);

Why not:

		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
				&lockmode,
				(flags & IOMAP_DIRECT) || IS_DAX(inode));

?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
