Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F326E7D0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 00:02:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E60D5148DA007;
	Thu, 17 Sep 2020 15:02:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 75A1D13E6AC90
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 15:02:17 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM0QNJ036919;
	Thu, 17 Sep 2020 22:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=w/0iChru56jDdRDowf1LtC/uWbP73dxAi+aX4R1zuno=;
 b=HCzkggtHPgfYXJ4dM8vsrUvT5UrLYLLdngRccdIiMYsbyXxixHJTn+JBiwZpkW/qgzdx
 2asVdEChKRIWgrWeOqFeIIG0PZvGRKsHVHJUtvIGrqFJqngDw0BIzP/nUpOLfOH24acj
 ngfN5zLt+nZnfG0RZHSoP+G29Skp06pwuwXeZfPeFAXSgyGCfPwdo5Cyr2I2tQlXvLCt
 Q9uA9RTvAA6M+BhfrncO3r33ifDEDpnLg552xqiRi40O78r6t7dXn94oeMq+b7Gg0F5r
 ncj5Y53YnPu3ryGyt6/X+BQMRhywv8IsCNgg2DejO71VNvANXJMbR+rBuhLMTzNzoksE Kg==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 33j91dwp03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2020 22:02:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HM06dY102117;
	Thu, 17 Sep 2020 22:02:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3030.oracle.com with ESMTP id 33khpnqjum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2020 22:02:13 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08HM2CFQ030491;
	Thu, 17 Sep 2020 22:02:12 GMT
Received: from localhost (/67.169.218.210)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 17 Sep 2020 22:02:12 +0000
Date: Thu, 17 Sep 2020 15:02:10 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v2 6/9] iomap: Convert read_count to read_bytes_pending
Message-ID: <20200917220210.GO7955@magnolia>
References: <20200910234707.5504-1-willy@infradead.org>
 <20200910234707.5504-7-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910234707.5504-7-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=1 mlxlogscore=999
 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170162
Message-ID-Hash: QXF5LLHOAWYK2VZHYV53FNTE5FV3DWK7
X-Message-ID-Hash: QXF5LLHOAWYK2VZHYV53FNTE5FV3DWK7
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QXF5LLHOAWYK2VZHYV53FNTE5FV3DWK7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 11, 2020 at 12:47:04AM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of counting bio segments, count the number of bytes submitted.
> This insulates us from the block layer's definition of what a 'same page'
> is, which is not necessarily clear once THPs are involved.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c | 41 ++++++++++++-----------------------------
>  1 file changed, 12 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9670c096b83e..1cf976a8e55c 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -26,7 +26,7 @@
>   * to track sub-page uptodate status and I/O completions.
>   */
>  struct iomap_page {
> -	atomic_t		read_count;
> +	atomic_t		read_bytes_pending;
>  	atomic_t		write_count;
>  	spinlock_t		uptodate_lock;
>  	unsigned long		uptodate[];
> @@ -72,7 +72,7 @@ iomap_page_release(struct page *page)
>  
>  	if (!iop)
>  		return;
> -	WARN_ON_ONCE(atomic_read(&iop->read_count));
> +	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
>  	WARN_ON_ONCE(atomic_read(&iop->write_count));
>  	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
>  			PageUptodate(page));
> @@ -167,13 +167,6 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
>  		SetPageUptodate(page);
>  }
>  
> -static void
> -iomap_read_finish(struct iomap_page *iop, struct page *page)
> -{
> -	if (!iop || atomic_dec_and_test(&iop->read_count))
> -		unlock_page(page);
> -}
> -
>  static void
>  iomap_read_page_end_io(struct bio_vec *bvec, int error)
>  {
> @@ -187,7 +180,8 @@ iomap_read_page_end_io(struct bio_vec *bvec, int error)
>  		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
>  	}
>  
> -	iomap_read_finish(iop, page);
> +	if (!iop || atomic_sub_and_test(bvec->bv_len, &iop->read_bytes_pending))
> +		unlock_page(page);
>  }
>  
>  static void
> @@ -267,30 +261,19 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  	}
>  
>  	ctx->cur_page_in_bio = true;
> +	if (iop)
> +		atomic_add(plen, &iop->read_bytes_pending);
>  
> -	/*
> -	 * Try to merge into a previous segment if we can.
> -	 */
> +	/* Try to merge into a previous segment if we can */
>  	sector = iomap_sector(iomap, pos);
> -	if (ctx->bio && bio_end_sector(ctx->bio) == sector)
> +	if (ctx->bio && bio_end_sector(ctx->bio) == sector) {
> +		if (__bio_try_merge_page(ctx->bio, page, plen, poff,
> +				&same_page))
> +			goto done;
>  		is_contig = true;
> -
> -	if (is_contig &&
> -	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
> -		if (!same_page && iop)
> -			atomic_inc(&iop->read_count);
> -		goto done;
>  	}
>  
> -	/*
> -	 * If we start a new segment we need to increase the read count, and we
> -	 * need to do so before submitting any previous full bio to make sure
> -	 * that we don't prematurely unlock the page.
> -	 */
> -	if (iop)
> -		atomic_inc(&iop->read_count);
> -
> -	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
> +	if (!is_contig || bio_full(ctx->bio, plen)) {
>  		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
>  		gfp_t orig_gfp = gfp;
>  		int nr_vecs = (length + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
