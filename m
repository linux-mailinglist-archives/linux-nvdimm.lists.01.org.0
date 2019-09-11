Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B49B00CA
	for <lists+linux-nvdimm@lfdr.de>; Wed, 11 Sep 2019 18:03:20 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D15CB21962301;
	Wed, 11 Sep 2019 09:03:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6571E202BDC8A
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 09:03:27 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 09:03:17 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; d="scan'208";a="385744126"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 09:03:17 -0700
Subject: [PATCH v2 3/3] libnvdimm, MAINTAINERS: Maintainer Entry Profile
From: Dan Williams <dan.j.williams@intel.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 11 Sep 2019 08:48:59 -0700
Message-ID: <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Document the basic policies of the libnvdimm subsystem and provide a first
example of a Maintainer Entry Profile for others to duplicate and edit.

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/nvdimm/maintainer-entry-profile.rst |   64 +++++++++++++++++++++
 MAINTAINERS                                       |    4 +
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/nvdimm/maintainer-entry-profile.rst

diff --git a/Documentation/nvdimm/maintainer-entry-profile.rst b/Documentation/nvdimm/maintainer-entry-profile.rst
new file mode 100644
index 000000000000..c102950f2257
--- /dev/null
+++ b/Documentation/nvdimm/maintainer-entry-profile.rst
@@ -0,0 +1,64 @@
+LIBNVDIMM Maintainer Entry Profile
+==================================
+
+Overview
+--------
+The libnvdimm subsystem manages persistent memory across multiple
+architectures. The mailing list, is tracked by patchwork here:
+https://patchwork.kernel.org/project/linux-nvdimm/list/
+...and that instance is configured to give feedback to submitters on
+patch acceptance and upstream merge. Patches are merged to either the
+'libnvdimm-fixes', or 'libnvdimm-for-next' branch. Those branches are
+available here:
+https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/
+
+In general patches can be submitted against the latest -rc, however if
+the incoming code change is dependent on other pending changes then the
+patch should be based on the libnvdimm-for-next branch. However, since
+persistent memory sits at the intersection of storage and memory there
+are cases where patches are more suitable to be merged through a
+Filesystem or the Memory Management tree. When in doubt copy the nvdimm
+list and the maintainers will help route.
+
+Submissions will be exposed to the kbuild robot for compile regression
+testing. It helps to get a success notification from that infrastructure
+before submitting, but it is not required.
+
+
+Submit Checklist Addendum
+-------------------------
+There are unit tests for the subsystem via the ndctl utility:
+https://github.com/pmem/ndctl
+Those tests need to be passed before the patches go upstream, but not
+necessarily before initial posting. Contact the list if you need help
+getting the test environment set up.
+
+
+Key Cycle Dates
+---------------
+New submissions can be sent at any time, but if they intend to hit the
+next merge window they should be sent before -rc4, and ideally
+stabilized in the libnvdimm-for-next branch by -rc6. Of course if a
+patch set requires more than 2 weeks of review -rc4 is already too late
+and some patches may require multiple development cycles to review.
+
+
+Coding Style Addendum
+---------------------
+libnvdimm expects multi-line statements to be double indented. I.e.
+
+        if (x...
+                        && ...y) {
+
+
+Review Cadence
+--------------
+In general, please wait up to one week before pinging for feedback. A
+private mail reminder is preferred. Alternatively ask for other
+developers that have Reviewed-by tags for libnvdimm changes to take a
+look and offer their opinion.
+
+
+Style Cleanup Patches
+---------------------
+Standalone style-cleanups are welcome.
diff --git a/MAINTAINERS b/MAINTAINERS
index e5d111a86e61..2be1e18a368e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9185,6 +9185,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
+P:	Documentation/nvdimm/maintainer-entry-profile.rst
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
 F:	drivers/nvdimm/blk.c
@@ -9195,6 +9196,7 @@ M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
+P:	Documentation/nvdimm/maintainer-entry-profile.rst
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
 F:	drivers/nvdimm/btt*
@@ -9204,6 +9206,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
+P:	Documentation/nvdimm/maintainer-entry-profile.rst
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 S:	Supported
 F:	drivers/nvdimm/pmem*
@@ -9223,6 +9226,7 @@ M:	Dave Jiang <dave.jiang@intel.com>
 M:	Keith Busch <keith.busch@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
 L:	linux-nvdimm@lists.01.org
+P:	Documentation/nvdimm/maintainer-entry-profile.rst
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git
 S:	Supported

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
