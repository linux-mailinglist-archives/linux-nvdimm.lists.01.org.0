Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314F165C2D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:53:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2D4B10FC35BB;
	Thu, 20 Feb 2020 02:53:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6D0B810FC35B2
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:51:39 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAoW5D190795
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xe8fmx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:44 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:03 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:50:00 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAnxEh26477016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:49:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D38CA404D;
	Thu, 20 Feb 2020 10:49:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA31A4051;
	Thu, 20 Feb 2020 10:49:56 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:49:56 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 4/8] libndctl: Add support for parsing of_pmem dimm flags and monitor mode
Date: Thu, 20 Feb 2020 16:19:24 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0008-0000-0000-00000354B673
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0009-0000-0000-00004A75C5F7
Message-Id: <20200220104928.198625-5-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_03:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=3 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: DVTUD3KYT3XDDPAA7AASH42Y4UVVOZG5
X-Message-ID-Hash: DVTUD3KYT3XDDPAA7AASH42Y4UVVOZG5
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DVTUD3KYT3XDDPAA7AASH42Y4UVVOZG5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add support for parsing the dimm flags for of_pmem supporting
dimms. The flag file is exported in sysfs as 'papr_flags' and its
contents are space separated flags indicating the current state of the
dimm. A newly introduced function parse_of_pmem_flags() reads the contents
of this flag file and sets appropriate flag bits in 'struct
ndctl_dimm.flags'. This function is called at the end of of_pmem probe
function add_of_pmem_dimm().

Also we advertise support for monitor mode by allocating a file
descriptor to the 'papr_flags' file and assigning it to 'struct
ndctl_dimm.health_event_fd'.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/libndctl.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 650406d27512..7cc50afac404 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -801,6 +801,28 @@ static void parse_nfit_mem_flags(struct ndctl_dimm *dimm, char *flags)
 				ndctl_dimm_get_devname(dimm), flags);
 }
 
+static void parse_of_pmem_flags(struct ndctl_dimm *dimm, char *flags)
+{
+	char *start, *end;
+
+	start = flags;
+	while ((end = strchr(start, ' '))) {
+		*end = '\0';
+		if (strcmp(start, "not_armed") == 0)
+			dimm->flags.f_arm = 1;
+		else if (strcmp(start, "save_fail") == 0)
+			dimm->flags.f_save = 1;
+		else if (strcmp(start, "flush_fail") == 0)
+			dimm->flags.f_flush = 1;
+		else if (strcmp(start, "smart_notify") == 0)
+			dimm->flags.f_notify = 1;
+		start = end + 1;
+	}
+	if (end != start)
+		dbg(ndctl_dimm_get_ctx(dimm), "%s: %s\n",
+				ndctl_dimm_get_devname(dimm), flags);
+}
+
 static void parse_dimm_flags(struct ndctl_dimm *dimm, char *flags)
 {
 	char *start, *end;
@@ -1436,8 +1458,17 @@ static int add_of_pmem_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 	if (strcmp(buf, "ibm,pmemory") == 0) {
 		dimm->cmd_family = NVDIMM_FAMILY_PAPR_SCM;
 		rc = 0;
-		goto out;
+		goto out_monitor;
 	}
+
+out_monitor:
+	/* read the flags and also allocate the monitor mode event_fd */
+	sprintf(path, "%s/papr_flags", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		parse_of_pmem_flags(dimm, buf);
+
+	/* Allocate monitor mode fd */
+	dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
 out:
 	free(path);
 	return rc;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
