Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B94307E9D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Jan 2021 20:19:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3A000100EAB4C;
	Thu, 28 Jan 2021 11:19:00 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15; helo=mout.gmx.net; envelope-from=deller@gmx.de; receiver=<UNKNOWN> 
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 67C5C100EAB4B
	for <linux-nvdimm@lists.01.org>; Thu, 28 Jan 2021 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=badeba3b8450; t=1611861528;
	bh=T2/4O2AxgXFBXSdZe5UdzBtTGA6z6qjg4G1b5zju5/g=;
	h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
	b=RLvuPcXKpHlbjE3bgTNCgmN1jvF9YAHy2CRv9P+R9/hdKu/f6CbNYVpk7Pr2MF6bJ
	 IHE94vlyv4lrhAgP+C60mIeUQH0cU+8zeSH5eJq5nezJ5EnbCtCR5M39rmZfFfCJuj
	 0AvPmhZi78RnGKFyL6h8TpAj3UGTFDuBhkGfW9L4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.59]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1lr06l0Wot-00wAz8; Thu, 28
 Jan 2021 20:18:48 +0100
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8bfcc62d-ff81-6108-f161-486f2e888a51@gmx.de>
Date: Thu, 28 Jan 2021 20:18:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
Content-Language: en-US
X-Provags-ID: V03:K1:P2nSEzBfeQCXu2MhCDLsBvjHyMRcNbqDel9TFjtkQfGGAKK9y30
 G/b0u00rhpe8VccgtnfKyLF13uPTMja++1mkoaV+XUJZlAvJonohxP4j8XC1H3KmqqALqwX
 FzVNP1toN63BeGRftx3Ryhfxx8XFG3STPRfVNSjeGxFEOw1D31Xg410brcpML+cS/R3TAva
 y/NS/qIzpuH9psJfCGYgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:e8xsw4xiGoY=:3DDSCnDAsQmYi0aVLs7Aoc
 bc0d84uLCDxBM/hpNOYQk+/fbrfaW9hCqE6LxRksQxE0ZIk3y+buTPWmXcfI0vFIUFzlliYf1
 ulTzQRQ0+P2216NbzlyNQKu0YjZFRVhxcFJvruGcPCOx3B6Odzx1PkIypHtqNR11LihB9h00W
 4RRasRHezIzC+u/qHytla/O4Z/RFoApnSnf7vytDyCfTf9qc3O6O+2x9BzFr8qdq6xhL6T9TD
 eZ5XZBRKo/9MWMX2nYoGnSiZyGKp0LPDD1jCBt++dL9IolV4CFY47Kr09B62pqUkTSe/HAFzF
 dIzpRdTwyzmmAwQXC36Cu3ydlGr9MoIl0maiG3C9XwRI5ianmpEshsfuzkAOgPyN8gZPEPGQ2
 Mqpjg7tqmdIKTKlHqaewnUvSuzb4yKCVlTxz+FsuNVdbkBHGPyZzZ52RL+oUp1E/X0ECcR3+B
 h8NctcSTx7YzuVuKXyKXOvpL63T2Z6Ps6mPem2DkyICeXBkcMGVjJpqTYabLBlVej8jbQRmbT
 qr+MdHcl5JaPRyC0ya523ZdmXEs+UC1KaZcJEWbxEpgsVVpOfxRORCWAKVlG2H/PUyQY8+ZYf
 iiPvMSlQRVSEo9xTAt6D4ZEtOQqtv/V0ohBH4LZpMQhhkR3ln2FsDOzFoIvWt58LDXqaib/AC
 WX6rtZStw0v/uaF6YkD+1/Or3UUbrGwoTJn9mBmD/PaFRjmEJHkyYCUFWFSbVw3IVh6ZNhqn3
 dZjXEPdhTsOl7cSihMGFxTtjHbM1CaJkhAqsVH8q2o+9vUBCWZ30X6Ot8pw4hx3jEl6fS/uik
 AS4YV1KBsT0CZVZbNLegtirSPJRzjJ7x3wyZufzZgJW0kqn84s+rXrAvtlL9BEeYPOiy4GRrQ
 +U0iQOKE0UKzJtoOM2Zg==
