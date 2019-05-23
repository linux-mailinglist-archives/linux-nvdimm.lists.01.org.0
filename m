Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6EB27E7E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 23 May 2019 15:44:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C349F21276B86;
	Thu, 23 May 2019 06:44:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C7EEA212532F0
 for <linux-nvdimm@lists.01.org>; Thu, 23 May 2019 06:44:51 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6207AAC6E;
 Thu, 23 May 2019 13:44:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 010F11E3C69; Thu, 23 May 2019 15:44:49 +0200 (CEST)
Date: Thu, 23 May 2019 15:44:49 +0200
From: Jan Kara <jack@suse.cz>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: Re: [PATCH 12/18] btrfs: allow MAP_SYNC mmap
Message-ID: <20190523134449.GC2949@quack2.suse.cz>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-13-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-13-rgoldwyn@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: kilobyte@angband.pl, jack@suse.cz, darrick.wong@oracle.com,
 nborisov@suse.com, linux-nvdimm@lists.01.org, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 linux-fsdevel@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon 29-04-19 12:26:43, Goldwyn Rodrigues wrote:
> From: Adam Borowski <kilobyte@angband.pl>
> 
> Used by userspace to detect DAX.
> [rgoldwyn@suse.com: Added CONFIG_FS_DAX around mmap_supported_flags]

Why the CONFIG_FS_DAX bit? Your mmap(2) implementation understands
implications of MAP_SYNC flag and that's all that's needed to set
.mmap_supported_flags.

								Honza

> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9d5a3c99a6b9..362a9cf9dcb2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -16,6 +16,7 @@
>  #include <linux/btrfs.h>
>  #include <linux/uio.h>
>  #include <linux/iversion.h>
> +#include <linux/mman.h>
>  #include "ctree.h"
>  #include "disk-io.h"
>  #include "transaction.h"
> @@ -3319,6 +3320,9 @@ const struct file_operations btrfs_file_operations = {
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> +#ifdef CONFIG_FS_DAX
> +	.mmap_supported_flags = MAP_SYNC,
> +#endif
>  	.open		= btrfs_file_open,
>  	.release	= btrfs_release_file,
>  	.fsync		= btrfs_sync_file,
> -- 
> 2.16.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
