Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15493347FEB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 24 Mar 2021 19:00:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 32BC7100EB350;
	Wed, 24 Mar 2021 11:00:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EEE27100EB34F
	for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 11:00:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u5so34380840ejn.8
        for <linux-nvdimm@lists.01.org>; Wed, 24 Mar 2021 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KFNkl1or0mmtXA1jvsRAF0OANfT9njIYX+exK4jOos=;
        b=vFzEiq5fNjCN/7R0WwqtTXBrQesBMnmm7Yt0aIk36IUzb9nz2Iwwjuku88ov5xGoo7
         I2nZHiAzvvorrWHog5G+fz0o6Iwgp6fPe5BX5ALrKM8J8rriLQBF2bQ6iQmCTySTWQeW
         U//yvsIy1PSHAhs/SX8wnQHVLy4lhbL9aV+PelAq1xjXUrvVSvyfV6E/eLWQI3REFqaQ
         He1p0+EQfwXwRd5c1XOplbo7llR+YgnDVh0Qw+Ot0l9QZsjaixzo1kAkhZJUMzGxY+ki
         n7X09BFlfP5Sp9r65op8Vg3Ww+4V6SnFtzm8Ym0iKZ0MacVqsqNvp80/mc20puyxivuG
         ceGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KFNkl1or0mmtXA1jvsRAF0OANfT9njIYX+exK4jOos=;
        b=jXV9IQ2emNAVtVJBgw8gZ/4Ofn9+opNUWZ0Sz5DP9K5su+aZHS1O9BjhiunUKwATL0
         oeSfFcI8FkENSzGVIf26S+3W0/132mtMmfgv3nIOjd8PqqYxwi307yqK6L3BIJ3hzwAR
         VNXRv61igtfwHn+XxPumOvg1ABU4PNaD1SAYPEgTgmrG5MWpUR++DwCMedc/fpXZQUds
         Lyh7/gf9naMDMIboOGM4LhUNuhdBfxv9OXowJngBmINn6mPCA9l/LYy56csvgl8NhwqV
         MMR9Y5QA+/Izgp5yBOjnXU8W2k8VwttCc/pPxVsIZ2VnFDEvaEABdR+ZtLC2FuM5q+34
         0qmA==
X-Gm-Message-State: AOAM533JL+9BiZ35H+m1eHFAsXtR4dQ0UWOEERxUgI9Z/T0WYg6TB3pn
	RGLFwB5jM2lVcAwPc0HbShJC+sXozNfKh12gLh6Xsw==
X-Google-Smtp-Source: ABdhPJy9J40IqLa/d+cck6PXVVGYBFPLo6iqEOA+v2R4s6asbN5wOCf5ZJ6fNNbFdsT8bCsuZH/tAzIMp5hm7zOGEdw=
X-Received: by 2002:a17:906:8447:: with SMTP id e7mr5154772ejy.523.1616608827202;
 Wed, 24 Mar 2021 11:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
 <OSBPR01MB29203F891F9584CC53616FB8F4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4gn_AvT6BA7g4jLKRFODSpt7_ORowVd3KgyWxyaFG0k9g@mail.gmail.com>
 <OSBPR01MB2920E46CBE4816CDF711E004F46F9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29208779955B49F84D857F80F4689@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <CAPcyv4jhUU3NVD8HLZnJzir+SugB6LnnrgJZ-jP45BZrbJ1dJQ@mail.gmail.com>
 <20210324074751.GA1630@lst.de> <CAPcyv4hOrYCW=wjkxkCP+JbyD+A_Po0rW-61qQWAOm3zp_eyUQ@mail.gmail.com>
 <20210324173935.GB12770@lst.de>
In-Reply-To: <20210324173935.GB12770@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 24 Mar 2021 11:00:16 -0700
Message-ID: <CAPcyv4iyS0EB0zLNxLwML1C0E2Eqk3TweHvmgpNWpZKVPVpz5Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: QXV63JL3NNPKYMZU3G44JJUXVNAUENQQ
X-Message-ID-Hash: QXV63JL3NNPKYMZU3G44JJUXVNAUENQQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>, "y-goto@fujitsu.com" <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QXV63JL3NNPKYMZU3G44JJUXVNAUENQQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Mar 24, 2021 at 10:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Mar 24, 2021 at 09:37:01AM -0700, Dan Williams wrote:
> > > Eww.  As I said I think the right way is that the file system (or
> > > other consumer) can register a set of callbacks for opening the device.
> >
> > How does that solve the problem of the driver being notified of all
> > pfn failure events?
>
> Ok, I probably just showed I need to spend more time looking at
> your proposal vs the actual code..
>
> Don't we have a proper way how one of the nvdimm layers own a
> spefific memory range and call directly into that instead of through
> a notifier?

So that could be a new dev_pagemap operation as Ruan has here. I was
thinking that other agents would be interested in non-dev_pagemap
managed ranges, but we could leave that for later and just make the
current pgmap->memory_failure() callback proposal range based.

>
> > Today pmem only finds out about the ones that are
> > notified via native x86 machine check error handling via a notifier
> > (yes "firmware-first" error handling fails to do the right thing for
> > the pmem driver),
>
> Did any kind of firmware-first error handling ever get anything
> right?  I wish people would have learned that by now.

Part of me wants to say if you use firmware-first you get to keep the
pieces, but it's not always the end user choice as far as I
understand.

> > or the ones that are eventually reported via address
> > range scrub, but only for the nvdimms that implement range scrubbing.
> > memory_failure() seems a reasonable catch all point to route pfn
> > failure events, in an arch independent way, to interested drivers.
>
> Yeah.
>
> > I'm fine swapping out dax_device blocking_notiier chains for your
> > proposal, but that does not address all the proposed reworks in my
> > list which are:
> >
> > - delete "drivers/acpi/nfit/mce.c"
> >
> > - teach memory_failure() to be able to communicate range failure
> >
> > - enable memory_failure() to defer to a filesystem that can say
> > "critical metadata is impacted, no point in trying to do file-by-file
> > isolation, bring the whole fs down".
>
> This all sounds sensible.

Ok, Ruan, I think this means rework your dev_pagemap_ops callback to
be range based. Add a holder concept for dax_devices and then layer
that on Christoph's eventual dax_device callback mechanism that a
dax_device holder can register.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
