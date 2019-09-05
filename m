Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0730CAA79B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  5 Sep 2019 17:46:24 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27FF821962301;
	Thu,  5 Sep 2019 08:47:19 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 68E0720260CF7
 for <linux-nvdimm@lists.01.org>; Thu,  5 Sep 2019 08:47:17 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x85FbZZv084881; Thu, 5 Sep 2019 11:46:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uu3uwmb1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 11:46:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x85FjiUB003408;
 Thu, 5 Sep 2019 15:46:17 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma04dal.us.ibm.com with ESMTP id 2uqgh7axnw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Sep 2019 15:46:17 +0000
Received: from b03ledav002.gho.boulder.ibm.com
 (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x85FkFXk40829306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Sep 2019 15:46:15 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FA31136051;
 Thu,  5 Sep 2019 15:46:15 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D07913604F;
 Thu,  5 Sep 2019 15:46:14 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.35.243])
 by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  5 Sep 2019 15:46:13 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v9 0/7] Mark the namespace disabled on pfn superblock mismatch
Date: Thu,  5 Sep 2019 21:15:56 +0530
Message-Id: <20190905154603.10349-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-05_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050147
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

We add new members to pfn superblock (PAGE_SIZE and struct page size) in this series.
This is now checked while initializing the namespace. If we find a mismatch we mark
the namespace disabled.

This series also handle configs where hugepage support is not enabled by default.
This can result in different align restrictions for dax namespace. We mark the
dax namespace disabled if we find the alignment not supported.

Changes from v8:
* updated patch 7 for addressing review feedback

Changes from v6:
* Formatting changes

Changes from v5:
* Split patch 3
* Update commit message
* Add MAX_STRUCT_PAGE_SIZE with value 64 and use that when allocating reserve block
* Add BUILD_BUG_ON if we find sizeof(struct page) > 64



Aneesh Kumar K.V (6):
  libnvdimm/pmem: Advance namespace seed for specific probe errors
  libnvdimm/pfn_dev: Add a build check to make sure we notice when
    struct page size change
  libnvdimm/pfn_dev: Add page size and struct page size to pfn
    superblock
  libnvdimm/label: Remove the dpa align check
  libnvdimm: Use PAGE_SIZE instead of SZ_4K for align check
  libnvdimm/dax: Pick the right alignment default when creating dax
    devices

Dan Williams (1):
  libnvdimm/region: Rewrite _probe_success() to _advance_seeds()

 drivers/nvdimm/bus.c            |   8 +--
 drivers/nvdimm/label.c          |   5 --
 drivers/nvdimm/namespace_devs.c |  40 +++++++++---
 drivers/nvdimm/nd-core.h        |   3 +-
 drivers/nvdimm/nd.h             |  10 +--
 drivers/nvdimm/pfn.h            |   5 +-
 drivers/nvdimm/pfn_devs.c       | 110 +++++++++++++++++++++++++-------
 drivers/nvdimm/pmem.c           |  29 +++++++--
 drivers/nvdimm/region_devs.c    |  76 ++++------------------
 include/linux/huge_mm.h         |   7 +-
 10 files changed, 176 insertions(+), 117 deletions(-)

-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
