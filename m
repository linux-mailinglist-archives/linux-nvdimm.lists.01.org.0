Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53556233F34
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 08:42:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 86B8612878832;
	Thu, 30 Jul 2020 23:42:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1C8A01287882E
	for <linux-nvdimm@lists.01.org>; Thu, 30 Jul 2020 23:42:16 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V6XKor029019;
	Fri, 31 Jul 2020 02:42:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32maeb51hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 02:42:08 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V6XK8s029145;
	Fri, 31 Jul 2020 02:42:08 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 32maeb51gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 02:42:08 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V6UpM5004411;
	Fri, 31 Jul 2020 06:42:06 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by ppma03fra.de.ibm.com with ESMTP id 32gcr0m86g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2020 06:42:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V6g3uX21234074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2020 06:42:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758104C04A;
	Fri, 31 Jul 2020 06:42:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E39F4C040;
	Fri, 31 Jul 2020 06:42:00 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.19.45])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 31 Jul 2020 06:41:59 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 31 Jul 2020 12:11:58 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v4 0/2] powerpc/papr_scm: add support for reporting NVDIMM 'life_used_percentage' metric
Date: Fri, 31 Jul 2020 12:11:51 +0530
Message-Id: <20200731064153.182203-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_02:2020-07-30,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310047
Message-ID-Hash: 3SWB3IZ5KHGOIMWCUIJ442O3R2ESLCXY
X-Message-ID-Hash: 3SWB3IZ5KHGOIMWCUIJ442O3R2ESLCXY
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3SWB3IZ5KHGOIMWCUIJ442O3R2ESLCXY/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v3[1]:

* Fixed a rebase issue pointed out by Aneesh in first patch in the series.

[1] https://lore.kernel.org/linux-nvdimm/20200730121303.134230-1-vaibhav@linux.ibm.com
---

This small patchset implements kernel side support for reporting
'life_used_percentage' metric in NDCTL with dimm health output for
papr-scm NVDIMMs. With corresponding NDCTL side changes output for
should be like:

$ sudo ndctl list -DH
[
  {
    "dev":"nmem0",
    "health":{
      "health_state":"ok",
      "life_used_percentage":0,
      "shutdown_state":"clean"
    }
  }
]

PHYP supports H_SCM_PERFORMANCE_STATS hcall through which an LPAR can
fetch various performance stats including 'fuel_gauge' percentage for
an NVDIMM. 'fuel_gauge' metric indicates the usable life remaining of
an NVDIMM expressed as percentage and  'life_used_percentage' can be
calculated as 'life_used_percentage = 100 - fuel_gauge'.

Structure of the patchset
=========================
First patch implements necessary scaffolding needed to issue the
H_SCM_PERFORMANCE_STATS hcall and fetch performance stats
catalogue. The patch also implements support for 'perf_stats' sysfs
attribute to report the full catalogue of supported performance stats
by PHYP.

Second and final patch implements support for sending this value to
libndctl by extending the PAPR_PDSM_HEALTH pdsm payload to add a new
field named 'dimm_fuel_gauge' to it.

Vaibhav Jain (2):
  powerpc/papr_scm: Fetch nvdimm performance stats from PHYP
  powerpc/papr_scm: Add support for fetching nvdimm 'fuel-gauge' metric

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 +++
 arch/powerpc/include/uapi/asm/papr_pdsm.h     |   9 +
 arch/powerpc/platforms/pseries/papr_scm.c     | 199 ++++++++++++++++++
 3 files changed, 235 insertions(+)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
