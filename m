Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC064326A20
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 23:41:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ECC35100EC1CD;
	Fri, 26 Feb 2021 14:41:54 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 99179100ED4A0
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 14:41:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id c6so12906218ede.0
        for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fHpk7bX3cDWOBW490ZT0/lz5t0wLMJKj3dSlv6bBAAo=;
        b=1yPeE5A9fp2f1ejfpTgfXOETxBjJbBT1SW14Chud06HLDzIPNmCmEsBOwUKfXdN3gG
         vJaneShjlCuuLtVWoYUcKIDMup8b2L1ipSyCLygvfOdhGe92XWeSyMfTu3qfKefqBXHV
         KMLUvZTGTvbA42+8ifrpPE2dZBXOL0gAQy9jhaV9OnK/sGFHAD8aBWOBYrjNVcWNAESs
         UBhGp1C8ai2SH/diDzk7qVVRiEWSsBjvBKIdzhrmhhVfDd4zoXVI/HXEe2k23sGGfAE2
         duzT9FLKldvV8YstP9kViwPaBBH+jJGT/gEcK/nbRdXMijcNQt9b9YiuJ7Wl/23jK6Cv
         BYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fHpk7bX3cDWOBW490ZT0/lz5t0wLMJKj3dSlv6bBAAo=;
        b=mbqlBqhr29qG5j9Tnylf5uhSCzsWZ9JjkwQwcB2z83NKWfySOoWIdxi97q/h5bVWJR
         JTBNVc0/kPd3/D4uLoQgQxSqnLJ7M8nRBK7+cAicpkhG4+VhbarO3oGFtqWMcCl0JpD1
         rqN7S47A3O6WM47WfaTCini9Iojm6MZGlLfJnFMg2r2pt+0UuA1ObNI9S0NtRucU7wm6
         n5CeSADCuka5/rCCV9r7Wd1NiitOc0rHS61te43QeB/6iAqszok/RB6tKD7ONfL5sx/O
         S1lVTwF5LzaLO0uhSy33joE7en/mI4EByVcKILruYV2jXxWi6394qafgjEXnCTwHLATf
         MMZA==
X-Gm-Message-State: AOAM531ug+POVofwq7URgwxm2ZF9T7C4ePFFkWBhcLBcVYssw3Him88b
	7WD454ckpfaWLw1/98r5Kmw1i1QC8WWLqjnuO7Wvtg==
X-Google-Smtp-Source: ABdhPJzRqB7Th9975KKwZVp3f4l2p1uq8ensA0GvES+o8Z3FVF9VoQw9apOJIKwlD0LzIcC2XhrsXeFRdf3KO98ibv0=
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr5689417edc.97.1614379305912;
 Fri, 26 Feb 2021 14:41:45 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area> <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
 <20210226212748.GY4662@dread.disaster.area>
