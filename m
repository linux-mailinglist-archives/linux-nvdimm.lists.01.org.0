Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42753136AC
	for <lists+linux-nvdimm@lfdr.de>; Mon,  8 Feb 2021 16:14:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5674D100F226A;
	Mon,  8 Feb 2021 07:14:25 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 733A5100F2268
	for <linux-nvdimm@lists.01.org>; Mon,  8 Feb 2021 07:14:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id D07EF68AFE; Mon,  8 Feb 2021 16:14:19 +0100 (CET)
Date: Mon, 8 Feb 2021 16:14:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 3/7] fsdax: Copy data before write
Message-ID: <20210208151419.GC12872@lst.de>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com> <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210207170924.2933035-4-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: WMMCAL5ZV77DW64ZZTPLTCFRDVURFG2Z
X-Message-ID-Hash: WMMCAL5ZV77DW64ZZTPLTCFRDVURFG2Z
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WMMCAL5ZV77DW64ZZTPLTCFRDVURFG2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>  	switch (iomap.type) {
>  	case IOMAP_MAPPED:
> +cow:
>  		if (iomap.flags & IOMAP_F_NEW) {
>  			count_vm_event(PGMAJFAULT);
>  			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
>  			major = VM_FAULT_MAJOR;
>  		}
>  		error = dax_iomap_direct_access(&iomap, pos, PAGE_SIZE,
> -						NULL, &pfn);
> +						&kaddr, &pfn);

Any chance you could look into factoring out this code into a helper
to avoid the goto magic, which is a little too convoluted?

>  	switch (iomap.type) {
>  	case IOMAP_MAPPED:
> +cow:
>  		error = dax_iomap_direct_access(&iomap, pos, PMD_SIZE,
> -						NULL, &pfn);
> +						&kaddr, &pfn);
>  		if (error < 0)
>  			goto finish_iomap;
>  
>  		entry = dax_insert_entry(&xas, mapping, vmf, entry, pfn,
>  						DAX_PMD, write && !sync);
>  
> +		if (srcmap.type != IOMAP_HOLE) {

Same here.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
