Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C8637C81E
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 18:39:21 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 286FE100EB338;
	Wed, 12 May 2021 09:39:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D18BA100EBB6C
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 09:39:12 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CGXHAF092370;
	Wed, 12 May 2021 12:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cnigX0WjwP/vRXK6j5MH8oj6VVrQsQYVVKSBzSu3mdc=;
 b=sXmoLzkmdVm8Z2CbzyNDcavrTaRAAt43zsl074KHqpyAm7I8xUILBn/yxowANFCNiqXO
 uEA4eaNP0BV6wiwIdv4pgEnQBdci4XbV4ray6dcvsasDTK28KRFKLc3ECGH1lCxb9oox
 8RcfyWpLHtmK9xniz/UHEYzItHlUIYa1KvGmoJ4Psg4KQfO7xKvC3oDEgDMuXc7Fvsns
 BqAZF3O4OcF62+g8vTrZi4MzSDWdNmdAQu2uqCgBNQywXBFF5Dl5yoyNsPhLqaH+WPku
 7pFZ0bMK/LsK1iY6yfWNhGxvL4j5oKSdUQCJdA+1HDUTL+0X+ioJxaZli6UT6t27PLFt iA==
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38ghs4ht0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 May 2021 12:38:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CGb9TX031194;
	Wed, 12 May 2021 16:38:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma03fra.de.ibm.com with ESMTP id 38fxx008yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 May 2021 16:38:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CGclcC35848486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 May 2021 16:38:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A058FAE0EF;
	Wed, 12 May 2021 16:38:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58DBCAE0EC;
	Wed, 12 May 2021 16:38:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.40.5])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 12 May 2021 16:38:44 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/4] drivers/nvdimm: Add perf interface to expose nvdimm performance stats
Date: Wed, 12 May 2021 22:08:21 +0530
Message-Id: <20210512163824.255370-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210512163824.255370-1-kjain@linux.ibm.com>
References: <20210512163824.255370-1-kjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bNtazjKlFTDw20xtVMLs5Rm4-fCQGSBY
X-Proofpoint-GUID: bNtazjKlFTDw20xtVMLs5Rm4-fCQGSBY
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120105
Message-ID-Hash: FTWMHBFNZ5LD4LSK5SDCP2MGLOR7V5G6
X-Message-ID-Hash: FTWMHBFNZ5LD4LSK5SDCP2MGLOR7V5G6
X-MailFrom: kjain@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: maddy@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FTWMHBFNZ5LD4LSK5SDCP2MGLOR7V5G6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patch adds performance stats reporting support for nvdimm.
Added interface includes support for a pmu register function and
callbacks to be used by the arch/platform specific drivers.
User could use the standard perf tool to access perf events exposed
via pmu.

A structure is added called nvdimm_pmu which can be used to add
platform specific data like supported events and callbacks to pmu
functions like event_init/add/delete/read. It also adds
unregister_nvdimm_pmu function to handle unregistering of a pmu device.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 drivers/nvdimm/Makefile  |   1 +
 drivers/nvdimm/nd_perf.c | 111 +++++++++++++++++++++++++++++++++++++++
 include/linux/nd.h       |  31 +++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/nvdimm/nd_perf.c

diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index 29203f3d3069..25dba6095612 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -18,6 +18,7 @@ nd_e820-y := e820.o
 libnvdimm-y := core.o
 libnvdimm-y += bus.o
 libnvdimm-y += dimm_devs.o
+libnvdimm-y += nd_perf.o
 libnvdimm-y += dimm.o
 libnvdimm-y += region_devs.o
 libnvdimm-y += region.o
diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
new file mode 100644
index 000000000000..d28bec2b61a2
--- /dev/null
+++ b/drivers/nvdimm/nd_perf.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * nd_perf.c: NVDIMM Device Performance Monitoring Unit support
+ *
+ * Perf interface to expose nvdimm performance stats.
+ *
+ * Copyright (C) 2021 IBM Corporation
+ */
+
+#define pr_fmt(fmt) "nvdimm_pmu: " fmt
+
+#include <linux/nd.h>
+
+#define to_nvdimm_pmu(_pmu)	container_of(_pmu, struct nvdimm_pmu, pmu)
+
+static int nvdimm_pmu_event_init(struct perf_event *event)
+{
+	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
+
+	/* test the event attr type for PMU enumeration */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* it does not support event sampling mode */
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	/* no branch sampling */
+	if (has_branch_stack(event))
+		return -EOPNOTSUPP;
+
+	/* jump to arch/platform specific callbacks if any */
+	if (nd_pmu && nd_pmu->event_init)
+		return nd_pmu->event_init(event, nd_pmu->dev);
+
+	return 0;
+}
+
+static void nvdimm_pmu_read(struct perf_event *event)
+{
+	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
+
+	/* jump to arch/platform specific callbacks if any */
+	if (nd_pmu && nd_pmu->read)
+		nd_pmu->read(event, nd_pmu->dev);
+}
+
+static void nvdimm_pmu_del(struct perf_event *event, int flags)
+{
+	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
+
+	/* jump to arch/platform specific callbacks if any */
+	if (nd_pmu && nd_pmu->del)
+		nd_pmu->del(event, flags, nd_pmu->dev);
+}
+
+static int nvdimm_pmu_add(struct perf_event *event, int flags)
+{
+	struct nvdimm_pmu *nd_pmu = to_nvdimm_pmu(event->pmu);
+
+	if (flags & PERF_EF_START)
+		/* jump to arch/platform specific callbacks if any */
+		if (nd_pmu && nd_pmu->add)
+			return nd_pmu->add(event, flags, nd_pmu->dev);
+	return 0;
+}
+
+int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
+{
+	int rc;
+
+	if (!nd_pmu || !pdev)
+		return -EINVAL;
+
+	nd_pmu->pmu.task_ctx_nr = perf_invalid_context;
+	nd_pmu->pmu.event_init = nvdimm_pmu_event_init;
+	nd_pmu->pmu.add = nvdimm_pmu_add;
+	nd_pmu->pmu.del = nvdimm_pmu_del;
+	nd_pmu->pmu.read = nvdimm_pmu_read;
+	nd_pmu->pmu.name = nd_pmu->name;
+	nd_pmu->pmu.attr_groups = nd_pmu->attr_groups;
+	nd_pmu->pmu.capabilities = PERF_PMU_CAP_NO_INTERRUPT |
+				PERF_PMU_CAP_NO_EXCLUDE;
+
+	/*
+	 * Adding platform_device->dev pointer to nvdimm_pmu, so that we can
+	 * access that device data in PMU callbacks and also pass it to
+	 * arch/platform specific code.
+	 */
+	nd_pmu->dev = &pdev->dev;
+
+	rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->name, -1);
+	if (rc)
+		return rc;
+
+	pr_info("%s NVDIMM performance monitor support registered\n",
+		nd_pmu->name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_nvdimm_pmu);
+
+void unregister_nvdimm_pmu(struct pmu *nd_pmu)
+{
+	/*
+	 * nd_pmu will get free in arch/platform specific code once
+	 * corresponding pmu get unregistered.
+	 */
+	perf_pmu_unregister(nd_pmu);
+}
+EXPORT_SYMBOL_GPL(unregister_nvdimm_pmu);
diff --git a/include/linux/nd.h b/include/linux/nd.h
index ee9ad76afbba..fa6e60b2b368 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -8,6 +8,8 @@
 #include <linux/ndctl.h>
 #include <linux/device.h>
 #include <linux/badblocks.h>
+#include <linux/platform_device.h>
+#include <linux/perf_event.h>
 
 enum nvdimm_event {
 	NVDIMM_REVALIDATE_POISON,
@@ -23,6 +25,35 @@ enum nvdimm_claim_class {
 	NVDIMM_CCLASS_UNKNOWN,
 };
 
+/**
+ * struct nvdimm_pmu - data structure for nvdimm perf driver
+ *
+ * @name: name of the nvdimm pmu device.
+ * @pmu: pmu data structure for nvdimm performance stats.
+ * @cpu: designated cpu for counter access.
+ * @dev: nvdimm device pointer.
+ * @functions(event_init/add/del/read): platform specific callbacks.
+ * @attr_groups: data structure for events/formats/cpumask.
+ * @node: node for cpu hotplug notifier link.
+ * @cpuhp_state: state for cpu hotplug notification.
+ */
+struct nvdimm_pmu {
+	const char *name;
+	struct pmu pmu;
+	int cpu;
+	struct device *dev;
+	int (*event_init)(struct perf_event *event,  struct device *dev);
+	int  (*add)(struct perf_event *event, int flags, struct device *dev);
+	void (*del)(struct perf_event *event, int flags, struct device *dev);
+	void (*read)(struct perf_event *event,  struct device *dev);
+	const struct attribute_group **attr_groups;
+	struct hlist_node node;
+	enum cpuhp_state cpuhp_state;
+};
+
+int register_nvdimm_pmu(struct nvdimm_pmu *nvdimm, struct platform_device *pdev);
+void unregister_nvdimm_pmu(struct pmu *pmu);
+
 struct nd_device_driver {
 	struct device_driver drv;
 	unsigned long type;
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