In-Reply-To: <20210226212748.GY4662@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Feb 2021 14:41:34 -0800
Message-ID: <CAPcyv4jryJ32R5vOwwEdoU3V8C0B7zu_pCt=7f6A3Gk-9h6Dfg@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: H3SR3JK4ZVM67EUR4M3P5V6SH5JRKKQV
X-Message-ID-Hash: H3SR3JK4ZVM67EUR4M3P5V6SH5JRKKQV
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <djwong@kernel.org>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/H3SR3JK4ZVM67EUR4M3P5V6SH5JRKKQV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 1:28 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 26, 2021 at 12:59:53PM -0800, Dan Williams wrote:
> > On Fri, Feb 26, 2021 at 12:51 PM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Fri, Feb 26, 2021 at 11:24:53AM -0800, Dan Williams wrote:
> > > > On Fri, Feb 26, 2021 at 11:05 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >
> > > > > On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> > > > > > Hi, guys
> > > > > >
> > > > > > Beside this patchset, I'd like to confirm something about the
> > > > > > "EXPERIMENTAL" tag for dax in XFS.
> > > > > >
> > > > > > In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> > > > > > when we mount a pmem device with dax option, has been existed for a
> > > > > > while.  It's a bit annoying when using fsdax feature.  So, my initial
> > > > > > intention was to remove this tag.  And I started to find out and solve
> > > > > > the problems which prevent it from being removed.
> > > > > >
> > > > > > As is talked before, there are 3 main problems.  The first one is "dax
> > > > > > semantics", which has been resolved.  The rest two are "RMAP for
> > > > > > fsdax" and "support dax reflink for filesystem", which I have been
> > > > > > working on.
> > > > >
> > > > > <nod>
> > > > >
> > > > > > So, what I want to confirm is: does it means that we can remove the
> > > > > > "EXPERIMENTAL" tag when the rest two problem are solved?
> > > > >
> > > > > Yes.  I'd keep the experimental tag for a cycle or two to make sure that
> > > > > nothing new pops up, but otherwise the two patchsets you've sent close
> > > > > those two big remaining gaps.  Thank you for working on this!
> > > > >
> > > > > > Or maybe there are other important problems need to be fixed before
> > > > > > removing it?  If there are, could you please show me that?
> > > > >
> > > > > That remains to be seen through QA/validation, but I think that's it.
> > > > >
> > > > > Granted, I still have to read through the two patchsets...
> > > >
> > > > I've been meaning to circle back here as well.
> > > >
> > > > My immediate concern is the issue Jason recently highlighted [1] with
> > > > respect to invalidating all dax mappings when / if the device is
> > > > ripped out from underneath the fs. I don't think that will collide
> > > > with Ruan's implementation, but it does need new communication from
> > > > driver to fs about removal events.
> > > >
> > > > [1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
> > >
> > > Oh, yay.
> > >
> > > The XFS shutdown code is centred around preventing new IO from being
> > > issued - we don't actually do anything about DAX mappings because,
> > > well, I don't think anyone on the filesystem side thought they had
> > > to do anything special if pmem went away from under it.
> > >
> > > My understanding -was- that the pmem removal invalidates
> > > all the ptes currently mapped into CPU page tables that point at
> > > the dax device across the system. THe vmas that manage these
> > > mappings are not really something the filesystem really manages,
> > > but a function of the mm subsystem. What the filesystem cares about
> > > is that it gets page faults triggered when a change of state occurs
> > > so that it can remap the page to it's backing store correctly.
> > >
> > > IOWs, all the mm subsystem needs to when pmem goes away is clear the
> > > CPU ptes, because then when then when userspace tries to access the
> > > mapped DAX pages we get a new page fault. In processing the fault, the
> > > filesystem will try to get direct access to the pmem from the block
> > > device. This will get an ENODEV error from the block device because
> > > because the backing store (pmem) has been unplugged and is no longer
> > > there...
> > >
> > > AFAICT, as long as pmem removal invalidates all the active ptes that
> > > point at the pmem being removed, the filesystem doesn't need to
> > > care about device removal at all, DAX or no DAX...
> >
> > How would the pmem removal do that without walking all the active
> > inodes in the fs at the time of shutdown and call
> > unmap_mapping_range(inode->i_mapping, 0, 0, 1)?
>
> Which then immediately ends up back at the vmas that manage the ptes
> to unmap them.
>
> Isn't finding the vma(s) that map a specific memory range exactly
> what the rmap code in the mm subsystem is supposed to address?

rmap can lookup only vmas from a virt address relative to a given
mm_struct. The driver has neither the list of mm_struct objects nor
virt addresses to do a lookup. All it knows is that someone might have
mapped pages through the fsdax interface.

To me this looks like a notifier that fires from memunmap_pages()
after dev_pagemap_kill() to notify any block_device associated with
that dev_pagemap() to say that any dax mappings arranged through this
block_device are now invalid. The reason to do this after
dev_pagemap_kill() is so that any new mapping attempts that are racing
the removal will be blocked.

The receiver of that notification needs to go from a block_device to a
superblock that has mapped inodes and walk ->sb_inodes triggering the
unmap/invalidation.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
