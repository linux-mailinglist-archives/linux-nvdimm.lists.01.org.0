Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ACB42F4E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 20:50:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 28F192129605E;
	Wed, 12 Jun 2019 11:50:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::243; helo=mail-oi1-x243.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CAE4A2129604D
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 11:50:03 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t76so12480272oih.4
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 11:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oLKBk3Q7ccO0NJJMRJYYFBU09UJHS0/ornRP0j3Fxnk=;
 b=gmeYon7zauy3OQh0dds8NZYm6t5UDisLz6yhyFv+zAHzAQld3I1PlASf7zsZM+CaaZ
 CehQMBgQdj6gortTquDOB3N7bsSZoRiiIPq0F65TSYhGSEiVglTlgXcZdamdruNK0EZE
 L4hW+NB6I/OXN8FIUSFL51bNjJWJFW8hzlwgXFjesNuMtfLc6oA7+M/3K2vidJa0br9V
 czG4Eoe/orE9D++K3+lLCE4n/UgTBq+X11qW/QB7IGhWEAbaQV6NagrYsJ8UOQey3FsU
 R4uBxwDIf6zhdzoruyQQmgKdtCNWOHRzy7IMkgSp8cIYB925DCaZB8zX5lMCi8WnCkui
 Earw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oLKBk3Q7ccO0NJJMRJYYFBU09UJHS0/ornRP0j3Fxnk=;
 b=jt85AxZZ41EKPFEJy7KEhy7rEl7Loej+M4c2a25FzWk9Vb6C56bW3AnRvxsOHXL4LP
 1TQJCRTRv7zpVAOpm1uVetBtaEqwdMvYmfGL6lZfcIhMnHdDnzELFDt5pn3hYQ+qh7IX
 rv4Sl/Qxd35D41Nf00UjU5QMcLd+EYWhN6TY/IR2x8Roi0SDxqBlmx1V1AUqXaC6m1pG
 MkOTt1w2S1fSegGp+DXCrbmB6WKRQcPq0sZG+A6BbATpbgTCZb8M4g3rzQtextz6ast1
 SdUiP5/hbAY0XJR76U+CSmPLdYwvzVzeCXRyt4C0cXms7mwAeWg9b/Xldx9eV1UKVi/Y
 KagA==
X-Gm-Message-State: APjAAAX6zvLAbhAyJxFAjw7jrUxY0FoCR8pLKLusvKR8Kmo0toC/OvR9
 949+xBQbl0qf2GSzcDb7Hol+l3tsBeLoCUCYKEi87g==
X-Google-Smtp-Source: APXvYqxnUAltCxrDlkjMuVh0Fis6UXRXzk4ak5OCGI7cs5NoWVrVaXVk3zYCAPwY8b7pSu88qbXHjB+1CYR77yxpUws=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr420099oih.73.1560365403007; 
 Wed, 12 Jun 2019 11:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606195114.GA30714@ziepe.ca>
 <20190606222228.GB11698@iweiny-DESK2.sc.intel.com>
 <20190607103636.GA12765@quack2.suse.cz> <20190607121729.GA14802@ziepe.ca>
 <20190607145213.GB14559@iweiny-DESK2.sc.intel.com>
 <20190612102917.GB14578@quack2.suse.cz>
In-Reply-To: <20190612102917.GB14578@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 12 Jun 2019 11:49:52 -0700
Message-ID: <CAPcyv4jSyTjC98UsWb3-FnZekV0oyboiSe9n1NYDC2TSKAqiqw@mail.gmail.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 12, 2019 at 3:29 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 07-06-19 07:52:13, Ira Weiny wrote:
> > On Fri, Jun 07, 2019 at 09:17:29AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Jun 07, 2019 at 12:36:36PM +0200, Jan Kara wrote:
> > >
> > > > Because the pins would be invisible to sysadmin from that point on.
> > >
> > > It is not invisible, it just shows up in a rdma specific kernel
> > > interface. You have to use rdma netlink to see the kernel object
> > > holding this pin.
> > >
> > > If this visibility is the main sticking point I suggest just enhancing
> > > the existing MR reporting to include the file info for current GUP
> > > pins and teaching lsof to collect information from there as well so it
> > > is easy to use.
> > >
> > > If the ownership of the lease transfers to the MR, and we report that
> > > ownership to userspace in a way lsof can find, then I think all the
> > > concerns that have been raised are met, right?
> >
> > I was contemplating some new lsof feature yesterday.  But what I don't
> > think we want is sysadmins to have multiple tools for multiple
> > subsystems.  Or even have to teach lsof something new for every potential
> > new subsystem user of GUP pins.
>
> Agreed.
>
> > I was thinking more along the lines of reporting files which have GUP
> > pins on them directly somewhere (dare I say procfs?) and teaching lsof to
> > report that information.  That would cover any subsystem which does a
> > longterm pin.
>
> So lsof already parses /proc/<pid>/maps to learn about files held open by
> memory mappings. It could parse some other file as well I guess. The good
> thing about that would be that then "longterm pin" structure would just hold
> struct file reference. That would avoid any needs of special behavior on
> file close (the file reference in the "longterm pin" structure would make
> sure struct file and thus the lease stays around, we'd just need to make
> explicit lease unlock block until the "longterm pin" structure is freed).
> The bad thing is that it requires us to come up with a sane new proc
> interface for reporting "longterm pins" and associated struct file. Also we
> need to define what this interface shows if the pinned pages are in DRAM
> (either page cache or anon) and not on NVDIMM.

The anon vs shared detection case is important because a longterm pin
might be blocking a memory-hot-unplug operation if it is pinning
ZONE_MOVABLE memory, but I don't think we want DRAM vs NVDIMM to be an
explicit concern of the interface. For the anon / cached case I expect
it might be useful to put that communication under the memory-blocks
sysfs interface. I.e. a list of pids that are pinning that
memory-block from being hot-unplugged.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
