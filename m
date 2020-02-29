Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39737174935
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:36:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07C371003ECB6;
	Sat, 29 Feb 2020 12:37:04 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 288341007B185
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:37:01 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:09 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="232628648"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:36:09 -0800
Subject: [ndctl PATCH 00/36] Multiple topics / backlog for v68
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 29 Feb 2020 12:20:04 -0800
Message-ID: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: UM2XVCXF5ODEQVCZEHOLLD5BLELB3PZU
X-Message-ID-Hash: UM2XVCXF5ODEQVCZEHOLLD5BLELB3PZU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Biesek <michal.biesek@intel.com>, Auke Kok <auke-jan.h.kok@intel.com>, Jan Kara <jack@suse.cz>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UM2XVCXF5ODEQVCZEHOLLD5BLELB3PZU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes from review:
- Add NDCTL_LIST_LINT to not regress list output (Jeff)
- Add kernel-doc description for ndctl_region_set_align() (Jeff)

---

About half of these have been posted previously, but have been reworked
and revised as they have percolated in my tree relative to other
arriving features. Yes, it is quite a lot to ingest at once, but given
the interdependencies and need to catch up I decided to post it all
together.

The recommendation on how to review is to start with the new tests,
those introduce some new commands, and those new commands introduce some
new library routines. The rest are miscellaneous updates, fixes, and
cleanups.

New tests:
----------
dm.sh: When touching the kernel's core dax infrastructure there are
simple bugs that can be caught by simply firing up a device-mapper dax
configuration.

track-uuid.sh: The kernel bug that lead to this condition of the kernel
garbage collecting the wrong label required a specific namespace
manipulation sequence. Record and replay that sequence against future
kernel updates.

sub-section.sh: Sub-section support adds machinery to add/remove
namespaces on sub-128M boundaries. Force these section collisions and
validate the kernel tracks the mappings.

align.sh: The kernel has grown the ability to align namespace capacity
provisioning at the region level, since the sub-section changes it has
stopped creating namespace with non-zero start_pad, and now it also
needs to enforce up to a 16M minimum alignment on PowerPC. These
alignment requirements / checks need to be balanced against not
regressing currently defined namespaces. Given the kernel will stop
generating problematic configurations by default a tool was needed to
regression test old configs. The new read-infoblock and write-infoblock
commands are added to support that testing and debug.

New commands:
-------------
ndctl read-infoblock: A compliment to read-labels, it can validate and
dump the known infoblock formats in json format. It can also dump the
raw binary infoblock image from a namespace for backup purposes.

ndctl write-infoblock: Generate an fsdax, or devdax infoblock from
passed in parameters. It currently does not support generating btt
infoblocks since that support would also want btt-arena generation
support... maybe in a future update.

New library apis:
-----------------
ndctl_namespace_get_target_node:
ndctl_region_get_target_node: The target_node attribute indicates the
numa node that this memory range would instantiate / join if it were
hot-added via the dax_kmem driver. The target_node is also used to query
platform firmware performance data.

ndctl_region_get_align
ndctl_region_set_align: Support the new alignment settings at the region
level. This augments namespace creation to provision aligned spans of dpa
(device-physical-address).

New command options:
--------------------
ndctl create-namespace: --force: By default ndctl will disallow sub-16M
aligned dax-mode namespace creation to encourage cross-arch
compatibility. However, non-x86 supports 2M aligned namespaces, and
--force will bypass the 16M alignment check.

ndctl create-namespace: --no-autorecover: For debug cases the automatic
cleanup of namespace creation failures destroys some forensic details.
Exit without cleanup when this option is specified.

ndctl list: --configured: The --idle option can be used to enumerate 
namespaces that failed to initialize, but the output is cluttered with
seed devices. The --configured option limits the listing to any
namespace that has capacity allocated.

ndctl list: NDCTL_LIST_LINT (environment variable): Allow environments
to opt-in to 'ndctl list' fixes that structurally change the output
format. This prevents ndctl invalidating scripts that are dependent on
the buggy output.

Fixes:
------
- Multiple fixups to create-namespace error reporting 
- Require 16M minimum size for any non-raw namespace mode
- Fix destruction of tpm.handle in test/security.sh
- Fix ndctl_namespace_get_resource() to return the updated resource base
  after ndctl_namespace_set_size()
- Fix the warning spew from taking the address of a packed structure
  member.


---

