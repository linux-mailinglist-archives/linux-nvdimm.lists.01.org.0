Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7B144A4E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 22 Jan 2020 04:20:57 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9043B1007B8E6;
	Tue, 21 Jan 2020 19:24:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.55.52.115; helo=mga14.intel.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD4701007B8E7
	for <linux-nvdimm@lists.01.org>; Tue, 21 Jan 2020 19:24:12 -0800 (PST)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:20:53 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400";
   d="scan'208";a="227544259"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2020 19:20:53 -0800
Subject: [PATCH v4 3/6] powerpc/papr_scm: Switch to numa_map_to_online_node()
From: Dan Williams <dan.j.williams@intel.com>
To: tglx@linutronix.de, mingo@redhat.com
Date: Tue, 21 Jan 2020 19:04:50 -0800
Message-ID: <157966229059.2508551.6086588174339773492.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Message-ID-Hash: OSKHHVHKKMTIENI5474WCMILRTHPTEUI
X-Message-ID-Hash: OSKHHVHKKMTIENI5474WCMILRTHPTEUI
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, x86@kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OSKHHVHKKMTIENI5474WCMILRTHPTEUI/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Now that the core exports numa_map_to_online_node() switch to that
instead of the locally coded duplicate.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Link: https://lore.kernel.org/r/157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c |   21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index c2ef320ba1bf..057ed703e882 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -284,25 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 	return 0;
 }
 
-static inline int papr_scm_node(int node)
-{
-	int min_dist = INT_MAX, dist;
-	int nid, min_node;
-
-	if ((node == NUMA_NO_NODE) || node_online(node))
-		return node;
-
-	min_node = first_online_node;
-	for_each_online_node(nid) {
-		dist = node_distance(node, nid);
-		if (dist < min_dist) {
-			min_dist = dist;
-			min_node = nid;
-		}
-	}
-	return min_node;
-}
-
 static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 {
 	struct device *dev = &p->pdev->dev;
@@ -347,7 +328,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
 	target_nid = dev_to_node(&p->pdev->dev);
-	online_nid = papr_scm_node(target_nid);
+	online_nid = numa_map_to_online_node(target_nid);
 	ndr_desc.numa_node = online_nid;
 	ndr_desc.target_node = target_nid;
 	ndr_desc.res = &p->res;
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
