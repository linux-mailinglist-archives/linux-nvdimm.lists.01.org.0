Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8811D76B5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 May 2020 13:20:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3622711E16D12;
	Mon, 18 May 2020 04:17:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F1EF311E16D0E
	for <linux-nvdimm@lists.01.org>; Mon, 18 May 2020 04:17:27 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IB2MrA011338;
	Mon, 18 May 2020 07:20:33 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 31293tswa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 07:20:32 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IBKTSf009087;
	Mon, 18 May 2020 11:20:30 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma03ams.nl.ibm.com with ESMTP id 3127t5m05m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2020 11:20:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IBKRNs62390718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2020 11:20:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDC755204E;
	Mon, 18 May 2020 11:20:27 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.102.2.238])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 8D5A15204F;
	Mon, 18 May 2020 11:20:25 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Mon, 18 May 2020 16:50:24 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl RFC-PATCH 0/4] Add support for reporting PAPR NVDIMM Statistics
Date: Mon, 18 May 2020 16:50:19 +0530
Message-Id: <20200518112023.147139-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_04:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=941 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 cotscore=-2147483648 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180096
Message-ID-Hash: Q2UFWU46HO5RB7P3Z25Q3CIXJRJB5U4Z
X-Message-ID-Hash: Q2UFWU46HO5RB7P3Z25Q3CIXJRJB5U4Z
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Q2UFWU46HO5RB7P3Z25Q3CIXJRJB5U4Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch-set proposes addition of new functionality to ndctl and
libndctl enabling them to report vendor specific NVDIMM Statistics
(dimm-stats) like "Cache Read/Write Hit Count" which arent S.M.A.R.T
attributes but still indicate important NVDIMM performance metrics.

Until now these statistics were exposed via vendor specific tools
like ipmictl[1] in case of Intel Optane-DC memory. These patch-set
however tries to implement a generic abstraction within libndctl to
report such statistics from the ndctl tool.

The patch-set proposes to add a new command line arg '--stats' / '-S'
that reports vendor specific dimm-stats for a NVDIMM. Below is an
example invocation and output of the proposed changes:

 # ndctl list -D --stats
[
  {
    "dev":"nmem0",
    "stats":{
      "Controller Reset Count":2,
      "Controller Reset Elapsed Time":603331,
      "Power-on Seconds":603931,
      "Life Remaining":"100%",
      "Critical Resource Utilization":"0%",
      "Host Load Count":5781028,
      "Host Store Count":8966800,
      "Host Load Duration":975895365,
      "Host Store Duration":716230690,
      "Media Read Count":0,
      "Media Write Count":6313,
      "Media Read Duration":0,
      "Media Write Duration":9679615,
      "Cache Read Hit Count":5781028,
      "Cache Write Hit Count":8442479,
      "Fast Write Count":8969912
    }
  }
]

As a proof of concept the patch-set implements reporting dimm-stats for
PAPR compatible NVDIMMs. The output above is from a PPC64 PSeries
Guest LPAR with an NVDIMM, running on a PowerVM Hyper-visor.

The patch-set is dependent on existing patch-set "[ndctl PATCH v3 0/6]
Add support for reporting papr-scm nvdimm health" available at
Ref[2] and [3]. That patch-set implemented the base infrastructure
needed to support PAPR complaint NVDIMMs in ndctl and libndctl.

For PAPR compliant NVDIMMs we also depend on kernel side changes
published at [4] that add support for necessary pdsms to expose
dimm-stats to libndctl via CMD_CALL ioctl interface.

Structure of the patch-set
==========================

First patch in the series starts with implementing necessary
infrastructure in libndctl to introduce two new dimm_ops namely
'new_stats' and 'get_stat' that can be implemented by dimm-providers
to provide libndctl access to vendor specific dimm-stats. The patch
also implements necessary changes in ndctl ndctl/util/json-smart.c to
call these new dimm-ops and generate json-c objects to generate an
output as mentioned above.

Next three patches deal with implementing support for these new
dimm-ops for papr_scm in libndctl. Patch-2 implements dimm-op
'new_stats' that returns a 'struct ndctl_cmd' that can be submitted to
libnvdimm for fetching dimm-stats and copy them to papr_scm managed
buffer.

Patch-2 implements parsing and clean-up of the fetched dimm-stats from
kernel.

Finally Patch-3 implements dimm_ops 'get_stat' that provides ndctl
access to dimm-stat which then constructs a json object aggregating
them and then generating a text output from it.


References
==========
[1] https://docs.pmem.io/ipmctl-user-guide/instrumentation/show-device-performance

[2] https://github.com/vaibhav92/ndctl/tree/papr_scm_health_v7

[3] https://lore.kernel.org/linux-nvdimm/20200420075556.272174-1-vaibhav@linux.ibm.com/

[4] https://lore.kernel.org/linux-nvdimm/20200518110814.145644-1-vaibhav@linux.ibm.com

Vaibhav Jain (4):
  ndctl,libndctl: Implement new dimm-ops 'new_stats' and 'get_stat'
  papr_scm: Add support for fetching dimm-stats
  papr_scm: Implement parsing and clean-up for fetched dimm stats
  papr_scm: Implement dimm op 'get_stat'

 Documentation/ndctl/ndctl-list.txt |  24 +++
 ndctl/lib/libndctl.sym             |   5 +
 ndctl/lib/papr_scm.c               | 300 ++++++++++++++++++++++++++++-
 ndctl/lib/papr_scm_pdsm.h          |  48 +++++
 ndctl/lib/private.h                |   6 +
 ndctl/lib/smart.c                  |  26 +++
 ndctl/libndctl.h                   |  23 +++
 ndctl/list.c                       |   9 +
 ndctl/util/json-smart.c            |  73 +++++++
 util/json.h                        |   1 +
 10 files changed, 514 insertions(+), 1 deletion(-)

-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
