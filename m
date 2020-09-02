Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566D25A555
	for <lists+linux-nvdimm@lfdr.de>; Wed,  2 Sep 2020 08:07:11 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8512813A642B6;
	Tue,  1 Sep 2020 23:07:09 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=song@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 09FE312FFDA97
	for <linux-nvdimm@lists.01.org>; Tue,  1 Sep 2020 23:07:07 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 763472087D
	for <linux-nvdimm@lists.01.org>; Wed,  2 Sep 2020 06:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599026826;
	bh=5+KmkwCh74/cntArpz/UMLM/pddG8ulQKVSpeB3X+RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cTkF1377EKFMiKH243aPvnk5sDiPB+mAJ8UbjY3H3CxHW3ub6AhJm8zB6sjCeyjos
	 0Zb34r3LG95586+asqAax7/k2wV4jNsfLjOB7nVyJnDD7czJn3t7iganE4hOlIZPud
	 bwrsx4majAT2w7kFdtUeFxc30f6s6TlOONSSdwLw=
Received: by mail-lj1-f177.google.com with SMTP id y4so4408802ljk.8
        for <linux-nvdimm@lists.01.org>; Tue, 01 Sep 2020 23:07:06 -0700 (PDT)
X-Gm-Message-State: AOAM5318xlqMzFLQ1TowOw70D5IjU/Z5zm0WUqaeEJA33/+Oss0pw33e
	OkrcS/SQFbbFz8M2IiVfXzeRjlJ6RbXYZc2RJmo=
X-Google-Smtp-Source: ABdhPJyE5jGOrYyZE6ORaRQIp51/fhLfZD64Ax0jpOVcS4L2G+U2YIU+6jbqUjHlXVyGhP2izG2P3ekqYZd5wXuophY=
X-Received: by 2002:a2e:81c2:: with SMTP id s2mr2472465ljg.10.1599026824658;
 Tue, 01 Sep 2020 23:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200901155748.2884-1-hch@lst.de> <20200901155748.2884-5-hch@lst.de>
In-Reply-To: <20200901155748.2884-5-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Tue, 1 Sep 2020 23:06:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-nfKQK_178R-Y+ps6KLNMrwvWe0Rh5=M1-xvcKHYTgg@mail.gmail.com>
Message-ID: <CAPhsuW5-nfKQK_178R-Y+ps6KLNMrwvWe0Rh5=M1-xvcKHYTgg@mail.gmail.com>
Subject: Re: [PATCH 4/9] block: add a new revalidate_disk_size helper
To: Christoph Hellwig <hch@lst.de>
Message-ID-Hash: OD7KVESOVTSY2MP2MRNN7ECM64CNE6NC
X-Message-ID-Hash: OD7KVESOVTSY2MP2MRNN7ECM64CNE6NC
X-MailFrom: song@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, dm-devel@redhat.com, open list <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org, nbd@other.debian.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid <linux-raid@vger.kernel.org>, linux-nvdimm@lists.01.org, linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OD7KVESOVTSY2MP2MRNN7ECM64CNE6NC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Sep 1, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
[...]

>  drivers/md/md-cluster.c       |  6 ++---
>  drivers/md/md-linear.c        |  2 +-
>  drivers/md/md.c               | 10 ++++-----

For md bits:
Acked-by: Song Liu <song@kernel.org>

[...]
>
> +/**
> + * revalidate_disk_size - checks for disk size change and adjusts bdev size.
> + * @disk: struct gendisk to check
> + * @verbose: if %true log a message about a size change if there is any
> + *
> + * This routine checks to see if the bdev size does not match the disk size
> + * and adjusts it if it differs. When shrinking the bdev size, its all caches
> + * are freed.
> + */
> +void revalidate_disk_size(struct gendisk *disk, bool verbose)
> +{
> +       struct block_device *bdev;
> +
> +       /*
> +        * Hidden disks don't have associated bdev so there's no point in
> +        * revalidating them.
> +        */
> +       if (disk->flags & GENHD_FL_HIDDEN)
> +               return;
> +
> +       bdev = bdget_disk(disk, 0);
> +       if (bdev) {
> +               check_disk_size_change(disk, bdev, verbose);
> +               bdput(bdev);
> +       }
> +}
> +EXPORT_SYMBOL(revalidate_disk_size);

Shall we use EXPORT_SYMBOL_GPL() here?

[...]
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
