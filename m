Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 419C421745F
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 18:46:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5CCE310FCD5CD;
	Tue,  7 Jul 2020 09:46:53 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harish@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4DC541003FD6A
	for <linux-nvdimm@lists.01.org>; Tue,  7 Jul 2020 09:46:51 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067GWPrY190559;
	Tue, 7 Jul 2020 12:46:45 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
	by mx0a-001b2d01.pphosted.com with ESMTP id 324ptpvth3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2020 12:46:45 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
	by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067GgFNM004505;
	Tue, 7 Jul 2020 16:46:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma06fra.de.ibm.com with ESMTP id 322h1g9shr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2020 16:46:43 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067Gkfp464749896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2020 16:46:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 200E052052;
	Tue,  7 Jul 2020 16:46:41 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.87.99])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 01F4C52050;
	Tue,  7 Jul 2020 16:46:39 +0000 (GMT)
From: Harish <harish@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: [ndctl PATCH] infoblock: Make output mutually exclusive
Date: Tue,  7 Jul 2020 22:16:35 +0530
Message-Id: <20200707164635.31217-1-harish@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 mlxscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070115
Message-ID-Hash: IVM7SXNAL5H4UDUETOK5Q2HK4GWGV5SV
X-Message-ID-Hash: IVM7SXNAL5H4UDUETOK5Q2HK4GWGV5SV
X-MailFrom: harish@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Harish <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/IVM7SXNAL5H4UDUETOK5Q2HK4GWGV5SV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Patch fixes checking output filter option (-o <file> or -c) of
write-infoblock command to be mutually exclusive.

Signed-off-by: Harish <harish@linux.ibm.com>
---
 ndctl/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0550580..d3ade25 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -440,7 +440,7 @@ static const char *parse_namespace_options(int argc, const char **argv,
 		rc = -EINVAL;
 	}
 
-	if (action == ACTION_WRITE_INFOBLOCK && (param.outfile || param.std_out)
+	if (action == ACTION_WRITE_INFOBLOCK && (param.outfile && param.std_out)
 			&& argc) {
 		error("specify only one of a namespace filter, --output, or --stdout\n");
 		rc = -EINVAL;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
