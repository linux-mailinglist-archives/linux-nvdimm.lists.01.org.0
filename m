Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 457A477C2E
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:55:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AA2C0212E46E0;
	Sat, 27 Jul 2019 14:57:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.24; helo=mga09.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 007D9212E259E
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:26 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:55:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="190061089"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:59 -0700
Subject: [ndctl PATCH v2 15/26] ndctl/dimm: Fix init-labels success reporting
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:42 -0700
Message-ID: <156426364243.531577.13465180915476535003.stgit@dwillia2-desk3.amr.corp.intel.com>
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

When a DIMM is disabled due to a label parsing issue "ndctl init-labels"
mis-reports the status of the init-labels command:

    # ndctl init-labels all -f
    initialized 1 nmem
    [root@dwillia2-dev ndctl]# ndctl list -Di
    [
      {
        "dev":"nmem1",
        "id":"8680-57341200",
        "handle":2,
        "phys_id":0,
        "state":"disabled"
      },
      {
        "dev":"nmem0",
        "id":"8680-56341200",
        "handle":1,
        "phys_id":0
      }
    ]
    # ndctl init-labels nmem1 -f
    initialized 1020 nmems

Catch any positive return from action_init() as success:

    # ndctl init-labels all -f
    initialized 2 nmems
    # ndctl init-labels nmem1 -f
    initialized 1 nmem

Reported-by: Jane Chu <jane.chu@oracle.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index c7ad621367e9..5e6fa19bab15 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -1035,7 +1035,7 @@ static int __action_init(struct ndctl_dimm *dimm,
 
  out:
 	ndctl_cmd_unref(cmd_read);
-	return rc;
+	return rc >= 0 ? 0 : rc;
 }
 
 static int action_init(struct ndctl_dimm *dimm, struct action_context *actx)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
