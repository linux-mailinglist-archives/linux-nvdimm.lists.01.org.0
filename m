Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 945588A8C0
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Aug 2019 23:00:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A3D0B2130A4E6;
	Mon, 12 Aug 2019 14:02:36 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ECB1D203D85E8
 for <linux-nvdimm@lists.01.org>; Mon, 12 Aug 2019 14:02:34 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 14:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,378,1559545200"; d="scan'208";a="178466009"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga003.jf.intel.com with ESMTP; 12 Aug 2019 14:00:14 -0700
Date: Mon, 12 Aug 2019 14:00:14 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 15/19] mm/gup: Introduce vaddr_pin_pages()
Message-ID: <20190812210013.GC20634@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-16-ira.weiny@intel.com>
 <6ed26a08-4371-9dc1-09eb-7b8a4689d93b@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ed26a08-4371-9dc1-09eb-7b8a4689d93b@nvidia.com>
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

On Fri, Aug 09, 2019 at 05:09:54PM -0700, John Hubbard wrote:
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
> 
> Hi Ira,
> 
> OK, the API seems fine to me, anyway. :)
> 
> A bit more below...
> 
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
> 
> What's with the commas? I thought kernel-doc wants colons, like this, right?
> 
> @addr: start address

:-/  I don't know.

Fixed.

> 
> 
> > + * @nr_pages, number of pages to pin
> > + * @gup_flags, flags to use for the pin
> > + * @pages, array of pages returned
> > + * @vaddr_pin, initalized meta information this pin is to be associated
> > + * with.
> > + *
> > + * NOTE regarding vaddr_pin:
> > + *
> > + * Some callers can share pins via file descriptors to other processes.
> > + * Callers such as this should use the f_owner field of vaddr_pin to indicate
> > + * the file the fd points to.  All other callers should use the mm this pin is
> > + * being made against.  Usually "current->mm".
> > + *
> > + * Expects mmap_sem to be read locked.
> > + */
> > +long vaddr_pin_pages(unsigned long addr, unsigned long nr_pages,
> > +		     unsigned int gup_flags, struct page **pages,
> > +		     struct vaddr_pin *vaddr_pin)
> > +{
> > +	long ret;
> > +
> > +	gup_flags |= FOLL_LONGTERM;
> 
> 
> Is now the right time to introduce and use FOLL_PIN? If not, then I can always
> add it on top of this later, as part of gup-tracking patches. But you did point
> out that FOLL_LONGTERM is taking on additional meaning, and so maybe it's better
> to split that meaning up right from the start.
> 

At one point I wanted to (and had in my tree) a new flag but I went away from
it.  Prior to the discussion on mlock last week I did not think we needed it.
But I'm ok to add it back in.

I was not ignoring the idea for this RFC I just wanted to get this out there
for people to see.  I see that you threw out a couple of patches which add this
flag in.

FWIW, I think it would be good to differentiate between an indefinite pinned
page vs a referenced "gotten" page.

What you and I have been working on is the former.  So it would be easy to
change your refcounting patches to simply key off of FOLL_PIN.

Would you like me to add in your FOLL_PIN patches to this series?

> 
> > +
> > +	if (!vaddr_pin || (!vaddr_pin->mm && !vaddr_pin->f_owner))
> > +		return -EINVAL;
> > +
> > +	ret = __gup_longterm_locked(current,
> > +				    vaddr_pin->mm,
> > +				    addr, nr_pages,
> > +				    pages, NULL, gup_flags,
> > +				    vaddr_pin);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL(vaddr_pin_pages);
> > +
> > +/**
> > + * vaddr_unpin_pages_dirty_lock - counterpart to vaddr_pin_pages
> > + *
> > + * @pages, array of pages returned
> > + * @nr_pages, number of pages in pages
> > + * @vaddr_pin, same information passed to vaddr_pin_pages
> > + * @make_dirty: whether to mark the pages dirty
> > + *
> > + * The semantics are similar to put_user_pages_dirty_lock but a vaddr_pin used
> > + * in vaddr_pin_pages should be passed back into this call for propper
> 
> Typo:
                                                                   proper
Fixed.

> 
> > + * tracking.
> > + */
> > +void vaddr_unpin_pages_dirty_lock(struct page **pages, unsigned long nr_pages,
> > +				  struct vaddr_pin *vaddr_pin, bool make_dirty)
> > +{
> > +	__put_user_pages_dirty_lock(vaddr_pin, pages, nr_pages, make_dirty);
> > +}
> > +EXPORT_SYMBOL(vaddr_unpin_pages_dirty_lock);
> > 
> 
> OK, whew, I'm glad to see the updated _dirty_lock() API used here. :)

Yea this was pretty easy to change during the rebase.  Again I'm kind of
floating these quickly at this point.  So sorry about the nits...

Ira

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
