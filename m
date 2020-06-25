Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433420A992
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 02:07:00 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 383B5110122B3;
	Thu, 25 Jun 2020 17:06:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2000D11001AC0
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 17:06:57 -0700 (PDT)
IronPort-SDR: F5TbQwIc2PyQ9uGmLsSw4Q+yfWBAiv3gt/gC6bFfsvdD/2iB/cwFeYbqDPZSqAcp/RdbWIb+8m
 6jcQdyjPGnEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="125347015"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="125347015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:06:56 -0700
IronPort-SDR: rnMUlXvABKnvDX7FrKhx1Qg+l4cDNKEf+QmLz7CR9oEO2mUPxBRdSgTIvti8KqG7sE4CxI0ZQX
 8cKphOtS+N9Q==
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800";
   d="scan'208";a="279989435"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 17:06:56 -0700
Subject: [PATCH 04/12] tools/testing/nvdimm: Cleanup dimm index passing
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Thu, 25 Jun 2020 16:50:42 -0700
Message-ID: <159312904210.1850128.9566374963556922854.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: 7OIII2LICLQI34H7IUCGEM6HJDK4QPAH
X-Message-ID-Hash: 7OIII2LICLQI34H7IUCGEM6HJDK4QPAH
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7OIII2LICLQI34H7IUCGEM6HJDK4QPAH/>
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
