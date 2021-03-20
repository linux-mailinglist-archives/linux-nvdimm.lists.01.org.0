Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C1342A0D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 20 Mar 2021 03:39:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 751B3100EAB43;
	Fri, 19 Mar 2021 19:39:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F14E6100EC1D3
	for <linux-nvdimm@lists.01.org>; Fri, 19 Mar 2021 19:39:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u5so12615766ejn.8
        for <linux-nvdimm@lists.01.org>; Fri, 19 Mar 2021 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RcZY/Fegt1p4SfYuCZqJM1CamsLu9oq2uWBHoPkFgz0=;
        b=g6oYFgSYGN8VgtOP1q04Sfinv+7kfPt4fHhkd8vA9tI1jA8cckrjisBdYPN4B1luHG
         7DbeL2EF4rKvdup7FhJUrvrgDIcw9sXX4UMae8piHEaXKE/s+dUzVT57NbuA85yERrSc
         FTG08QQYm42AuDcCU+wu42dJEyJ6EEx7AFZZ42Fl0/zyBZBIa15AYbV8CEZQudLQWGmH
         nRclZdwy5ATr4Gy5QO3kPEfCWLEcSck+TBzOsqF/WcEONH3CQAqCtcpw3nu5gpcQs9et
         ecG+Y41IK6JXNq0uFgfPDJP1Sd0oi3aabTXfM4jjdEXMQy/pme2PWkbTi4aD9k+v5Jqc
         BLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RcZY/Fegt1p4SfYuCZqJM1CamsLu9oq2uWBHoPkFgz0=;
        b=mGcmx5czG0gDmKlRJxu5F5ASvcAG2v/h9GGLq/t5fsMNIRULBbFjymbL8Utttk28Kr
         CW53k5kjFeaV/OLaknjHMrI6QDZrCWnaPCZQ46EakpnJ8UR32OZZOsqE1jVO0dLHmvZs
         2rzOa23aznDPB4xOGIo0/TK+d3zkackTifvF/qZPb5OMf4WKx7np7xg5f9p1BTisKH+r
         JKD7yq8EnJJwaMqq1Ge+2By5uahQ1s/bmctdLKlkAqciCjReRw2yaUEMAefE9cJ7OwN0
         xxs21VvXULWXYTusdf1uR1OcKWKFFMKHpH3WEHpMYAQs+socpj6QwJqtdveD26qCenhz
         l1fQ==
X-Gm-Message-State: AOAM532QsxFA0H0cf3Xj0nVGeI9w/Nbg3+0R2edsE8pmokIP3cWi9wR2
	FqoGZsjKMCzRoJz9MK++2YmQaem+BSrakkEiqaK+7Q==
X-Google-Smtp-Source: ABdhPJxDB+iblMo6BMSqjpcCdR/A3DRZKC/5MjxXI5umAzL7eCFQ/VYjXVFiarSRxzPgmJzisrIK7qryOnWPjBJYqpw=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr7512084ejc.45.1616207953094;
 Fri, 19 Mar 2021 19:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210318045745.GC349301@dread.disaster.area> <CAPcyv4iPE_MB08PFM-DZig8g35YH_VTKydeFyffN+QovfXx7HA@mail.gmail.com>
 <20210320014648.GD349301@dread.disaster.area>
In-Reply-To: <20210320014648.GD349301@dread.disaster.area>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 19 Mar 2021 19:39:01 -0700
Message-ID: <CAPcyv4jQRzNsPE8fkq2d1hkPBtMxhSZ-mX8RnPaNyNR-SXwuig@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm, dax, pmem: Introduce dev_pagemap_failure()
To: Dave Chinner <david@fromorbit.com>
Message-ID-Hash: V6SO5ID54CNATAICWY4I4B7ZNAAXWTZF
X-Message-ID-Hash: V6SO5ID54CNATAICWY4I4B7ZNAAXWTZF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>, "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V6SO5ID54CNATAICWY4I4B7ZNAAXWTZF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 19, 2021 at 6:47 PM Dave Chinner <david@fromorbit.com> wrote:
[..]
> > Now I'm trying to reconcile the fact that platform
> > poison handling will hit memory_failure() first and may not
> > immediately reach the driver, if ever (see the perennially awkward
> > firmware-first-mode error handling: ghes_handle_memory_failure()) . So
> > even if the ->memory_failure(dev...) up call exists there is no
> > guarantee it can get called for all poison before the memory_failure()
> > down call happens. Which means regardless of whether
> > ->memory_failure(dev...) exists memory_failure() needs to be able to
> > do the right thing.
>
> I don't see how a poor implementation of memory_failure in a driver
> or hardware is even remotely relevant to the interface used to
> notify the filesystem of a media or device failure. It sounds like
> you are trying to use memory_failure() for something it was never
> intended to support and that there's a bunch of driver and
> infrastructure work needed to make it work how you want it to work.
> And even then it may not work the way we want it to work....
>
> > Combine that with the fact that new buses like CXL might be configured
> > in "poison on decode error" mode which means that a memory_failure()
> > storm can happen regardless of whether the driver initiates it
> > programatically.
>
> Straw man argument.
>
> "We can't make this interface a ranged notification because the
> hardware might only be able to do page-by-page notification."

