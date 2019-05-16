Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8751FF42
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 07:55:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E3E22212657BD;
	Wed, 15 May 2019 22:55:27 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=vaibhav@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B2183212377E4
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 22:55:25 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4G5koNs091262
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 01:55:24 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sh0db3k94-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 01:55:23 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
 Thu, 16 May 2019 06:55:21 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 16 May 2019 06:55:17 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4G5tGqu32374960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2019 05:55:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2587A405F;
 Thu, 16 May 2019 05:55:15 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 631F3A4054;
 Thu, 16 May 2019 05:55:12 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.102.1.9])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2019 05:55:12 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: akpm@linux-foundation.org
Subject: [PATCH] dax: Fix last_page check in  __bdev_dax_supported()
Date: Thu, 16 May 2019 11:24:22 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19051605-0020-0000-0000-0000033D33D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051605-0021-0000-0000-0000218FF97F
Message-Id: <20190516055422.16939-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-16_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160041
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
Cc: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, Chandan Rajendra <chandan@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Presently __bdev_dax_supported() checks if first sector of last
page ( last_page ) on the block device is aligned to page
boundary. However the code to compute 'last_page' assumes that there
are 8 sectors/page assuming a 4K page-size.

This assumption breaks on architectures which use a different page
size specifically PPC64 where page-size == 64K. Hence a warning is
seen while trying to mount a xfs/ext4 file-system with dax enabled:

$ sudo mount -o dax /dev/pmem0 /mnt/pmem
XFS (pmem0): DAX enabled. Warning: EXPERIMENTAL, use at your own risk
XFS (pmem0): DAX unsupported by block device. Turning off DAX.

The patch fixes this issue by updating calculation of 'last_var' to
take into account number-of-sectors/page instead of assuming it to be
'8'.

Fixes: ad428cdb525a ("dax: Check the end of the block-device capacity with dax_direct_access()")
Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 drivers/dax/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index bbd57ca0634a..6b50ed3673d3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -116,7 +116,9 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 		return false;
 	}
 
-	last_page = PFN_DOWN(i_size_read(bdev->bd_inode) - 1) * 8;
+	/* Calculate the first sector of last page on the block device */
+	last_page = PFN_DOWN(i_size_read(bdev->bd_inode) - 1) *
+		(PAGE_SIZE >> SECTOR_SHIFT);
 	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
 	if (err) {
 		pr_debug("%s: error: unaligned partition for dax\n",
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
