Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86F9DAF2
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 03:09:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BC02E20215F49;
	Mon, 26 Aug 2019 18:11:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.120; helo=mga04.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0ACDE21A02937
 for <linux-nvdimm@lists.01.org>; Mon, 26 Aug 2019 18:11:31 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Aug 2019 18:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.64,435,1559545200"; d="scan'208";a="185131879"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Aug 2019 18:09:17 -0700
Subject: [PATCH v2 2/3] libnvdimm/security: Tighten scope of nvdimm->busy vs
 security operations
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 26 Aug 2019 17:55:00 -0700
Message-ID: <156686729996.184120.3458026302402493937.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156686728950.184120.5188743631586996901.stgit@dwillia2-desk3.amr.corp.intel.com>
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

An attempt to freeze DIMMs currently runs afoul of default blocking of
all security operations in the entry to the 'store' routine for the
'security' sysfs attribute.

The blanket blocking of all security operations while the DIMM is in
active use in a region is too restrictive. The only security operations
that need to be aware of the ->busy state are those that mutate the
state of data, i.e. erase and overwrite.

Refactor the ->busy checks to be applied at the entry common entry point
in __security_store() rather than each of the helper routines to enable
freeze to be run regardless of busy state.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm_devs.c |   33 ++++++++++++++++-----------------
 drivers/nvdimm/security.c  |   10 ----------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 53330625fe07..d837cb9be83d 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -424,9 +424,6 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
 	unsigned int key, newkey;
 	int i;
 
-	if (atomic_read(&nvdimm->busy))
-		return -EBUSY;
-
 	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
 			" %"__stringify(KEY_ID_SIZE)"s"
 			" %"__stringify(KEY_ID_SIZE)"s",
@@ -451,23 +448,25 @@ static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
 	} else if (i == OP_DISABLE) {
 		dev_dbg(dev, "disable %u\n", key);
 		rc = nvdimm_security_disable(nvdimm, key);
-	} else if (i == OP_UPDATE) {
-		dev_dbg(dev, "update %u %u\n", key, newkey);
-		rc = nvdimm_security_update(nvdimm, key, newkey, NVDIMM_USER);
-	} else if (i == OP_ERASE) {
-		dev_dbg(dev, "erase %u\n", key);
-		rc = nvdimm_security_erase(nvdimm, key, NVDIMM_USER);
+	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
+		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
+		rc = nvdimm_security_update(nvdimm, key, newkey, i == OP_UPDATE
+				? NVDIMM_USER : NVDIMM_MASTER);
+	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
+		dev_dbg(dev, "%s %u\n", ops[i].name, key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
+			return -EBUSY;
+		}
+		rc = nvdimm_security_erase(nvdimm, key, i == OP_ERASE
+				? NVDIMM_USER : NVDIMM_MASTER);
 	} else if (i == OP_OVERWRITE) {
 		dev_dbg(dev, "overwrite %u\n", key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
+			return -EBUSY;
+		}
 		rc = nvdimm_security_overwrite(nvdimm, key);
-	} else if (i == OP_MASTER_UPDATE) {
-		dev_dbg(dev, "master_update %u %u\n", key, newkey);
-		rc = nvdimm_security_update(nvdimm, key, newkey,
-				NVDIMM_MASTER);
-	} else if (i == OP_MASTER_ERASE) {
-		dev_dbg(dev, "master_erase %u\n", key);
-		rc = nvdimm_security_erase(nvdimm, key,
-				NVDIMM_MASTER);
 	} else
 		return -EINVAL;
 
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 5862d0eee9db..2166e627383a 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -334,11 +334,6 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 			|| !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
-	if (atomic_read(&nvdimm->busy)) {
-		dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
-		return -EBUSY;
-	}
-
 	rc = check_security_state(nvdimm);
 	if (rc)
 		return rc;
@@ -380,11 +375,6 @@ int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 			|| !nvdimm->sec.flags)
 		return -EOPNOTSUPP;
 
-	if (atomic_read(&nvdimm->busy)) {
-		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
-		return -EBUSY;
-	}
-
 	if (dev->driver == NULL) {
 		dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
 		return -EINVAL;

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
