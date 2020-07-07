Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB0216441
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:58:01 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 364E41108E90C;
	Mon,  6 Jul 2020 19:58:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ED2F81108E909
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:57:58 -0700 (PDT)
IronPort-SDR: T7WQ0OVBB60qM0EZh/+8k8FKHCqWBhkuqsebLfK8zhdGw7S0x+1gS9dLDfKH7PeUiNrvZwXFME
 H9B0Ap9llgKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="149041640"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="149041640"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:58 -0700
IronPort-SDR: a2eJb0pFVVZKZxeacRekTrR+sz8SW5g2+dKL55V3VsnwgB2jz0BPbdzOfhC7ew/bxV9udVYqRG
 1o9+Dh4s1HIA==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="279464222"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:57:58 -0700
Subject: [ndctl PATCH 16/16] test/ndctl: mremap pmd confusion
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: vishal.l.verma@intel.com
Date: Mon, 06 Jul 2020 19:41:43 -0700
Message-ID: <159408970344.2386154.3822093364134233478.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408961822.2386154.888266173771881937.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: RJMV4VNKFUTQB7H67FWII43GXXSWLA4F
X-Message-ID-Hash: RJMV4VNKFUTQB7H67FWII43GXXSWLA4F
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RJMV4VNKFUTQB7H67FWII43GXXSWLA4F/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

mremap() fails to check for pmd_devmap() entries in some kernels leading to
a case where move_page_tables() interprets a pmd_devmap() entry as a page
table and not a leaf entry. Reproduce this failing condition across
device-dax and fileystem-dax.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test.h            |    2 +
 test/dax-dev.c    |    4 ++
 test/dax-pmd.c    |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 test/device-dax.c |    7 ++++
 4 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/test.h b/test.h
index fa0c0cff9daf..3f6212e067fc 100644
--- a/test.h
+++ b/test.h
@@ -38,6 +38,8 @@ struct ndctl_ctx;
 int test_parent_uuid(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
 int test_multi_pmem(int loglevel, struct ndctl_test *test, struct ndctl_ctx *ctx);
 int test_dax_directio(int dax_fd, unsigned long align, void *dax_addr, off_t offset);
+int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, void *dax_addr,
+		off_t offset, bool fsdax);
 #ifdef ENABLE_POISON
 int test_dax_poison(struct ndctl_test *test, int dax_fd, unsigned long align,
 		void *dax_addr, off_t offset, bool fsdax);
diff --git a/test/dax-dev.c b/test/dax-dev.c
index 49ccaa334e31..ab6b35a67183 100644
--- a/test/dax-dev.c
+++ b/test/dax-dev.c
@@ -60,6 +60,10 @@ struct ndctl_namespace *ndctl_get_test_dev(struct ndctl_ctx *ctx)
 	if (!ndns)
 		goto out;
 
+	rc = ndctl_namespace_enable(ndns);
+	if (rc)
+		goto out;
+
 	mode = ndctl_namespace_get_mode(ndns);
 	if (mode >= 0 && mode != NDCTL_NS_MODE_MEMORY)
 		goto out;
diff --git a/test/dax-pmd.c b/test/dax-pmd.c
index 0c95b20707c2..df3219639a6d 100644
--- a/test/dax-pmd.c
+++ b/test/dax-pmd.c
@@ -27,6 +27,7 @@
 #include <test.h>
 #include <util/size.h>
 #include <linux/fiemap.h>
+#include <linux/version.h>
 
 #define NUM_EXTENTS 5
 #define fail() fprintf(stderr, "%s: failed at: %d (%s)\n", \
@@ -35,6 +36,92 @@
 	__func__, __LINE__, i, strerror(errno))
 #define TEST_FILE "test_dax_data"
 
