Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A629945C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 14:59:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8B61620213F33;
	Thu, 22 Aug 2019 06:00:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A13B120213F08
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 06:00:36 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C3EE18C4261;
 Thu, 22 Aug 2019 12:59:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 406585D772;
 Thu, 22 Aug 2019 12:59:28 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id C5CFA223CFC; Thu, 22 Aug 2019 08:59:27 -0400 (EDT)
Date: Thu, 22 Aug 2019 08:59:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 11/19] fuse, dax: Implement dax read/write operations
Message-ID: <20190822125927.GA8999@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
 <20190821175720.25901-12-vgoyal@redhat.com>
 <20190821194934.rqswgc52juisunl2@US-160370MP2.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190821194934.rqswgc52juisunl2@US-160370MP2.local>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 22 Aug 2019 12:59:33 +0000 (UTC)
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
Cc: Miklos Szeredi <mszeredi@redhat.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 miklos@szeredi.hu, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 dgilbert@redhat.com, virtio-fs@redhat.com, stefanha@redhat.com,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 21, 2019 at 12:49:34PM -0700, Liu Bo wrote:

[..]
> > +static int iomap_begin_upgrade_mapping(struct inode *inode, loff_t pos,
> > +					 loff_t length, unsigned flags,
> > +					 struct iomap *iomap)
> > +{
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct fuse_dax_mapping *dmap;
> > +	int ret;
> > +
> > +	/*
> > +	 * Take exclusive lock so that only one caller can try to setup
> > +	 * mapping and others wait.
> > +	 */
> > +	down_write(&fi->i_dmap_sem);
> > +	dmap = fuse_dax_interval_tree_iter_first(&fi->dmap_tree, pos, pos);
> > +
> > +	/* We are holding either inode lock or i_mmap_sem, and that should
> > +	 * ensure that dmap can't reclaimed or truncated and it should still
> > +	 * be there in tree despite the fact we dropped and re-acquired the
> > +	 * lock.
> > +	 */
> > +	ret = -EIO;
> > +	if (WARN_ON(!dmap))
> > +		goto out_err;
> > +
> > +	/* Maybe another thread already upgraded mapping while we were not
> > +	 * holding lock.
> > +	 */
> > +	if (dmap->writable)
> > +		goto out_fill_iomap;
> 
> @ret needs to be reset here.
> 

Good catch. Will fix it.

Vivek
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
