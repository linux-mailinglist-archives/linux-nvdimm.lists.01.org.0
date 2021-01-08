Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F4F2EF039
	for <lists+linux-nvdimm@lfdr.de>; Fri,  8 Jan 2021 10:56:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 80CF8100EA2AB;
	Fri,  8 Jan 2021 01:56:19 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 18206100EA2AA
	for <linux-nvdimm@lists.01.org>; Fri,  8 Jan 2021 01:56:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0C03967373; Fri,  8 Jan 2021 10:56:15 +0100 (CET)
Date: Fri, 8 Jan 2021 10:56:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 03/10] fs: Introduce ->corrupted_range() for superblock
Message-ID: <20210108095614.GB5647@lst.de>
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com> <20201230165601.845024-4-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201230165601.845024-4-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: IE2XBEAL27PFJFITJHWUCIUC5R2MTM7X
X-Message-ID-Hash: IE2XBEAL27PFJFITJHWUCIUC5R2MTM7X
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, song@kernel.org, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IE2XBEAL27PFJFITJHWUCIUC5R2MTM7X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 31, 2020 at 12:55:54AM +0800, Shiyang Ruan wrote:
> Memory failure occurs in fsdax mode will finally be handled in
> filesystem.  We introduce this interface to find out files or metadata
> affected by the corrupted range, and try to recover the corrupted data
> if possiable.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  include/linux/fs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8667d0cdc71e..282e2139b23e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1965,6 +1965,8 @@ struct super_operations {
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
>  				    struct shrink_control *);
> +	int (*corrupted_range)(struct super_block *sb, struct block_device *bdev,

This adds an overly long line.  But more importantly it must work on
the dax device and not the block device.  I'd also structure the callback
so that it is called on the dax device only, with the file system storing
the super block in a private data member.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
