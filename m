Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2196D1DC464
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 May 2020 02:59:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0BE5211F8CED8;
	Wed, 20 May 2020 17:55:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.151; helo=mga17.intel.com; envelope-from=vishal.l.verma@intel.com; receiver=<UNKNOWN> 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 16D9F11F57C2F
	for <linux-nvdimm@lists.01.org>; Wed, 20 May 2020 17:55:36 -0700 (PDT)
IronPort-SDR: ULGOl4IIwu+7uV8VgOkMmAzrQn3xY/2kjVDvEWOfKw+tr1vikh1uWiqVSpoYLVUZOw2Z/YTg7Z
 GWxCFSnWywWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 17:59:03 -0700
IronPort-SDR: P6LtpReucp1+s+lXHk09v43+MEsTz2fVeIKiUaFkT/9FebGf6ZMVteJGR80T7/nqeawFSlkG4O
 tqyz+4UssMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400";
   d="scan'208";a="440250139"
Received: from vverma7-mobl4.lm.intel.com ([10.251.149.210])
  by orsmga005.jf.intel.com with ESMTP; 20 May 2020 17:59:03 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [ndctl PATCH 2/2] ndctl/test: fix align.sh to not expect initialized labels
Date: Wed, 20 May 2020 18:58:48 -0600
Message-Id: <20200521005848.7272-2-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200521005848.7272-1-vishal.l.verma@intel.com>
References: <20200521005848.7272-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Message-ID-Hash: LSGXKYC7PEIMUZJ2LSPVSNDWWLGXTOKJ
X-Message-ID-Hash: LSGXKYC7PEIMUZJ2LSPVSNDWWLGXTOKJ
X-MailFrom: vishal.l.verma@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LSGXKYC7PEIMUZJ2LSPVSNDWWLGXTOKJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

A fresh qemu based system may not have its labels initialized. In this
case, align.sh would get skipped because the label-less namespaces would
be using all available region capacity.

Fix this by initializing labels if a usable region is not found the
first time around, and try again.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 test/align.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/test/align.sh b/test/align.sh
index 81d1fbc..37b2a1d 100755
--- a/test/align.sh
+++ b/test/align.sh
@@ -34,8 +34,19 @@ is_aligned() {
 set -e
 trap 'err $LINENO cleanup' ERR
 
-region=$($NDCTL list -R -b ACPI.NFIT | jq -r '[.[] | select(.available_size == .size)][0] | .dev')
+find_region()
+{
+	$NDCTL list -R -b ACPI.NFIT | jq -r '[.[] | select(.available_size == .size)][0] | .dev'
+}
 
+region=$(find_region)
+if [ "x$region" = "xnull"  ]; then
+	# this is destructive
+	$NDCTL disable-region -b ACPI.NFIT all
+	$NDCTL init-labels -f -b ACPI.NFIT all
+	$NDCTL enable-region -b ACPI.NFIT all
+fi
+region=$(find_region)
 if [ "x$region" = "xnull"  ]; then
 	unset $region
 	echo "unable to find empty region"
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
