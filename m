Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C652C1D86
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Nov 2020 06:27:48 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 07B2A100EBB7C;
	Mon, 23 Nov 2020 21:27:46 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 61697100EBB71
	for <linux-nvdimm@lists.01.org>; Mon, 23 Nov 2020 21:27:43 -0800 (PST)
IronPort-SDR: UdtMID9EyTfpi7p2SGCAPbB9u3OE6JJEuP68lU/dgjgQAHBgW1TVxh76X2oQjp0PqLKCKmaQ3O
 1N7VKaAR51LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="236031569"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400";
   d="scan'208";a="236031569"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 21:27:42 -0800
IronPort-SDR: slVFfxUjVUc5hAVhYANK4q6P8xaOpwCaklMmE441hegdvLl6m4iEchBe6uUU5YnIo5WSePVbu7
 MrTpzDEzBqGg==
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400";
   d="scan'208";a="332439281"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 21:27:42 -0800
Subject: [PATCH] ACPI: NFIT: Fix input validation of bus-family
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 23 Nov 2020 21:27:42 -0800
Message-ID: <160619566216.201177.9354229595539334957.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: V5KWP5M3H6VH6CBKP5TX47BJF575DQFD
X-Message-ID-Hash: V5KWP5M3H6VH6CBKP5TX47BJF575DQFD
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dan Carpenter <dan.carpenter@oracle.com>, stable@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/V5KWP5M3H6VH6CBKP5TX47BJF575DQFD/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan reports that smatch thinks userspace can craft an out-of-bound bus
family number. However, nd_cmd_clear_to_send() blocks all non-zero
values of bus-family since only the kernel can initiate these commands.
However, in the speculation path, family is a user controlled array
index value so mask it for speculation safety. Also, since the
nd_cmd_clear_to_send() safety is non-obvious and possibly may change in
the future include input validation is if userspace could get past the
nd_cmd_clear_to_send() gatekeeper.

Link: http://lore.kernel.org/r/20201111113000.GA1237157@mwanda
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index cda7b6c52504..b11b08a60684 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -5,6 +5,7 @@
 #include <linux/list_sort.h>
 #include <linux/libnvdimm.h>
 #include <linux/module.h>
+#include <linux/nospec.h>
 #include <linux/mutex.h>
 #include <linux/ndctl.h>
 #include <linux/sysfs.h>
@@ -479,8 +480,11 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		cmd_mask = nd_desc->cmd_mask;
 		if (cmd == ND_CMD_CALL && call_pkg->nd_family) {
 			family = call_pkg->nd_family;
-			if (!test_bit(family, &nd_desc->bus_family_mask))
+			if (family > NVDIMM_BUS_FAMILY_MAX ||
+			    !test_bit(family, &nd_desc->bus_family_mask))
 				return -EINVAL;
+			family = array_index_nospec(family,
+						    NVDIMM_BUS_FAMILY_MAX + 1);
 			dsm_mask = acpi_desc->family_dsm_mask[family];
 			guid = to_nfit_bus_uuid(family);
 		} else {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
