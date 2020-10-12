Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231DE28C1EE
	for <lists+linux-nvdimm@lfdr.de>; Mon, 12 Oct 2020 22:03:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC47E15D14759;
	Mon, 12 Oct 2020 13:03:23 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D911815D14757
	for <linux-nvdimm@lists.01.org>; Mon, 12 Oct 2020 13:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bCWIFHvT8FvIPrDMc3maof4qHUnzu6oS60i9lgfyu+w=; b=osm7lCKhtCxcgsJVmnbUIZHhMp
	5nvioHkxA8AhlfbRA0tXQBSBlQdovP0UNFUmlu/tYL30pdEacRnzwKeBjNLJ8YRj+D/sF4f+x4FRA
	68EE5VyuQPlhkPgzE4vuiuikkji/6lzFKcK2qIYtpBfSW0scT+5xZ65/me+9ijMgWVh8NM56bexcy
	gJZd0qYjXWzdg4a2mFecVVyLa3Rwg0gTTp9KEwoseCi8fLlQXob3uBfLwA1anIPkZvUKPjVJpvK3u
	UT+9cSbb34PGNNH3jL974SwKTCytz2qfL4ONXzbZAaSn1ZoiKQGnXIIuZa+WQOp/Awa/qjp/ly6GK
	H6D/8XHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS422-0000HA-AX; Mon, 12 Oct 2020 20:02:54 +0000
Date: Mon, 12 Oct 2020 21:02:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize new kmap_thread()
Message-ID: <20201012200254.GB20115@casper.infradead.org>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
 <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
 <20201012161946.GA858@sol.localdomain>
 <5d621db9-23d4-e140-45eb-d7fca2093d2b@intel.com>
 <20201012164438.GA20115@casper.infradead.org>
 <20201012195354.GC2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201012195354.GC2046448@iweiny-DESK2.sc.intel.com>
Message-ID-Hash: GBGYZT6724PVSKHWRFLU66HO2SWT5Y2J
X-Message-ID-Hash: GBGYZT6724PVSKHWRFLU66HO2SWT5Y2J
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dave Hansen <dave.hansen@intel.com>, Eric Biggers <ebiggers@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-aio@kvack.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, target-devel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kselftest@vger.kernel.org, samba-technical@lists.samba.org, ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, linux-afs@lists.infradead.org, cluster-devel@redhat.com, linux-cachefs@redhat.com, int
 el-wired-lan@lists.osuosl.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, ecryptfs@vger.kernel.org, linux-um@lists.infradead.org, intel-gfx@lists.freedesktop.org, linux-erofs@lists.ozlabs.org, reiserfs-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, io-uring@vger.kernel.org, linux-nfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-btrfs@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GBGYZT6724PVSKHWRFLU66HO2SWT5Y2J/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Oct 12, 2020 at 12:53:54PM -0700, Ira Weiny wrote:
> On Mon, Oct 12, 2020 at 05:44:38PM +0100, Matthew Wilcox wrote:
> > On Mon, Oct 12, 2020 at 09:28:29AM -0700, Dave Hansen wrote:
> > > kmap_atomic() is always preferred over kmap()/kmap_thread().
> > > kmap_atomic() is _much_ more lightweight since its TLB invalidation is
> > > always CPU-local and never broadcast.
> > > 
> > > So, basically, unless you *must* sleep while the mapping is in place,
> > > kmap_atomic() is preferred.
> > 
> > But kmap_atomic() disables preemption, so the _ideal_ interface would map
> > it only locally, then on preemption make it global.  I don't even know
> > if that _can_ be done.  But this email makes it seem like kmap_atomic()
> > has no downsides.
> 
> And that is IIUC what Thomas was trying to solve.
> 
> Also, Linus brought up that kmap_atomic() has quirks in nesting.[1]
> 
> >From what I can see all of these discussions support the need to have something
> between kmap() and kmap_atomic().
> 
> However, the reason behind converting call sites to kmap_thread() are different
> between Thomas' patch set and mine.  Both require more kmap granularity.
> However, they do so with different reasons and underlying implementations but
> with the _same_ resulting semantics; a thread local mapping which is
> preemptable.[2]  Therefore they each focus on changing different call sites.
> 
> While this patch set is huge I think it serves a valuable purpose to identify a
> large number of call sites which are candidates for this new semantic.

Yes, I agree.  My problem with this patch-set is that it ties it to
some Intel feature that almost nobody cares about.  Maybe we should
care about it, but you didn't try very hard to make anyone care about
it in the cover letter.

For a future patch-set, I'd like to see you just introduce the new
API.  Then you can optimise the Intel implementation of it afterwards.
Those patch-sets have entirely different reviewers.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
