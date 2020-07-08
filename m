Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D73F218118
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 09:23:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CC66110CC32A;
	Wed,  8 Jul 2020 00:23:34 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harish@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B6331110BDB38
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 00:23:31 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06871vjY075711;
	Wed, 8 Jul 2020 03:23:29 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 324y8s713c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 03:23:29 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0687FvGv022215;
	Wed, 8 Jul 2020 07:23:27 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03ams.nl.ibm.com with ESMTP id 322hd7v96s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2020 07:23:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0687NPDS5702118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2020 07:23:25 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08555A405F;
	Wed,  8 Jul 2020 07:23:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D73FA405C;
	Wed,  8 Jul 2020 07:23:23 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.68.220])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2020 07:23:23 +0000 (GMT)
From: Harish <harish@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: [ndctl PATCH] Documentation: write-infoblock namespace as mutually exclusive
Date: Wed,  8 Jul 2020 12:53:19 +0530
Message-Id: <20200708072319.10896-1-harish@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_04:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 cotscore=-2147483648
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080044
Message-ID-Hash: UOWM6TW2B5Z6YI5I44BSASHA3UDRD62C
X-Message-ID-Hash: UOWM6TW2B5Z6YI5I44BSASHA3UDRD62C
X-MailFrom: harish@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Harish <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UOWM6TW2B5Z6YI5I44BSASHA3UDRD62C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The write-infoblock command allows user to write to only one of
namespace, stdout or to a file. Document that explicitly and also
change the usage string to indicate mutual exclusion.

Signed-off-by: Harish <harish@linux.ibm.com>
---
 Documentation/ndctl/ndctl-write-infoblock.txt | 14 ++++++++------
 ndctl/namespace.c                             |  4 +++-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/ndctl/ndctl-write-infoblock.txt b/Documentation/ndctl/ndctl-write-infoblock.txt
index 8197559..c29327d 100644
--- a/Documentation/ndctl/ndctl-write-infoblock.txt
+++ b/Documentation/ndctl/ndctl-write-infoblock.txt
@@ -61,19 +61,21 @@ read 1 infoblock
 
 OPTIONS
 -------
-<namespace(s)>::
-	One or more 'namespaceX.Y' device names. The keyword 'all' can be specified to
-	operate on every namespace in the system, optionally filtered by bus id (see
-        --bus= option), or region id (see --region= option).
+<namespace>::
+	Write the infoblock to 'namespaceX.Y' device name. The keyword 'all' can be
+	specified to operate on every namespace in the system, optionally filtered
+	by bus id (see --bus= option), or region id (see --region= option).
+	(mutually exclusive with --stdout and --output)
 
 -c::
 --stdout::
-	Write the infoblock to stdout
+	Write the infoblock to stdout (mutually
+	exclusive with <namespace> and --output)
 
 -o::
 --output=::
 	Write the infoblock to the given file (mutually
-	exclusive with --stdout).
+	exclusive with <namespace> and --stdout).
 
 -m::
 --mode=::
diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0550580..cf6c4ea 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -2346,7 +2346,9 @@ int cmd_read_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 int cmd_write_infoblock(int argc, const char **argv, struct ndctl_ctx *ctx)
 {
-	char *xable_usage = "ndctl write-infoblock <namespace> [<options>]";
+	char *xable_usage = "ndctl write-infoblock [<namespace> | -o <file> "
+			"| --stdout] [<options>]";
+
 	const char *namespace = parse_namespace_options(argc, argv,
 			ACTION_WRITE_INFOBLOCK, write_infoblock_options,
 			xable_usage);
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
