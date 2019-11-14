Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C759FBD6A
	for <lists+linux-nvdimm@lfdr.de>; Thu, 14 Nov 2019 02:24:54 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF9D2100DC436;
	Wed, 13 Nov 2019 17:26:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=jglisse@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 39DF8100DC434
	for <linux-nvdimm@lists.01.org>; Wed, 13 Nov 2019 17:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1573694689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7jXRzyKCm+mM5iPsPq5U8675eMVocuhlR6RXezXlIM=;
	b=cA/WvmN27aGK7XRQqwgnTWw7DcR35apWGGYwu55cW5fuxRCvgja6lWnSWmXXd1Oa7PbCbO
	5aURkakPfwCm1s11hMFTPjEZ5wo/YcgY2CPrgXlPMfVI36SHU3dMEBxjQsyQRDljkAzI6A
	FdOOkZHZuGvfgjd/YKoKhvloEWKCXNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-qQt2hxAlNM2VwrcHmZ_fzg-1; Wed, 13 Nov 2019 20:24:45 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5341802CE2;
	Thu, 14 Nov 2019 01:24:43 +0000 (UTC)
Received: from redhat.com (ovpn-121-71.rdu2.redhat.com [10.10.121.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8A791084196;
	Thu, 14 Nov 2019 01:24:42 +0000 (UTC)
Date: Wed, 13 Nov 2019 20:24:41 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: Cleanup __put_devmap_managed_page() vs ->page_free()
Message-ID: <20191114012441.GA6395@redhat.com>
References: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <157368992671.2974225.13512647385398246617.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: qQt2hxAlNM2VwrcHmZ_fzg-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Message-ID-Hash: 26BOWOHU34JDFA2S3IBNKHYWKX7ZTZMD
X-Message-ID-Hash: 26BOWOHU34JDFA2S3IBNKHYWKX7ZTZMD
X-MailFrom: jglisse@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: jhubbard@nvidia.com, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/26BOWOHU34JDFA2S3IBNKHYWKX7ZTZMD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2019 at 04:07:22PM -0800, Dan Williams wrote:
> After the removal of the device-public infrastructure there are only 2
> ->page_free() call backs in the kernel. One of those is a device-private
> callback in the nouveau driver, the other is a generic wakeup needed in
> the DAX case. In the hopes that all ->page_free() callbacks can be
> migrated to common core kernel functionality, move the device-private
> specific actions in __put_devmap_managed_page() under the
> is_device_private_page() conditional, including the ->page_free()
> callback. For the other page types just open-code the generic wakeup.
>=20
> Yes, the wakeup is only needed in the MEMORY_DEVICE_FSDAX case, but it
> does no harm in the MEMORY_DEVICE_DEVDAX and MEMORY_DEVICE_PCI_P2PDMA
> case.
>=20
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: J=E9r=F4me Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

All looks good to me.

Reviewed-by: J=E9r=F4me Glisse <jglisse@redhat.com>


> ---
> Hi John,
>=20
> This applies on top of today's linux-next and passes my nvdimm unit
> tests. That testing noticed that devmap_managed_enable_get() needed a
> small fixup as well.
>=20
>  drivers/nvdimm/pmem.c |    6 ------
>  mm/memremap.c         |   22 ++++++++++++----------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index f9f76f6ba07b..21db1ce8c0ae 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -338,13 +338,7 @@ static void pmem_release_disk(void *__pmem)
>  	put_disk(pmem->disk);
>  }
> =20
> -static void pmem_pagemap_page_free(struct page *page)
> -{
> -	wake_up_var(&page->_refcount);
> -}
> -
>  static const struct dev_pagemap_ops fsdax_pagemap_ops =3D {
> -	.page_free		=3D pmem_pagemap_page_free,
>  	.kill			=3D pmem_pagemap_kill,
>  	.cleanup		=3D pmem_pagemap_cleanup,
>  };
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 022e78e68ea0..6e6f3d6fdb73 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -27,7 +27,8 @@ static void devmap_managed_enable_put(void)
> =20
>  static int devmap_managed_enable_get(struct dev_pagemap *pgmap)
>  {
> -	if (!pgmap->ops || !pgmap->ops->page_free) {
> +	if (!pgmap->ops || (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE
> +				&& !pgmap->ops->page_free)) {
>  		WARN(1, "Missing page_free method\n");
>  		return -EINVAL;
>  	}
> @@ -449,12 +450,6 @@ void __put_devmap_managed_page(struct page *page)
>  	 * holds a reference on the page.
>  	 */
>  	if (count =3D=3D 1) {
> -		/* Clear Active bit in case of parallel mark_page_accessed */
> -		__ClearPageActive(page);
> -		__ClearPageWaiters(page);
> -
> -		mem_cgroup_uncharge(page);
> -
>  		/*
>  		 * When a device_private page is freed, the page->mapping field
>  		 * may still contain a (stale) mapping value. For example, the
> @@ -476,10 +471,17 @@ void __put_devmap_managed_page(struct page *page)
>  		 * handled differently or not done at all, so there is no need
>  		 * to clear page->mapping.
>  		 */
> -		if (is_device_private_page(page))
> -			page->mapping =3D NULL;
> +		if (is_device_private_page(page)) {
> +			/* Clear Active bit in case of parallel mark_page_accessed */
> +			__ClearPageActive(page);
> +			__ClearPageWaiters(page);
> =20
> -		page->pgmap->ops->page_free(page);
> +			mem_cgroup_uncharge(page);
> +
> +			page->mapping =3D NULL;
> +			page->pgmap->ops->page_free(page);
> +		} else
> +			wake_up_var(&page->_refcount);
>  	} else if (!count)
>  		__put_page(page);
>  }
>=20
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
