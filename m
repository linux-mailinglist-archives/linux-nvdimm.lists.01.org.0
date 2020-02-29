Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9B17459B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 09:04:18 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5125E1007B1FD;
	Sat, 29 Feb 2020 00:05:07 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=pankaj.gupta.linux@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8EA881007B1F6
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 00:05:05 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id m10so10978058wmc.0
        for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 00:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5uuuwXmEYzKMQWHoj3FlOv3W0FcMz6JiZ2HkvpHOxlY=;
        b=NHbDra58T/LGoW6ToL2m1yJYHBIA52uz+lA/+D9pJUMdOjW6x42+5vYm6+HsegtKvf
         z4oRg9viu+uCeJocBr1uu54cOt9Ux+7k6yAD28PDK/Uj1YoYX4uU5TzmaODEfvDnYvE8
         T1ekke2cgSGEtV7gKMMk82ltzoWmJIGQ3a9zq6xw5blJeOcVDnteB8DtZqOY/gUKrIhw
         tL+R38Dey9qMSKJmE/6qh4IaJbvycIU1hrEsWShwo+Si+dkGawJYcSwJoIHfeeGaN8mT
         Dx6Ut6tDeCZsT9M03HNyim5y/O1rkBT8U0DxaUqUQ8H+aM7Kse/ArGnDgA7p0zgZ1oIE
         hAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5uuuwXmEYzKMQWHoj3FlOv3W0FcMz6JiZ2HkvpHOxlY=;
        b=ndoFJxMROmeqq0lAO4HBL2CkZnXTGuQ7uZd+7o8zY9umUIPhvtez8BgnZ1n16JG+Qy
         XM+YfBi7H8pBI2MwOLcR88p0QKb6pSz0m8NixVnCYn/vI4s6mFY4ia/A+k/9cGpN1Z0W
         oLNlhFy+ItzamMODGWl5qfoB+9xJDLftmrb02yXiu+xkECo+povOFjiMTOYPC4MEkCBv
         3FOWLIJ2Go2YpfyqFlLdefkCYvumV7byZPaFkMtAwgjZUn5q01dSR1iDSnq6g7VerPpx
         9aaf/BMaWiVVss1SgIpIHRMlXutU+0WBBOz9/cigl0cpz1W9UegsQ7PULgrWGWC+p8V/
         xwEg==
X-Gm-Message-State: APjAAAX33ZBlBi1Zt2GA6kWshMhTpnNX1+bsKmLRpAxi66NIKDWFrfDC
	bEphZhdBkxN2Fhl8CK5pC9YFzZHDQ4S/hQWlUUw=
X-Google-Smtp-Source: APXvYqx0csBzSURuS/yibvzs0QZc0eFRxP0mymsBxYXXWF0i4h66voqBNGDpRg+MOvg+NnwvY7slgvvjgmbCqiyqQpQ=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr9014466wme.30.1582963452149;
 Sat, 29 Feb 2020 00:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20200228163456.1587-1-vgoyal@redhat.com> <20200228163456.1587-2-vgoyal@redhat.com>
