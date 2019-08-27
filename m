Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FED9DAEE
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 03:09:10 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8BA5521A070B8;
	Mon, 26 Aug 2019 18:11:22 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.126; helo=mga18.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2F1E920212CB9
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 18:11:20 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Aug 2019 18:09:07 -0700
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; d="scan'208";a="174388482"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Aug 2019 18:09:06 -0700
Subject: [PATCH v2 0/3] libnvdimm/security: Enumerate the frozen state and
 other cleanups
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 26 Aug 2019 17:54:49 -0700
Message-ID: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Changes since v1 [1]:
- Cleanup patch1, simplify flags return in the overwrite case and
  consolidate frozen-state cases (Jeff)
- Clarify the motivation for patch2 (Jeff)
- Collect Dave's Reviewed-by

[1]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/023133.html

---

Jeff reported a scenario where ndctl was failing to unlock DIMMs [2].
Through the course of debug it was discovered that the security
interface on the DIMMs was in the 'frozen' state disallowing unlock, or
any security operation.  Unfortunately the kernel only showed that the
DIMMs were 'locked', not 'locked' and 'frozen'.

Introduce a new sysfs 'frozen' attribute so that ndctl can reflect the
"security-operations-allowed" state independently of the lock status.
Then, followup with cleanups related to replacing a security-state-enum
with a set of flags.
 
[2]: https://lists.01.org/pipermail/linux-nvdimm/2019-August/022856.html

---

Dan Williams (3):
      libnvdimm/security: Introduce a 'frozen' attribute
      libnvdimm/security: Tighten scope of nvdimm->busy vs security operations
      libnvdimm/security: Consolidate 'security' operations


 drivers/acpi/nfit/intel.c        |   59 ++++++-----
 drivers/nvdimm/bus.c             |    2 
 drivers/nvdimm/dimm_devs.c       |  134 ++++++--------------------
 drivers/nvdimm/nd-core.h         |   51 ++++------
 drivers/nvdimm/security.c        |  199 +++++++++++++++++++++++++-------------
 include/linux/libnvdimm.h        |    9 +-
 tools/testing/nvdimm/dimm_devs.c |   19 +---
 7 files changed, 226 insertions(+), 247 deletions(-)
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
