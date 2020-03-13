Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6E41844B1
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Mar 2020 11:18:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F89710FC3799;
	Fri, 13 Mar 2020 03:19:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::142; helo=mail-il1-x142.google.com; envelope-from=miklos@szeredi.hu; receiver=<UNKNOWN> 
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3719D10FC378D
	for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 03:19:18 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k29so8392922ilg.0
        for <linux-nvdimm@lists.01.org>; Fri, 13 Mar 2020 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyFbd+XTU4jmr46S/cr+5oxuJ4yyBlKA+WZPNk944HQ=;
        b=jbLOV/wKEBCP+egAIPuAmGI01EGi9iRz1D+M4W1UTJ1zDP7EGuZ06aIyWN1ZP2PqaS
         jt1Y6IaJZOgv5eR99mE1xIvQrt2lJqt2PMidGpfnF4LDdvdkrrGqK/CQ12baoYeXoNdR
         bMkkgu83JFDRZECx6628ZmgAPYa4D+C7IpQ4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyFbd+XTU4jmr46S/cr+5oxuJ4yyBlKA+WZPNk944HQ=;
        b=GlT8wNAcwcxuX0BLtcUpJWtPn2fz5MuKctumCTmzswBPwVC0QlUFN1jpMlCwgHjctS
         T58tXqWXHTLqNi9tAkYLcC24gpRg2pws5TlrIop+bwIKPXfxA3qJceAheq8yi9TfP/HS
         8OVHR1dLBBUa6jC4uEx73nN5VF4rr7U0ybJSCRjRlGI0URu33qTzbn0VkHxMwCz8aCAr
         EzmCPx2mbxg33P2IzUnFtt4AsCCOqMwG/11UxawmFPDbw+N9LBJpNtZq1XuYt4KX5zgh
         gRMhMhl013h7N4s7dEi1tiNMrnflpHu987CMeLY2RZ6rjZHXff18nELi9W4p65utp5qp
         wYYg==
X-Gm-Message-State: ANhLgQ0gjaKB/sfq4ITwHwLJjfkmWpRMQMQHKZPhF4urSSa3SX/twi2z
	tID9CzjOesPuq5CmqyXjLU6l8U0IxAiKDGursgPglQ==
X-Google-Smtp-Source: ADFU+vu5FYOgunG79LQ1WrD3HHErLWS3Yhjf9f/SMHV66YbhDMSAExoU1JWrRHjekA9AGDGKhjMz4qWzyU5gCRD2uoY=
X-Received: by 2002:a92:d745:: with SMTP id e5mr12394886ilq.285.1584094706462;
 Fri, 13 Mar 2020 03:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-14-vgoyal@redhat.com>
 <CAJfpegtpgE+vnN0hvEVMDyNkYZ0h3_kNgxWCQUb2iuBdy8kEsw@mail.gmail.com> <20200312160208.GB114720@redhat.com>
