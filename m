Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7511F265B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  7 Nov 2019 05:12:07 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5A4B0100DC2B8;
	Wed,  6 Nov 2019 20:14:36 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 84874100DC2A7
	for <linux-nvdimm@lists.01.org>; Wed,  6 Nov 2019 20:14:34 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:04 -0800
X-IronPort-AV: E=Sophos;i="5.68,276,1569308400";
   d="scan'208";a="233120929"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 20:12:03 -0800
Subject: [PATCH 13/16] acpi/mm: Up-level "map to online node" functionality
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Date: Wed, 06 Nov 2019 19:57:47 -0800
Message-ID: <157309906694.1582359.4777838043061104635.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157309899529.1582359.15358067933360719580.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Message-ID-Hash: JEMEYJ4IGJHKEHR6WUFSGPFYEJGLFIBY
X-Message-ID-Hash: JEMEYJ4IGJHKEHR6WUFSGPFYEJGLFIBY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Michal Hocko <mhocko@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, peterz@infradead.org, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JEMEYJ4IGJHKEHR6WUFSGPFYEJGLFIBY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The acpi_map_pxm_to_online_node() helper is used to find the closest
online node to a given proximity domain. This is used to map devices in
a proximity domain with no online memory or cpus to the closest online
node and populate a device's 'numa_node' property. The numa_node
property allows applications to be migrated "close" to a resource.

In preparation for providing a generic facility to optionally map an
address range to its closest online node, or the node the range would
represent were it to be onlined (target_node), up-level the core of
acpi_map_pxm_to_online_node() to a generic mm/numa helper.

Cc: Michal Hocko <mhocko@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/numa.c  |   41 -----------------------------------------
 include/linux/acpi.h |   23 ++++++++++++++++++++++-
 include/linux/numa.h |    2 ++
 mm/mempolicy.c       |   30 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index eadbf90e65d1..47b4969d9b93 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -72,47 +72,6 @@ int acpi_map_pxm_to_node(int pxm)
 }
 EXPORT_SYMBOL(acpi_map_pxm_to_node);
 
-/**
- * acpi_map_pxm_to_online_node - Map proximity ID to online node
- * @pxm: ACPI proximity ID
- *
- * This is similar to acpi_map_pxm_to_node(), but always returns an online
- * node.  When the mapped node from a given proximity ID is offline, it
- * looks up the node distance table and returns the nearest online node.
- *
- * ACPI device drivers, which are called after the NUMA initialization has
- * completed in the kernel, can call this interface to obtain their device
- * NUMA topology from ACPI tables.  Such drivers do not have to deal with
- * offline nodes.  A node may be offline when a device proximity ID is
- * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
- * "numa=off" on x86.
- */
-int acpi_map_pxm_to_online_node(int pxm)
-{
-	int node, min_node;
-
-	node = acpi_map_pxm_to_node(pxm);
-
-	if (node == NUMA_NO_NODE)
-		node = 0;
-
-	min_node = node;
-	if (!node_online(node)) {
-		int min_dist = INT_MAX, dist, n;
-
-		for_each_online_node(n) {
-			dist = node_distance(node, n);
-			if (dist < min_dist) {
-				min_dist = dist;
-				min_node = n;
-			}
-		}
-	}
-
-	return min_node;
-}
-EXPORT_SYMBOL(acpi_map_pxm_to_online_node);
-
 static void __init
 acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8b4e516bac00..aeedd09f2f71 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -401,9 +401,30 @@ extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
 #ifdef CONFIG_ACPI_NUMA
-int acpi_map_pxm_to_online_node(int pxm);
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
+
+/**
+ * acpi_map_pxm_to_online_node - Map proximity ID to online node
+ * @pxm: ACPI proximity ID
+ *
+ * This is similar to acpi_map_pxm_to_node(), but always returns an online
+ * node.  When the mapped node from a given proximity ID is offline, it
+ * looks up the node distance table and returns the nearest online node.
+ *
+ * ACPI device drivers, which are called after the NUMA initialization has
+ * completed in the kernel, can call this interface to obtain their device
+ * NUMA topology from ACPI tables.  Such drivers do not have to deal with
+ * offline nodes.  A node may be offline when a device proximity ID is
+ * unique, SRAT memory entry does not exist, or NUMA is disabled, ex.
+ * "numa=off" on x86.
+ */
+static inline int acpi_map_pxm_to_online_node(int pxm)
+{
+	int node = acpi_map_pxm_to_node(pxm);
+
+	return numa_map_to_online_node(node);
+}
 #else
 static inline int acpi_map_pxm_to_online_node(int pxm)
 {
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 110b0e5d0fb0..4fd80f42be43 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -13,4 +13,6 @@
 
 #define	NUMA_NO_NODE	(-1)
 
+int numa_map_to_online_node(int node);
+
 #endif /* _LINUX_NUMA_H */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967bcf954..e2d8dd21ce9d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -127,6 +127,36 @@ static struct mempolicy default_policy = {
 
 static struct mempolicy preferred_node_policy[MAX_NUMNODES];
 
+/**
+ * numa_map_to_online_node - Find closest online node
+ * @nid: Node id to start the search
+ *
+ * Lookup the next closest node by distance if @nid is not online.
+ */
+int numa_map_to_online_node(int node)
+{
+	int min_node;
+
+	if (node == NUMA_NO_NODE)
+		node = 0;
+
+	min_node = node;
+	if (!node_online(node)) {
+		int min_dist = INT_MAX, dist, n;
+
+		for_each_online_node(n) {
+			dist = node_distance(node, n);
+			if (dist < min_dist) {
+				min_dist = dist;
+				min_node = n;
+			}
+		}
+	}
+
+	return min_node;
+}
+EXPORT_SYMBOL_GPL(numa_map_to_online_node);
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
 	struct mempolicy *pol = p->mempolicy;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
