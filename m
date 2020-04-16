Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97CF1AD013
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 21:05:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 499F7100DCB7F;
	Thu, 16 Apr 2020 12:05:44 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=207.211.31.120; helo=us-smtp-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [207.211.31.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AEB7C100DCB7C
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 12:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1587063919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LcO8LGSRLpNBRQkWwHdMf9RGdRa86XKrk2exP8zF5vE=;
	b=Wv0HaS3jjHKnJ4Q0Mclt6SZwpx4zwrhGZOuFUNwEWrgMh48i/i+mb9GHbDxKwzt/RzpDgS
	kDrDmQ/snKp99PFk2cQc2u+C7FpsNlikYVfxPalZU+HamhtYbsu9njEtwkzdq1XmyJLzE5
	vH0nh652t+BBCRyEnlc6NFkvvdhw2pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-6Ukn1W4mMRGW_C6M9lssZQ-1; Thu, 16 Apr 2020 15:05:17 -0400
X-MC-Unique: 6Ukn1W4mMRGW_C6M9lssZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B336107ACCC;
	Thu, 16 Apr 2020 19:05:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-15.rdu2.redhat.com [10.10.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B10E10027C3;
	Thu, 16 Apr 2020 19:05:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 4C979220537; Thu, 16 Apr 2020 15:05:07 -0400 (EDT)
Date: Thu, 16 Apr 2020 15:05:07 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200416190507.GC276932@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200326000904.GA34937@rsjd01523.et2sqa>
 <20200327140114.GB32717@redhat.com>
 <20200327220606.GA119028@rsjd01523.et2sqa>
 <20200414193045.GB210453@redhat.com>
 <20200415172229.GA121484@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200415172229.GA121484@rsjd01523.et2sqa>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Message-ID-Hash: JNPCT223AV2ZXLQDSG5J3QATPO2M5T5P
X-Message-ID-Hash: JNPCT223AV2ZXLQDSG5J3QATPO2M5T5P
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JNPCT223AV2ZXLQDSG5J3QATPO2M5T5P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Apr 16, 2020 at 01:22:29AM +0800, Liu Bo wrote:
> On Tue, Apr 14, 2020 at 03:30:45PM -0400, Vivek Goyal wrote:
> > On Sat, Mar 28, 2020 at 06:06:06AM +0800, Liu Bo wrote:
> > > On Fri, Mar 27, 2020 at 10:01:14AM -0400, Vivek Goyal wrote:
> > > > On Thu, Mar 26, 2020 at 08:09:05AM +0800, Liu Bo wrote:
> > > > 
> > > > [..]
> > > > > > +/*
> > > > > > + * Find first mapping in the tree and free it and return it. Do not add
> > > > > > + * it back to free pool. If fault == true, this function should be called
> > > > > > + * with fi->i_mmap_sem held.
> > > > > > + */
> > > > > > +static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> > > > > > +							 struct inode *inode,
> > > > > > +							 bool fault)
> > > > > > +{
> > > > > > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > > > > > +	struct fuse_dax_mapping *dmap;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	if (!fault)
> > > > > > +		down_write(&fi->i_mmap_sem);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Make sure there are no references to inode pages using
> > > > > > +	 * get_user_pages()
> > > > > > +	 */
> > > > > > +	ret = fuse_break_dax_layouts(inode, 0, 0);
> > > > > 
> > > > > Hi Vivek,
> > > > > 
> > > > > This patch is enabling inline reclaim for fault path, but fault path
> > > > > has already holds a locked exceptional entry which I believe the above
> > > > > fuse_break_dax_layouts() needs to wait for, can you please elaborate
> > > > > on how this can be avoided?
> > > > > 
> > > > 
> > > > Hi Liubo,
> > > > 
> > > > Can you please point to the exact lock you are referring to. I will
> > > > check it out. Once we got rid of needing to take inode lock in
> > > > reclaim path, that opended the door to do inline reclaim in fault
> > > > path as well. But I was not aware of this exceptional entry lock.
> > > 
> > > Hi Vivek,
> > > 
> > > dax_iomap_{pte,pmd}_fault has called grab_mapping_entry to get a
> > > locked entry, when this fault gets into inline reclaim, would
> > > fuse_break_dax_layouts wait for the locked exceptional entry which is
> > > locked in dax_iomap_{pte,pmd}_fault?
> > 
> > Hi Liu Bo,
> > 
> > This is a good point. Indeed it can deadlock the way code is written
> > currently.
> >
> 
> It's 100% reproducible on 4.19, but not on 5.x which has xarray for
> dax_layout_busy_page.
> 
> It was weird that on 5.x kernel the deadlock is gone, it turned out
> that xarray search in dax_layout_busy_page simply skips the empty
> locked exceptional entry, I didn't get deeper to find out whether it's
> reasonable, but with that 5.x doesn't run to deadlock.

I found more problems with enabling inline reclaim in fault path. I
am holding fi->i_mmap_sem, shared and fuse_break_dax_layouts() can
drop fi->i_mmap_sem if page is busy. I don't think we can drop and
reacquire fi->i_mmap_sem while in fault path.

Also fuse_break_dax_layouts() does not know if we are holding it
shared or exclusive.

So I will probably have to go back to disable inline reclaim in
fault path. If memory range is not available go back up in
fuse_dax_fault(), drop fi->i_mmap_sem lock and wait on wait queue for
a range to become free and retry.

I can retain the changes I did to break layout for a 2MB range only
and not the whole file. I think that's a good optimization to retain
anyway.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
