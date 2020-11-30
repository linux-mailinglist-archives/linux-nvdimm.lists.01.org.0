Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796032C857E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Nov 2020 14:37:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CB768100ED4A6;
	Mon, 30 Nov 2020 05:36:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A995E100ED49B
	for <linux-nvdimm@lists.01.org>; Mon, 30 Nov 2020 05:36:55 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A77D2AB63;
	Mon, 30 Nov 2020 13:36:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id A500F1E131B; Mon, 30 Nov 2020 14:36:52 +0100 (CET)
Date: Mon, 30 Nov 2020 14:36:52 +0100
From: Jan Kara <jack@suse.cz>
To: Amy Parker <enbyamy@gmail.com>
Subject: Re: [RFC PATCH 1/3] fs: dax.c: move fs hole signifier from
 DAX_ZERO_PAGE to XA_ZERO_ENTRY
Message-ID: <20201130133652.GK11250@quack2.suse.cz>
References: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1WUT7ke9TR_H+et5_BUg93OYcDF0LD2ku+Cto59PhP6nz8qg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: 6YNRSLRSIFKWO4VS6KO6BSM2IIQLF4AY
X-Message-ID-Hash: 6YNRSLRSIFKWO4VS6KO6BSM2IIQLF4AY
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6YNRSLRSIFKWO4VS6KO6BSM2IIQLF4AY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat 28-11-20 20:36:29, Amy Parker wrote:
> DAX uses the DAX_ZERO_PAGE bit to represent holes in files. It could also use
> a single entry, such as XArray's XA_ZERO_ENTRY. This distinguishes zero pages
> and allows us to shift DAX_EMPTY down (see patch 2/3).
> 
> Signed-off-by: Amy Parker <enbyamy@gmail.com>

Thanks for the patch. The idea looks nice however I think technically there
are some problems with the patch. See below.

> +/*
> + * A zero entry, XA_ZERO_ENTRY, is used to represent a zero page. This
> + * definition helps with checking if an entry is a PMD size.
> + */
> +#define XA_ZERO_PMD_ENTRY DAX_PMD | (unsigned long)XA_ZERO_ENTRY
> +

Firstly, if you define a macro, we usually wrap it inside braces like:

#define XA_ZERO_PMD_ENTRY (DAX_PMD | (unsigned long)XA_ZERO_ENTRY)

to avoid unexpected issues when macro expands and surrounding operators
have higher priority.

Secondly, I don't think you can combine XA_ZERO_ENTRY with DAX_PMD (or any
other bits for that matter). XA_ZERO_ENTRY is defined as
xa_mk_internal(257) which is ((257 << 2) | 2) - DAX bits will overlap with
the bits xarray internal entries are using and things will break.

Honestly, I find it somewhat cumbersome to use xarray internal entries for
DAX purposes since all the locking (using DAX_LOCKED) and size checking
(using DAX_PMD) functions will have to special-case internal entries to
operate on different set of bits. It could be done, sure, but I'm not sure
it is worth the trouble for saving two bits (we could get rid of
DAX_ZERO_PAGE and DAX_EMPTY bits in this way) in DAX entries. But maybe
Matthew had some idea how to do this in an elegant way...

								Honza

>  static unsigned long dax_to_pfn(void *entry)
>  {
>      return xa_to_value(entry) >> DAX_SHIFT;
> @@ -114,7 +119,7 @@ static bool dax_is_pte_entry(void *entry)
> 
>  static int dax_is_zero_entry(void *entry)
>  {
> -    return xa_to_value(entry) & DAX_ZERO_PAGE;
> +    return xa_to_value(entry) & (unsigned long)XA_ZERO_ENTRY;
>  }
> 
>  static int dax_is_empty_entry(void *entry)
> @@ -738,7 +743,7 @@ static void *dax_insert_entry(struct xa_state *xas,
>      if (dirty)
>          __mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
> 
> -    if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> +    if (dax_is_zero_entry(entry) && !(flags & (unsigned long)XA_ZERO_ENTRY)) {
>          unsigned long index = xas->xa_index;
>          /* we are replacing a zero page with block mapping */
>          if (dax_is_pmd_entry(entry))
> @@ -1047,7 +1052,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
>      vm_fault_t ret;
> 
>      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -            DAX_ZERO_PAGE, false);
> +            XA_ZERO_ENTRY, false);
> 
>      ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
>      trace_dax_load_hole(inode, vmf, ret);
> @@ -1434,7 +1439,7 @@ static vm_fault_t dax_pmd_load_hole(struct
> xa_state *xas, struct vm_fault *vmf,
> 
>      pfn = page_to_pfn_t(zero_page);
>      *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> -            DAX_PMD | DAX_ZERO_PAGE, false);
> +            XA_ZERO_PMD_ENTRY, false);
> 
>      if (arch_needs_pgtable_deposit()) {
>          pgtable = pte_alloc_one(vma->vm_mm);
> -- 
> 2.29.2
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
