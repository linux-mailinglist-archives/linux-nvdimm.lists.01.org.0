Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E3F43B46
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 17:28:04 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 794EA212966E6;
	Thu, 13 Jun 2019 08:28:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80B7B21959CB2
 for <linux-nvdimm@lists.01.org>; Thu, 13 Jun 2019 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vn04L/39CxGmnFvWZbLFG3AukuBPlzgMR3HJ4g3XYMs=; b=tHlQpyqzo7ZQBVB5wRrQJI46t
 aGvrn7sclf7JSvki0K76DhAQ9grt++rr3RsyMukb0ZOE6ao5QkZuVltTGW0kSmf01kovvUtAmSiMC
 FRCnkWcmo+pTrNeUZtpZy52SEQbCrGAv6HRyCq081N6v+J6AluX52Ap/rjGwfAbZNww9f9q25CrJ4
 2/28x8clrMHc5fH8S/5jQZoozJIYzfzvecMqlkikJzXv1MdjRaDtLgMF0+C/+TZhLxUqIdCboLufF
 QARq/0WKMHCQBh07+I4aQgQBCb/hzuiZZD053C7PNwE5NpsajGwqxDMtci1Q9lcRzIGXjOlZwRRQS
 8bRUD+XPw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hbRdr-0002TD-Ht; Thu, 13 Jun 2019 15:27:55 +0000
Date: Thu, 13 Jun 2019 08:27:55 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190613152755.GI32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
 <20190612123751.GD32656@bombadil.infradead.org>
 <20190613002555.GH14363@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613002555.GH14363@dread.disaster.area>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Thu, Jun 13, 2019 at 10:25:55AM +1000, Dave Chinner wrote:
> e.g. Process A has an exclusive layout lease on file F. It does an
> IO to file F. The filesystem IO path checks that Process A owns the
> lease on the file and so skips straight through layout breaking
> because it owns the lease and is allowed to modify the layout. It
> then takes the inode metadata locks to allocate new space and write
> new data.
> 
> Process B now tries to write to file F. The FS checks whether
> Process B owns a layout lease on file F. It doesn't, so then it
> tries to break the layout lease so the IO can proceed. The layout
> breaking code sees that process A has an exclusive layout lease
> granted, and so returns -ETXTBSY to process B - it is not allowed to
> break the lease and so the IO fails with -ETXTBSY.

This description doesn't match the behaviour that RDMA wants either.
Even if Process A has a lease on the file, an IO from Process A which
results in blocks being freed from the file is going to result in the
RDMA device being able to write to blocks which are now freed (and
potentially reallocated to another file).
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
