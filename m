Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35519158FF
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 07:33:01 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E498321253310;
	Mon,  6 May 2019 22:32:59 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org;
 receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3650621253306
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 22:32:58 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D0EC20B7C;
 Tue,  7 May 2019 05:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1557207178;
 bh=m1p7UAVOnxe5IJuYFEQD7MknEjc4Qh9Zt5HfCqgINBw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K9q9Kdy1kj5wyAVFwhYUOY49ESca3IW8q02TeT8Se2ttNEbA4OgH3mBezhXKKexR7
 CrmpIrtYN5iTlt42j72RAENVu+us7HRr6MG3dfXE7cUuXlLiVf0NbYZ+LNSQAdNkd/
 1uLf0MwIhxfIV0WgJr25rrJCHzxuJzlrY4n8pUxQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 16/99] libnvdimm/security: provide fix for
 secure-erase to use zero-key
Date: Tue,  7 May 2019 01:31:10 -0400
Message-Id: <20190507053235.29900-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 037c8489ade669e0f09ad40d5b91e5e1159a14b1 ]

Add a zero key in order to standardize hardware that want a key of 0's to
be passed. Some platforms defaults to a zero-key with security enabled
rather than allow the OS to enable the security. The zero key would allow
us to manage those platform as well. This also adds a fix to secure erase
so it can use the zero key to do crypto erase. Some other security commands
already use zero keys. This introduces a standard zero-key to allow
unification of semantics cross nvdimm security commands.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/security.c        | 17 ++++++++++++-----
 tools/testing/nvdimm/test/nfit.c | 11 +++++++++--
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index f8bb746a549f..6bea6852bf27 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -22,6 +22,8 @@ static bool key_revalidate = true;
 module_param(key_revalidate, bool, 0444);
 MODULE_PARM_DESC(key_revalidate, "Require key validation at init.");
 
+static const char zero_key[NVDIMM_PASSPHRASE_LEN];
+
 static void *key_data(struct key *key)
 {
 	struct encrypted_key_payload *epayload = dereference_key_locked(key);
@@ -286,8 +288,9 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 {
 	struct device *dev = &nvdimm->dev;
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
-	struct key *key;
+	struct key *key = NULL;
 	int rc;
+	const void *data;
 
 	/* The bus lock should be held at the top level of the call stack */
 	lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
@@ -319,11 +322,15 @@ int nvdimm_security_erase(struct nvdimm *nvdimm, unsigned int keyid,
 		return -EOPNOTSUPP;
 	}
 
-	key = nvdimm_lookup_user_key(nvdimm, keyid, NVDIMM_BASE_KEY);
-	if (!key)
-		return -ENOKEY;
+	if (keyid != 0) {
+		key = nvdimm_lookup_user_key(nvdimm, keyid, NVDIMM_BASE_KEY);
+		if (!key)
+			return -ENOKEY;
+		data = key_data(key);
+	} else
+		data = zero_key;
 
-	rc = nvdimm->sec.ops->erase(nvdimm, key_data(key), pass_type);
+	rc = nvdimm->sec.ops->erase(nvdimm, data, pass_type);
 	dev_dbg(dev, "key: %d erase%s: %s\n", key_serial(key),
 			pass_type == NVDIMM_MASTER ? "(master)" : "(user)",
 			rc == 0 ? "success" : "fail");
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index b579f962451d..cad719876ef4 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -225,6 +225,8 @@ static struct workqueue_struct *nfit_wq;
 
 static struct gen_pool *nfit_pool;
 
+static const char zero_key[NVDIMM_PASSPHRASE_LEN];
+
 static struct nfit_test *to_nfit_test(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1059,8 +1061,7 @@ static int nd_intel_test_cmd_secure_erase(struct nfit_test *t,
 	struct device *dev = &t->pdev.dev;
 	struct nfit_test_sec *sec = &dimm_sec_info[dimm];
 
-	if (!(sec->state & ND_INTEL_SEC_STATE_ENABLED) ||
-			(sec->state & ND_INTEL_SEC_STATE_FROZEN)) {
+	if (sec->state & ND_INTEL_SEC_STATE_FROZEN) {
 		nd_cmd->status = ND_INTEL_STATUS_INVALID_STATE;
 		dev_dbg(dev, "secure erase: wrong security state\n");
 	} else if (memcmp(nd_cmd->passphrase, sec->passphrase,
@@ -1068,6 +1069,12 @@ static int nd_intel_test_cmd_secure_erase(struct nfit_test *t,
 		nd_cmd->status = ND_INTEL_STATUS_INVALID_PASS;
 		dev_dbg(dev, "secure erase: wrong passphrase\n");
 	} else {
+		if (!(sec->state & ND_INTEL_SEC_STATE_ENABLED)
+				&& (memcmp(nd_cmd->passphrase, zero_key,
+					ND_INTEL_PASSPHRASE_SIZE) != 0)) {
+			dev_dbg(dev, "invalid zero key\n");
+			return 0;
+		}
 		memset(sec->passphrase, 0, ND_INTEL_PASSPHRASE_SIZE);
 		memset(sec->master_passphrase, 0, ND_INTEL_PASSPHRASE_SIZE);
 		sec->state = 0;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
