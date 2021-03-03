Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD832B62C
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Mar 2021 10:28:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29336100EB84D;
	Wed,  3 Mar 2021 01:28:14 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=<UNKNOWN> 
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 52C82100EBBB4
	for <linux-nvdimm@lists.01.org>; Wed,  3 Mar 2021 01:28:11 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9A87668BEB; Wed,  3 Mar 2021 10:28:08 +0100 (CET)
Date: Wed, 3 Mar 2021 10:28:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [PATCH v2 02/10] fsdax: Factor helper: dax_fault_actor()
Message-ID: <20210303092808.GC12784@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-3-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Message-ID-Hash: SFW3YK3XSIEMP2OL3XWDNEJCVDGZJTKF
X-Message-ID-Hash: SFW3YK3XSIEMP2OL3XWDNEJCVDGZJTKF
X-MailFrom: hch@lst.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SFW3YK3XSIEMP2OL3XWDNEJCVDGZJTKF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Feb 26, 2021 at 08:20:22AM +0800, Shiyang Ruan wrote:
> The core logic in the two dax page fault functions is similar. So, move
> the logic into a common helper function. Also, to facilitate the
> addition of new features, such as CoW, switch-case is no longer used to
> handle different iomap types.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 211 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 117 insertions(+), 94 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 7031e4302b13..9dea1572868e 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1289,6 +1289,93 @@ static int dax_fault_cow_page(struct vm_fault *vmf, struct iomap *iomap,
>  	return 0;
>  }
>  
> +static vm_fault_t dax_fault_insert_pfn(struct vm_fault *vmf, pfn_t pfn,
> +		bool pmd, bool write)
> +{
> +	vm_fault_t ret;
> +
> +	if (!pmd) {
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long address = vmf->address;
> +
> +		if (write)
> +			ret = vmf_insert_mixed_mkwrite(vma, address, pfn);
> +		else
> +			ret = vmf_insert_mixed(vma, address, pfn);
> +	} else
> +		ret = vmf_insert_pfn_pmd(vmf, pfn, write);

What about simplifying this a little bit more, something like:

	if (pmd)
		return vmf_insert_pfn_pmd(vmf, pfn, write);

	if (write)
		return vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
	return vmf_insert_mixed(vmf->vma, vmf->address, pfn);

also given that this only has a single user, why not keep open coding
it in the caller?

> +#ifdef CONFIG_FS_DAX_PMD
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry);
> +#else
> +static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
> +		struct iomap *iomap, void **entry)
> +{
> +	return VM_FAULT_FALLBACK;
> +}
> +#endif

Can we try to avoid the forward declaration?  Also is there a reason
dax_pmd_load_hole does not compile for the !CONFIG_FS_DAX_PMD case?
If it compiles fine we can just rely on IS_ENABLED() based dead code
elimination entirely.

> +	/* if we are reading UNWRITTEN and HOLE, return a hole. */
> +	if (!write &&
> +	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
> +		if (!pmd)
> +			return dax_load_hole(xas, mapping, &entry, vmf);
> +		else
> +			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
> +	}
> +
> +	if (iomap->type != IOMAP_MAPPED) {
> +		WARN_ON_ONCE(1);
> +		return VM_FAULT_SIGBUS;
> +	}

Nit: I'd use a switch statement here for a clarity:

	switch (iomap->type) {
	case IOMAP_MAPPED:
		break;
	case IOMAP_UNWRITTEN:
	case IOMAP_HOLE:
		if (!write) {
			if (!pmd)
				return dax_load_hole(xas, mapping, &entry, vmf);
			return dax_pmd_load_hole(xas, vmf, iomap, &entry);
		}
		break;
	default:
		WARN_ON_ONCE(1);
		return VM_FAULT_SIGBUS;
	}


> +	err = dax_iomap_pfn(iomap, pos, size, &pfn);
> +	if (err)
> +		goto error_fault;
> +
> +	entry = dax_insert_entry(xas, mapping, vmf, entry, pfn, 0,
> +				 write && !sync);
> +
> +	if (sync)
> +		return dax_fault_synchronous_pfnp(pfnp, pfn);
> +
> +	ret = dax_fault_insert_pfn(vmf, pfn, pmd, write);
> +
> +error_fault:
> +	if (err)
> +		ret = dax_fault_return(err);
> +
> +	return ret;

It seems like the only place that sets err is the dax_iomap_pfn case
above.  So I'd move the dax_fault_return there, which then allows a direct
return for everyone else, including the open coded version of
dax_fault_insert_pfn.

I really like where this is going!
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
