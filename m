Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2FC15382B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 19:32:10 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B53BA10FC33EB;
	Wed,  5 Feb 2020 10:35:26 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9BAE110FC33E9
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=atoIN1OFKCU2b5DgZt33HXnRgjJrT50beNxSLnGsZbo=; b=kliQ8fsEHZFoN0v/LbvxMWn4Vs
	BpKxAJxnm+S8GyqNylyBM76FILz9NUGyuot4wcQv0YoeA2z2oqL98udL9f+uk6mTgdACSA+CBOS8+
	WsX7/jADCrNOPWoWhnRhyuOLoaxEqNdy4EQM+H4h93QtZmx+ThPHzag0tGkZYaAUv4R2/DfrwhWI5
	mRIK24RxU4+CxSNPrO6vD0qg2Xgvp0ZImW+zwdgNH65ISRT8YVG/LdIVQkzC0BSrNR8w9vLVSidw6
	Gu/Abtu9bJbd8QXqxZ1jM+MT/lD2pjLcP4JTtK8tf2UdoHXmIKjCd7BFVGVmIGg4MSOJTCIcAr3cC
	ijJFvNuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPT3-0001K6-LJ; Wed, 05 Feb 2020 18:32:05 +0000
Date: Wed, 5 Feb 2020 10:32:05 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/5] s390,dax: Add dax zero_page_range operation to
 dcssblk driver
Message-ID: <20200205183205.GB26711@infradead.org>
References: <20200203200029.4592-1-vgoyal@redhat.com>
 <20200203200029.4592-3-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200203200029.4592-3-vgoyal@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: M7M27IMET5ZKXPVL7EOPCE63NBR2LWOL
X-Message-ID-Hash: M7M27IMET5ZKXPVL7EOPCE63NBR2LWOL
X-MailFrom: BATV+a2b935cbc3c12af13a1b+6009+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, hch@infradead.org, dm-devel@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/M7M27IMET5ZKXPVL7EOPCE63NBR2LWOL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
> index 63502ca537eb..f6709200bcd0 100644
> --- a/drivers/s390/block/dcssblk.c
> +++ b/drivers/s390/block/dcssblk.c
> @@ -62,6 +62,7 @@ static const struct dax_operations dcssblk_dax_ops = {
>  	.dax_supported = generic_fsdax_supported,
>  	.copy_from_iter = dcssblk_dax_copy_from_iter,
>  	.copy_to_iter = dcssblk_dax_copy_to_iter,
> +	.zero_page_range = dcssblk_dax_zero_page_range,
>  };
>  
>  struct dcssblk_dev_info {
> @@ -941,6 +942,12 @@ dcssblk_dax_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
>  	return __dcssblk_direct_access(dev_info, pgoff, nr_pages, kaddr, pfn);
>  }
>  
> +static int dcssblk_dax_zero_page_range(struct dax_device *dax_dev,pgoff_t pgoff,
> +				       unsigned offset, size_t len)
> +{
> +	return generic_dax_zero_page_range(dax_dev, pgoff, offset, len);
> +}

Wouldn't this need a forward declaration?  Then again given that dcssblk
is the only caller of generic_dax_zero_page_range we might as well merge
the two.  If you want to keep the generic one it could be wired up to
dcssblk_dax_ops directly, though.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
