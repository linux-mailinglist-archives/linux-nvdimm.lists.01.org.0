Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2237172232
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Feb 2020 16:25:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A9C210FC3638;
	Thu, 27 Feb 2020 07:26:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8290010FC3638
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1582817128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IhP/uVeNAjyfX+4w576BUdyw6NCAxT3/mgVgsHd4czE=;
	b=Y1W4GdSr/dObwbu5ns2MPYwsuA3Cdr53iX8kR2fV3AbMtep+HaVbH0oTIcJ649KSrxOaTI
	g1F6oU6sbCSDKitjl0NQaZ9JemYYpn/+V/n0GFyUjcbGdD5NfJDA7JiKsEyJ/AouQuOrjl
	u5WRYbInFlmWQSyZ8GMagqUQpGV/b0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-zSt6dAGOPb6f6QGsCD_XYw-1; Thu, 27 Feb 2020 10:25:22 -0500
X-MC-Unique: zSt6dAGOPb6f6QGsCD_XYw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237A68017CC;
	Thu, 27 Feb 2020 15:25:21 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1249F87B08;
	Thu, 27 Feb 2020 15:25:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 7E1272257D2; Thu, 27 Feb 2020 10:25:17 -0500 (EST)
Date: Thu, 27 Feb 2020 10:25:17 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
Message-ID: <20200227152517.GA22844@redhat.com>
References: <20200224201346.GC14651@redhat.com>
 <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
 <20200224211553.GD14651@redhat.com>
 <CAPcyv4gX8p0YuMg3=r9DtPAO3Lz-96nuNyXbK1X5-cyVzNrDTA@mail.gmail.com>
 <20200225133653.GA7488@redhat.com>
 <CAPcyv4h2fdo=-jqLPTqnuxYVMbBgODWPqafH35yBMBaPa5Rxcw@mail.gmail.com>
 <20200225200824.GB7488@redhat.com>
 <CAPcyv4jN7ntOO2hK4ByDcX4-Kob=aJNOr3fGR_k_8rxZ=3Sz7w@mail.gmail.com>
 <20200226165756.GB30329@redhat.com>
 <20200227031143.GH10737@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200227031143.GH10737@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Message-ID-Hash: MASY62RGBC6QAZHCPZZMXI3N2K2PKQ2Y
X-Message-ID-Hash: MASY62RGBC6QAZHCPZZMXI3N2K2PKQ2Y
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MASY62RGBC6QAZHCPZZMXI3N2K2PKQ2Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Feb 27, 2020 at 02:11:43PM +1100, Dave Chinner wrote:
> On Wed, Feb 26, 2020 at 11:57:56AM -0500, Vivek Goyal wrote:
> > On Tue, Feb 25, 2020 at 02:49:30PM -0800, Dan Williams wrote:
> > [..]
> > > > > I'm ok with replacing blkdev_issue_zeroout() with a dax operation
> > > > > callback that deals with page aligned entries. That change at least
> > > > > makes the error boundary symmetric across copy_from_iter() and the
> > > > > zeroing path.
> > > >
> > > > IIUC, you are suggesting that modify dax_zero_page_range() to take page
> > > > aligned start and size and call this interface from
> > > > __dax_zero_page_range() and get rid of blkdev_issue_zeroout() in that
> > > > path?
> > > >
> > > > Something like.
> > > >
> > > > __dax_zero_page_range() {
> > > >   if(page_aligned_io)
> > > >         call_dax_page_zero_range()
> > > >   else
> > > >         use_direct_access_and_memcpy;
> > > > }
> > > >
> > > > And other callers of blkdev_issue_zeroout() in filesystems can migrate
> > > > to calling dax_zero_page_range() instead.
> > > >
> > > > If yes, I am not seeing what advantage do we get by this change.
> > > >
> > > > - __dax_zero_page_range() seems to be called by only partial block
> > > >   zeroing code. So dax_zero_page_range() call will remain unused.
> > > >
> > > >
> > > > - dax_zero_page_range() will be exact replacement of
> > > >   blkdev_issue_zeroout() so filesystems will not gain anything. Just that
> > > >   it will create a dax specific hook.
> > > >
> > > > In that case it might be simpler to just get rid of blkdev_issue_zeroout()
> > > > call from __dax_zero_page_range() and make sure there are no callers of
> > > > full block zeroing from this path.
> > > 
> > > I think you're right. The path I'm concerned about not regressing is
> > > the error clearing on new block allocation and we get that already via
> > > xfs_zero_extent() and sb_issue_zeroout().
> > 
> > Well I was wrong. I found atleast one user which uses __dax_zero_page_range()
> > to zero full PAGE_SIZE blocks.
> > 
> > xfs_io -c "allocsp 32K 0" foo.txt
> 
> That ioctl interface is deprecated and likely unused by any new
> application written since 1999. It predates unwritten extents (1998)
> and I don't think any native linux applications have ever used it. A
> newly written DAX aware application would almost certainly not use
> this interface.
> 
> IOWs, I wouldn't use it as justification for some special case
> behaviour; I'm more likely to say "rip that ancient ioctl out" than
> to jump through hoops because it's implementation behaviour.

Hi Dave,

Do you see any other path in xfs using iomap_zero_range() and zeroing
full block. iomap_zero_range() already skips IOMAP_HOLE and
IOMAP_UNWRITTEN. So it has to be a full block zeroing which is of not type
IOMAP_HOLE and IOMAP_UNWRITTEN.

My understanding is that ext4 and xfs both are initializing full blocks
using blkdev_issue_zeroout(). Only partial blocks are being zeroed using
this dax zeroing path.

If there are no callers of full block zeroing through
__dax_zero_page_range(), then I can simply get rid of
blkdev_issue_zerout() call from __dax_zero_page_range().

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
