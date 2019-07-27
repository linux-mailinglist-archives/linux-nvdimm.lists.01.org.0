Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761177C2D
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Jul 2019 23:54:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6BB1C212E25BB;
	Sat, 27 Jul 2019 14:57:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3DE18212E2590
 for <linux-nvdimm@lists.01.org>; Sat, 27 Jul 2019 14:57:21 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:54 -0700
X-IronPort-AV: E=Sophos;i="5.64,315,1559545200"; d="scan'208";a="198966346"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jul 2019 14:54:54 -0700
Subject: [ndctl PATCH v2 14/26] ndctl/namespace: Handle 'create-namespace'
 in label-less mode
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Sat, 27 Jul 2019 14:40:36 -0700
Message-ID: <156426363655.531577.4504452379578995249.stgit@dwillia2-desk3.amr.corp.intel.com>
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

A common confusion with ndctl is that 'create-namespace' does not work
in the label-less case. In the label-less case there is no capacity to
allocate as the size if already hard-coded by the region boundary.

However, users typically do something like the following in the
label-less case:

    # ndctl list
    {
      "dev":"namespace1.0",
      "mode":"raw",
      "size":"127.00 GiB (136.37 GB)",
      "sector_size":512,
      "blockdev":"pmem1"
    }

    # ndctl destroy-namespace namespace1.0 -f
    destroyed 1 namespace

    # ndctl create-namespace
    failed to create namespace: Resource temporarily unavailable

In other words they destroy the raw mode namespace that they don't want,
and seek to create a new default configuration namespace. Since there is
no "available_capacity" in the label-less case the 'create' attempt
fails.

Fix this by recognizing that the user wants a default sized namespace
and just reconfigure the raw namespace.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/namespace.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 58fec194ab94..e5a2b1341cdb 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -837,9 +837,13 @@ static int namespace_create(struct ndctl_region *region)
 		return -EAGAIN;
 	}
 
-	available = ndctl_region_get_max_available_extent(region);
-	if (available == ULLONG_MAX)
-		available = ndctl_region_get_available_size(region);
+	if (ndctl_region_get_nstype(region) == ND_DEVICE_NAMESPACE_IO)
+		available = ndctl_region_get_size(region);
+	else {
+		available = ndctl_region_get_max_available_extent(region);
+		if (available == ULLONG_MAX)
+			available = ndctl_region_get_available_size(region);
+	}
 	if (!available || p.size > available) {
 		debug("%s: insufficient capacity size: %llx avail: %llx\n",
 			devname, p.size, available);

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
