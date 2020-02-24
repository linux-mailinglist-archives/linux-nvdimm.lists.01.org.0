Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20916B131
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 21:52:30 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 88A8D10FC33E5;
	Mon, 24 Feb 2020 12:53:20 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4A708100780BF
	for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 12:53:18 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i6so10004903otr.7
        for <linux-nvdimm@lists.01.org>; Mon, 24 Feb 2020 12:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8R0Yz0kh2qEncltGO0WdBs4JzIqRp4Msdo8mPLCV/M=;
        b=T/Ped1HqKQsyhfGnnfPSZm5Dmza9Kw7HUIrjsLWpG2Pn+ucdj+Y+x4+a2rmiK0YfgB
         aQwOW8e75UggCu3EDNfKC0Xal/4/z3TCc3wH6KSB2TqIa4LcmBhu/7VRc6T6VFaGoQL9
         k9E9sfbzD3Q2xb7OGhuzKcTXln2FrKHWHSnfEHdbUjHY8rgwzFySxOlVfohs42QEkP3j
         Osz5vZpWrm7p/7rzwnf8dBAxU9yaEL+z6cNGUvHvvBia7gJmY2ad8H/mzZcstOaK359c
         UKyzUL8CP1F+JHHn9kIscxBd5angkPDv7vPFKPxjLbg2xiIvUGkMYeK5eQsfXHGKZ7Ot
         B0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8R0Yz0kh2qEncltGO0WdBs4JzIqRp4Msdo8mPLCV/M=;
        b=UX0mA8zx1CMBpw7cTMvwYW4/tjv06fatEzrCQSN1Mg02ebDBCbaBStGKoZWBWP2Ht/
         Pf2eB4BCGxiRiTA/Jgd9F+bViuzHTntRA5XdhyZH8FxbnXRnl7Ubd/910uZinovdI04c
         AJUENZIuh9smjIsWbwPIjQL2y8QeSw2L0ht8duXcWBos2eWRTDSimJsqFBSYZ7wUDyTq
         0aAk/utGA+7wMFaes4ERYEUpw+k9IDL8CpMsFWLbCighHeK3jvxVdHF+dQPUq4ynnvDg
         NMuAsqBYdVI/2Dv1lSHv6YWAsFYBPp/VmXX6wEDuJZ42Zu5lpN9Vh/vCTQN5uXyVWJpx
         +MUw==
X-Gm-Message-State: APjAAAUjw82u7MRU9uyDpRwM1EqITHvFTloh6Ew/nB2HEdKhyG1pfzMc
	b7cFj7xLt+eFQBhJvC1zLNtXO4qSoBrJFq7kZahBAg==
X-Google-Smtp-Source: APXvYqwqRTpp2me+DUxj2FvNKdLSg8IA7RdRU0WUAM4YskYWcv2V2vC5gEmMF+jsQYHbJN7ozB05eAA5F/kJbEVg1Vw=
X-Received: by 2002:a9d:7852:: with SMTP id c18mr39808439otm.247.1582577545041;
 Mon, 24 Feb 2020 12:52:25 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
 <20200223230330.GE10737@dread.disaster.area> <20200224201346.GC14651@redhat.com>
