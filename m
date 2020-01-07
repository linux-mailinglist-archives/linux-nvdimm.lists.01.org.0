Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DF5132EB1
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 19:50:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 397E810097E13;
	Tue,  7 Jan 2020 10:53:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7521210097E12
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 10:53:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id v140so400140oie.0
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 10:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t48KUg/ZZUxxUfAn6PKZNoX6jboF7EFYxp12esgcQ28=;
        b=ZMpgs2GKyoBtwEMsSb+m34paimovDcZpnH2wIQCItZ+wZEXPLHaFsrW1Ka8cSuQMnE
         L3LOT9AELU5HIQwh5IJkC8uTu8BMrWW1J9xsNCKLVyyaTMgmz0aoyeSKcEbJRxfjkkgV
         5/GsAUxCrExLRE7VKDI+3Rz3Kx3X9A4cs7uTdXiv2ihlLJ6Oc/O1aTuuTcFoqM5nClll
         Sjr9Yl3VgHCYIsueORm7ISm1jdWsGOS3MytGAdYtcbeb/7n1ecazjNclYZvxhqARCCHQ
         PtHsKiZ0iuTvYnOfl/nibcnc+74rtOGBOev5CMVX19jm1kVUidOQa62QdS1UQz5OAtbF
         R1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t48KUg/ZZUxxUfAn6PKZNoX6jboF7EFYxp12esgcQ28=;
        b=nPwMLRXcKYemLFq1z0ybfmSd48jups2rYo8FXqlytd9dYGZC0vo3En3HaW32GgnUtb
         n4wxz1gVP4WT8rELq2BMJMO4HvU8oDD69GHxSpRNRwIbbQpxPFxpdDaZ+mssHGAx3jbG
         yYRkmKVWA63DLJ0miThPhv7Q/En4G/OIIcLVZ4BGODsguVMcUCqPx6/lYG9Z7TV4h3Xz
         Zua0hi9Nb70tXh2TOtFYugS+nPEPEh60EOKAti8RaAceyrfLVDpAn1BYErQGYJU7rGIm
         FSucrDe289HmKQrV2HIG9pritFYrTZ0ZCYULk9pH2+HjuTEw0z4tZA/NgZlkeTLDWTX+
         Cw6Q==
X-Gm-Message-State: APjAAAXtzCWLkB3wLCRtgBmHb5OICQrwpWLEPeoXVWYo3ebOPuLpGYOG
	vfm3C/KysvwZV84Q853ydDKozxeX7AD2+OrFJno0VA==
X-Google-Smtp-Source: APXvYqySCi7jdU7hO7GxjPpaMeSSljm0zTFLcblWxgWtNbBVyesDfcmhxVvT/h+O/Soz0EZ3GWEae9nu2R5pOinvUiI=
X-Received: by 2002:a05:6808:b37:: with SMTP id t23mr687284oij.149.1578423006001;
 Tue, 07 Jan 2020 10:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com>
In-Reply-To: <20200107183307.GD15920@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 10:49:55 -0800
Message-ID: <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: LFSQRKAEREO5P3D6APUWIHP5MUTSZDCK
X-Message-ID-Hash: LFSQRKAEREO5P3D6APUWIHP5MUTSZDCK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LFSQRKAEREO5P3D6APUWIHP5MUTSZDCK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 10:33 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 10:07:18AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > > > >
> > > > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > > > implementation to expect the block-device to be available.
> > > > > > > > >
> > > > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > > > cleanup opportunities.
> > > > > > > >
> > > > > > > > Hi Dan,
> > > > > > > >
> > > > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > > > >
> > > > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > > > including partition 0). That probably means state belong to whole device
> > > > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > > > dax_device_common.
> > > > > > > >
> > > > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > > > partitions be exported to user space.
> > > > > > >
> > > > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > > > devices and then remove them after a cycle or two?
> > > > > >
> > > > > > That does seem a better plan than trying to force partition support
> > > > > > where it is not needed.
> > > > >
> > > > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > > > create dm-linear devices for each partition, will DAX still work through
> > > > > that?
> > > >
> > > > The device-mapper support will continue, but it will be limited to
> > > > whole device sub-components. I.e. you could use kpartx to carve up
> > > > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
> > >
> > > So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> > > is a block device, I thought tools will expect it to be partitioned.
> > > Sometimes I create those partitions and use /dev/pmem0. So what's
> > > the replacement for this. People often have tools/scripts which might
> > > want to partition the device and these will start failing.
> >
> > Partitioning will still work, but dax operation will be declined and
> > fall back to page-cache.
>
> Ok, so if I mount /dev/pmem0p1 with dax enabled, that might fail or
> filesystem will fall back to using page cache. (But dax will not be
> enabled).
>
> >
> > > IOW, I do not understand that why being able to partition /dev/pmem0
> > > (which is a block device from user space point of view), is pointless.
> >
> > How about s/pointless/redundant/. Persistent memory can already be
> > "partitioned" via namespace boundaries.
>
> But that's an entirely different way of partitioning. To me being able
> to use block devices (with dax capability) in same way as any other
> block device makes sense.
>
> > Block device partitioning is
> > then redundant and needlessly complicates, as you have found, the
> > kernel implementation.
>
> It does complicate kernel implementation. Is it too hard to solve the
> problem in kernel.
>
> W.r.t partitioning, bdev_dax_pgoff() seems to be the pain point where
> dax code refers back to block device to figure out partition offset in
> dax device. If we create a dax object corresponding to "struct block_device"
> and store sector offset in that, then we could pass that object to dax
> code and not worry about referring back to bdev. I have written some
> proof of concept code and called that object "dax_handle". I can post
> that code if there is interest.

I don't think it's worth it in the end especially considering
filesystems are looking to operate on /dev/dax devices directly and
remove block entanglements entirely.

> IMHO, it feels useful to be able to partition and use a dax capable
> block device in same way as non-dax block device. It will be really
> odd to think that if filesystem is on /dev/pmem0p1, then dax can't
> be enabled but if filesystem is on /dev/mapper/pmem0p1, then dax
> will work.

That can already happen today. If you do not properly align the
partition then dax operations will be disabled. This proposal just
extends that existing failure domain to make all partitions fail to
support dax.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
