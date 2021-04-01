Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A7350F44
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Apr 2021 08:45:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E5370100EB349;
	Wed, 31 Mar 2021 23:45:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=ritesh.list@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D205A100EB847
	for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a12so721800pfc.7
        for <linux-nvdimm@lists.01.org>; Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cqVKb6CBj74jNn4PteYvhc8gg791d45MOhfp+Rlng1g=;
        b=qv/Z0X+nfvaFgxMy2FBBb8T3pLXpS4ySkNJjwcEc9yPH6thFDRr7wiFRYyqbgffczK
         HVN/IWOi0lg4iAkrc7uLZXSpzD8GBuMCReSnFcP+bNuTMYWvSlW7bG3w2GUEbAqZCCya
         88rgJama7f4bgWy2v61GjP12ZZFjmX0Uoga6067CEwCJjLGtz5cYsTv/CamTTDPknVno
         vZajEJ3JVnr1ETbtooBYpUmR4GKw3NuqyElz3qcFhcGgeHT7cRaxSNd5aLtxmFgwx+Xz
         00s/M8FlibpPfa2yLxP91oDtL9sV0amp0nlS1Yu6R0NdFcBpsyMWk3J4PTzzS30LNMmp
         T3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cqVKb6CBj74jNn4PteYvhc8gg791d45MOhfp+Rlng1g=;
        b=EYlf6+kMymGgbU7pVALanro/JfmGatroElEflNsP6SBUkG3QlN+XBDxBMZf/O+NXed
         /QYZWZArhB/iSWg4kdX7WKfRkNP9Kaw+tvw0CZDfGqOnijlHfszIAOOB2G6KDjW6T/IA
         4j1WydCI1z+RPb/TPdNsl9V+0UMwjSAshF5qgUg5pZkkBdGhW9iU4/SfxA/o9PbFWM60
         xIuQeIyaeUvmbHIqY5udKc9WzyS9j+Yrl2IQBx7nGJS1V0+iSBRB863la/B2VSi5kTNH
         8b66sc5aTvJJj6WtX9N2xUiVUEdkPwnlDr8oIEqpbOwgh05CpbGbccKINizSAdT+Py5m
         U66w==
X-Gm-Message-State: AOAM53390K2O2SUvceYR+kBosk8uOFyYJcQ3p6QkrdKYZGGEaeCd+S2N
	8KM3DgvuWjBLedtBtYLnEZ0=
X-Google-Smtp-Source: ABdhPJxtKqGP3au9ZiwwVN50hiRw8YRBjgdFTyLntXV/t7UtoBMLPEn/8gzMRbVDkZtH1agb/7VUfw==
X-Received: by 2002:a62:e404:0:b029:1f1:5cea:afbd with SMTP id r4-20020a62e4040000b02901f15ceaafbdmr6303168pfh.5.1617259509397;
        Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
Received: from localhost ([122.182.250.63])
        by smtp.gmail.com with ESMTPSA id ms21sm4387389pjb.5.2021.03.31.23.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:45:09 -0700 (PDT)
Date: Thu, 1 Apr 2021 12:15:06 +0530
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v3 06/10] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Message-ID: <20210401064506.47pz6u2gegp6s2ky@riteshh-domain>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
Message-ID-Hash: 4VW4PCFKSRGW5L6LJXQBF65V543YP44O
X-Message-ID-Hash: 4VW4PCFKSRGW5L6LJXQBF65V543YP44O
X-MailFrom: ritesh.list@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4VW4PCFKSRGW5L6LJXQBF65V543YP44O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/19 09:52AM, Shiyang Ruan wrote:
> Punch hole on a reflinked file needs dax_copy_edge() too.  Otherwise,
> data in not aligned area will be not correct.  So, add the srcmap to
> dax_iomap_zero() and replace memset() as dax_copy_edge().
>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c               | 9 +++++++--
>  fs/iomap/buffered-io.c | 2 +-
>  include/linux/dax.h    | 3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index cfe513eb111e..348297b38f76 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1174,7 +1174,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
>  }
>  #endif /* CONFIG_FS_DAX_PMD */
>
> -s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
> +s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> +		struct iomap *srcmap)

Do we know why does dax_iomap_zero() operates on PAGE_SIZE range?
IIUC, dax_zero_page_range() can take nr_pages as a parameter. But we still
always use one page at a time. Why is that?

>  {
>  	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
>  	pgoff_t pgoff;
> @@ -1204,7 +1205,11 @@ s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
>  	}
>
>  	if (!page_aligned) {
> -		memset(kaddr + offset, 0, size);
> +		if (iomap->addr != srcmap->addr)
> +			dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
> +					   kaddr, true);
> +		else
> +			memset(kaddr + offset, 0, size);
>  		dax_flush(iomap->dax_dev, kaddr + offset, size);
>  	}
>  	dax_read_unlock(id);
>

Maybe the above could be simplified to this?

	if (page_aligned) {
		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
	} else {
		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
		if (iomap->addr != srcmap->addr)
			dax_iomap_cow_copy(offset, size, PAGE_SIZE, srcmap,
					   kaddr, true);
		else
			memset(kaddr + offset, 0, size);
		dax_flush(iomap->dax_dev, kaddr + offset, size);
	}

	dax_read_unlock(id);
	return rc < 0 ? rc : size;

Other than that looks good.
Feel free to add.
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
