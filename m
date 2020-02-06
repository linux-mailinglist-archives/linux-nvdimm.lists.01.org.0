Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA591540B6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Feb 2020 09:55:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EFDB910FC3403;
	Thu,  6 Feb 2020 00:58:59 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DCC410FC3401
	for <linux-nvdimm@lists.01.org>; Thu,  6 Feb 2020 00:58:57 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 074ECAD55;
	Thu,  6 Feb 2020 08:55:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 521681E0E31; Thu,  6 Feb 2020 09:47:40 +0100 (CET)
Date: Thu, 6 Feb 2020 09:47:40 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
Message-ID: <20200206084740.GE14001@quack2.suse.cz>
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 6NS5PHLGTWH57K3WGU4O6O2QW6VLZO3N
X-Message-ID-Hash: 6NS5PHLGTWH57K3WGU4O6O2QW6VLZO3N
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, willy@infradead.org, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6NS5PHLGTWH57K3WGU4O6O2QW6VLZO3N/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed 05-02-20 14:15:58, Jeff Moyer wrote:
> fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> dax".  The reason is that the initial pwrite to an empty file with the
> RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> dax_iomap_rw doesn't pass that flag through to iomap_apply.
> 
> With this patch applied, generic/471 passes for me.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I've just noticed ext4 seems to be buggy in this regard and even this
patch doesn't fix it. So I guess you've been using XFS for testing this?

									Honza

> diff --git a/fs/dax.c b/fs/dax.c
> index 1f1f0201cad1..0b0d8819cb1b 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1207,6 +1207,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		lockdep_assert_held(&inode->i_rwsem);
>  	}
>  
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		flags |= IOMAP_NOWAIT;
> +
>  	while (iov_iter_count(iter)) {
>  		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
>  				iter, dax_iomap_actor);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
