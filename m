Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE119A140
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 22:36:51 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E29420214B20;
	Thu, 22 Aug 2019 13:37:51 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.88; helo=mga01.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A9B1A202110A3
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 13:37:49 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Aug 2019 13:36:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,418,1559545200"; d="scan'208";a="354404683"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga005.jf.intel.com with ESMTP; 22 Aug 2019 13:36:48 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 2/2] libdaxctl: point to migrate-device-model for
 dax-class errors
Date: Thu, 22 Aug 2019 14:36:35 -0600
Message-Id: <20190822203635.17926-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822203635.17926-1-vishal.l.verma@intel.com>
References: <20190822203635.17926-1-vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

When a dax-bus vs. dax-class expectation causes a failure, such as when
reconfiguring device modes, print an error message directly pointing the
user to the daxctl-migrate-device-model command.

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 daxctl/lib/libdaxctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 44842b9..c0a859c 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -917,6 +917,7 @@ static int daxctl_dev_enable(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
 
 	if (!device_model_is_dax_bus(dev)) {
 		err(ctx, "%s: error: device model is dax-class\n", devname);
+		err(ctx, "%s: see man daxctl-migrate-device-model\n", devname);
 		return -EOPNOTSUPP;
 	}
 
@@ -962,6 +963,7 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
 
 	if (!device_model_is_dax_bus(dev)) {
 		err(ctx, "%s: error: device model is dax-class\n", devname);
+		err(ctx, "%s: see man daxctl-migrate-device-model\n", devname);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
