Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D592134F3
	for <lists+linux-nvdimm@lfdr.de>; Fri,  3 May 2019 23:32:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F0A4821BB2520;
	Fri,  3 May 2019 14:32:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.100; helo=mga07.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 02D572194EB7C
 for <linux-nvdimm@lists.01.org>; Fri,  3 May 2019 14:32:43 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 May 2019 14:32:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,427,1549958400"; d="scan'208";a="145838685"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga008.fm.intel.com with ESMTP; 03 May 2019 14:32:43 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH 8/8] contrib/ndctl: add bash-completion for
 daxctl-reconfigure-device
Date: Fri,  3 May 2019 15:32:31 -0600
Message-Id: <20190503213231.12280-9-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503213231.12280-1-vishal.l.verma@intel.com>
References: <20190503213231.12280-1-vishal.l.verma@intel.com>
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

Add bash completion helpers for the new daxctl-reconfigure-device
command.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 contrib/ndctl | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/contrib/ndctl b/contrib/ndctl
index d1f8bd6..32c4731 100755
--- a/contrib/ndctl
+++ b/contrib/ndctl
@@ -544,7 +544,7 @@ __daxctlcomp()
 
 	COMPREPLY=( $( compgen -W "$1" -- "$2" ) )
 	for cword in "${COMPREPLY[@]}"; do
-		if [[ "$cword" == @(--region|--dev) ]]; then
+		if [[ "$cword" == @(--region|--dev|--mode) ]]; then
 			COMPREPLY[$i]="${cword}="
 		else
 			COMPREPLY[$i]="${cword} "
@@ -569,6 +569,9 @@ __daxctl_comp_options()
 		--dev)
 			opts="$(__daxctl_get_devs -i)"
 			;;
+		--mode)
+			opts="system-ram devdax"
+			;;
 		*)
 			return
 			;;
@@ -579,8 +582,19 @@ __daxctl_comp_options()
 
 __daxctl_comp_non_option_args()
 {
-	# there aren't any commands that accept non option arguments yet
-	return
+	local subcmd=$1
+	local cur=$2
+	local opts
+
+	case $subcmd in
+	reconfigure-device)
+		opts="$(__daxctl_get_devs -i) all"
+		;;
+	*)
+		return
+		;;
+	esac
+	__daxctlcomp "$opts" "$cur"
 }
 
 __daxctl_main()
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
