Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9F1376491
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 13:40:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AF4D2100EBB78;
	Fri,  7 May 2021 04:40:08 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 76FEC100EBB6C
	for <linux-nvdimm@lists.01.org>; Fri,  7 May 2021 04:40:06 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 147BWjV7127717;
	Fri, 7 May 2021 07:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CsLPBrkvnepPxpoLL2iPU4V3RctbqgEBQqgiT5igYD4=;
 b=Bla6+hmN+U11OB11BCGgyIUp3xzyv9hgzodqgIa5beiDWDFTVimKnKeSR5PtpU8jZinZ
 bchMUetxaV8kwejJYcQWTOV4bgksjq8dtqqhFWLX94jX2akNXtB6yz4IF+A1LXxPE7Hi
 JPts760S6zIEsJIVgWo16FyRgPctrcIGM2mPAfErcHkDUJ9H3g+Caef7oxlEQx5cqZKK
 IHQsuPQAW7M5uNf4Cn+8PRPloTxGUw5p4wTfOIxW//b9HlEDhrmCLJrGQcYzKhWmAG7x
 8QutN9vczx4DOoEp1DsrXJA7/1Wv+k2auhghGwxXebrccWRtjRZyTyvt6lcWheARfWGd QA==
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 38d4ka8du3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 07:39:59 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 147BXCDN009890;
	Fri, 7 May 2021 11:39:57 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma04ams.nl.ibm.com with ESMTP id 38csq108sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 May 2021 11:39:57 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 147BdsEU34013664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 May 2021 11:39:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25BB352050;
	Fri,  7 May 2021 11:39:54 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.69.191])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id DA33B5204F;
	Fri,  7 May 2021 11:39:50 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Fri, 07 May 2021 17:09:49 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2] powerpc/papr_scm: Make 'perf_stats' invisible if perf-stats unavailable
Date: Fri,  7 May 2021 17:09:48 +0530
Message-Id: <20210507113948.38950-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PDEonpK8umvdTD7Pk2rtab5WtRhYtogl
X-Proofpoint-GUID: PDEonpK8umvdTD7Pk2rtab5WtRhYtogl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-07_04:2021-05-06,2021-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=34 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2105070079
Message-ID-Hash: A632WT5OLMQ5IPPP2DBQWZXR4QJUKGY2
X-Message-ID-Hash: A632WT5OLMQ5IPPP2DBQWZXR4QJUKGY2
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A632WT5OLMQ5IPPP2DBQWZXR4QJUKGY2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In case performance stats for an nvdimm are not available, reading the
'perf_stats' sysfs file returns an -ENOENT error. A better approach is
to make the 'perf_stats' file entirely invisible to indicate that
performance stats for an nvdimm are unavailable.

So this patch updates 'papr_nd_attribute_group' to add a 'is_visible'
callback implemented as newly introduced 'papr_nd_attribute_visible()'
that returns an appropriate mode in case performance stats aren't
supported in a given nvdimm.

Also the initialization of 'papr_scm_priv.stat_buffer_len' is moved
from papr_scm_nvdimm_init() to papr_scm_probe() so that it value is
available when 'papr_nd_attribute_visible()' is called during nvdimm
initialization.

Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v2:
* Removed a redundant dev_info() from pap_scm_nvdimm_init() [ Aneesh ]
* Marked papr_nd_attribute_visible() as static which also fixed the
  build warning reported by kernel build robot
---
 arch/powerpc/platforms/pseries/papr_scm.c | 35 ++++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index e2b69cc3beaf..11e7b90a3360 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -907,6 +907,20 @@ static ssize_t flags_show(struct device *dev,
 }
 DEVICE_ATTR_RO(flags);
 
+static umode_t papr_nd_attribute_visible(struct kobject *kobj,
+					 struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+	struct papr_scm_priv *p = nvdimm_provider_data(nvdimm);
+
+	/* For if perf-stats not available remove perf_stats sysfs */
+	if (attr == &dev_attr_perf_stats.attr && p->stat_buffer_len == 0)
+		return 0;
+
+	return attr->mode;
+}
+
 /* papr_scm specific dimm attributes */
 static struct attribute *papr_nd_attributes[] = {
 	&dev_attr_flags.attr,
@@ -916,6 +930,7 @@ static struct attribute *papr_nd_attributes[] = {
 
 static struct attribute_group papr_nd_attribute_group = {
 	.name = "papr",
+	.is_visible = papr_nd_attribute_visible,
 	.attrs = papr_nd_attributes,
 };
 
@@ -931,7 +946,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	struct nd_region_desc ndr_desc;
 	unsigned long dimm_flags;
 	int target_nid, online_nid;
-	ssize_t stat_size;
 
 	p->bus_desc.ndctl = papr_scm_ndctl;
 	p->bus_desc.module = THIS_MODULE;
@@ -1016,16 +1030,6 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	list_add_tail(&p->region_list, &papr_nd_regions);
 	mutex_unlock(&papr_ndr_lock);
 
-	/* Try retriving the stat buffer and see if its supported */
-	stat_size = drc_pmem_query_stats(p, NULL, 0);
-	if (stat_size > 0) {
-		p->stat_buffer_len = stat_size;
-		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
-			p->stat_buffer_len);
-	} else {
-		dev_info(&p->pdev->dev, "Dimm performance stats unavailable\n");
-	}
-
 	return 0;
 
 err:	nvdimm_bus_unregister(p->bus);
@@ -1102,6 +1106,7 @@ static int papr_scm_probe(struct platform_device *pdev)
 	u64 blocks, block_size;
 	struct papr_scm_priv *p;
 	const char *uuid_str;
+	ssize_t stat_size;
 	u64 uuid[2];
 	int rc;
 
@@ -1179,6 +1184,14 @@ static int papr_scm_probe(struct platform_device *pdev)
 	p->res.name  = pdev->name;
 	p->res.flags = IORESOURCE_MEM;
 
+	/* Try retriving the stat buffer and see if its supported */
+	stat_size = drc_pmem_query_stats(p, NULL, 0);
+	if (stat_size > 0) {
+		p->stat_buffer_len = stat_size;
+		dev_dbg(&p->pdev->dev, "Max perf-stat size %lu-bytes\n",
+			p->stat_buffer_len);
+	}
+
 	rc = papr_scm_nvdimm_init(p);
 	if (rc)
 		goto err2;
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
