Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D310434F73D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 31 Mar 2021 05:12:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8187E100EB32F;
	Tue, 30 Mar 2021 20:12:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.20; helo=mga02.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 50825100EB85F
	for <linux-nvdimm@lists.01.org>; Tue, 30 Mar 2021 20:12:49 -0700 (PDT)
IronPort-SDR: EojhTVuWTz8efJyhoTeHKmBNTtVJ+Sd8Hb/5GoiokWJdd1v7L91SndmF7kHXzgg/eCuHAtEQ81
 FtUpEXgZUSGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179035523"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="179035523"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:49 -0700
IronPort-SDR: L3XRBIKZfjsJaeuT7BexLdTBR6JnBNxGgmxjbuRVuQvC9KTro3gUyna6nOgLnsumax8pFAZtU3
 QiBEgCufQweQ==
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400";
   d="scan'208";a="438581738"
Received: from choffma1-mobl.amr.corp.intel.com (HELO omniknight.intel.com) ([10.212.71.210])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 20:12:48 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/3] libdaxctl: add an API to check if a device is active
Date: Tue, 30 Mar 2021 21:12:28 -0600
Message-Id: <20210331031229.384068-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331031229.384068-1-vishal.l.verma@intel.com>
References: <20210331031229.384068-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 7CXJC2A33CSDHNDEQYOKDDSGH6WH66IJ
X-Message-ID-Hash: 7CXJC2A33CSDHNDEQYOKDDSGH6WH66IJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Hansen <dave.hansen@linux.intel.com>, Chunye Xu <chunye.xu@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7CXJC2A33CSDHNDEQYOKDDSGH6WH66IJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an API to check whether a daxctl device is active in system-ram
mode. This would be used from libndctl during
ndctl_namespace_disable_safe(), so that we don't disable/destroy an
underlying namespace while the memory is active and online.

Reported-by: Chunye Xu <chunye.xu@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c   | 10 ++++++++++
 daxctl/libdaxctl.h       |  1 +
 daxctl/lib/libdaxctl.sym |  1 +
 3 files changed, 12 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 879f7e6..860bd9c 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1665,3 +1665,13 @@ DAXCTL_EXPORT int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev)
 	/* match both "online" and "online_movable" */
 	return !strncmp(buf, "online", 6);
 }
+
+DAXCTL_EXPORT int daxctl_dev_has_online_memory(struct daxctl_dev *dev)
+{
+	struct daxctl_memory *mem = daxctl_dev_get_memory(dev);
+
+	if (mem)
+		return daxctl_memory_is_online(mem);
+	else
+		return 0;
+}
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index 30ab51a..683ae9c 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -72,6 +72,7 @@ int daxctl_dev_enable_devdax(struct daxctl_dev *dev);
 int daxctl_dev_enable_ram(struct daxctl_dev *dev);
 int daxctl_dev_get_target_node(struct daxctl_dev *dev);
 int daxctl_dev_will_auto_online_memory(struct daxctl_dev *dev);
+int daxctl_dev_has_online_memory(struct daxctl_dev *dev);
 
 struct daxctl_memory;
 struct daxctl_memory *daxctl_dev_get_memory(struct daxctl_dev *dev);
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 892e393..a13e93d 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -95,4 +95,5 @@ global:
 LIBDAXCTL_9 {
 global:
 	daxctl_dev_will_auto_online_memory;
+	daxctl_dev_has_online_memory;
 } LIBDAXCTL_8;
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
