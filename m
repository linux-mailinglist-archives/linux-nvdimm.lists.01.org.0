Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2BD8E270
	for <lists+linux-nvdimm@lfdr.de>; Thu, 15 Aug 2019 03:37:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DA17E2031121A;
	Wed, 14 Aug 2019 18:39:32 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 824EA202EDB8B
 for <linux-nvdimm@lists.01.org>; Wed, 14 Aug 2019 18:39:31 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 18:37:29 -0700
X-IronPort-AV: E=Sophos;i="5.64,387,1559545200"; d="scan'208";a="176740878"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Aug 2019 18:37:29 -0700
Subject: [ndctl PATCH] ndctl/dimm: Add support for separate security-frozen
 attribute
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 14 Aug 2019 18:23:11 -0700
Message-ID: <156583219134.2816070.2537582454969393648.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Given the discovery that the original libnvdimm-security implementation
is unable to communicate both the 'freeze' status and the 'lock' status
simultaneously, newer kernels deploy a new 'frozen' attribute for this
purpose.

Add a new api and update the tests for this new capability. The old test
will fail on newer kernels, but hopefully there were no other
applications depending on the 'security' attribute to communicate the
'freeze' status. It was likely only ever a debug / enumeration aid, not
an application dependency.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ndctl/ndctl-freeze-security.txt |    8 +++++---
 ndctl/dimm.c                                  |    2 +-
 ndctl/lib/dimm.c                              |   25 +++++++++++++++++++++++++
 ndctl/lib/libndctl.sym                        |    4 ++++
 ndctl/libndctl.h                              |    1 +
 test/security.sh                              |   18 ++++++++++++------
 util/json.c                                   |    6 ++++++
 7 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/ndctl/ndctl-freeze-security.txt b/Documentation/ndctl/ndctl-freeze-security.txt
index 573577194183..dbb94e7989af 100644
--- a/Documentation/ndctl/ndctl-freeze-security.txt
+++ b/Documentation/ndctl/ndctl-freeze-security.txt
@@ -35,7 +35,7 @@ $ ndctl list -d nmem0
 ]
 
 $ ndctl freeze-security  nmem0
-security freezed 1 nmem.
+security froze 1 nmem.
 
 $ ndctl list -d nmem0
 [
@@ -44,9 +44,11 @@ $ ndctl list -d nmem0
     "id":"cdab-0a-07e0-ffffffff",
     "handle":0,
     "phys_id":0,
-    "security":"frozen"
-  }
+    "security":"unlocked",
+    "security_frozen":true
+  },
 ]
+
 ----
 
 OPTIONS
diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index 5e6fa19bab15..c8821d6110e8 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -1426,7 +1426,7 @@ int cmd_freeze_security(int argc, const char **argv, void *ctx)
 	int count = dimm_action(argc, argv, ctx, action_security_freeze, base_options,
 			"ndctl freeze-security <nmem0> [<nmem1>..<nmemN>] [<options>]");
 
