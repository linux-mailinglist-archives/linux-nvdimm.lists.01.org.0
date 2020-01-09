Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A546F1357D9
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 Jan 2020 12:25:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DB95B10097DAB;
	Thu,  9 Jan 2020 03:28:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8A3710097DA5
	for <linux-nvdimm@lists.01.org>; Thu,  9 Jan 2020 03:28:36 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 947B96A4CE;
	Thu,  9 Jan 2020 11:24:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 1FABF1E0798; Thu,  9 Jan 2020 12:24:47 +0100 (CET)
Date: Thu, 9 Jan 2020 12:24:47 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
Message-ID: <20200109112447.GG27035@quack2.suse.cz>
References: <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com>
 <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia>
 <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
 <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
 <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 3PQ4QZQ46S23WELKUWSNCPLPHMJZBGYS
X-Message-ID-Hash: 3PQ4QZQ46S23WELKUWSNCPLPHMJZBGYS
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3PQ4QZQ46S23WELKUWSNCPLPHMJZBGYS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue 07-01-20 10:49:55, Dan Williams wrote:
> On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> > dax code refers back to block device to figure out partition offset in
> > dax device. If we create a dax object corresponding to "struct block_device"
> > and store sector offset in that, then we could pass that object to dax
> > code and not worry about referring back to bdev. I have written some
> > proof of concept code and called that object "dax_handle". I can post
> > that code if there is interest.
> 
> I don't think it's worth it in the end especially considering
> filesystems are looking to operate on /dev/dax devices directly and
> remove block entanglements entirely.
> 
> > IMHO, it feels useful to be able to partition and use a dax capable
> > block device in same way as non-dax block device. It will be really
> > odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> > be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> > will work.
> 
> That can already happen today. If you do not properly align the
> partition then dax operations will be disabled. This proposal just
> extends that existing failure domain to make all partitions fail to
> support dax.

Well, I have some sympathy with the sysadmin that has /dev/pmem0 device,
decides to create partitions on it for whatever (possibly misguided)
reason and then ponders why the hell DAX is not working? And PAGE_SIZE
partition alignment is so obvious and widespread that I don't count it as a
realistic error case sysadmins would be pondering about currently.

So I'd find two options reasonably consistent:
1) Keep status quo where partitions are created and support DAX.
2) Stop partition creation altogether, if anyones wants to split pmem
device further, he can use dm-linear for that (i.e., kpartx).

But I'm not sure if the ship hasn't already sailed for option 2) to be
feasible without angry users and Linus reverting the change.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
