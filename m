Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDE142CD1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jan 2020 15:08:09 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BA6B10097E0A;
	Mon, 20 Jan 2020 06:11:26 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A89910097E08
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jan 2020 06:11:25 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KE3P0n026258;
	Mon, 20 Jan 2020 09:08:06 -0500
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyea0re7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:05 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00KE45J2029929;
	Mon, 20 Jan 2020 09:08:05 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xkyea0rdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 09:08:05 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
	by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00KE4q9G029303;
	Mon, 20 Jan 2020 14:08:04 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
	by ppma02wdc.us.ibm.com with ESMTP id 2xksn637m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2020 14:08:04 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00KE83H330146886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jan 2020 14:08:03 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183A4BE05B;
	Mon, 20 Jan 2020 14:08:03 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC20DBE04F;
	Mon, 20 Jan 2020 14:08:00 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.71.225])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jan 2020 14:08:00 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, jmoyer@redhat.com
Subject: [PATCH v4 0/6] Validating namespace size and start address attributes.
Date: Mon, 20 Jan 2020 19:37:43 +0530
Message-Id: <20200120140749.69549-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=834 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200122
Message-ID-Hash: IK4I6465FDIJ3QIJ7F5MLROAUIZKCQBL
X-Message-ID-Hash: IK4I6465FDIJ3QIJ7F5MLROAUIZKCQBL
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IK4I6465FDIJ3QIJ7F5MLROAUIZKCQBL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When creating a new namespace, the kernel needs to make sure namespace size and
start address are correctly aligned to SUBSECTION_SIZE. This ensures kernel can
enable/disable namespace without conflicting with memory hotplug rules. Without this,
a namespace that partially covers a SUBSECTION can prevent the creation of an
adjacent namespace because the hotplug subsystem will find the subsection already active.

To make sure new kernel don't break an existing install with an unaligned start/size attribute,
while initializing the namespace the kernel validates these attribute against direct-map
mapping page size rather than subsection size.


Aneesh Kumar K.V (6):
  libnvdimm/namespace: Make namespace size validation arch dependent
  libnvdimm/namespace: Validate namespace start addr and size
  libnvdimm/namespace: Add arch dependent callback for namespace create
    time validation
  libnvdimm/namespace: Validate namespace size when creating a new
    namespace.
  libnvdimm/namespace: Align DPA based on arch restrictions
  libnvdimm/namespace: Expose arch specific supported size align value

 arch/arm64/mm/flush.c           | 13 +++++
 arch/powerpc/lib/pmem.c         | 20 ++++++++
 arch/x86/mm/pageattr.c          | 13 +++++
 drivers/nvdimm/namespace_devs.c | 85 +++++++++++++++++++++++++++++++--
 include/linux/libnvdimm.h       |  2 +
 5 files changed, 128 insertions(+), 5 deletions(-)

-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
