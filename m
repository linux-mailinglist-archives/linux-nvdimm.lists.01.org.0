Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B43293AA
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Mar 2021 22:35:07 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 485C6100ED4AE;
	Mon,  1 Mar 2021 13:35:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 40E03100ED49C
	for <linux-nvdimm@lists.01.org>; Mon,  1 Mar 2021 13:35:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f6so6941027edd.12
        for <linux-nvdimm@lists.01.org>; Mon, 01 Mar 2021 13:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5eQqZgOuAzrBI1ZGPeaiXwFuA8MI7ck2ex1o4+Zhi4=;
        b=GsgUGnSh6XCM33kX1YqttSd0KUcHsr80+hSKtWCibszAfGFuVyoxIXC+cudRfZnEyL
         jFH0+RPqUvsQwAvjT5XJwBt5pQuHcaGCA/Feko97ZuD1PMjrJ8hMLEHi1SchA998kROw
         UxPATs7C/17JV7vMmPWCU0/Cq8DeK9RmormTicDEINXX6EXW8+Qep3kfC331ztEFSzZ8
         bw9+S7FYGY4+AkXPXKG2NEE4JfhXF3kMVFhfWhSrSe352obZ3SIJ8AsGdgXReUr/NbEz
         WxFs1esX13EoIG/CvJs1unIoGIX7b4I9BK7Xd42Qj0vnCaDuJwD4PX0OJKgCRqq4oI6R
         hnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5eQqZgOuAzrBI1ZGPeaiXwFuA8MI7ck2ex1o4+Zhi4=;
        b=lrDAugGpY0s+QU1t77mfUaWe61OJ3NF+fZ/HPA2n5gEuylIYXNmCv/+Nj2x5+jqMhX
         idS53HkgD1uOmmyKubcohGmshJuOHSyT0ptSk/Mde1PkN9psecwsoslmYSWuIEtsRAWe
         J8RSGnANrqX9Pg8Llr9VkiPb8o5dkOGBfUPGx49Sv2l1JJyAmMP5UDqE62QklHbLmCxu
         Ep/2bJDxLpffHUOjfs7C8PNggG9nuqx7peqDqqTxgjUaU2wB/sT1FrIZ4VMAwA5sPCsh
         kLYnQb6Uq0qKClFHqmcH7K8D7WTb3LrQgxxfF/uLAb9KVo5qQe7oDvl1tC1R9d5YQSzl
         2WXw==
X-Gm-Message-State: AOAM531o2fqgHYP/ZlSskCvA3ISYaZCvxBe4qINgvzPIy19D/2EadYXt
	yhZaBOOfWvsZ3oHXdIAT78THHIxhlEEQ+VvEWWdaDw==
X-Google-Smtp-Source: ABdhPJwE9duJauuJj63Z2mtoHxQXFJwkwdtiBTnboqNDobSDSZ5Ru3/ng679otfZJBNziIAzFv6Zba+Xj6ySXe7YUC0=
X-Received: by 2002:a05:6402:10ce:: with SMTP id p14mr18013748edu.348.1614634501187;
 Mon, 01 Mar 2021 13:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920899F1D71E7B054A04E39F49D9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210226190454.GD7272@magnolia> <CAPcyv4iJiYsM5FQdpMvCi24aCi7RqUnnxC6sM0umFqiN+Q59cg@mail.gmail.com>
 <556921a1-456c-c24d-6d47-e8b15c1d9972@fujitsu.com>