-	fprintf(stderr, "security freezed %d nmem%s.\n", count >= 0 ? count : 0,
+	fprintf(stderr, "security froze %d nmem%s.\n", count >= 0 ? count : 0,
 			count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
diff --git a/ndctl/lib/dimm.c b/ndctl/lib/dimm.c
index 37db5570102a..2f145be520fd 100644
--- a/ndctl/lib/dimm.c
+++ b/ndctl/lib/dimm.c
@@ -704,6 +704,31 @@ NDCTL_EXPORT enum ndctl_security_state ndctl_dimm_get_security(
 	return NDCTL_SECURITY_INVALID;
 }
 
+NDCTL_EXPORT bool ndctl_dimm_security_is_frozen(struct ndctl_dimm *dimm)
+{
+	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
+	char *path = dimm->dimm_buf;
+	char buf[SYSFS_ATTR_SIZE];
+	int len = dimm->buf_len;
+	int rc;
+
+
+	if (ndctl_dimm_get_security(dimm) == NDCTL_SECURITY_FROZEN)
+		return true;
+
+	if (snprintf(path, len, "%s/frozen", dimm->dimm_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				ndctl_dimm_get_devname(dimm));
+		return false;
+	}
+
+	rc = sysfs_read_attr(ctx, path, buf);
+	if (rc < 0)
+		return false;
+
+	return !!strtoul(buf, NULL, 0);
+}
+
 static int write_security(struct ndctl_dimm *dimm, const char *cmd)
 {
 	struct ndctl_ctx *ctx = ndctl_dimm_get_ctx(dimm);
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index fef2907aa47d..c93c1ee7274c 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -419,3 +419,7 @@ LIBNDCTL_21 {
 	ndctl_dimm_read_label_extent;
 	ndctl_dimm_zero_label_extent;
 } LIBNDCTL_20;
+
+LIBNDCTL_22 {
+	ndctl_dimm_security_is_frozen;
+} LIBNDCTL_21;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index f3f2ef66c5a8..d720a98ead1e 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -714,6 +714,7 @@ enum ndctl_security_state {
 };
 
 enum ndctl_security_state ndctl_dimm_get_security(struct ndctl_dimm *dimm);
+bool ndctl_dimm_security_is_frozen(struct ndctl_dimm *dimm);
 int ndctl_dimm_update_passphrase(struct ndctl_dimm *dimm,
 		long ckey, long nkey);
 int ndctl_dimm_disable_passphrase(struct ndctl_dimm *dimm, long key);
diff --git a/test/security.sh b/test/security.sh
index c86d2c6591a6..942831c901fa 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -105,6 +105,11 @@ lock_dimm()
 	fi
 }
 
+get_frozen_state()
+{
+	$NDCTL list -i -b "$NFIT_TEST_BUS0" -d "$dev" | jq -r .[].dimms[0].security_frozen
+}
+
 get_security_state()
 {
 	$NDCTL list -i -b "$NFIT_TEST_BUS0" -d "$dev" | jq -r .[].dimms[0].security
@@ -195,15 +200,15 @@ test_5_security_freeze()
 	setup_passphrase
 	freeze_security
 	sstate="$(get_security_state)"
-	if [ "$sstate" != "frozen" ]; then
-		echo "Incorrect security state: $sstate expected: frozen"
+	fstate="$(get_frozen_state)"
+	if [ "$fstate" != "true" ]; then
+		echo "Incorrect security state: expected: frozen"
 		err "$LINENO"
 	fi
 	$NDCTL remove-passphrase "$dev" && { echo "remove succeed after frozen"; }
-	sstate="$(get_security_state)"
-	echo "$sstate"
-	if [ "$sstate" != "frozen" ]; then
-		echo "Incorrect security state: $sstate expected: frozen"
+	sstate2="$(get_security_state)"
+	if [ "$sstate" != "$sstate2" ]; then
+		echo "Incorrect security state: $sstate2 expected: $sstate"
 		err "$LINENO"
 	fi
 }
@@ -262,6 +267,7 @@ test_4_security_unlock
 # not impact any key management testing via libkeyctl.
 echo "Test 5, freeze security"
 test_5_security_freeze
+exit 1
 
 # Load-keys is independent of actual nvdimm security and is part of key
 # mangement testing.
diff --git a/util/json.c b/util/json.c
index ac834b33d108..524b64fae9a5 100644
--- a/util/json.c
+++ b/util/json.c
@@ -260,6 +260,12 @@ struct json_object *util_dimm_to_json(struct ndctl_dimm *dimm,
 	if (jobj)
 		json_object_object_add(jdimm, "security", jobj);
 
+	if (ndctl_dimm_security_is_frozen(dimm)) {
+		jobj = json_object_new_boolean(true);
+		if (jobj)
+			json_object_object_add(jdimm, "security_frozen", jobj);
+	}
+
 	return jdimm;
  err:
 	json_object_put(jdimm);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
