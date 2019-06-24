Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6D50340
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Jun 2019 09:25:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30C9921296701;
	Mon, 24 Jun 2019 00:25:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=miklos@szeredi.hu; receiver=linux-nvdimm@lists.01.org 
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 589FD21296413
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 00:25:12 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so842405ior.9
 for <linux-nvdimm@lists.01.org>; Mon, 24 Jun 2019 00:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szeredi.hu; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d06Pia/4lguTSyfVaEUkJGeGzpj48WO3rGAQAMd0JI0=;
 b=rJKBNWS/CBTy5/iFxgr+p/i6UK2GzCu06m4babw4ksvR9H8XBN7Jz7JwzofgpjmuTs
 Bk+7hgADEaxcUjCveN8zvoIz5AJPfaxQPdn9xY8iwK3UphdlI9FOxUvbGouCd3mgAZi0
 A+jX5TEKN6abHFboRaB9AbJwa8n/jXJPoHd7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d06Pia/4lguTSyfVaEUkJGeGzpj48WO3rGAQAMd0JI0=;
 b=l3AIWtKRcVFUW2uBLO7fUlmKTvCfoGnmPREXJiAuf8z9iH2SRpy4OPz78smihodsTD
 RlgITDnu4zZEUSuPdOKX5rdFt7+GDAoZdOxeS4v/pke1V4mWuZUQ0pYM4sU+ekBWvxh2
 h4mFwNvgGL978b9XeqvEPvWzngdAO9hxqqgz+Gy0aUBbXxbbpeyhG3whZ6FaTI6KChuh
 V/5+fBllRnAlcrs6b0ssUn/O7sJJcWwrfBsXfPG3LvLqFe6R208LT0evGXc3uw1lmKse
 1JAqXCKeGFgkXzxIrcpqIaaDwTXmQhXTKcvIES7fM3FszFabo/YEUNrayEaHkCoT2nQK
 RUNA==
X-Gm-Message-State: APjAAAWiKwu2lGVutGlRBp1Kr7GHo7PPUe7myoNAf3gg3WwSfAoWg43g
 K/ar8RF/uX4i8ypUo1aMNtqbLwfntryBaiChovZUuw==
X-Google-Smtp-Source: APXvYqzSFVYqgkEMUYRR/hMSf4R0JOiOzdzfQKcoXcpVZ2cUWIBSIsXogNHRPZg/mu51W1Q8ppk6FXK6bX3yJdvx55k=
X-Received: by 2002:a5e:da4b:: with SMTP id o11mr8462865iop.212.1561361111479; 
 Mon, 24 Jun 2019 00:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CANQeFDCCGED3BR0oTpzQ75gtGpdGCw8FLf+kspBYytw3YteXAw@mail.gmail.com>
 <20190620083628.GH13630@quack2.suse.cz>
 <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
In-Reply-To: <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Jun 2019 09:25:00 +0200
Message-ID: <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com>
Subject: Re: a few questions about pagevc_lookup_entries
To: Liu Bo <obuil.liubo@gmail.com>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

[cc: vivek, stefan, dgilbert]

