Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6A316812
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Feb 2021 14:33:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 774E0100EAAF2;
	Wed, 10 Feb 2021 05:33:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DB61100EAAE6
	for <linux-nvdimm@lists.01.org>; Wed, 10 Feb 2021 05:33:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id BABDE68B02; Wed, 10 Feb 2021 14:33:47 +0100 (CET)
Date: Wed, 10 Feb 2021 14:33:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler
 for dax mapping
Message-ID: <20210210133347.GD30109@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: HXT4CRUDLZPOQ3M5A2RMN7IW4LVQ7CZK
X-Message-ID-Hash: HXT4CRUDLZPOQ3M5A2RMN7IW4LVQ7CZK
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, dm-devel@redhat.com, darrick.wong@oracle.com, david@fromorbit.com, hch@lst.de, agk@redhat.com, snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HXT4CRUDLZPOQ3M5A2RMN7IW4LVQ7CZK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> +extern int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags);

No nee for the extern, please avoid the overly long line.

> @@ -120,6 +121,13 @@ static int hwpoison_filter_dev(struct page *p)
>  	if (PageSlab(p))
>  		return -EINVAL;
>  
> +	if (pfn_valid(page_to_pfn(p))) {
> +		if (is_device_fsdax_page(p))
> +			return 0;
> +		else
> +			return -EINVAL;
> +	}
> +

This looks odd.  For one there is no need for an else after a return.
But more importantly page_mapping() as called below pretty much assumes
a valid PFN, so something is fishy in this function.

> +	if (is_zone_device_page(p)) {
> +		if (is_device_fsdax_page(p))
> +			tk->addr = vma->vm_start +
> +					((pgoff - vma->vm_pgoff) << PAGE_SHIFT);

The arithmetics here scream for a common helper, I suspect there might
be other places that could use the same helper.

> +int mf_dax_mapping_kill_procs(struct address_space *mapping, pgoff_t index, int flags)

Overly long line.  Also the naming scheme with the mf_ seems rather
unusual. Maybe dax_kill_mapping_procs?  Also please add a kerneldoc
comment describing the function given that it exported.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
