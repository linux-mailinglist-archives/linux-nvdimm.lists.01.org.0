Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF03243361
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 Aug 2020 06:35:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0F63512FFD9FD;
	Wed, 12 Aug 2020 21:35:23 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E075212FFD9FC
	for <linux-nvdimm@lists.01.org>; Wed, 12 Aug 2020 21:35:20 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07D4WxAP037515;
	Thu, 13 Aug 2020 00:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+fDx+BmpDs/4z/fssdjXb16JLmqig9SdOL3eh929Opg=;
 b=qN9NWsHXvermtggXfwGi2SpB03N54TMkn/4q34vTG3Gkeuwr4Vm3Bzc1oXVR8LhT5LJy
 qS9bC6evy2fDA/bY0YrqD6V9iCOyOLUZ6VhfHJuALwyFzv2pJmv9Xlxbt9TgG13HwklN
 zRDq3elg/3sjlWl2OZnf9pfazvVWvhutHSQgO0+wnG5jOVEb0nJQdOQa4z3DHQ11ouif
 Jn8WlaMxOILixGXhTRXW15XUtxU9+d1QuScQ0xxn+oBieHNfcP1kEJOrjn7vXAGZD81X
 qh+//F0fzmCsxdWxLnnvgWgJm2d87U84xbL+CJgVa+SqHAK9AnDjhftEPTdgryeU+vr1 cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v0rvtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 00:35:09 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07D4YvKl042939;
	Thu, 13 Aug 2020 00:35:09 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32v7v0rvst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 00:35:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07D4QZ2X031833;
	Thu, 13 Aug 2020 04:35:07 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 32skp854ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2020 04:35:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07D4Z4Yu30015802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2020 04:35:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100794C04E;
	Thu, 13 Aug 2020 04:35:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F544C052;
	Thu, 13 Aug 2020 04:35:01 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.68.120])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Thu, 13 Aug 2020 04:35:01 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Thu, 13 Aug 2020 10:05:00 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
Date: Thu, 13 Aug 2020 10:04:58 +0530
Message-Id: <20200813043458.165718-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_02:2020-08-11,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130030
Message-ID-Hash: ERWZNBEENR75QKIWFP7K7LTEUVFQ3SVF
X-Message-ID-Hash: ERWZNBEENR75QKIWFP7K7LTEUVFQ3SVF
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ERWZNBEENR75QKIWFP7K7LTEUVFQ3SVF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The newly introduced 'perf_stats' attribute uses the default access
mode of 0444 letting non-root users access performance stats of an
nvdimm and potentially force the kernel into issuing large number of
expensive HCALLs. Since the information exposed by this attribute
cannot be cached hence its better to ward of access to this attribute
from users who don't need to access these performance statistics.

Hence this patch adds check in perf_stats_show() to only let users
that are 'perfmon_capable()' to read the nvdimm performance
statistics.

Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index f439f0dfea7d1..36c51bf8af9a8 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -792,6 +792,10 @@ static ssize_t perf_stats_show(struct device *dev,
 	struct nvdimm *dimm = to_nvdimm(dev);
 	struct papr_scm_priv *p = nvdimm_provider_data(dimm);
 
+	/* Allow access only to perfmon capable users */
+	if (!perfmon_capable())
+		return -EACCES;
+
 	if (!p->stat_buffer_len)
 		return -ENOENT;
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
