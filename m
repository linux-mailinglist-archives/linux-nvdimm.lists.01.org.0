Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61041132DFB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jan 2020 19:07:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0466410097E0E;
	Tue,  7 Jan 2020 10:10:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7459F10097E0F
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jan 2020 10:10:49 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id k14so865675otn.4
        for <linux-nvdimm@lists.01.org>; Tue, 07 Jan 2020 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9qVcv2ok0qOOmijKDSuHWlK71aI9OJbo1lCq2yFN1g=;
        b=jQH6IumLFu5DdnndMFOX12fwWMj0i8NatfwnP/5oCE1lYwuVmTMX/cnW78ZGwmvQ6C
         Qf0P7QezhZLY6yUTEncsy4CD2+tMq5afmzQir2tuRcj4aYCq6eLC7oaDEl8aEYUIBHsN
         jRw3z+WcIM8BoxFiz2LVFq3zFqYDP6dfz2dVBV0bsl1Jn3z6HVBWAAWrsIMw9Alg7iso
         4qLs9mUkKKQReWortMYNeHaq6H1iki5wIw2Nh1eGzfZxxf0kVY57IcQnV3FcXeFoIGIf
         wyvQRZSkpk7lUva1wSK7WcXpc+5o1xaEGEtRTQSTS8psr/zB3XKTvtR4ukz9uZweRo1S
         A2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9qVcv2ok0qOOmijKDSuHWlK71aI9OJbo1lCq2yFN1g=;
        b=isGKQpRbxVD3Xbw8OeSlvOLIc593uJj3KrIp4h38jkzzQNIr5j0WfkQpO30PPayhLy
         XoCaeyfuHPRx+prbJQpaWpGxb/UoSpcBPMSfAhY2HsLAXMpAEEKGuo7VH7TWSUo10ytH
         OyfSt++iDh0IXaI7jWQ9nc6uo6ydwBCHJiQgxlR9P/1LuSDnVTFD8AEPENTZzYg6ZUU8
         E5KoXzunzAXLoFUL6WipYQJdGKvWoqUzVvS6szPebd5nYwIIzPlakg3LO0j2B4A4lvJV
         ZX9mdxegDfv9Tq8rzpBx+2twsiPGRqHkEMjfWi2qxmlIHdPyufgbm+6qh5J0TqLV15rd
         LxRQ==
X-Gm-Message-State: APjAAAUsbPQlCLppqi/ObUOlVA+WKxtg/DSHu/u5YzrSZ/Olw+LY5U1a
	Jf9dNpM8k7wdBF5r6d8oMn6nubLQFTFvy+I3B9zXNyVl
X-Google-Smtp-Source: APXvYqzLIFHJ9zSugFUS6iwPDoK4NgvqbGeVRNhWCXR5x6X+EAsfnzcznFHENk0/XTBefdPXsNFJL268VI72rv55www=
X-Received: by 2002:a9d:6f11:: with SMTP id n17mr1079009otq.126.1578420449528;
 Tue, 07 Jan 2020 10:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20190827163828.GA6859@redhat.com> <20190828065809.GA27426@infradead.org>
 <20190828175843.GB912@redhat.com> <20190828225322.GA7777@dread.disaster.area>
 <CAPcyv4jGEAbYSJef2zLzgg6Arozsuz7eN_vZL1iTcd1XQuNT4Q@mail.gmail.com>
 <20191216181014.GA30106@redhat.com> <20200107125159.GA15745@infradead.org>
 <CAPcyv4jZE35sbDo6J4ihioEUFTuekJ3_h0=2Ra4PY+xn2xn1cQ@mail.gmail.com>
 <20200107170731.GA472641@magnolia> <CAPcyv4ggH7-QhYg+YOOWn_m25uds+-0L46=N09ap-LALeGuU_A@mail.gmail.com>
 <20200107180101.GC15920@redhat.com>
In-Reply-To: <20200107180101.GC15920@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 Jan 2020 10:07:18 -0800
Message-ID: <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: U44PIW2ZOTZA2HSO2XTHCCBRE2PN6EEA
X-Message-ID-Hash: U44PIW2ZOTZA2HSO2XTHCCBRE2PN6EEA
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <darrick.wong@oracle.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <david@fromorbit.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U44PIW2ZOTZA2HSO2XTHCCBRE2PN6EEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jan 7, 2020 at 10:02 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jan 07, 2020 at 09:29:17AM -0800, Dan Williams wrote:
> > On Tue, Jan 7, 2020 at 9:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > >
> > > On Tue, Jan 07, 2020 at 06:22:54AM -0800, Dan Williams wrote:
> > > > On Tue, Jan 7, 2020 at 4:52 AM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > On Mon, Dec 16, 2019 at 01:10:14PM -0500, Vivek Goyal wrote:
> > > > > > > Agree. In retrospect it was my laziness in the dax-device
> > > > > > > implementation to expect the block-device to be available.
> > > > > > >
> > > > > > > It looks like fs_dax_get_by_bdev() is an intercept point where a
> > > > > > > dax_device could be dynamically created to represent the subset range
> > > > > > > indicated by the block-device partition. That would open up more
> > > > > > > cleanup opportunities.
> > > > > >
> > > > > > Hi Dan,
> > > > > >
> > > > > > After a long time I got time to look at it again. Want to work on this
> > > > > > cleanup so that I can make progress with virtiofs DAX paches.
> > > > > >
> > > > > > I am not sure I understand the requirements fully. I see that right now
> > > > > > dax_device is created per device and all block partitions refer to it. If
> > > > > > we want to create one dax_device per partition, then it looks like this
> > > > > > will be structured more along the lines how block layer handles disk and
> > > > > > partitions. (One gendisk for disk and block_devices for partitions,
> > > > > > including partition 0). That probably means state belong to whole device
> > > > > > will be in common structure say dax_device_common, and per partition state
> > > > > > will be in dax_device and dax_device can carry a pointer to
> > > > > > dax_device_common.
> > > > > >
> > > > > > I am also not sure what does it mean to partition dax devices. How will
> > > > > > partitions be exported to user space.
> > > > >
> > > > > Dan, last time we talked you agreed that partitioned dax devices are
> > > > > rather pointless IIRC.  Should we just deprecate partitions on DAX
> > > > > devices and then remove them after a cycle or two?
> > > >
> > > > That does seem a better plan than trying to force partition support
> > > > where it is not needed.
> > >
> > > Question: if one /did/ have a partitioned DAX device and used kpartx to
> > > create dm-linear devices for each partition, will DAX still work through
> > > that?
> >
> > The device-mapper support will continue, but it will be limited to
> > whole device sub-components. I.e. you could use kpartx to carve up
> > /dev/pmem0 and still have dax, but not partitions of /dev/pmem0.
>
> So we can't use fdisk/parted to partition /dev/pmem0. Given /dev/pmem0
> is a block device, I thought tools will expect it to be partitioned.
> Sometimes I create those partitions and use /dev/pmem0. So what's
> the replacement for this. People often have tools/scripts which might
> want to partition the device and these will start failing.

Partitioning will still work, but dax operation will be declined and
fall back to page-cache.

> IOW, I do not understand that why being able to partition /dev/pmem0
> (which is a block device from user space point of view), is pointless.

How about s/pointless/redundant/. Persistent memory can already be
"partitioned" via namespace boundaries. Block device partitioning is
then redundant and needlessly complicates, as you have found, the
kernel implementation.

The problem will be people that were on dax+ext4 on partitions. Those
people will see a hard failure at mount whereas XFS will fallback to
page cache with a warning in the log. I think ext4 must convert to the
xfs dax handling model before partition support is dropped.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
