Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4885E8DCBF
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Aug 2019 20:08:52 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C8A4D20311214;
	Wed, 14 Aug 2019 11:10:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DF337202ECFAE
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 11:10:53 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 11:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; d="scan'208";a="376130035"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2019 11:08:49 -0700
Date: Wed, 14 Aug 2019 11:08:49 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190814101714.GA26273@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814101714.GA26273@quack2.suse.cz>
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
 linux-xfs@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> Hello!
> 
> On Fri 09-08-19 15:58:14, ira.weiny@intel.com wrote:
> > Pre-requisites
> > ==============
> > 	Based on mmotm tree.
> > 
> > Based on the feedback from LSFmm, the LWN article, the RFC series since
> > then, and a ton of scenarios I've worked in my mind and/or tested...[1]
> > 
> > Solution summary
> > ================
> > 
> > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > memory which is then truncated.  So really any solution we present which:
> > 
> > A) Prevents file system corruption or data leaks
> > ...and...
> > B) Informs the user that they did something wrong
> > 
> > Should be an acceptable solution.
> > 
> > Because this is slightly new behavior.  And because this is going to be
> > specific to DAX (because of the lack of a page cache) we have made the user
> > "opt in" to this behavior.
> > 
> > The following patches implement the following solution.
> > 
> > 0) Registrations to Device DAX char devs are not affected
> > 
> > 1) The user has to opt in to allowing page pins on a file with an exclusive
> >    layout lease.  Both exclusive and layout lease flags are user visible now.
> > 
> > 2) page pins will fail if the lease is not active when the file back page is
> >    encountered.
> > 
> > 3) Any truncate or hole punch operation on a pinned DAX page will fail.
> 
> So I didn't fully grok the patch set yet but by "pinned DAX page" do you
> mean a page which has corresponding file_pin covering it? Or do you mean a
> page which has pincount increased? If the first then I'd rephrase this to
> be less ambiguous, if the second then I think it is wrong. 

I mean the second.  but by "fail" I mean hang.  Right now the "normal" page
pincount processing will hang the truncate.  Given the discussion with John H
we can make this a bit better if we use something like FOLL_PIN and the page
count bias to indicate this type of pin.  Then I could fail the truncate
outright.  but that is not done yet.

so... I used the word "fail" to be a bit more vague as the final implementation
may return ETXTBUSY or hang as noted.

> 
> > 4) The user has the option of holding the lease or releasing it.  If they
> >    release it no other pin calls will work on the file.
> 
> Last time we spoke the plan was that the lease is kept while the pages are
> pinned (and an attempt to release the lease would block until the pages are
> unpinned). That also makes it clear that the *lease* is what is making
> truncate and hole punch fail with ETXTBUSY and the file_pin structure is
> just an implementation detail how the existence is efficiently tracked (and
> what keeps the backing file for the pages open so that the lease does not
> get auto-destroyed). Why did you change this?

closing the file _and_ unmaping it will cause the lease to be released
regardless of if we allow this or not.

As we discussed preventing the close seemed intractable.

I thought about failing the munmap but that seemed wrong as well.  But more
importantly AFAIK RDMA can pass its memory pins to other processes via FD
passing...  This means that one could pin this memory, pass it to another
process and exit.  The file lease on the pin'ed file is lost.

The file lease is just a key to get the memory pin.  Once unlocked the procfs
tracking keeps track of where that pin goes and which processes need to be
killed to get rid of it.

> 
> > 5) Closing the file is ok.
> > 
> > 6) Unmapping the file is ok
> > 
> > 7) Pins against the files are tracked back to an owning file or an owning mm
> >    depending on the internal subsystem needs.  With RDMA there is an owning
> >    file which is related to the pined file.
> > 
> > 8) Only RDMA is currently supported
> 
> If you currently only need "owning file" variant in your patch set, then
> I'd just implement that and leave "owning mm" variant for later if it
> proves to be necessary. The things are complex enough as is...

I can do that...  I was trying to get io_uring working as well with the
owning_mm but I should save that for later.

> 
> > 9) Truncation of pages which are not actively pinned nor covered by a lease
> >    will succeed.
> 
> Otherwise I like the design.

Thanks,
Ira

> 
> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
