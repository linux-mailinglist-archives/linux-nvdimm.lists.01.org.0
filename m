Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93298325C6B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 05:14:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E046F100EC1E9;
	Thu, 25 Feb 2021 20:14:48 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=djwong@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8A90100EC1CC
	for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 20:14:46 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9227864EDC;
	Fri, 26 Feb 2021 04:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1614312885;
	bh=sgWuxqBTz4uJmSaPMNWjznkck8E4uzq3eRWOtth4/Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaKlhVvbTBQ10wmdG8lJGORHMFm7ED+I2ZQh6j3TMj5vcfdLDA91LE6NAJU6sYUAQ
	 PLQ/fdnQyVxpFDdaGoY8MBdg+9xQznfx/6tHoJIAPnTa5XymqVuRDgGDR9woUdGIt1
	 qR9bvxbSIdjDrVgZMmBG3RdSwbrzz2s14VpCvmDDxQir6273b544lhaey0J9JohhGF
	 /F9PfucDLwp+H/egWwJ0jCumTfHCKrfrAlR7rN1QEeK4gDR++yhSE51klT4tcnTvSp
	 QGkqBbHSLvEQYMwJNM9436fxTtc2kUqBJVmlSHPW//XR7cYfGQxa9nqGz78tOJbvah
	 n5IabVC/GXYtw==
Date: Thu, 25 Feb 2021 20:14:46 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v2 07/10] iomap: Introduce iomap_apply2() for operations
 on two files
Message-ID: <20210226041446.GV7272@magnolia>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <20210226002030.653855-8-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-8-ruansy.fnst@fujitsu.com>
Message-ID-Hash: OG2SOD7AXIE6UOTWJPSC6ULEPZYEMHXT
X-Message-ID-Hash: OG2SOD7AXIE6UOTWJPSC6ULEPZYEMHXT
X-MailFrom: djwong@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OG2SOD7AXIE6UOTWJPSC6ULEPZYEMHXT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 08:20:27AM +0800, Shiyang Ruan wrote:
> Some operations, such as comparing a range of data in two files under
> fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
> we introduce iomap_apply2() to accept arguments from two files and
> iomap_actor2_t for actions on two files.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/iomap/apply.c      | 51 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iomap.h |  7 +++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 26ab6563181f..fd2f8bde5791 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -97,3 +97,54 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>  
>  	return written ? written : ret;
>  }
> +
> +loff_t
> +iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
> +		loff_t length, unsigned int flags, const struct iomap_ops *ops,
> +		void *data, iomap_actor2_t actor)
> +{
> +	struct iomap smap = { .type = IOMAP_HOLE };
> +	struct iomap dmap = { .type = IOMAP_HOLE };
> +	loff_t written = 0, ret;
> +
> +	ret = ops->iomap_begin(ino1, pos1, length, 0, &smap, NULL);
> +	if (ret)
> +		goto out_src;
> +	if (WARN_ON(smap.offset > pos1)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +	if (WARN_ON(smap.length == 0)) {
> +		written = -EIO;
> +		goto out_src;
> +	}
> +
> +	ret = ops->iomap_begin(ino2, pos2, length, 0, &dmap, NULL);
> +	if (ret)
> +		goto out_dest;
> +	if (WARN_ON(dmap.offset > pos2)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +	if (WARN_ON(dmap.length == 0)) {
> +		written = -EIO;
> +		goto out_dest;
> +	}
> +
> +	/* make sure extent length of two file is equal */
> +	if (WARN_ON(smap.length != dmap.length)) {

Why not set smap.length and dmap.length to min(smap.length, dmap.length) ?

--D

> +		written = -EIO;
> +		goto out_dest;
> +	}
> +
> +	written = actor(ino1, pos1, ino2, pos2, length, data, &smap, &dmap);
> +
> +out_dest:
> +	if (ops->iomap_end)
> +		ret = ops->iomap_end(ino2, pos2, length, 0, 0, &dmap);
> +out_src:
> +	if (ops->iomap_end)
> +		ret = ops->iomap_end(ino1, pos1, length, 0, 0, &smap);
> +
> +	return ret;
> +}
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 5bd3cac4df9c..913f98897a77 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -148,10 +148,15 @@ struct iomap_ops {
>   */
>  typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
>  		void *data, struct iomap *iomap, struct iomap *srcmap);
> -
> +typedef loff_t (*iomap_actor2_t)(struct inode *ino1, loff_t pos1,
> +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> +		struct iomap *smap, struct iomap *dmap);
>  loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
>  		unsigned flags, const struct iomap_ops *ops, void *data,
>  		iomap_actor_t actor);
> +loff_t iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2,
> +		loff_t pos2, loff_t length, unsigned int flags,
> +		const struct iomap_ops *ops, void *data, iomap_actor2_t actor);
>  
>  ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
>  		const struct iomap_ops *ops);
> -- 
> 2.30.1
> 
> 
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
