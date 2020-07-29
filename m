Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C2E231B86
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 10:45:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 427D11269A4EB;
	Wed, 29 Jul 2020 01:45:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=riteshh@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1945A125B96B3
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 01:45:30 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T8WR1Q053522;
	Wed, 29 Jul 2020 04:45:30 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32jpw40reg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 04:45:29 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06T8TnkI026980;
	Wed, 29 Jul 2020 08:45:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma03ams.nl.ibm.com with ESMTP id 32gcpx4u4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2020 08:45:27 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06T8i0xC55640444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2020 08:44:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A6A11C05C;
	Wed, 29 Jul 2020 08:45:25 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E610911C050;
	Wed, 29 Jul 2020 08:45:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.112])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2020 08:45:23 +0000 (GMT)
From: Ritesh Harjani <riteshh@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [RFC 1/1] pmem: Add cond_resched() in bio_for_each_segment loop in pmem_make_request
Date: Wed, 29 Jul 2020 14:15:18 +0530
Message-Id: <0d96e2481f292de2cda8828b03d5121004308759.1596011292.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_03:2020-07-28,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=842
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=1 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290055
Message-ID-Hash: ZSOP7XAKCO2QK2DGQMOD4YEQXUJJIRH5
X-Message-ID-Hash: ZSOP7XAKCO2QK2DGQMOD4YEQXUJJIRH5
X-MailFrom: riteshh@linux.ibm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZSOP7XAKCO2QK2DGQMOD4YEQXUJJIRH5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

For systems which do not have CONFIG_PREEMPT set and
if there is a heavy multi-threaded load/store operation happening
on pmem + sometimes along with device latencies, softlockup warnings like
this could trigger. This was seen on Power where pagesize is 64K.

To avoid softlockup, this patch adds a cond_resched() in this path.

<...>
watchdog: BUG: soft lockup - CPU#31 stuck for 22s!
<...>
CPU: 31 PID: 15627 <..> 5.3.18-20
<...>
NIP memcpy_power7+0x43c/0x7e0
LR memcpy_flushcache+0x28/0xa0

Call Trace:
memcpy_power7+0x274/0x7e0 (unreliable)
memcpy_flushcache+0x28/0xa0
write_pmem+0xa0/0x100 [nd_pmem]
pmem_do_bvec+0x1f0/0x420 [nd_pmem]
pmem_make_request+0x14c/0x370 [nd_pmem]
generic_make_request+0x164/0x400
submit_bio+0x134/0x2e0
submit_bio_wait+0x70/0xc0
blkdev_issue_zeroout+0xf4/0x2a0
xfs_zero_extent+0x90/0xc0 [xfs]
xfs_bmapi_convert_unwritten+0x198/0x230 [xfs]
xfs_bmapi_write+0x284/0x630 [xfs]
xfs_iomap_write_direct+0x1f0/0x3e0 [xfs]
xfs_file_iomap_begin+0x344/0x690 [xfs]
dax_iomap_pmd_fault+0x488/0xc10
__xfs_filemap_fault+0x26c/0x2b0 [xfs]
__handle_mm_fault+0x794/0x1af0
handle_mm_fault+0x12c/0x220
__do_page_fault+0x290/0xe40
do_page_fault+0x38/0xc0
handle_page_fault+0x10/0x30

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 drivers/nvdimm/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 2df6994acf83..fcf7af13897e 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -214,6 +214,7 @@ static blk_qc_t pmem_make_request(struct request_queue *q, struct bio *bio)
 			bio->bi_status = rc;
 			break;
 		}
+		cond_resched();
 	}
 	if (do_acct)
 		nd_iostat_end(bio, start);
-- 
2.25.4
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
