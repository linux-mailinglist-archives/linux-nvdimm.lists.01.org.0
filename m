Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E89DDC20
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Oct 2019 05:23:45 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBFAA1007B5C2;
	Sat, 19 Oct 2019 20:25:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7C3441007B5C0
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 20:25:36 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 20:23:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,318,1566889200";
   d="scan'208";a="187207938"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
  by orsmga007.jf.intel.com with ESMTP; 19 Oct 2019 20:23:39 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 00/10] fixes and movability for system-ram mode
Date: Sat, 19 Oct 2019 21:23:22 -0600
Message-Id: <20191020032332.16776-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Message-ID-Hash: FBSCZ3XJUMMARPRDSOHG6QT2IJXYUIXS
X-Message-ID-Hash: FBSCZ3XJUMMARPRDSOHG6QT2IJXYUIXS
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Ben Olson <ben.olson@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FBSCZ3XJUMMARPRDSOHG6QT2IJXYUIXS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v2:
- Change MEM_FIND_ZONE to MEM_GET_ZONE (Dan)
- Remove the verbose race warning from runtime and just point to the man
  page (Dan)
- Remove the short option for '--no-movable' (Dan)

This patchset improves the user experience around memory onlining,
specifically the state it is onlined in - movable vs non-movable. It
also adds an option to make the memory non-movable when onlining.

Patches 1-3 perform some preparatory and clean up steps.
Patches 4-6 add a way to determine and display the 'movable' vs
'non-movable' state of memory.
Patches 7-8 attempt to detect a race with memory onlining, and add a
Documentation clarification
Patches 9-10 Add the new --no-movable option to commands that may
online memory.

Vishal Verma (10):
  libdaxctl: refactor path construction in op_for_one_memblock()
  libdaxctl: refactor memblock_is_online() checks
  daxctl/device.c: fix json output omission for reconfigure-device
  libdaxctl: add an API to determine if memory is movable
  libdaxctl: allow memblock_in_dev() to return an error
  daxctl: show a 'movable' attribute in device listings
  daxctl: detect races when onlining memory blocks
  Documentation: clarify memory movablity for reconfigure-device
  libdaxctl: add an API to online memory in a non-movable state
  daxctl: add --no-movable option for onlining memory

 Documentation/daxctl/daxctl-online-memory.txt |   2 +
 .../daxctl/daxctl-reconfigure-device.txt      |  24 +-
 Documentation/daxctl/movable-options.txt      |   9 +
 daxctl/device.c                               |  45 ++-
 daxctl/lib/libdaxctl-private.h                |  26 ++
 daxctl/lib/libdaxctl.c                        | 277 +++++++++++++-----
 daxctl/lib/libdaxctl.sym                      |   6 +
 daxctl/libdaxctl.h                            |   2 +
 util/json.c                                   |  14 +-
 9 files changed, 320 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/daxctl/movable-options.txt

-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
