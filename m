Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F93A7A94
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Sep 2019 07:08:42 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 90C2D21962301;
	Tue,  3 Sep 2019 22:09:49 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E8AAC2021B709
 for <linux-nvdimm@lists.01.org>; Tue,  3 Sep 2019 22:09:48 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8458I87070716; Wed, 4 Sep 2019 01:08:38 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ut0m60qhd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 01:08:35 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x845636H026561;
 Wed, 4 Sep 2019 05:08:28 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 2uqgh6q0yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Sep 2019 05:08:28 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8458RU037421472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Sep 2019 05:08:27 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AA01AE05F;
 Wed,  4 Sep 2019 05:08:27 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4835BAE05C;
 Wed,  4 Sep 2019 05:08:26 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.33.228])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  4 Sep 2019 05:08:26 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v7 0/7] Mark the namespace disabled on pfn superblock mismatch
Date: Wed,  4 Sep 2019 10:38:15 +0530
Message-Id: <20190904050822.23139-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-04_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040053
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

 arch/powerpc/include/asm/libnvdimm.h |  9 ++++
 arch/powerpc/mm/Makefile             |  1 +
 arch/powerpc/mm/nvdimm.c             | 34 +++++++++++++
 arch/x86/include/asm/libnvdimm.h     | 19 +++++++
 drivers/nvdimm/bus.c                 |  8 ++-
 drivers/nvdimm/label.c               |  5 --
 drivers/nvdimm/namespace_devs.c      | 40 +++++++++++----
 drivers/nvdimm/nd-core.h             |  3 +-
 drivers/nvdimm/nd.h                  | 10 ++--
 drivers/nvdimm/pfn.h                 |  5 +-
 drivers/nvdimm/pfn_devs.c            | 67 ++++++++++++++++++++++--
 drivers/nvdimm/pmem.c                | 29 +++++++++--
 drivers/nvdimm/region_devs.c         | 76 +++++-----------------------
 include/linux/huge_mm.h              |  7 ++-
 14 files changed, 215 insertions(+), 98 deletions(-)
 create mode 100644 arch/powerpc/include/asm/libnvdimm.h
 create mode 100644 arch/powerpc/mm/nvdimm.c
 create mode 100644 arch/x86/include/asm/libnvdimm.h

-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
