Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7AC13BBCA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Jan 2020 10:03:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6260E10097DBE;
	Wed, 15 Jan 2020 01:06:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6224C10097DAF
	for <linux-nvdimm@lists.01.org>; Wed, 15 Jan 2020 01:06:35 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 063F3AC6E;
	Wed, 15 Jan 2020 09:03:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 3EAEA1E0CBC; Wed, 15 Jan 2020 10:03:06 +0100 (CET)
Date: Wed, 15 Jan 2020 10:03:06 +0100
From: Jan Kara <jack@suse.cz>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200115090306.GA31450@quack2.suse.cz>
References: <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz>
 <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com>
 <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200114212805.GB3145@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: MJSN6JZSZCCWC6IUSJYJ3DQPTAWVLDMW
X-Message-ID-Hash: MJSN6JZSZCCWC6IUSJYJ3DQPTAWVLDMW
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MJSN6JZSZCCWC6IUSJYJ3DQPTAWVLDMW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 14-01-20 16:28:05, Vivek Goyal wrote:
> On Tue, Jan 14, 2020 at 12:39:00PM -0800, Dan Williams wrote:
> > I think we should at least try to delete the partition support and see
> > if anyone screams. Have a module option to revert the behavior so
> > people are not stuck waiting for the revert to land, but if it stays
> > quiet then we're in a better place with that support pushed out of the
> > dax core.
> 
> Hi Dan,
> 
> So basically keep partition support code just that disable it by default
> and it is enabled by some knob say kernel command line option/module
> option.
> 
> At what point of time will we remove that code completely. I mean what
> if people scream after two kernel releases, after we have removed the
> code.
> 
> Also, from distribution's perspective, we might not hear from our
> customers for a very long time (till we backport that code in to
> existing releases or release this new code in next major release). From
> that view point I will not like to break existing user visible behavior.
> 
> How bad it is to keep partition support around. To me it feels reasonaly
> simple where we just have to store offset into dax device into another
> dax object and pass that object around (instead of dax_device). If that's
> the case, I am not sure why to even venture into a direction where some
> user's setup might be broken.
> 
> Also from an application perspective, /dev/pmem is a block device, so it
> should behave like a block device, (including kernel partition table support).
> From that view, dax looks like just an additional feature of that device
> which can be enabled by passing option "-o dax".

Well, not all block devices are partitionable. For example cdroms are
standard block devices but partitioning does not run for them. Similarly
device mapper devices are block devices but not partitioned. So there is
some precedens in not doing partitioning for some types of block devices.

For the rest I agree that kernels where pmem devices are partitionable have
shipped in enterprise distros and are going to be supported (and used) for
5-10 years before users decide to move on to something newer - at which
point we'll only find out whether someone used the feature or not. So
deprecation is going to be somewhat interesting. On the other hand clever
udev rule that detects partition table on pmem device and uses kpartx to
partition these devices (like what happens e.g. for dm-multipath devices)
could possibly be used as a replacement for kernel support so there's a way
out of this...

So I don't care too deeply about what the decision is going to be.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
