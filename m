Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0049329649
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Mar 2021 06:50:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A532100EB83B;
	Mon,  1 Mar 2021 21:50:34 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0F8A0100EBB94
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 21:50:30 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id w1so32926490ejf.11
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 21:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNZE31gswus170slngXjiwYWAkhOfZUEI/tWqeY6+Ew=;
        b=Q/OzweNBKTN/p31Gfi5+pQqOQLOS8ZN89cCgWPq5hATdbuSvGCLn+xZgiTqHaV8ovA
         WPKN7gxWkd/+30M9nOOTji8DLoErcoaIiwcYKBsZU/JkB5jhdpz4wr0X2R9eV7Om8Q0N
         RILeOr2BWoJJHRoqZ4VrOk84X5EAfMP2kLyBknuDlFE1TifyhnA4CM+YMvmSNBdnnmEE
         gh0wmMjxGG9kl+Zi/KvsWuhE9ss4/c2eFFp6TBVG9D6DSlyPgmcR3v+BtzohWvyCOGjR
         5pmqvqEAeig8HYJ40mUttD9ivnt7wJthGN3a7/JqWUToJ2QNAehPFT6Lplucu2vvBVXy
         2Bsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNZE31gswus170slngXjiwYWAkhOfZUEI/tWqeY6+Ew=;
        b=MNSsQVjgLAj+QslXhUFU5sP9t40MnfDf5Xb2CiURrYh6DgPJ/QWSV5ie+L6yycw6uK
         EpFiD294QKxCmeFO1huLGv7dFlK1ekJQE7CFdwRMs3YzFO4Rcklo5KDwpH0HRqbgDPDr
         7Fc/L9q3GvWwwjiGOKgm+L6iSXAFFRH3SA9Ipuez9FddC4642QRGnTdStLfqO5FGsWXq
         haAkEvfXVNzDGOU05isDQW5n4vJhT5NacEe4ZgVFeEFzsvdPFHmJ7irrvNfgdj48J2mR
         cW/MdaqYeQoVEFWCPC6bUe/oAIpKLfARfPB8NWaFgQVYuleiSL8sXq/9tnRIt/dG0Dsg
         dWyw==
X-Gm-Message-State: AOAM531XoZbE1tgwhlu+Wuwll5JIdRp+T3SWGfoWD71rBjOCKas78LqH
	GGojtEL+7ygxxAlhA8blnpMWdPza/J7HtFo52uhTYw==
X-Google-Smtp-Source: ABdhPJxLO+hVTmt5Q/tH6FezKM4fb+QRR9ZU9IG9BkPzIKgW3o8mPLtbsk6FDkn6ClsqBLu20m+e0BUjDu7jfCSGcRk=
X-Received: by 2002:a17:906:6088:: with SMTP id t8mr19715072ejj.323.1614664229502;
 Mon, 01 Mar 2021 21:50:29 -0800 (PST)
MIME-Version: 1.0
References: <20210226212748.GY4662@dread.disaster.area> <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area> <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area> <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
 <20210301224640.GG4662@dread.disaster.area> <CAPcyv4iTqDJApZY0o_Q0GKn93==d2Gta2NM5x=upf=3JtTia7Q@mail.gmail.com>
 <20210302024227.GH4662@dread.disaster.area> <CAPcyv4ja8gnTR1E-Ge5etm+y69cHwdWN6Bg79wPPF4M=C-w79A@mail.gmail.com>
 <20210302053828.GI4662@dread.disaster.area>
