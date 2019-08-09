Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287F788702
	for <lists+linux-nvdimm@lfdr.de>; Sat, 10 Aug 2019 01:53:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BD0282131D57C;
	Fri,  9 Aug 2019 16:56:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=211.29.132.246;
 helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by ml01.01.org (Postfix) with ESMTP id DDF3021309D25
 for <linux-nvdimm@lists.01.org>; Fri,  9 Aug 2019 16:56:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-167-148.pa.nsw.optusnet.com.au
 [49.181.167.148])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id DAF307E93B3;
 Sat, 10 Aug 2019 09:53:39 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
 (envelope-from <david@fromorbit.com>)
 id 1hwEgR-0001ae-PY; Sat, 10 Aug 2019 09:52:31 +1000
Date: Sat, 10 Aug 2019 09:52:31 +1000
From: Dave Chinner <david@fromorbit.com>
To: ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 01/19] fs/locks: Export F_LAYOUT lease to user space
Message-ID: <20190809235231.GC7777@dread.disaster.area>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-2-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190809225833.6657-2-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
 a=gu9DDhuZhshYSb5Zs/lkOA==:117 a=gu9DDhuZhshYSb5Zs/lkOA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10
 a=QyXUC8HyAAAA:8 a=7-415B0cAAAA:8 a=U9j2fOsc8QPwp6X3jq8A:9
 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
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
 John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Aug 09, 2019 at 03:58:15PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order to support an opt-in policy for users to allow long term pins
> of FS DAX pages we need to export the LAYOUT lease to user space.
> 
> This is the first of 2 new lease flags which must be used to allow a
> long term pin to be made on a file.
> 
> After the complete series:
> 
> 0) Registrations to Device DAX char devs are not affected
> 
> 1) The user has to opt in to allowing page pins on a file with an exclusive
>    layout lease.  Both exclusive and layout lease flags are user visible now.
> 
> 2) page pins will fail if the lease is not active when the file back page is
>    encountered.
> 
> 3) Any truncate or hole punch operation on a pinned DAX page will fail.
> 
> 4) The user has the option of holding the lease or releasing it.  If they
>    release it no other pin calls will work on the file.
> 
> 5) Closing the file is ok.
> 
> 6) Unmapping the file is ok
> 
> 7) Pins against the files are tracked back to an owning file or an owning mm
>    depending on the internal subsystem needs.  With RDMA there is an owning
>    file which is related to the pined file.
> 
> 8) Only RDMA is currently supported
> 
> 9) Truncation of pages which are not actively pinned nor covered by a lease
>    will succeed.

This has nothing to do with layout leases or what they provide
access arbitration over. Layout leases have _nothing_ to do with
page pinning or RDMA - they arbitrate behaviour the file offset ->
physical block device mapping within the filesystem and the
behaviour that will occur when a specific lease is held.

The commit descripting needs to describe what F_LAYOUT actually
protects, when they'll get broken, etc, not how RDMA is going to use
it.

> @@ -2022,8 +2030,26 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
>  	struct file_lock *fl;
>  	struct fasync_struct *new;
>  	int error;
> +	unsigned int flags = 0;
> +
> +	/*
> +	 * NOTE on F_LAYOUT lease
> +	 *
> +	 * LAYOUT lease types are taken on files which the user knows that
> +	 * they will be pinning in memory for some indeterminate amount of
> +	 * time.

Indeed, layout leases have nothing to do with pinning of memory.
That's something an application taht uses layout leases might do,
but it largely irrelevant to the functionality layout leases
provide. What needs to be done here is explain what the layout lease
API actually guarantees w.r.t. the physical file layout, not what
some application is going to do with a lease. e.g.

	The layout lease F_RDLCK guarantees that the holder will be
	notified that the physical file layout is about to be
	changed, and that it needs to release any resources it has
	over the range of this lease, drop the lease and then
	request it again to wait for the kernel to finish whatever
	it is doing on that range.

	The layout lease F_RDLCK also allows the holder to modify
	the physical layout of the file. If an operation from the
	lease holder occurs that would modify the layout, that lease
	holder does not get notification that a change will occur,
	but it will block until all other F_RDLCK leases have been
	released by their holders before going ahead.

	If there is a F_WRLCK lease held on the file, then a F_RDLCK
	holder will fail any operation that may modify the physical
	layout of the file. F_WRLCK provides exclusive physical
	modification access to the holder, guaranteeing nothing else
	will change the layout of the file while it holds the lease.

	The F_WRLCK holder can change the physical layout of the
	file if it so desires, this will block while F_RDLCK holders
	are notified and release their leases before the
	modification will take place.

We need to define the semantics we expose to userspace first.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
