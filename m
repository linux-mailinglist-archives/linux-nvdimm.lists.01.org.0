Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190E12F6C2A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Jan 2021 21:38:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1676C100EC1FA;
	Thu, 14 Jan 2021 12:38:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 49A7B100ED4A5
	for <linux-nvdimm@lists.01.org>; Thu, 14 Jan 2021 12:38:43 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so7170116edt.7
        for <linux-nvdimm@lists.01.org>; Thu, 14 Jan 2021 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HW2Gy+bmbScdrUiihPvmqmOfoBoJ371Y9lVdMFUmq+Y=;
        b=yGOdyQNILINypQm/2jqXO6AfJMafn21XGw8EuGb3Op3CFg1tTZMSAR0rEasGJ1fNOS
         yLllo/9Y8iS/xZYU6AxccWxMPTpSMM8D6QvzzM4jMSGwEs9hnHIlBnLno7KTxzdYF3Kp
         KwtNyxup1uOWxXyQrcBBAo2o9U51ITkYAiriKkt2QNr2JX6HrELaFQgxFhhCA8zYidBs
         k7aOmIV3u5QzjG0umzVAbcSHGi2o9GzSnc7gS6T59a8K4b8xbNr8QhTa7Jy5EYUITqET
         o40thjAjGnsgi1R5vPAh+U9Vvz+toY/DwyAl8fonbO5ueCyy/1GYAeVF73/Ndh+roNVD
         9VQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HW2Gy+bmbScdrUiihPvmqmOfoBoJ371Y9lVdMFUmq+Y=;
        b=cc1Tp70hoIpUAxXho0vUn09K4AcRNNXeLL79XtBaVrRyCUV5jI37VH1oNcX2AQa484
         t9KiZyHe/FnoPIBApGBbU5uEkY/kwRhrxAHXFf9kEQF4YN/QbWkrUYWwzCHqAkwc6DI/
         DIH9sntLXoF/VCPR/ds/WZPe9vb2csYfbZ6vyElEJm5PzzR3oNi4ikrttc4B/bpISyjG
         P7eNjBwHInuDcU2t95gxadpcmyDHyYCrKpw/cEMqs/m6b2hU8GKN9BAsMqc/Yd9NxSEo
         l0vhuDmwOKVJ4rOpQmqyqpd59Gr3L6opJvqIdCyw16cbs5OT/2RHDyuSsZlXrO1zzDSo
         0POA==
X-Gm-Message-State: AOAM533GD+RcmU2aAFCq3prfJiUlN0AuoQUW6rlZ8+Rb/Dzg5df9Iigq
	JBJ/wVo9Vh/v+x77SxGHGPjvOwxcf79dxg0ZwRojSw==
X-Google-Smtp-Source: ABdhPJw/UE18mcptuTTaq48ZA3l/slnXhk/5uHJysnrWQLOxkXl0WkGF7VK5q6iTBMceXPuJ8xY9V/7LnANIuvkLoIM=
X-Received: by 2002:a50:b282:: with SMTP id p2mr7358432edd.210.1610656721518;
 Thu, 14 Jan 2021 12:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20201230165601.845024-1-ruansy.fnst@cn.fujitsu.com> <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
In-Reply-To: <20201230165601.845024-5-ruansy.fnst@cn.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 14 Jan 2021 12:38:30 -0800
Message-ID: <CAPcyv4hD1aeVGQ33j54o8jKi41qtAVkAhTgrx64C=WPZ0SvNQg@mail.gmail.com>
Subject: Re: [PATCH 04/10] mm, fsdax: Refactor memory-failure handler for dax mapping
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: THENKHXX7CX35XR3SQLJF5QWXKNDPQYX
X-Message-ID-Hash: THENKHXX7CX35XR3SQLJF5QWXKNDPQYX
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-raid <linux-raid@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, song@kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/THENKHXX7CX35XR3SQLJF5QWXKNDPQYX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Dec 30, 2020 at 8:59 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> The current memory_failure_dev_pagemap() can only handle single-mapped
> dax page for fsdax mode.  The dax page could be mapped by multiple files
> and offsets if we let reflink feature & fsdax mode work together.  So,
> we refactor current implementation to support handle memory failure on
> each file and offset.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  fs/dax.c            | 21 +++++++++++
>  include/linux/dax.h |  1 +
>  include/linux/mm.h  |  9 +++++
>  mm/memory-failure.c | 91 ++++++++++++++++++++++++++++++++++-----------
>  4 files changed, 100 insertions(+), 22 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..799210cfa687 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -378,6 +378,27 @@ static struct page *dax_busy_page(void *entry)
>         return NULL;
>  }
>
> +/*
> + * dax_load_pfn - Load pfn of the DAX entry corresponding to a page
> + * @mapping: The file whose entry we want to load
> + * @index:   The offset where the DAX entry located in
> + *
> + * Return:   pfn of the DAX entry
> + */
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index)
> +{
> +       XA_STATE(xas, &mapping->i_pages, index);
> +       void *entry;
> +       unsigned long pfn;
> +
> +       xas_lock_irq(&xas);
> +       entry = xas_load(&xas);
> +       pfn = dax_to_pfn(entry);
> +       xas_unlock_irq(&xas);
> +
> +       return pfn;
> +}
> +
>  /*
>   * dax_lock_mapping_entry - Lock the DAX entry corresponding to a page
>   * @page: The page whose entry we want to lock
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b52f084aa643..89e56ceeffc7 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -150,6 +150,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>
>  struct page *dax_layout_busy_page(struct address_space *mapping);
>  struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
> +unsigned long dax_load_pfn(struct address_space *mapping, unsigned long index);
>  dax_entry_t dax_lock_page(struct page *page);
>  void dax_unlock_page(struct page *page, dax_entry_t cookie);
>  #else
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index db6ae4d3fb4e..db3059a1853e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1141,6 +1141,14 @@ static inline bool is_device_private_page(const struct page *page)
>                 page->pgmap->type == MEMORY_DEVICE_PRIVATE;
>  }
>
> +static inline bool is_device_fsdax_page(const struct page *page)
> +{
> +       return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> +               IS_ENABLED(CONFIG_DEVICE_PRIVATE) &&
> +               is_zone_device_page(page) &&
> +               page->pgmap->type == MEMORY_DEVICE_FS_DAX;
> +}
> +

Have a look at the recent fixes to pfn_to_online_page() vs DAX pages [1].

This above page type check is racy given that the pfn could stop being
pfn_valid() while this check is running. I think hwpoison_filter()
needs an explicit check for whether the page is already referenced or
not. For example the current call to hwpoison_filter() from
memory_failure_dev_pagemap() is safe because the page has already been
validated as ZONE_DEVICE and is safe to de-reference page->pgmap.

[1]: http://lore.kernel.org/r/161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