In-Reply-To: <20210302053828.GI4662@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Mar 2021 21:50:21 -0800
Message-ID: <CAPcyv4g03VU8Z8MarMOrW6oJpO-4QFe9-P=CFu3C0z6St3vLuQ@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: PL5N4QTD5JFG7734HWFAM4GXXCFVAZM3
X-Message-ID-Hash: PL5N4QTD5JFG7734HWFAM4GXXCFVAZM3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <djwong@kernel.org>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PL5N4QTD5JFG7734HWFAM4GXXCFVAZM3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Mar 1, 2021 at 9:38 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Mar 01, 2021 at 07:33:28PM -0800, Dan Williams wrote:
> > On Mon, Mar 1, 2021 at 6:42 PM Dave Chinner <david@fromorbit.com> wrote:
> > [..]
> > > We do not need a DAX specific mechanism to tell us "DAX device
> > > gone", we need a generic block device interface that tells us "range
> > > of block device is gone".
> >
> > This is the crux of the disagreement. The block_device is going away
> > *and* the dax_device is going away.
>
> No, that is not the disagreement I have with what you are saying.
> You still haven't understand that it's even more basic and generic
> than devices going away. At the simplest form, all the filesystem
> wants is to be notified of is when *unrecoverable media errors*
> occur in the persistent storage that underlies the filesystem.
>
> The filesystem does not care what that media is build from - PMEM,
> flash, corroded spinning disks, MRAM, or any other persistent media
> you can think off. It just doesn't matter.
>
> What we care about is that the contents of a *specific LBA range* no
> longer contain *valid data*. IOWs, the data in that range of the
> block device has been lost, cannot be retreived and/or cannot be
> written to any more.
>
> PMEM taking a MCE because ECC tripped is a media error because data
> is lost and inaccessible until recovery actions are taken.
>
> MD RAID failing a scrub is a media error and data is lost and
> unrecoverable at that layer.
>
> A device disappearing is a media error because the storage media is
> now permanently inaccessible to the higher layers.
>
> This "media error" categorisation is a fundamental property of
> persistent storage and, as such, is a property of the block devices
> used to access said persistent storage.
>
> That's the disagreement here - that you and Christoph are saying
> ->corrupted_range is not a block device property because only a
> pmem/DAX device currently generates it.
>
> You both seem to be NACKing a generic interface because it's only
> implemented for the first subsystem that needs it. AFAICT, you
> either don't understand or are completely ignoring the architectural
> need for it to be provided across the rest of the storage stack that
> *block device based filesystems depend on*.

No I'm NAKing it because it's the wrong interface. See my 'struct
badblocks' argument in the reply to Darrick. That 'struct badblocks'
infrastructure arose from MD and is shared with PMEM.

>
> Sure, there might be dax device based fielsystems around the corner.
> They just require a different pmem device ->corrupted_range callout
> to implement the notification - one that directs to the dax device
> rather than the block device. That's simple and trivial to
> implement, but such functionaity for DAX devices  does not replace
> the need for the same generic functionality to be provided across a
> *range of different block devices* as required by *block device
> based filesystems*.
>
> And that's fundamentally the problem. XFS is block device based, not
> DAX device based. We require errors to be reported through block
> device mechanisms. fs-dax does not change this - it is based on pmem
> being presented as a primarily as a block device to the block device
> based filesystems and only secondarily as a dax device. Hence if it
> can be trivially implemented as a block device interface, that's
> where it should go, because then all the other block devices that
> the filesytem runs on can provide the same functionality for similar
> media error events....

Sure, use 'struct badblocks' not struct block_device and
block_device_operations.
>
> > The dax_device removal implies one
> > set of actions (direct accessed pfns invalid) the block device removal
> > implies another (block layer sector access offline).
>
> There you go again, saying DAX requires an action, while the block
> device notification is a -state change- (i.e. goes offline).

There you go reacting to the least generous interpretation of what I said.

s/pfns invalid/pfns offline/

>
> This is exactly what I said was wrong in my last email.
>
> > corrupted_range
> > is blurring the notification for 2 different failure domains. Look at
> > the nascent idea to mount a filesystem on dax sans a block device.
> > Look at the existing plumbing for DM to map dax_operations through a
> > device stack.
>
> Ummm, it just maps the direct_access call to the underlying device
> and calls it's ->direct_access method. All it's doing is LBA
> mapping. That's all it needs to do for ->corrupted_range, too.
> I have no clue why you think this is a problem for error
> notification...
>
> > Look at the pushback Ruan got for adding a new
> > block_device operation for corrupted_range().
>
> one person said "no". That's hardly pushback. Especially as I think
> Christoph's objection about this being dax specific functionality
> is simply wrong, as per above.

It's not wrong when we have a perfectly suitable object for sector
based error notification and when we're trying to disentangle 'struct
block_device' from 'struct dax_device'.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
