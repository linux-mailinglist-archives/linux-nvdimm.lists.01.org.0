Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149B170ED9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 04:11:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65A2510FC361A;
	Wed, 26 Feb 2020 19:12:41 -0800 (PST)
Received-SPF: Pass (helo) identity=helo; client-ip=211.29.132.246; helo=mail104.syd.optusnet.com.au; envelope-from=david@fromorbit.com; receiver=<UNKNOWN> 
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
	by ml01.01.org (Postfix) with ESMTP id 90C5E10FC3597
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 19:12:38 -0800 (PST)
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4D5587EAACE;
	Thu, 27 Feb 2020 14:11:45 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1j79aR-000690-Tq; Thu, 27 Feb 2020 14:11:43 +1100
Date: Thu, 27 Feb 2020 14:11:43 +1100
From: Dave Chinner <david@fromorbit.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200227031143.GH10737@dread.disaster.area>
References: <20200223230330.GE10737@dread.disaster.area>
 <20200224201346.GC14651@redhat.com>
 <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
 <20200224211553.GD14651@redhat.com>
 <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
 <20200225133653.GA7488@redhat.com>
 <CAPcyv4h2fdo=-jqLPTqnuxYVMbBgODWPqafH35yBMBaPa5Rxcw@mail.gmail.com>
 <20200225200824.GB7488@redhat.com>
 <CAPcyv4jN7ntOO2hK4ByDcX4-Kob=aJNOr3fGR_k_8rxZ=3Sz7w@mail.gmail.com>
 <20200226165756.GB30329@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200226165756.GB30329@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
	a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
	a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
	a=7-415B0cAAAA:8 a=JyclL5V1kyJuvP7DWe4A:9 a=esild3LDZCtdEqoH:21
	a=FE7rXZW1Nghj-ak8:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Message-ID-Hash: PNMZLOXXMJ362Z55KAZGDBYOYKOTIO4B
X-Message-ID-Hash: PNMZLOXXMJ362Z55KAZGDBYOYKOTIO4B
X-MailFrom: david@fromorbit.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PNMZLOXXMJ362Z55KAZGDBYOYKOTIO4B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 26, 2020 at 11:57:56AM -0500, Vivek Goyal wrote:
> On Tue, Feb 25, 2020 at 02:49:30PM -0800, Dan Williams wrote:
> [..]
> > > > I'm ok with replacing blkdev_issue_zeroout() with a dax operation
> > > > callback that deals with page aligned entries. That change at least
> > > > makes the error boundary symmetric across copy_from_iter() and the
> > > > zeroing path.
> > >
> > > IIUC, you are suggesting that modify dax_zero_page_range() to take page
> > > aligned start and size and call this interface from
> > > __dax_zero_page_range() and get rid of blkdev_issue_zeroout() in that
> > > path?
> > >
> > > Something like.
> > >
> > > __dax_zero_page_range() {
> > >   if(page_aligned_io)
> > >         call_dax_page_zero_range()
> > >   else
> > >         use_direct_access_and_memcpy;
> > > }
> > >
> > > And other callers of blkdev_issue_zeroout() in filesystems can migrate
> > > to calling dax_zero_page_range() instead.
> > >
> > > If yes, I am not seeing what advantage do we get by this change.
> > >
> > > - __dax_zero_page_range() seems to be called by only partial block
> > >   zeroing code. So dax_zero_page_range() call will remain unused.
> > >
> > >
> > > - dax_zero_page_range() will be exact replacement of
> > >   blkdev_issue_zeroout() so filesystems will not gain anything. Just that
> > >   it will create a dax specific hook.
> > >
> > > In that case it might be simpler to just get rid of blkdev_issue_zeroout()
> > > call from __dax_zero_page_range() and make sure there are no callers of
> > > full block zeroing from this path.
> > 
> > I think you're right. The path I'm concerned about not regressing is
> > the error clearing on new block allocation and we get that already via
> > xfs_zero_extent() and sb_issue_zeroout().
> 
> Well I was wrong. I found atleast one user which uses __dax_zero_page_range()
> to zero full PAGE_SIZE blocks.
> 
> xfs_io -c "allocsp 32K 0" foo.txt

That ioctl interface is deprecated and likely unused by any new
application written since 1999. It predates unwritten extents (1998)
and I don't think any native linux applications have ever used it. A
newly written DAX aware application would almost certainly not use
this interface.

IOWs, I wouldn't use it as justification for some special case
behaviour; I'm more likely to say "rip that ancient ioctl out" than
to jump through hoops because it's implementation behaviour.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
