Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9258250CAD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 01:59:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F718135BE572;
	Mon, 24 Aug 2020 16:59:22 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.53; helo=mail107.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail107.syd.optusnet.com.au (mail107.syd.optusnet.com.au [211.29.132.53])
	by ml01.01.org (Postfix) with ESMTP id CDC80124DA503
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 16:59:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id B8F73D5C62F;
	Tue, 25 Aug 2020 09:59:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kAMMw-0005iZ-3C; Tue, 25 Aug 2020 09:59:18 +1000
Date: Tue, 25 Aug 2020 09:59:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 5/9] iomap: Support arbitrarily many blocks per page
Message-ID: <20200824235918.GF12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-6-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-6-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
	a=7-415B0cAAAA:8 a=anYf10tJ47q-4tFj-8MA:9 a=CjuIK1q_8ugA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: VUGMYIRP22CTTANIEVLSEEPH7GMEXURS
X-Message-ID-Hash: VUGMYIRP22CTTANIEVLSEEPH7GMEXURS
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VUGMYIRP22CTTANIEVLSEEPH7GMEXURS/>
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

Just to confirm: this vm bug check is to needed becuse we only
attach the iomap_page to the head page of a compound page?

Assuming that I've understood the above correctly:

Reviewed-by: Dave Chinner <dchinner@redhat.com>
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