Dan Williams (36):
      ndctl/list: Add 'target_node' to region and namespace verbose listings
      ndctl/docs: Fix mailing list sign-up link
      ndctl/list: Drop named list objects from verbose listing
      daxctl/list: Avoid memory operations without resource data
      ndctl/build: Fix distcheck
      ndctl/namespace: Fix destroy-namespace accounting relative to seed devices
      ndctl/region: Support ndctl_region_{get,set}_align()
      ndctl/namespace: Emit better errors on failure
      ndctl/namespace: Check for region alignment violations
      ndctl/util: Up-level is_power_of_2() and introduce IS_ALIGNED
      ndctl/namespace: Validate resource alignment for dax-mode namespaces
      ndctl/namespace: Add read-infoblock command
      ndctl/test: Update dax-dev to handle multiple e820 ranges
      ndctl/namespace: Always zero info-blocks
      ndctl/namespace: Disable autorecovery of create-namespace failures
      ndctl/build: Fix EXTRA_DIST already defined errors
      ndctl/test: Checkout device-mapper + dax operation
      ndctl/test: Exercise sub-section sized namespace creation/deletion
      ndctl/namespace: Kill off the legacy mode names
      ndctl/namespace: Introduce mode-to-name and name-to-mode helpers
      ndctl/namespace: Validate namespace size within validate_namespace_options()
      ndctl/namespace: Clarify 16M minimum size requirement
      ndctl/test: Regression test 'failed to track'
      ndctl/dimm: Rework dimm command status reporting
      ndctl/dimm: Rework iteration to drop unaligned pointers
      ndctl/test: Fix typos / loss of tpm.handle in security test
      ndctl/test: Relax dax_pmem_compat requirement
      ndctl/namespace: Fix namespace-action vs namespace-mode confusion
      ndctl/namespace: Update 'pfn' infoblock definition
      ndctl/util: Return 0 for NULL arguments to parse_size64()
      ndctl/namespace: Fix read-info-block vs read-infoblock
      ndctl/namespace: Parse infoblocks from stdin
      ndctl/namespace: Add write-infoblock command
      ndctl/list: Add option to list configured + disabled namespaces
      ndctl/lib/namespace: Fix resource retrieval after size change
      ndctl/test: Regression test misaligned namespaces


 CONTRIBUTING.md                                |    2 
 Documentation/ndctl/Makefile.am                |    4 
 Documentation/ndctl/ndctl-create-namespace.txt |   17 
 Documentation/ndctl/ndctl-list.txt             |   64 +
 Documentation/ndctl/ndctl-read-infoblock.txt   |   94 ++
 Documentation/ndctl/ndctl-write-infoblock.txt  |  132 +++
 ndctl/action.h                                 |    2 
 ndctl/builtin.h                                |    2 
 ndctl/check.c                                  |   20 
 ndctl/lib/ars.c                                |   34 +
 ndctl/lib/hpe1.c                               |   17 
 ndctl/lib/hyperv.c                             |    7 
 ndctl/lib/intel.c                              |   56 +
 ndctl/lib/libndctl.c                           |  191 ++++
 ndctl/lib/libndctl.sym                         |    4 
 ndctl/lib/msft.c                               |    8 
 ndctl/lib/nfit.c                               |   36 +
 ndctl/lib/private.h                            |   16 
 ndctl/libndctl-nfit.h                          |   11 
 ndctl/libndctl.h                               |    5 
 ndctl/list.c                                   |   59 +
 ndctl/namespace.c                              | 1050 +++++++++++++++++++++---
 ndctl/namespace.h                              |   61 +
 ndctl/ndctl.c                                  |    2 
 test/Makefile.am                               |   14 
 test/align.sh                                  |  118 +++
 test/blk-exhaust.sh                            |    2 
 test/blk_namespaces.c                          |    1 
 test/btt-check.sh                              |    2 
 test/btt-errors.sh                             |    7 
 test/btt-pad-compat.sh                         |    5 
 test/clear.sh                                  |    2 
 test/core.c                                    |    8 
 test/create.sh                                 |    2 
 test/dax-dev.c                                 |   17 
 test/dax.sh                                    |    2 
 test/daxctl-devices.sh                         |    2 
 test/daxdev-errors.sh                          |    2 
 test/device-dax-fio.sh                         |    2 
 test/dm.sh                                     |   75 ++
 test/dpa-alloc.c                               |   10 
 test/dsm-fail.c                                |    5 
 test/firmware-update.sh                        |    2 
 test/inject-error.sh                           |    2 
 test/inject-smart.sh                           |    2 
 test/label-compat.sh                           |    5 
 test/libndctl.c                                |   16 
 test/max_available_extent_ns.sh                |    2 
 test/mmap.sh                                   |    2 
 test/monitor.sh                                |    2 
 test/multi-dax.sh                              |    2 
 test/parent-uuid.c                             |    1 
 test/pfn-meta-errors.sh                        |    2 
 test/pmem-errors.sh                            |   11 
 test/rescan-partitions.sh                      |    2 
 test/sector-mode.sh                            |    2 
 test/security.sh                               |    6 
 test/sub-section.sh                            |   77 ++
 test/track-uuid.sh                             |   40 +
 util/filter.c                                  |   46 +
 util/filter.h                                  |    3 
 util/fletcher.h                                |    1 
 util/json.c                                    |   18 
 util/json.h                                    |    1 
 util/size.c                                    |    2 
 util/size.h                                    |    8 
 66 files changed, 2112 insertions(+), 313 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-read-infoblock.txt
 create mode 100644 Documentation/ndctl/ndctl-write-infoblock.txt
 create mode 100755 test/align.sh
 create mode 100755 test/dm.sh
 create mode 100755 test/sub-section.sh
 create mode 100755 test/track-uuid.sh

base-commit: 56f4a91b51b532fcdb8b44ace422dce48ed27c7d
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