No, it's "we can't make this interface notify the filesytem that
sectors have failed before the memory_failure() (ranged or not) has
communicated that pfns have failed."

memory_failure() today is the first and sometimes only interface that
learns of pfn failures.

>
> You can do page-by-page notification with a range based interface.
> We are talking about how to efficiently and reliably inform the
> filesystem that a range of a device is no longer accessible and so
> it needs to revoke all mappings over that range of it's address
> space. That does not need to be a single page at a time interface.
>
> If your hardware is configured to do stupid things, then that is not
> the fault of the software interface used to communicate faults up
> the stack, nor is it something that the notfication interface should
> try to fix or mitigate.....
>
> > How about a mechanism to optionally let a filesystem take over memory
> > failure handling for a range of pfns that the memory_failure() can
> > consult to fail ranges at a time rather than one by one? So a new
> > 'struct dax_operations' op (void) (*memory_failure_register(struct
> > dax_device *, void *data). Where any agent that claims a dax_dev can
> > register to take over memory_failure() handling for any event that
> > happens in that range. This would be routed through device-mapper like
> > any other 'struct dax_operations' op. I think that meets your
> > requirement to get notifications of all the events you want to handle,
> > but still allows memory_failure() to be the last resort for everything
> > that has not opted into this error handling.
>
> Which is basically the same as the proposed ->corrupted_range stack,
> except it doesn't map the pfns back to LBA addresses the filesystem
> needs to make sense of the failure.
>
> fs-dax filesystems have no clue what pfns are, or how to translate
> them to LBAs in their block device address space that the map
> everything to. The fs-dax infrastructure asks the filesystem for
> bdev/sector based mappings, and internally converts them to pfns by
> a combination of bdev and daxdev callouts. Hence fs-dax filesystems
> never see nor interpret pfns at all.  Nor do they have the
> capability to convert a PFN to a LBA address. And neither the
> underlying block device nor the associated DAX device provide a
> method for doing this reverse mapping translation.

True.

>
> So if we have an interface that hands a {daxdev,PFN,len} tuple to
> the filesystem, exactly what is the filesystem supposed to do with
> it? How do we turn that back into a {bdev,sector,len} tuple so we
> can do reverse mapping lookups to find the filesystem objects that
> allocated within the notified range?
>
> I'll point out again that these address space translations were
> something that the ->corrupted_range callbacks handled directly - no
> layer in the stack was handed a range that it didn't know how to map
> to it's own internal structures. By the time it got to the
> filesystem, it was a {bdev,sector,len} tuple, and the filesystem
> could feed that directly to it's reverse mapping lookups....
>
> Maybe I'm missing something magical about ->memory_failure that does
> all this translation for us, but I don't see it in this patchset. I
> just don't see how this proposed interface is a usable at the
> filesystem level as it stands.

So then it's not the filesystem that needs to register for
memory_failure() it's the driver in order to translate the failed LBAs
up the stack. However, memory_failure() still needs to make sure that
the pfns are unmapped regardless of any LBA notification after the
fact. So memory_failure() would still need to gain a range based
failure mode that optionally coordinates with a driver that can try to
head off sub-optimal memory_failure() default behavior.

Something like:

memory_failure_range()
    for_each_range_owner() {
        handled = notify_range_owner()
        if (!handled)
            do_fail_each_pfn()
    }

...then in the pmem driver.

pmem_pfn_range_failure_handler()
    lba_range_failure_notifier()

Then each stacking block device registers for the lba_notifier from
the next block device in the stack.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
