Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F832FD26
	for <lists+linux-nvdimm@lfdr.de>; Sat,  6 Mar 2021 21:36:52 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B778C100EC1E1;
	Sat,  6 Mar 2021 12:36:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8757A100ED48C
	for <linux-nvdimm@lists.01.org>; Sat,  6 Mar 2021 12:36:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so11558614ejc.1
        for <linux-nvdimm@lists.01.org>; Sat, 06 Mar 2021 12:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bVBJNOetXrqKceA6PQT3AoaWCMo1uBzTwNd40e3p5Mg=;
        b=DUH2TaJDmYKl3P+nqyQnZD/L+UUehgvGZ+JdR6f29HgDHqUZMlDctwBIl8mYEmOyr0
         N4JfiYpVnsK20wsamLI2lVHA89Wfq08BTq5pazwlWEnowiN+pvdoMlOFkXMkezTctVU6
         yLVLH/j9zqqOc1XXIzlPNblcwaWBnvPKoE+8ygaflWqyueqL8GQUxJqDZ0IOPsbLAq4D
         ClAITvBD9MRRxeIdqI+0cvIdl865zgrrN5mPPgRQlFQTjJcqKYMYzsPzMflqD2WkyucY
         yYqxvUtScFD3cWQ3k6qWXggCW2IBUYcSUf7R3K/wcLL0Zz3r5yXY54vMvwFWm819EQIv
         72nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bVBJNOetXrqKceA6PQT3AoaWCMo1uBzTwNd40e3p5Mg=;
        b=rneEszRWWQlPg0YtFytY3si8arTOd9BWLBeOZuw68BYT8Y2cxDkDA2UTofCnG5yZC7
         KdrOy53s4HlMzSQARER9x1NMk+KpsDd2Jn9vkmixwEvtZdE4uWlmEPs93sa+pkEbkVxd
         5F4OzTfXd9BYX4RkCNOoDeN9ZruBZFVh9KV/MO6fVZU45lWuf6Vb4zlzsHHMpP0XR0RS
         PqXwHi80i8rSNJyqHBTiaHF9kUHbfSXoVeydU4wgCh6Ay36M9S6RaPacrRemoR/PLzvR
         Mgc0OH1XQlnbEVSU25fSA96EMABA5rxKByyLjIl6YY2YOS4gUcN0tPgBuRVneSPOezjo
         YIjA==
X-Gm-Message-State: AOAM530Q7YDUZ5ibNkYROwnqJlkySMCw454EQwI9rh8o2bao/UmMR9fK
	/q/ZINC1YGHYdW8+X4lIBa5MlmfzKqLTatKfEVuumw==
X-Google-Smtp-Source: ABdhPJwWg5JZfa53VPl0WuQEKYMbCdynjlz48fz7pdzLNK+5tXI6itu2L3u8T4IRUn3/J6V3gGOhtuytQtomfVZ9FIo=
X-Received: by 2002:a17:906:2818:: with SMTP id r24mr8202331ejc.472.1615063004125;
 Sat, 06 Mar 2021 12:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
In-Reply-To: <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 6 Mar 2021 12:36:39 -0800
Message-ID: <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Message-ID-Hash: TEGINT2B2UVJGWAOP4LE474EN7FY3FR7
X-Message-ID-Hash: TEGINT2B2UVJGWAOP4LE474EN7FY3FR7
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux MM <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, device-mapper development <dm-devel@redhat.com>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Goldwyn Rodrigues <rgoldwyn@suse.de>, qi.fuli@fujitsu.com, Yasunori Goto <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TEGINT2B2UVJGWAOP4LE474EN7FY3FR7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Feb 8, 2021 at 2:55 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
>
> When memory-failure occurs, we call this function which is implemented
> by each kind of devices.  For the fsdax case, pmem device driver
> implements it.  Pmem device driver will find out the block device where
> the error page locates in, and try to get the filesystem on this block
> device.  And finally call filesystem handler to deal with the error.
> The filesystem will try to recover the corrupted data if possiable.
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> ---
>  include/linux/memremap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 79c49e7f5c30..0bcf2b1e20bd 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
>          * the page back to a CPU accessible page.
>          */
>         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> +
> +       /*
> +        * Handle the memory failure happens on one page.  Notify the processes
> +        * who are using this page, and try to recover the data on this page
> +        * if necessary.
> +        */
> +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> +                             int flags);
>  };

After the conversation with Dave I don't see the point of this. If
there is a memory_failure() on a page, why not just call
memory_failure()? That already knows how to find the inode and the
filesystem can be notified from there.

Although memory_failure() is inefficient for large range failures, I'm
not seeing a better option, so I'm going to test calling
memory_failure() over a large range whenever an in-use dax-device is
hot-removed.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
