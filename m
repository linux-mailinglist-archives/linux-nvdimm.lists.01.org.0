Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82377C2B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:46 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3A02212E25B5;
	Sat, 27 Jul 2019 14:57:11 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2F2EA212E258A
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:09 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="194804318"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:42 -0700
Subject: [ndctl PATCH v2 12/26] ndctl/namespace: Minimize label data
 transfer for autolabel
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:25 -0700
Message-ID: <156426362517.531577.97948221719947571.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156426356088.531577.14828880045306313118.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Use the new ndctl_dimm_read_label_index() helper to minimize the amount
of label I/O needed to execute an autolabel event.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 645aa14882bb..a3963d79831a 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -1029,7 +1029,7 @@ retry:
 		int num_labels, avail;
 
 		ndctl_cmd_unref(cmd_read);
-		cmd_read = ndctl_dimm_read_labels(dimm);
+		cmd_read = ndctl_dimm_read_label_index(dimm);
 		if (!cmd_read)
 			continue;
 

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