In-Reply-To: <556921a1-456c-c24d-6d47-e8b15c1d9972@fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 1 Mar 2021 13:34:52 -0800
Message-ID: <CAPcyv4g3ZwbdLFx8bqMcNvXyrob8y6sBXXu=xPTmTY0VSk5HCw@mail.gmail.com>
Subject: Re: Question about the "EXPERIMENTAL" tag for dax in XFS
To: Yasunori Goto <y-goto@fujitsu.com>
Message-ID-Hash: CA46UZCNTF2EYO7MM6XWGENQGLEKXGZ3
X-Message-ID-Hash: CA46UZCNTF2EYO7MM6XWGENQGLEKXGZ3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Darrick J. Wong" <djwong@kernel.org>, "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "darrick.wong@oracle.com" <darrick.wong@oracle.com>, "willy@infradead.org" <willy@infradead.org>, "jack@suse.cz" <jack@suse.cz>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>, "david@fromorbit.com" <david@fromorbit.com>, "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "fnstml-iaas@cn.fujitsu.com" <fnstml-iaas@cn.fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CA46UZCNTF2EYO7MM6XWGENQGLEKXGZ3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 28, 2021 at 11:27 PM Yasunori Goto <y-goto@fujitsu.com> wrote:
>
> Hello, Dan-san,
>
> On 2021/02/27 4:24, Dan Williams wrote:
> > On Fri, Feb 26, 2021 at 11:05 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>
> >> On Fri, Feb 26, 2021 at 09:45:45AM +0000, ruansy.fnst@fujitsu.com wrote:
> >>> Hi, guys
> >>>
> >>> Beside this patchset, I'd like to confirm something about the
> >>> "EXPERIMENTAL" tag for dax in XFS.
> >>>
> >>> In XFS, the "EXPERIMENTAL" tag, which is reported in waring message
> >>> when we mount a pmem device with dax option, has been existed for a
> >>> while.  It's a bit annoying when using fsdax feature.  So, my initial
> >>> intention was to remove this tag.  And I started to find out and solve
> >>> the problems which prevent it from being removed.
> >>>
> >>> As is talked before, there are 3 main problems.  The first one is "dax
> >>> semantics", which has been resolved.  The rest two are "RMAP for
> >>> fsdax" and "support dax reflink for filesystem", which I have been
> >>> working on.
> >>
> >> <nod>
> >>
> >>> So, what I want to confirm is: does it means that we can remove the
> >>> "EXPERIMENTAL" tag when the rest two problem are solved?
> >>
> >> Yes.  I'd keep the experimental tag for a cycle or two to make sure that
> >> nothing new pops up, but otherwise the two patchsets you've sent close
> >> those two big remaining gaps.  Thank you for working on this!
> >>
> >>> Or maybe there are other important problems need to be fixed before
> >>> removing it?  If there are, could you please show me that?
> >>
> >> That remains to be seen through QA/validation, but I think that's it.
> >>
> >> Granted, I still have to read through the two patchsets...
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
> >
>
> I'm not sure why there is a race condition between unbinding operation
> and accessing mmaped file on filesystem dax yet.
>
> May be silly question, but could you tell me why the "unbinding"
> operation of the namespace which is mounted by filesystem dax must be
> allowed?

The unbind operation is used to switch the mode of a namespace between
fsdax and devdax. There is no way to fail unbind. At most it can be
delayed for a short while to perform cleanup, but it can't be blocked
indefinitely. There is the option to specify 'suppress_bind_attrs' to
the driver to preclude software triggered device removal, but that
would disable mode changes for the device.

> If "unbinding" is rejected when the filesystem is mounted with dax
> enabled, what is inconvenience?

It would be interesting (read difficult) to introduce the concept of
dynamic 'suppress_bind_attrs'. Today the decision is static at driver
registration time, not in response to how the device is being used.

I think global invalidation of all inodes that might be affected by a
dax-capable device being ripped away from the filesystem is sufficient
and avoids per-fs enabling, but I'm willing to be convinced that
->corrupted_range() is the proper vehicle for this.

>
> I can imagine if a device like usb memory stick is removed surprisingly,
> kernel/filesystem need to reject writeback at the time, and discard page
> cache. Then, I can understand that unbinding operation is essential for
> such case.

For usb the system is protected by the fact that all future block-i/o
submissions to the old block-device will fail, and a new usb-device
being plugged in will get a new block-device. I.e. the old security
model is invalidated / all holes are closed by blk_cleanup_queue().

> But I don't know why PMEM device/namespace allows unbinding operation
> like surprising removal event.

DAX hands direct mappings to physical pages, if the security model
fronting those physical pages changes the mappings attained via the
old security model need to be invalidated. blk_cleanup_queue() does
not invalidate DAX mappings.

The practical value of fixing that hole is small given that physical
unplug is not implemented for NVDIMMs today, but the get_user_pages()
path can be optimized if this invalidation is implemented, and future
hotplug-capable NVDIMM buses like CXL will need this.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
