Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2251DC463
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 02:59:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E552711F8787B;
	Wed, 20 May 2020 17:55:37 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5C31111F57C2F
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 17:55:35 -0700 (PDT)
IronPort-SDR: 5ylKkWX00cuD/Yk14xe9bPvdjKVnKaVdm0DFKkuJJQIrNvpkRVIUSzXZHtFvbPh3RjI/LaamhS
 XuuRdQemTt3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 17:59:02 -0700
IronPort-SDR: F4sLWZrTrwH79kwqJ9zWwpkllvpSCPofXCQhpkir5v+pNNDjWFkCstwj3uow9RYdZ6FFkbBi+v
 ohQWsz5J6V1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400";
   d="scan'208";a="440250133"
Received: from vverma7-mobl4.lm.intel.com ([10.251.149.210])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2020 17:59:01 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 1/2] ndctl/test: Fix region selection in align.sh
Date: Wed, 20 May 2020 18:58:47 -0600
Message-Id: <20200521005848.7272-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Message-ID-Hash: VCN5VV3TOZCMCOMN5URDU4M2ARRLGL7T
X-Message-ID-Hash: VCN5VV3TOZCMCOMN5URDU4M2ARRLGL7T
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VCN5VV3TOZCMCOMN5URDU4M2ARRLGL7T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Fix the region filtering/selection for the align.sh test. The current jq
filter falls over if two regions match the criteria because array
elements got flattened to the top level.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/align.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/align.sh b/test/align.sh
index 0129255..81d1fbc 100755
--- a/test/align.sh
+++ b/test/align.sh
@@ -34,7 +34,7 @@ is_aligned() {
 set -e
 trap 'err $LINENO cleanup' ERR
 
-region=$($NDCTL list -R -b ACPI.NFIT | jq -r '.[] | [select(.available_size == .size)] | .[0].dev')
+region=$($NDCTL list -R -b ACPI.NFIT | jq -r '[.[] | select(.available_size == .size)][0] | .dev')
 
 if [ "x$region" = "xnull"  ]; then
 	unset $region
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
