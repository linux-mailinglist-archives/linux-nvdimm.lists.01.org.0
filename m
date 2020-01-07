Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A6132E88
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 19:33:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F294A10097E12;
	Tue,  7 Jan 2020 10:36:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.81; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [207.211.31.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 81E6B10097E0F
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 10:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1578421998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o2v5kMDPXg2q4+QAcC/kCbrlQj05oGBBvgK3JOC1J3M=;
	b=V5yCte4rgcV861M9EVonxcDrm4wSuMO88Pv89b56oH6H5TI1UJBW5wlFwnh1BvhLVIy7bB
	lwqM/AbP+s/ulR/og01ufS2BoxLmnLGVuwqjF1Xw2kI2OD944YXT/ifniYXiZPuPkNF5uP
	tuOCLRg7gEeRrU3NEC1n+dKU3qKSsVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-U97v-XCQMkax5zcCnuUoeQ-1; Tue, 07 Jan 2020 13:33:14 -0500
X-MC-Unique: U97v-XCQMkax5zcCnuUoeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A55418C8C31;
	Tue,  7 Jan 2020 18:33:13 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0E4F7C35A;
	Tue,  7 Jan 2020 18:33:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 6FF242202E9; Tue,  7 Jan 2020 13:33:07 -0500 (EST)
Date: Tue, 7 Jan 2020 13:33:07 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200107183307.GD15920@redhat.com>
References: <20190828175843.GB912@redhat.com>
 <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: F7NMWOGMWISUQRMRSIRA32W2DXWXYIRF
X-Message-ID-Hash: F7NMWOGMWISUQRMRSIRA32W2DXWXYIRF
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/F7NMWOGMWISUQRMRSIRA32W2DXWXYIRF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 07, 2020 at 10:07:18AM -0800, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > >
> > > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > >
> > > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > > implementation to expect the block-device to be available.
> > > > > > > >
> > > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > > cleanup opportunities.
> > > > > > >
> > > > > > > Hi Dan,
> > > > > > >
> > > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > > >
> > > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > > including partition 0). That probably means state belong to whole device
> > > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > > dax_device_common.
> > > > > > >
> > > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > > partitions be exported to user space.
> > > > > >
> > > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > > devices and then remove them after a cycle or two?
> > > > >
> > > > > That does seem a better plan than trying to force partition support
> > > > > where it is not needed.
> > > >
> > > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > > create dm-linear devices for each partition, will DAX still work through
> > > > that?
> > >
> > > The device-mapper support will continue, but it will be limited to
> > > whole device sub-components. I.e. you could use kpartx to carve up
> > > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
> >
> > So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> > is a block device, I thought tools will expect it to be partitioned.
> > Sometimes I create those partitions and use /dev/pmem0. So what's
> > the replacement for this. People often have tools/scripts which might
> > want to partition the device and these will start failing.
> 
> Partitioning will still work, but dax operation will be declined and
> fall back to page-cache.

Ok, so if I mount /dev/pmem0p1 with dax enabled, that might fail or
filesystem will fall back to using page cache. (But dax will not be
enabled).

> 
> > IOW, I do not understand that why being able to partition /dev/pmem0
> > (which is a block device from user space point of view), is pointless.
> 
> How about s/pointless/redundant/. Persistent memory can already be
> "partitioned" via namespace boundaries.

But that's an entirely different way of partitioning. To me being able
to use block devices (with dax capability) in same way as any other
block device makes sense.

> Block device partitioning is
> then redundant and needlessly complicates, as you have found, the
> kernel implementation.

It does complicate kernel implementation. Is it too hard to solve the
problem in kernel.

W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
dax code refers back to block device to figure out partition offset in
dax device. If we create a dax object corresponding to "struct block_device"
and store sector offset in that, then we could pass that object to dax
code and not worry about referring back to bdev. I have written some
proof of concept code and called that object "dax_handle". I can post
that code if there is interest.

IMHO, it feels useful to be able to partition and use a dax capable
block device in same way as non-dax block device. It will be really
odd to think that if filesystem is on /dev/pmem0p1, then dax can't
be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
will work.

Thanks
Vivek

> 
> The problem will be people that were on dax+ext4 on partitions. Those
> people will see a hard failure at mount whereas XFS will fallback to
> page cache with a warning in the log. I think ext4 must convert to the
> xfs dax handling model before partition support is dropped.
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
