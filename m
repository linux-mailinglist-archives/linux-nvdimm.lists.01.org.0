Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4902A82845
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 01:51:06 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CDA74213281F9;
	Mon,  5 Aug 2019 16:53:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 639E3213030A2
 for <linux-nvdimm@lists.01.org>; Mon,  5 Aug 2019 16:45:51 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 16:43:11 -0700
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; d="scan'208";a="202624676"
Received: from dwillia2-desk3.jf.intel.com (HELO
 dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Aug 2019 16:43:11 -0700
Subject: [ndctl PATCH v4 2/7] ndctl/dimm: Minimize data-transfer for
 init-labels
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Mon, 05 Aug 2019 16:28:53 -0700
Message-ID: <156504773351.847544.8335116234672284361.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156504772175.847544.11368833704527657055.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156504772175.847544.11368833704527657055.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Currently init-labels implementation reads the entire namespace-label
capacity, initializes just the namespace index, and then writes the
entire label capacity. It turns out that DIMM label-area access methods
can be exceedingly slow.

For example, the time to read the entire label area on a single dimm:
2s, but the time to just read the index block space: 45ms.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 ndctl/dimm.c           |    2 +-
 ndctl/lib/dimm.c       |   53 +++++++++++++++++++++++++++++++++++++++++++++---
 ndctl/lib/libndctl.sym |    1 +
 ndctl/libndctl.h       |    1 +
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/ndctl/dimm.c b/ndctl/dimm.c
index db91f42421e4..d78e0dbc3ec6 100644
--- a/ndctl/dimm.c
+++ b/ndctl/dimm.c
@@ -982,7 +982,7 @@ static int __action_init(struct ndctl_dimm *dimm,
 	struct ndctl_cmd *cmd_read;
 	int rc;
 
-	cmd_read = ndctl_dimm_read_labels(dimm);
+	cmd_read = ndctl_dimm_read_label_index(dimm);
 	if (!cmd_read)
 		return -ENXIO;
 
diff --git a/ndctl/lib/dimm.c b/ndctl/lib/dimm.c
index 22cf4e10b56c..2b5b964fe03d 100644
--- a/ndctl/lib/dimm.c
+++ b/ndctl/lib/dimm.c
@@ -370,14 +370,15 @@ static struct namespace_label *label_base(struct nvdimm_data *ndd)
 	return (struct namespace_label *) base;
 }
 
-static void init_ndd(struct nvdimm_data *ndd, struct ndctl_cmd *cmd_read)
+static void init_ndd(struct nvdimm_data *ndd, struct ndctl_cmd *cmd_read,
+		struct ndctl_cmd *cmd_size)
 {
 	ndctl_cmd_unref(ndd->cmd_read);
 	memset(ndd, 0, sizeof(*ndd));
 	ndd->cmd_read = cmd_read;
 	ndctl_cmd_ref(cmd_read);
 	ndd->data = cmd_read->iter.total_buf;
-	ndd->config_size = cmd_read->iter.total_xfer;
+	ndd->config_size = cmd_size->get_size->config_size;
 	ndd->ns_current = -1;
 	ndd->ns_next = -1;
 }
@@ -490,6 +491,52 @@ NDCTL_EXPORT int ndctl_dimm_validate_labels(struct ndctl_dimm *dimm)
 	return label_validate(&dimm->ndd);
 }
 
+NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_label_index(struct ndctl_dimm *dimm)
+{
+        struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
+        struct ndctl_cmd *cmd_size, *cmd_read;
+	struct nvdimm_data *ndd = &dimm->ndd;
+        int rc;
+
+        rc = ndctl_bus_wait_probe(bus);
+        if (rc < 0)
+                return NULL;
+
+        cmd_size = ndctl_dimm_cmd_new_cfg_size(dimm);
+        if (!cmd_size)
+                return NULL;
+        rc = ndctl_cmd_submit_xlat(cmd_size);
+        if (rc < 0)
+                goto out_size;
+
+        cmd_read = ndctl_dimm_cmd_new_cfg_read(cmd_size);
+        if (!cmd_read)
+                goto out_size;
+	/*
+	 * To calc the namespace index size use the minimum label
+	 * size which corresponds to the maximum namespace index size.
+	 */
+	init_ndd(ndd, cmd_read, cmd_size);
+	ndd->nslabel_size = 128;
+	rc = ndctl_cmd_cfg_read_set_extent(cmd_read,
+			sizeof_namespace_index(ndd) * 2, 0);
+	if (rc < 0)
+		goto out_read;
+
+        rc = ndctl_cmd_submit_xlat(cmd_read);
+        if (rc < 0)
+                goto out_read;
+	ndctl_cmd_unref(cmd_size);
+
+	return cmd_read;
+
+ out_read:
+        ndctl_cmd_unref(cmd_read);
+ out_size:
+        ndctl_cmd_unref(cmd_size);
+        return NULL;
+}
+
 NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
 {
         struct ndctl_bus *bus = ndctl_dimm_get_bus(dimm);
@@ -515,7 +562,7 @@ NDCTL_EXPORT struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm)
                 goto out_read;
 	ndctl_cmd_unref(cmd_size);
 
-	init_ndd(&dimm->ndd, cmd_read);
+	init_ndd(&dimm->ndd, cmd_read, cmd_size);
 
 	return cmd_read;
 
diff --git a/ndctl/lib/libndctl.sym b/ndctl/lib/libndctl.sym
index 84359b97b793..648f83bced1b 100644
--- a/ndctl/lib/libndctl.sym
+++ b/ndctl/lib/libndctl.sym
@@ -415,4 +415,5 @@ global:
 LIBNDCTL_21 {
 	ndctl_cmd_cfg_read_set_extent;
 	ndctl_cmd_cfg_write_set_extent;
+	ndctl_dimm_read_label_index;
 } LIBNDCTL_20;
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 310814fe924c..8aa4b8bbe6c2 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -308,6 +308,7 @@ struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_read(struct ndctl_cmd *cfg_size);
 struct ndctl_cmd *ndctl_dimm_cmd_new_cfg_write(struct ndctl_cmd *cfg_read);
 int ndctl_dimm_zero_labels(struct ndctl_dimm *dimm);
 struct ndctl_cmd *ndctl_dimm_read_labels(struct ndctl_dimm *dimm);
+struct ndctl_cmd *ndctl_dimm_read_label_index(struct ndctl_dimm *dimm);
 int ndctl_dimm_validate_labels(struct ndctl_dimm *dimm);
 enum ndctl_namespace_version {
 	NDCTL_NS_VERSION_1_1,

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
