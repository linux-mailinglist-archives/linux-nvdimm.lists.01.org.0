Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3C252257
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 23:02:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4ED2E114493CF;
	Tue, 25 Aug 2020 14:02:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4909B111FF46E
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 14:02:08 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKxGYe043437;
	Tue, 25 Aug 2020 21:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HFiP3ElMqXpazB4S8Vqol6QjJN2M93nsVrh0yeuWLCk=;
 b=g9q+BfCDQfKaBRnvSC3MuF/2OSTy8R1znYeiI8apQ+dkhMotedhXENH444+nQ8oWJINR
 4diRhKJPEr5eqyuC5XGkQwBTaG+XU2KSCKq57LiTVnDzoKivlaL/DipJFHzsDJPYL1Tu
 g84Ph9+LeVOPqPQxpbaS4DqM5iQacKUWmBe50O5V8lCk7H9qhMm40iwIRWON0tn+5RY9
 U2VnSqNDixBfdypPqkYC1owXco2M2917S47joXJRtj/T1oGN5zVGQh9tXn7M2xUwkYN0
 QdCAZyh11AW6WcMhs89/Csx6PIyTpqUdiZFONaOk0cJM6wvB3MPBlMo6smVcE/ZxkhtQ 2g==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 333w6tufjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Aug 2020 21:02:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PL0CHr173802;
	Tue, 25 Aug 2020 21:02:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3020.oracle.com with ESMTP id 333ru8fv9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2020 21:02:04 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07PL24ge013167;
	Tue, 25 Aug 2020 21:02:04 GMT
Received: from localhost (/10.159.234.29)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 25 Aug 2020 14:02:04 -0700
Date: Tue, 25 Aug 2020 14:02:03 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200825210203.GJ6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-6-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=1 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250159
Message-ID-Hash: MZZ7YQSE5T43XGFW5S2JATKS5U5MEUEU
X-Message-ID-Hash: MZZ7YQSE5T43XGFW5S2JATKS5U5MEUEU
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MZZ7YQSE5T43XGFW5S2JATKS5U5MEUEU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:06PM +0100, Matthew Wilcox (Oracle) wrote:
> Size the uptodate array dynamically to support larger pages in the
> page cache.  With a 64kB page, we're only saving 8 bytes per page today,
> but with a 2MB maximum page size, we'd have to allocate more than 4kB
> per page.  Add a few debugging assertions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index dbf9572dabe9..844e95cacea8 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -22,18 +22,19 @@
>  #include "../internal.h"
>  
>  /*
> - * Structure allocated for each page when block size < PAGE_SIZE to track
> + * Structure allocated for each page when block size < page size to track
>   * sub-page uptodate status and I/O completions.

"for each regular page or head page of a huge page"?  Or whatever we're
calling them nowadays?

--D

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
> +	VM_BUG_ON_PGFLAGS(PageTail(page), page);
>  	if (page_has_private(page))
>  		return (struct iomap_page *)page_private(page);
>  	return NULL;
> @@ -45,11 +46,13 @@ static struct iomap_page *
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
> @@ -59,11 +62,14 @@ static void
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
