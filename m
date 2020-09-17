Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 800E926E7E1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 00:03:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3760013FD87ED;
	Thu, 17 Sep 2020 15:03:18 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C53F13FD87EC
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 15:03:15 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM0RLa036949;
	Thu, 17 Sep 2020 22:03:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jBOs08fQ0aQajU7zanwF1NyRNVYjyzYAbb9zEtpUEyE=;
 b=SRIaL7J/BNv3CAl6ags9fcIkcrLYqZXj1saMadB+oY51263oJHkY31pz6BMPUTtl2cxS
 4Nx3ePVSGLkZyldcZ3ODH+82LbBaPvR3mGftfKV6iy/tcdV5e8Cdvir8wS0c2b5VOP5q
 92nAVqG+z/x23c2SWJhDku7Su/8n2dDuLgTbwPRjjNm56d2/GKslqWovHSqSDm+gIn8Y
 ioiUHW0VB/lU+BHyFUktnqogPv4RJnkJrVpp4ELLkF2A20uG4/ZbWo3AKE20dtfIVYdZ
 gfGP8TIYk5kx9pPbpWGZKxv0d/j8oZvFkdEL286t6RDKAclQtlJ5oCRKBAX5C9B+vf0t hw==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 33j91dwp3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2020 22:03:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM1a6s079549;
	Thu, 17 Sep 2020 22:03:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 33h88ck9fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2020 22:03:11 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HM39vk006929;
	Thu, 17 Sep 2020 22:03:10 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Sep 2020 22:03:09 +0000
Date: Thu, 17 Sep 2020 15:03:06 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 8/9] iomap: Convert iomap_write_end types
Message-ID: <20200917220306.GQ7955@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-9-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-9-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
Message-ID-Hash: B5ZMBXIQIRYVSEQEJR6RYTJA2ODZWIJ7
X-Message-ID-Hash: B5ZMBXIQIRYVSEQEJR6RYTJA2ODZWIJ7
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/B5ZMBXIQIRYVSEQEJR6RYTJA2ODZWIJ7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:47:06AM +0100, Matthew Wilcox (Oracle) wrote:
> iomap_write_end cannot return an error, so switch it to return
> size_t instead of int and remove the error checking from the callers.
> Also convert the arguments to size_t from unsigned int, in case anyone
> ever wants to support a page size larger than 2GB.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

LGTM
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 64a5cb383f30..cb25a7b70401 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -663,9 +663,8 @@ iomap_set_page_dirty(struct page *page)
>  }
>  EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
>  
> -static int
> -__iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
> -		unsigned copied, struct page *page)
> +static size_t __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page)
>  {
>  	flush_dcache_page(page);
>  
> @@ -687,9 +686,8 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
>  	return copied;
>  }
>  
> -static int
> -iomap_write_end_inline(struct inode *inode, struct page *page,
> -		struct iomap *iomap, loff_t pos, unsigned copied)
> +static size_t iomap_write_end_inline(struct inode *inode, struct page *page,
> +		struct iomap *iomap, loff_t pos, size_t copied)
>  {
>  	void *addr;
>  
> @@ -705,13 +703,14 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  	return copied;
>  }
>  
> -static int
> -iomap_write_end(struct inode *inode, loff_t pos, unsigned len, unsigned copied,
> -		struct page *page, struct iomap *iomap, struct iomap *srcmap)
> +/* Returns the number of bytes copied.  May be 0.  Cannot be an errno. */
> +static size_t iomap_write_end(struct inode *inode, loff_t pos, size_t len,
> +		size_t copied, struct page *page, struct iomap *iomap,
> +		struct iomap *srcmap)
>  {
>  	const struct iomap_page_ops *page_ops = iomap->page_ops;
>  	loff_t old_size = inode->i_size;
> -	int ret;
> +	size_t ret;
>  
>  	if (srcmap->type == IOMAP_INLINE) {
>  		ret = iomap_write_end_inline(inode, page, iomap, pos, copied);
> @@ -790,11 +789,8 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
>  
> -		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
> +		copied = iomap_write_end(inode, pos, bytes, copied, page, iomap,
>  				srcmap);
> -		if (unlikely(status < 0))
> -			break;
> -		copied = status;
>  
>  		cond_resched();
>  
> @@ -868,11 +864,8 @@ iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		status = iomap_write_end(inode, pos, bytes, bytes, page, iomap,
>  				srcmap);
> -		if (unlikely(status <= 0)) {
> -			if (WARN_ON_ONCE(status == 0))
> -				return -EIO;
> -			return status;
> -		}
> +		if (WARN_ON_ONCE(status == 0))
> +			return -EIO;
>  
>  		cond_resched();
>  
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
