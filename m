Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E80D25F903
	for <lists+linux-nvdimm@lfdr.de>; Mon,  7 Sep 2020 13:06:27 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EAA913B6E51D;
	Mon,  7 Sep 2020 04:06:25 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1D62E13B6E51C
	for <linux-nvdimm@lists.01.org>; Mon,  7 Sep 2020 04:06:21 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087B3ENm127493;
	Mon, 7 Sep 2020 07:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=rN65u+chTUkSYWa8afoWVcviGtesLrEc2JSgSAn7lHc=;
 b=dNWjWkoDXwEmXl4MiKBAsi1Wg7kIZtz7vgaaO3A/Gr7ioaGOZtsFrYXcRpXy7mShCyn+
 zNKSwAvDuupJjVaAKD76dO7RmZ2ZsodiGEKs2jO12zqKCV2kj7KUTkEipiSlSdr77Sqf
 PxxSFkNUCk42wv6Y9NUNdctKZpl0rqAqv/m7HwIdi00+JyeRXMl3QPs+I6Owc0QpUw3e
 SceMmouOtVm0sBAmUdBj1X6pzAa4WiNvraBkxsCZV+MVdjt65M/1VPEGv+ZhV6MXCotO
 6Wf+ANhJqVhlVHGg5+fCxYIhszBRk07VpOAYCEGTfngdocHIG/FjxH6LFJpM186aIsbl Kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33dk6vgwrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2020 07:06:02 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 087B3jma128969;
	Mon, 7 Sep 2020 07:06:02 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 33dk6vgwqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2020 07:06:02 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
	by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 087B1tCD020214;
	Mon, 7 Sep 2020 11:06:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma06ams.nl.ibm.com with ESMTP id 33cyq5128k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2020 11:06:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 087B5v3J33489292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2020 11:05:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AF9952059;
	Mon,  7 Sep 2020 11:05:57 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.81.124])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id D2B565204E;
	Mon,  7 Sep 2020 11:05:53 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation); Mon, 07 Sep 2020 16:35:52 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2] powerpc/papr_scm: Limit the readability of 'perf_stats' sysfs attribute
Date: Mon,  7 Sep 2020 16:35:40 +0530
Message-Id: <20200907110540.21349-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_04:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070104
Message-ID-Hash: NRNFY53AJ5MIH7WBVNQOIMNOYKOIQQ2Z
X-Message-ID-Hash: NRNFY53AJ5MIH7WBVNQOIMNOYKOIQQ2Z
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NRNFY53AJ5MIH7WBVNQOIMNOYKOIQQ2Z/>
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

Hence this patch updates access mode of 'perf_stats' attribute to
be only readable by root users.

Fixes: 2d02bf835e573 ('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Change-log:

v2:
* Instead of checking for perfmon_capable() inside show_perf_stats()
  set the attribute as DEVICE_ATTR_ADMIN_RO [ Aneesh ]
* Update patch description
---
 arch/powerpc/platforms/pseries/papr_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index f439f0dfea7d1..a88a707a608aa 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -822,7 +822,7 @@ static ssize_t perf_stats_show(struct device *dev,
 	kfree(stats);
 	return rc ? rc : seq_buf_used(&s);
 }
-DEVICE_ATTR_RO(perf_stats);
+DEVICE_ATTR_ADMIN_RO(perf_stats);
 
 static ssize_t flags_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
