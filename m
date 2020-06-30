Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2D20F501
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jun 2020 14:48:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C571F1141F7A9;
	Tue, 30 Jun 2020 05:48:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42C3D114129E2
	for <linux-nvdimm@lists.01.org>; Tue, 30 Jun 2020 05:48:37 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UCXQcM132804;
	Tue, 30 Jun 2020 08:48:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32042ekgdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 08:48:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UCXp2e135823;
	Tue, 30 Jun 2020 08:48:33 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
	by mx0a-001b2d01.pphosted.com with ESMTP id 32042ekgdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 08:48:33 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
	by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UCe7pp011736;
	Tue, 30 Jun 2020 12:48:32 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
	by ppma04dal.us.ibm.com with ESMTP id 31wwr8wwb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2020 12:48:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UCmVKK25231770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2020 12:48:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E9B67805C;
	Tue, 30 Jun 2020 12:48:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72ADC7805F;
	Tue, 30 Jun 2020 12:48:27 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.45.4])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2020 12:48:26 +0000 (GMT)
X-Mailer: emacs 27.0.91 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH updated] libnvdimm/nvdimm/flush: Allow architecture to
 override the flush barrier
In-Reply-To: <03cf6d12-544f-154d-18da-a6cd204998ee@linux.ibm.com>
References: <20200629135722.73558-5-aneesh.kumar@linux.ibm.com>
 <20200629202901.83516-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hgjH4We9Th2oir3NxpJEhFuLnQeCrF8auwNfF+5av8jQ@mail.gmail.com>
 <87imf9gn9w.fsf@linux.ibm.com>
 <CAPcyv4hbECX+7cvX+eT97jvDFUTjQbUEqExZKpV_moDWMFzJ6A@mail.gmail.com>
 <03cf6d12-544f-154d-18da-a6cd204998ee@linux.ibm.com>
Date: Tue, 30 Jun 2020 18:18:24 +0530
Message-ID: <871rlwhg87.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 cotscore=-2147483648 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006300090
Message-ID-Hash: FRQEX2EGE37O5WIGRTLZKLRKZLSOUDSS
X-Message-ID-Hash: FRQEX2EGE37O5WIGRTLZKLRKZLSOUDSS
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FRQEX2EGE37O5WIGRTLZKLRKZLSOUDSS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


Update patch. 

From 1e6aa6c4182e14ec5d6bf878ae44c3f69ebff745 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Tue, 12 May 2020 20:58:33 +0530
Subject: [PATCH] libnvdimm/nvdimm/flush: Allow architecture to override the
 flush barrier

Architectures like ppc64 provide persistent memory specific barriers
that will ensure that all stores for which the modifications are
written to persistent storage by preceding dcbfps and dcbstps
instructions have updated persistent storage before any data
access or data transfer caused by subsequent instructions is initiated.
This is in addition to the ordering done by wmb()

Update nvdimm core such that architecture can use barriers other than
wmb to ensure all previous writes are architecturally visible for
the platform buffer flush.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 Documentation/memory-barriers.txt | 14 ++++++++++++++
 drivers/md/dm-writecache.c        |  2 +-
 drivers/nvdimm/region_devs.c      |  8 ++++----
 include/asm-generic/barrier.h     | 10 ++++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index eaabc3134294..340273a6b18e 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1935,6 +1935,20 @@ There are some more advanced barrier functions:
      relaxed I/O accessors and the Documentation/DMA-API.txt file for more
      information on consistent memory.
 
+ (*) pmem_wmb();
+
+     This is for use with persistent memory to ensure that stores for which
+     modifications are written to persistent storage have updated the persistent
+     storage.
+
+     For example, after a non-temporal write to pmem region, we use pmem_wmb()
+     to ensures that stores have updated the persistent storage. This ensures
+     that stores have updated persistent storage before any data access or
+     data transfer caused by subsequent instructions is initiated. This is
+     in addition to the ordering done by wmb().
+
+     For load from persistent memory, existing read memory barriers are sufficient
+     to ensure read ordering.
 
 ===============================
 IMPLICIT KERNEL MEMORY BARRIERS
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 74f3c506f084..00534fa4a384 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -536,7 +536,7 @@ static void ssd_commit_superblock(struct dm_writecache *wc)
 static void writecache_commit_flushed(struct dm_writecache *wc, bool wait_for_ios)
 {
 	if (WC_MODE_PMEM(wc))
-		wmb();
+		pmem_wmb();
 	else
 		ssd_commit_flushed(wc, wait_for_ios);
 }
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 4502f9c4708d..2333b290bdcf 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1206,13 +1206,13 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
 	idx = this_cpu_add_return(flush_idx, hash_32(current->pid + idx, 8));
 
 	/*
-	 * The first wmb() is needed to 'sfence' all previous writes
-	 * such that they are architecturally visible for the platform
-	 * buffer flush.  Note that we've already arranged for pmem
+	 * The first arch_pmem_flush_barrier() is needed to 'sfence' all
+	 * previous writes such that they are architecturally visible for
+	 * the platform buffer flush. Note that we've already arranged for pmem
 	 * writes to avoid the cache via memcpy_flushcache().  The final
 	 * wmb() ensures ordering for the NVDIMM flush write.
 	 */
-	wmb();
+	pmem_wmb();
 	for (i = 0; i < nd_region->ndr_mappings; i++)
 		if (ndrd_get_flush_wpq(ndrd, i, 0))
 			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 2eacaf7d62f6..879d68faec1d 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -257,5 +257,15 @@ do {									\
 })
 #endif
 
+/*
+ * pmem_barrier() ensures that all stores for which the modification
+ * are written to persistent storage by preceding instructions have
+ * updated persistent storage before any data  access or data transfer
+ * caused by subsequent instructions is initiated.
+ */
+#ifndef pmem_wmb
+#define pmem_wmb()	wmb()
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
