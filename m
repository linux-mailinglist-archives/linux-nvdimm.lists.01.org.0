Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27711D0596
	for <lists+linux-nvdimm@lfdr.de>; Wed, 13 May 2020 05:48:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 47B0A11AC81FF;
	Tue, 12 May 2020 20:45:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D934511AC81FA
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 20:45:22 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D3VVRF001771;
	Tue, 12 May 2020 23:47:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxbe27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2020 23:47:52 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04D3WEFf003650;
	Tue, 12 May 2020 23:47:52 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 3101kxbe1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2020 23:47:52 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04D3j95M008692;
	Wed, 13 May 2020 03:47:51 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma03wdc.us.ibm.com with ESMTP id 3100ub3ecd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2020 03:47:51 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04D3lnqa31326566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2020 03:47:49 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CF96A04D;
	Wed, 13 May 2020 03:47:50 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA6986A047;
	Wed, 13 May 2020 03:47:47 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.102.3.92])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2020 03:47:47 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org
Subject: [PATCH v2 3/5] libnvdimm/nvdimm/flush: Allow architecture to override the flush barrier
Date: Wed, 13 May 2020 09:17:03 +0530
Message-Id: <20200513034705.172983-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
References: <20200513034705.172983-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_08:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 cotscore=-2147483648 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130026
Message-ID-Hash: AETSARS3MGDLIDQGPFHBPYL475DTCYFG
X-Message-ID-Hash: AETSARS3MGDLIDQGPFHBPYL475DTCYFG
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/AETSARS3MGDLIDQGPFHBPYL475DTCYFG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
 drivers/nvdimm/region_devs.c | 8 ++++----
 include/linux/libnvdimm.h    | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index ccbb5b43b8b2..88ea34a9c7fd 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1216,13 +1216,13 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
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
+	arch_pmem_flush_barrier();
 	for (i = 0; i < nd_region->ndr_mappings; i++)
 		if (ndrd_get_flush_wpq(ndrd, i, 0))
 			writeq(1, ndrd_get_flush_wpq(ndrd, i, idx));
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index 18da4059be09..66f6c65bd789 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -286,4 +286,8 @@ static inline void arch_invalidate_pmem(void *addr, size_t size)
 }
 #endif
 
+#ifndef arch_pmem_flush_barrier
+#define arch_pmem_flush_barrier() wmb()
+#endif
+
 #endif /* __LIBNVDIMM_H__ */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
