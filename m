Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE818E26C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Aug 2019 03:34:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9B2F92035D702;
	Wed, 14 Aug 2019 18:36:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4461620311212
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 18:36:48 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 18:34:46 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; d="scan'208";a="188356876"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 18:34:46 -0700
Subject: [PATCH 3/3] libnvdimm/security: Consolidate 'security' operations
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 14 Aug 2019 18:20:29 -0700
Message-ID: <156583202899.2815870.9164783407864995953.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156583201347.2815870.4687949334637966672.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The security operations are exported from libnvdimm/security.c to
libnvdimm/dimm_devs.c, and libnvdimm/security.c is optionally compiled
based on the CONFIG_NVDIMM_KEYS config symbol.

Rather than export the operations across compile objects, just move the
__security_store() entry point to live with the helpers.

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/dimm_devs.c |   84 -----------------------------------------
 drivers/nvdimm/nd-core.h   |   30 +--------------
 drivers/nvdimm/security.c  |   90 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 90 insertions(+), 114 deletions(-)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index d837cb9be83d..196aa44c4936 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -393,88 +393,6 @@ static ssize_t frozen_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(frozen);
 
-#define OPS							\
-	C( OP_FREEZE,		"freeze",		1),	\
-	C( OP_DISABLE,		"disable",		2),	\
-	C( OP_UPDATE,		"update",		3),	\
-	C( OP_ERASE,		"erase",		2),	\
-	C( OP_OVERWRITE,	"overwrite",		2),	\
-	C( OP_MASTER_UPDATE,	"master_update",	3),	\
-	C( OP_MASTER_ERASE,	"master_erase",		2)
-#undef C
-#define C(a, b, c) a
-enum nvdimmsec_op_ids { OPS };
-#undef C
-#define C(a, b, c) { b, c }
-static struct {
-	const char *name;
-	int args;
-} ops[] = { OPS };
-#undef C
-
-#define SEC_CMD_SIZE 32
-#define KEY_ID_SIZE 10
-
-static ssize_t __security_store(struct device *dev, const char *buf, size_t len)
-{
-	struct nvdimm *nvdimm = to_nvdimm(dev);
-	ssize_t rc;
-	char cmd[SEC_CMD_SIZE+1], keystr[KEY_ID_SIZE+1],
-		nkeystr[KEY_ID_SIZE+1];
-	unsigned int key, newkey;
-	int i;
-
-	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
-			" %"__stringify(KEY_ID_SIZE)"s"
-			" %"__stringify(KEY_ID_SIZE)"s",
-			cmd, keystr, nkeystr);
-	if (rc < 1)
-		return -EINVAL;
-	for (i = 0; i < ARRAY_SIZE(ops); i++)
-		if (sysfs_streq(cmd, ops[i].name))
-			break;
-	if (i >= ARRAY_SIZE(ops))
-		return -EINVAL;
-	if (ops[i].args > 1)
-		rc = kstrtouint(keystr, 0, &key);
-	if (rc >= 0 && ops[i].args > 2)
-		rc = kstrtouint(nkeystr, 0, &newkey);
-	if (rc < 0)
-		return rc;
-
-	if (i == OP_FREEZE) {
-		dev_dbg(dev, "freeze\n");
-		rc = nvdimm_security_freeze(nvdimm);
-	} else if (i == OP_DISABLE) {
-		dev_dbg(dev, "disable %u\n", key);
-		rc = nvdimm_security_disable(nvdimm, key);
-	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
-		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
-		rc = nvdimm_security_update(nvdimm, key, newkey, i == OP_UPDATE
-				? NVDIMM_USER : NVDIMM_MASTER);
-	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
-		dev_dbg(dev, "%s %u\n", ops[i].name, key);
-		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
-			return -EBUSY;
-		}
-		rc = nvdimm_security_erase(nvdimm, key, i == OP_ERASE
-				? NVDIMM_USER : NVDIMM_MASTER);
-	} else if (i == OP_OVERWRITE) {
-		dev_dbg(dev, "overwrite %u\n", key);
-		if (atomic_read(&nvdimm->busy)) {
-			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
-			return -EBUSY;
-		}
-		rc = nvdimm_security_overwrite(nvdimm, key);
-	} else
-		return -EINVAL;
-
-	if (rc == 0)
-		rc = len;
-	return rc;
-}
-
 static ssize_t security_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t len)
 
@@ -489,7 +407,7 @@ static ssize_t security_store(struct device *dev,
 	nd_device_lock(dev);
 	nvdimm_bus_lock(dev);
 	wait_nvdimm_bus_probe_idle(dev);
-	rc = __security_store(dev, buf, len);
+	rc = nvdimm_security_store(dev, buf, len);
 	nvdimm_bus_unlock(dev);
 	nd_device_unlock(dev);
 
diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index da2bbfd56d9f..454454ba1738 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -68,35 +68,11 @@ static inline unsigned long nvdimm_security_flags(
 }
 int nvdimm_security_freeze(struct nvdimm *nvdimm);
 #if IS_ENABLED(CONFIG_NVDIMM_KEYS)
-int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid);
-int nvdimm_security_update(struct nvdimm *nvdimm, unsigned int keyid,
-		unsigned int new_keyid,
-		enum nvdimm_passphrase_type pass_type);
-int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
-		enum nvdimm_passphrase_type pass_type);
-int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid);
+ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len);
 void nvdimm_security_overwrite_query(struct work_struct *work);
 #else
