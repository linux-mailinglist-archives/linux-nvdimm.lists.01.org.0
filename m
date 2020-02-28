Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 937AC174049
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 20:34:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23B4610FC36F0;
	Fri, 28 Feb 2020 11:34:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.24; helo=mga09.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C80510FC36ED
	for <linux-nvdimm@lists.01.org>; Fri, 28 Feb 2020 11:34:53 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:02 -0800
X-IronPort-AV: E=Sophos;i="5.70,497,1574150400";
   d="scan'208";a="231182883"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Feb 2020 11:34:01 -0800
Subject: [PATCH v3 2/5] libnvdimm/pfn: Prevent raw mode fallback if
 pfn-infoblock valid
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Fri, 28 Feb 2020 11:17:56 -0800
Message-ID: <158291747661.1609624.13504407869218712107.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158291746615.1609624.7591692546429050845.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: VZCPKGGWQOFJ3TZENGCOOM3AQIDKY3BI
X-Message-ID-Hash: VZCPKGGWQOFJ3TZENGCOOM3AQIDKY3BI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VZCPKGGWQOFJ3TZENGCOOM3AQIDKY3BI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The EOPNOTSUPP return code from the pmem driver indicates that the
namespace has a configuration that may be valid, but the current kernel
does not support it. Expand this to all of the nd_pfn_validate() error
conditions after the infoblock has been verified as self consistent.

This prevents exposing the namespace to I/O when the infoblock needs to
be corrected, or the system needs to be put into a different
configuration (like changing the page size on PowerPC).

Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pfn_devs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index a5c25cb87116..79fe02d6f657 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -561,14 +561,14 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 			dev_dbg(&nd_pfn->dev, "align: %lx:%lx mode: %d:%d\n",
 					nd_pfn->align, align, nd_pfn->mode,
 					mode);
-			return -EINVAL;
+			return -EOPNOTSUPP;
 		}
 	}
 
 	if (align > nvdimm_namespace_capacity(ndns)) {
 		dev_err(&nd_pfn->dev, "alignment: %lx exceeds capacity %llx\n",
 				align, nvdimm_namespace_capacity(ndns));
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	/*
@@ -581,7 +581,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 	if (offset >= resource_size(&nsio->res)) {
 		dev_err(&nd_pfn->dev, "pfn array size exceeds capacity of %s\n",
 				dev_name(&ndns->dev));
-		return -EBUSY;
+		return -EOPNOTSUPP;
 	}
 
 	if ((align && !IS_ALIGNED(nsio->res.start + offset + start_pad, align))
@@ -589,7 +589,7 @@ int nd_pfn_validate(struct nd_pfn *nd_pfn, const char *sig)
 		dev_err(&nd_pfn->dev,
 				"bad offset: %#llx dax disabled align: %#lx\n",
 				offset, align);
-		return -ENXIO;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
