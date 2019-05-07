Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297CF166EE
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 17:37:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5C29121255836;
	Tue,  7 May 2019 08:37:14 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3ABF5212449F8
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 08:37:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u3so9899987otq.4
 for <linux-nvdimm@lists.01.org>; Tue, 07 May 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
 b=1RDaQiep4r+5NZ7RO5zftr0FnsMUZwAyLWkMBkR9iTDOBSIJayhPK4u9DWG7+9yxpt
 9FJnbG3lrhIL0LedEM5ytUIEEGfVVBYdsCV16Q3ZevH87Y7p3IJljktvzFGtbrtOW9jV
 qgMeHUIAfkrXfVgCh+wJIUgLwx8HPs0Hso14g3nE34tG3uE5Kaf93v1albOqeZ8FtzEo
 MRnNU+jjU7Bd7Hg2HKOClTmC45crVs8w8TurxKr/6z1WENdYw/y//CLDQEQmIA9Rf7i+
 OKLRLxxsnQvga0Mn1E5gFobavHOZ9OlvYblRdklzqgaUM3FSIzUzMZWnI38rOf5/Ueyc
 SI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6dOaY+uD9DJjErKzQ4lbx3sa2d0JDi7CHezoB5wTbvY=;
 b=DrhPbbuf18ityMagpyvEA05XmU+9MPa1lhfbAEnGHjX16tYYLFfkRbR9O+hTRd9tMJ
 BdcQHRwRfSTRV6fQ4rPlg66i0ihkN2p78nDcPXJfxB9XLI+yreXfmNLyzsz17HjpUVj1
 6xGwHN6F94TpX6EnW93EP26YW7blXPY/Jnt3gcsJiTxbPAO/pUDmNAll+bPkytM95nFE
 fnp5kNnv03qVP7c7bTxO50QF7lfXtobHtmfgAQnfe0kEAEESJV+NlRNYRQu0c9MApsJp
 bKn9uC6WylPwBAStnmloT0Y+LApOGOQMdrLipJ5P5QkZc0yLuBhui/49W5cDXfT89jqf
 T2Qg==
X-Gm-Message-State: APjAAAXypEQu8GR8LxHWbNjJviLpG1S+ivjc6Y9MkwQeFrvFqEK5Z+lD
 pNQE+3BgclOttWeQUqLbdOv/Ob5cYpfi2rbPMi3kaTxT
X-Google-Smtp-Source: APXvYqxbxERKNtTaVpMxD9jAh6w8zsl3plIje9NPoM99XF0whcoJ/rqAndFua0o+8QlJA2fPNaeXZRcDVPm+ejCVDvk=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22019501ota.353.1557243432435; 
 Tue, 07 May 2019 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com>
 <20190426050039.17460-7-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-7-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 May 2019 08:37:01 -0700
Message-ID: <CAPcyv4hCP4E4xPkQx25tqhznon6ADwrYJB1yujkrO-A7LUnsmg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] xfs: disable map_sync for async flush
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
 Andreas Dilger <adilger.kernel@dilger.ca>, Ross Zwisler <zwisler@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Len Brown <lenb@kernel.org>,
 kilobyte@angband.pl, Rik van Riel <riel@surriel.com>,
 yuval shaia <yuval.shaia@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
 Theodore Ts'o <tytso@mit.edu>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Apr 25, 2019 at 10:03 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> Dont support 'MAP_SYNC' with non-DAX files and DAX files
> with asynchronous dax_device. Virtio pmem provides
> asynchronous host page cache flush mechanism. We don't
> support 'MAP_SYNC' with virtio pmem and xfs.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Darrick, does this look ok to take through the nvdimm tree?

>
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index a7ceae90110e..f17652cca5ff 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1203,11 +1203,14 @@ xfs_file_mmap(
>         struct file     *filp,
>         struct vm_area_struct *vma)
>  {
> +       struct dax_device       *dax_dev;
> +
> +       dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
>         /*
> -        * We don't support synchronous mappings for non-DAX files. At least
> -        * until someone comes with a sensible use case.
> +        * We don't support synchronous mappings for non-DAX files and
> +        * for DAX files if underneath dax_device is not synchronous.
>          */
> -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> +       if (!daxdev_mapping_supported(vma, dax_dev))
>                 return -EOPNOTSUPP;
>
>         file_accessed(filp);
> --
> 2.20.1
>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
