Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D0D32B644
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Mar 2021 10:43:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CD37100EB321;
	Wed,  3 Mar 2021 01:43:16 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1B4C1100EB85F
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 01:43:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EAEBC68D01; Wed,  3 Mar 2021 10:43:09 +0100 (CET)
Date: Wed, 3 Mar 2021 10:43:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Message-ID: <20210303094309.GB15389@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-10-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-10-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: ZAINR5FCJ7YT4GBVGHDCTQO4527DPFLU
X-Message-ID-Hash: ZAINR5FCJ7YT4GBVGHDCTQO4527DPFLU
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZAINR5FCJ7YT4GBVGHDCTQO4527DPFLU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 08:20:29AM +0800, Shiyang Ruan wrote:
>  	error = iomap_zero_range(VFS_I(ip), offset, len, NULL,
> -			&xfs_buffered_write_iomap_ops);
> +		  IS_DAX(VFS_I(ip)) ?
> +		  &xfs_dax_write_iomap_ops : &xfs_buffered_write_iomap_ops);

Please add a xfs_zero_range helper that picks the right iomap_ops
instead of open coding this in a few places.

> +static int
> +xfs_dax_write_iomap_end(
> +	struct inode		*inode,
> +	loff_t			pos,
> +	loff_t			length,
> +	ssize_t			written,
> +	unsigned int		flags,
> +	struct iomap		*iomap)
> +{
> +	int			error = 0;
> +	xfs_inode_t		*ip = XFS_I(inode);
> +
> +	if (pos + written > i_size_read(inode)) {
> +		i_size_write(inode, pos + written);
> +		error = xfs_setfilesize(ip, pos, written);
> +	}
> +	if (xfs_is_cow_inode(ip))
> +		error = xfs_reflink_end_cow(ip, pos, written);
> +
> +	return error;

What is the advantage of the ioemap_end handler here?  It adds another
indirect funtion call to the fast path, so if we can avoid it, I'd
rather do that.

Also, shouldn't we cancel the COW rather than finishing it when setting
the file size fails?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
