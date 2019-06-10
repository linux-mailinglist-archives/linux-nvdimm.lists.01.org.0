Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EBF3BE04
	for <lists+linux-nvdimm@lfdr.de>; Mon, 10 Jun 2019 23:06:40 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8F54C21962301;
	Mon, 10 Jun 2019 14:06:37 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Permerror (SPF Permanent Error: Two or more type TXT spf records
 found.) identity=mailfrom; client-ip=192.185.144.91;
 helo=gateway31.websitewelcome.com; envelope-from=gustavo@embeddedor.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com
 [192.185.144.91])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 6F4582127420E
 for <linux-nvdimm@lists.01.org>; Mon, 10 Jun 2019 14:06:36 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway31.websitewelcome.com (Postfix) with ESMTP id 02F782176
 for <linux-nvdimm@lists.01.org>; Mon, 10 Jun 2019 16:06:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id aRUwhrwL7iQeraRUwhQA67; Mon, 10 Jun 2019 16:06:34 -0500
X-Authority-Reason: nr=8
Received: from [189.250.75.107] (port=48826 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.92)
 (envelope-from <gustavo@embeddedor.com>)
 id 1haRUd-003eSZ-CB; Mon, 10 Jun 2019 16:06:33 -0500
Date: Mon, 10 Jun 2019 16:06:13 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] libnvdimm, region: Use struct_size() in kzalloc()
Message-ID: <20190610210613.GA21989@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.75.107
X-Source-L: No
X-Exim-ID: 1haRUd-003eSZ-CB
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.75.107]:48826
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
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
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct nd_region {
	...
        struct nd_mapping mapping[0];
};

instance = kzalloc(sizeof(struct nd_region) + sizeof(struct nd_mapping) *
                          count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kzalloc(struct_size(instance, mapping, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvdimm/region_devs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index b4ef7d9ff22e..88becc87e234 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1027,10 +1027,9 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 		}
 		region_buf = ndbr;
 	} else {
-		nd_region = kzalloc(sizeof(struct nd_region)
-				+ sizeof(struct nd_mapping)
-				* ndr_desc->num_mappings,
-				GFP_KERNEL);
+		nd_region = kzalloc(struct_size(nd_region, mapping,
+						ndr_desc->num_mappings),
+				    GFP_KERNEL);
 		region_buf = nd_region;
 	}
 
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
