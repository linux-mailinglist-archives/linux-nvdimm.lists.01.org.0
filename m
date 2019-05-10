Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51581A05C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 17:41:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C7FE821268FB7;
	Fri, 10 May 2019 08:41:41 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5A51A21C93EDD
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 08:41:38 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g18so5731746otj.11
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ui2zFPB1DYC19lQl11zIEBS4dDuBE0sSmR3AaK+jIn0=;
 b=Xd7Jve/wwg9rBXpWJVmiERkysPDBo4ePhgeoBglu5WVf7aUKOOBKrVzxnk3xLq0xr/
 6Jtqopi12VqLssCwwKL8C5lDjxeFPDs36a3RgBuBHams3EpOBqPUrEFS34ntfNAJ2Wd7
 PjDlZyWysnLd+akFS1hRkooK2NYRDIVlvXrXrZVaXlzGy24TvtXZPf/vZh9POmqJWVpi
 yB5ZbigT4jat3qnXu4F7G57AsCGSUdRbxhf0aftekZipf2BsBT9eKnJiqVNFBsp46rTs
 boLZbqln3lmy1mFwke26mvVHOLmqp7i2dgYckaSysIO5XmtgtBuBckgtGfnjC8l+15nX
 z35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ui2zFPB1DYC19lQl11zIEBS4dDuBE0sSmR3AaK+jIn0=;
 b=IciigV0LI48lAbONYN2e4e6Uw/MPwcE+utQsOk1FcaLUfYEeBBNDu+Rl1WLeb46pbK
 ybnYSWbIsHpZqVS7qZmcERIxpi/bwx38FWu/cbuhglQkHQXe3ICG2IIHH/UAEzfCDl11
 Sc6+O+ut4Ty2rkYPrEhTjoLBIU7pDnaG7eadSQhNVssv8W7piR+HX6iOjo1kl8aCmcLL
 Ckq+TuHVgSQ4hzmuEZYbSg9ZpI457YAigTbHWk2yiwFn6pDHy8wuMLQGMjpjewKao/uL
 HVT/fhYfWb/pdC4MLKgime2xOAb4xtVGn24N9lXYF4+mMxRpZukbLsYWrVcUhFsN4Qza
 B7pA==
X-Gm-Message-State: APjAAAUPsW5g3lM6D01Oarh4m9t2kTTDg1S97b16yVx/F0a3TXd3y4st
 0iLe+8Ugba7ZJqBQ088a8tlitbM94hAMXkAXQ33A5w==
X-Google-Smtp-Source: APXvYqx9GD2D2N7EYWR97IWH0oQh55yLDCabFZoBxeK8iZN4jPseNZXYcKsp8O4O1+YAgTc16rdx2Cf5rBsgV0xZ5bE=
X-Received: by 2002:a9d:7c84:: with SMTP id q4mr1631137otn.98.1557502897461;
 Fri, 10 May 2019 08:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190429172649.8288-13-rgoldwyn@suse.de>
 <20190510153222.24665-1-kilobyte@angband.pl>
In-Reply-To: <20190510153222.24665-1-kilobyte@angband.pl>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 08:41:25 -0700
Message-ID: <CAPcyv4jPF70QECzpgDCwzasJT38eOqG9tfQRbo37OWg+YzGu_w@mail.gmail.com>
Subject: Re: [PATCH for-goldwyn] btrfs: disallow MAP_SYNC outside of DAX mounts
To: Adam Borowski <kilobyte@angband.pl>
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
Cc: Jan Kara <jack@suse.cz>, "Darrick J. Wong" <darrick.wong@oracle.com>,
 nborisov@suse.com, Goldwyn Rodrigues <rgoldwyn@suse.de>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, david <david@fromorbit.com>,
 dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, May 10, 2019 at 8:33 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Even if allocation is done synchronously, data would be lost except on
> actual pmem.  Explicit msync()s don't need MAP_SYNC, and don't require
> a sync per page.
>
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> MAP_SYNC can't be allowed unconditionally, as cacheline flushes don't help
> guarantee persistency in page cache.  This fixes an error in my earlier
> patch "btrfs: allow MAP_SYNC mmap" -- you'd probably want to amend that.
>
>
>  fs/btrfs/file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 362a9cf9dcb2..0bc5428037ba 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2233,6 +2233,13 @@ static int btrfs_file_mmap(struct file   *filp, struct vm_area_struct *vma)
>         if (!IS_DAX(inode) && !mapping->a_ops->readpage)
>                 return -ENOEXEC;
>
> +       /*
> +        * Normal operation of btrfs is pretty much an antithesis of MAP_SYNC;
> +        * supporting it outside DAX is pointless.
> +        */
> +       if (!IS_DAX(inode) && (vma->vm_flags & VM_SYNC))
> +               return -EOPNOTSUPP;
> +

If the virtio-pmem patch set goes upstream prior to btrfs-dax support
this will need to switch over to the new daxdev_mapping_supported()
helper.

https://lore.kernel.org/lkml/20190426050039.17460-5-pagupta@redhat.com/
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
