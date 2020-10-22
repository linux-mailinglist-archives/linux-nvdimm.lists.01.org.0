Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C565B29583C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Oct 2020 08:08:58 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 170B8160FE782;
	Wed, 21 Oct 2020 23:08:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5AE56160FE780
	for <linux-nvdimm@lists.01.org>; Wed, 21 Oct 2020 23:08:33 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09M62sNg163749;
	Thu, 22 Oct 2020 02:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=uc6fcGTCxAhtnCCPzFEsC7h0NNdr18Di/axa3y+n+1s=;
 b=grJIgnzciB5LZUdOC6IzL+71x7cjKSXTjewsbNOWQNKM8RlM+tpvYsZdGczOWWvzYH3U
 iWxhT2KC+B8ICLt/oeKsc+tcuwpa21H2vdLekA8SdqfXcKnXQUR3EQEeYyiUgsUrhwm+
 LRK4q+GTnF5B38Ss1hUlQCdEb8q64ANMsrVom7rvoPJ5QOqRni/uLT2nagF+qWWgem2j
 FUHDlPmshYnkkyRijJEZmjmBMeLu+rjHwBc4ChP/D+T5SWcF6xt9ACWAsDGQgKkaHoQO
 crt4IAPzTlZsrcGfYrV2FHx0yVZEIKgI7s0AmeyAaBpOE8uTQ0NqJjnhHsNtFAxUdP/R LQ==
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 34b4d1raja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2020 02:08:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09M689pA005088;
	Thu, 22 Oct 2020 06:08:23 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma03dal.us.ibm.com with ESMTP id 347r89q612-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2020 06:08:23 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09M68MS653871006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2020 06:08:22 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1B71112066;
	Thu, 22 Oct 2020 06:08:22 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1F2112062;
	Thu, 22 Oct 2020 06:08:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.198.168])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2020 06:08:12 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH] mm/mremap_pages: Fix static key devmap_managed_key updates
Date: Thu, 22 Oct 2020 11:37:53 +0530
Message-Id: <20201022060753.21173-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_02:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=3 spamscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220040
Message-ID-Hash: WQLW7OMXKPIS6WSTP7SBUXK33JJ4P3BN
X-Message-ID-Hash: WQLW7OMXKPIS6WSTP7SBUXK33JJ4P3BN
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: akpm@linux-foundation.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Christoph Hellwig <hch@infradead.org>, Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-nvdimm@lists.01.org, Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WQLW7OMXKPIS6WSTP7SBUXK33JJ4P3BN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

commit 6f42193fd86e ("memremap: don't use a separate devm action for
devmap_managed_enable_get") changed the static key updates such that we
now call devmap_managed_enable_put() without doing the equivalent
devmap_managed_enable_get().

devmap_managed_enable_get() is only called for MEMORY_DEVICE_PRIVATE and
MEMORY_DEVICE_FS_DAX, But memunmap_pages() get called for other pgmap
types too. This results in the below warning when switching between
system-ram and devdax mode for devdax namespace.

 jump label: negative count!
 WARNING: CPU: 52 PID: 1335 at kernel/jump_label.c:235 static_key_slow_try_dec+0x88/0xa0
 Modules linked in:
 ....

 NIP [c000000000433318] static_key_slow_try_dec+0x88/0xa0
 LR [c000000000433314] static_key_slow_try_dec+0x84/0xa0
 Call Trace:
 [c000000025c1f660] [c000000000433314] static_key_slow_try_dec+0x84/0xa0 (unreliable)
 [c000000025c1f6d0] [c000000000433664] __static_key_slow_dec_cpuslocked+0x34/0xd0
 [c000000025c1f700] [c0000000004337a4] static_key_slow_dec+0x54/0xf0
 [c000000025c1f770] [c00000000059c49c] memunmap_pages+0x36c/0x500
 [c000000025c1f820] [c000000000d91d10] devm_action_release+0x30/0x50
 [c000000025c1f840] [c000000000d92e34] release_nodes+0x2f4/0x3e0
 [c000000025c1f8f0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
 [c000000025c1f930] [c000000000d883a4] bus_remove_device+0x124/0x210
 [c000000025c1f9b0] [c000000000d80ef4] device_del+0x1d4/0x530
 [c000000025c1fa70] [c000000000e341e8] unregister_dev_dax+0x48/0xe0
 [c000000025c1fae0] [c000000000d91d10] devm_action_release+0x30/0x50
 [c000000025c1fb00] [c000000000d92e34] release_nodes+0x2f4/0x3e0
 [c000000025c1fbb0] [c000000000d8b15c] device_release_driver_internal+0x17c/0x280
 [c000000025c1fbf0] [c000000000d87000] unbind_store+0x130/0x170
 [c000000025c1fc30] [c000000000d862a0] drv_attr_store+0x40/0x60
 [c000000025c1fc50] [c0000000006d316c] sysfs_kf_write+0x6c/0xb0
 [c000000025c1fc90] [c0000000006d2328] kernfs_fop_write+0x118/0x280
 [c000000025c1fce0] [c0000000005a79f8] vfs_write+0xe8/0x2a0
 [c000000025c1fd30] [c0000000005a7d94] ksys_write+0x84/0x140
 [c000000025c1fd80] [c00000000003a430] system_call_exception+0x120/0x270
 [c000000025c1fe20] [c00000000000c540] system_call_common+0xf0/0x27c

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>
Cc: linux-nvdimm@lists.01.org
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memremap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 73a206d0f645..d4402ff3e467 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -158,6 +158,16 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 {
 	unsigned long pfn;
 	int i;
+	bool need_devmap_managed = false;
+
+	switch (pgmap->type) {
+	case MEMORY_DEVICE_PRIVATE:
+	case MEMORY_DEVICE_FS_DAX:
+		need_devmap_managed = true;
+		break;
+	default:
+		break;
+	}
 
 	dev_pagemap_kill(pgmap);
 	for (i = 0; i < pgmap->nr_range; i++)
@@ -169,7 +179,8 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 		pageunmap_range(pgmap, i);
 
 	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
-	devmap_managed_enable_put();
+	if (need_devmap_managed)
+		devmap_managed_enable_put();
 }
 EXPORT_SYMBOL_GPL(memunmap_pages);
 
@@ -307,7 +318,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 		.pgprot = PAGE_KERNEL,
 	};
 	const int nr_range = pgmap->nr_range;
-	bool need_devmap_managed = true;
+	bool need_devmap_managed = false;
 	int error, i;
 
 	if (WARN_ONCE(!nr_range, "nr_range must be specified\n"))
@@ -327,6 +338,7 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			WARN(1, "Missing owner\n");
 			return ERR_PTR(-EINVAL);
 		}
+		need_devmap_managed = true;
 		break;
 	case MEMORY_DEVICE_FS_DAX:
 		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
@@ -334,13 +346,12 @@ void *memremap_pages(struct dev_pagemap *pgmap, int nid)
 			WARN(1, "File system DAX not supported\n");
 			return ERR_PTR(-EINVAL);
 		}
+		need_devmap_managed = true;
 		break;
 	case MEMORY_DEVICE_GENERIC:
-		need_devmap_managed = false;
 		break;
 	case MEMORY_DEVICE_PCI_P2PDMA:
 		params.pgprot = pgprot_noncached(params.pgprot);
-		need_devmap_managed = false;
 		break;
 	default:
 		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
