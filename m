Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F95A4E7
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Jun 2019 21:11:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F36AF21945DE1;
	Fri, 28 Jun 2019 12:11:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4A6402129EB8E
 for <linux-nvdimm@lists.01.org>; Fri, 28 Jun 2019 12:11:22 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jun 2019 12:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; d="scan'208";a="173564759"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga002.jf.intel.com with ESMTP; 28 Jun 2019 12:11:21 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v5 11/13] contrib/ndctl: fix region-id completions for
 daxctl
Date: Fri, 28 Jun 2019 13:11:08 -0600
Message-Id: <20190628191110.21428-12-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628191110.21428-1-vishal.l.verma@intel.com>
References: <20190628191110.21428-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

The completion helpers for daxctl assumed the region arguments for
specifying daxctl regions were the same as ndctl regions, i.e.
"regionX". This is not true - daxctl region arguments are a simple
numeric 'id'.

Add a new helper __daxctl_get_regions() to complete daxctl region IDs
properly.

While at it, fix a useless use of 'echo' in __daxctl_get_devs() and
quoting in __daxctl_comp_options()

Fixes: d6790a32f32c ("daxctl: Add bash-completion")
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 contrib/ndctl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/contrib/ndctl b/contrib/ndctl
index 396a344..cacee2d 100755
--- a/contrib/ndctl
+++ b/contrib/ndctl
@@ -531,8 +531,14 @@ _ndctl()
 
 __daxctl_get_devs()
 {
-	local opts="--devices $*"
-	echo "$(daxctl list $opts | grep -E "^\s*\"chardev\":" | cut -d\" -f4)"
+	local opts=("--devices" "$*")
+	daxctl list "${opts[@]}" | grep -E "^\s*\"chardev\":" | cut -d'"' -f4
+}
+
+__daxctl_get_regions()
+{
+	local opts=("--regions" "$*")
+	daxctl list "${opts[@]}" | grep -E "^\s*\"id\":" | grep -Eo "[0-9]+"
 }
 
 __daxctlcomp()
@@ -561,10 +567,10 @@ __daxctl_comp_options()
 		local cur_arg=${cur##*=}
 		case $cur_subopt in
 		--region)
-			opts=$(__ndctl_get_regions -i)
+			opts="$(__daxctl_get_regions -i)"
 			;;
 		--dev)
-			opts=$(__daxctl_get_devs -i)
+			opts="$(__daxctl_get_devs -i)"
 			;;
 		*)
 			return
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
