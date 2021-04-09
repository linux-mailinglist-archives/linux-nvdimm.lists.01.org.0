Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9135A3AA
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:43:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AABF7100EB32D;
	Fri,  9 Apr 2021 09:43:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78248100EB330
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:43:54 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id E7F80B10B;
	Fri,  9 Apr 2021 16:43:52 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 00/16] bcache: support NVDIMM for journaling
Date: Sat, 10 Apr 2021 00:43:27 +0800
Message-Id: <20210409164343.56828-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: A4OVJUNNILYMBASOXH6HGB3P6U5VAS53
X-Message-ID-Hash: A4OVJUNNILYMBASOXH6HGB3P6U5VAS53
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A4OVJUNNILYMBASOXH6HGB3P6U5VAS53/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is the 7th effort for bcache to support NVDIMM for jouranling since
the first nvm-pages series was posted.

This series is combination of the v7 nvm-pages allocator developed by
Intel developers and related bcache changes from me.

The nvm-pages allocator is a buddy-like allocator, which allocates size
in power-of-2 pages from the NVDIMM namespace. User space tool 'bcache'
has a new added '-M' option to format a NVDIMM namespace and register it
via sysfs interface as a bcache meta device. The nvm-pages kernel code
does a DAX mapping to map the whole namespace into system's memory
address range, and allocating the pages to requestion like typical buddy
allocator does. The major difference is nvm-pages allocator maintains
the pages allocated to each requester by a owner list which stored on
NVDIMM too. Owner list of different requester is tracked by a pre-
defined UUID, all the pages tracked in all owner lists are treated as
allocated busy pages and won't be initialized into buddy system after
the system reboot.

The bcache journal code may request a block of power-of-2 size pages
from the nvm-pages allocator, normally it is a range of 256MB or 512MB
continuous pages range. During meta data journaling, the in-memory jsets
go into the calculated nvdimm pages location by kernel memcpy routine.
So the journaling I/Os won't go into block device (e.g. SSD) anymore, 
the write and read for journal jsets happen on NVDIMM.

The nvm-pages on-NVDIMM data structures are defined as legacy in-memory
objects, because they ARE in-memory objects directly referenced by
linear addresses, both in system DRAM and NVDIMM. They are defined in
the following patch,
- bcache: add initial data structures for nvm pages

Intel developers Jianpeng Ma and Qiaowei Ren compose the initial code of
nvm-pages, the related patches are,
- bcache: initialize the nvm pages allocator
- bcache: initialization of the buddy
- bcache: bch_nvm_alloc_pages() of the buddy
- bcache: bch_nvm_free_pages() of the buddy
- bcache: get allocated pages from specific owner
All the code depends on Linux libnvdimm and dax drivers, the bcache nvm-
pages allocator can be treated as user of these two drivers.

I modify the bcache code to recognize the nvm meta device feature,
initialize journal on NVDIMM, and do journal I/Os on NVDIMM in the
following patches,
- bcache: add initial data structures for nvm pages
- bcache: use bucket index to set GC_MARK_METADATA for journal buckets
  in bch_btree_gc_finish()
- bcache: add BCH_FEATURE_INCOMPAT_NVDIMM_META into incompat feature set
- bcache: initialize bcache journal for NVDIMM meta device
- bcache: support storing bcache journal into NVDIMM meta device
- bcache: read jset from NVDIMM pages for journal replay
- bcache: add sysfs interface register_nvdimm_meta to register NVDIMM
  meta device

Also during the code integration and testing, there are some issues are
fixed by the following patches,
- bcache: nvm-pages fixes for bcache integration testing
- bcache: use div_u64() in init_owner_info()
- bcache: fix BCACHE_NVM_PAGES' dependences in Kconfig
- bcache: more fix for compiling error when BCACHE_NVM_PAGES disabled
The above patches can be added or merged into nvm-pages code, so that
they can be dropped in next version of this series.

Current series works as expected, of course it is not perfect but the
state is fine as a code base for further improvement. For example the
power failure tolerance for nvm-pages owner list operations, more error
handling for journal code, and moving the B+ tree node I/Os into NVDIMM.

All the code is EXPERIMENTAL, they won't be enabled by default until we
feel the NVDIMM support is completed and stable.

Any comments and suggestion is warmly welcome :-)

Thank you in advance.

Coly Li

---
Changelog:
v7: Refine nvm-pages allocator code to operate owner list directly in
    dax mapped NVDIMM pages, and remove the meta data copy from DRAM.
v6: The series submitted but not merged in Linux 5.12 merge window.
v1-v5: RFC patches of bcache nvm-pages.


Coly Li (11):
  bcache: add initial data structures for nvm pages
  bcache: nvm-pages fixes for bcache integration testing
  bcache: use bucket index to set GC_MARK_METADATA for journal buckets
    in bch_btree_gc_finish()
  bcache: add BCH_FEATURE_INCOMPAT_NVDIMM_META into incompat feature set
  bcache: initialize bcache journal for NVDIMM meta device
  bcache: support storing bcache journal into NVDIMM meta device
  bcache: read jset from NVDIMM pages for journal replay
  bcache: add sysfs interface register_nvdimm_meta to register NVDIMM
    meta device
  bcache: use div_u64() in init_owner_info()
  bcache: fix BCACHE_NVM_PAGES' dependences in Kconfig
  bcache: more fix for compiling error when BCACHE_NVM_PAGES disabled

Jianpeng Ma (5):
  bcache: initialize the nvm pages allocator
  bcache: initialization of the buddy
  bcache: bch_nvm_alloc_pages() of the buddy
  bcache: bch_nvm_free_pages() of the buddy
  bcache: get allocated pages from specific owner

 drivers/md/bcache/Kconfig       |   9 +
 drivers/md/bcache/Makefile      |   2 +-
 drivers/md/bcache/btree.c       |   6 +-
 drivers/md/bcache/features.h    |   9 +
 drivers/md/bcache/journal.c     | 317 +++++++++++---
 drivers/md/bcache/journal.h     |   2 +-
 drivers/md/bcache/nvm-pages.c   | 744 ++++++++++++++++++++++++++++++++
 drivers/md/bcache/nvm-pages.h   |  95 ++++
 drivers/md/bcache/super.c       |  73 +++-
 include/uapi/linux/bcache-nvm.h | 208 +++++++++
 10 files changed, 1392 insertions(+), 73 deletions(-)
 create mode 100644 drivers/md/bcache/nvm-pages.c
 create mode 100644 drivers/md/bcache/nvm-pages.h
 create mode 100644 include/uapi/linux/bcache-nvm.h

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
