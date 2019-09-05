Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A3A97DC
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 03:13:30 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75C2D21962301;
	Wed,  4 Sep 2019 18:14:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id AEEF320260CF7
 for <linux-nvdimm@lists.01.org>; Wed,  4 Sep 2019 18:14:28 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Sep 2019 18:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; d="scan'208";a="190341680"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.164])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2019 18:13:25 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v2 1/2] libdaxctl: fix the system-ram capability check
Date: Wed,  4 Sep 2019 19:13:13 -0600
Message-Id: <20190905011314.18610-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

When checking a daxctl device for system-ram capability, we needn't look
at the symlink resolution for /sys/bus/dax.../driver/module since the
driver in question may not always have an associated module, and could
be builtin instead.

Change the symlink we resolve to simply '/sys/bus/dax.../driver' and
since that too resolves to '.../kmem' in the system-ram case, the
rest of the check remains unchanged.

This is a pre-requisite to making daxctl-reconfigure-device work
correctly when the target mode's driver might be builtin.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---

v2: Collect Reviewed-by tags

 daxctl/lib/libdaxctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index c0a859c..d9f2c33 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -406,7 +406,7 @@ static int dev_is_system_ram_capable(struct daxctl_dev *dev)
 	if (!daxctl_dev_is_enabled(dev))
 		return false;
 
-	if (snprintf(path, len, "%s/driver/module", dev->dev_path) >= len) {
+	if (snprintf(path, len, "%s/driver", dev->dev_path) >= len) {
 		err(ctx, "%s: buffer too small!\n", devname);
 		return false;
 	}
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
