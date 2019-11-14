Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E3FC0A4
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 08:19:11 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 140BB100DC43D;
	Wed, 13 Nov 2019 23:20:42 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7E9A1100DC43B
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 23:20:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FE8B68AFE; Thu, 14 Nov 2019 08:19:03 +0100 (CET)
Date: Thu, 14 Nov 2019 08:19:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs
 ->page_free()
Message-ID: <20191114071903.GA26307@lst.de>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: X4LPYTLMXZGA7ZAJOIGVUI3F3ZBIM4BI
X-Message-ID-Hash: X4LPYTLMXZGA7ZAJOIGVUI3F3ZBIM4BI
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: jhubbard@nvidia.com, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/X4LPYTLMXZGA7ZAJOIGVUI3F3ZBIM4BI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
>  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -	if (!pgmap->ops || !pgmap->ops->page_free) {
> +	if (!pgmap->ops || (pgmap->type == MEMORY_DEVICE_PRIVATE
> +				&& !pgmap->ops->page_free)) {

I don't think this check is correct.  You only want the the ops null check
or MEMORY_DEVICE_PRIVATE as well now, i.e.:

	if (pgmap->type == MEMORY_DEVICE_PRIVATE &&
	    (!pgmap->ops || !pgmap->ops->page_free)) {

> @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
>  		 * handled differently or not done at all, so there is no need
>  		 * to clear page->mapping.
>  		 */
> -		if (is_device_private_page(page))
> -			page->mapping = NULL;
> +		if (is_device_private_page(page)) {
> +			/* Clear Active bit in case of parallel mark_page_accessed */

This adds a > 80 char line.  But that whole flow of the function seems
rather odd now.

Why can't we do:

	if (count == 0) {
		__put_page(page);
	} else if (is_device_private_page(page)) {
		__ClearPageActive(page);
		__ClearPageWaiters(page);

		mem_cgroup_uncharge(page);
		page->mapping = NULL;
		page->pgmap->ops->page_free(page);
	} else {
		wake_up_var(&page->_refcount);
	}

(except for the fact that I don't get the point of calling __put_page
on a refcount of zero, but that is separate from this patch).
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
