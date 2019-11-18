Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB87FFF4F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 08:08:55 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69E35100DC3F1;
	Sun, 17 Nov 2019 23:09:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=batv+189483ff2217bb486f00+5930+infradead.org+hch@bombadil.srs.infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0134E100DC3EC
	for <linux-nvdimm@lists.01.org>; Sun, 17 Nov 2019 23:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8ExZk9kczKbYZaf+JhYjsw3ZlJG/piiUaGK9LX777sQ=; b=HWYQdaeoViTJh8ki1f8oz62GPc
	S/9Pz7w7AlVu5+aaOjLpiy0pqQiH1U9UzwZUlaqga/snXQcMZ6w+JzwIKPiGvVQZNR+abF4Ymu368
	koJGbrV5zpC27FQXI56DpaATg1VIR4EEutNGTtJWQzSKs25LwLh5M/8DHct0IXWa5oJdCrTECNaQr
	dzmWJQ21ALWiDg6IIPx7Qmk82vaS6wZAsOtdNxFiUVCfB8xSAAYKqIJTLy74ScZXnpZKidUdXu4zk
	0dEUeV1Z+nGlNIcnBuJ65GkTrCX5Bq1mbfARwB+2tIz0plZ4rzGpTJ/E7gUJr0c1ogfBzo+Qxe87Z
	D0dyFaiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iWb98-0002G9-83; Mon, 18 Nov 2019 07:08:26 +0000
Date: Sun, 17 Nov 2019 23:08:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 2/2] mm: devmap: refactor 1-based refcounting for
 ZONE_DEVICE pages
Message-ID: <20191118070826.GB3099@infradead.org>
References: <20191115001134.2489505-1-jhubbard@nvidia.com>
 <20191115001134.2489505-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191115001134.2489505-3-jhubbard@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Message-ID-Hash: ZID4TDJPLAUGE2PSOQWW52DWII6EK5PR
X-Message-ID-Hash: ZID4TDJPLAUGE2PSOQWW52DWII6EK5PR
X-MailFrom: BATV+189483ff2217bb486f00+5930+infradead.org+hch@bombadil.srs.infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, linux-nvdimm@lists.01.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZID4TDJPLAUGE2PSOQWW52DWII6EK5PR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 04:11:34PM -0800, John Hubbard wrote:
> An upcoming patch changes and complicates the refcounting and
> especially the "put page" aspects of it. In order to keep
> everything clean, refactor the devmap page release routines:
>=20
> * Rename put_devmap_managed_page() to page_is_devmap_managed(),
>   and limit the functionality to "read only": return a bool,
>   with no side effects.
>=20
> * Add a new routine, put_devmap_managed_page(), to handle checking
>   what kind of page it is, and what kind of refcount handling it
>   requires.
>=20
> * Rename __put_devmap_managed_page() to free_devmap_managed_page(),
>   and limit the functionality to unconditionally freeing a devmap
>   page.
>=20
> This is originally based on a separate patch by Ira Weiny, which
> applied to an early version of the put_user_page() experiments.
> Since then, J=E9r=F4me Glisse suggested the refactoring described above.

I can't say I'm a big fan of this as it adds a lot more inlined
code to put_page, which has a lot of callsites.  Can't we instead
try to figure out a way to move away from the off by one refcounting?

>=20
> Cc: Jan Kara <jack@suse.cz>
> Cc: J=E9r=F4me Glisse <jglisse@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: J=E9r=F4me Glisse <jglisse@redhat.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h | 27 ++++++++++++++++++++++++---
>  mm/memremap.c      | 16 ++--------------
>  2 files changed, 26 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a2adf95b3f9c..96228376139c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -967,9 +967,10 @@ static inline bool is_zone_device_page(const struct =
page *page)
>  #endif
> =20
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
> -void __put_devmap_managed_page(struct page *page);
> +void free_devmap_managed_page(struct page *page);
>  DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
> -static inline bool put_devmap_managed_page(struct page *page)
> +
> +static inline bool page_is_devmap_managed(struct page *page)
>  {
>  	if (!static_branch_unlikely(&devmap_managed_key))
>  		return false;
> @@ -978,7 +979,6 @@ static inline bool put_devmap_managed_page(struct pag=
e *page)
>  	switch (page->pgmap->type) {
>  	case MEMORY_DEVICE_PRIVATE:
>  	case MEMORY_DEVICE_FS_DAX:
> -		__put_devmap_managed_page(page);
>  		return true;
>  	default:
>  		break;
> @@ -986,6 +986,27 @@ static inline bool put_devmap_managed_page(struct pa=
ge *page)
>  	return false;
>  }
> =20
> +static inline bool put_devmap_managed_page(struct page *page)
> +{
> +	bool is_devmap =3D page_is_devmap_managed(page);
> +
> +	if (is_devmap) {
> +		int count =3D page_ref_dec_return(page);
> +
> +		/*
> +		 * devmap page refcounts are 1-based, rather than 0-based: if
> +		 * refcount is 1, then the page is free and the refcount is
> +		 * stable because nobody holds a reference on the page.
> +		 */
> +		if (count =3D=3D 1)
> +			free_devmap_managed_page(page);
> +		else if (!count)
> +			__put_page(page);
> +	}
> +
> +	return is_devmap;
> +}
> +
>  #else /* CONFIG_DEV_PAGEMAP_OPS */
>  static inline bool put_devmap_managed_page(struct page *page)
>  {
> diff --git a/mm/memremap.c b/mm/memremap.c
> index e899fa876a62..2ba773859031 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -411,20 +411,8 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pf=
n,
>  EXPORT_SYMBOL_GPL(get_dev_pagemap);
> =20
>  #ifdef CONFIG_DEV_PAGEMAP_OPS
> -void __put_devmap_managed_page(struct page *page)
> +void free_devmap_managed_page(struct page *page)
>  {
> -	int count =3D page_ref_dec_return(page);
> -
> -	/* still busy */
> -	if (count > 1)
> -		return;
> -
> -	/* only triggered by the dev_pagemap shutdown path */
> -	if (count =3D=3D 0) {
> -		__put_page(page);
> -		return;
> -	}
> -
>  	/* notify page idle for dax */
>  	if (!is_device_private_page(page)) {
>  		wake_up_var(&page->_refcount);
> @@ -461,5 +449,5 @@ void __put_devmap_managed_page(struct page *page)
>  	page->mapping =3D NULL;
>  	page->pgmap->ops->page_free(page);
>  }
> -EXPORT_SYMBOL(__put_devmap_managed_page);
> +EXPORT_SYMBOL(free_devmap_managed_page);
>  #endif /* CONFIG_DEV_PAGEMAP_OPS */
> --=20
> 2.24.0
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
---end quoted text---
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