-static inline int nvdimm_security_disable(struct nvdimm *nvdimm,
-		unsigned int keyid)
-{
-	return -EOPNOTSUPP;
-}
-static inline int nvdimm_security_update(struct nvdimm *nvdimm,
-		unsigned int keyid,
-		unsigned int new_keyid,
-		enum nvdimm_passphrase_type pass_type)
-{
-	return -EOPNOTSUPP;
-}
-static inline int nvdimm_security_erase(struct nvdimm *nvdimm,
-		unsigned int keyid,
-		enum nvdimm_passphrase_type pass_type)
-{
-	return -EOPNOTSUPP;
-}
-static inline int nvdimm_security_overwrite(struct nvdimm *nvdimm,
-		unsigned int keyid)
+static inline ssize_t nvdimm_security_store(struct device *dev,
+		const char *buf, size_t len)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 2166e627383a..9e45b207ff01 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -235,7 +235,7 @@ static int check_security_state(struct nvdimm *nvdimm)
 	return 0;
 }
 
-int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid)
+static int security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -268,7 +268,7 @@ int nvdimm_security_disable(struct nvdimm *nvdimm, unsigned int keyid)
 	return rc;
 }
 
-int nvdimm_security_update(struct nvdimm *nvdimm, unsigned int keyid,
+static int security_update(struct nvdimm *nvdimm, unsigned int keyid,
 		unsigned int new_keyid,
 		enum nvdimm_passphrase_type pass_type)
 {
@@ -318,7 +318,7 @@ int nvdimm_security_update(struct nvdimm *nvdimm, unsigned int keyid,
 	return rc;
 }
 
-int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
+static int security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 		enum nvdimm_passphrase_type pass_type)
 {
 	struct device *dev = &nvdimm->dev;
@@ -360,7 +360,7 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 	return rc;
 }
 
-int nvdimm_security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
+static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
@@ -465,3 +465,85 @@ void nvdimm_security_overwrite_query(struct work_struct *work)
 	__nvdimm_security_overwrite_query(nvdimm);
 	nvdimm_bus_unlock(&nvdimm->dev);
 }
+
+#define OPS							\
+	C( OP_FREEZE,		"freeze",		1),	\
+	C( OP_DISABLE,		"disable",		2),	\
+	C( OP_UPDATE,		"update",		3),	\
+	C( OP_ERASE,		"erase",		2),	\
+	C( OP_OVERWRITE,	"overwrite",		2),	\
+	C( OP_MASTER_UPDATE,	"master_update",	3),	\
+	C( OP_MASTER_ERASE,	"master_erase",		2)
+#undef C
+#define C(a, b, c) a
+enum nvdimmsec_op_ids { OPS };
+#undef C
+#define C(a, b, c) { b, c }
+static struct {
+	const char *name;
+	int args;
+} ops[] = { OPS };
+#undef C
+
+#define SEC_CMD_SIZE 32
+#define KEY_ID_SIZE 10
+
+ssize_t nvdimm_security_store(struct device *dev, const char *buf, size_t len)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	ssize_t rc;
+	char cmd[SEC_CMD_SIZE+1], keystr[KEY_ID_SIZE+1],
+		nkeystr[KEY_ID_SIZE+1];
+	unsigned int key, newkey;
+	int i;
+
+	rc = sscanf(buf, "%"__stringify(SEC_CMD_SIZE)"s"
+			" %"__stringify(KEY_ID_SIZE)"s"
+			" %"__stringify(KEY_ID_SIZE)"s",
+			cmd, keystr, nkeystr);
+	if (rc < 1)
+		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(ops); i++)
+		if (sysfs_streq(cmd, ops[i].name))
+			break;
+	if (i >= ARRAY_SIZE(ops))
+		return -EINVAL;
+	if (ops[i].args > 1)
+		rc = kstrtouint(keystr, 0, &key);
+	if (rc >= 0 && ops[i].args > 2)
+		rc = kstrtouint(nkeystr, 0, &newkey);
+	if (rc < 0)
+		return rc;
+
+	if (i == OP_FREEZE) {
+		dev_dbg(dev, "freeze\n");
+		rc = nvdimm_security_freeze(nvdimm);
+	} else if (i == OP_DISABLE) {
+		dev_dbg(dev, "disable %u\n", key);
+		rc = security_disable(nvdimm, key);
+	} else if (i == OP_UPDATE || i == OP_MASTER_UPDATE) {
+		dev_dbg(dev, "%s %u %u\n", ops[i].name, key, newkey);
+		rc = security_update(nvdimm, key, newkey, i == OP_UPDATE
+				? NVDIMM_USER : NVDIMM_MASTER);
+	} else if (i == OP_ERASE || i == OP_MASTER_ERASE) {
+		dev_dbg(dev, "%s %u\n", ops[i].name, key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to secure erase while DIMM active.\n");
+			return -EBUSY;
+		}
+		rc = security_erase(nvdimm, key, i == OP_ERASE
+				? NVDIMM_USER : NVDIMM_MASTER);
+	} else if (i == OP_OVERWRITE) {
+		dev_dbg(dev, "overwrite %u\n", key);
+		if (atomic_read(&nvdimm->busy)) {
+			dev_dbg(dev, "Unable to overwrite while DIMM active.\n");
+			return -EBUSY;
+		}
+		rc = security_overwrite(nvdimm, key);
+	} else
+		return -EINVAL;
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
