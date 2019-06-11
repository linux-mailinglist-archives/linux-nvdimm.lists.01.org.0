Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 981CB3C937
	for <lists+linux-nvdimm@lfdr.de>; Tue, 11 Jun 2019 12:44:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 981CF21962301;
	Tue, 11 Jun 2019 03:44:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 10B862194EB70
 for <linux-nvdimm@lists.01.org>; Tue, 11 Jun 2019 03:37:31 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BB1C8AD12;
 Tue, 11 Jun 2019 10:37:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 1C7AE1E3E26; Tue, 11 Jun 2019 12:37:29 +0200 (CEST)
Date: Tue, 11 Jun 2019 12:37:29 +0200
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v3 3/6] mm/nvdimm: Add page size and struct page size to
 pfn superblock
Message-ID: <20190611103729.GA27635@quack2.suse.cz>
References: <20190604091357.32213-1-aneesh.kumar@linux.ibm.com>
 <20190604091357.32213-3-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190604091357.32213-3-aneesh.kumar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue 04-06-19 14:43:54, Aneesh Kumar K.V wrote:
> This is needed so that we don't wrongly initialize a namespace
> which doesn't have enough space reserved for holding struct pages
> with the current kernel.
> 
> We also increment PFN_MIN_VERSION to make sure that older kernel
> won't initialize namespace created with newer kernel.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
...
> diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
> index 00c57805cad3..e01eee9efafe 100644
> --- a/drivers/nvdimm/pfn_devs.c
> +++ b/drivers/nvdimm/pfn_devs.c
> @@ -467,6 +467,15 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
>  	if (__le16_to_cpu(pfn_sb->version_minor) < 2)
>  		pfn_sb->align = 0;
>  
> +	if (__le16_to_cpu(pfn_sb->version_minor) < 3) {
> +		/*
> +		 * For a large part we use PAGE_SIZE. But we
> +		 * do have some accounting code using SZ_4K.
> +		 */
> +		pfn_sb->page_struct_size = cpu_to_le16(64);
> +		pfn_sb->page_size = cpu_to_le32(SZ_4K);
> +	}
> +
>  	switch (le32_to_cpu(pfn_sb->mode)) {
>  	case PFN_MODE_RAM:
>  	case PFN_MODE_PMEM:

As we discussed with Aneesh privately, this actually means that existing
NVDIMM namespaces on PPC64 will stop working due to these defaults for old
superblocks. I don't think that's a good thing as upgrading kernels is
going to be nightmare due to this on PPC64. So I believe we should make
defaults for old superblocks such that working setups keep working without
sysadmin having to touch anything.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
