Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D283543250
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 05:23:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3411821296073;
	Wed, 12 Jun 2019 20:23:31 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D0FD52129606E
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 20:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QaIPZk5fG08PMipK2ZOjFgNMkP7/mE5EU+2hsa7y6lY=; b=VCF/wqwvWCkPBIrvCaL/D3G8l
 tHqc/P5TR0jF4odv4tFa+eZycXtANJYw8npQGw1u7+6Uv8D3dPL6PSPWSss02vOD3RMl8SN9UE9tE
 pgdev89Cvk50mX8MdLQMFzWKjT9ybPnHlvymKlhrDcAdtq9BjKibIVkW+vernB9b/39/CVM/w8KPZ
 7eNO6yjjUerdEhluGAkQcubSLK9G/8N4d5w54XxHTAPHR/5HqmRB4lPvHLnyja2+Z1QV2Pr2MBWyz
 OHrDRVCwX8aCx5s1LcyskUetCbhRrlq1e3Hk4+o+Gp2Qi2Fokqvsf6H+CAZFG91Ylp4HPDaT6v01i
 r9dkL+CUQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hbGKe-0003os-RJ; Thu, 13 Jun 2019 03:23:20 +0000
Date: Wed, 12 Jun 2019 20:23:20 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613032320.GG32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613002555.GH14363@dread.disaster.area>
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> On Wed, Jun 12, 2019 at 05:37:53AM -0700, Matthew Wilcox wrote:
> > That's rather different from the normal meaning of 'exclusive' in the
> > context of locks, which is "only one user can have access to this at
> > a time".
> 
> Layout leases are not locks, they are a user access policy object.
> It is the process/fd which holds the lease and it's the process/fd
> that is granted exclusive access.  This is exactly the same semantic
> as O_EXCL provides for granting exclusive access to a block device
> via open(), yes?

This isn't my understanding of how RDMA wants this to work, so we should
probably clear that up before we get too far down deciding what name to
give it.

For the RDMA usage case, it is entirely possible that both process A
and process B which don't know about each other want to perform RDMA to
file F.  So there will be two layout leases active on this file at the
same time.  It's fine for IOs to simultaneously be active to both leases.
But if the filesystem wants to move blocks around, it has to break
both leases.

If Process C tries to do a write to file F without a lease, there's no
problem, unless a side-effect of the write would be to change the block
mapping, in which case either the leases must break first, or the write
must be denied.

Jason, please correct me if I've misunderstood the RDMA needs here.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
