Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE891319E9
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Jun 2019 08:29:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B54D212909F9;
	Fri, 31 May 2019 23:29:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 11A2D211FB8AF
 for <linux-nvdimm@lists.01.org>; Fri, 31 May 2019 23:29:08 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i2so10437059otr.9
 for <linux-nvdimm@lists.01.org>; Fri, 31 May 2019 23:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pvQK6WJG0mGv3pVSu5OSYb8LqyE3fhcFrJhciECSYJY=;
 b=zAq3dmDcYmDOFRGWPRho3n9VwHtS/ms4RxAtlrWfGP6kzMscluGhAO/pUa4TA+4EUS
 O0/4V2wR9qZcVx3qMS3QoB+HAQeLd2d2CDwsDN1N3DBbRKcGdR7bB+bQJPhBtO5qBBD8
 qYtkmlkUSEKMjZ50q7KpWOF2nJop+rQTGA+KOkHdzHd+G7A7NpsAwm9za6+lD17Xpadt
 bBwCs0HFc6tNdDL6uOqSRQ+UbMp0iEmi4VLXhjbg/8iQ6ZYHFac4FNgAxARif9GzMuH6
 t9gOCBA01URioVkiQ14oCPcK7W+RxbSIJNNYh1f11vuThMbN9aOLBPGBjStFZqhbk42U
 MHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pvQK6WJG0mGv3pVSu5OSYb8LqyE3fhcFrJhciECSYJY=;
 b=psSBdSIR2ygAH3sVAcD1akYUzs3vhOLYJ+wx0p9pw+IpRcXJy8q3GZzo1NpzbGUA7Y
 fXgI5rObw4z0sYatxDBFbtLihsZtLAWa81OFyyB1KTqvOTnrM5Jayaw2jRY1oXMTQS9f
 9bRKh+98bT8F5onE3WPszhsJj+bPEVVbgZjv45eEgeMI0X1MCQxlyFNa/7uWiYvC5LCU
 MR3hq5XoCV8GmO5hH90+WmkvC34C+x204qKu2fl2Jd9jYo3Tt5kksvDR7pvPIQScnIGY
 D8wJE3Pl4erChu+/0SAIVhm9rgRP3gURDkJqP9xkLzyUxxCDM2vbGYPDcbkels4xcsB7
 VAvw==
X-Gm-Message-State: APjAAAUJVQxDL/iqUO1B3NVQlSflZfHjd/+23BlillgZlZ/Zh3S5jufV
 ZmRfj6xaVPfkmiJgxW1hrG5LOvDbwqaxcg7AK0S3pw==
X-Google-Smtp-Source: APXvYqxuwOV4rRKEmSZCq5qcwBRWuusFc8LtQ4tAccMQn0kPo+oROMhcV0mbfJCQAHkg4BYqbZdyRhVUU/uCtJ3RX78=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr4259219otn.247.1559370547538; 
 Fri, 31 May 2019 23:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133713.31653-1-pagupta@redhat.com>
 <20190521133713.31653-5-pagupta@redhat.com>
In-Reply-To: <20190521133713.31653-5-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 31 May 2019 23:28:56 -0700
Message-ID: <CAPcyv4iW-UeHBs+qSii2Pk7Q2Nki6imGBTEORuxEAWgEMMp=nA@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] dm: enable synchronous dax
To: Pankaj Gupta <pagupta@redhat.com>
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
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 david <david@fromorbit.com>, Qemu Developers <qemu-devel@nongnu.org>,
 virtualization@lists.linux-foundation.org,
 device-mapper development <dm-devel@redhat.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, jstaron@google.com,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 Adam Borowski <kilobyte@angband.pl>, Randy Dunlap <rdunlap@infradead.org>,
 Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Nitesh Narayan Lal <nilal@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Mike Snitzer <snitzer@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 21, 2019 at 6:43 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>  This patch sets dax device 'DAXDEV_SYNC' flag if all the target
>  devices of device mapper support synchrononous DAX. If device
>  mapper consists of both synchronous and asynchronous dax devices,
>  we don't set 'DAXDEV_SYNC' flag.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/md/dm-table.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index cde3b49b2a91..1cce626ff576 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -886,10 +886,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>         return bdev_dax_supported(dev->bdev, PAGE_SIZE);
>  }
>
> +static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
> +                              sector_t start, sector_t len, void *data)
> +{
> +       return dax_synchronous(dev->dax_dev);
> +}
> +
>  static bool dm_table_supports_dax(struct dm_table *t)
>  {
>         struct dm_target *ti;
>         unsigned i;
> +       bool dax_sync = true;
>
>         /* Ensure that all targets support DAX. */
>         for (i = 0; i < dm_table_get_num_targets(t); i++) {
> @@ -901,7 +908,14 @@ static bool dm_table_supports_dax(struct dm_table *t)
>                 if (!ti->type->iterate_devices ||
>                     !ti->type->iterate_devices(ti, device_supports_dax, NULL))
>                         return false;
> +
> +               /* Check devices support synchronous DAX */
> +               if (dax_sync &&
> +                   !ti->type->iterate_devices(ti, device_synchronous, NULL))
> +                       dax_sync = false;

Looks like this needs to be rebased on the current state of v5.2-rc,
and then we can nudge Mike for an ack.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
