Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E10837C81D
	for <lists+linux-nvdimm@lfdr.de>; Wed, 12 May 2021 18:39:20 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B69F100EBB92;
	Wed, 12 May 2021 09:39:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BAD74100EBB6A
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 09:39:12 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14CGXvTv080047;
	Wed, 12 May 2021 12:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KpwEyGoPjDUEM6nsUOz34TyLmBlksLIsyVzf/xObjiw=;
 b=UVdVbSj5UbTNgQGCrof3qtzIXovp4r0aUyvHuoNGgCSHSN80OBaL9U8tXeU44MrsgVT1
 tW8T+yPwLW1tWFdqIf4BjF24Z6VTjpCJytRpVHm/LX1UoyQUL8zMsQASPKEsehcPXPjV
 YhEj5RGDHhR5OlDgFEetk6RsMaVdoSCdYHmIWhDo28dlGG8+m07iC9ZvqXemYUbG++ih
 wn+T+u3jdMU5mfm0jLljCAglwsaDGB/3I6t2RtuWTgTMqU9r3+cTIVomrecAtjyzVnc6
 WcYljzI2jIIUNPbW1UVWyrV49BPYWtcuWwMGfd4UUY5kMpaSrimGhNEKpJz8WcrZAAi8 0A==
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
	by mx0b-001b2d01.pphosted.com with ESMTP id 38ghx3hfs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 May 2021 12:38:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
	by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14CGXAhg012041;
	Wed, 12 May 2021 16:38:45 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma02fra.de.ibm.com with ESMTP id 38dj9898ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 May 2021 16:38:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14CGcF2f37421500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 May 2021 16:38:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA56FAE0F4;
	Wed, 12 May 2021 16:38:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83DF0AE0EF;
	Wed, 12 May 2021 16:38:38 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.40.5])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Wed, 12 May 2021 16:38:38 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/4] Add perf interface to expose nvdimm performance stats
Date: Wed, 12 May 2021 22:08:20 +0530
Message-Id: <20210512163824.255370-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tp5c3rAEQvtdJhfKf-iB3p_7q0MoJnI3
X-Proofpoint-ORIG-GUID: tp5c3rAEQvtdJhfKf-iB3p_7q0MoJnI3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-12_09:2021-05-12,2021-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=957 lowpriorityscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105120105
Message-ID-Hash: NDDEIHLBZDRSGC5EZ2XKG26AH4AOKZ5T
X-Message-ID-Hash: NDDEIHLBZDRSGC5EZ2XKG26AH4AOKZ5T
X-MailFrom: kjain@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: maddy@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com, vaibhav@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NDDEIHLBZDRSGC5EZ2XKG26AH4AOKZ5T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patchset adds performance stats reporting support for nvdimm.
Added interface includes support for a pmu register function and
callbacks to be used by arch/platform specific drivers.
User could use standard perf tool to access perf events exposed via pmu.

Patchset adds a structure called nvdimm_pmu which can
be used to add platform specific data like supported event list and
callbacks to pmu functions like event_init/add/delete/read.

Patchset includes an implements the to expose IBM pseries platform nmem*
device performance stats using this interface.

Result from power9 pseries lpar with 2 nvdimm device:
command:# perf list nmem
  nmem0/cchrhcnt/                                    [Kernel PMU event]
  nmem0/cchwhcnt/                                    [Kernel PMU event]
  nmem0/critrscu/                                    [Kernel PMU event]
  nmem0/ctlresct/                                    [Kernel PMU event]
  nmem0/ctlrestm/                                    [Kernel PMU event]
  nmem0/fastwcnt/                                    [Kernel PMU event]
  nmem0/hostlcnt/                                    [Kernel PMU event]
  nmem0/hostldur/                                    [Kernel PMU event]
  nmem0/hostscnt/                                    [Kernel PMU event]
  nmem0/hostsdur/                                    [Kernel PMU event]
  nmem0/medrcnt/                                     [Kernel PMU event]
  nmem0/medrdur/                                     [Kernel PMU event]
  nmem0/medwcnt/                                     [Kernel PMU event]
  nmem0/medwdur/                                     [Kernel PMU event]
  nmem0/memlife/                                     [Kernel PMU event]
  nmem0/noopstat/                                    [Kernel PMU event]
  nmem0/ponsecs/                                     [Kernel PMU event]
  nmem1/cchrhcnt/                                    [Kernel PMU event]
  nmem1/cchwhcnt/                                    [Kernel PMU event]
  nmem1/critrscu/                                    [Kernel PMU event]
  ...
  nmem1/noopstat/                                    [Kernel PMU event]
  nmem1/ponsecs/                                     [Kernel PMU event]

Patch1:
        Introduces the nvdimm_pmu structure, common function for pmu
        register along with callback routine check.
Pacth2
        Add code in arch/powerpc/platform/pseries/papr_scm.c to expose
        nmem* pmu. It fills in the nvdimm_pmu structure with event attrs
        and event callback functions and then registers the pmu by adding
        callback to register_nvdimm_pmu.
Patch3:
        Sysfs documentation patch
Patch4:
        Adds cpuhotplug support.

Kajol Jain (4):
  drivers/nvdimm: Add perf interface to expose nvdimm performance stats
  powerpc/papr_scm: Add perf interface support
  powerpc/papr_scm: Document papr_scm sysfs event format entries
  powerpc/papr_scm: Add cpu hotplug support for nvdimm pmu device

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  31 ++
 arch/powerpc/include/asm/device.h             |   5 +
 arch/powerpc/platforms/pseries/papr_scm.c     | 346 +++++++++++++++++-
 drivers/nvdimm/Makefile                       |   1 +
 drivers/nvdimm/nd_perf.c                      | 111 ++++++
 include/linux/nd.h                            |  31 ++
 6 files changed, 524 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvdimm/nd_perf.c

-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
