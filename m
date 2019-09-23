Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B3BBC04
	for <lists+linux-nvdimm@lfdr.de>; Mon, 23 Sep 2019 21:08:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B4AF21962301;
	Mon, 23 Sep 2019 12:11:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.115; helo=mga14.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4AD50202ECFB6
 for <linux-nvdimm@lists.01.org>; Mon, 23 Sep 2019 12:11:22 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Sep 2019 12:08:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; d="scan'208";a="213426723"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2019 12:08:53 -0700
Date: Mon, 23 Sep 2019 12:08:53 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: Lease semantic proposal
Message-ID: <20190923190853.GA3781@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Theodore Ts'o <tytso@mit.edu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Since the last RFC patch set[1] much of the discussion of supporting RDMA with
FS DAX has been around the semantics of the lease mechanism.[2]  Within that
thread it was suggested I try and write some documentation and/or tests for the
new mechanism being proposed.  I have created a foundation to test lease
functionality within xfstests.[3] This should be close to being accepted.
Before writing additional lease tests, or changing lots of kernel code, this
email presents documentation for the new proposed "layout lease" semantic.

At Linux Plumbers[4] just over a week ago, I presented the current state of the
patch set and the outstanding issues.  Based on the discussion there, well as
follow up emails, I propose the following addition to the fcntl() man page.

Thank you,
Ira

[1] https://lkml.org/lkml/2019/8/9/1043
[2] https://lkml.org/lkml/2019/8/9/1062
[3] https://www.spinics.net/lists/fstests/msg12620.html
[4] https://linuxplumbersconf.org/event/4/contributions/368/


<fcntl man page addition>
Layout Leases
-------------

Layout (F_LAYOUT) leases are special leases which can be used to control and/or
be informed about the manipulation of the underlying layout of a file.

A layout is defined as the logical file block -> physical file block mapping
including the file size and sharing of physical blocks among files.  Note that
the unwritten state of a block is not considered part of file layout.

**Read layout lease F_RDLCK | F_LAYOUT**

Read layout leases can be used to be informed of layout changes by the
system or other users.  This lease is similar to the standard read (F_RDLCK)
lease in that any attempt to change the _layout_ of the file will be reported to
the process through the lease break process.  But this lease is different
because the file can be opened for write and data can be read and/or written to
the file as long as the underlying layout of the file does not change.
Therefore, the lease is not broken if the file is simply open for write, but
_may_ be broken if an operation such as, truncate(), fallocate() or write()
results in changing the underlying layout.

**Write layout lease (F_WRLCK | F_LAYOUT)**

Write Layout leases can be used to break read layout leases to indicate that
the process intends to change the underlying layout lease of the file.

A process which has taken a write layout lease has exclusive ownership of the
file layout and can modify that layout as long as the lease is held.
Operations which change the layout are allowed by that process.  But operations
from other file descriptors which attempt to change the layout will break the
lease through the standard lease break process.  The F_LAYOUT flag is used to
indicate a difference between a regular F_WRLCK and F_WRLCK with F_LAYOUT.  In
the F_LAYOUT case opens for write do not break the lease.  But some operations,
if they change the underlying layout, may.

The distinction between read layout leases and write layout leases is that
write layout leases can change the layout without breaking the lease within the
owning process.  This is useful to guarantee a layout prior to specifying the
unbreakable flag described below.


**Unbreakable Layout Leases (F_UNBREAK)**

In order to support pinning of file pages by direct user space users an
unbreakable flag (F_UNBREAK) can be used to modify the read and write layout
lease.  When specified, F_UNBREAK indicates that any user attempting to break
the lease will fail with ETXTBUSY rather than follow the normal breaking
procedure.

Both read and write layout leases can have the unbreakable flag (F_UNBREAK)
specified.  The difference between an unbreakable read layout lease and an
unbreakable write layout lease are that an unbreakable read layout lease is
_not_ exclusive.  This means that once a layout is established on a file,
multiple unbreakable read layout leases can be taken by multiple processes and
used to pin the underlying pages of that file.

Care must therefore be taken to ensure that the layout of the file is as the
user wants prior to using the unbreakable read layout lease.  A safe mechanism
to do this would be to take a write layout lease and use fallocate() to set the
layout of the file.  The layout lease can then be "downgraded" to unbreakable
read layout as long as no other user broke the write layout lease.

</fcntl man page addition>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