On Fri, Jun 21, 2019 at 12:04 AM Liu Bo <obuil.liubo@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 1:36 AM Jan Kara <jack@suse.cz> wrote:
> >
> > [added some relevant lists to CC - this can safe some people debugging by
> > being able to google this discussion]
> >
> > On Wed 19-06-19 15:57:38, Liu Bo wrote:
> > > I found a weird dead loop within invalidate_inode_pages2_range, the
> > > reason being that  pagevec_lookup_entries(index=1) returns an indices
> > > array which has only one entry storing value 0, and this has led
> > > invalidate_inode_pages2_range() to a dead loop, something like,
> > >
> > > invalidate_inode_pages2_range()
> > >   -> while (pagevec_lookup_entries(index=1, indices))
> > >     ->  for (i = 0; i < pagevec_count(&pvec); i++) {
> > >       -> index = indices[0]; // index is set to 0
> > >       -> if (radix_tree_exceptional_entry(page)) {
> > >           -> if (!invalidate_exceptional_entry2()) //
> > >                   ->__dax_invalidate_mapping_entry // return 0
> > >                      -> // entry marked as PAGECACHE_TAG_DIRTY/TOWRITE
> > >                  ret = -EBUSY;
> > >           ->continue;
> > >           } // end of if (radix_tree_exceptional_entry(page))
> > >     -> index++; // index is set to 1
> > >
> > > The following debug[1] proved the above analysis,  I was wondering if
> > > this was a corner case that  pagevec_lookup_entries() allows or a
> > > known bug that has been fixed upstream?
> > >
> > > ps: the kernel in use is 4.19.30 (LTS).
> >
> > Hum, the above trace suggests you are using DAX. Are you really? Because the
> > stacktrace below shows we are working on fuse inode so that shouldn't
> > really be DAX inode...
> >
>
> So I was running tests against virtiofs[1] which adds dax support to
> fuse, with dax, fuse provides posix stuff while dax provides data
> channel.
>
> [1]: https://virtio-fs.gitlab.io/
> https://gitlab.com/virtio-fs/linux
>
> thanks,
> liubo
>
> >                                                                 Honza
> >
> > > [1]:
> > > $git diff
> > > diff --git a/mm/truncate.c b/mm/truncate.c
> > > index 71b65aab8077..82bfeeb53135 100644
> > > --- a/mm/truncate.c
> > > +++ b/mm/truncate.c
> > > @@ -692,6 +692,7 @@ int invalidate_inode_pages2_range(struct
> > > address_space *mapping,
> > >                         struct page *page = pvec.pages[i];
> > >
> > >                         /* We rely upon deletion not changing page->index */
> > > +                       WARN_ONCE(index > indices[i], "index = %d
> > > indices[%d]=%d\n", index, i, indices[i]);
> > >                         index = indices[i];
> > >                         if (index > end)
> > >                                 break;
> > >
> > > [  129.095383] ------------[ cut here ]------------
> > > [  129.096164] index = 1 indices[0]=0
> > > [  129.096786] WARNING: CPU: 0 PID: 3022 at mm/truncate.c:695
> > > invalidate_inode_pages2_range+0x471/0x500
> > > [  129.098234] Modules linked in:
> > > [  129.098717] CPU: 0 PID: 3022 Comm: doio Not tainted 4.19.30+ #4
> > > ...
> > > [  129.101288] RIP: 0010:invalidate_inode_pages2_range+0x471/0x500
> > > ...
> > > [  129.114162] Call Trace:
> > > [  129.114623]  ? __schedule+0x2ad/0x860
> > > [  129.115214]  ? prepare_to_wait_event+0x80/0x140
> > > [  129.115903]  ? finish_wait+0x3f/0x80
> > > [  129.116452]  ? request_wait_answer+0x13d/0x210
> > > [  129.117128]  ? remove_wait_queue+0x60/0x60
> > > [  129.117757]  ? make_kgid+0x13/0x20
> > > [  129.118277]  ? fuse_change_attributes_common+0x7d/0x130
> > > [  129.119057]  ? fuse_change_attributes+0x8d/0x120
> > > [  129.119754]  fuse_dentry_revalidate+0x2c5/0x300
> > > [  129.120456]  lookup_fast+0x237/0x2b0
> > > [  129.121018]  path_openat+0x15f/0x1380
> > > [  129.121614]  ? generic_update_time+0x6b/0xd0
> > > [  129.122316]  do_filp_open+0x91/0x100
> > > [  129.122876]  do_sys_open+0x126/0x210
> > > [  129.123453]  do_syscall_64+0x55/0x180
> > > [  129.124036]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  129.124820] RIP: 0033:0x7fbe0cd75e80
> > > ...
> > > [  129.134574] ---[ end trace c0fc0bbc5aebf0dc ]---
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
