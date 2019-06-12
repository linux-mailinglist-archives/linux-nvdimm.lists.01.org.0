Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D60B4250B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 14:09:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 174E121295CB5;
	Wed, 12 Jun 2019 05:09:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 761702128A65C
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 05:09:12 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 83424AE27;
 Wed, 12 Jun 2019 12:09:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id A86331E4328; Wed, 12 Jun 2019 14:09:07 +0200 (CEST)
Date: Wed, 12 Jun 2019 14:09:07 +0200
From: Jan Kara <jack@suse.cz>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612120907.GC14578@quack2.suse.cz>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz>
 <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
 <20190612114721.GB3876@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612114721.GB3876@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed 12-06-19 08:47:21, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2019 at 12:29:17PM +0200, Jan Kara wrote:
> 
> > > > The main objection to the current ODP & DAX solution is that very
> > > > little HW can actually implement it, having the alternative still
> > > > require HW support doesn't seem like progress.
> > > > 
> > > > I think we will eventually start seein some HW be able to do this
> > > > invalidation, but it won't be universal, and I'd rather leave it
> > > > optional, for recovery from truely catastrophic errors (ie my DAX is
> > > > on fire, I need to unplug it).
> > > 
> > > Agreed.  I think software wise there is not much some of the devices can do
> > > with such an "invalidate".
> > 
> > So out of curiosity: What does RDMA driver do when userspace just closes
> > the file pointing to RDMA object? It has to handle that somehow by aborting
> > everything that's going on... And I wanted similar behavior here.
> 
> It aborts *everything* connected to that file descriptor. Destroying
> everything avoids creating inconsistencies that destroying a subset
> would create.
> 
> What has been talked about for lease break is not destroying anything
> but very selectively saying that one memory region linked to the GUP
> is no longer functional.

OK, so what I had in mind was that if RDMA app doesn't play by the rules
and closes the file with existing pins (and thus layout lease) we would
force it to abort everything. Yes, it is disruptive but then the app didn't
obey the rule that it has to maintain file lease while holding pins. Thus
such situation should never happen unless the app is malicious / buggy.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
