Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27852582A9
	for <lists+linux-nvdimm@lfdr.de>; Thu, 27 Jun 2019 14:34:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7EB7E212AAB72;
	Thu, 27 Jun 2019 05:34:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C083821297063
 for <linux-nvdimm@lists.01.org>; Thu, 27 Jun 2019 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQUdy9qv7ABtkbJ3dGIuBeaEJk7dGMp7ONsxEfM/sUo=; b=GB++/qHL9hKxCF/RRNMnajjsu
 xKIvNL4xju2zGJKLaeidmxAup1NRvdhZjR3qz5yxAEki0voDqhp3K+7wBftYKcCS72jZrOA4UebYR
 6L73m6dtLHtZnrVEgDp+vgb4NX2jCDSJ9Wkb8IubBlfTXdwBFfLTnU/lJAH6LMyDKYsLpBbJO1qgw
 lgCL8lJdNVBxGDTi+PaQfAnimGwjCx09EVneNK413YhsRaMygyBBhgr74JEXnMhv92HXfD4mqTLlZ
 y4VGOKeHb8nEXmqYQzy2b65mZZ7IR8LavdkAcrSMkldtnd15+4M6uzfMhCcV+Okn/QUGtYvSJY5gx
 QaMJ3DiKw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hgTbT-00045v-KE; Thu, 27 Jun 2019 12:34:15 +0000
Date: Thu, 27 Jun 2019 05:34:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] filesystem-dax: Disable PMD support
Message-ID: <20190627123415.GA4286@bombadil.infradead.org>
References: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <156159454541.2964018.7466991316059381921.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: Seema Pandit <seema.pandit@intel.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Robert Barror <robert.barror@intel.com>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jun 26, 2019 at 05:15:45PM -0700, Dan Williams wrote:
> Ever since the conversion of DAX to the Xarray a RocksDB benchmark has
> been encountering intermittent lockups. The backtraces always include
> the filesystem-DAX PMD path, multi-order entries have been a source of
> bugs in the past, and disabling the PMD path allows a test that fails in
> minutes to run for an hour.

On May 4th, I asked you:

Since this is provoked by a fatal signal, it must have something to do
with a killable or interruptible sleep.  There's only one of those in the
DAX code; fatal_signal_pending() in dax_iomap_actor().  Does rocksdb do
I/O with write() or through a writable mmap()?  I'd like to know before
I chase too far down this fault tree analysis.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
