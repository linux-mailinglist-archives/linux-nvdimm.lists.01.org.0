Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BE045256
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 05:08:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C644721296B39;
	Thu, 13 Jun 2019 20:08:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.42;
 helo=mail106.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail106.syd.optusnet.com.au (mail106.syd.optusnet.com.au
 [211.29.132.42]) by ml01.01.org (Postfix) with ESMTP id D2A2721296B30
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 20:08:11 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au
 [49.195.189.25])
 by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id ACCE93DD56B;
 Fri, 14 Jun 2019 13:08:09 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hbcYa-0005cJ-7D; Fri, 14 Jun 2019 13:07:12 +1000
Date: Fri, 14 Jun 2019 13:07:12 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190614030712.GO14363@dread.disaster.area>
References: <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
 <20190613152755.GI32656@bombadil.infradead.org>
 <20190613211321.GC32404@iweiny-DESK2.sc.intel.com>
 <20190613234530.GK22901@ziepe.ca>
 <20190614020921.GM14363@dread.disaster.area>
 <20190614023107.GK32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190614023107.GK32656@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0 cx=a_idp_d
 a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
 a=7-415B0cAAAA:8 a=8i7XV5XKZheqFIjFUW4A:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
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

On Thu, Jun 13, 2019 at 07:31:07PM -0700, Matthew Wilcox wrote:
> On Fri, Jun 14, 2019 at 12:09:21PM +1000, Dave Chinner wrote:
> > If the lease holder modifies the mapping in a way that causes it's
> > own internal state to screw up, then that's a bug in the lease
> > holder application.
> 
> Sounds like the lease semantics aren't the right ones for the longterm
> GUP users then.  The point of the longterm GUP is so the pages can be
> written to, and if the filesystem is going to move the pages around when
> they're written to, that just won't work.

And now we go full circle back to the constraints we decided on long
ago because we can't rely on demand paging RDMA hardware any time
soon to do everything we need to transparently support long-term GUP
on file-backed mappings. i.e.:

	RDMA to file backed mappings must first preallocate and
	write zeros to the range of the file they are mapping so
	that the filesystem block mapping is complete and static for
	the life of the RDMA mapping that will pin it.

IOWs, the layout lease will tell the RDMA application that the
static setup it has already done  to work correctly with a file
backed mapping may be about to be broken by a third party.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
