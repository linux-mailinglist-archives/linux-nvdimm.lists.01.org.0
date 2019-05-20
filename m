Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C38323695
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 May 2019 14:54:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 37256212733FD;
	Mon, 20 May 2019 05:54:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 396B821260512
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 05:54:06 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D89D3091782;
 Mon, 20 May 2019 12:54:00 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BBDB6085B;
 Mon, 20 May 2019 12:53:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 06ECD220386; Mon, 20 May 2019 08:53:56 -0400 (EDT)
Date: Mon, 20 May 2019 08:53:55 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Eric Ren <ericdotren@gmail.com>
Subject: Re: [PATCH v2 26/30] fuse: Add logic to free up a memory range
Message-ID: <20190520125355.GA28008@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
 <20190515192715.18000-27-vgoyal@redhat.com>
 <CAN+Pk99SNKSf+GjSQUUWt_eu1fSjTy_ByUOEQUXHi8zNqXY1zA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAN+Pk99SNKSf+GjSQUUWt_eu1fSjTy_ByUOEQUXHi8zNqXY1zA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 20 May 2019 12:54:05 +0000 (UTC)
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
Cc: kvm@vger.kernel.org, miklos@szeredi.hu, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, dgilbert@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org, swhiteho@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, May 19, 2019 at 03:48:05PM +0800, Eric Ren wrote:
> Hi,
> 
> @@ -1784,8 +1822,23 @@ static int fuse_iomap_begin(struct inode *inode,
> > loff_t pos, loff_t length,
> >                 if (pos >= i_size_read(inode))
> >                         goto iomap_hole;
> >
> > -               alloc_dmap = alloc_dax_mapping(fc);
> > -               if (!alloc_dmap)
> > +               /* Can't do reclaim in fault path yet due to lock ordering.
> > +                * Read path takes shared inode lock and that's not
> > sufficient
> > +                * for inline range reclaim. Caller needs to drop lock,
> > wait
> > +                * and retry.
> > +                */
> > +               if (flags & IOMAP_FAULT || !(flags & IOMAP_WRITE)) {
> > +                       alloc_dmap = alloc_dax_mapping(fc);
> > +                       if (!alloc_dmap)
> > +                               return -ENOSPC;
> > +               } else {
> > +                       alloc_dmap = alloc_dax_mapping_reclaim(fc, inode);
> >
> 
> alloc_dmap could be NULL as follows:
> 
> alloc_dax_mapping_reclaim
>    -->fuse_dax_reclaim_first_mapping
>              -->fuse_dax_reclaim_first_mapping_locked
>                   --> fuse_dax_interval_tree_iter_first  ==> return NULL
> and
> 
> IS_ERR(NULL) is false, so we may miss that error case.

Hi Eric,

Good catch. I will fix it next version. 

Thanks
Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