In-Reply-To: <20200312160208.GB114720@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 13 Mar 2020 11:18:15 +0100
Message-ID: <CAJfpegtuCCRfKfctUyQBimAOpnOTvW5zodLAy307Mr_1h0+e7g@mail.gmail.com>
Subject: Re: [PATCH 13/20] fuse, dax: Implement dax read/write operations
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: 7WS3XY6K3OAAP6YPNC6MELI2XLRA5ZSQ
X-Message-ID-Hash: 7WS3XY6K3OAAP6YPNC6MELI2XLRA5ZSQ
X-MailFrom: miklos@szeredi.hu
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm <linux-nvdimm@lists.01.org>, virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Liu Bo <bo.liu@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7WS3XY6K3OAAP6YPNC6MELI2XLRA5ZSQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 12, 2020 at 5:02 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Mar 12, 2020 at 10:43:10AM +0100, Miklos Szeredi wrote:
> > On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > This patch implements basic DAX support. mmap() is not implemented
> > > yet and will come in later patches. This patch looks into implemeting
> > > read/write.
> > >
> > > We make use of interval tree to keep track of per inode dax mappings.
> > >
> > > Do not use dax for file extending writes, instead just send WRITE message
> > > to daemon (like we do for direct I/O path). This will keep write and
> > > i_size change atomic w.r.t crash.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
> > > Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
> > > ---
> > >  fs/fuse/file.c            | 597 +++++++++++++++++++++++++++++++++++++-
> > >  fs/fuse/fuse_i.h          |  23 ++
> > >  fs/fuse/inode.c           |   6 +
> > >  include/uapi/linux/fuse.h |   1 +
> > >  4 files changed, 621 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 9d67b830fb7a..9effdd3dc6d6 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -18,6 +18,12 @@
> > >  #include <linux/swap.h>
> > >  #include <linux/falloc.h>
> > >  #include <linux/uio.h>
> > > +#include <linux/dax.h>
> > > +#include <linux/iomap.h>
> > > +#include <linux/interval_tree_generic.h>
> > > +
> > > +INTERVAL_TREE_DEFINE(struct fuse_dax_mapping, rb, __u64, __subtree_last,
> > > +                     START, LAST, static inline, fuse_dax_interval_tree);
> >
> > Are you using this because of byte ranges (u64)?   Does it not make
> > more sense to use page offsets, which are unsigned long and so fit
> > nicely into the generic interval tree?
>
> I think I should be able to use generic interval tree. I will switch
> to that.
>
> [..]
> > > +/* offset passed in should be aligned to FUSE_DAX_MEM_RANGE_SZ */
> > > +static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
> > > +                                 struct fuse_dax_mapping *dmap, bool writable,
> > > +                                 bool upgrade)
> > > +{
> > > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > > +       struct fuse_setupmapping_in inarg;
> > > +       FUSE_ARGS(args);
> > > +       ssize_t err;
> > > +
> > > +       WARN_ON(offset % FUSE_DAX_MEM_RANGE_SZ);
> > > +       WARN_ON(fc->nr_free_ranges < 0);
> > > +
> > > +       /* Ask fuse daemon to setup mapping */
> > > +       memset(&inarg, 0, sizeof(inarg));
> > > +       inarg.foffset = offset;
> > > +       inarg.fh = -1;
> > > +       inarg.moffset = dmap->window_offset;
> > > +       inarg.len = FUSE_DAX_MEM_RANGE_SZ;
> > > +       inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
> > > +       if (writable)
> > > +               inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
> > > +       args.opcode = FUSE_SETUPMAPPING;
> > > +       args.nodeid = fi->nodeid;
> > > +       args.in_numargs = 1;
> > > +       args.in_args[0].size = sizeof(inarg);
> > > +       args.in_args[0].value = &inarg;
> >
> > args.force = true?
>
> I can do that but I am not sure what exactly does args.force do and
> why do we need it in this case.

Hm, it prevents interrupts.  Looking closely, however it will only
prevent SIGKILL from immediately interrupting the request, otherwise
it will send an INTERRUPT request and the filesystem can ignore that.
Might make sense to have a args.nonint flag to prevent the sending of
INTERRUPT...

> First thing it does is that request is allocated with flag __GFP_NOFAIL.
> Second thing it does is that caller is forced to wait for request
> completion and its not an interruptible sleep.
>
> I am wondering what makes FUSE_SETUPMAPING/FUSE_REMOVEMAPPING requests
> special that we need to set force flag.

Maybe not for SETUPMAPPING (I was confused by the error log).

However if REMOVEMAPPING fails for some reason, than that dax mapping
will be leaked for the lifetime of the filesystem.   Or am I
misunderstanding it?

> > > +       ret = fuse_setup_one_mapping(inode,
> > > +                                    ALIGN_DOWN(pos, FUSE_DAX_MEM_RANGE_SZ),
> > > +                                    dmap, true, true);
> > > +       if (ret < 0) {
> > > +               printk("fuse_setup_one_mapping() failed. err=%d pos=0x%llx\n",
> > > +                      ret, pos);
> >
> > Again.
>
> Will remove. How about converting some of them to pr_debug() instead? It
> can help with debugging if something is not working.

Okay, and please move it to fuse_setup_one_mapping() where there's
already a pr_debug() for the success case.

 > > +
> > > +       /* Do not use dax for file extending writes as its an mmap and
> > > +        * trying to write beyong end of existing page will generate
> > > +        * SIGBUS.
> >
> > Ah, here it is.  So what happens in case of a race?  Does that
> > currently crash KVM?
>
> In case of race, yes, KVM hangs. So no shared directory operation yet
> till we have designed proper error handling in kvm path.

I think before this is merged we have to fix the KVM crash; that's not
acceptable even if we explicitly say that shared directory is not
supported for the time being.

Thanks,
Miklos
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
