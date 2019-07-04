Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 402095FC1F
	for <lists+linux-nvdimm@lfdr.de>; Thu,  4 Jul 2019 18:54:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A154C212B0825;
	Thu,  4 Jul 2019 09:54:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=jack@suse.cz;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AB361212AF0D0
 for <linux-nvdimm@lists.01.org>; Thu,  4 Jul 2019 09:54:52 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3D1F0AD2A;
 Thu,  4 Jul 2019 16:54:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id D0EFC1E3F56; Thu,  4 Jul 2019 18:54:50 +0200 (CEST)
Date: Thu, 4 Jul 2019 18:54:50 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
Message-ID: <20190704165450.GH31037@quack2.suse.cz>
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
 <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
 <20190703195302.GJ1729@bombadil.infradead.org>
 <CAPcyv4iPNz=oJyc_EoE-mC11=gyBzwMKbmj1ZY_Yna54=cC=Mg@mail.gmail.com>
 <20190704032728.GK1729@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190704032728.GK1729@bombadil.infradead.org>
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
 Boaz Harrosh <openosd@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 stable <stable@vger.kernel.org>, Robert Barror <robert.barror@intel.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Seema Pandit <seema.pandit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed 03-07-19 20:27:28, Matthew Wilcox wrote:
> On Wed, Jul 03, 2019 at 02:28:41PM -0700, Dan Williams wrote:
> > On Wed, Jul 3, 2019 at 12:53 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > @@ -211,7 +215,8 @@ static void *get_unlocked_entry(struct xa_state *xas)
> > >         for (;;) {
> > >                 entry = xas_find_conflict(xas);
> > >                 if (!entry || WARN_ON_ONCE(!xa_is_value(entry)) ||
> > > -                               !dax_is_locked(entry))
> > > +                               !dax_is_locked(entry) ||
> > > +                               dax_entry_order(entry) < xas_get_order(xas))
> > 
> > Doesn't this potentially allow a locked entry to be returned for a
> > caller that expects all value entries are unlocked?
> 
> It only allows locked entries to be returned for callers which pass in
> an xas which refers to a PMD entry.  This is fine for grab_mapping_entry()
> because it checks size_flag & is_pte_entry.
> 
> dax_layout_busy_page() only uses 0-order.
> __dax_invalidate_entry() only uses 0-order.
> dax_writeback_one() needs an extra fix:
> 
>                 /* Did a PMD entry get split? */
>                 if (dax_is_locked(entry))
>                         goto put_unlocked;
> 
> dax_insert_pfn_mkwrite() checks for a mismatch of pte vs pmd.
> 
> So I think we're good for all current users.

Agreed but it is an ugly trap. As I already said, I'd rather pay the
unnecessary cost of waiting for pte entry and have an easy to understand
interface. If we ever have a real world use case that would care for this
optimization, we will need to refactor functions to make this possible and
still keep the interfaces sane. For example get_unlocked_entry() could
return special "error code" indicating that there's no entry with matching
order in xarray but there's a conflict with it. That would be much less
error-prone interface.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
