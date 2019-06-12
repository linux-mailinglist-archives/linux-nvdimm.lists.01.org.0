Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD45431D2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Jun 2019 01:05:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AACD521290DF9;
	Wed, 12 Jun 2019 16:05:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.151; helo=mga17.intel.com;
 envelope-from=alison.schofield@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3C1BB21290DF2
 for <linux-nvdimm@lists.01.org>; Wed, 12 Jun 2019 16:05:33 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 16:05:32 -0700
X-ExtLoop1: 1
Received: from alison-desk.jf.intel.com ([10.54.74.53])
 by orsmga008.jf.intel.com with ESMTP; 12 Jun 2019 16:05:32 -0700
Date: Wed, 12 Jun 2019 16:08:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] ndctl, test: handle backup_keys in security.sh
Message-ID: <20190612230845.GA13679@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Fix a typo in security.sh that causes a script failure
when an nvdimm-master.blob already exists and needs to
be backed up.

+ setup_keys
+ '[' '!' -d /etc/ndctl/keys ']'
+ '[' -f /etc/ndctl/keys/nvdimm-master.blob ']'
+ mv /etc/ndctl/keys/nvdimm-master.blob /etc/ndctl/keys/nvdimm-master.blob.bak
+ 0=1
./security.sh: line 39: 0=1: command not found

Fixes: ba35642d3815 ("ndctl: add a load-keys test in the security unit test")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 test/security.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/security.sh b/test/security.sh
index 8a36265..c86d2c6 100755
--- a/test/security.sh
+++ b/test/security.sh
@@ -36,11 +36,11 @@ setup_keys()
 
 	if [ -f "$masterpath" ]; then
 		mv "$masterpath" "$masterpath.bak"
-		$backup_key=1
+		backup_key=1
 	fi
 	if [ -f "$keypath/tpm.handle" ]; then
 		mv "$keypath/tpm.handle" "$keypath/tmp.handle.bak"
-		$backup_handle=1
+		backup_handle=1
 	fi
 
 	dd if=/dev/urandom bs=1 count=32 2>/dev/null | keyctl padd user "$masterkey" @u
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
