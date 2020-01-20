Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD97E143209
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 20:19:06 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C256E10097DC9;
	Mon, 20 Jan 2020 11:22:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=134.134.136.31; helo=mga06.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E955810097DC9
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 11:22:21 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:03 -0800
X-IronPort-AV: E=Sophos;i="5.70,343,1574150400";
   d="scan'208";a="275110101"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 11:19:02 -0800
Subject: [PATCH v3 2/6] mm/numa: Skip NUMA_NO_NODE and online nodes in
 numa_map_to_online_node()
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Mon, 20 Jan 2020 11:02:59 -0800
Message-ID: <157954697957.2239526.17206272633668977957.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157954696789.2239526.17707265517154476652.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: PH337DLKLCQIAZ24IX6VEEHAKRLIUVSY
X-Message-ID-Hash: PH337DLKLCQIAZ24IX6VEEHAKRLIUVSY
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PH337DLKLCQIAZ24IX6VEEHAKRLIUVSY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Update numa_map_to_online_node() to stop falling back to numa node 0
when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
online. This makes the routine compatible with other arch node mapping
routines.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 mm/mempolicy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4cff069279f6..30d76db718bf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
 {
 	int min_node;
 
-	if (node == NUMA_NO_NODE)
-		node = 0;
+	if (node == NUMA_NO_NODE || node_online(node))
+		return node;
 
 	min_node = node;
 	if (!node_online(node)) {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
