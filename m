Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC87B5E153
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 11:47:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3AB79212ACEA1;
	Wed,  3 Jul 2019 02:47:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id EE56D212AC488
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 02:47:53 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 7ADFDB15C;
 Wed,  3 Jul 2019 09:47:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 285CE1E433D; Mon,  1 Jul 2019 14:11:19 +0200 (CEST)
Date: Mon, 1 Jul 2019 14:11:19 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190701121119.GE31621@quack2.suse.cz>
References: <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190630152324.GA15900@bombadil.infradead.org>
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
Cc: Seema Pandit <seema.pandit@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Sun 30-06-19 08:23:24, Matthew Wilcox wrote:
> On Sun, Jun 30, 2019 at 01:01:04AM -0700, Dan Williams wrote:
> > @@ -215,7 +216,7 @@ static wait_queue_head_t
> > *dax_entry_waitqueue(struct xa_state *xas,
> >          * queue to the start of that PMD.  This ensures that all offsets in
> >          * the range covered by the PMD map to the same bit lock.
> >          */
> > -       if (dax_is_pmd_entry(entry))
> > +       //if (dax_is_pmd_entry(entry))
> >                 index &= ~PG_PMD_COLOUR;
> >         key->xa = xas->xa;
> >         key->entry_start = index;
> 
> Hah, that's a great naive fix!  Thanks for trying that out.
> 
> I think my theory was slightly mistaken, but your fix has the effect of
> fixing the actual problem too.
> 
> The xas->xa_index for a PMD is going to be PMD-aligned (ie a multiple of
> 512), but xas_find_conflict() does _not_ adjust xa_index (... which I
> really should have mentioned in the documentation).  So we go to sleep
> on the PMD-aligned index instead of the index of the PTE.  Your patch
> fixes this by using the PMD-aligned index for PTEs too.
> 
> I'm trying to come up with a clean fix for this.  Clearly we
> shouldn't wait for a PTE entry if we're looking for a PMD entry.
> But what should get_unlocked_entry() return if it detects that case?
> We could have it return an error code encoded as an internal entry,
> like grab_mapping_entry() does.  Or we could have it return the _locked_
> PTE entry, and have callers interpret that.
> 
> At least get_unlocked_entry() is static, but it's got quite a few callers.
> Trying to discern which ones might ask for a PMD entry is a bit tricky.
> So this seems like a large patch which might have bugs.

Yeah. So get_unlocked_entry() is used in several cases:

1) Case where we already have entry at given index but it is locked and we
need it unlocked so that we can do our thing `(dax_writeback_one(),
dax_layout_busy_page()).

2) Case where we want any entry covering given index (in
__dax_invalidate_entry()). This is essentially the same as case 1) since we
have already looked up the entry (just didn't propagate that information
from mm/truncate.c) - we want any unlocked entry covering given index.

3) Cases where we really want entry at given index and we have some entry
order constraints (dax_insert_pfn_mkwrite(), grab_mapping_entry()).

Honestly I'd make the rule that get_unlocked_entry() returns entry of any
order that is covering given index. I agree it may be unnecessarily waiting
for PTE entry lock for the case where in case 3) we are really looking only
for PMD entry but that seems like a relatively small cost for the
simplicity of the interface.

BTW, looking into the xarray code, I think I found another difference
between the old radix tree code and the new xarray code that could cause
issues. In the old radix tree code if we tried to insert PMD entry but
there was some PTE entry in the covered range, we'd get EEXIST error back
and the DAX fault code relies on this. I don't see how similar behavior is
achieved by xas_store()...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
