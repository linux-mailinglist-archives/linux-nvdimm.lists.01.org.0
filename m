Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A403626E7C7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 00:00:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D5E314869C92;
	Thu, 17 Sep 2020 15:00:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4B12813E6AC90
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 15:00:18 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HLxfa0047948;
	Thu, 17 Sep 2020 22:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=6Yw7FZiIzqNMwMA8TDvezwmycMynYGKLn2r6WY2pEOw=;
 b=EbD6kch8pT1TuAXxEK5KBg6sWhumiP8dBYhRXrhlulb3gLkKsGEc7aJUCONX5hy45k6Y
 TL8vKuIOLDy3PyNkPlkQYIHCxy0z39dlBljGMnyEZklEaPox2lUUZEy1GQMuwQa+AjoK
 Ns7bV1z7nvf6dLgrLWfbafafy+8aQxZ24Qzl9aDQBAbJEqdDwY4YwwB1ebIjN400Cf2L
 KbGydDJWVvinIBBPpuRFQQe4CKMgpl9wV6pM6RenuygpFQu/HwkTx7dC7N7vyMQDjWP0
 A6jmp82JciizRb4QgkAAwFZGliLHpYUqUbf8OJ6KXet1pZThC+++nMZBELWm7rFLHeHx vg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2130.oracle.com with ESMTP id 33gnrrc2bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2020 22:00:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM05EV101966;
	Thu, 17 Sep 2020 22:00:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 33khpnqfy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2020 22:00:08 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HM06ng029353;
	Thu, 17 Sep 2020 22:00:06 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Sep 2020 22:00:06 +0000
Date: Thu, 17 Sep 2020 15:00:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200917220003.GN7955@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-6-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1011 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
Message-ID-Hash: OFBF5JTT3BPMV2657Y6Z7VOWTJ6KAD2W
X-Message-ID-Hash: OFBF5JTT3BPMV2657Y6Z7VOWTJ6KAD2W
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Dave Chinner <dchinner@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OFBF5JTT3BPMV2657Y6Z7VOWTJ6KAD2W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:47:03AM +0100, Matthew Wilcox (Oracle) wrote:
> Size the uptodate array dynamically to support larger pages in the
> page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> but with a 2MB maximum page size, we'd have to allocate more than 4kB
> per page.  Add a few debugging assertions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 7fc0e02d27b0..9670c096b83e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -22,18 +22,25 @@
>  #include "../internal.h"
>  
>  /*
> - * Structure allocated for each page when block size < PAGE_SIZE to track
> - * sub-page uptodate status and I/O completions.
> + * Structure allocated for each page or THP when block size < page size
> + * to track sub-page uptodate status and I/O completions.
>   */
>  struct iomap_page {
>  	atomic_t		read_count;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
> -	DECLARE_BITMAP(uptodate, PAGE_SIZE / 512);
> +	unsigned long		uptodate[];
>  };
>  
>  static inline struct iomap_page *to_iomap_page(struct page *page)
>  {
> +	/*
> +	 * per-block data is stored in the head page.  Callers should
> +	 * not be dealing with tail pages (and if they are, they can
> +	 * call thp_head() first.
> +	 */
> +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> +
>  	if (page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;
> @@ -45,11 +52,13 @@ static struct iomap_page *
>  iomap_page_create(struct inode *inode, struct page *page)
>  {
>  	struct iomap_page *iop = to_iomap_page(page);
> +	unsigned int nr_blocks = i_blocks_per_page(inode, page);
>  
> -	if (iop || i_blocks_per_page(inode, page) <= 1)
> +	if (iop || nr_blocks <= 1)
>  		return iop;
>  
> -	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> +	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> +			GFP_NOFS | __GFP_NOFAIL);
>  	spin_lock_init(&iop->uptodate_lock);
>  	attach_page_private(page, iop);
>  	return iop;
> @@ -59,11 +68,14 @@ static void
>  iomap_page_release(struct page *page)
>  {
>  	struct iomap_page *iop = detach_page_private(page);
> +	unsigned int nr_blocks = i_blocks_per_page(page->mapping->host, page);
>  
>  	if (!iop)
>  		return;
>  	WARN_ON_ONCE(atomic_read(&iop->read_count));
>  	WARN_ON_ONCE(atomic_read(&iop->write_count));
> +	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> +			PageUptodate(page));
>  	kfree(iop);
>  }
>  
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
