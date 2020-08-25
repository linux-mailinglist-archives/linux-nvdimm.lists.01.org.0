Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B544A252226
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 22:48:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 11C73114493CB;
	Tue, 25 Aug 2020 13:48:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=darrick.wong@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D82B8111FF46E
	for <linux-nvdimm@lists.01.org>; Tue, 25 Aug 2020 13:48:05 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKiciB156095;
	Tue, 25 Aug 2020 20:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cxlyUwt13zo7dYYZPBBHib691Icpcqbd97TLEtnQSm0=;
 b=b1DOERxbKhp7D/quegWiCdYCHOVZteyvBuLWE5fzf7gAcqS/VAQWMVOumrHcQHfdFDw4
 8T3gqWcOAJo3DdSi6Wa6qRnJoykAW1xxvMr/drTuusErp5CgHtGj25mn2UNom2CyPdrd
 5vqhXqj+iJmYvHf6JFAcKSnUhQw54BQOVPr6OuengTRTax++/gncr2ahKqzseP4MMM+1
 Ul3NG/ADRMCSuTmpRUI8U0VmmwQNpo8GNio/SC1RgzTKtoXZMRB8GO/A9da/QgJP5Lby
 RIjxoqz30aVJQuZx0BZFkLHpXwb6uY40lytfzQXiA3sLoWkW2Vlai+VYzA/ZSPZJvHck WA==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 333csj4wtn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Aug 2020 20:47:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07PKjJH4034335;
	Tue, 25 Aug 2020 20:47:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3030.oracle.com with ESMTP id 333r9k240j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2020 20:47:58 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07PKlt9I005311;
	Tue, 25 Aug 2020 20:47:55 GMT
Received: from localhost (/10.159.234.29)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 25 Aug 2020 13:47:54 -0700
Date: Tue, 25 Aug 2020 13:47:53 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 1/9] iomap: Fix misplaced page flushing
Message-ID: <20200825204753.GF6096@magnolia>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-2-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-2-willy@infradead.org>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=1 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9724 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250157
Message-ID-Hash: OUQHM64NGHIVL6IRHO7TZFGE4IV3PCNO
X-Message-ID-Hash: OUQHM64NGHIVL6IRHO7TZFGE4IV3PCNO
X-MailFrom: darrick.wong@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OUQHM64NGHIVL6IRHO7TZFGE4IV3PCNO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:02PM +0100, Matthew Wilcox (Oracle) wrote:
> If iomap_unshare_actor() unshares to an inline iomap, the page was
> not being flushed.  block_write_end() and __iomap_write_end() already
> contain flushes, so adding it to iomap_write_end_inline() seems like
> the best place.  That means we can remove it from iomap_write_actor().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Seems reasonable to me...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index bcfc288dba3f..cffd575e57b6 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -715,6 +715,7 @@ iomap_write_end_inline(struct inode *inode, struct page *page,
>  {
>  	void *addr;
>  
> +	flush_dcache_page(page);
>  	WARN_ON_ONCE(!PageUptodate(page));
>  	BUG_ON(pos + copied > PAGE_SIZE - offset_in_page(iomap->inline_data));
>  
> @@ -811,8 +812,6 @@ iomap_write_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  
>  		copied = iov_iter_copy_from_user_atomic(page, i, offset, bytes);
>  
> -		flush_dcache_page(page);
> -
>  		status = iomap_write_end(inode, pos, bytes, copied, page, iomap,
>  				srcmap);
>  		if (unlikely(status < 0))
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
