Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A264199F3E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 31 Mar 2020 21:38:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 17D8E10FC38A0;
	Tue, 31 Mar 2020 12:39:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42D5010FC38A0
	for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 12:39:19 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id v1so26631491edq.8
        for <linux-nvdimm@lists.01.org>; Tue, 31 Mar 2020 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coOdi1Ly5bJ5CvWdmQt/Q+ZCp+crvRqi7slIvYScR14=;
        b=oCBiHixRsRqxNnKByFIvZClFEVtIFF4B8Nx41p6iiYhNwitsHjQ8cg5SAq5qI1ghy3
         kSuUcWke/Ml2C4WTgdNA5jhbVfBm4qucb5EDY7/8+kRqlLnRsYYzQEUuLEQmY1ijaP5y
         +qWEQRzJkut5qkaLKy7ZyanwwQ4yAkijmn+4+w8YhXlei7Xx8eAtZMJQrhKEJd7LvtOm
         vGcv56fIlzt2bB7GpSJO1GkIHRRfZ7L9UZZ64pAgKHFleZ4HqrXJqUh9tu+iQZXOiL5j
         pikzHkCrq26EooTmp26MpUo+KwZPLUEEJ0xx2P9qAmSBV0SlCSQ4VccUscW5L2dAV26b
         iWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coOdi1Ly5bJ5CvWdmQt/Q+ZCp+crvRqi7slIvYScR14=;
        b=FS1CYRuQ88wJvafNYQ16t0NB50DgtsSSRAj3emvewLKIrklloFqqqS0c1bMIUSr1Qq
         57UfEizJvttMNMYWjyT9bNvVgONL+AdmmQP7kVm/hNXb3w3TaEgTWfehT9tmxbmbpLLp
         O7VssVAAXJJQYlwQqIJJTpzt3gKmQrHzYkS9uaCy781MJwxekznv3ajct9YANPvn820H
         Q/v+pRsVm3WSy6RAEyvEUpZGOsNh3SHvXvefr7rNGRd0PzylkNks0XAR2sAz5lfp8dPM
         QzfZ8G/G6WKpjHC34NmEZJXdd2DcW4idhdCZRgmCGCEKayDEyKhdjAVdgMIn+WhKDq7N
         xZ7A==
X-Gm-Message-State: ANhLgQ23BKEXk6CUOdPbQ8/ImzMgDH6YpWLtNRpi04iuYUPaVeQV2P/y
	oDfz6KnzFqMsUr3U790YVRXWtQdBB63iOtqCS3uD3vP1
X-Google-Smtp-Source: ADFU+vucdPRa5GwsLNOLq17qDztrUIi3xXzSpp62uKGM5//eINqDk4GDVcCHXXgstr7+YAE0SAGtA+/4ZqZsNN24uMY=
X-Received: by 2002:aa7:d7c7:: with SMTP id e7mr17322078eds.296.1585683508013;
 Tue, 31 Mar 2020 12:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200218214841.10076-1-vgoyal@redhat.com> <20200218214841.10076-5-vgoyal@redhat.com>
In-Reply-To: <20200218214841.10076-5-vgoyal@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 31 Mar 2020 12:38:16 -0700
Message-ID: <CAPcyv4jKHxy5c8BZodePeCu5+Z=cwhtEfw3RnOD1ZDNob382bQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] dax, pmem: Add a dax operation zero_page_range
To: Vivek Goyal <vgoyal@redhat.com>
Message-ID-Hash: WOR4UIAIA5PRQ565ZEMGWEGW42YGACT6
X-Message-ID-Hash: WOR4UIAIA5PRQ565ZEMGWEGW42YGACT6
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Christoph Hellwig <hch@infradead.org>, device-mapper development <dm-devel@redhat.com>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WOR4UIAIA5PRQ565ZEMGWEGW42YGACT6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 1:49 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Add a dax operation zero_page_range, to zero a range of memory. This will
> also clear any poison in the range being zeroed.
>
> As of now, zeroing of up to one page is allowed in a single call. There
> are no callers which are trying to zero more than a page in a single call.
> Once we grow the callers which zero more than a page in single call, we
> can add that support. Primary reason for not doing that yet is that this
> will add little complexity in dm implementation where a range might be
> spanning multiple underlying targets and one will have to split the range
> into multiple sub ranges and call zero_page_range() on individual targets.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  drivers/dax/super.c   | 19 +++++++++++++++++++
>  drivers/nvdimm/pmem.c | 10 ++++++++++
>  include/linux/dax.h   |  3 +++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
> index 0aa4b6bc5101..c912808bc886 100644
> --- a/drivers/dax/super.c
> +++ b/drivers/dax/super.c
> @@ -344,6 +344,25 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
>  }
>  EXPORT_SYMBOL_GPL(dax_copy_to_iter);
>
> +int dax_zero_page_range(struct dax_device *dax_dev, u64 offset, size_t len)
> +{
> +       if (!dax_alive(dax_dev))
> +               return -ENXIO;
> +
> +       if (!dax_dev->ops->zero_page_range)
> +               return -EOPNOTSUPP;

This seems too late to be doing the validation. It would be odd for
random filesystem operations to see this error. I would move the check
to alloc_dax() and fail that if the caller fails to implement the
operation.

An incremental patch on top to fix this up would be ok. Something like
"Now that all dax_operations providers implement zero_page_range()
mandate it at alloc_dax time".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
