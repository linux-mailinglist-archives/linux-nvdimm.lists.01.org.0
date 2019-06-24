Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC515195E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 19:14:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C6050212966EC;
	Mon, 24 Jun 2019 10:14:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=obuil.liubo@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 9B584212741EC
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 10:14:07 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d17so15249126qtj.8
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qJ+RAvzPBAa5v9bPGuZoXeQwFc3BtTVsLP1GzK8UUP4=;
 b=NLRB/GC9Umew7FMEUu8JPvaseDV5/gNuyIlAsJTrrAX2wk76pD/3wC/xO2nx6SOnFt
 6QgCwp8+hXZfCt4W4SRuDE4SIX9NJfm1RdY9lCsajqEe/tcJqAKETWZXZzBBuiShraMP
 tFiopWrOpZ76T0hADA/WzVfuaTAnJa/WYt5ChgGqzEwmUpJdDpoHRreQQMZFJK8Una+U
 63W9S90SIFiXdqSSbFgXqSZ+FzQsJo3nrVvWtUD8DtX9PoxOFKlLWJAPTkvAB3g1pYMQ
 aZYxBEyMB8FOD0wLAM6UIo7EtBC52Mna5EOyPdz7U955NsPivwU3kGQNdBPFEtOmUcAU
 LQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qJ+RAvzPBAa5v9bPGuZoXeQwFc3BtTVsLP1GzK8UUP4=;
 b=bbjQiAJXCotue/x2hUqrW8ibEV2nhPxrSldG/+SX9bn1kMfCT6+uj2Y2vXivHelNLw
 OinZt6YQyi6w5B2btirANDPLjEgmc2CcIR21KrNZNzRR3OAmZHzEOJLJXDZdZOKiD0bK
 bnaNLQ7MLP/fV3uGBdDyRs5/ScYTgJ+5IYAthsLy13NMBGy/hxyJMOe0t1pBakGbZ7XP
 8M7j8BRmqHJwC3SfC6xXh4F1G4OHrb27mEkfm3AUS7RvVTH2SNECeQz+mUOOoC6nRJiW
 Z5flZfIEC5DpBrwVRSvFG9XePgoQ3i1enPRDqHbeIxngzh+u3OqefsQUcBZi2dX6fOWE
 qabQ==
X-Gm-Message-State: APjAAAXe+nj8hAA287qlyHAo8kpNxtog43hagzkryfJnYUtFr6ih3Vu5
 A5k73/FXqs/PDtek8iy28C0i3kqQRnkX8e/q1C8=
X-Google-Smtp-Source: APXvYqxp485nYNDW+Op6Gikqr5hCb2I/N/zJwLAWIaqkZ0JejaH2p8x2EBjaEkM9me2CJmO22UOyn7h6+JA2pWJ4e8M=
X-Received: by 2002:a0c:d04a:: with SMTP id d10mr57748940qvh.189.1561396446261; 
 Mon, 24 Jun 2019 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANQeFDCCGED3BR0oTpzQ75gtGpdGCw8FLf+kspBYytw3YteXAw@mail.gmail.com>
 <20190620083628.GH13630@quack2.suse.cz>
 <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
 <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com>
 <20190624104106.GC32376@quack2.suse.cz>
In-Reply-To: <20190624104106.GC32376@quack2.suse.cz>
From: Liu Bo <obuil.liubo@gmail.com>
Date: Mon, 24 Jun 2019 10:13:55 -0700
Message-ID: <CANQeFDBYQH5Pxwk17rey6VsCDLV9_g0YX5u=OzcnpoojPveO+w@mail.gmail.com>
Subject: Re: a few questions about pagevc_lookup_entries
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
Cc: linux-nvdimm@lists.01.org, Miklos Szeredi <miklos@szeredi.hu>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 24, 2019 at 3:41 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 24-06-19 09:25:00, Miklos Szeredi wrote:
> > [cc: vivek, stefan, dgilbert]
> >
> > On Fri, Jun 21, 2019 at 12:04 AM Liu Bo <obuil.liubo@gmail.com> wrote:
> > >
> > > On Thu, Jun 20, 2019 at 1:36 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > [added some relevant lists to CC - this can safe some people debugging by
> > > > being able to google this discussion]
> > > >
> > > > On Wed 19-06-19 15:57:38, Liu Bo wrote:
> > > > > I found a weird dead loop within invalidate_inode_pages2_range, the
> > > > > reason being that  pagevec_lookup_entries(index=1) returns an indices
> > > > > array which has only one entry storing value 0, and this has led
> > > > > invalidate_inode_pages2_range() to a dead loop, something like,
> > > > >
> > > > > invalidate_inode_pages2_range()
> > > > >   -> while (pagevec_lookup_entries(index=1, indices))
> > > > >     ->  for (i = 0; i < pagevec_count(&pvec); i++) {
> > > > >       -> index = indices[0]; // index is set to 0
> > > > >       -> if (radix_tree_exceptional_entry(page)) {
> > > > >           -> if (!invalidate_exceptional_entry2()) //
> > > > >                   ->__dax_invalidate_mapping_entry // return 0
> > > > >                      -> // entry marked as PAGECACHE_TAG_DIRTY/TOWRITE
> > > > >                  ret = -EBUSY;
> > > > >           ->continue;
> > > > >           } // end of if (radix_tree_exceptional_entry(page))
> > > > >     -> index++; // index is set to 1
> > > > >
> > > > > The following debug[1] proved the above analysis,  I was wondering if
> > > > > this was a corner case that  pagevec_lookup_entries() allows or a
> > > > > known bug that has been fixed upstream?
> > > > >
> > > > > ps: the kernel in use is 4.19.30 (LTS).
> > > >
> > > > Hum, the above trace suggests you are using DAX. Are you really? Because the
> > > > stacktrace below shows we are working on fuse inode so that shouldn't
> > > > really be DAX inode...
> > > >
> > >
> > > So I was running tests against virtiofs[1] which adds dax support to
> > > fuse, with dax, fuse provides posix stuff while dax provides data
> > > channel.
> > >
> > > [1]: https://virtio-fs.gitlab.io/
> > > https://gitlab.com/virtio-fs/linux
>
> OK, thanks for the explanation and the pointer. So if I should guess, I'd
> say that there's some problem with multiorder entries (for PMD pages) in
> the radix tree. In particular if you lookup index 1 and there's
> multiorder entry for indices 0-511, radix_tree_next_chunk() is updating
> iter->index like:
>
> iter->index = (index &~ node_maxindex(node)) | (offset << node->shift);
>
> and offset is computed by radix_tree_descend() as:
>
> offset = (index >> parent->shift) & RADIX_TREE_MAP_MASK;
>
> So this all results in iter->index being set to 0 and thus confusing the
> iteration in invalidate_inode_pages2_range(). Current kernel has xarray
> code from Matthew which maintains originally passed index in xas.xa_index
> and thus the problem isn't there.
>
> So to sum up: Seems like a DAX-specific bug with PMD entries in older
> kernels fixed by xarray rewrite.
>

Thank you so much for the information, Jan.

I'll double check if that's the root cause and report back, if yes,
guess then we have to fix 4.19's radix tree in place to do the right
thing instead of porting back xarray rewrite..

thanks,
liubo

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
