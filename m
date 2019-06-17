Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7347A93
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 Jun 2019 09:15:56 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4BBC421295C9B;
	Mon, 17 Jun 2019 00:15:55 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=batv+a9ecd0bfb5b639be820a+5776+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A34FE2128D6B8
 for <linux-nvdimm@lists.01.org>; Mon, 17 Jun 2019 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gpRMsfGNXtpOHyXo1HHqlE0dlVAyPKBRJRDhBOKV9jk=; b=ciyWTDMrwSY3eNjL+rF5wFxvY
 Hk0lkKZBcBzvIMyNlZFE0NW6MIWRBlxlwnMDVqs7KohK9iSwbzBy5AnCQbGRDRPTaWJDWsBEHbf6S
 x2vJX1VhVXZiH6spDpYQwXl6RqXuKAeRagnraCMYavKvp+Sc/fsLkO/AHgrZtGSgDWkuGS781Vuej
 UCWQr0KsCKYjfN/XoK5gwW2s3OqBX2wib/0PrlfQSff+SB3cwgBxTivqhBuUUuo0TcpdenkP5mOgs
 nBHx8IXK+RndchBTpjqETN8U02sGo2U3SxhTEnnzA9GKAfbuiopJf2aHzCHL+/P6NlBB+1co33y6L
 VDNnrnyjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hclrT-0005ke-Jx; Mon, 17 Jun 2019 07:15:27 +0000
Date: Mon, 17 Jun 2019 00:15:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
Message-ID: <20190617071527.GA14003@infradead.org>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-6-alastair@au1.ibm.com>
 <20190617065921.GV3436@hirez.programming.kicks-ass.net>
 <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>,
 David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Jiri Kosina <jkosina@suse.cz>, Mukesh Ojha <mojha@codeaurora.org>,
 Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Arun KS <arunks@codeaurora.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Qian Cai <cai@lca.pw>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 17, 2019 at 05:05:30PM +1000, Alastair D'Silva wrote:
> On Mon, 2019-06-17 at 08:59 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > If an external driver module supplies physical memory and needs to
> > > expose
> > 
> > Why would you ever want to allow a module to do such a thing?
> > 
> 
> I'm working on a driver for Storage Class Memory, connected via an
> OpenCAPI link.
> 
> The memory is only usable once the card says it's OK to access it.

And all that should go through our pmem APIs, not not directly
poke into mm internals.  And if you still need core patches send them
along with the actual driver.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
