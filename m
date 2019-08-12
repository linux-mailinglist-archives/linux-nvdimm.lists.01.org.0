Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F98A8D1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:01:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C880021311BEA;
	Mon, 12 Aug 2019 14:03:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6F24621311BE1
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:03:36 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 14:01:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; d="scan'208";a="176002236"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 12 Aug 2019 14:01:17 -0700
Date: Mon, 12 Aug 2019 14:01:17 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Message-ID: <20190812210116.GD20634@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <88d82639-c0b2-0b35-1919-999a8438031c@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88d82639-c0b2-0b35-1919-999a8438031c@nvidia.com>
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
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Aug 11, 2019 at 04:07:23PM -0700, John Hubbard wrote:
> On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > The addition of FOLL_LONGTERM has taken on additional meaning for CMA
> > pages.
> > 
> > In addition subsystems such as RDMA require new information to be passed
> > to the GUP interface to track file owning information.  As such a simple
> > FOLL_LONGTERM flag is no longer sufficient for these users to pin pages.
> > 
> > Introduce a new GUP like call which takes the newly introduced vaddr_pin
> > information.  Failure to pass the vaddr_pin object back to a vaddr_put*
> > call will result in a failure if pins were created on files during the
> > pin operation.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> I'm creating a new call site conversion series, to replace the 
> "put_user_pages(): miscellaneous call sites" series. This uses
> vaddr_pin_pages*() where appropriate. So it's based on your series here.
> 
> btw, while doing that, I noticed one more typo while re-reading some of the comments. 
> Thought you probably want to collect them all for the next spin. Below...
> 
> > ---
> > Changes from list:
> > 	Change to vaddr_put_pages_dirty_lock
> > 	Change to vaddr_unpin_pages_dirty_lock
> > 
> >  include/linux/mm.h |  5 ++++
> >  mm/gup.c           | 59 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 657c947bda49..90c5802866df 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1603,6 +1603,11 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
> >  int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
> >  			struct task_struct *task, bool bypass_rlim);
> >  
> > +long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
> > +		     unsigned int gup_flags, struct page **pages,
> > +		     struct vaddr_pin *vaddr_pin);
> > +void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
> > +				  struct vaddr_pin *vaddr_pin, bool make_dirty);
> >  bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
> >  
> >  /* Container for pinned pfns / pages */
> > diff --git a/mm/gup.c b/mm/gup.c
> > index eeaa0ddd08a6..6d23f70d7847 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2536,3 +2536,62 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(get_user_pages_fast);
> > +
> > +/**
> > + * vaddr_pin_pages pin pages by virtual address and return the pages to the
> > + * user.
> > + *
> > + * @addr, start address
> > + * @nr_pages, number of pages to pin
> > + * @gup_flags, flags to use for the pin
> > + * @pages, array of pages returned
> > + * @vaddr_pin, initalized meta information this pin is to be associated
> 
> Typo:
>                   initialized

Thanks fixed.
Ira

> 
> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
