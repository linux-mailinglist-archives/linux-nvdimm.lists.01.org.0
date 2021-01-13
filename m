Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298CF2F44FC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 Jan 2021 08:15:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DDBFF100EB327;
	Tue, 12 Jan 2021 23:15:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71D7D100EB32C
	for <linux-nvdimm@lists.01.org>; Tue, 12 Jan 2021 23:15:15 -0800 (PST)
IronPort-SDR: aVqTH0rG6KioOlqm0NW8aU2BpqtuhowtiGruwX8wzY8ZlKq80KCgvJO/YdppE6r0yixlaxGQKR
 +Z9Y9IMR57cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157938659"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="157938659"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:15 -0800
IronPort-SDR: ILGqLlhkIYIBWLAJgHcok1oPJeG2Di6ApLi0U0UX49cetuefwyfpSiMvC1d81mJSnQa9xIAQh0
 Clo+9UKZcs1g==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400";
   d="scan'208";a="353346877"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:15:14 -0800
Subject: [ndctl PATCH 4/4] ndctl/test: Exercise soft_offline_page() corner
 cases
From: Dan Williams <dan.j.williams@intel.com>
To: vishal.l.verma@intel.com
Date: Tue, 12 Jan 2021 23:15:14 -0800
Message-ID: <161052211455.1804207.13884321454837200896.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161052209289.1804207.11599120961607513911.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: LSZPSPYHGOTTRVE6JHQACKLH7P6O7IBK
X-Message-ID-Hash: LSZPSPYHGOTTRVE6JHQACKLH7P6O7IBK
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LSZPSPYHGOTTRVE6JHQACKLH7P6O7IBK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Test soft-offline injection into PMEM namespace metadata and user mapped
space. Both attempts should fail on kernels with a pfn_to_online_page()
implementation that considers subsection ZONE_DEVICE ranges.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/dax-poison.c |   19 +++++++++++++++++++
 test/device-dax.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/test/dax-poison.c b/test/dax-poison.c
index a4ef12eca1be..4e09761f0a5e 100644
--- a/test/dax-poison.c
+++ b/test/dax-poison.c
@@ -5,6 +5,7 @@
 #include <signal.h>
 #include <setjmp.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
@@ -49,6 +50,7 @@ int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
 	unsigned char *addr = MAP_FAILED;
 	struct sigaction act;
 	unsigned x = x;
+	FILE *smaps;
 	void *buf;
 	int rc;
 
@@ -94,6 +96,9 @@ int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
 		goto out;
 	}
 
+	fprintf(stderr, "%s: mmap got %p align: %ld offset: %zd\n",
+			__func__, addr, align, offset);
+
 	if (sigsetjmp(sj_env, 1)) {
 		if (sig_mcerr_ar) {
 			fprintf(stderr, "madvise triggered 'action required' sigbus\n");
@@ -104,6 +109,20 @@ int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
 		}
 	}
 
+	rc = madvise(addr + align / 2, 4096, MADV_SOFT_OFFLINE);
+	if (rc == 0) {
+		fprintf(stderr, "softoffline should always fail for dax\n");
+		smaps = fopen("/proc/self/smaps", "r");
+		do {
+			rc = fread(buf, 1, 4096, smaps);
+			fwrite(buf, 1, rc, stderr);
+		} while (rc);
+		fclose(smaps);
+		fail();
+		rc = -ENXIO;
+		goto out;
+	}
+
 	rc = madvise(addr + align / 2, 4096, MADV_HWPOISON);
 	if (rc) {
 		fail();
diff --git a/test/device-dax.c b/test/device-dax.c
index 5f0da297f28e..aad8fa5f1cb1 100644
--- a/test/device-dax.c
+++ b/test/device-dax.c
@@ -128,6 +128,44 @@ static int verify_data(struct daxctl_dev *dev, char *dax_buf,
 	return 0;
 }
 
+static int test_dax_soft_offline(struct ndctl_test *test, struct ndctl_namespace *ndns)
+{
+	unsigned long long resource = ndctl_namespace_get_resource(ndns);
+	int fd, rc;
+	char *buf;
+
+	if (resource == ULLONG_MAX) {
+		fprintf(stderr, "failed to get resource: %s\n",
+				ndctl_namespace_get_devname(ndns));
+		return -ENXIO;
+	}
+
+	fd = open("/sys/devices/system/memory/soft_offline_page", O_WRONLY);
+	if (fd < 0) {
+		fprintf(stderr, "failed to open soft_offline_page\n");
+		return -ENOENT;
+	}
+
+	rc = asprintf(&buf, "%#llx\n", resource);
+	if (rc < 0) {
+		fprintf(stderr, "failed to alloc resource\n");
+		close(fd);
+		return -ENOMEM;
+	}
+
+	fprintf(stderr, "%s: try to offline page @%#llx\n", __func__, resource);
+	rc = write(fd, buf, rc);
+	free(buf);
+	close(fd);
+
+	if (rc >= 0) {
+		fprintf(stderr, "%s: should have failed\n", __func__);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static int __test_device_dax(unsigned long align, int loglevel,
 		struct ndctl_test *test, struct ndctl_ctx *ctx)
 {
@@ -278,6 +316,13 @@ static int __test_device_dax(unsigned long align, int loglevel,
 			goto out;
 		}
 
+		rc = test_dax_soft_offline(test, ndns);
+		if (rc) {
+			fprintf(stderr, "%s: failed dax soft offline\n",
+					ndctl_namespace_get_devname(ndns));
+			goto out;
+		}
+
 		rc = test_dax_poison(test, fd, align, NULL, 0, devdax);
 		if (rc) {
 			fprintf(stderr, "%s: failed dax poison\n",
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
