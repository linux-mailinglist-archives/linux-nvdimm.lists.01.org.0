Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB89246D76
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Aug 2020 18:57:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6CA2132DBAE2;
	Mon, 17 Aug 2020 09:57:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75015132DBAE0
	for <linux-nvdimm@lists.01.org>; Mon, 17 Aug 2020 09:57:33 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 2326AADE5;
	Mon, 17 Aug 2020 16:57:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id BD1611E12CB; Mon, 17 Aug 2020 18:57:31 +0200 (CEST)
Date: Mon, 17 Aug 2020 18:57:31 +0200
From: Jan Kara <jack@suse.cz>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 01/20] dax: Modify bdev_dax_pgoff() to handle NULL bdev
Message-ID: <20200817165731.GB22500@quack2.suse.cz>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807195526.426056-2-vgoyal@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: YCN6RIB2IOWTOBQL7TEQ5RESVWXJKV4W
X-Message-ID-Hash: YCN6RIB2IOWTOBQL7TEQ5RESVWXJKV4W
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YCN6RIB2IOWTOBQL7TEQ5RESVWXJKV4W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri 07-08-20 15:55:07, Vivek Goyal wrote:
> virtiofs does not have a block device but it has dax device.
> Modify bdev_dax_pgoff() to be able to handle that.
> 
> If there is no bdev, that means dax offset is 0. (It can't be a partition
> block device starting at an offset in dax device).
> 
> This is little hackish. There have been discussions about getting rid
> of dax not supporting partitions.
> 
> https://lore.kernel.org/linux-fsdevel/20200107125159.GA15745@infradead.org/
> 
> IMHO, this path can easily break exisitng users. For example
> ioctl(BLKPG_ADD_PARTITION) will start breaking on block devices
> supporting DAX. Also, I personally find it very useful to be able to
> partition dax devices and still be able to use DAX.
> 
> Alternatively, I tried to store offset into dax device information in iomap
> interface, but that got NACKed.
> 
> https://lore.kernel.org/linux-fsdevel/20200217133117.GB20444@infradead.org/
> 
> I can't think of a good path to solve this issue properly. So to make
> progress, it seems this patch is least bad option for now and I hope
> we can take it.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: linux-nvdimm@lists.01.org

This patch looks OK to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/dax/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 8e32345be0f7..c4bec437e88b 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -46,7 +46,8 @@ EXPORT_SYMBOL_GPL(dax_read_unlock);
>  int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
>  		pgoff_t *pgoff)
>  {
> -	phys_addr_t phys_off = (get_start_sect(bdev) + sector) * 512;
> +	sector_t start_sect = bdev ? get_start_sect(bdev) : 0;
> +	phys_addr_t phys_off = (start_sect + sector) * 512;
>  
>  	if (pgoff)
>  		*pgoff = PHYS_PFN(phys_off);
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
