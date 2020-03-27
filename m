Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E474E195878
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 15:01:33 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F31D10FC3BA9;
	Fri, 27 Mar 2020 07:02:22 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.74; helo=us-smtp-delivery-74.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [63.128.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61B0C10FC3624
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1585317687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nmGn2iu/6hb//kS/DiygB1sR/c0YTQN3IceTCMDHJQI=;
	b=P7hqw9fYxamwMPG7PmB/s2DWPm0P50WwyyUZY0L7xjgKwHGn5ukU1Fv+l6/5wVtf1vuUHW
	W8AnMjkKwScpxTWOkZQ6b+fqMU+xSnQi/Sy+n4gzkxvL8pczu+Xy+1y8T3sOH/yt4lnakA
	sn7OvQJq3UI6YeQludZAq2f5bzgAmRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-IhFdegswPqOnvQl_xs_QBQ-1; Fri, 27 Mar 2020 10:01:25 -0400
X-MC-Unique: IhFdegswPqOnvQl_xs_QBQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331DC8018AB;
	Fri, 27 Mar 2020 14:01:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-99.rdu2.redhat.com [10.10.117.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 05F425DA81;
	Fri, 27 Mar 2020 14:01:14 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 3255B222D9D; Fri, 27 Mar 2020 10:01:14 -0400 (EDT)
Date: Fri, 27 Mar 2020 10:01:14 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 20/20] fuse,virtiofs: Add logic to free up a memory range
Message-ID: <20200327140114.GB32717@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
 <20200304165845.3081-21-vgoyal@redhat.com>
 <20200326000904.GA34937@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200326000904.GA34937@rsjd01523.et2sqa>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Message-ID-Hash: SMPDWSVAN2M5UOQ5ZJA3ZFCHZ3URCQQX
X-Message-ID-Hash: SMPDWSVAN2M5UOQ5ZJA3ZFCHZ3URCQQX
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMPDWSVAN2M5UOQ5ZJA3ZFCHZ3URCQQX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 26, 2020 at 08:09:05AM +0800, Liu Bo wrote:

[..]
> > +/*
> > + * Find first mapping in the tree and free it and return it. Do not add
> > + * it back to free pool. If fault == true, this function should be called
> > + * with fi->i_mmap_sem held.
> > + */
> > +static struct fuse_dax_mapping *inode_reclaim_one_dmap(struct fuse_conn *fc,
> > +							 struct inode *inode,
> > +							 bool fault)
> > +{
> > +	struct fuse_inode *fi = get_fuse_inode(inode);
> > +	struct fuse_dax_mapping *dmap;
> > +	int ret;
> > +
> > +	if (!fault)
> > +		down_write(&fi->i_mmap_sem);
> > +
> > +	/*
> > +	 * Make sure there are no references to inode pages using
> > +	 * get_user_pages()
> > +	 */
> > +	ret = fuse_break_dax_layouts(inode, 0, 0);
> 
> Hi Vivek,
> 
> This patch is enabling inline reclaim for fault path, but fault path
> has already holds a locked exceptional entry which I believe the above
> fuse_break_dax_layouts() needs to wait for, can you please elaborate
> on how this can be avoided?
> 

Hi Liubo,

Can you please point to the exact lock you are referring to. I will
check it out. Once we got rid of needing to take inode lock in
reclaim path, that opended the door to do inline reclaim in fault
path as well. But I was not aware of this exceptional entry lock.

Vivek
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
