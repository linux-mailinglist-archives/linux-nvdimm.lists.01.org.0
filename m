Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C85C252232
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 22:50:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A116C114493D0;
	Tue, 25 Aug 2020 13:50:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5900C114493CB
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 13:49:59 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKixMQ156255;
	Tue, 25 Aug 2020 20:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=ImYJvkWuSHo5qIDzd5Wm+ZtgL4tShmllmY0/Qa3RjH0=;
 b=F8uab4sPAWlMhR9niVn/qXvXNnKJD5l7PLU4V09rUN8KoEPrS+9kdNTjBLSI/4rGPOGm
 tTF1GZbU0HB4JojOLity0rXLxJdi+XK+2XyGX6NZqG7YsYPQ2DEJk5+4SR4RorqiXhz7
 1mTAbLLASWfN4/Gs7gsuU/cwIe44JHEX+vMZri5ONrjeSvFsJc7qRgRrEHvmioaV3BA+
 HjQcwpRYvvBz55+ti/DVBycD84iwrwwpqU8SBuGJhWdi4QUovB5IdQUDqINHIEq6IuYX
 WR7Y6vE7K6+8bx2gePfm41rx1cHjiWUwa9tJ4MebyuODgmsTsxrYGdC4yGLbppTd/H5l VQ==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 333csj4x32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Aug 2020 20:49:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKkDPK117022;
	Tue, 25 Aug 2020 20:49:55 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 333ru8f5d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2020 20:49:55 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PKntNZ020917;
	Tue, 25 Aug 2020 20:49:55 GMT
Received: from localhost (/10.159.234.29)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 25 Aug 2020 13:49:54 -0700
Date: Tue, 25 Aug 2020 13:49:53 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 3/9] iomap: Use kzalloc to allocate iomap_page
Message-ID: <20200825204953.GH6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-4-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=997 phishscore=0
 bulkscore=0 suspectscore=1 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=970 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
Message-ID-Hash: B3YDT4MKP3JOCWAQTDLH27JB3GQJPGA6
X-Message-ID-Hash: B3YDT4MKP3JOCWAQTDLH27JB3GQJPGA6
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B3YDT4MKP3JOCWAQTDLH27JB3GQJPGA6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:04PM +0100, Matthew Wilcox (Oracle) wrote:
> We can skip most of the initialisation, although spinlocks still
> need explicit initialisation as architectures may use a non-zero
> value to indicate unlocked.  The comment is no longer useful as
> attach_page_private() handles the refcount now.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 13d5cdab8dcd..639d54a4177e 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -49,16 +49,8 @@ iomap_page_create(struct inode *inode, struct page *page)
>  	if (iop || i_blocks_per_page(inode, page) <= 1)
>  		return iop;
>  
> -	iop = kmalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
> -	atomic_set(&iop->read_count, 0);
> -	atomic_set(&iop->write_count, 0);
> +	iop = kzalloc(sizeof(*iop), GFP_NOFS | __GFP_NOFAIL);
>  	spin_lock_init(&iop->uptodate_lock);
> -	bitmap_zero(iop->uptodate, PAGE_SIZE / SECTOR_SIZE);
> -
> -	/*
> -	 * migrate_page_move_mapping() assumes that pages with private data have
> -	 * their count elevated by 1.
> -	 */
>  	attach_page_private(page, iop);
>  	return iop;
>  }
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
