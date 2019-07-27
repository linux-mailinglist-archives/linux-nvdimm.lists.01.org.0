Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D98877C1C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:53:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8467A212E15A7;
	Sat, 27 Jul 2019 14:56:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C085E212B9A9D
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:56:05 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:38 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="164999229"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:53:38 -0700
Subject: [ndctl PATCH v2 00/26] Improvements for namespace
 creation/interrogation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:39:21 -0700
Message-ID: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since v1 [1]:
- Fix up the --human option for 'read-labels' and 'read-infoblock' to
  imply --json (Vishal)

- Add a man page for 'read-infoblock' and update 'read-labels' man page.
  (Vishal)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-February/019916.html

---

What follows is random assortment of ndctl improvements that have been
hiding out in my private tree. There was a v1 "[ndctl PATCH 0/8]
Improve support + testing for labels + info-blocks " back in February,
but the patch kit has tripled in size since then. There was also a major
change in direction on improving the situation around 'section
collision' handling. Rather than more local libnvdimm hacks the problem
was solved at the source in the memory hotplug code with 'sub-section
memory hotplug' support merged for v5.3-rc1. That results in the
previous patch "ndctl/test: Test inter-region collision handling " being
abandoned in favor of "ndctl/test: Exercise sub-section sized namespace
creation/deletion".

In the course of developing that test and addressing Jane's concerns
with ndctl create-namespace behavior, a few more fixups relative to
minimum namespace size are also included.

Other miscellaneous items included in this set:

- A device-mapper unit test to catch simple device-mapper support
  regressions.
- A simple fixup to the monitor to allow it to be suspended (Ctrl+Z)


Given the size and random topics I am open to merging these piecemeal,
or out of order if something needs to be deferred for more fixups.

---

Dan Williams (26):
      ndctl/dimm: Add 'flags' field to read-labels output
      ndctl/dimm: Add --human support to read-labels
      ndctl/build: Drop -Wpointer-arith
      ndctl/namespace: Add read-infoblock command
      ndctl/test: Update dax-dev to handle multiple e820 ranges
      ndctl/test: Make dax.sh more robust vs small namespaces
      ndctl/namespace: Always zero info-blocks
      ndctl/dimm: Support small label reads/writes
      ndctl/dimm: Minimize data-transfer for init-labels
      ndctl/dimm: Add offset and size options to {read,write,zero}-labels
      ndctl/dimm: Limit read-labels with --index option
      ndctl/namespace: Minimize label data transfer for autolabel
      ndctl/namespace: Disable autorecovery of create-namespace failures
      ndctl/namespace: Handle 'create-namespace' in label-less mode
      ndctl/dimm: Fix init-labels success reporting
      ndctl/test: Fix device-dax bus-model detection
      ndctl/test: Checkout device-mapper + dax operation
      ndctl/test: Exercise sub-section sized namespace creation/deletion
      ndctl/namespace: Kill off the legacy mode names
      ndctl/namespace: Introduce mode-to-name and name-to-mode helpers
      ndctl/namespace: Validate namespace size within validate_namespace_options()
      ndctl/namespace: Clarify 16M minimum size requirement
      ndctl/namespace: Report ENOSPC when regions are full
      ndctl/test: Regression test 'failed to track'
      ndctl/namespace: Continue region search on 'missing seed' event
      ndctl/monitor: Allow monitor to be manually moved to the background


 Documentation/ndctl/Makefile.am                |    3 
 Documentation/ndctl/labels-options.txt         |    9 
 Documentation/ndctl/ndctl-create-namespace.txt |    9 
 Documentation/ndctl/ndctl-read-infoblock.txt   |   94 ++++
 Documentation/ndctl/ndctl-read-labels.txt      |    7 
 configure.ac                                   |    1 
 ndctl/action.h                                 |    1 
 ndctl/builtin.h                                |    1 
 ndctl/check.c                                  |   20 -
 ndctl/dimm.c                                   |  111 +++-
 ndctl/lib/dimm.c                               |   85 +++
 ndctl/lib/libndctl.c                           |  111 ++++
 ndctl/lib/libndctl.sym                         |    5 
 ndctl/lib/private.h                            |    4 
 ndctl/libndctl.h                               |   10 
 ndctl/monitor.c                                |    4 
 ndctl/namespace.c                              |  600 ++++++++++++++++++++----
 ndctl/namespace.h                              |   51 ++
 ndctl/ndctl.c                                  |    1 
 test/Makefile.am                               |    5 
 test/core.c                                    |   10 
 test/dax-dev.c                                 |   17 +
 test/dax.sh                                    |    4 
 test/dm.sh                                     |   75 +++
 test/libndctl.c                                |    6 
 test/sub-section.sh                            |   78 +++
 test/track-uuid.sh                             |   41 ++
 util/filter.c                                  |   46 +-
 util/filter.h                                  |    3 
 util/fletcher.h                                |    1 
 util/json.c                                    |    4 
 util/size.h                                    |    1 
 util/util.h                                    |    4 
 33 files changed, 1221 insertions(+), 201 deletions(-)
 create mode 100644 Documentation/ndctl/ndctl-read-infoblock.txt
 create mode 100755 test/dm.sh
 create mode 100755 test/sub-section.sh
 create mode 100755 test/track-uuid.sh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
