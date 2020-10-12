Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750C28AE7D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 08:56:44 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6502C1562E47E;
	Sun, 11 Oct 2020 23:56:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=ira.weiny@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69D9E1562E45A
	for <linux-nvdimm@lists.01.org>; Sun, 11 Oct 2020 23:56:39 -0700 (PDT)
IronPort-SDR: 7EmXzm8ZgwxuR4aEUMcyqQC4Oy/idd+NyYcDvTFh5vRzl+JJKEGAcWu3qcy6h50wFI1q4MPS4F
 kNOY0HYzN76A==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="250392524"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400";
   d="scan'208";a="250392524"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:56:37 -0700
IronPort-SDR: DSpSIoZKV7KPLq4zxFvBA+ZLKNkpgmuUQCwMmUi8wsqk6OFxxWBKXoVpyUUZRY9EN2DChpPczf
 4EPhWIQlBVGQ==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400";
   d="scan'208";a="529842687"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 23:56:35 -0700
Date: Sun, 11 Oct 2020 23:56:35 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize new kmap_thread()
Message-ID: <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201010013036.GD1122@sol.localdomain>
User-Agent: Mutt/1.11.1 (2018-12-01)
Message-ID-Hash: KQGIZ3F7S3DQYG6LLW5SU55WBKUKR3TP
X-Message-ID-Hash: KQGIZ3F7S3DQYG6LLW5SU55WBKUKR3TP
X-MailFrom: ira.weiny@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-aio@kvack.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kselftest@vger.kernel.org, samba-technical@lists.samba.org, ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org, cluster-devel@redhat.com, linux-cachefs@redhat.com, intel-wired-lan@lists.osuosl.org, xen-
 devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, intel-gfx@lists.freedesktop.org, linux-erofs@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, io-uring@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KQGIZ3F7S3DQYG6LLW5SU55WBKUKR3TP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Oct 09, 2020 at 06:30:36PM -0700, Eric Biggers wrote:
> On Sat, Oct 10, 2020 at 01:39:54AM +0100, Matthew Wilcox wrote:
> > On Fri, Oct 09, 2020 at 02:34:34PM -0700, Eric Biggers wrote:
> > > On Fri, Oct 09, 2020 at 12:49:57PM -0700, ira.weiny@intel.com wrote:
> > > > The kmap() calls in this FS are localized to a single thread.  To avoid
> > > > the over head of global PKRS updates use the new kmap_thread() call.
> > > >
> > > > @@ -2410,12 +2410,12 @@ static inline struct page *f2fs_pagecache_get_page(
> > > >  
> > > >  static inline void f2fs_copy_page(struct page *src, struct page *dst)
> > > >  {
> > > > -	char *src_kaddr = kmap(src);
> > > > -	char *dst_kaddr = kmap(dst);
> > > > +	char *src_kaddr = kmap_thread(src);
> > > > +	char *dst_kaddr = kmap_thread(dst);
> > > >  
> > > >  	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
> > > > -	kunmap(dst);
> > > > -	kunmap(src);
> > > > +	kunmap_thread(dst);
> > > > +	kunmap_thread(src);
> > > >  }
> > > 
> > > Wouldn't it make more sense to switch cases like this to kmap_atomic()?
> > > The pages are only mapped to do a memcpy(), then they're immediately unmapped.
> > 
> > Maybe you missed the earlier thread from Thomas trying to do something
> > similar for rather different reasons ...
> > 
> > https://lore.kernel.org/lkml/20200919091751.011116649@linutronix.de/
> 
> I did miss it.  I'm not subscribed to any of the mailing lists it was sent to.
> 
> Anyway, it shouldn't matter.  Patchsets should be standalone, and not require
> reading random prior threads on linux-kernel to understand.

Sorry, but I did not think that the discussion above was directly related.  If
I'm not mistaken, Thomas' work was directed at relaxing kmap_atomic() into
kmap_thread() calls.  While interesting, it is not the point of this series.  I
want to restrict kmap() callers into kmap_thread().

For this series it was considered to change the kmap_thread() call sites to
kmap_atomic().  But like I said in the cover letter kmap_atomic() is not the
same semantic.  It is too strict.  Perhaps I should have expanded that
explanation.

> 
> And I still don't really understand.  After this patchset, there is still code
> nearly identical to the above (doing a temporary mapping just for a memcpy) that
> would still be using kmap_atomic().

I don't understand.  You mean there would be other call sites calling:

kmap_atomic()
memcpy()
kunmap_atomic()

?

> Is the idea that later, such code will be
> converted to use kmap_thread() instead?  If not, why use one over the other?
 

The reason for the new call is that with PKS added behind kmap we have 3 levels
of mapping we want.

global kmap (can span threads and sleep)
'thread' kmap (can sleep but not span threads)
'atomic' kmap (can't sleep nor span threads [by definition])

As Matthew said perhaps 'global kmaps' may be best changed to vmaps?  I just
don't know the details of every call site.

And since I don't know the call site details if there are kmap_thread() calls
which are better off as kmap_atomic() calls I think it is worth converting
them.  But I made the assumption that kmap users would already be calling
kmap_atomic() if they could (because it is more efficient).

Ira
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
