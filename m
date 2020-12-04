Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFE2CEE49
	for <lists+linux-nvdimm@lfdr.de>; Fri,  4 Dec 2020 13:44:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEBEC100EBBCB;
	Fri,  4 Dec 2020 04:44:14 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 11E6F100EC1C6
	for <linux-nvdimm@lists.01.org>; Fri,  4 Dec 2020 04:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AjuAPGM7G2kMm64bUja2RitkEu1uv3g7PuJ6UiGCjec=; b=OS2MyK0IhBUnWYTsQkbN6XDe+a
	0RzYNlc12iI9h+rXilNNpWO0YuA0DMEXsNw5zXxeuMb5hODEavmO3BLe/dC0zNpt9L7IMIfHz0Tyl
	rWmUHxvmiShEPwvMnxZ3XMKlNBSJ+kCEQsmkPNb7+lisRzXeBaOR2fHJXykN5paMkmKKc9AxMSC6W
	/9lZVSSqDxcq6ArODbGnmHKB7KdbJmX7KDQjdxig0V4JuXy4U1z7RuD24XhjgVGFfi/7IY4W1CwXy
	HGdY8vXvgnKkeI4XlZ+DMGG9+Vv71fRwMJJFuQs3IOSQI33bDaMpChMBRl3RPRkDXoKE3ROVoi7pg
	uYuZGdIA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klARO-000262-Tg; Fri, 04 Dec 2020 12:44:02 +0000
Date: Fri, 4 Dec 2020 12:44:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Helge Deller <deller@gmx.de>
Subject: Re: PATCH] fs/dax: fix compile problem on parisc and mips
Message-ID: <20201204124402.GN11935@casper.infradead.org>
References: <fb91b40d258414b0fdce2c380752e48daa6a70d6.camel@HansenPartnership.com>
 <20201204034843.GM11935@casper.infradead.org>
 <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f0ac7be-0108-0648-a4db-2f37db1c8114@gmx.de>
Message-ID-Hash: PNJR3D65KMOMGY42YYCVGNFR4IOKB64Y
X-Message-ID-Hash: PNJR3D65KMOMGY42YYCVGNFR4IOKB64Y
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: James Bottomley <James.Bottomley@hansenpartnership.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PNJR3D65KMOMGY42YYCVGNFR4IOKB64Y/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Dec 04, 2020 at 08:57:37AM +0100, Helge Deller wrote:
> On 12/4/20 4:48 AM, Matthew Wilcox wrote:
> > On Thu, Dec 03, 2020 at 04:33:10PM -0800, James Bottomley wrote:
> >> These platforms define PMD_ORDER in asm/pgtable.h
> >
> > I think that's the real problem, though.
> >
> > #define PGD_ORDER       1 /* Number of pages per pgd */
> > #define PMD_ORDER       1 /* Number of pages per pmd */
> > #define PGD_ALLOC_ORDER (2 + 1) /* first pgd contains pmd */
> > #else
> > #define PGD_ORDER       1 /* Number of pages per pgd */
> > #define PGD_ALLOC_ORDER (PGD_ORDER + 1)
> >
> > That should clearly be PMD_ALLOC_ORDER, not PMD_ORDER.  Or even
> > PAGES_PER_PMD like the comment calls it, because I really think
> > that doing an order-3 (8 pages) allocation for the PGD is wrong.
> 
> We need a spinlock to protect parallel accesses to the PGD,
> search for pgd_spinlock().
> This spinlock is stored behind the memory used for the PGD, which
> is why we allocate more memory (and waste 3 pages).

There are better places to store it than that!  For example, storing it
in the struct page, like many architectures do for split ptlocks.
You'll have to skip the _pt_pad_1 so it doesn't get confused with
being a compound_head, but soemthing like this:

		struct {	/* PA-RISC PGD */
			unsigned long _pa_pad_1;	/* compound_head */
#if ALLOC_SPLIT_PA_PTLOCKS
			spinlock_t *pa_ptl;
#else
			spinlock_t pa_ptl;
#endif
		};

inside struct page (linux/mm_types.h) should do the trick.  You'll
still need to allocate them separately if various debugging options
are enabled (see the ALLOC_SPLIT_PTLOCKS for details), but usually
this will save you a lot of memory.

You could also fill in pt_mm like x86 does for its pgds, and then use
mm->page_table_lock to protect whatever the PGD lock currently protects.
Maybe page_table_lock is sometimes held when calling ptep_set_wrprotect()
and sometimes isn't; then this wouldn't work.

Also, could you fix the comments?  They don't match the code:

 #define PGD_ORDER      1 /* Number of pages per pgd */

should be

 #define PGD_ALLOC_ORDER      1 /* 2 pages (8KiB) per pgd */
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
