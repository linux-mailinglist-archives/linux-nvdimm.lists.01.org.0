Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3AD2FF361
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 19:43:50 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65212100F2242;
	Thu, 21 Jan 2021 10:43:49 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0D6E8100F2240
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dXcuDwvoqNoP4NL97KSkxgI2xxt79APfMRyPL3XfbG4=; b=s8qAsrChiHJHM3e3dm+Vil913r
	dsMYbj166wZ3MpqLY+lsTacSlh2CTq9KkKqwFaHcZpC17BHXPuzd62jFoERqLi6ERZkT0xN77hXjK
	3C2UoQG5n/LvSXDuQRPTizobQpPuwbY+hHicZiAZ9nMcpLqRMmFUPe/JBO2P3ixS5RbGroU3k5JU3
	/33PnsOo/KwcCYoP0jDuQJiK53heCH54L+cJZE2pkPGAbgyKKJjUb6dcZJWaLxZhfsGWUmeuXt1lp
	KN6km+XZtR3BeZOxA2ApjF+YIdqnMOnA6Gnr05Au2mmAkwGGo8/zKvo1Qpbq7JRuqYquNWJr3EBYv
	LPrw3nBg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
	id 1l2eve-00HOCt-9F; Thu, 21 Jan 2021 18:43:35 +0000
Date: Thu, 21 Jan 2021 18:43:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/4] Remove nrexceptional tracking
Message-ID: <20210121184334.GA4127393@casper.infradead.org>
References: <20201026151849.24232-1-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201026151849.24232-1-willy@infradead.org>
Message-ID-Hash: VYOBJS5EAIJP2W3P42NYY6ILDOIKBVNL
X-Message-ID-Hash: VYOBJS5EAIJP2W3P42NYY6ILDOIKBVNL
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VYOBJS5EAIJP2W3P42NYY6ILDOIKBVNL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Ping?  These patches still apply to next-20210121.

On Mon, Oct 26, 2020 at 03:18:45PM +0000, Matthew Wilcox (Oracle) wrote:
> We actually use nrexceptional for very little these days.  It's a minor
> pain to keep in sync with nrpages, but the pain becomes much bigger
> with the THP patches because we don't know how many indices a shadow
> entry occupies.  It's easier to just remove it than keep it accurate.
> 
> Also, we save 8 bytes per inode which is nothing to sneeze at; on my
> laptop, it would improve shmem_inode_cache from 22 to 23 objects per
> 16kB, and inode_cache from 26 to 27 objects.  Combined, that saves
> a megabyte of memory from a combined usage of 25MB for both caches.
> Unfortunately, ext4 doesn't cross a magic boundary, so it doesn't save
> any memory for ext4.
> 
> Matthew Wilcox (Oracle) (4):
>   mm: Introduce and use mapping_empty
>   mm: Stop accounting shadow entries
>   dax: Account DAX entries as nrpages
>   mm: Remove nrexceptional from inode
> 
>  fs/block_dev.c          |  2 +-
>  fs/dax.c                |  8 ++++----
>  fs/gfs2/glock.c         |  3 +--
>  fs/inode.c              |  2 +-
>  include/linux/fs.h      |  2 --
>  include/linux/pagemap.h |  5 +++++
>  mm/filemap.c            | 16 ----------------
>  mm/swap_state.c         |  4 ----
>  mm/truncate.c           | 19 +++----------------
>  mm/workingset.c         |  1 -
>  10 files changed, 15 insertions(+), 47 deletions(-)
> 
> -- 
> 2.28.0
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