In-Reply-To: <20200224201346.GC14651@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 24 Feb 2020 12:52:13 -0800
Message-ID: <CAPcyv4gGrimesjZ=OKRaYTDd5dUVz+U9aPeBMh_H3_YCz4FOEQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: LT73CFYLM5ID7XYWSV34ZHTUKQ6C4HOF
X-Message-ID-Hash: LT73CFYLM5ID7XYWSV34ZHTUKQ6C4HOF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LT73CFYLM5ID7XYWSV34ZHTUKQ6C4HOF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 24, 2020 at 12:13 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Feb 24, 2020 at 10:03:30AM +1100, Dave Chinner wrote:
> > On Fri, Feb 21, 2020 at 03:17:59PM -0500, Vivek Goyal wrote:
> > > On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > > > Vivek Goyal <vgoyal@redhat.com> writes:
> > > >
> > > > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > > > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > > > >>
> > > > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > > > >> > Atleast that seems to be the assumption with which code has been written.
> > > > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > > > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > > > >> >
> > > > >> > Soon we want use this function from dax_zero_page_range() code path which
> > > > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > > > >> > function to assume that offset and length can be arbitrary and do the
> > > > >> > necessary alignments as needed.
> > > > >>
> > > > >> What caller will try to zero a range that is smaller than a sector?
> > > > >
> > > > > Hi Jeff,
> > > > >
> > > > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > > > a range which is less than a sector. Or which is bigger than a sector
> > > > > but start and end are not aligned on sector boundaries.
> > > >
> > > > Sure, but who will call it with misaligned ranges?
> > >
> > > create a file foo.txt of size 4K and then truncate it.
> > >
> > > "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> > > 4095.
> >
> > This should fail with EIO. Only full page writes should clear the
> > bad page state, and partial writes should therefore fail because
> > they do not guarantee the data in the filesystem block is all good.
> >
> > If this zeroing was a buffered write to an address with a bad
> > sector, then the writeback will fail and the user will (eventually)
> > get an EIO on the file.
> >
> > DAX should do the same thing, except because the zeroing is
> > synchronous (i.e. done directly by the truncate syscall) we can -
> > and should - return EIO immediately.
> >
> > Indeed, with your code, if we then extend the file by truncating up
> > back to 4k, then the range between 23 and 512 is still bad, even
> > though we've successfully zeroed it and the user knows it. An
> > attempt to read anywhere in this range (e.g. 10 bytes at offset 100)
> > will fail with EIO, but reading 10 bytes at offset 2000 will
> > succeed.
> >
> > That's *awful* behaviour to expose to userspace, especially when
> > they look at the fs config and see that it's using both 4kB block
> > and sector sizes...
> >
> > The only thing that makes sense from a filesystem perspective is
> > clearing bad page state when entire filesystem blocks are
> > overwritten. The data in a filesystem block is either good or bad,
> > and it doesn't matter how many internal (kernel or device) sectors
> > it has.
> >
> > > > And what happens to the rest?  The caller is left to trip over the
> > > > errors?  That sounds pretty terrible.  I really think there needs to be
> > > > an explicit contract here.
> > >
> > > Ok, I think is is the contentious bit. Current interface
> > > (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> > > sector) or expects page to be free of poison.
> > >
> > > So in above example, of "truncate -s 23 foo.txt", currently I get an error
> > > because range being zeroed is not sector aligned. So
> > > __dax_zero_page_range() falls back to calling direct_access(). Which
> > > fails because there are poisoned sectors in the page.
> > >
> > > With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> > > 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> > > and returns success.
> >
> > Ok, kernel sectors are not the unit of granularity bad page state
> > should be managed at. They don't match page state granularity, and
> > they don't match filesystem block granularity, and the whacky
> > "partial writes silently succeed, reads fail unpredictably"
> > assymetry it leads to will just cause problems for users.
> >
> > > So question is, is this better behavior or worse behavior. If sector 0
> > > was poisoned, it will continue to remain poisoned and caller will come
> > > to know about it on next read and then it should try to truncate file
> > > to length 0 or unlink file or restore that file to get rid of poison.
> >
> > Worse, because the filesystem can't track what sub-parts of the
> > block are bad and that leads to inconsistent data integrity status
> > being exposed to userspace.
> >
> >
> > > IOW, if a partial block is being zeroed and if it is poisoned, caller
> > > will not be return an error and poison will not be cleared and memory
> > > will be zeroed. What do we expect in such cases.
> > >
> > > Do we expect an interface where if there are any bad blocks in the range
> > > being zeroed, then they all should be cleared (and hence all I/O should
> > > be aligned) otherwise error is returned. If yes, I could make that
> > > change.
> > >
> > > Downside of current interface is that it will clear as many blocks as
> > > possible in the given range and leave starting and end blocks poisoned
> > > (if it is unaligned) and not return error. That means a reader will
> > > get error on these blocks again and they will have to try to clear it
> > > again.
> >
> > Which is solved by having partial page writes always EIO on poisoned
> > memory.
>
> Ok, how about if I add one more patch to the series which will check
> if unwritten portion of the page has known poison. If it has, then
> -EIO is returned.
>
>
> Subject: pmem: zero page range return error if poisoned memory in unwritten area
>
> Filesystems call into pmem_dax_zero_page_range() to zero partial page upon
> truncate. If partial page is being zeroed, then at the end of operation
> file systems expect that there is no poison in the whole page (atleast
> known poison).
>
> So make sure part of the partial page which is not being written, does not
> have poison. If it does, return error. If there is poison in area of page
> being written, it will be cleared.

No, I don't like that the zero operation is special cased compared to
the write case. I'd say let's make them identical for now. I.e. fail
the I/O at dax_direct_access() time. I think the error clearing
interface should be an explicit / separate op rather than a
side-effect. What about an explicit interface for initializing newly
allocated blocks, and the only reliable way to destroy poison through
the filesystem is to free the block?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
