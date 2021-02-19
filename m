Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B24831F3CA
	for <lists+linux-nvdimm@lfdr.de>; Fri, 19 Feb 2021 03:04:17 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5F2B7100EAB0C;
	Thu, 18 Feb 2021 18:04:05 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.120; helo=mga04.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E80D2100EAB7B
	for <linux-nvdimm@lists.01.org>; Thu, 18 Feb 2021 18:03:56 -0800 (PST)
IronPort-SDR: l2+ofm1dhvcRKQjCLqy9Xh6ca6twBcQLR411LCv64RfFoJpP1S+8sgTtAyYHIBE6+uTO8hv3NO
 hfxeNtywQh3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9899"; a="181151526"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="181151526"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
IronPort-SDR: GDo/Lx3087n09v8JUHr7Uq+iVJYdHjkn5E9SJCY4BSfaDrVZ0LNIlGn/5yddP+DW13WspLCjTl
 VidP7VO+NcwQ==
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400";
   d="scan'208";a="513509691"
Received: from jnavar1-mobl4.amr.corp.intel.com (HELO omniknight.intel.com) ([10.213.167.18])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 18:03:56 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-cxl@vger.kernel.org>
Subject: [ndctl PATCH v2 13/13] test/libcxl: introduce a command size fuzzing test
Date: Thu, 18 Feb 2021 19:03:31 -0700
Message-Id: <20210219020331.725687-14-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210219020331.725687-1-vishal.l.verma@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: IMRCSZYTH3VY5BZFQNZGNN5ZHZYJ3I4O
X-Message-ID-Hash: IMRCSZYTH3VY5BZFQNZGNN5ZHZYJ3I4O
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, Ben Widawsky <ben.widawsky@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IMRCSZYTH3VY5BZFQNZGNN5ZHZYJ3I4O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a new test within test/libcxl which tries different combinations of
valid and invalid payload sizes, and ensures that the kernel responds as
expected by either succeeding, erroring out the ioctl, adjusting the
out.size in the response etc.

The fuzz set is a statically defined array which contains the different
combinations to test. Adding a new combination onle needs appending to
this array.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/libcxl.c | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/test/libcxl.c b/test/libcxl.c
index 1cff32c..f7233b2 100644
--- a/test/libcxl.c
+++ b/test/libcxl.c
@@ -210,6 +210,117 @@ out_fail:
 	return rc;
 }
 
+struct cmd_fuzzer {
+	struct cxl_cmd *(*new_fn)(struct cxl_memdev *memdev);
+	int in;		/* in size to set in cmd (INT_MAX = don't change) */
+	int out;	/* out size to set in cmd (INT_MAX = don't change) */
+	int e_out;	/* expected out size returned (INT_MAX = don't check) */
+	int e_rc;	/* expected ioctl return (INT_MAX = don't check) */
+	int e_hwrc;	/* expected 'mbox_status' (INT_MAX = don't check) */
+} fuzz_set[] = {
+	{ cxl_cmd_new_identify, INT_MAX, INT_MAX, 67, 0, 0 },
+	{ cxl_cmd_new_identify, 64, INT_MAX, INT_MAX, -ENOMEM, INT_MAX },
+	{ cxl_cmd_new_identify, INT_MAX, 1024, 67, 0, INT_MAX },
+	{ cxl_cmd_new_identify, INT_MAX, 16, INT_MAX, -ENOMEM, INT_MAX },
+};
+
+static int do_one_cmd_size_test(struct cxl_memdev *memdev,
+		struct cmd_fuzzer *test)
+{
+	const char *devname = cxl_memdev_get_devname(memdev);
+	struct cxl_cmd *cmd;
+	int rc;
+
+	cmd = test->new_fn(memdev);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (test->in != INT_MAX) {
+		rc = cxl_cmd_set_input_payload(cmd, NULL, test->in);
+		if (rc) {
+			fprintf(stderr,
+				"%s: %s: failed to set in.size (%d): %s\n",
+				__func__, devname, test->in, strerror(-rc));
+			goto out_fail;
+		}
+	}
+	if (test->out != INT_MAX) {
+		rc = cxl_cmd_set_output_payload(cmd, NULL, test->out);
+		if (rc) {
+			fprintf(stderr,
+				"%s: %s: failed to set out.size (%d): %s\n",
+				__func__, devname, test->out, strerror(-rc));
+			goto out_fail;
+		}
+	}
+
+	rc = cxl_cmd_submit(cmd);
+	if (test->e_rc != INT_MAX && rc != test->e_rc) {
+		fprintf(stderr, "%s: %s: expected cmd rc %d, got %d\n",
+			__func__, devname, test->e_rc, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+
+	rc = cxl_cmd_get_out_size(cmd);
+	if (test->e_out != INT_MAX && rc != test->e_out) {
+		fprintf(stderr, "%s: %s: expected response out.size %d, got %d\n",
+			__func__, devname, test->e_out, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+
+	rc = cxl_cmd_get_mbox_status(cmd);
+	if (test->e_hwrc != INT_MAX && rc != test->e_hwrc) {
+		fprintf(stderr, "%s: %s: expected firmware status %d, got %d\n",
+			__func__, devname, test->e_hwrc, rc);
+		rc = -ENXIO;
+		goto out_fail;
+	}
+	return 0;
+
+out_fail:
+	cxl_cmd_unref(cmd);
+	return rc;
+
+}
+
+static void print_fuzz_test_status(struct cmd_fuzzer *t, const char *devname,
+		unsigned long idx, const char *msg)
+{
+	fprintf(stderr,
+		"%s: fuzz_set[%lu]: in: %d, out %d, e_out: %d, e_rc: %d, e_hwrc: %d, result: %s\n",
+		devname, idx,
+		(t->in == INT_MAX) ? -1 : t->in,
+		(t->out == INT_MAX) ? -1 : t->out,
+		(t->e_out == INT_MAX) ? -1 : t->e_out,
+		(t->e_rc == INT_MAX) ? -1 : t->e_rc,
+		(t->e_hwrc == INT_MAX) ? -1 : t->e_hwrc,
+		msg);
+}
+
+static int test_cxl_cmd_fuzz_sizes(struct cxl_ctx *ctx)
+{
+	struct cxl_memdev *memdev;
+	unsigned long i;
+	int rc;
+
+	cxl_memdev_foreach(ctx, memdev) {
+		const char *devname = cxl_memdev_get_devname(memdev);
+
+		for (i = 0; i < ARRAY_SIZE(fuzz_set); i++) {
+			rc = do_one_cmd_size_test(memdev, &fuzz_set[i]);
+			if (rc) {
+				print_fuzz_test_status(&fuzz_set[i], devname,
+					i, "FAIL");
+				return rc;
+			}
+			print_fuzz_test_status(&fuzz_set[i], devname, i, "OK");
+		}
+	}
+	return 0;
+}
+
 static int debugfs_write_raw_flag(char *str)
 {
 	char *path = "/sys/kernel/debug/cxl/mbox/raw_allow_all";
@@ -350,6 +461,7 @@ static do_test_fn do_test[] = {
 	test_cxl_emulation_env,
 	test_cxl_cmd_identify,
 	test_cxl_cmd_lsa,
+	test_cxl_cmd_fuzz_sizes,
 };
 
 static int test_libcxl(int loglevel, struct test_ctx *test, struct cxl_ctx *ctx)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
