Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D2C33FE05
	for <lists+linux-nvdimm@lfdr.de>; Thu, 18 Mar 2021 05:08:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4EABD100EC1D7;
	Wed, 17 Mar 2021 21:08:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CE6C100ED487
	for <linux-nvdimm@lists.01.org>; Wed, 17 Mar 2021 21:08:03 -0700 (PDT)
IronPort-SDR: Rx1HujzYY7SLI87f825EUniyCbJuGm7v7DmzycdDr6ufRVQBt9f0EVTBfmK9yeDkX0D5U/qATz
 ChFrRoHFj9lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="169517640"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="169517640"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:03 -0700
IronPort-SDR: xedkW7m47DneM2lj0B/SURqsM0slD1zr1weIjCPKTRIjhraCuZdK8jDotAnT7nhf2EZn3hR8kC
 P3SNjFE1zdrA==
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400";
   d="scan'208";a="511964232"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:08:03 -0700
Subject: [PATCH 0/3] mm, pmem: Force unmap pmem on surprise remove
From: Dan Williams <dan.j.williams@intel.com>
To: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Date: Wed, 17 Mar 2021 21:08:02 -0700
Message-ID: <161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: Y7KWCN7ASHGCH447LT3BTDA6LIE52CQE
X-Message-ID-Hash: Y7KWCN7ASHGCH447LT3BTDA6LIE52CQE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Shiyang Ruan <ruansy.fnst@fujitsu.com>, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Y7KWCN7ASHGCH447LT3BTDA6LIE52CQE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Summary:

A dax_dev can be unbound from its driver at any time. Unbind can not
fail. The driver-core will always trigger ->remove() and the result from
->remove() is ignored. After ->remove() the driver-core proceeds to tear
down context. The filesystem-dax implementation can leave pfns mapped
after ->remove() if it is triggered while the filesystem is mounted.
Security and data-integrity is forfeit if the dax_dev is repurposed for
another security domain (new filesystem or change device modes), or if
the dax_dev is physically replaced. CXL is a hotplug bus that makes
dax_dev physical replace a real world prospect. 

All dax_dev pfns must be unmapped at remove. Detect the "remove while
mounted" case and trigger memory_failure() over the entire dax_dev
range.

Details:

The get_user_pages_fast() path expects all synchronization to be handled
by the pattern of checking for pte presence, taking a page reference,
and then validating that the pte was stable over that event. The
gup-fast path for devmap / DAX pages additionally attempts to take/hold
a live reference against the hosting pgmap over the page pin. The
rational for the pgmap reference is to synchronize against a dax-device
unbind / ->remove() event, but that is unnecessary if pte invalidation
is guaranteed in the ->remove() path.

Global dax-device pte invalidation *does* happen when the device is in
raw "device-dax" mode where there is a single shared inode to unmap at
remove, but the filesystem-dax path has a large number of actively
mapped inodes unknown to the driver at ->remove() time. So, that unmap
does not happen today for filesystem-dax. However, as Jason points out,
that unmap / invalidation *needs* to happen not only to cleanup
get_user_pages_fast() semantics, but in a future (see CXL) where dax_dev
->remove() is correlated with actual physical removal / replacement the
implications of allowing a physical pfn to be exchanged without tearing
down old mappings are severe (security and data-integrity).

What is not in this patch set is coordination with the dax_kmem driver
to trigger memory_failure() when the dax_dev is onlined as "System
RAM". The remove_memory() API was built with the assumption that
platform firmware negotiates all removal requests and the OS has a
chance to say "no". This is why dax_kmem today simply leaks
request_region() to burn that physical address space for any other
usage until the next reboot on a manual unbind event if the memory can't
be offlined. However a future to make sure that remove_memory() succeeds
after memory_failure() of the same range seems a better semantic than
permanently burning physical address space.

The topic of remove_memory() failures gets to the question of what
happens to active page references when the inopportune ->remove() event
happens. For transient pins the ->remove() event will wait for for all
pins to be dropped before allowing ->remove() to complete. Since
fileystem-dax forbids longterm pins all those pins are transient.
Device-dax, on the other hand, does allow longterm pins which means that
->remove() will hang unless / until the longterm pin is dropped.
Hopefully an unmap_mapping_range() event is sufficient to get the pin
dropped, but I suspect device-dax might need to trigger memory_failure()
as well to get the longterm pin holder to wake up and get out of the
way (TBD).

Lest we repeat the "longterm-pin-revoke" debate, which highlighted that
RDMA devices do not respond well to having context torn down, keep in
mind that this proposal is to do a best effort recovery of an event that
should not happen (surprise removal) under nominal operation.

---

Dan Williams (3):
      mm/memory-failure: Prepare for mass memory_failure()
      mm, dax, pmem: Introduce dev_pagemap_failure()
      mm/devmap: Remove pgmap accounting in the get_user_pages_fast() path


 drivers/dax/super.c      |   15 +++++++++++++++
 drivers/nvdimm/pmem.c    |   10 +++++++++-
 drivers/nvdimm/pmem.h    |    1 +
 include/linux/dax.h      |    5 +++++
 include/linux/memremap.h |    5 +++++
 include/linux/mm.h       |    3 +++
 mm/gup.c                 |   38 ++++++++++++++++----------------------
 mm/memory-failure.c      |   36 +++++++++++++++++++++++-------------
 mm/memremap.c            |   11 +++++++++++
 9 files changed, 88 insertions(+), 36 deletions(-)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
