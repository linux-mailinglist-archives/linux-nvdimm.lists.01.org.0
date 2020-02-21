Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDC516887C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 21 Feb 2020 22:00:47 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CFBFC1007A830;
	Fri, 21 Feb 2020 13:01:37 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2DCC41007B162
	for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 13:01:34 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id p125so2941642oif.10
        for <linux-nvdimm@lists.01.org>; Fri, 21 Feb 2020 13:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9zGqeiAFuU1hz56hby3sLYJSu+5W5mMr3othhbbia0=;
        b=LGR8SSxjxsz7OwmUqvbysr04iq9GPLpZrVPnhdeyWuwXYL6nR0s7DqdFSHEy7steMk
         54L4psHjsvpbD6fElTbY9MLZDealwQ3dB3E4H4hRi1QRTwM07LT0lotlbHcd0fO/szMN
         WrtNGZIBKOq11kZ+zWAQVOmG1SWPQPmyg5OmSnBHEFtj7K2b8p+8xAxCCaVAUKmB66Xk
         eymuD0trHzIkIpiNTQXoBkg0DxpjEoXpmulW3fNEV1d3fylm0bbtMwJWfO9jhnQzSipx
         taaEo7YFVu/AcNeABK2ZSDMWP1nrDl/v0DuySFZEdAqq4RDHdVD/rjDUdfzTJ3lAq1dC
         SwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9zGqeiAFuU1hz56hby3sLYJSu+5W5mMr3othhbbia0=;
        b=i6KQ9XXNym+r+yM6/5kQHNE0prinSCOzhBg2Q3TXeTqLtqGfRYAyZsvNI5sEqHtFPt
         euqAvj5rPJn5MlVFmnc3whL9mlmWTXbElOI/bTYwM8KQWuOPYSbdLH6ZoBEDY2MIbH5R
         9yu8SUzX5q2K41bKCm5Civ0Q7w3tJ7+gXzaGyJ0ptekuLL+Hq0LGjnpHcz5pdOIn2jqk
         ZBPcm22Ldt0see3qaLRSKB2qKUGd4Rx1mz9m7ByDTWE4GbvFrMQB992b4WwTYsy7u03o
         iXrSspm+VoRu0YZQ69FK00sgzfpfK1G72DqmZKuzbk6+pPZJhRzhQz+VXcsJfhKMaq4Q
         ZsSA==
X-Gm-Message-State: APjAAAVRRed+y3iGWUio0ldIl+wqyEpO/NGbaWfH0c89M+ZWyHTHaUpp
	yvNuEhO1+cnc+gCW/0V+bs7n/VdgCJbjZSl9WR81zg==
X-Google-Smtp-Source: APXvYqw+sNx+g44a5wUn/igCjTg5OUz/j/7Mm1hjMZw3kTc6+e1Wo0DO9NrmlIQshXvM9KPkC+QIb+hq8ADsgW7KLyA=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr3561886oia.73.1582318840763;
 Fri, 21 Feb 2020 13:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-3-vgoyal@redhat.com>
 <x49lfoxj622.fsf@segfault.boston.devel.redhat.com> <20200220215707.GC10816@redhat.com>
 <x498skv3i5r.fsf@segfault.boston.devel.redhat.com> <20200221201759.GF25974@redhat.com>
