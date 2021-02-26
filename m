Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE16326905
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 22:00:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E6E4100ED497;
	Fri, 26 Feb 2021 13:00:09 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BDAE7100EF27B
	for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 13:00:06 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mm21so16715742ejb.12
        for <linux-nvdimm@lists.01.org>; Fri, 26 Feb 2021 13:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcQVf2L16DF1R7/sAErfdlf5yiNv7ZgQmWWZvBx0O7Y=;
        b=i9J2NEsaXdVW+xwyoC4uKryJBgK9gHlQ7rn0quR2L+4Oc/C8oI27RfDLQZQo0NCs/g
         hnrG1r6gm7njrx0fVEjP15LRadpIIXN/fOV5yKa01mFTbo1gcBDGjhwbZ7ZOLVe9f3cs
         rSg899zbhjmj9QpjjBl4C7469jymgZ1pywhm0Yi9YbtPNPwZ2dPcm+SZW7JxR+if3mxW
         2ovsyRLMabpzn+UfK4PuDGgo/cUZoppPCV+qLm/F+ETuObciepwGF7IQ1xtRVWFJLB+b
         KZEQJrNlzzrVi641tIumtAdQnvy83AqgijwIGL3hqkDEuk1oRuBS/V/pxBDajS2Srnrr
         4QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcQVf2L16DF1R7/sAErfdlf5yiNv7ZgQmWWZvBx0O7Y=;
        b=qxTX0dzVyy4kmkQ7qYfyKF1/pjPf9UECWyxMPGYrUGt3mhq7KJR7ONmW2/EIOLVQPL
         IU0d62mDfysNt+APoTicAkrFhk80jIIEqobUOmuVk0CBugpIGFm6oWjoaSGJ5hsmokpm
         DxdM5uA9wClfC66B6d0Et27p6Nx5rzfestFrxOR++tTkMbVz7MDhcXNzqNQotAwnUyFq
         WJUgp/uMqbeqy9suGzKv1JtlcRq7kdmudV5cLnjXpFAZYk5gQeqVaH/hMXTFrfRj3tbV
         QGAfbqsHnpbXLIepToZmyHmV0c6KtRL10nE9bV652chf5Q2H2IydFHHIymlw0nxX6r+z
         QVMA==
X-Gm-Message-State: AOAM533FwoYmkqbQkClTvh3u68RInPE9M4GFkZYA8+/YX8guUQ5gV5Xg
	FcL+T/gZOPUCuTzX7HpOT3MHG+6/E53nZi8I4yLuEQ==
X-Google-Smtp-Source: ABdhPJxDAdEBlk0RbwYt70jYfdky1u7QL1zNZXib8jYKCmqQiS//AXLx/UeM+e6rrhKUOcntNXe+fmaTNeYAK6yOe7A=
X-Received: by 2002:a17:906:6088:: with SMTP id t8mr5436602ejj.323.1614373204093;
 Fri, 26 Feb 2021 13:00:04 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <20210226205126.GX4662@dread.disaster.area>
In-Reply-To: <20210226205126.GX4662@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 26 Feb 2021 12:59:53 -0800
Message-ID: <CAPcyv4iDefA3Y0wUW=p080SYAsM_2TPJba-V-sxdK_BeJMkmsw@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: TGCID4RSOFEBE424K5BQ7IPXXL3YAWC6
X-Message-ID-Hash: TGCID4RSOFEBE424K5BQ7IPXXL3YAWC6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <djwong@kernel.org>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TGCID4RSOFEBE424K5BQ7IPXXL3YAWC6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 12:51 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Fri, Feb 26, 2021 at 11:24:53AM -0800, Dan Williams wrote:
> > On Fri, Feb 26, 2021 at 11:05 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> > > > Hi, guys
> > > >
> > > > Beside this patchset, I'd like to confirm something about the
> > > > "EXPERIMENTAL" tag for dax in XFS.
> > > >
> > > > In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> > > > when we mount a pmem device with dax option, has been existed for a
> > > > while.  It's a bit annoying when using fsdax feature.  So, my initial
> > > > intention was to remove this tag.  And I started to find out and solve
> > > > the problems which prevent it from being removed.
> > > >
> > > > As is talked before, there are 3 main problems.  The first one is "dax
> > > > semantics", which has been resolved.  The rest two are "RMAP for
> > > > fsdax" and "support dax reflink for filesystem", which I have been
> > > > working on.
> > >
> > > <nod>
> > >
> > > > So, what I want to confirm is: does it means that we can remove the
> > > > "EXPERIMENTAL" tag when the rest two problem are solved?
> > >
> > > Yes.  I'd keep the experimental tag for a cycle or two to make sure that
> > > nothing new pops up, but otherwise the two patchsets you've sent close
> > > those two big remaining gaps.  Thank you for working on this!
> > >
> > > > Or maybe there are other important problems need to be fixed before
> > > > removing it?  If there are, could you please show me that?
> > >
> > > That remains to be seen through QA/validation, but I think that's it.
> > >
> > > Granted, I still have to read through the two patchsets...
> >
> > I've been meaning to circle back here as well.
> >
> > My immediate concern is the issue Jason recently highlighted [1] with
> > respect to invalidating all dax mappings when / if the device is
> > ripped out from underneath the fs. I don't think that will collide
> > with Ruan's implementation, but it does need new communication from
> > driver to fs about removal events.
> >
> > [1]: http://lore.kernel.org/r/CAPcyv4i+PZhYZiePf2PaH0dT5jDfkmkDX-3usQy1fAhf6LPyfw@mail.gmail.com
>
> Oh, yay.
>
> The XFS shutdown code is centred around preventing new IO from being
> issued - we don't actually do anything about DAX mappings because,
> well, I don't think anyone on the filesystem side thought they had
> to do anything special if pmem went away from under it.
>
> My understanding -was- that the pmem removal invalidates
> all the ptes currently mapped into CPU page tables that point at
> the dax device across the system. THe vmas that manage these
> mappings are not really something the filesystem really manages,
> but a function of the mm subsystem. What the filesystem cares about
> is that it gets page faults triggered when a change of state occurs
> so that it can remap the page to it's backing store correctly.
>
> IOWs, all the mm subsystem needs to when pmem goes away is clear the
> CPU ptes, because then when then when userspace tries to access the
> mapped DAX pages we get a new page fault. In processing the fault, the
> filesystem will try to get direct access to the pmem from the block
> device. This will get an ENODEV error from the block device because
> because the backing store (pmem) has been unplugged and is no longer
> there...
>
> AFAICT, as long as pmem removal invalidates all the active ptes that
> point at the pmem being removed, the filesystem doesn't need to
> care about device removal at all, DAX or no DAX...

How would the pmem removal do that without walking all the active
inodes in the fs at the time of shutdown and call
unmap_mapping_range(inode->i_mapping, 0, 0, 1)?

The core-mm does tear down the ptes in the direct map, but user
mappings to pmem are not afaics in xfs_do_force_shutdown().
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
