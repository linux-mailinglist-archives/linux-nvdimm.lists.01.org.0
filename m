Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5D41D8F9E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 19 May 2020 07:55:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 82EE411EA677D;
	Mon, 18 May 2020 22:52:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E035C11EA677A
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 22:52:08 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04J5WfKQ101055;
	Tue, 19 May 2020 01:55:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 313r0yp77h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 01:55:17 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04J5btGD118299;
	Tue, 19 May 2020 01:55:16 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com with ESMTP id 313r0yp77b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 01:55:16 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04J5nSCv011962;
	Tue, 19 May 2020 05:55:16 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma03wdc.us.ibm.com with ESMTP id 313wne32jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2020 05:55:16 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04J5tEnI11993414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2020 05:55:14 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 688467805E;
	Tue, 19 May 2020 05:55:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96967805C;
	Tue, 19 May 2020 05:55:12 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.81.200])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2020 05:55:12 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org
Subject: [PATCH v3 1/7] powerpc/pmem: Restrict papr_scm to P8 and above.
Date: Tue, 19 May 2020 11:24:56 +0530
Message-Id: <20200519055502.128318-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_01:2020-05-15,2020-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 phishscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190044
Message-ID-Hash: BFUHC2ZE6TU5ZQKI4NHBSAAABX34GDUP
X-Message-ID-Hash: BFUHC2ZE6TU5ZQKI4NHBSAAABX34GDUP
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alistair@popple.id.au, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BFUHC2ZE6TU5ZQKI4NHBSAAABX34GDUP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The PAPR based virtualized persistent memory devices are only supported on
POWER9 and above. In the followup patch, the kernel will switch the persistent
memory cache flush functions to use a new `dcbf` variant instruction. The new
instructions even though added in ISA 3.1 works even on P8 and P9 because these
are implemented as a variant of existing `dcbf` and `hwsync` and on P8 and
above behaves as such.

Considering these devices are only supported on P8 and above,  update the driver
to prevent a P7-compat guest from using persistent memory devices.

We don't update of_pmem driver with the same condition, because, on bare-metal,
the firmware enables pmem support only on P9 and above. There the kernel depends
on OPAL firmware to restrict exposing persistent memory related device tree
entries on older hardware. of_pmem.ko is written without any arch dependency and
we don't want to add ppc64 specific cpu feature check in of_pmem driver.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/pmem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
index f860a897a9e0..2347e1038f58 100644
--- a/arch/powerpc/platforms/pseries/pmem.c
+++ b/arch/powerpc/platforms/pseries/pmem.c
@@ -147,6 +147,12 @@ const struct of_device_id drc_pmem_match[] = {
 
 static int pseries_pmem_init(void)
 {
+	/*
+	 * Only supported on POWER8 and above.
+	 */
+	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
+		return 0;
+
 	pmem_node = of_find_node_by_type(NULL, "ibm,persistent-memory");
 	if (!pmem_node)
 		return 0;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
