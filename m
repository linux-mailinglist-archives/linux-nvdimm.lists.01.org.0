Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E36293442
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Oct 2020 07:27:26 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6218B159BD0AC;
	Mon, 19 Oct 2020 22:27:24 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3FAC159ADF6F
	for <linux-nvdimm@lists.01.org>; Mon, 19 Oct 2020 22:27:21 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09K57I5O010634;
	Tue, 20 Oct 2020 01:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=t8SrPZ19pjm68HwhbJbUKSfGM/sp19xa9Qj8Zf9cjsc=;
 b=AuCG9fZFLyLif/KQ+EU+dsUL/fWZdzYkuCwbDnBfD7+jvPbduIK2FWjk2vUXTruip9nV
 Eeg9bGhYpvnDLnDO2VIBoidULGDejeo6pUvt+jLrVZ8lviHurDxZYte3bpRXpT64CN5D
 LyBsmOf4W/VfbIGQS5WmuAh1WPXMvOd/73w+vgjsQPB3QoDZc9mzL+9emuaxhX0u9yZy
 XeInv8+ildKBSOqE8QKGn6Du+MM8oVm9T/t3UAt95LSe2D2/FCNQMunqZXfptWECcE1M
 D3RJzfuRLB112mTMGmg/M8vJwBpoLI0jjXRsTBg8HLIWcwY18CYQT3Aw10s8ezM1LT2W ww==
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
	by mx0b-001b2d01.pphosted.com with ESMTP id 349ra59wg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 01:27:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
	by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09K5OCS0014051;
	Tue, 20 Oct 2020 05:27:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma03dal.us.ibm.com with ESMTP id 347r892m17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2020 05:27:18 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09K5RH1n61407580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2020 05:27:17 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 754346A047;
	Tue, 20 Oct 2020 05:27:17 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644BB6A057;
	Tue, 20 Oct 2020 05:27:15 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.92.7])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2020 05:27:14 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-nvdimm@lists.01.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Subject: [PATCH] daxctl: phys_index value 0 is valid
Date: Tue, 20 Oct 2020 10:57:04 +0530
Message-Id: <20201020052704.331557-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-20_01:2020-10-16,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200030
Message-ID-Hash: MCAJOM4PCNRNY7AXSF4OERQG5RX3Q5KL
X-Message-ID-Hash: MCAJOM4PCNRNY7AXSF4OERQG5RX3Q5KL
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MCAJOM4PCNRNY7AXSF4OERQG5RX3Q5KL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On power platforms we can find
 # cat /sys/devices/system/memory/memory0/phys_index
00000000

This results in

libdaxctl: memblock_in_dev: dax1.0: memory0: Unable to determine phys_index: Success

Avoid considering phys_index == 0 as error.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 daxctl/lib/libdaxctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index ee4a069eb463..3cb89c755978 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1229,7 +1229,7 @@ static int memblock_in_dev(struct daxctl_memory *mem, const char *memblock)
 	rc = sysfs_read_attr(ctx, path, buf);
 	if (rc == 0) {
 		phys_index = strtoul(buf, NULL, 16);
-		if (phys_index == 0 || phys_index == ULONG_MAX) {
+		if (phys_index == ULONG_MAX) {
 			rc = -errno;
 			err(ctx, "%s: %s: Unable to determine phys_index: %s\n",
 				devname, memblock, strerror(-rc));
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
