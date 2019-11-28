Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CE110C52C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Nov 2019 09:32:01 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C4E7101134F0;
	Thu, 28 Nov 2019 00:35:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 35CDD101134E9
	for <linux-nvdimm@lists.01.org>; Thu, 28 Nov 2019 00:35:21 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS8RFxr043915;
	Thu, 28 Nov 2019 03:31:55 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2wjar88411-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 03:31:55 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAS8UBWO007767;
	Thu, 28 Nov 2019 08:31:54 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma03dal.us.ibm.com with ESMTP id 2wevd772b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 08:31:54 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAS8VrZu49545670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2019 08:31:53 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A664AAC05F;
	Thu, 28 Nov 2019 08:31:53 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67177AC059;
	Thu, 28 Nov 2019 08:31:48 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.131])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2019 08:31:47 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2 6/6] libnvdimm/namespace: Expose arch specific supported size align value
Date: Thu, 28 Nov 2019 14:00:57 +0530
Message-Id: <20191128083057.141425-6-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
References: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=1 mlxlogscore=902
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911280071
Message-ID-Hash: XTRPMQWBJOAONFAOX6UUNA2CUG6LYZWV
X-Message-ID-Hash: XTRPMQWBJOAONFAOX6UUNA2CUG6LYZWV
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XTRPMQWBJOAONFAOX6UUNA2CUG6LYZWV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Expose supported size align as a namespace RO attribute. Usespace can use this
to validate the size argument specified when creating a new namespace.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 6a83db9f8734..22c714469f87 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1684,6 +1684,14 @@ static ssize_t force_raw_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(force_raw);
 
+static ssize_t supported_size_align_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%ld\n", arch_namespace_align_size());
+}
+static DEVICE_ATTR_RO(supported_size_align);
+
+
 static struct attribute *nd_namespace_attributes[] = {
 	&dev_attr_nstype.attr,
 	&dev_attr_size.attr,
@@ -1696,6 +1704,7 @@ static struct attribute *nd_namespace_attributes[] = {
 	&dev_attr_sector_size.attr,
 	&dev_attr_dpa_extents.attr,
 	&dev_attr_holder_class.attr,
+	&dev_attr_supported_size_align.attr,
 	NULL,
 };
 
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