+#define REGION_MEM_SIZE 4096*4
+#define REGION_PM_SIZE        4096*512
+#define REMAP_SIZE      4096
+
+static sigjmp_buf sj_env;
+
+static void sigbus(int sig, siginfo_t *siginfo, void *d)
+{
+	siglongjmp(sj_env, 1);
+}
+
+int test_dax_remap(struct ndctl_test *test, int dax_fd, unsigned long align, void *dax_addr,
+		off_t offset, bool fsdax)
+{
+	void *anon, *remap, *addr;
+	struct sigaction act;
+	int rc, val;
+
+	if ((fsdax || align == SZ_2M) && !ndctl_test_attempt(test, KERNEL_VERSION(5, 8, 0))) {
+		/* kernel's prior to 5.8 may crash on this test */
+		fprintf(stderr, "%s: SKIP mremap() test\n", __func__);
+		return 0;
+	}
+
+	anon = mmap(NULL, REGION_MEM_SIZE, PROT_READ|PROT_WRITE,
+			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+
+	addr = mmap(dax_addr, 2*align,
+			PROT_READ|PROT_WRITE, MAP_SHARED, dax_fd, offset);
+
+	fprintf(stderr, "%s: addr: %p size: %#lx\n", __func__, addr, 2*align);
+
+	if (addr == MAP_FAILED) {
+		rc = -errno;
+		faili(0);
+		return rc;
+	}
+
+	memset(anon, 'a', REGION_MEM_SIZE);
+	memset(addr, 'i', align*2);
+
+	remap = mremap(addr, REMAP_SIZE, REMAP_SIZE, MREMAP_MAYMOVE|MREMAP_FIXED, anon);
+
+	if (remap != anon) {
+		rc = -ENXIO;
+		perror("mremap");
+		faili(1);
+		return rc;
+	}
+
+	fprintf(stderr, "%s: addr: %p size: %#x\n", __func__, remap, REMAP_SIZE);
+
+	memset(&act, 0, sizeof(act));
+	act.sa_sigaction = sigbus;
+	act.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGBUS, &act, 0)) {
+		perror("sigaction");
+		rc = EXIT_FAILURE;
+		goto out;
+	}
+
+	/* test fault after device-dax instance disabled */
+	if (sigsetjmp(sj_env, 1)) {
+		if (!fsdax && align > SZ_4K) {
+			fprintf(stderr, "got expected SIGBUS after mremap() of device-dax\n");
+			rc = 0;
+		} else {
+			fprintf(stderr, "unpexpected SIGBUS after mremap()\n");
+			rc = -EIO;
+		}
+		goto out;
+	}
+
+	*(int *) anon = 0xAA;
+	val = *(int *) anon;
+
+	if (val != 0xAA) {
+		faili(2);
+		return -ENXIO;
+	}
+
+	rc = 0;
+out:
+	return rc;
+}
+
 int test_dax_directio(int dax_fd, unsigned long align, void *dax_addr, off_t offset)
 {
 	int i, rc = -ENXIO;
@@ -254,15 +341,19 @@ static int test_pmd(struct ndctl_test *test, int fd)
 
 	pmd_addr = (char *) base + m_align;
 	pmd_off =  ext->fe_logical + p_align;
+	rc = test_dax_remap(test, fd, HPAGE_SIZE, pmd_addr, pmd_off, fsdax);
+	if (rc)
+		goto err_test;
+
 	rc = test_dax_directio(fd, HPAGE_SIZE, pmd_addr, pmd_off);
 	if (rc)
-		goto err_directio;
+		goto err_test;
 
 	rc = test_dax_poison(test, fd, HPAGE_SIZE, pmd_addr, pmd_off, fsdax);
 
- err_directio:
- err_extent:
- err_mmap:
+err_test:
+err_extent:
+err_mmap:
 	free(map);
 	return rc;
 }
diff --git a/test/device-dax.c b/test/device-dax.c
index b19c1ed0b535..9de10682e34d 100644
--- a/test/device-dax.c
+++ b/test/device-dax.c
@@ -268,6 +268,13 @@ static int __test_device_dax(unsigned long align, int loglevel,
 					ndctl_namespace_get_devname(ndns));
 			goto out;
 		}
+
+		rc = test_dax_remap(test, fd, align, NULL, 0, devdax);
+		if (rc) {
+			fprintf(stderr, "%s: failed dax remap\n",
+					ndctl_namespace_get_devname(ndns));
+			goto out;
+		}
 		close(fd);
 
 		fprintf(stderr, "%s: test dax poison\n",
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