Message-ID-Hash: V7OIVRDXVDIDXMJMG5AZRDB3BYUNFNLK
X-Message-ID-Hash: V7OIVRDXVDIDXMJMG5AZRDB3BYUNFNLK
X-MailFrom: deller@gmx.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V7OIVRDXVDIDXMJMG5AZRDB3BYUNFNLK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/4/20 1:33 AM, James Bottomley wrote:
> These platforms define PMD_ORDER in asm/pgtable.h
>
> This means that as soon as dax.c included asm/pgtable.h in commit
> 11cf9d863dcb ("fs/dax: Deposit pagetable even when installing zero
> page") we clash with PMD_ORDER introduced by cfc93c6c6c96 ("dax:
> Convert dax_insert_pfn_mkwrite to XArray") and we get this problem:
>
> /home/jejb/git/linux-build/fs/dax.c:53: warning: "PMD_ORDER" redefined
>    53 | #define PMD_ORDER (PMD_SHIFT - PAGE_SHIFT)
>       |
> In file included from /home/jejb/git/linux-build/include/linux/pgtable.h:6,
>                  from /home/jejb/git/linux-build/include/linux/mm.h:33,
>                  from /home/jejb/git/linux-build/include/linux/bvec.h:14,
>                  from /home/jejb/git/linux-build/include/linux/blk_types.h:10,
>                  from /home/jejb/git/linux-build/include/linux/genhd.h:19,
>                  from /home/jejb/git/linux-build/include/linux/blkdev.h:8,
>                  from /home/jejb/git/linux-build/fs/dax.c:10:
> /home/jejb/git/linux-build/arch/parisc/include/asm/pgtable.h:124: note: this is the location of the previous definition
>   124 | #define PMD_ORDER 1 /* Number of pages per pmd */
>       |
> make[2]: *** Deleting file 'fs/dax.o'
>
> Fix by renaming dax's PMD_ORDER to DAX_PMD_ORDER


Dear dax developers,

could you please recheck if you can apply this suggested patch by James?
Your usage of "PMD_ORDER" conflicts with mips and parisc, and
a renaming to DAX_PMD_ORDER seems easy and logical.

Helge



> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  fs/dax.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/dax.c b/fs/dax.c
> index 5b47834f2e1b..4d3b0db5c321 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
>  #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
>
>  /* The order of a PMD entry */
> -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> +#define DAX_PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
>
>  static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
>
> @@ -98,7 +98,7 @@ static bool dax_is_locked(void *entry)
>  static unsigned int dax_entry_order(void *entry)
>  {
>  	if (xa_to_value(entry) & DAX_PMD)
> -		return PMD_ORDER;
> +		return DAX_PMD_ORDER;
>  	return 0;
>  }
>
> @@ -1471,7 +1471,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct address_space *mapping = vma->vm_file->f_mapping;
> -	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, PMD_ORDER);
> +	XA_STATE_ORDER(xas, &mapping->i_pages, vmf->pgoff, DAX_PMD_ORDER);
>  	unsigned long pmd_addr = vmf->address & PMD_MASK;
>  	bool write = vmf->flags & FAULT_FLAG_WRITE;
>  	bool sync;
> @@ -1530,7 +1530,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
>  	 * entry is already in the array, for instance), it will return
>  	 * VM_FAULT_FALLBACK.
>  	 */
> -	entry = grab_mapping_entry(&xas, mapping, PMD_ORDER);
> +	entry = grab_mapping_entry(&xas, mapping, DAX_PMD_ORDER);
>  	if (xa_is_internal(entry)) {
>  		result = xa_to_internal(entry);
>  		goto fallback;
> @@ -1696,7 +1696,7 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
>  	if (order == 0)
>  		ret = vmf_insert_mixed_mkwrite(vmf->vma, vmf->address, pfn);
>  #ifdef CONFIG_FS_DAX_PMD
> -	else if (order == PMD_ORDER)
> +	else if (order == DAX_PMD_ORDER)
>  		ret = vmf_insert_pfn_pmd(vmf, pfn, FAULT_FLAG_WRITE);
>  #endif
>  	else
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
