Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75E3781C
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 17:36:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A0112128D883;
	Thu,  6 Jun 2019 08:35:58 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A4E3219493E6
 for <linux-nvdimm@lists.01.org>; Thu,  6 Jun 2019 08:35:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id q186so1904584oia.0
 for <linux-nvdimm@lists.01.org>; Thu, 06 Jun 2019 08:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1uRCmoXjULyV6kNTp2XKoB1qQmxkPSNDXYL9A3FHXFA=;
 b=QHJOC2ZZhCoDsF3kkt0jD8pflX+D1g9wOGO30jisMp6VkS20cZbHhajfwYZJVXdiNh
 JvAq7go3CRc5C+qomPxstLKznxkYPvd1O8ef7VHSAdG1rMnaPbbiOm9MuPNkCt7QxXaR
 tW2MckCN4CHKIL8N13EVae4FrQAMJth8VAaKv/3gRwubZltnT7kNI3PWIXvq1c0vgZdi
 L4XQGyBb2kkKpfIMhfb2YWP8o3M95HB+am83dkZODoLq1I1UWGrX6Sp8tjJSrVa2UG3+
 kN4AXQu3lycB826+fr4/pUl5FixrZTURACJPQlnP2NuCi+p38m+p145UkX/P89XlKLdK
 QHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1uRCmoXjULyV6kNTp2XKoB1qQmxkPSNDXYL9A3FHXFA=;
 b=RfymymnkJtQ5yULKEDuRGaiU9acpuyZXU3gaXNvyRJf2eG86m4M8Mvs3FiUzHME9Bf
 e1lX1I4GQyXRT7X4F8qWSttrUaLNgpmap3c06M5Sbn0YEK2BCgUEUp8UgN5L45X7+EMf
 pz559SXmsg1gAXKJBbCdtOtQy3L32rc+bMONLeg+P83QhMmnVIjqnxS/1jfnuRiZ7wvZ
 8woy87jw6dlNpqd2bdg1gjdNdl/WIQvO7QgjQ/I/4xd3el6qKTqZMkTT1x2ZFI6mzZMf
 jI2JezfBicAWgn2WpOejG1cEDY1eS9/nimUVcOipttLoh+yb52Op3f2EEoXppY+IzoKm
 bk2g==
X-Gm-Message-State: APjAAAWYbRZhMD84PaHyhghG2uJWaoal9/kps/uZoFj1XiwIOsM1me2l
 OiMWTcI4ByUcHYAM6CuBkgCH+xCjRrMctjoAvtY6dQ==
X-Google-Smtp-Source: APXvYqwQgzrGrWeJ2qr6zRt1Kh72wsL96qCKSVk7C2TBZflDvhLK6wlI/C4trmZ0QEDDo8Q9KA4CrwRdXYqf7oGmgHc=
X-Received: by 2002:aca:bbc5:: with SMTP id l188mr410988oif.73.1559835355090; 
 Thu, 06 Jun 2019 08:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
In-Reply-To: <20190606104203.GF7433@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 6 Jun 2019 08:35:42 -0700
Message-ID: <CAPcyv4h-k_5T39fDY+SVrLXG_XETmgz-6N3NjQUteYG7g9NdDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
To: Jan Kara <jack@suse.cz>
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Dave Chinner <david@fromorbit.com>, Jeff Layton <jlayton@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-xfs <linux-xfs@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 6, 2019 at 3:42 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 05-06-19 18:45:33, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > ... V1,000,000   ;-)
> >
> > Pre-requisites:
> >       John Hubbard's put_user_pages() patch series.[1]
> >       Jan Kara's ext4_break_layouts() fixes[2]
> >
> > Based on the feedback from LSFmm and the LWN article which resulted.  I've
> > decided to take a slightly different tack on this problem.
> >
> > The real issue is that there is no use case for a user to have RDMA pinn'ed
> > memory which is then truncated.  So really any solution we present which:
> >
> > A) Prevents file system corruption or data leaks
> > ...and...
> > B) Informs the user that they did something wrong
> >
> > Should be an acceptable solution.
> >
> > Because this is slightly new behavior.  And because this is gonig to be
> > specific to DAX (because of the lack of a page cache) we have made the user
> > "opt in" to this behavior.
> >
> > The following patches implement the following solution.
> >
> > 1) The user has to opt in to allowing GUP pins on a file with a layout lease
> >    (now made visible).
> > 2) GUP will fail (EPERM) if a layout lease is not taken
> > 3) Any truncate or hole punch operation on a GUP'ed DAX page will fail.
> > 4) The user has the option of holding the layout lease to receive a SIGIO for
> >    notification to the original thread that another thread has tried to delete
> >    their data.  Furthermore this indicates that if the user needs to GUP the
> >    file again they will need to retake the Layout lease before doing so.
> >
> >
> > NOTE: If the user releases the layout lease or if it has been broken by
> > another operation further GUP operations on the file will fail without
> > re-taking the lease.  This means that if a user would like to register
> > pieces of a file and continue to register other pieces later they would
> > be advised to keep the layout lease, get a SIGIO notification, and retake
> > the lease.
> >
> > NOTE2: Truncation of pages which are not actively pinned will succeed.
> > Similar to accessing an mmap to this area GUP pins of that memory may
> > fail.
>
> So after some through I'm willing accept the fact that pinned DAX pages
> will just make truncate / hole punch fail and shove it into a same bucket
> of situations like "user can open a file and unlink won't delete it" or
> "ETXTBUSY when user is executing a file being truncated".  The problem I
> have with this proposal is a lack of visibility from sysadmin POV. For
> ETXTBUSY or "unlinked but open file" sysadmin can just do lsof, find the
> problematic process and kill it. There's nothing like that with your
> proposal since currently once you hold page reference, you can unmap the
> file, drop layout lease, close the file, and there's no trace that you're
> responsible for the pinned page anymore.
>
> So I'd like to actually mandate that you *must* hold the file lease until
> you unpin all pages in the given range (not just that you have an option to
> hold a lease). And I believe the kernel should actually enforce this. That
> way we maintain a sane state that if someone uses a physical location of
> logical file offset on disk, he has a layout lease. Also once this is done,
> sysadmin has a reasonably easy way to discover run-away RDMA application
> and kill it if he wishes so.

Yes, this satisfies the primary concern that made me oppose failing
truncate. If the administrator determines that reclaiming capacity is
more important than maintaining active RDMA mappings "lsof + kill" is
a reasonable way to recover. I'd go so far as to say that anything
less is an abdication of the kernel's responsibility as an arbiter of
platform resources.

> The question is on how to exactly enforce that lease is taken until all
> pages are unpinned. I belive it could be done by tracking number of
> long-term pinned pages within a lease. Gup_longterm could easily increment
> the count when verifying the lease exists, gup_longterm users will somehow
> need to propagate corresponding 'filp' (struct file pointer) to
> put_user_pages_longterm() callsites so that they can look up appropriate
> lease to drop reference - probably I'd just transition all gup_longterm()
> users to a saner API similar to the one we have in mm/frame_vector.c where
> we don't hand out page pointers but an encapsulating structure that does
> all the necessary tracking. Removing a lease would need to block until all
> pins are released - this is probably the most hairy part since we need to
> handle a case if application just closes the file descriptor which would
> release the lease but OTOH we need to make sure task exit does not deadlock.
> Maybe we could block only on explicit lease unlock and just drop the layout
> lease on file close and if there are still pinned pages, send SIGKILL to an
> application as a reminder it did something stupid...
>
> What do people think about this?

SIGKILL on close() without explicit unlock and wait-on-last-pin with
explicit unlock sounds reasonable to me.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
