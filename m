Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9675510C529
	for <lists+linux-nvdimm@lfdr.de>; Thu, 28 Nov 2019 09:31:52 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 052C3101134F0;
	Thu, 28 Nov 2019 00:35:14 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CD596101134EF
	for <linux-nvdimm@lists.01.org>; Thu, 28 Nov 2019 00:35:11 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAS8Ncxh081473;
	Thu, 28 Nov 2019 03:31:47 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2whcy8q8x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 03:31:47 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAS8UBwC001018;
	Thu, 28 Nov 2019 08:31:46 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by ppma03wdc.us.ibm.com with ESMTP id 2wevd6v17m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2019 08:31:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAS8Vk0E46137790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2019 08:31:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2008DAC05F;
	Thu, 28 Nov 2019 08:31:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 765B5AC059;
	Thu, 28 Nov 2019 08:31:42 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.39.131])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 28 Nov 2019 08:31:41 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: [PATCH v2 5/6] libnvdimm/namespace: Align DPA based on arch restrictions
Date: Thu, 28 Nov 2019 14:00:56 +0530
Message-Id: <20191128083057.141425-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
References: <20191128083057.141425-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 mlxlogscore=878 impostorscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=1 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280071
Message-ID-Hash: DLVKLSPIUWTRPGBBIWXVX2J575TCINZH
X-Message-ID-Hash: DLVKLSPIUWTRPGBBIWXVX2J575TCINZH
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DLVKLSPIUWTRPGBBIWXVX2J575TCINZH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When creating new namespace make sure DPA address are properly aligned based
on arch restrictions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/nvdimm/namespace_devs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 06b55c41660d..6a83db9f8734 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -589,6 +589,8 @@ static void space_valid(struct nd_region *nd_region, struct nvdimm_drvdata *ndd,
 		return;
 	}
 
+	valid->start = ALIGN(valid->start, arch_namespace_align_size());
+
 	/* allocation needs to be contiguous, so this is all or nothing */
 	if (resource_size(valid) < n)
 		goto invalid;
-- 
2.23.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
