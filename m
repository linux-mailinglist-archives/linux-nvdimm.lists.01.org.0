Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5827D24E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  1 Aug 2019 02:30:00 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A4D372194EB7C;
	Wed, 31 Jul 2019 17:32:18 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.31; helo=mga06.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CC46C212FD4E8
 for <linux-nvdimm@lists.01.org>; Wed, 31 Jul 2019 17:32:16 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Jul 2019 17:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,332,1559545200"; d="scan'208";a="256388883"
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by orsmga001.jf.intel.com with ESMTP; 31 Jul 2019 17:29:45 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH v9 12/13] contrib/ndctl: add bash-completion for the new
 daxctl commands
Date: Wed, 31 Jul 2019 18:29:31 -0600
Message-Id: <20190801002932.26430-13-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801002932.26430-1-vishal.l.verma@intel.com>
References: <20190801002932.26430-1-vishal.l.verma@intel.com>
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

Add bash completion helpers for the new daxctl-reconfigure-device,
daxctl-online-memory, and daxctl-offline-memory commands.

Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 contrib/ndctl | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/contrib/ndctl b/contrib/ndctl
index cacee2d..680fe6a 100755
--- a/contrib/ndctl
+++ b/contrib/ndctl
@@ -547,7 +547,7 @@ __daxctlcomp()
 
 	COMPREPLY=( $( compgen -W "$1" -- "$2" ) )
 	for cword in "${COMPREPLY[@]}"; do
-		if [[ "$cword" == @(--region|--dev) ]]; then
+		if [[ "$cword" == @(--region|--dev|--mode) ]]; then
 			COMPREPLY[$i]="${cword}="
 		else
 			COMPREPLY[$i]="${cword} "
@@ -572,6 +572,9 @@ __daxctl_comp_options()
 		--dev)
 			opts="$(__daxctl_get_devs -i)"
 			;;
+		--mode)
+			opts="system-ram devdax"
+			;;
 		*)
 			return
 			;;
@@ -582,8 +585,23 @@ __daxctl_comp_options()
 
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
+		;&
+	online-memory)
+		;&
+	offline-memory)
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
