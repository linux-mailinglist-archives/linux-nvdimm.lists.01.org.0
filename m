Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A714E6AD
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jan 2020 01:40:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05CCC10FC3162;
	Thu, 30 Jan 2020 16:43:47 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.88; helo=mga01.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3219110FC3162
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jan 2020 16:43:43 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2020 16:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,383,1574150400";
   d="scan'208";a="224292318"
Received: from vverma7-desk1.amr.corp.intel.com (HELO vverma7-desk1.lm.intel.com) ([10.232.112.164])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jan 2020 16:40:25 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Subject: [ndctl PATCH v2] ndctl/lib: fix symbol redefinitions reported by GCC10
Date: Thu, 30 Jan 2020 17:40:23 -0700
Message-Id: <20200131004023.31255-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: DARH6VVRHEM3FQEF5MYRADWA34PMZZYW
X-Message-ID-Hash: DARH6VVRHEM3FQEF5MYRADWA34PMZZYW
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DARH6VVRHEM3FQEF5MYRADWA34PMZZYW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A toolchain update in Fedora 32 caused new compile errors due to
multiple definitions of dimm_ops structures. The declarations in
'private.h' for the various NFIT families are present so that libndctl
can find all the per-family dimm-ops. However they need to be declared
as extern because the actual definitions are in <family>.c.
Additionally, 'param' instances in list.c and monitor.c need to be
marked as static.

Cc: Dan Williams <dan.j.williams@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

Tested with a F32 mockbuild

 ndctl/Makefile.am   | 4 +++-
 ndctl/lib/private.h | 8 ++++----
 ndctl/list.c        | 2 +-
 ndctl/monitor.c     | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/ndctl/Makefile.am b/ndctl/Makefile.am
index 264c4ed..49c6c4a 100644
--- a/ndctl/Makefile.am
+++ b/ndctl/Makefile.am
@@ -18,7 +18,9 @@ ndctl_SOURCES = ndctl.c \
 		check.c \
 		region.c \
 		dimm.c \
-		 ../util/log.c \
+		../util/log.c \
+		../util/filter.c \
+		../util/filter.h \
 		list.c \
 		../util/json.c \
 		../util/json.h \
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index e445301..16bf8f9 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -343,10 +343,10 @@ struct ndctl_dimm_ops {
 	int (*xlat_firmware_status)(struct ndctl_cmd *);
 };
 
-struct ndctl_dimm_ops * const intel_dimm_ops;
-struct ndctl_dimm_ops * const hpe1_dimm_ops;
-struct ndctl_dimm_ops * const msft_dimm_ops;
-struct ndctl_dimm_ops * const hyperv_dimm_ops;
+extern struct ndctl_dimm_ops * const intel_dimm_ops;
+extern struct ndctl_dimm_ops * const hpe1_dimm_ops;
+extern struct ndctl_dimm_ops * const msft_dimm_ops;
+extern struct ndctl_dimm_ops * const hyperv_dimm_ops;
 
 static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
 {
diff --git a/ndctl/list.c b/ndctl/list.c
index 125a9fe..12d78d8 100644
--- a/ndctl/list.c
+++ b/ndctl/list.c
@@ -59,7 +59,7 @@ static unsigned long listopts_to_flags(void)
 	return flags;
 }
 
-struct util_filter_params param;
+static struct util_filter_params param;
 
 static int did_fail;
 
diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index b8ee27f..1755b87 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -45,7 +45,7 @@ struct monitor_dimm {
 	struct list_node list;
 };
 
-struct util_filter_params param;
+static struct util_filter_params param;
 
 static int did_fail;
 
-- 
2.21.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
