Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEA95B05C
	for <lists+linux-nvdimm@lfdr.de>; Sun, 30 Jun 2019 17:23:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 750D7212AB003;
	Sun, 30 Jun 2019 08:23:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2139A212963F4
 for <linux-nvdimm@lists.01.org>; Sun, 30 Jun 2019 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0yKD+nd5R9noH+ABUpWvHdCJQD/Y+EiA+7PhImpdzhE=; b=NHSJZkW9cFAt3rifg9uKVBJjJ
 lHKZKmmzh1JoJwUtBk3B4GeWNLeDZvyQIpRApyU4Tz4I/5CMZJUoKUG6NtSJjx4J6yYpntr514Xpk
 bwO5/aKXzdNZgNWDhr7g9ZBPVV/EcpgcMhUINwDYX4o8OSC5hl62tzfUI7+SIM2lvT6Al47sbG1xx
 3ZyVTnPkQafCYAEXYk9/9g2SndTjMuHIQ6FZsGVI5hC+CyHfe4rZaPgFtqAxfocE/nlnP9dlkyb3u
 93fwueDizOc3fOqJ2uY+EqFTPtoTRugIGLg6cXE53phGvI+ckyCC8E5uY78WWQwFJEd+fqNqr/G3I
 xpbztJVIQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hhbfp-00041b-13; Sun, 30 Jun 2019 15:23:25 +0000
Date: Sun, 30 Jun 2019 08:23:24 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190630152324.GA15900@bombadil.infradead.org>
References: <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
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

On Sun, Jun 30, 2019 at 01:01:04AM -0700, Dan Williams wrote:
> On Sun, Jun 30, 2019 at 12:27 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Sat, Jun 29, 2019 at 9:03 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Thu, Jun 27, 2019 at 07:39:37PM -0700, Dan Williams wrote:
> > > > On Thu, Jun 27, 2019 at 12:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > >
> > > > > On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > > > > > > This bug feels like we failed to unlock, or unlocked the wrong entry
> > > > > > > and this hunk in the bisected commit looks suspect to me. Why do we
> > > > > > > still need to drop the lock now that the radix_tree_preload() calls
> > > > > > > are gone?
> > > > > >
> > > > > > Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> > > > > > wonder why we don't restart the lookup like the old implementation.
> > > > >
> > > > > We have the entry locked:
> > > > >
> > > > >                 /*
> > > > >                  * Make sure 'entry' remains valid while we drop
> > > > >                  * the i_pages lock.
> > > > >                  */
> > > > >                 dax_lock_entry(xas, entry);
> > > > >
> > > > >                 /*
> > > > >                  * Besides huge zero pages the only other thing that gets
> > > > >                  * downgraded are empty entries which don't need to be
> > > > >                  * unmapped.
> > > > >                  */
> > > > >                 if (dax_is_zero_entry(entry)) {
> > > > >                         xas_unlock_irq(xas);
> > > > >                         unmap_mapping_pages(mapping,
> > > > >                                         xas->xa_index & ~PG_PMD_COLOUR,
> > > > >                                         PG_PMD_NR, false);
> > > > >                         xas_reset(xas);
> > > > >                         xas_lock_irq(xas);
> > > > >                 }
> > > > >
> > > > > If something can remove a locked entry, then that would seem like the
> > > > > real bug.  Might be worth inserting a lookup there to make sure that it
> > > > > hasn't happened, I suppose?
> > > >
> > > > Nope, added a check, we do in fact get the same locked entry back
> > > > after dropping the lock.
> > > >
> > > > The deadlock revolves around the mmap_sem. One thread holds it for
> > > > read and then gets stuck indefinitely in get_unlocked_entry(). Once
> > > > that happens another rocksdb thread tries to mmap and gets stuck
> > > > trying to take the mmap_sem for write. Then all new readers, including
> > > > ps and top that try to access a remote vma, then get queued behind
> > > > that write.
> > > >
> > > > It could also be the case that we're missing a wake up.
> > >
> > > OK, I have a Theory.
> > >
> > > get_unlocked_entry() doesn't check the size of the entry being waited for.
> > > So dax_iomap_pmd_fault() can end up sleeping waiting for a PTE entry,
> > > which is (a) foolish, because we know it's going to fall back, and (b)
> > > can lead to a missed wakeup because it's going to sleep waiting for
> > > the PMD entry to come unlocked.  Which it won't, unless there's a happy
> > > accident that happens to map to the same hash bucket.
> > >
> > > Let's see if I can steal some time this weekend to whip up a patch.
> >
> > Theory seems to have some evidence... I instrumented fs/dax.c to track
> > outstanding 'lock' entries and 'wait' events. At the time of the hang
> > we see no locks held and the waiter is waiting on a pmd entry:
> >
> > [ 4001.354334] fs/dax locked entries: 0
> > [ 4001.358425] fs/dax wait entries: 1
> > [ 4001.362227] db_bench/2445 index: 0x0 shift: 6
> > [ 4001.367099]  grab_mapping_entry+0x17a/0x260
> > [ 4001.371773]  dax_iomap_pmd_fault.isra.43+0x168/0x7a0
> > [ 4001.377316]  ext4_dax_huge_fault+0x16f/0x1f0
> > [ 4001.382086]  __handle_mm_fault+0x411/0x1390
> > [ 4001.386756]  handle_mm_fault+0x172/0x360
> 
> In fact, this naive fix is holding up so far:
> 
> @@ -215,7 +216,7 @@ static wait_queue_head_t
> *dax_entry_waitqueue(struct xa_state *xas,
>          * queue to the start of that PMD.  This ensures that all offsets in
>          * the range covered by the PMD map to the same bit lock.
>          */
> -       if (dax_is_pmd_entry(entry))
> +       //if (dax_is_pmd_entry(entry))
>                 index &= ~PG_PMD_COLOUR;
>         key->xa = xas->xa;
>         key->entry_start = index;

Hah, that's a great naive fix!  Thanks for trying that out.

I think my theory was slightly mistaken, but your fix has the effect of
fixing the actual problem too.

The xas->xa_index for a PMD is going to be PMD-aligned (ie a multiple of
512), but xas_find_conflict() does _not_ adjust xa_index (... which I
really should have mentioned in the documentation).  So we go to sleep
on the PMD-aligned index instead of the index of the PTE.  Your patch
fixes this by using the PMD-aligned index for PTEs too.

I'm trying to come up with a clean fix for this.  Clearly we
shouldn't wait for a PTE entry if we're looking for a PMD entry.
But what should get_unlocked_entry() return if it detects that case?
We could have it return an error code encoded as an internal entry,
like grab_mapping_entry() does.  Or we could have it return the _locked_
PTE entry, and have callers interpret that.

At least get_unlocked_entry() is static, but it's got quite a few callers.
Trying to discern which ones might ask for a PMD entry is a bit tricky.
So this seems like a large patch which might have bugs.

Thoughts?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
