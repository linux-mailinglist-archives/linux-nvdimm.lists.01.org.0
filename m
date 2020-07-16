Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FB12229E8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 19:29:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 561F611C6719B;
	Thu, 16 Jul 2020 10:29:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C0FF111C67198
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 10:29:48 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHMrg7108489;
	Thu, 16 Jul 2020 17:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=/DojH78Za5gXTe4CFdrD9/E9liFW6vuu4N1QfjS7cME=;
 b=IsO4I4K/0EC29A+KQC6ljCJGfAbFH0C2iLEN0W2370NcHp8FAKnH5iQeskKw0BPWpiep
 xDnRuGbD5Sf2f3MK3wpNjFtWfTB1n12AGnmulgiowFQr2oI99mlFnw3CdkPYjhNtgKmR
 x7TPatP8tnaHtsru5/wueuOp+a9P1eOt/Pu8fTESQ5YyhqRWXA0e3xwn12ACVq7bxBQy
 9i7wkWVGrNtasJlD9jdDBttMZ9C3piHIHxKSlKzzNp1mOzVf0k8nqNKjuE8IqVA1uWwF
 sRFboFAcnpAD9A1E5E6YwQd9hV/wzN1rK3spWX+GpY2vPgfM4cmegoEjGQ96pGGIqudT rg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2130.oracle.com with ESMTP id 3274urjv6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 17:29:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHIk0l086528;
	Thu, 16 Jul 2020 17:29:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userp3030.oracle.com with ESMTP id 327qc3tuw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 17:29:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GHTh5Z016792;
	Thu, 16 Jul 2020 17:29:43 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 10:29:43 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1 4/4] device-dax: Add a range mapping allocation attribute
Date: Thu, 16 Jul 2020 18:29:13 +0100
Message-Id: <20200716172913.19658-5-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716172913.19658-1-joao.m.martins@oracle.com>
References: <20200716172913.19658-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
Message-ID-Hash: RMQJS7QNW6Y5RTR2CFKXROGYQBF527T3
X-Message-ID-Hash: RMQJS7QNW6Y5RTR2CFKXROGYQBF527T3
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Jason Zeng <jason.zeng@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RMQJS7QNW6Y5RTR2CFKXROGYQBF527T3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add a sysfs attribute which denotes a range from the dax region
to be allocated. It's an write only @mapping sysfs attribute in
the format of '<start>-<end>' to allocate a range. @start and
@end use hexadecimal values and the @pgoff is implicitly ordered
wrt to previous writes to @mapping sysfs e.g. a write of a range
of length 1G the pgoff is 0..1G(-4K), a second write will use
@pgoff for 1G+4K..<size>.

This range mapping interface is useful for:

 1) Application which want to implement its own allocation logic,
 and thus pick the desired ranges from dax_region.

 2) For use cases like VMM fast restart[0] where after kexec we
 want to the same gpa<->phys mappings (as originally created
 before kexec).

[0] https://static.sched.com/hosted_files/kvmforum2019/66/VMM-fast-restart_kvmforum2019.pdf

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/dax/bus.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index eb384dd6a376..83cc55d7517d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1041,6 +1041,67 @@ static ssize_t size_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+static ssize_t range_parse(const char *opt, size_t len, struct range *range)
+{
+	unsigned long long addr = 0;
+	char *start, *end, *str;
+	ssize_t rc = EINVAL;
+
+	str = kstrdup(opt, GFP_KERNEL);
+	if (!str)
+		return rc;
+
+	end = str;
+	start = strsep(&end, "-");
+	if (!start || !end)
+		goto err;
+
+	rc = kstrtoull(start, 16, &addr);
+	if (rc)
+		goto err;
+	range->start = addr;
+
+	rc = kstrtoull(end, 16, &addr);
+	if (rc)
+		goto err;
+	range->end = addr;
+
+err:
+	kfree(str);
+	return rc;
+}
+
+static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	size_t to_alloc;
+	struct range r;
+	ssize_t rc;
+
+	rc = range_parse(buf, len, &r);
+	if (rc)
+		return rc;
+
+	rc = -ENXIO;
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return rc;
+	}
+	device_lock(dev);
+
+	to_alloc = range_len(&r);
+	if (alloc_is_aligned(to_alloc, dev_dax->align))
+		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+	device_unlock(dev);
+	device_unlock(dax_region->dev);
+
+	return rc == 0 ? len : rc;
+}
+static DEVICE_ATTR_WO(mapping);
+
 static ssize_t align_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1182,6 +1243,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 		return 0;
 	if (a == &dev_attr_numa_node.attr && !IS_ENABLED(CONFIG_NUMA))
 		return 0;
+	if (a == &dev_attr_mapping.attr && is_static(dax_region))
+		return 0;
 	if ((a == &dev_attr_align.attr ||
 	     a == &dev_attr_size.attr) && is_static(dax_region))
 		return 0444;
@@ -1191,6 +1254,7 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_size.attr,
+	&dev_attr_mapping.attr,
 	&dev_attr_target_node.attr,
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
