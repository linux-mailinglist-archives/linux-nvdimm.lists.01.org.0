Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1192013768A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 Jan 2020 20:05:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1ECA10097DDF;
	Fri, 10 Jan 2020 11:09:01 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2674C10097DDC
	for <linux-nvdimm@lists.01.org>; Fri, 10 Jan 2020 11:08:59 -0800 (PST)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ3C56131553;
	Fri, 10 Jan 2020 19:05:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=IAxWsXZJeFUgO3RbSR4igugMzki4kDIyDXTs6F36IxU=;
 b=Xar53uV/V6ArJjBjrO2U/jRSqy+lBdT0sIOibNZPQJ0sSIRTE8E/vkVf/k3ISNfMnM03
 nzzlelBFvEF6mqCIDAy4qHKZvpKvvpUirI6tepOp9Z5VnjB570p2hLfGK6f0TGncDgAE
 vVps6a1rWKDMOLKafYwhtbYk4LBk/keEpMxkrfmUdnHsk1dnONEY1Pc5ZXBs+P+xkhGB
 RAzOnve4U8GM3iIInJXABFDYiDTVJfTd0zqbk7QkW0C5hTOSqP3zcJghsbOD1r/kV9P9
 TXBV56IioMWKsWEgf0TQA7/gzYhXcSG2tLmJ6dGIx3RJfy5ENgg0Gn9R7dy9UDt+6Z+j 9Q==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2130.oracle.com with ESMTP id 2xaj4um8hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:05:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00AJ482S069233;
	Fri, 10 Jan 2020 19:05:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by aserp3020.oracle.com with ESMTP id 2xevfec03t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2020 19:05:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00AJ5JPx021552;
	Fri, 10 Jan 2020 19:05:19 GMT
Received: from paddy.uk.oracle.com (/10.175.192.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 10 Jan 2020 11:05:19 -0800
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH RFC 08/10] dax/pmem: Add device-dax support for PFN_MODE_NONE
Date: Fri, 10 Jan 2020 19:03:11 +0000
Message-Id: <20200110190313.17144-9-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200110190313.17144-1-joao.m.martins@oracle.com>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9496 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100154
Message-ID-Hash: VULES3VFBPX5PZHJRXW26PYB4ARTWIWJ
X-Message-ID-Hash: VULES3VFBPX5PZHJRXW26PYB4ARTWIWJ
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Liran Alon <liran.alon@oracle.com>, Nikita Leshenko <nikita.leshchenko@oracle.com>, Barret Rhoden <brho@google.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Matthew Wilcox <willy@infradead.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VULES3VFBPX5PZHJRXW26PYB4ARTWIWJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Allowing dax pmem driver to work without struct pages means
that user will request to not create any PFN metadata by writing
seed's device mode to PFN_MODE_NONE.

When the underlying nd_pfn->mode is PFN_MODE_NONE, most dax_pmem
initialization steps can be skipped because we won't have/need a
pfn superblock for the pagemap/struct-pages. We only allocate
an opaque zeroed object with the chosen align requested, and
finally add PFN_SPECIAL to the region pfn_flags.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/pmem/core.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/pmem/core.c b/drivers/dax/pmem/core.c
index 2bedf8414fff..67f5604a8291 100644
--- a/drivers/dax/pmem/core.c
+++ b/drivers/dax/pmem/core.c
@@ -17,15 +17,38 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 	struct nd_namespace_io *nsio;
 	struct dax_region *dax_region;
 	struct dev_pagemap pgmap = { };
+	struct dev_pagemap *devmap = NULL;
 	struct nd_namespace_common *ndns;
 	struct nd_dax *nd_dax = to_nd_dax(dev);
 	struct nd_pfn *nd_pfn = &nd_dax->nd_pfn;
 	struct nd_region *nd_region = to_nd_region(dev->parent);
+	unsigned long long pfn_flags = PFN_DEV;
 
 	ndns = nvdimm_namespace_common_probe(dev);
 	if (IS_ERR(ndns))
 		return ERR_CAST(ndns);
 
+	rc = sscanf(dev_name(&ndns->dev), "namespace%d.%d", &region_id, &id);
+	if (rc != 2)
+		return ERR_PTR(-EINVAL);
+
+	if (is_nd_dax(&nd_pfn->dev) && nd_pfn->mode == PFN_MODE_NONE) {
+		/* allocate a dummy super block */
+		pfn_sb = devm_kzalloc(&nd_pfn->dev, sizeof(*pfn_sb),
+				      GFP_KERNEL);
+		if (!pfn_sb)
+			return ERR_PTR(-ENOMEM);
+
+		memset(pfn_sb, 0, sizeof(*pfn_sb));
+		pfn_sb->align = nd_pfn->align;
+		nd_pfn->pfn_sb = pfn_sb;
+		pfn_flags |= PFN_SPECIAL;
+
+		nsio = to_nd_namespace_io(&ndns->dev);
+		memcpy(&res, &nsio->res, sizeof(res));
+		goto no_pfn_sb;
+	}
+
 	/* parse the 'pfn' info block via ->rw_bytes */
 	rc = devm_namespace_enable(dev, ndns, nd_info_block_reserve());
 	if (rc)
@@ -45,20 +68,21 @@ struct dev_dax *__dax_pmem_probe(struct device *dev, enum dev_dax_subsys subsys)
 		return ERR_PTR(-EBUSY);
 	}
 
-	rc = sscanf(dev_name(&ndns->dev), "namespace%d.%d", &region_id, &id);
-	if (rc != 2)
-		return ERR_PTR(-EINVAL);
-
 	/* adjust the dax_region resource to the start of data */
 	memcpy(&res, &pgmap.res, sizeof(res));
 	res.start += offset;
+	devmap = &pgmap;
+	pfn_flags |= PFN_MAP;
+
+no_pfn_sb:
 	dax_region = alloc_dax_region(dev, region_id, &res,
 			nd_region->target_node, le32_to_cpu(pfn_sb->align),
-			PFN_DEV|PFN_MAP);
+			pfn_flags);
 	if (!dax_region)
 		return ERR_PTR(-ENOMEM);
 
-	dev_dax = __devm_create_dev_dax(dax_region, id, &pgmap, subsys);
+
+	dev_dax = __devm_create_dev_dax(dax_region, id, devmap, subsys);
 
 	/* child dev_dax instances now own the lifetime of the dax_region */
 	dax_region_put(dax_region);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
