Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA3498402
	for <lists+linux-nvdimm@lfdr.de>; Wed, 21 Aug 2019 21:09:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C490020213F0E;
	Wed, 21 Aug 2019 12:10:15 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1A6942020F94B
 for <linux-nvdimm@lists.01.org>; Wed, 21 Aug 2019 12:10:14 -0700 (PDT)
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Aug 2019 12:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; d="scan'208";a="178594638"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2019 12:09:04 -0700
Date: Wed, 21 Aug 2019 12:09:04 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ; -)
Message-ID: <20190821190904.GD5965@iweiny-DESK2.sc.intel.com>
References: <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area>
 <ae64491b-85f8-eeca-14e8-2f09caf8abd2@nvidia.com>
 <20190820012021.GQ7777@dread.disaster.area>
 <84318b51-bd07-1d9b-d842-e65cac2ff484@nvidia.com>
 <20190820033608.GB1119@dread.disaster.area>
 <29c89d84-d847-0221-70a7-9e5a3d472cda@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <29c89d84-d847-0221-70a7-9e5a3d472cda@nvidia.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 linux-nvdimm@lists.01.org, linux-rdma@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Aug 21, 2019 at 11:43:30AM -0700, John Hubbard wrote:
> On 8/19/19 8:36 PM, Dave Chinner wrote:
> > On Mon, Aug 19, 2019 at 08:09:33PM -0700, John Hubbard wrote:
> > > On 8/19/19 6:20 PM, Dave Chinner wrote:
> > > > On Mon, Aug 19, 2019 at 05:05:53PM -0700, John Hubbard wrote:
> > > > > On 8/19/19 2:24 AM, Dave Chinner wrote:
> > > > > > On Mon, Aug 19, 2019 at 08:34:12AM +0200, Jan Kara wrote:
> > > > > > > On Sat 17-08-19 12:26:03, Dave Chinner wrote:
> > > > > > > > On Fri, Aug 16, 2019 at 12:05:28PM -0700, Ira Weiny wrote:
> > > > > > > > > On Thu, Aug 15, 2019 at 03:05:58PM +0200, Jan Kara wrote:
> > > > > > > > > > On Wed 14-08-19 11:08:49, Ira Weiny wrote:
> > > > > > > > > > > On Wed, Aug 14, 2019 at 12:17:14PM +0200, Jan Kara wrote:
> > > > > ...
> > AFAIA, there is no struct file here - the memory that has been pinned
> > is just something mapped into the application's address space.
> > 
> > It seems to me that the socket here is equivalent of the RDMA handle
> > that that owns the hardware that pins the pages. Again, that RDMA
> > handle is not aware of waht the mapping represents, hence need to
> > hold a layout lease if it's a file mapping.
> > 
> > SO from the filesystem persepctive, there's no difference between
> > XDP or RDMA - if it's a FSDAX mapping then it is DMAing directly
> > into the filesystem's backing store and that will require use of
> > layout leases to perform safely.
> > 
> 
> OK, got it! Makes perfect sense.

Just to chime in here... Yea from the FS perspective it is the same.

But on the driver side it is more complicated because of how the references to
the pins can be shared among other processes.

See the other branch of this thread

https://lkml.org/lkml/2019/8/21/828

Ira

> 
> thanks,
> -- 
> John Hubbard
> NVIDIA
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
