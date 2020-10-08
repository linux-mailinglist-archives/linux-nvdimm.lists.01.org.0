Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA14287C86
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Oct 2020 21:33:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 12630153BFF7A;
	Thu,  8 Oct 2020 12:33:14 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 390D0153BFF79
	for <linux-nvdimm@lists.01.org>; Thu,  8 Oct 2020 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BHYNWcWHIFZvVZFOrN5msKH7zebNjbiD4DhvwYAYv8g=; b=WtKqtTYFnWStgYMZ2Ii4ZkWL/J
	5VcSFFsPi/0uUCZ3Bgy/wKp/PsALEneWOFem2MTRPmtdVymmgotP68cHfrWos4OuKduHZzIl2zIJQ
	BOBnSQ4xy9IoePSftqZq5TxYBwXQMESJQV2wHwivsBCp2EbN9chVJcBPnDXfGN5RM6WDESexMEZxb
	TXsk60h68uXyRkqnspvPQW+qo7o1BntcHL6TQunHEk3ssVMKe8dNpqK/lrfAp+s88E4IvchIrBr9H
	YiMRHY+ZMGDBLQSMtL41gw2gCHd2dq1pk93L5VH8nbEUUgkGbIv9QpJSLfgsmkK8HPkgcMOyHVNw0
	ovZZsPHw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQbev-0007bI-Rb; Thu, 08 Oct 2020 19:33:01 +0000
Date: Thu, 8 Oct 2020 20:33:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 0/4] Remove nrexceptional tracking
Message-ID: <20201008193301.GN20115@casper.infradead.org>
References: <20200804161755.10100-1-willy@infradead.org>
 <898e058f12c7340703804ed9d05df5ead9ecb50d.camel@intel.com>
 <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ee26fdf05127b7aea69db9d025d6ba5e677479bb.camel@intel.com>
Message-ID-Hash: 7VITH3BPDCIKEZOY434N7CDGNFBPKSAL
X-Message-ID-Hash: 7VITH3BPDCIKEZOY434N7CDGNFBPKSAL
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7VITH3BPDCIKEZOY434N7CDGNFBPKSAL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Aug 06, 2020 at 08:16:02PM +0000, Verma, Vishal L wrote:
> On Thu, 2020-08-06 at 19:44 +0000, Verma, Vishal L wrote:
> > > 
> > > I'm running xfstests on this patchset right now.  If one of the DAX
> > > people could try it out, that'd be fantastic.
> > > 
> > > Matthew Wilcox (Oracle) (4):
> > >   mm: Introduce and use page_cache_empty
> > >   mm: Stop accounting shadow entries
> > >   dax: Account DAX entries as nrpages
> > >   mm: Remove nrexceptional from inode
> > 
> > Hi Matthew,
> > 
> > I applied these on top of 5.8 and ran them through the nvdimm unit test
> > suite, and saw some test failures. The first failing test signature is:
> > 
> >   + umount test_dax_mnt
> >   ./dax-ext4.sh: line 62: 15749 Segmentation fault      umount $MNT
> >   FAIL dax-ext4.sh (exit status: 139)

Thanks.  Fixed:

+++ b/fs/dax.c
@@ -644,7 +644,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
                goto out;
        dax_disassociate_entry(entry, mapping, trunc);
        xas_store(&xas, NULL);
-       mapping->nrpages -= dax_entry_order(entry);
+       mapping->nrpages -= 1UL << dax_entry_order(entry);
        ret = 1;
 out:
        put_unlocked_entry(&xas, entry);

Updated git tree at
https://git.infradead.org/users/willy/pagecache.git/

It survives an xfstests run on an fsdax namespace which supports 2MB pages.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
