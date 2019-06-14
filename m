Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB4451E3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 04:31:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E49321296B29;
	Thu, 13 Jun 2019 19:31:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4BD2021296B0E
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+7wuYVOL+KJLLZqVsK5P8paT7js/8q2t5FmzFZkLtIs=; b=ENiikzv7M66hoOdASWgKZV1A0
 rJK5psvvRbGVSGGyq2u76HQ0+ghuJReMB1GMbXkJHt5z8ePNmyi1/hdZDsjH3mXarUHdhpimSMjoM
 Eo5tLSG9C1Ur4S4+1bNnYwiyPrj97STAqU2aHaIQRwsjw6fM6hLz/kyP8jauG67FXvTUc5TedeNCP
 svVbpzU8jJOYHfoct4Hi43JwxrDsxO3My6EWca+6zLisl3fGYLkB8geveNSrbXx4RVYLLfMrxJvO4
 klnCQks4Kovj2mzLBFnp/hawIDHAWCK32ZvscGHxlSexEz54emMO4w/SU0PsCRVjWghHyNtUJ6dT+
 Gg+QtRtrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hbbzf-0001q2-Se; Fri, 14 Jun 2019 02:31:07 +0000
Date: Thu, 13 Jun 2019 19:31:07 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190614023107.GK32656@bombadil.infradead.org>
References: <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613152755.GI32656@bombadil.infradead.org>
 <20190613211321.GC32404@iweiny-DESK2.sc.intel.com>
 <20190613234530.GK22901@ziepe.ca>
 <20190614020921.GM14363@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614020921.GM14363@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-nvdimm@lists.01.org,
 linux-rdma@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 14, 2019 at 12:09:21PM +1000, Dave Chinner wrote:
> On Thu, Jun 13, 2019 at 08:45:30PM -0300, Jason Gunthorpe wrote:
> > On Thu, Jun 13, 2019 at 02:13:21PM -0700, Ira Weiny wrote:
> > > On Thu, Jun 13, 2019 at 08:27:55AM -0700, Matthew Wilcox wrote:
> > > > On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> > > > > e.g. Process A has an exclusive layout lease on file F. It does an
> > > > > IO to file F. The filesystem IO path checks that Process A owns the
> > > > > lease on the file and so skips straight through layout breaking
> > > > > because it owns the lease and is allowed to modify the layout. It
> > > > > then takes the inode metadata locks to allocate new space and write
> > > > > new data.
> > > > > 
> > > > > Process B now tries to write to file F. The FS checks whether
> > > > > Process B owns a layout lease on file F. It doesn't, so then it
> > > > > tries to break the layout lease so the IO can proceed. The layout
> > > > > breaking code sees that process A has an exclusive layout lease
> > > > > granted, and so returns -ETXTBSY to process B - it is not allowed to
> > > > > break the lease and so the IO fails with -ETXTBSY.
> > > > 
> > > > This description doesn't match the behaviour that RDMA wants either.
> > > > Even if Process A has a lease on the file, an IO from Process A which
> > > > results in blocks being freed from the file is going to result in the
> > > > RDMA device being able to write to blocks which are now freed (and
> > > > potentially reallocated to another file).
> > > 
> > > I don't understand why this would not work for RDMA?  As long as the layout
> > > does not change the page pins can remain in place.
> > 
> > Because process A had a layout lease (and presumably a MR) and the
> > layout was still modified in way that invalidates the RDMA MR.
> 
> The lease holder is allowed to modify the mapping it has a lease
> over. That's necessary so lease holders can write data into
> unallocated space in the file. The lease is there to prevent third
> parties from modifying the layout without the lease holder being
> informed and taking appropriate action to allow that 3rd party
> modification to occur.
> 
> If the lease holder modifies the mapping in a way that causes it's
> own internal state to screw up, then that's a bug in the lease
> holder application.

Sounds like the lease semantics aren't the right ones for the longterm
GUP users then.  The point of the longterm GUP is so the pages can be
written to, and if the filesystem is going to move the pages around when
they're written to, that just won't work.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
