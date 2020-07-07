Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8017E2163B4
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 04:15:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F0481108DEA9;
	Mon,  6 Jul 2020 19:15:12 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.136; helo=mga12.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE46B1108DEA7
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 19:15:10 -0700 (PDT)
IronPort-SDR: qYyj1y5oTlSv+nPoxQdodb2vqa9pyqIMX+FWGTRQ2PckUA4fl0LrQ+JTYXwBeVwotZfQIEyvRb
 vf1ZO9c4wYAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="127121355"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="127121355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:10 -0700
IronPort-SDR: 8cjKsX6iiwrrWvCxP5EkqEBJft6v6i1QXccRUD3WhUna/HYI4kqetiBoPy+bjYVCIuxK7BRmhQ
 jNNeCuycNSaw==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800";
   d="scan'208";a="279456883"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:10 -0700
Subject: [PATCH v2 04/12] tools/testing/nvdimm: Cleanup dimm index passing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 06 Jul 2020 18:58:55 -0700
Message-ID: <159408713507.2385045.7759465411330693892.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: IOFGBWDHYFVPXKXRC7EDDMHHIXUJQTJD
X-Message-ID-Hash: IOFGBWDHYFVPXKXRC7EDDMHHIXUJQTJD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IOFGBWDHYFVPXKXRC7EDDMHHIXUJQTJD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The ND_CMD_CALL path only applies to the nfit_test0 emulated DIMMs.
Cleanup occurrences of (i - t->dcr_idx) since that offset fixup only
applies to cases where nfit_test1 needs a bus-local index.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index a59174ba1d2a..ddf9b3095bfa 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -1224,6 +1224,11 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 			i = get_dimm(nfit_mem, func);
 			if (i < 0)
 				return i;
+			if (i >= NUM_DCR) {
+				dev_WARN_ONCE(&t->pdev.dev, 1,
+						"ND_CMD_CALL only valid for nfit_test0\n");
+				return -EINVAL;
+			}
 
 			switch (func) {
 			case NVDIMM_INTEL_GET_SECURITY_STATE:
@@ -1252,11 +1257,11 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 				break;
 			case NVDIMM_INTEL_OVERWRITE:
 				rc = nd_intel_test_cmd_overwrite(t,
-						buf, buf_len, i - t->dcr_idx);
+						buf, buf_len, i);
 				break;
 			case NVDIMM_INTEL_QUERY_OVERWRITE:
 				rc = nd_intel_test_cmd_query_overwrite(t,
-						buf, buf_len, i - t->dcr_idx);
+						buf, buf_len, i);
 				break;
 			case NVDIMM_INTEL_SET_MASTER_PASSPHRASE:
 				rc = nd_intel_test_cmd_master_set_pass(t,
@@ -1272,48 +1277,45 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 				break;
 			case ND_INTEL_FW_GET_INFO:
 				rc = nd_intel_test_get_fw_info(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_START_UPDATE:
 				rc = nd_intel_test_start_update(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_SEND_DATA:
 				rc = nd_intel_test_send_data(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_FINISH_UPDATE:
 				rc = nd_intel_test_finish_fw(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_FW_FINISH_QUERY:
 				rc = nd_intel_test_finish_query(t, buf,
-						buf_len, i - t->dcr_idx);
+						buf_len, i);
 				break;
 			case ND_INTEL_SMART:
 				rc = nfit_test_cmd_smart(buf, buf_len,
-						&t->smart[i - t->dcr_idx]);
+						&t->smart[i]);
 				break;
 			case ND_INTEL_SMART_THRESHOLD:
 				rc = nfit_test_cmd_smart_threshold(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx]);
+						&t->smart_threshold[i]);
 				break;
 			case ND_INTEL_SMART_SET_THRESHOLD:
 				rc = nfit_test_cmd_smart_set_threshold(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx],
-						&t->smart[i - t->dcr_idx],
+						&t->smart_threshold[i],
+						&t->smart[i],
 						&t->pdev.dev, t->dimm_dev[i]);
 				break;
 			case ND_INTEL_SMART_INJECT:
 				rc = nfit_test_cmd_smart_inject(buf,
 						buf_len,
-						&t->smart_threshold[i -
-							t->dcr_idx],
-						&t->smart[i - t->dcr_idx],
+						&t->smart_threshold[i],
+						&t->smart[i],
 						&t->pdev.dev, t->dimm_dev[i]);
 				break;
 			default:
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
