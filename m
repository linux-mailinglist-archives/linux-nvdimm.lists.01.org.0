Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B52159D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 10:47:48 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9CB332127340F;
	Fri, 17 May 2019 01:47:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9548421273402
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 01:47:44 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4AA79AE33;
 Fri, 17 May 2019 08:47:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 767281E3ED6; Fri, 17 May 2019 10:47:39 +0200 (CEST)
Date: Fri, 17 May 2019 10:47:39 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
Message-ID: <20190517084739.GB20550@quack2.suse.cz>
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Jeff Smits <jeff.smits@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>,
 linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Let's add Kees to CC for usercopy expertise...

On Thu 16-05-19 17:33:38, Dan Williams wrote:
> Jeff discovered that performance improves from ~375K iops to ~519K iops
> on a simple psync-write fio workload when moving the location of 'struct
> page' from the default PMEM location to DRAM. This result is surprising
> because the expectation is that 'struct page' for dax is only needed for
> third party references to dax mappings. For example, a dax-mapped buffer
> passed to another system call for direct-I/O requires 'struct page' for
> sending the request down the driver stack and pinning the page. There is
> no usage of 'struct page' for first party access to a file via
> read(2)/write(2) and friends.
> 
> However, this "no page needed" expectation is violated by
> CONFIG_HARDENED_USERCOPY and the check_copy_size() performed in
> copy_from_iter_full_nocache() and copy_to_iter_mcsafe(). The
> check_heap_object() helper routine assumes the buffer is backed by a
> page-allocator DRAM page and applies some checks.  Those checks are
> invalid, dax pages are not from the heap, and redundant,
> dax_iomap_actor() has already validated that the I/O is within bounds.

So this last paragraph is not obvious to me as check_copy_size() does a lot
of various checks in CONFIG_HARDENED_USERCOPY case. I agree that some of
those checks don't make sense for PMEM pages but I'd rather handle that by
refining check_copy_size() and check_object_size() functions to detect and
appropriately handle pmem pages rather that generally skip all the checks
in pmem_copy_from/to_iter(). And yes, every check in such hot path is going
to cost performance but that's what user asked for with
CONFIG_HARDENED_USERCOPY... Kees?

								Honza

> 
> Bypass this overhead and call the 'no check' versions of the
> copy_{to,from}_iter operations directly.
> 
> Fixes: 0aed55af8834 ("x86, uaccess: introduce copy_from_iter_flushcache...")
> Cc: Jan Kara <jack@suse.cz>
> Cc: <stable@vger.kernel.org>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Reported-and-tested-by: Jeff Smits <jeff.smits@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/nvdimm/pmem.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 845c5b430cdd..c894f45e5077 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -281,16 +281,21 @@ static long pmem_dax_direct_access(struct dax_device *dax_dev,
>  	return __pmem_direct_access(pmem, pgoff, nr_pages, kaddr, pfn);
>  }
>  
> +/*
> + * Use the 'no check' versions of copy_from_iter_flushcache() and
> + * copy_to_iter_mcsafe() to bypass HARDENED_USERCOPY overhead. Bounds
> + * checking is handled by dax_iomap_actor()
> + */
>  static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i)
>  {
> -	return copy_from_iter_flushcache(addr, bytes, i);
> +	return _copy_from_iter_flushcache(addr, bytes, i);
>  }
>  
>  static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i)
>  {
> -	return copy_to_iter_mcsafe(addr, bytes, i);
> +	return _copy_to_iter_mcsafe(addr, bytes, i);
>  }
>  
>  static const struct dax_operations pmem_dax_ops = {
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
