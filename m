Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B8180356
	for <lists+linux-nvdimm@lfdr.de>; Sat,  3 Aug 2019 02:08:43 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0AA2E21314728;
	Fri,  2 Aug 2019 17:11:12 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 304DF21311BE1
 for <linux-nvdimm@lists.01.org>; Fri,  2 Aug 2019 17:11:10 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2019 17:08:39 -0700
X-IronPort-AV: E=Sophos;i="5.64,340,1559545200"; d="scan'208";a="257133520"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Aug 2019 17:08:40 -0700
Subject: [ndctl PATCH v3 0/8] Improvements for namespace creation/interrogation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 02 Aug 2019 16:54:22 -0700
Message-ID: <156479006271.707590.298793474092813749.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Changes since v2 [1]:
- Drop the patches that have already been applied to the 'pending' branch
- Rebase the dimm extent series and the small 'create-namespace' fixlets
- Move the new libndctl apis to the next library symbol version (Vishal)
- Defer the following to a post ndctl-v66 release:

      ndctl/namespace: Add read-infoblock command
      ndctl/test: Update dax-dev to handle multiple e820 ranges
      ndctl/test: Make dax.sh more robust vs small namespaces
      ndctl/namespace: Always zero info-blocks
      ndctl/namespace: Disable autorecovery of create-namespace failures
      ndctl/test: Checkout device-mapper + dax operation
      ndctl/test: Exercise sub-section sized namespace creation/deletion
      ndctl/namespace: Kill off the legacy mode names
      ndctl/namespace: Introduce mode-to-name and name-to-mode helpers
      ndctl/namespace: Validate namespace size within validate_namespace_options()
      ndctl/namespace: Clarify 16M minimum size requirement

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-July/022766.html

---

This trimmed version includes the extent support for label operations
which significantly speeds up common label operations like
'init-labels'. It also fixes up some surprising results from
'create-namespace' where it would fail even though available capacity is
present. Lastly it suppresses a new warning found in Fedora Rawhide
builds that has moved to gcc 9.1.1.

---

Dan Williams (8):
      ndctl/build: Suppress -Waddress-of-packed-member
      ndctl/dimm: Support small label reads/writes
      ndctl/dimm: Minimize data-transfer for init-labels
      ndctl/dimm: Add offset and size options to {read,write,zero}-labels
      ndctl/dimm: Limit read-labels with --index option
      ndctl/namespace: Minimize label data transfer for autolabel
      ndctl/namespace: Continue region search on 'missing seed' event
      ndctl/namespace: Report ENOSPC when regions are full


 Documentation/ndctl/labels-options.txt    |    9 ++
 Documentation/ndctl/ndctl-read-labels.txt |    7 ++
 configure.ac                              |    1 
 ndctl/dimm.c                              |   92 +++++++++++++++++--------
 ndctl/lib/dimm.c                          |   85 +++++++++++++++++++++--
 ndctl/lib/libndctl.c                      |  108 +++++++++++++++++++++++++----
 ndctl/lib/libndctl.sym                    |    9 ++
 ndctl/lib/private.h                       |    4 -
 ndctl/libndctl.h                          |    9 ++
 ndctl/namespace.c                         |   13 +++
 util/util.h                               |    4 +
 11 files changed, 286 insertions(+), 55 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
