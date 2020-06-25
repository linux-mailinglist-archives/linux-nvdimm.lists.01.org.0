Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A617620A995
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 02:07:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 59F02110122B2;
	Thu, 25 Jun 2020 17:07:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8D42C10FC54C7
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 17:07:02 -0700 (PDT)
IronPort-SDR: xWr3JVa+L+IicpKtPkzW4UUv4kt8/JAdsIXsWA3yXViN/9Ozg0XEEZF7pecf44w5teKdOLL5ie
 JBFmzQAnxSDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125347022"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="125347022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:02 -0700
IronPort-SDR: BAlHoctKYwz2dpcDBXaHLfg8JUDyRQjAUwmzaByRTBSxzkMcheuhA8KOuVp0Uzh2QljMlXeU+C
 dWcPvj6W8oxg==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="479655207"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:07:01 -0700
Subject: [PATCH 05/12] tools/testing/nvdimm: Add command debug messages
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 25 Jun 2020 16:50:47 -0700
Message-ID: <159312904721.1850128.6777183061131324048.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: CYMMTXWVIQYRTCER5TF6QVNHQWRDRST2
X-Message-ID-Hash: CYMMTXWVIQYRTCER5TF6QVNHQWRDRST2
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CYMMTXWVIQYRTCER5TF6QVNHQWRDRST2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Arrange the for nfit_test_ctl() path to dump command payloads similarly
to the acpi_nfit_ctl() path. This is useful for comparing the
sequence of command events between an emulated ACPI-NFIT platform and a
real one.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index ddf9b3095bfa..9c6f475befe4 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1192,6 +1192,29 @@ static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 	return i;
 }
 
+static void nfit_ctl_dbg(struct acpi_nfit_desc *acpi_desc,
+		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
+		unsigned int len)
+{
+	struct nfit_test *t = container_of(acpi_desc, typeof(*t), acpi_desc);
+	unsigned int func = cmd;
+	unsigned int family = 0;
+
+	if (cmd == ND_CMD_CALL) {
+		struct nd_cmd_pkg *pkg = buf;
+
+		len = pkg->nd_size_in;
+		family = pkg->nd_family;
+		buf = pkg->nd_payload;
+		func = pkg->nd_command;
+	}
+	dev_dbg(&t->pdev.dev, "%s family: %d cmd: %d: func: %d input length: %d\n",
+			nvdimm ? nvdimm_name(nvdimm) : "bus", family, cmd, func,
+			len);
+	print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 16, 4,
+			buf, min(len, 256u), true);
+}
+
 static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc)
@@ -1205,6 +1228,8 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		cmd_rc = &__cmd_rc;
 	*cmd_rc = 0;
 
+	nfit_ctl_dbg(acpi_desc, nvdimm, cmd, buf, buf_len);
+
 	if (nvdimm) {
 		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 		unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
