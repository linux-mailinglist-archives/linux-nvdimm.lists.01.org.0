Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 777E615963B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Feb 2020 18:33:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D48B310FC3361;
	Tue, 11 Feb 2020 09:37:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 546B410FC319F
	for <linux-nvdimm@lists.01.org>; Tue, 11 Feb 2020 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1581442425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4X0xfWONZNxuOkpbq3f8Jv0lG2stok0ct4V7XvEvhEQ=;
	b=LtOqWKX5ju7/KYr5ptbQuRVw0+N1NS/8fa/Tm8GhUpi8geinCTe8+fhneO+RqpWdFf2Qp6
	VElfekyih48slW4wEWbTVLVd88wWlCa7poPYMISZQhTdeAKjjKsu6GcvVKOHXmsMCQlAf4
	TSAsJqhjuwJgWbMOwX3E3ykP0YUMpU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-h0GrCcpQOAi3KCxts--_oA-1; Tue, 11 Feb 2020 12:33:38 -0500
X-MC-Unique: h0GrCcpQOAi3KCxts--_oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 391D9100550E;
	Tue, 11 Feb 2020 17:33:37 +0000 (UTC)
Received: from horse.redhat.com (ovpn-123-66.rdu2.redhat.com [10.10.123.66])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C807D26FB2;
	Tue, 11 Feb 2020 17:33:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 4579E220A24; Tue, 11 Feb 2020 12:33:31 -0500 (EST)
Date: Tue, 11 Feb 2020 12:33:31 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200211173331.GC8590@redhat.com>
References: <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
 <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com>
 <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Message-ID-Hash: JM37ZCX2G6B5MB2M7F64W5PIWFDN2QH4
X-Message-ID-Hash: JM37ZCX2G6B5MB2M7F64W5PIWFDN2QH4
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JM37ZCX2G6B5MB2M7F64W5PIWFDN2QH4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 16, 2020 at 10:09:46AM -0800, Dan Williams wrote:
> On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Hi, Dan,
> >
> > Dan Williams <dan.j.williams@intel.com> writes:
> >
> > > I'm going to take a look at how hard it would be to develop a kpartx
> > > fallback in udev. If that can live across the driver transition then
> > > maybe this can be a non-event for end users that already have that
> > > udev update deployed.
> >
> > I just wanted to remind you that label-less dimms still exist, and are
> > still being shipped.  For those devices, the only way to subdivide the
> > storage is via partitioning.
> 
> True, but if kpartx + udev can make this transparent then I don't
> think users lose any functionality. They just gain a device-mapper
> dependency.

Hi Dan,

Are you planning to look into making this work?

We can easily disable partition scanning by specifying gendisk
GENHD_FL_NO_PART_SCAN flag. But what about partition additiona path,
ioctl(BLKPG_ADD_PARTITION). That does not seem to do any checks whether
block device supports in kernel partitions or not. 

So kernel partitions (hence /dev/pmemXpY) objects are created anyway and
this will conflict with all the new planned udev rules.

If you block ioctl(BLKPG_ADD_PARTITION), then user space tools like
parted and fdisk started breaking when trying to create a partition
on /dev/pmeme0. IIUC, we have to allow partition table creation on
/dev/pmem0 so that later kpartx can parse it and create dm-linear
partitions.

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
