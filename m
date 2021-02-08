Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E793136FB
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 16:19:27 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E055E100F226A;
	Mon,  8 Feb 2021 07:19:25 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 955E9100F2240
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 07:19:23 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id B592868AFE; Mon,  8 Feb 2021 16:19:20 +0100 (CET)
Date: Mon, 8 Feb 2021 16:19:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210208151920.GE12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: I5DLK74ZHZ3V7VIDEPVALRCDSFBLHNV7
X-Message-ID-Hash: I5DLK74ZHZ3V7VIDEPVALRCDSFBLHNV7
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I5DLK74ZHZ3V7VIDEPVALRCDSFBLHNV7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 08, 2021 at 01:09:22AM +0800, Shiyang Ruan wrote:
> With dax we cannot deal with readpage() etc. So, we create a
> funciton callback to perform the file data comparison and pass

s/funciton/function/g

> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))

This should use the existing min or min_t helpers.


>  int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  				  struct file *file_out, loff_t pos_out,
> -				  loff_t *len, unsigned int remap_flags)
> +				  loff_t *len, unsigned int remap_flags,
> +				  compare_range_t compare_range_fn)

Can we keep generic_remap_file_range_prep as-is, and add a new
dax_remap_file_range_prep, both sharing a low-level
__generic_remap_file_range_prep implementation?  And for that
implementation I'd also go for classic if/else instead of the function
pointer.

> +extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> +					 struct inode *dest, loff_t destoff,
> +					 loff_t len, bool *is_same);

no need for the extern.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
