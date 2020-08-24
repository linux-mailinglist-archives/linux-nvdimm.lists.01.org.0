Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C11250C98
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 01:55:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDBF7136F07B6;
	Mon, 24 Aug 2020 16:55:51 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.249; helo=mail105.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
	by ml01.01.org (Postfix) with ESMTP id 2837E13595D8B
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 16:55:37 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 84A853A6C49;
	Tue, 25 Aug 2020 09:55:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kAMJK-0005hV-UO; Tue, 25 Aug 2020 09:55:34 +1000
Date: Tue, 25 Aug 2020 09:55:34 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 2/9] fs: Introduce i_blocks_per_page
Message-ID: <20200824235534.GC12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-3-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-3-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
	a=7-415B0cAAAA:8 a=mJU8oAxJmDnO_Ql8_JAA:9 a=CjuIK1q_8ugA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: BFQ3XLDNOMFVQR77BMN7KGJXG3BBEH4G
X-Message-ID-Hash: BFQ3XLDNOMFVQR77BMN7KGJXG3BBEH4G
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BFQ3XLDNOMFVQR77BMN7KGJXG3BBEH4G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Aug 24, 2020 at 03:55:03PM +0100, Matthew Wilcox (Oracle) wrote:
> This helper is useful for both THPs and for supporting block size larger
> than page size.  Convert all users that I could find (we have a few
> different ways of writing this idiom, and I may have missed some).

There probably is - ISTR having a lot more of these changes for the
block_size > page_size patches as it needed the same {page, inode}
abstraction for calculating the range to iterate. But they can be
dealt with on a case by case basis, I think.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c  |  8 ++++----
>  fs/jfs/jfs_metapage.c   |  2 +-
>  fs/xfs/xfs_aops.c       |  2 +-
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  4 files changed, 22 insertions(+), 6 deletions(-)

Otherwise looks good.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
