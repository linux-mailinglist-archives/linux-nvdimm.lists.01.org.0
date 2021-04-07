Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B217C356ADC
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Apr 2021 13:14:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC2C7100EBBDA;
	Wed,  7 Apr 2021 04:14:35 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 56873100EBBCB
	for <linux-nvdimm@lists.01.org>; Wed,  7 Apr 2021 04:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gXTPe6Z3xf8fN6/+SVbn3oskaMk/+fmn0nXa9QgNoq4=; b=adTni07HAeWwLS2YFlGyWwnHef
	/sZm3ojRZKo+Ygx1EnVM5PliOVz1wtKizmuCGBSAmi0UJIsH7P6kMBF+ti7Mrf2S1tKMDzlyDFpO0
	BozxGSdjTVRNpdjd7IRtXJhaaLurr6AHi9d4x+v6JKg99TLPnvcs+ApVba0ZvMRXqgVrLC7CBfWPX
	hC5TVO5JLQaL446fVish6SQMaP0pZkmtI39bSBclvNEoVk1UvjJlJz/3FPOdGKF/0nxtnnV0a1i7a
	BeCe93JNy2rJKClRUwuIe5/6KPKkgRyghnTNtdRBO89EYmGqKOehHaE4aBEeR0hLoWj3OqAyOqtyr
	xRUHT6cQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1lU68B-00EN6A-FD; Wed, 07 Apr 2021 11:14:06 +0000
Date: Wed, 7 Apr 2021 12:13:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH 1/3] fsdax: Factor helpers to simplify dax fault code
Message-ID: <20210407111355.GD2531743@casper.infradead.org>
References: <20210407063207.676753-1-ruansy.fnst@fujitsu.com>
 <20210407063207.676753-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407063207.676753-2-ruansy.fnst@fujitsu.com>
Message-ID-Hash: 76ZPXMR2SM4HNSL5D4WZ3QUSVZZZBIXU
X-Message-ID-Hash: 76ZPXMR2SM4HNSL5D4WZ3QUSVZZZBIXU
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de, Ritesh Harjani <riteshh@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/76ZPXMR2SM4HNSL5D4WZ3QUSVZZZBIXU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Apr 07, 2021 at 02:32:05PM +0800, Shiyang Ruan wrote:
> +static int dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
> +		loff_t pos, vm_fault_t *ret)
> +{
> +	int error = 0;
> +	unsigned long vaddr = vmf->address;
> +	sector_t sector = dax_iomap_sector(iomap, pos);
> +
> +	switch (iomap->type) {
> +	case IOMAP_HOLE:
> +	case IOMAP_UNWRITTEN:
> +		clear_user_highpage(vmf->cow_page, vaddr);
> +		break;
> +	case IOMAP_MAPPED:
> +		error = copy_cow_page_dax(iomap->bdev, iomap->dax_dev,
> +						sector, vmf->cow_page, vaddr);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		error = -EIO;
> +		break;
> +	}
> +
> +	if (error)
> +		return error;
> +
> +	__SetPageUptodate(vmf->cow_page);
> +	*ret = finish_fault(vmf);
> +	if (!*ret)
> +		*ret = VM_FAULT_DONE_COW;
> +	return 0;
> +}
...

> +		error = dax_fault_cow_page(vmf, &iomap, pos, &ret);
>  		if (error)
> +			ret = dax_fault_return(error);
>  		goto finish_iomap;

This seems unnecessarily complex.  Why not return the vm_fault_t instead of
returning the errno and then converting it?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
