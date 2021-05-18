Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4C3882B4
	for <lists+linux-nvdimm@lfdr.de>; Wed, 19 May 2021 00:25:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F629100F225C;
	Tue, 18 May 2021 15:25:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.93; helo=mga11.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 291F7100F2255
	for <linux-nvdimm@lists.01.org>; Tue, 18 May 2021 15:25:32 -0700 (PDT)
IronPort-SDR: GXrvTNp7Zs4bo9W6yAdBnh5F1Wlt2j0F2Pvy6kHCaqDAlh5HVwPiqUKyyJ902AbhDmDaSSkM5s
 253PUFwG6GXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197743974"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400";
   d="scan'208";a="197743974"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 15:25:31 -0700
IronPort-SDR: C1HjXMhdbcMUJUgfDc7TgNIj5rtK9sV7Pj3mPPklRbk5oZhJ12I6mSmMf5vDuwEQBMYaXaT53S
 NeaAvurfuBfQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400";
   d="scan'208";a="542154866"
Received: from rong2-mobl1.amr.corp.intel.com (HELO vverma7-desk.amr.corp.intel.com) ([10.254.2.111])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 15:25:31 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <nvdimm@lists.linux.dev>
Subject: [ndctl PATCH] ndctl: Update nvdimm mailing list address
Date: Tue, 18 May 2021 16:25:27 -0600
Message-Id: <20210518222527.550730-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Message-ID-Hash: J2BII2IXF3OTZLMCMOFG4HFHSXJ7TJ2L
X-Message-ID-Hash: J2BII2IXF3OTZLMCMOFG4HFHSXJ7TJ2L
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J2BII2IXF3OTZLMCMOFG4HFHSXJ7TJ2L/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'nvdimm' mailing list has moved from lists.01.org to
lists.linux.dev. Update CONTRIBUTING.md and configure.ac to reflect
this.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 configure.ac    | 2 +-
 CONTRIBUTING.md | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5ec8d2f..dc39dbe 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ AC_PREREQ(2.60)
 m4_include([version.m4])
 AC_INIT([ndctl],
         GIT_VERSION,
-        [linux-nvdimm@lists.01.org],
+        [nvdimm@lists.linux.dev],
         [ndctl],
         [https://github.com/pmem/ndctl])
 AC_CONFIG_SRCDIR([ndctl/lib/libndctl.c])
diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 4c29d31..4f4865d 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -6,13 +6,14 @@ The following is a set of guidelines that we adhere to, and request that
 contributors follow.
 
 1. The libnvdimm (kernel subsystem) and ndctl developers primarily use
-   the [linux-nvdimm](https://lists.01.org/postorius/lists/linux-nvdimm.lists.01.org/)
+   the [nvdimm](https://subspace.kernel.org/lists.linux.dev.html)
    mailing list for everything. It is recommended to send patches to
-   **```linux-nvdimm@lists.01.org```**
+   **```nvdimm@lists.linux.dev```**
+   An archive is available on [lore](https://lore.kernel.org/nvdimm/)
 
 1. Github [issues](https://github.com/pmem/ndctl/issues) are an acceptable
    way to report a problem, but if you just have a question,
-   [email](mailto:linux-nvdimm@lists.01.org) the above list.
+   [email](mailto:nvdimm@lists.linux.dev) the above list.
 
 1. We follow the Linux Kernel [Coding Style Guide][cs] as applicable.
 

base-commit: a2a6fda4d7e93044fca4c67870d2ff7e193d3cf1
prerequisite-patch-id: 8fc5baaf64b312b2459acea255740f79a23b76cd
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
