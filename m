Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024E210C5B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 Jul 2020 15:35:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 347E711460B27;
	Wed,  1 Jul 2020 06:35:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2E05611460B26
	for <linux-nvdimm@lists.01.org>; Wed,  1 Jul 2020 06:35:29 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061DVrJI023112;
	Wed, 1 Jul 2020 09:35:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 320s22d67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 09:35:22 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061DW359023854;
	Wed, 1 Jul 2020 09:35:22 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 320s22d668-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 09:35:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061DUWiR022182;
	Wed, 1 Jul 2020 13:35:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by ppma04ams.nl.ibm.com with ESMTP id 31wwr8cybg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2020 13:35:19 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061DZHL150266238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2020 13:35:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37CDC4C04A;
	Wed,  1 Jul 2020 13:35:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C25A4C04E;
	Wed,  1 Jul 2020 13:35:13 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.44.33])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed,  1 Jul 2020 13:35:13 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 01 Jul 2020 19:05:12 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 0/2] powerpc/papr_scm: add support for reporting NVDIMM 'life_used_percentage' metric
Date: Wed,  1 Jul 2020 19:05:08 +0530
Message-Id: <20200701133510.4613-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 cotscore=-2147483648 malwarescore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007010096
Message-ID-Hash: JKDGHQIYO62EY3V3QA6CFNZQNNAX77CZ
X-Message-ID-Hash: JKDGHQIYO62EY3V3QA6CFNZQNNAX77CZ
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/JKDGHQIYO62EY3V3QA6CFNZQNNAX77CZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Changes since v1 [1]:

* Minor restructuring of code as suggested by Ira
* Renaming of few members of 'struct par_scm_perf_[stat|stats]'
* Fixed a bug where a NULL pointer was potentially passed to
virt_to_phys().
* Using Big endian type rather than cpu native type so receive data
from PHYP in 'struct par_scm_perf_[stat|stats]'
* Some minor log message improvements.

[1] https://lore.kernel.org/linux-nvdimm/20200622042451.22448-1-vaibhav@linux.ibm.com
---

This small patchset implements kernel side support for reporting
'life_used_percentage' metric in NDCTL with dimm health output for
papr-scm NVDIMMs. With corresponding NDCTL side changes [2] output for
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

References
==========
[2]
https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v13_run_guage

Vaibhav Jain (2):
  powerpc/papr_scm: Fetch nvdimm performance stats from PHYP
  powerpc/papr_scm: Add support for fetching nvdimm 'fuel-gauge' metric

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 +++
 arch/powerpc/include/uapi/asm/papr_pdsm.h     |   9 +
 arch/powerpc/platforms/pseries/papr_scm.c     | 183 ++++++++++++++++++
 3 files changed, 219 insertions(+)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
