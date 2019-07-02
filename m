Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399B5C7D2
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jul 2019 05:34:14 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23479212AAFF1;
	Mon,  1 Jul 2019 20:34:13 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EBDF521290D37
 for <linux-nvdimm@lists.01.org>; Mon,  1 Jul 2019 20:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rvg0fFhiVW2SSgiiyKRZ1dYBb2123d87t9/7oxE/t3s=; b=hPiTv9NcFQT+UCy+e+gooSaND
 sN1+wbD/4vxONjqjO+zJCyR6e8DZkzG/PQft9f18todOUGe/vHEb+N0BKS6/qFoXtRJxu3A42+9MC
 /AHlvyjEhP2Lde+VRKdHc0Vg3dVVJ76SftLB05vR0RWNiZYt8+lw/UGWf8lFOAoRkQkcopd3sYPVD
 hJ62GN7gHpSF0ADfjsqqdKK8DjBOkSGEt+OZrZwWW3ZS7L508/tM/0kkY8ozLmnm2M1xOoKe5K9y1
 cSBO3tQJcMnZOm2ARmAFW/nStl5qD455jTxWoWOuGkhCbO8GWejGio1Kbev1mZRYWrJgwPBTjnvPx
 NBXZxZd2g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hi9YY-0000SB-QV; Tue, 02 Jul 2019 03:34:10 +0000
Date: Mon, 1 Jul 2019 20:34:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190702033410.GB1729@bombadil.infradead.org>
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
 <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4j2NBPBEUU3UW1Q5OyOEuo9R5e90HpkowpeEkMsAKiUyQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun, Jun 30, 2019 at 02:37:32PM -0700, Dan Williams wrote:
> On Sun, Jun 30, 2019 at 8:23 AM Matthew Wilcox <willy@infradead.org> wrote:
> > I think my theory was slightly mistaken, but your fix has the effect of
> > fixing the actual problem too.
> >
> > The xas->xa_index for a PMD is going to be PMD-aligned (ie a multiple of
> > 512), but xas_find_conflict() does _not_ adjust xa_index (... which I
> > really should have mentioned in the documentation).  So we go to sleep
> > on the PMD-aligned index instead of the index of the PTE.  Your patch
> > fixes this by using the PMD-aligned index for PTEs too.
> >
> > I'm trying to come up with a clean fix for this.  Clearly we
> > shouldn't wait for a PTE entry if we're looking for a PMD entry.
> > But what should get_unlocked_entry() return if it detects that case?
> > We could have it return an error code encoded as an internal entry,
> > like grab_mapping_entry() does.  Or we could have it return the _locked_
> > PTE entry, and have callers interpret that.
> >
> > At least get_unlocked_entry() is static, but it's got quite a few callers.
> > Trying to discern which ones might ask for a PMD entry is a bit tricky.
> > So this seems like a large patch which might have bugs.
> >
> > Thoughts?
> 
> ...but if it was a problem of just mismatched waitqueue's I would have
> expected it to trigger prior to commit b15cd800682f "dax: Convert page
> fault handlers to XArray".

That commit converts grab_mapping_entry() (called by dax_iomap_pmd_fault())
from calling get_unlocked_mapping_entry() to calling get_unlocked_entry().
get_unlocked_mapping_entry() (eventually) called __radix_tree_lookup()
instead of dax_find_conflict().

> This hunk, if I'm reading it correctly,
> looks suspicious: @index in this case is coming directly from
> vm->pgoff without pmd alignment adjustment whereas after the
> conversion it's always pmd aligned from the xas->xa_index. So perhaps
> the issue is that the lock happens at pte granularity. I expect it
> would cause the old put_locked_mapping_entry() to WARN, but maybe that
> avoids the lockup and was missed in the bisect.

I don't think that hunk is the problem.  The __radix_tree_lookup()
is going to return a 'slot' which points to the canonical slot, no
matter which of the 512 indices corresponding to that slot is chosen.
So I think it's going to do essentially the same thing.

> @@ -884,21 +711,18 @@ static void *dax_insert_entry(struct
> address_space *mapping,
>                  * existing entry is a PMD, we will just leave the PMD in the
>                  * tree and dirty it if necessary.
>                  */
> -               struct radix_tree_node *node;
> -               void **slot;
> -               void *ret;
> -
> -               ret = __radix_tree_lookup(pages, index, &node, &slot);
> -               WARN_ON_ONCE(ret != entry);
> -               __radix_tree_replace(pages, node, slot,
> -                                    new_entry, NULL);
> +               void *old = dax_lock_entry(xas, new_entry);
> +               WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
> +                                       DAX_LOCKED));
>                 entry = new_entry;
> +       } else {
> +               xas_load(xas);  /* Walk the xa_state */
>         }
> 
>         if (dirty)
> -               radix_tree_tag_set(pages, index, PAGECACHE_TAG_DIRTY);
> +               xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
> 
> -       xa_unlock_irq(pages);
> +       xas_unlock_irq(xas);
>         return entry;
>  }
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
