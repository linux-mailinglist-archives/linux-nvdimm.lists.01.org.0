Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45861174954
	for <lists+linux-nvdimm@lfdr.de>; Sat, 29 Feb 2020 21:38:31 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ABA0D10FC3596;
	Sat, 29 Feb 2020 12:39:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.43; helo=mga05.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1448E10FC3413
	for <linux-nvdimm@lists.01.org>; Sat, 29 Feb 2020 12:39:20 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:28 -0800
X-IronPort-AV: E=Sophos;i="5.70,501,1574150400";
   d="scan'208";a="285978870"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Feb 2020 12:38:28 -0800
Subject: [ndctl PATCH 26/36] ndctl/test: Fix typos / loss of tpm.handle in
 security test
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Dave Jiang <dave.jiang@intel.com>, vishal.l.verma@intel.com
Date: Sat, 29 Feb 2020 12:22:22 -0800
Message-ID: <158300774283.2141307.10046883321054705021.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158300760415.2141307.14060353322051900501.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: LU5UJ4KTNTLJJXDOH2POY5E32CM7FHZE
X-Message-ID-Hash: LU5UJ4KTNTLJJXDOH2POY5E32CM7FHZE
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LU5UJ4KTNTLJJXDOH2POY5E32CM7FHZE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The DIMM security test confuses "tmp" and "tpm" in multiple places. It
saves the current tpm.handle file to tmp.handle.bak and tries to restore
it from tmp.handle.bak to tmp.handle. Replace all occurrences of "tmp"
with "tpm".

Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 test/security.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/security.sh b/test/security.sh
index 771135b7ab18..8e2d870c0d43 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -39,7 +39,7 @@ setup_keys()
 		backup_key=1
 	fi
 	if [ -f "$keypath/tpm.handle" ]; then
-		mv "$keypath/tpm.handle" "$keypath/tmp.handle.bak"
+		mv "$keypath/tpm.handle" "$keypath/tpm.handle.bak"
 		backup_handle=1
 	fi
 
@@ -71,7 +71,7 @@ post_cleanup()
 		mv "$masterpath.bak" "$masterpath"
 	fi
 	if [ "$backup_handle" -eq 1 ]; then
-		mv "$keypath/tpm.handle.bak" "$keypath/tmp.handle"
+		mv "$keypath/tpm.handle.bak" "$keypath/tpm.handle"
 	fi
 }
 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
