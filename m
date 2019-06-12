Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC742608
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 Jun 2019 14:38:02 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A49F121295CB8;
	Wed, 12 Jun 2019 05:38:00 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom;
 client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=linux-nvdimm@lists.01.org 
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6FB0F2194EB77
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 05:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l/g0KnT/EyAvMoDe4YYe+/hlvBi7vzZDEnk1KrMoaBA=; b=LcKAST6BxZ0yaOkpMIf7Enjfj
 6c1UeC9+DtFiAG+4D1XV7S0v/ELkcMzkURVHfKUblrSfnsOxjaT7amrayTl8QE7Smq9tJEjwDCWRd
 cPbbPfreHmLvxItzPtzj01TyLpkUqy/kyuWCUwt7PAmxBBWhSBNFS/O2Q9nWYMpVJEIh8LvtVttjd
 3KNMNDefD5IFT6bWTwg5AiN9UAusMV0sJPpB8YYd7y3pqpMB8efSmNBLxM2eJ58kVJO5XNksaSM2O
 FqwQN4iCqdirubzy0TOiW6r/sZA9NbDScogy2w/raTG/y8nZlf2j6YFQA1y/4Snew3ovKOI6jiSdf
 lwADVwjOA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red
 Hat Linux)) id 1hb2Vl-00060B-5I; Wed, 12 Jun 2019 12:37:53 +0000
Date: Wed, 12 Jun 2019 05:37:53 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC 00/10] RDMA/FS DAX truncate proposal
Message-ID: <20190612123751.GD32656@bombadil.infradead.org>
References: <20190606014544.8339-1-ira.weiny@intel.com>
 <20190606104203.GF7433@quack2.suse.cz>
 <20190606220329.GA11698@iweiny-DESK2.sc.intel.com>
 <20190607110426.GB12765@quack2.suse.cz>
 <20190607182534.GC14559@iweiny-DESK2.sc.intel.com>
 <20190608001036.GF14308@dread.disaster.area>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190608001036.GF14308@dread.disaster.area>
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

On Sat, Jun 08, 2019 at 10:10:36AM +1000, Dave Chinner wrote:
> On Fri, Jun 07, 2019 at 11:25:35AM -0700, Ira Weiny wrote:
> > Are you suggesting that we have something like this from user space?
> > 
> > 	fcntl(fd, F_SETLEASE, F_LAYOUT | F_UNBREAKABLE);
> 
> Rather than "unbreakable", perhaps a clearer description of the
> policy it entails is "exclusive"?
> 
> i.e. what we are talking about here is an exclusive lease that
> prevents other processes from changing the layout. i.e. the
> mechanism used to guarantee a lease is exclusive is that the layout
> becomes "unbreakable" at the filesystem level, but the policy we are
> actually presenting to uses is "exclusive access"...

That's rather different from the normal meaning of 'exclusive' in the
context of locks, which is "only one user can have access to this at
a time".  As I understand it, this is rather more like a 'shared' or
'read' lock.  The filesystem would be the one which wants an exclusive
lock, so it can modify the mapping of logical to physical blocks.

The complication being that by default the filesystem has an exclusive
lock on the mapping, and what we're trying to add is the ability for
readers to ask the filesystem to give up its exclusive lock.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
