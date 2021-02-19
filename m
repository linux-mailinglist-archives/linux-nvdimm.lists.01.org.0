Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1A31F3C8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0C5A9100EAB0A;
	Thu, 18 Feb 2021 18:04:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E26B0100EAB5E
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:55 -0800 (PST)
IronPort-SDR: 20XNdDHuFLotWS3A/srXXGMBj8XeHswmQhO1RqCZa/aR94XW4jbfo5jz8fv8ujH8knolxhtNpc
 64PNiwqEzrTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151520"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151520"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
IronPort-SDR: xwJI56I8B/aJ5n3quHngE1ZyRVy4rNIukVK3C/ywXl9KU/PEIAP7p8zb5ahTXANircS4OJe7/2
 S52lQN5+tdlQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509682"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:55 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 11/13] test/libcxl: add a test for {set, get}_lsa commands
Date: Thu, 18 Feb 2021 19:03:29 -0700
Message-Id: <20210219020331.725687-12-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: EEIPUH7ZDYMLMDP4RYTMBYYGQQP7I43D
X-Message-ID-Hash: EEIPUH7ZDYMLMDP4RYTMBYYGQQP7I43D
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EEIPUH7ZDYMLMDP4RYTMBYYGQQP7I43D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a test to store a static string in the label storage area using the
SET_LSA mailbox command, and retrieve it using the GET_LSA command.
Compare the strings sent and received and ensure they match.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/libcxl.c    | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 test/Makefile.am |   3 +-
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/test/libcxl.c b/test/libcxl.c
index 9662f34..1cff32c 100644
--- a/test/libcxl.c
+++ b/test/libcxl.c
@@ -19,6 +19,7 @@
 #include <linux/version.h>
 
 #include <util/size.h>
+#include <util/hexdump.h>
 #include <ccan/short_types/short_types.h>
 #include <ccan/array_size/array_size.h>
 #include <ccan/endian/endian.h>
@@ -209,6 +210,138 @@ out_fail:
 	return rc;
 }
 
+static int debugfs_write_raw_flag(char *str)
+{
+	char *path = "/sys/kernel/debug/cxl/mbox/raw_allow_all";
+	int fd = open(path, O_WRONLY|O_CLOEXEC);
+	int n, len = strlen(str) + 1, rc;
+
+	if (fd < 0)
+		return -errno;
+
+	n = write(fd, str, len);
+	rc = -errno;
+	close(fd);
+	if (n < len) {
+		fprintf(stderr, "failed to write %s to %s: %s\n", str, path,
+					strerror(errno));
+		return rc;
+	}
+	return 0;
+}
+
+static char *test_lsa_data = "LIBCXL_TEST LSA DATA 01";
+static int lsa_size = EXPECT_CMD_IDENTIFY_LSA_SIZE;
+
+static int test_set_lsa(struct cxl_memdev *memdev)
+{
+	int data_size = strlen(test_lsa_data) + 1;
+	struct cxl_cmd *cmd;
+	struct {
+		le32 offset;
+		le32 rsvd;
+		unsigned char data[lsa_size];
+	} __attribute__((packed)) set_lsa;
+	int rc;
+
+	set_lsa.offset = cpu_to_le32(0);
+	set_lsa.rsvd = cpu_to_le32(0);
+	memcpy(set_lsa.data, test_lsa_data, data_size);
+
+	cmd = cxl_cmd_new_raw(memdev, 0x4103);
+	if (!cmd)
+		return -ENOMEM;
+
+	rc = cxl_cmd_set_input_payload(cmd, &set_lsa, sizeof(set_lsa));
+	if (rc) {
+		fprintf(stderr, "%s: %s: cmd setup failed: %s\n",
+			__func__, cxl_memdev_get_devname(memdev),
+			strerror(-rc));
+		goto out_fail;
+	}
+
+	rc = debugfs_write_raw_flag("Y");
+	if (rc < 0)
+		return rc;
+
+	rc = cxl_cmd_submit(cmd);
+	if (rc < 0)
+		fprintf(stderr, "%s: %s: cmd submission failed: %s\n",
+			__func__, cxl_memdev_get_devname(memdev),
+			strerror(-rc));
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (rc != 0) {
+		fprintf(stderr, "%s: %s: firmware status: %d\n",
+			__func__, cxl_memdev_get_devname(memdev), rc);
+		return -ENXIO;
+	}
+
+	if(debugfs_write_raw_flag("N") < 0)
+		fprintf(stderr, "%s: %s: failed to restore raw flag\n",
+			__func__, cxl_memdev_get_devname(memdev));
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
+static int test_cxl_cmd_lsa(struct cxl_ctx *ctx)
+{
+	int data_size = strlen(test_lsa_data) + 1;
+	struct cxl_memdev *memdev;
+	struct cxl_cmd *cmd;
+	unsigned char *buf;
+	int rc;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		rc = test_set_lsa(memdev);
+		if (rc)
+			return rc;
+
+		cmd = cxl_cmd_new_get_lsa(memdev, 0, lsa_size);
+		if (!cmd)
+			return -ENOMEM;
+		rc = cxl_cmd_set_output_payload(cmd, NULL, lsa_size);
+		if (rc) {
+			fprintf(stderr, "%s: output buffer allocation: %s\n",
+				__func__, strerror(-rc));
+			return rc;
+		}
+		rc = cxl_cmd_submit(cmd);
+		if (rc < 0) {
+			fprintf(stderr, "%s: %s: cmd submission failed: %s\n",
+				__func__, cxl_memdev_get_devname(memdev),
+				strerror(-rc));
+			goto out_fail;
+		}
+
+		rc = cxl_cmd_get_mbox_status(cmd);
+		if (rc != 0) {
+			fprintf(stderr, "%s: %s: firmware status: %d\n",
+				__func__, cxl_memdev_get_devname(memdev), rc);
+			return -ENXIO;
+		}
+
+		buf = cxl_cmd_get_lsa_get_payload(cmd);
+		if (rc < 0)
+			goto out_fail;
+
+		if (memcmp(buf, test_lsa_data, data_size) != 0) {
+			fprintf(stderr, "%s: LSA data mismatch.\n", __func__);
+			hex_dump_buf(buf, data_size);
+			rc = -EIO;
+			goto out_fail;
+		}
+		cxl_cmd_unref(cmd);
+	}
+	return 0;
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return rc;
+}
+
 typedef int (*do_test_fn)(struct cxl_ctx *ctx);
 
 static do_test_fn do_test[] = {
@@ -216,6 +349,7 @@ static do_test_fn do_test[] = {
 	test_cxl_presence,
 	test_cxl_emulation_env,
 	test_cxl_cmd_identify,
+	test_cxl_cmd_lsa,
 };
 
 static int test_libcxl(int loglevel, struct test_ctx *test, struct cxl_ctx *ctx)
diff --git a/test/Makefile.am b/test/Makefile.am
index ce492a4..23f4860 100644
--- a/test/Makefile.am
+++ b/test/Makefile.am
@@ -86,7 +86,8 @@ LIBNDCTL_LIB =\
 testcore =\
 	core.c \
 	../util/log.c \
-	../util/sysfs.c
+	../util/sysfs.c \
+	../util/hexdump.c
 
 libndctl_SOURCES = libndctl.c $(testcore)
 libndctl_LDADD = $(LIBNDCTL_LIB) $(UUID_LIBS) $(KMOD_LIBS)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
