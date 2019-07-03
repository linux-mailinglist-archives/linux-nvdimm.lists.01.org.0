Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DB25E815
	for <lists+linux-nvdimm@lfdr.de>; Wed,  3 Jul 2019 17:47:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8097E212ACEC8;
	Wed,  3 Jul 2019 08:47:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 13256212ACEB1
 for <linux-nvdimm@lists.01.org>; Wed,  3 Jul 2019 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c5kOloQ+WKclVgeWbSMLX2CoWuvmPxmxrcEhF8nzqns=; b=HV+JnjgFvWKjV4CCm3LWNei+D
 dUQKdFpMgH9c7rrzBjIXKkcJmHfgvDLB/WAqpvJ85YhAxls3FjsnA0ioLob9VZbnQQJbtcq2/fkgL
 oswHKQkgdurqbO1Lecz3uaI0H1QfUF93Gmia3dxrNobIbd+5s5Hmt2PyB2S+Uo3EgYdV9UMC6BR5h
 uWqfZOlarNzVMFxAFe9LAZVBzLVAMWnzYhg5OI7sbYmYdFyV2+nCogciXfogxQNahbsmIayIytAyg
 w2cjhCNkefcxaW6b9xkLQoMDP/TBLkKdwn0YSfYiXuaLYFvPrq9QgRlCaBW11Tr3+Q4EBFRoQbyw3
 qcfPIWf3A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hihTJ-0000Vu-0v; Wed, 03 Jul 2019 15:47:01 +0000
Date: Wed, 3 Jul 2019 08:47:00 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190703154700.GI1729@bombadil.infradead.org>
References: <CAPcyv4jjqooboxivY=AsfEPhCvxdwU66GpwE9vM+cqrZWvtX3g@mail.gmail.com>
 <CAPcyv4h6HgNE38RF5TxO3C268ZvrxgcPNrPWOt94MnO5gP_pjw@mail.gmail.com>
 <CAPcyv4gwd1_VHk_MfHeNSxyH+N1=aatj9WkKXqYNPkSXe4bFDg@mail.gmail.com>
 <20190627195948.GB4286@bombadil.infradead.org>
 <CAPcyv4iB3f1hDdCsw=Cy234dP-RXpxGyXDoTwEU8nt5qUDEVQg@mail.gmail.com>
 <20190629160336.GB1180@bombadil.infradead.org>
 <CAPcyv4ge3Ht1k_v=tSoVA6hCzKg1N3imhs_rTL3oTB+5_KC8_Q@mail.gmail.com>
 <CAA9_cmcb-Prn6CnOx-mJfb9CRdf0uG9u4M1Vq1B1rKVemCD-Vw@mail.gmail.com>
 <20190630152324.GA15900@bombadil.infradead.org>
 <20190701121119.GE31621@quack2.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190701121119.GE31621@quack2.suse.cz>
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
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jul 01, 2019 at 02:11:19PM +0200, Jan Kara wrote:
> BTW, looking into the xarray code, I think I found another difference
> between the old radix tree code and the new xarray code that could cause
> issues. In the old radix tree code if we tried to insert PMD entry but
> there was some PTE entry in the covered range, we'd get EEXIST error back
> and the DAX fault code relies on this. I don't see how similar behavior is
> achieved by xas_store()...

Are you referring to this?

-               entry = dax_make_locked(0, size_flag | DAX_EMPTY);
-
-               err = __radix_tree_insert(&mapping->i_pages, index,
-                               dax_entry_order(entry), entry);
-               radix_tree_preload_end();
-               if (err) {
-                       xa_unlock_irq(&mapping->i_pages);
-                       /*
-                        * Our insertion of a DAX entry failed, most likely
-                        * because we were inserting a PMD entry and it
-                        * collided with a PTE sized entry at a different
-                        * index in the PMD range.  We haven't inserted
-                        * anything into the radix tree and have no waiters to
-                        * wake.
-                        */
-                       return ERR_PTR(err);
-               }

If so, that can't happen any more because we no longer drop the i_pages
lock while the entry is NULL, so the entry is always locked while the
i_pages lock is dropped.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
