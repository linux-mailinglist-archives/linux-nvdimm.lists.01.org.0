Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35365AC67
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Jun 2019 18:03:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8CFA3212ABA40;
	Sat, 29 Jun 2019 09:03:40 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F01C921295B17
 for <linux-nvdimm@lists.01.org>; Sat, 29 Jun 2019 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qtT2pRYm5g6b3fRjkDJ4o2YrzEnuahVF7qIr55Bxvvg=; b=qHF1K8SUIw7JPjQ9WiiBa8liX
 mKUdBsz1XW8hLrwqPD4mZ9s4UWYJ5NeDu+ZeK6Clz/m3Jf+L8ynyV93qurpvGRTJ42XBPI5c1bAiM
 T5ZXLYR5p8EwoTj0GHatz0hbG7v8PLgIHlJZkomH666xAjKwjUi3eHJPG8kPIxcsceqWTrt3f6lc5
 YvCnrzINRvDDQoco3QmrBv42WN0hIaYLR4D04yvKMAG43/Bq1hkBdDTZvkCrECMqyY4p33v8Wsqzy
 TK0/XGMDJzQ0rYlyrYwDyU02D1DC0+bH08d4vfCMSzspEOS2q5GmKmz55NVxy5lTyIFmU6enSAIsm
 bVFNyJBZA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hhFpA-0005dg-VR; Sat, 29 Jun 2019 16:03:36 +0000
Date: Sat, 29 Jun 2019 09:03:36 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190629160336.GB1180@bombadil.infradead.org>
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 07:39:37PM -0700, Dan Williams wrote:
> On Thu, Jun 27, 2019 at 12:59 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > > > This bug feels like we failed to unlock, or unlocked the wrong entry
> > > > and this hunk in the bisected commit looks suspect to me. Why do we
> > > > still need to drop the lock now that the radix_tree_preload() calls
> > > > are gone?
> > >
> > > Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> > > wonder why we don't restart the lookup like the old implementation.
> >
> > We have the entry locked:
> >
> >                 /*
> >                  * Make sure 'entry' remains valid while we drop
> >                  * the i_pages lock.
> >                  */
> >                 dax_lock_entry(xas, entry);
> >
> >                 /*
> >                  * Besides huge zero pages the only other thing that gets
> >                  * downgraded are empty entries which don't need to be
> >                  * unmapped.
> >                  */
> >                 if (dax_is_zero_entry(entry)) {
> >                         xas_unlock_irq(xas);
> >                         unmap_mapping_pages(mapping,
> >                                         xas->xa_index & ~PG_PMD_COLOUR,
> >                                         PG_PMD_NR, false);
> >                         xas_reset(xas);
> >                         xas_lock_irq(xas);
> >                 }
> >
> > If something can remove a locked entry, then that would seem like the
> > real bug.  Might be worth inserting a lookup there to make sure that it
> > hasn't happened, I suppose?
> 
> Nope, added a check, we do in fact get the same locked entry back
> after dropping the lock.
> 
> The deadlock revolves around the mmap_sem. One thread holds it for
> read and then gets stuck indefinitely in get_unlocked_entry(). Once
> that happens another rocksdb thread tries to mmap and gets stuck
> trying to take the mmap_sem for write. Then all new readers, including
> ps and top that try to access a remote vma, then get queued behind
> that write.
> 
> It could also be the case that we're missing a wake up.

OK, I have a Theory.

get_unlocked_entry() doesn't check the size of the entry being waited for.
So dax_iomap_pmd_fault() can end up sleeping waiting for a PTE entry,
which is (a) foolish, because we know it's going to fall back, and (b)
can lead to a missed wakeup because it's going to sleep waiting for
the PMD entry to come unlocked.  Which it won't, unless there's a happy
accident that happens to map to the same hash bucket.

Let's see if I can steal some time this weekend to whip up a patch.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
