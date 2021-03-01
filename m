Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F463292E1
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Mar 2021 21:56:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 13B36100ED49C;
	Mon,  1 Mar 2021 12:56:06 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2B678100EF270
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 12:56:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l12so22572297edt.3
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 12:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uf7JqQFHPCXtVt6OE3ndJLn8tz0ITkjzN5ljfjxdIhk=;
        b=LsUxVPo7UlbfyojprFB1jf/rKDEY5l1bLqSBqTvGf9XMx0WBQVwMKTlkmnc8L2SxOQ
         CQVHrea9eSOecxf54/iF/vdL/K8FbOVPW9KBl4US9kraCLKPGcb8Zy87mpx2ALTioUUi
         I3u0SK3g+sKzDaob/ol6gZFxAQylheAV+/IIn35GbikR2zQgDwQWXktUXD9ULoL+PzQx
         pr97W32SC56CXIMupsYveBfr4YnEHV3ekVFIoIK0dIk72+g1vb0gS6NvBqVEpVagMIPu
         0o2DeAiSUb4YzXlIswECNdeyiZKT86n3F+CjMKrQnKtykVj6ngmicpeLHNZKdX23vnF5
         orlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uf7JqQFHPCXtVt6OE3ndJLn8tz0ITkjzN5ljfjxdIhk=;
        b=NYyTLV2TZnSp4Ky9QkFbkkxBWWKj1lsYMjzLyRjACYBtVK9LQHCw8cVsmVRrSSl3Vq
         XyY7W8CEM2pxZtEA8xvGhH0eUaHjVrGNEd4mKWX67lfhkGNmUrvfFSldPpxiwEQ6szDd
         neQ92bxHQz/1LHgtRhp+fiwRozrguO4QPOOAjf6qTNL22y3wkCSfVK8cCtOqd37H2muO
         9oUALRXx1hwb7ebeKAIZDi3f2LroQcX1q2W4pvyleHOfsVo39DEXoKTyrdddnoHxK21H
         FdEYORblr3sQBa/7IgPP8nS6Y6a2P5D143UhX4+cXqE3PDHXT0YRa6lFvACSNWzTm5X4
         kV9g==
X-Gm-Message-State: AOAM5332UxTTOLKamksSAbDUHjGzB1WwvUiXomaJIf4aWgQjNEENJ/dW
	7+xMpQG2mm2V2smWuo497VI6kLhBWd3cNyOuvxqaIA==
X-Google-Smtp-Source: ABdhPJxBwKnueL85Spjb8OhqRdQvSAhEOhjHLo+ym/acf8R+C2DQPXIFH/M6CoSbCOsavo9bD3fi05mLAmEjhXAU4gc=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr17766218edc.97.1614632162323;
 Mon, 01 Mar 2021 12:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area> <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area> <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
 <20210227223611.GZ4662@dread.disaster.area> <CAPcyv4h7XA3Jorcy_J+t9scw0A4KdT2WEwAhE-Nbjc=C2qmkMw@mail.gmail.com>
 <20210228223846.GA4662@dread.disaster.area>
In-Reply-To: <20210228223846.GA4662@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Mar 2021 12:55:53 -0800
Message-ID: <CAPcyv4jzV2RUij2BEvDJLLiK_67Nf1v3M6-jRLKf32x4iOzqng@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: AW3YYMB6TDDSQ7SPFYQMT46BCSVJQ36O
X-Message-ID-Hash: AW3YYMB6TDDSQ7SPFYQMT46BCSVJQ36O
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <djwong@kernel.org>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AW3YYMB6TDDSQ7SPFYQMT46BCSVJQ36O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 28, 2021 at 2:39 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sat, Feb 27, 2021 at 03:40:24PM -0800, Dan Williams wrote:
> > On Sat, Feb 27, 2021 at 2:36 PM Dave Chinner <david@fromorbit.com> wrote:
> > > On Fri, Feb 26, 2021 at 02:41:34PM -0800, Dan Williams wrote:
> > > > On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
> > > > > On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > > it points to, check if it points to the PMEM that is being removed,
> > > grab the page it points to, map that to the relevant struct page,
> > > run collect_procs() on that page, then kill the user processes that
> > > map that page.
> > >
> > > So why can't we walk the ptescheck the physical pages that they
> > > map to and if they map to a pmem page we go poison that
> > > page and that kills any user process that maps it.
> > >
> > > i.e. I can't see how unexpected pmem device unplug is any different
> > > to an MCE delivering a hwpoison event to a DAX mapped page.
> >
> > I guess the tradeoff is walking a long list of inodes vs walking a
> > large array of pages.
>
> Not really. You're assuming all a filesystem has to do is invalidate
> everything if a device goes away, and that's not true. Finding if an
> inode has a mapping that spans a specific device in a multi-device
> filesystem can be a lot more complex than that. Just walking inodes
> is easy - determining whihc inodes need invalidation is the hard
> part.

That inode-to-device level of specificity is not needed for the same
reason that drop_caches does not need to be specific. If the wrong
page is unmapped a re-fault will bring it back, and re-fault will fail
for the pages that are successfully removed.

> That's where ->corrupt_range() comes in - the filesystem is already
> set up to do reverse mapping from physical range to inode(s)
> offsets...

Sure, but what is the need to get to that level of specificity with
the filesystem for something that should rarely happen in the course
of normal operation outside of a mistake?

>
> > There's likely always more pages than inodes, but perhaps it's more
> > efficient to walk the 'struct page' array than sb->s_inodes?
>
> I really don't see you seem to be telling us that invalidation is an
> either/or choice. There's more ways to convert physical block
> address -> inode file offset and mapping index than brute force
> inode cache walks....

Yes, but I was trying to map it to an existing mechanism and the
internals of drop_pagecache_sb() are, in coarse terms, close to what
needs to happen here.

>
> .....
>
> > > IOWs, what needs to happen at this point is very filesystem
> > > specific. Assuming that "device unplug == filesystem dead" is not
> > > correct, nor is specifying a generic action that assumes the
> > > filesystem is dead because a device it is using went away.
> >
> > Ok, I think I set this discussion in the wrong direction implying any
> > mapping of this action to a "filesystem dead" event. It's just a "zap
> > all ptes" event and upper layers recover from there.
>
> Yes, that's exactly what ->corrupt_range() is intended for. It
> allows the filesystem to lock out access to the bad range
> and then recover the data. Or metadata, if that's where the bad
> range lands. If that recovery fails, it can then report a data
> loss/filesystem shutdown event to userspace and kill user procs that
> span the bad range...
>
> FWIW, is this notification going to occur before or after the device
> has been physically unplugged?

Before. This will be operations that happen in the pmem driver
->remove() callback.

> i.e. what do we do about the
> time-of-unplug-to-time-of-invalidation window where userspace can
> still attempt to access the missing pmem though the
> not-yet-invalidated ptes? It may not be likely that people just yank
> pmem nvdimms out of machines, but with NVMe persistent memory
> spaces, there's every chance that someone pulls the wrong device...

The physical removal aspect is only theoretical today. While the pmem
driver has a ->remove() path that's purely a software unbind
operation. That said the vulnerability window today is if a process
acquires a dax mapping, the pmem device hosting that filesystem goes
through an unbind / bind cycle, and then a new filesystem is created /
mounted. That old pte may be able to access data that is outside its
intended protection domain.

Going forward, for buses like CXL, there will be a managed physical
remove operation via PCIE native hotplug. The flow there is that the
PCIE hotplug driver will notify the OS of a pending removal, trigger
->remove() on the pmem driver, and then notify the technician (slot
status LED) that the card is safe to pull.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
