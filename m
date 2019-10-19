Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9FDD9B6
	for <lists+linux-nvdimm@lfdr.de>; Sat, 19 Oct 2019 18:54:00 +0200 (CEST)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B305E1007B759;
	Sat, 19 Oct 2019 09:55:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 940C71007B758
	for <linux-nvdimm@lists.01.org>; Sat, 19 Oct 2019 09:55:55 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:53:56 -0700
X-IronPort-AV: E=Sophos;i="5.67,316,1566889200";
   d="scan'208";a="190676549"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2019 09:53:56 -0700
Subject: [ndctl PATCH 0/4] test/dax.sh: Add huge page fault validation
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 19 Oct 2019 09:39:38 -0700
Message-ID: <157150317870.3940762.5638079137146963300.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: GTHW7MEHHAOJLQQWWZ6W7DROESOY64YT
X-Message-ID-Hash: GTHW7MEHHAOJLQQWWZ6W7DROESOY64YT
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/GTHW7MEHHAOJLQQWWZ6W7DROESOY64YT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

v5.3 regressed huge page faulting and the ndctl unit test that tries to
generate huge page faults did not report it.

- Use trace-cmd to validate fault results
- Workaround XFS issues with fallocate > agsize
- Split the test to get distinct ext4 and xfs results
- Other misc fixups.

---

Dan Williams (4):
      test/dax.sh: Fix failure reporting / handling
      test/dax.sh: Fix xfs 2M alignment
      test/dax.sh: Validate huge page mappings
      test/dax.sh: Split into ext4 and xfs tests


 test/Makefile.am |    3 +
 test/dax-ext4.sh |    1 
 test/dax-pmd.c   |    3 +
 test/dax-xfs.sh  |    1 
 test/dax.sh      |  127 ++++++++++++++++++++++++++++++++++--------------------
 5 files changed, 87 insertions(+), 48 deletions(-)
 create mode 120000 test/dax-ext4.sh
 create mode 120000 test/dax-xfs.sh
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