In-Reply-To: <20200228163456.1587-2-vgoyal@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Sat, 29 Feb 2020 09:04:00 +0100
Message-ID: <CAM9Jb+gJWH_bC-9fgGdeP5LaSVjJ3JgTnjBxpRJMfe6vbTPOTA@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] pmem: Add functions for reading/writing page
 to/from pmem
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: 4TNND7MA37O2J7RUFYE523774LGUOSYV
X-Message-ID-Hash: 4TNND7MA37O2J7RUFYE523774LGUOSYV
X-MailFrom: pankaj.gupta.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, david@fromorbit.com, dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4TNND7MA37O2J7RUFYE523774LGUOSYV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2020 at 17:35, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This splits pmem_do_bvec() into pmem_do_read() and pmem_do_write().
> pmem_do_write() will be used by pmem zero_page_range() as well. Hence
> sharing the same code.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/nvdimm/pmem.c | 86 +++++++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 4eae441f86c9..075b11682192 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -136,9 +136,25 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
>         return BLK_STS_OK;
>  }
>
> -static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
> -                       unsigned int len, unsigned int off, unsigned int op,
> -                       sector_t sector)
> +static blk_status_t pmem_do_read(struct pmem_device *pmem,
> +                       struct page *page, unsigned int page_off,
> +                       sector_t sector, unsigned int len)
> +{
> +       blk_status_t rc;
> +       phys_addr_t pmem_off = sector * 512 + pmem->data_offset;

minor nit,  maybe 512 is replaced by macro? Looks like its used at multiple
places, maybe can keep at is for now.

> +       void *pmem_addr = pmem->virt_addr + pmem_off;
> +
> +       if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
> +               return BLK_STS_IOERR;
> +
> +       rc = read_pmem(page, page_off, pmem_addr, len);
> +       flush_dcache_page(page);
> +       return rc;
> +}
> +
> +static blk_status_t pmem_do_write(struct pmem_device *pmem,
> +                       struct page *page, unsigned int page_off,
> +                       sector_t sector, unsigned int len)
>  {
>         blk_status_t rc = BLK_STS_OK;
>         bool bad_pmem = false;
> @@ -148,34 +164,25 @@ static blk_status_t pmem_do_bvec(struct pmem_device *pmem, struct page *page,
>         if (unlikely(is_bad_pmem(&pmem->bb, sector, len)))
>                 bad_pmem = true;
>
> -       if (!op_is_write(op)) {
> -               if (unlikely(bad_pmem))
> -                       rc = BLK_STS_IOERR;
> -               else {
> -                       rc = read_pmem(page, off, pmem_addr, len);
> -                       flush_dcache_page(page);
> -               }
> -       } else {
> -               /*
> -                * Note that we write the data both before and after
> -                * clearing poison.  The write before clear poison
> -                * handles situations where the latest written data is
> -                * preserved and the clear poison operation simply marks
> -                * the address range as valid without changing the data.
> -                * In this case application software can assume that an
> -                * interrupted write will either return the new good
> -                * data or an error.
> -                *
> -                * However, if pmem_clear_poison() leaves the data in an
> -                * indeterminate state we need to perform the write
> -                * after clear poison.
> -                */
> -               flush_dcache_page(page);
> -               write_pmem(pmem_addr, page, off, len);
> -               if (unlikely(bad_pmem)) {
> -                       rc = pmem_clear_poison(pmem, pmem_off, len);
> -                       write_pmem(pmem_addr, page, off, len);
> -               }
> +       /*
> +        * Note that we write the data both before and after
> +        * clearing poison.  The write before clear poison
> +        * handles situations where the latest written data is
> +        * preserved and the clear poison operation simply marks
> +        * the address range as valid without changing the data.
> +        * In this case application software can assume that an
> +        * interrupted write will either return the new good
> +        * data or an error.
> +        *
> +        * However, if pmem_clear_poison() leaves the data in an
> +        * indeterminate state we need to perform the write
> +        * after clear poison.
> +        */
> +       flush_dcache_page(page);
> +       write_pmem(pmem_addr, page, page_off, len);
> +       if (unlikely(bad_pmem)) {
> +               rc = pmem_clear_poison(pmem, pmem_off, len);
> +               write_pmem(pmem_addr, page, page_off, len);
>         }
>
>         return rc;
> @@ -197,8 +204,12 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
>
>         do_acct = nd_iostat_start(bio, &start);
>         bio_for_each_segment(bvec, bio, iter) {
> -               rc = pmem_do_bvec(pmem, bvec.bv_page, bvec.bv_len,
> -                               bvec.bv_offset, bio_op(bio), iter.bi_sector);
> +               if (op_is_write(bio_op(bio)))
> +                       rc = pmem_do_write(pmem, bvec.bv_page, bvec.bv_offset,
> +                               iter.bi_sector, bvec.bv_len);
> +               else
> +                       rc = pmem_do_read(pmem, bvec.bv_page, bvec.bv_offset,
> +                               iter.bi_sector, bvec.bv_len);
>                 if (rc) {
>                         bio->bi_status = rc;
>                         break;
> @@ -223,9 +234,12 @@ static int pmem_rw_page(struct block_device *bdev, sector_t sector,
>         struct pmem_device *pmem = bdev->bd_queue->queuedata;
>         blk_status_t rc;
>
> -       rc = pmem_do_bvec(pmem, page, hpage_nr_pages(page) * PAGE_SIZE,
> -                         0, op, sector);
> -
> +       if (op_is_write(op))
> +               rc = pmem_do_write(pmem, page, 0, sector,
> +                                  hpage_nr_pages(page) * PAGE_SIZE);
> +       else
> +               rc = pmem_do_read(pmem, page, 0, sector,
> +                                  hpage_nr_pages(page) * PAGE_SIZE);
>         /*
>          * The ->rw_page interface is subtle and tricky.  The core
>          * retries on any error, so we can only invoke page_endio() in
> --
> 2.20.1

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
