Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EA14F535
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 00:32:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C125710FC317B;
	Fri, 31 Jan 2020 15:35:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8275E10FC317A
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jan 2020 15:35:28 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id c16so9012226oic.3
        for <linux-nvdimm@lists.01.org>; Fri, 31 Jan 2020 15:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbvzdoNUIaDNq+3zk83a56z2N8LGBGLQ9n7er2/J/Fc=;
        b=NobVDx/gd01Sll6Fd/Vcv5vLnnh9IpBkdCmAUSz+yxvtMkHRMHoT9UMW822cJqyfga
         IHhGXKPGIRoOs25ZUB4eR/Osb3Lj7veVqz4eBrV6NTfFdwPGdbDFL1Gx0LuUcJEplq1G
         ryuCo3IVpjtG3VW4thw9RUwAHcdBaJ0EZEF9/9WLWkBtA8iBqS/s4WSuXpgPSO+i1HA7
         4rRNghurksWFslBIYgRFflg4fnpqhmuadmeFDordOb0IH3RrElAQJ8a1ppu6cqkxI7VF
         P0OKh4QM1DB9ljpJiXpSuOJcVCBbFV+urrSvpDAF2s7NoogkKKDdf5k4/w1YUOc7O0NI
         RTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbvzdoNUIaDNq+3zk83a56z2N8LGBGLQ9n7er2/J/Fc=;
        b=mUxPn3xO9sEPQVtbfUrs+7Tuzhe5B6f4fTli2xQrlP8cC3BzstIc7dLxPzYvUdAioe
         CRJ7V9cEuIwMu4PgS1hMNStObwYMbnAPtvey6PBDIjZ2i3jMKLLQDaEtf0TLjWyfhRyz
         Z4ouDcI/f+n5D3lsthuywLqylvnRjxXL/eZrBZ00zGTKQK2ZxHFr5zyfqPm7ZwBWOfPA
         X27WTtRrMGg8Va9MuRz4U3BKo22r2bTD0ff3IUhGtU640Nl2/woTldlhFUDjvkEw0a0W
         +cJYr3J91wDNmoUVLh0nCqlR0drAPr94Wgxau9fs2p5u3AksXsXJE23LQ6ZtS7OtqZ74
         vOYQ==
X-Gm-Message-State: APjAAAVTu37/FaSGvXKr78lr9w7Brs/O4A8fr0sRlvgooVuIjXJDZWeN
	pKIFb8QsY0Sytwg8B5Jv/5DC5YDYYM9vhQhxJG31EA==
X-Google-Smtp-Source: APXvYqzy4XwNMjBVemev+5VjKUaUiGQr17Dr+lTA27hy9UvwPh/URJrCK0yRVnuVEljIQo3bIk2HK2DGzmqVBHngv+4=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr8258617oij.0.1580513529312;
 Fri, 31 Jan 2020 15:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20200123165249.GA7664@redhat.com> <20200123190103.GB8236@magnolia>
In-Reply-To: <20200123190103.GB8236@magnolia>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 Jan 2020 15:31:58 -0800
Message-ID: <CAPcyv4jT3py4gtdJo84i8gPnJo5MO4uGaaO=+fuuAjXQ0gQsHA@mail.gmail.com>
Subject: Re: [RFC] dax,pmem: Provide a dax operation to zero range of memory
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Message-ID-Hash: FCU56AV6RZWB2NLRTRZXHQFJXR2Q6DM7
X-Message-ID-Hash: FCU56AV6RZWB2NLRTRZXHQFJXR2Q6DM7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Christoph Hellwig <hch@infradead.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FCU56AV6RZWB2NLRTRZXHQFJXR2Q6DM7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jan 23, 2020 at 11:07 AM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
>
> On Thu, Jan 23, 2020 at 11:52:49AM -0500, Vivek Goyal wrote:
> > Hi,
> >
> > This is an RFC patch to provide a dax operation to zero a range of memory.
> > It will also clear poison in the process. This is primarily compile tested
> > patch. I don't have real hardware to test the poison logic. I am posting
> > this to figure out if this is the right direction or not.
> >
> > Motivation from this patch comes from Christoph's feedback that he will
> > rather prefer a dax way to zero a range instead of relying on having to
> > call blkdev_issue_zeroout() in __dax_zero_page_range().
> >
> > https://lkml.org/lkml/2019/8/26/361
> >
> > My motivation for this change is virtiofs DAX support. There we use DAX
> > but we don't have a block device. So any dax code which has the assumption
> > that there is always a block device associated is a problem. So this
> > is more of a cleanup of one of the places where dax has this dependency
> > on block device and if we add a dax operation for zeroing a range, it
> > can help with not having to call blkdev_issue_zeroout() in dax path.
> >
> > I have yet to take care of stacked block drivers (dm/md).
> >
> > Current poison clearing logic is primarily written with assumption that
> > I/O is sector aligned. With this new method, this assumption is broken
> > and one can pass any range of memory to zero. I have fixed few places
> > in existing logic to be able to handle an arbitrary start/end. I am
> > not sure are there other dependencies which might need fixing or
> > prohibit us from providing this method.
> >
> > Any feedback or comment is welcome.
>
> So who gest to use this? :)
>
> Should we (XFS) make fallocate(ZERO_RANGE) detect when it's operating on
> a written extent in a DAX file and call this instead of what it does now
> (punch range and reallocate unwritten)?

If it eliminates more block assumptions, then yes. In general I think
there are opportunities to use "native" direct_access instead of
block-i/o for other areas too, like metadata i/o.

> Is this the kind of thing XFS should just do on its own when DAX us that
> some range of pmem has gone bad and now we need to (a) race with the
> userland programs to write /something/ to the range to prevent a machine
> check (b) whack all the programs that think they have a mapping to
> their data, (c) see if we have a DRAM copy and just write that back, (d)
> set wb_err so fsyncs fail, and/or (e) regenerate metadata as necessary?

(a), (b) duplicate what memory error handling already does. So yes,
could be done but it only helps if machine check handling is broken or
missing.

(c) what DRAM copy in the DAX case?

(d) dax fsync is just cache flush, so it can't fail, or are you
talking about errors in metadata?

(e) I thought our solution for dax metadata redundancy is to use a
realtime data device and raid mirror for the metadata device.

> <cough> Will XFS ever get that "your storage went bad" hook that was
> promised ages ago?

pmem developers don't scale?

> Though I guess it only does this a single page at a time, which won't be
> awesome if we're trying to zero (say) 100GB of pmem.  I was expecting to
> see one big memset() call to zero the entire range followed by
> pmem_clear_poison() on the entire range, but I guess you did tag this
> RFC. :)

Until movdir64b is available the only way to clear poison is by making
a call to the BIOS. The BIOS may not be efficient at bulk clearing.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
