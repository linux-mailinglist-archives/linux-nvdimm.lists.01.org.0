Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FC985DB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 22:44:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9529120213F14;
	Wed, 21 Aug 2019 13:45:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2DDFD202110D0
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 13:45:31 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 13:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="196076495"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:44:21 -0700
Date: Wed, 21 Aug 2019 13:44:21 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190821204421.GE5965@iweiny-DESK2.sc.intel.com>
References: <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area>
 <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
 <20190821185703.GB5965@iweiny-DESK2.sc.intel.com>
 <20190821194810.GI8653@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190821194810.GI8653@ziepe.ca>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Michal Hocko <mhocko@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Dave Chinner <david@fromorbit.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 21, 2019 at 04:48:10PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 11:57:03AM -0700, Ira Weiny wrote:
> 
> > > Oh, I didn't think we were talking about that. Hanging the close of
> > > the datafile fd contingent on some other FD's closure is a recipe for
> > > deadlock..
> > 
> > The discussion between Jan and Dave was concerning what happens when a user
> > calls
> > 
> > fd = open()
> > fnctl(...getlease...)
> > addr = mmap(fd...)
> > ib_reg_mr() <pin>
> > munmap(addr...)
> > close(fd)
> 
> I don't see how blocking close(fd) could work.

Well Dave was saying this _could_ work.  FWIW I'm not 100% sure it will but I
can't prove it won't..  Maybe we are all just touching a different part of this
elephant[1] but the above scenario or one without munmap is very reasonably
something a user would do.  So we can either allow the close to complete (my
current patches) or try to make it block like Dave is suggesting.

I don't disagree with Dave with the semantics being nice and clean for the
filesystem.  But the fact that RDMA, and potentially others, can "pass the
pins" to other processes is something I spent a lot of time trying to work out.

>
> Write it like this:
> 
>  fd = open()
>  uverbs = open(/dev/uverbs)
>  fnctl(...getlease...)
>  addr = mmap(fd...)
>  ib_reg_mr() <pin>
>  munmap(addr...)
>   <sigkill>
> 
> The order FD's are closed during sigkill is not deterministic, so when
> all the fputs happen during a kill'd exit we could end up blocking in
> close(fd) as close(uverbs) will come after in the close
> list. close(uverbs) is the thing that does the dereg_mr and releases
> the pin.

Of course, that is a different scenario which needs to be fixed in my patch
set.  Now that my servers are back up I can hopefully make progress.  (Power
was down for them yesterday).

> 
> We don't need complexity with dup to create problems.

No but that complexity _will_ come unless we "zombie" layout leases.

Ira

[1] https://en.wikipedia.org/wiki/Blind_men_and_an_elephant

> 
> Jason
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
