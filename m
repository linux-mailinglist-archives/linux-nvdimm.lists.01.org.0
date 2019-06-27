Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E858B53
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 21:59:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12274212AB008;
	Thu, 27 Jun 2019 12:59:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id ECC5D212A36C4
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1zaJPISJ/EM3luyF1vz7G/5Xji346kDTt6heztPdAbM=; b=Opin+Qydyf8b8u+uTC3Ub0SNO
 bNiTRXwZJKK3vmcNgV3Q+9ZsiLEpy0Z/TptTzlqTB/at+xjh5msPBhEbfBZw2ume9YxOvHLAyj+mR
 vneJqGV8dfXGHd2fo6u2nzXrMquEyTDAhcs/rjOCT1tNz10efzK73Zc+asQMhIG2/TKghMpiHcCEt
 jQMbY9H3RIcg2UIxJBohct5anRwA9gw7fz+Rq2giBj3pqDhWPfqxDk3f6ts7XQjV6A5U21Aq3bcfP
 eqUCt08yZKTPer3mQ6Bg+Sly5ULCt7EJx5YiuALhtj6Cg2It6s4hByBpQujCnvyeNIeuWALavj14k
 pspOiFNAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hgaYe-0007ij-P9; Thu, 27 Jun 2019 19:59:48 +0000
Date: Thu, 27 Jun 2019 12:59:48 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190627195948.GB4286@bombadil.infradead.org>
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190627123415.GA4286@bombadil.infradead.org>
 <CAPcyv4jQP-SFJGor-Q3VCRQ0xwt3MuVpH2qHx2wzyRA88DGQww@mail.gmail.com>
 <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
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

On Thu, Jun 27, 2019 at 12:09:29PM -0700, Dan Williams wrote:
> > This bug feels like we failed to unlock, or unlocked the wrong entry
> > and this hunk in the bisected commit looks suspect to me. Why do we
> > still need to drop the lock now that the radix_tree_preload() calls
> > are gone?
> 
> Nevermind, unmapp_mapping_pages() takes a sleeping lock, but then I
> wonder why we don't restart the lookup like the old implementation.

We have the entry locked:

                /*
                 * Make sure 'entry' remains valid while we drop
                 * the i_pages lock.
                 */
                dax_lock_entry(xas, entry);

                /*
                 * Besides huge zero pages the only other thing that gets
                 * downgraded are empty entries which don't need to be
                 * unmapped.
                 */
                if (dax_is_zero_entry(entry)) {
                        xas_unlock_irq(xas);
                        unmap_mapping_pages(mapping,
                                        xas->xa_index & ~PG_PMD_COLOUR,
                                        PG_PMD_NR, false);
                        xas_reset(xas);
                        xas_lock_irq(xas);
                }

If something can remove a locked entry, then that would seem like the
real bug.  Might be worth inserting a lookup there to make sure that it
hasn't happened, I suppose?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
