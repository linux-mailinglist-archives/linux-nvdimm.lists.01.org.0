Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6393D250C99
	for <lists+linux-nvdimm@lfdr.de>; Tue, 25 Aug 2020 01:56:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1A3DB136F07B5;
	Mon, 24 Aug 2020 16:56:08 -0700 (PDT)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.59; helo=mail108.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail108.syd.optusnet.com.au (mail108.syd.optusnet.com.au [211.29.132.59])
	by ml01.01.org (Postfix) with ESMTP id 54C78136F07B5
	for <linux-nvdimm@lists.01.org>; Mon, 24 Aug 2020 16:56:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
	by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 591AC1AA954;
	Tue, 25 Aug 2020 09:56:05 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1kAMJo-0005hi-Lg; Tue, 25 Aug 2020 09:56:04 +1000
Date: Tue, 25 Aug 2020 09:56:04 +1000
From: Dave Chinner <david@fromorbit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH 3/9] iomap: Use kzalloc to allocate iomap_page
Message-ID: <20200824235604.GD12131@dread.disaster.area>
References: <20200824145511.10500-1-willy@infradead.org>
 <20200824145511.10500-4-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824145511.10500-4-willy@infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
	a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
	a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=JfrnYn6hAAAA:8 a=20KFwNOVAAAA:8
	a=7-415B0cAAAA:8 a=Eo_zldZ1eKELjHi0JfAA:9 a=CjuIK1q_8ugA:10
	a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: NIWQBPUKM6PDYA7B6OLRU46GLUNRJZN4
X-Message-ID-Hash: NIWQBPUKM6PDYA7B6OLRU46GLUNRJZN4
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <darrick.wong@oracle.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NIWQBPUKM6PDYA7B6OLRU46GLUNRJZN4/>
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
> ---
>  fs/iomap/buffered-io.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

The sooner this goes in the better :)

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
