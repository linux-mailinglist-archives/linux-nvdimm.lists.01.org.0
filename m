Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1941EB6C0
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Jun 2020 09:49:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1ABD7100DBB71;
	Tue,  2 Jun 2020 00:44:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 585E4100DBB70
	for <linux-nvdimm@lists.01.org>; Tue,  2 Jun 2020 00:44:35 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0527WpB4122579;
	Tue, 2 Jun 2020 03:49:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bm16cvgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:19 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0527X8aX124128;
	Tue, 2 Jun 2020 03:49:18 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31bm16cvg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 03:49:18 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
	by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0527j3XV009833;
	Tue, 2 Jun 2020 07:49:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
	by ppma04wdc.us.ibm.com with ESMTP id 31bf48rvvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2020 07:49:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
	by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0527nFjT17301764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2020 07:49:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B5E9C605B;
	Tue,  2 Jun 2020 07:49:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CB78C6057;
	Tue,  2 Jun 2020 07:49:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.34.130])
	by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2020 07:49:12 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [RFC PATCH v2 1/5] libnvdimm/dax: Add a dax flag to control synchronous fault support
Date: Tue,  2 Jun 2020 13:19:05 +0530
Message-Id: <20200602074909.36738-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_08:2020-06-01,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 cotscore=-2147483648 mlxlogscore=900 phishscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006020043
Message-ID-Hash: KSY3FJXDOJT6WXCC2KM3WYEADOTBZ3M7
X-Message-ID-Hash: KSY3FJXDOJT6WXCC2KM3WYEADOTBZ3M7
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KSY3FJXDOJT6WXCC2KM3WYEADOTBZ3M7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

With POWER10, architecture is adding new pmem flush and sync instructions.
The kernel should prevent the usage of MAP_SYNC if applications are not using
the new instructions on newer hardware

This patch adds a dax attribute (/sys/bus/nd/devices/region0/pfn0.1/block/pmem0/dax/sync_fault)
which can be used to control this flag. If the device supports synchronous flush
then userspace can update this attribute to enable/disable the synchronous
fault. The attribute is only visible if there is write cache enabled on the device.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/super.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/Kconfig          |  3 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..980f7be7e56d 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -198,6 +198,12 @@ enum dax_device_flags {
 	DAXDEV_WRITE_CACHE,
 	/* flag to check if device supports synchronous flush */
 	DAXDEV_SYNC,
+	/*
+	 * flag to indicate whether synchronous flush is enabled.
+	 * Some platform may want to disable synchronous flush support
+	 * even though device supports the same.
+	 */
+	DAXDEV_SYNC_ENABLED,
 };
 
 /**
@@ -254,6 +260,60 @@ static ssize_t write_cache_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(write_cache);
 
+static bool dax_synchronous_enabled(struct dax_device *dax_dev)
+{
+	return test_bit(DAXDEV_SYNC_ENABLED, &dax_dev->flags);
+}
+
+static void set_dax_synchronous_enable(struct dax_device *dax_dev, bool enable)
+{
+	if (!test_bit(DAXDEV_SYNC, &dax_dev->flags))
+		return;
+
+	if (enable)
+		set_bit(DAXDEV_SYNC_ENABLED, &dax_dev->flags);
+	else
+		clear_bit(DAXDEV_SYNC_ENABLED, &dax_dev->flags);
+}
+
+
+static ssize_t sync_fault_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct dax_device *dax_dev = dax_get_by_host(dev_name(dev));
+	ssize_t rc;
+
+	WARN_ON_ONCE(!dax_dev);
+	if (!dax_dev)
+		return -ENXIO;
+
+	rc = sprintf(buf, "%d\n", !!__dax_synchronous(dax_dev));
+	put_dax(dax_dev);
+	return rc;
+}
+
+static ssize_t sync_fault_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	bool enable_sync;
+	int rc = strtobool(buf, &enable_sync);
+	struct dax_device *dax_dev = dax_get_by_host(dev_name(dev));
+
+	WARN_ON_ONCE(!dax_dev);
+	if (!dax_dev)
+		return -ENXIO;
+
+	if (rc)
+		len = rc;
+	else
+		set_dax_synchronous_enable(dax_dev, enable_sync);
+
+	put_dax(dax_dev);
+	return len;
+}
+
+static DEVICE_ATTR_RW(sync_fault);
+
 static umode_t dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, typeof(*dev), kobj);
@@ -267,11 +327,18 @@ static umode_t dax_visible(struct kobject *kobj, struct attribute *a, int n)
 	if (a == &dev_attr_write_cache.attr)
 		return 0;
 #endif
+	if (a == &dev_attr_sync_fault.attr) {
+		if (dax_write_cache_enabled(dax_dev))
+			return a->mode;
+		return 0;
+	}
+
 	return a->mode;
 }
 
 static struct attribute *dax_attributes[] = {
 	&dev_attr_write_cache.attr,
+	&dev_attr_sync_fault.attr,
 	NULL,
 };
 
@@ -394,13 +461,17 @@ EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
 
 bool __dax_synchronous(struct dax_device *dax_dev)
 {
-	return test_bit(DAXDEV_SYNC, &dax_dev->flags);
+	return test_bit(DAXDEV_SYNC, &dax_dev->flags) &&
+		test_bit(DAXDEV_SYNC_ENABLED, &dax_dev->flags);
 }
 EXPORT_SYMBOL_GPL(__dax_synchronous);
 
 void __set_dax_synchronous(struct dax_device *dax_dev)
 {
 	set_bit(DAXDEV_SYNC, &dax_dev->flags);
+#ifndef CONFIG_ARCH_MAP_SYNC_DISABLE
+	set_bit(DAXDEV_SYNC_ENABLED, &dax_dev->flags);
+#endif
 }
 EXPORT_SYMBOL_GPL(__set_dax_synchronous);
 
diff --git a/mm/Kconfig b/mm/Kconfig
index c1acc34c1c35..38fd7cfbfca8 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -867,4 +867,7 @@ config ARCH_HAS_HUGEPD
 config MAPPING_DIRTY_HELPERS
         bool
 
+config ARCH_MAP_SYNC_DISABLE
+	bool
+
 endmenu
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
