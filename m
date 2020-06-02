Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EC1EB6C3
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 09:49:47 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5FA7510106A0A;
	Tue,  2 Jun 2020 00:44:56 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BCEAD10106A09
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 00:44:54 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527aYnJ145862;
	Tue, 2 Jun 2020 03:49:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkjmnqf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:41 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0527jKuo181059;
	Tue, 2 Jun 2020 03:49:40 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bkjmnqem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:40 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0527ncoN016800;
	Tue, 2 Jun 2020 07:49:38 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
	by ppma01wdc.us.ibm.com with ESMTP id 31bf490y3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 07:49:38 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0527naFm3343010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2020 07:49:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB2B8C6055;
	Tue,  2 Jun 2020 07:49:37 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EE9CC6059;
	Tue,  2 Jun 2020 07:49:34 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.34.130])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2020 07:49:34 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [RFC PATCH v2 5/5] libnvdimm: Add prctl control for disabling synchronous fault support
Date: Tue,  2 Jun 2020 13:19:09 +0530
Message-Id: <20200602074909.36738-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602074909.36738-1-aneesh.kumar@linux.ibm.com>
References: <20200602074909.36738-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020047
Message-ID-Hash: ZVX53R5SOV2MYRASMXUG3PVQSIL5E2JW
X-Message-ID-Hash: ZVX53R5SOV2MYRASMXUG3PVQSIL5E2JW
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZVX53R5SOV2MYRASMXUG3PVQSIL5E2JW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With POWER10, architecture is adding new pmem flush and sync instructions.
The kernel should prevent the usage of MAP_SYNC if applications are not using
the new instructions on newer hardware.

This patch adds a prctl option MAP_SYNC_ENABLE that can be used to enable
the usage of MAP_SYNC. This is in addition to the namespace specific control
already added (/sys/bus/nd/devices/region0/pfn0.1/block/pmem0/dax/sync_fault)

With this patch, if the device supports synchronous fault, then an application
can enable the synchronous fault support using the prctl() interface even if
the platform disabled it for the namespace.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/dax.h            |  5 +++--
 include/linux/sched/coredump.h | 13 ++++++++++---
 include/uapi/linux/prctl.h     |  3 +++
 kernel/fork.c                  |  8 +++++++-
 kernel/sys.c                   | 18 ++++++++++++++++++
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index c4a3551557de..0733aae23828 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -80,9 +80,10 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	if (!IS_DAX(file_inode(vma->vm_file)))
 		return false;
 	/*
-	 * check MAP_SYNC is disabled by platform for this device.
+	 * MAP_SYNC is disabled by platform for this device.
+	 * check for prctl.
 	 */
-	if (!dax_synchronous_enabled(dax_dev))
+	if (!dax_synchronous_enabled(dax_dev) && !map_sync_enabled(vma->vm_mm))
 		return false;
 
 	return dax_synchronous(dax_dev);
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index ecdc6542070f..35698adc3d13 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -72,9 +72,16 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
 #define MMF_OOM_VICTIM		25	/* mm is the oom victim */
 #define MMF_OOM_REAP_QUEUED	26	/* mm was queued for oom_reaper */
-#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
+#define MMF_ENABLE_MAP_SYNC	27	/* disable THP for all VMAs */
+#define MMF_DISABLE_THP_MASK		(1 << MMF_DISABLE_THP)
+#define MMF_ENABLE_MAP_SYNC_MASK	(1 << MMF_ENABLE_MAP_SYNC)
 
-#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK | \
+			MMF_DISABLE_THP_MASK | MMF_ENABLE_MAP_SYNC_MASK)
+
+static inline bool map_sync_enabled(struct mm_struct *mm)
+{
+	return !!(mm->flags & MMF_ENABLE_MAP_SYNC_MASK);
+}
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f8131e36..ee4cde32d5cf 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -238,4 +238,7 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+#define PR_SET_MAP_SYNC_ENABLE		59
+#define PR_GET_MAP_SYNC_ENABLE		60
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c700f881d92..d50cac15ef41 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -963,6 +963,12 @@ __cacheline_aligned_in_smp DEFINE_SPINLOCK(mmlist_lock);
 
 static unsigned long default_dump_filter = MMF_DUMP_FILTER_DEFAULT;
 
+#ifndef CONFIG_ARCH_MAP_SYNC_DISABLE
+unsigned long default_map_sync_mask = MMF_ENABLE_MAP_SYNC_MASK;
+#else
+unsigned long default_map_sync_mask = 0;
+#endif
+
 static int __init coredump_filter_setup(char *s)
 {
 	default_dump_filter =
@@ -1039,7 +1045,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
-		mm->flags = default_dump_filter;
+		mm->flags = default_dump_filter | default_map_sync_mask;
 		mm->def_flags = 0;
 	}
 
diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..5011912831b0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2450,6 +2450,24 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
 		up_write(&me->mm->mmap_sem);
 		break;
+
+	case PR_GET_MAP_SYNC_ENABLE:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = !!test_bit(MMF_ENABLE_MAP_SYNC, &me->mm->flags);
+		break;
+	case PR_SET_MAP_SYNC_ENABLE:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (down_write_killable(&me->mm->mmap_sem))
+			return -EINTR;
+		if (arg2)
+			set_bit(MMF_ENABLE_MAP_SYNC, &me->mm->flags);
+		else
+			clear_bit(MMF_ENABLE_MAP_SYNC, &me->mm->flags);
+		up_write(&me->mm->mmap_sem);
+		break;
+
 	case PR_MPX_ENABLE_MANAGEMENT:
 	case PR_MPX_DISABLE_MANAGEMENT:
 		/* No longer implemented: */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
