Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 711B120CEF1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Jun 2020 15:57:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BCAEF111AFBB2;
	Mon, 29 Jun 2020 06:57:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 634C71118BAE6
	for <linux-nvdimm@lists.01.org>; Mon, 29 Jun 2020 06:57:53 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TDVGDl165375;
	Mon, 29 Jun 2020 09:57:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ycgcu72b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:57:45 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05TDVGL4165476;
	Mon, 29 Jun 2020 09:57:45 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31ycgcu71v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 09:57:45 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
	by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05TDtsjg016382;
	Mon, 29 Jun 2020 13:57:44 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
	by ppma02dal.us.ibm.com with ESMTP id 31wwr8knax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2020 13:57:44 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05TDvipA52363580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2020 13:57:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D64AAE05F;
	Mon, 29 Jun 2020 13:57:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED948AE05C;
	Mon, 29 Jun 2020 13:57:40 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.197.62])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2020 13:57:40 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Subject: [PATCH v6 1/8] powerpc/pmem: Restrict papr_scm to P8 and above.
Date: Mon, 29 Jun 2020 19:27:15 +0530
Message-Id: <20200629135722.73558-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
References: <20200629135722.73558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006290091
Message-ID-Hash: RVDDTWIVSOPFVQMHC2QRP5XLBKS5UYVR
X-Message-ID-Hash: RVDDTWIVSOPFVQMHC2QRP5XLBKS5UYVR
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, msuchanek@suse.de, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RVDDTWIVSOPFVQMHC2QRP5XLBKS5UYVR/>
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
P9 behaves as such.

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