In-Reply-To: <20200221201759.GF25974@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 21 Feb 2020 13:00:29 -0800
Message-ID: <CAPcyv4j3BPGvrhuVaQZgvZ0i+M+i-Ab0BH+mAjR_aZzu4_kidQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] drivers/pmem: Allow pmem_clear_poison() to accept
 arbitrary offset and len
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: CGBDNCJRYYROYRMZLKPQZ6JOCLMA4PJQ
X-Message-ID-Hash: CGBDNCJRYYROYRMZLKPQZ6JOCLMA4PJQ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CGBDNCJRYYROYRMZLKPQZ6JOCLMA4PJQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 21, 2020 at 12:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Fri, Feb 21, 2020 at 01:32:48PM -0500, Jeff Moyer wrote:
> > Vivek Goyal <vgoyal@redhat.com> writes:
> >
> > > On Thu, Feb 20, 2020 at 04:35:17PM -0500, Jeff Moyer wrote:
> > >> Vivek Goyal <vgoyal@redhat.com> writes:
> > >>
> > >> > Currently pmem_clear_poison() expects offset and len to be sector aligned.
> > >> > Atleast that seems to be the assumption with which code has been written.
> > >> > It is called only from pmem_do_bvec() which is called only from pmem_rw_page()
> > >> > and pmem_make_request() which will only passe sector aligned offset and len.
> > >> >
> > >> > Soon we want use this function from dax_zero_page_range() code path which
> > >> > can try to zero arbitrary range of memory with-in a page. So update this
> > >> > function to assume that offset and length can be arbitrary and do the
> > >> > necessary alignments as needed.
> > >>
> > >> What caller will try to zero a range that is smaller than a sector?
> > >
> > > Hi Jeff,
> > >
> > > New dax zeroing interface (dax_zero_page_range()) can technically pass
> > > a range which is less than a sector. Or which is bigger than a sector
> > > but start and end are not aligned on sector boundaries.
> >
> > Sure, but who will call it with misaligned ranges?
>
> create a file foo.txt of size 4K and then truncate it.
>
> "truncate -s 23 foo.txt". Filesystems try to zero the bytes from 24 to
> 4095.
>
> I have also written a test for this.
>
> https://github.com/rhvgoyal/misc/blob/master/pmem-tests/iomap-range-test.sh#L102
>
> >
> > > At this point of time, all I care about is that case of an arbitrary
> > > range is handeled well. So if a caller passes a range in, we figure
> > > out subrange which is sector aligned in terms of start and end, and
> > > clear poison on those sectors and ignore rest of the range. And
> > > this itself will be an improvement over current behavior where
> > > nothing is cleared if I/O is not sector aligned.
> >
> > I don't think this makes sense.  The caller needs to know about the
> > blast radius of errors.  This is why I asked for a concrete example.
> > It might make more sense, for example, to return an error if not all of
> > the errors could be cleared.
> >
> > >> > nvdimm_clear_poison() seems to assume offset and len to be aligned to
> > >> > clear_err_unit boundary. But this is currently internal detail and is
> > >> > not exported for others to use. So for now, continue to align offset and
> > >> > length to SECTOR_SIZE boundary. Improving it further and to align it
> > >> > to clear_err_unit boundary is a TODO item for future.
> > >>
> > >> When there is a poisoned range of persistent memory, it is recorded by
> > >> the badblocks infrastructure, which currently operates on sectors.  So,
> > >> no matter what the error unit is for the hardware, we currently can't
> > >> record/report to userspace anything smaller than a sector, and so that
> > >> is what we expect when clearing errors.
> > >>
> > >> Continuing on for completeness, we will currently not map a page with
> > >> badblocks into a process' address space.  So, let's say you have 256
> > >> bytes of bad pmem, we will tell you we've lost 512 bytes, and even if
> > >> you access a valid mmap()d address in the same page as the poisoned
> > >> memory, you will get a segfault.
> > >>
> > >> Userspace can fix up the error by calling write(2) and friends to
> > >> provide new data, or by punching a hole and writing new data to the hole
> > >> (which may result in getting a new block, or reallocating the old block
> > >> and zeroing it, which will clear the error).
> > >
> > > Fair enough. I do not need poison clearing at finer granularity. It might
> > > be needed once dev_dax path wants to clear poison. Not sure how exactly
> > > that works.
> >
> > It doesn't.  :)
> >
> > >> > +        /*
> > >> > +         * Callers can pass arbitrary offset and len. But nvdimm_clear_poison()
> > >> > +         * expects memory offset and length to meet certain alignment
> > >> > +         * restrction (clear_err_unit). Currently nvdimm does not export
> > >>                                                   ^^^^^^^^^^^^^^^^^^^^^^
> > >> > +         * required alignment. So align offset and length to sector boundary
> > >>
> > >> What is "nvdimm" in that sentence?  Because the nvdimm most certainly
> > >> does export the required alignment.  Perhaps you meant libnvdimm?
> > >
> > > I meant nvdimm_clear_poison() function in drivers/nvdimm/bus.c. Whatever
> > > it is called. It first queries alignement required (clear_err_unit) and
> > > then makes sure range passed in meets that alignment requirement.
> >
> > My point was your comment is misleading.
> >
> > >> We could potentially support clearing less than a sector, but I'd have
> > >> to understand the use cases better before offerring implementation
> > >> suggestions.
> > >
> > > I don't need clearing less than a secotr. Once somebody needs it they
> > > can implement it. All I am doing is making sure current logic is not
> > > broken when dax_zero_page_range() starts using this logic and passes
> > > an arbitrary range. We need to make sure we internally align I/O
> >
> > An arbitrary range is the same thing as less than a sector.  :)  Do you
> > know of an instance where the range will not be sector-aligned and sized?
> >
> > > and carve out an aligned sub-range and pass that subrange to
> > > nvdimm_clear_poison().
> >
> > And what happens to the rest?  The caller is left to trip over the
> > errors?  That sounds pretty terrible.  I really think there needs to be
> > an explicit contract here.
>
> Ok, I think is is the contentious bit. Current interface
> (__dax_zero_page_range()) either clears the poison (if I/O is aligned to
> sector) or expects page to be free of poison.
>
> So in above example, of "truncate -s 23 foo.txt", currently I get an error
> because range being zeroed is not sector aligned. So
> __dax_zero_page_range() falls back to calling direct_access(). Which
> fails because there are poisoned sectors in the page.
>
> With my patches, dax_zero_page_range(), clears the poison from sector 1 to
> 7 but leaves sector 0 untouched and just writes zeroes from byte 0 to 511
> and returns success.
>
> So question is, is this better behavior or worse behavior. If sector 0
> was poisoned, it will continue to remain poisoned and caller will come
> to know about it on next read and then it should try to truncate file
> to length 0 or unlink file or restore that file to get rid of poison.
>
> IOW, if a partial block is being zeroed and if it is poisoned, caller
> will not be return an error and poison will not be cleared and memory
> will be zeroed. What do we expect in such cases.
>
> Do we expect an interface where if there are any bad blocks in the range
> being zeroed, then they all should be cleared (and hence all I/O should
> be aligned) otherwise error is returned. If yes, I could make that
> change.

This does not strike me as a good idea because it's a false security
compared to the latent poison case. If the writes to an unknown
poisoned location would otherwise succeed via a different I/O path
(dax), it's an unsymmetric surprise to start returning errors just
because you wrote zeroes as a side effect of truncate.

> Downside of current interface is that it will clear as many blocks as
> possible in the given range and leave starting and end blocks poisoned
> (if it is unaligned) and not return error. That means a reader will
> get error on these blocks again and they will have to try to clear it
> again.

I think what you have described in your truncate example is an
improvement on what we have currently because x86 does not communicate
write errors. Specifically, writing zeros via dax from userspace over
unknown poison behaves the same as writing unaligned zeros over known
poison. In both cases it's a best effort that always succeeds (no cpu
exception), and may inadvertently clear poison as a side-effect.
Otherwise, an error-block-aligned hole punch is the only way to
trigger the kernel to try to clear known poison when the full block is
reallocated.

On movdir64b capable cpus the error clearing unit becomes 64-bytes
rather than 256-bytes because that allows a cacheline to be written
without triggering a line fill read. So the error clearing granularity
gets better over time, but unfortunately not synchronous detection in
the I/O path.

I think a better way to improve poison handling is the long standing
idea to integrate the badblock tracking into the filesystem directly.
That way driver notifications of poison can be ingested into the
filesystem and notifications sent on filenames rather than the current
TOCTOU mess of trying to do a reverse lookup of badblock numbers to
files. If the application can efficiently list and be notified of
poison it can mitigate it immediately rather than trying to rely on
write side effects.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
