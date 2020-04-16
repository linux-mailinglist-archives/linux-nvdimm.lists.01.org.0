Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 013E41ACFF8
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Apr 2020 20:53:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 655C6100DCB7C;
	Thu, 16 Apr 2020 11:53:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0BAC6100DCB7A
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 11:53:39 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GIaR1Y050892
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 14:53:18 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30escs7ese-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 16 Apr 2020 14:53:17 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 16 Apr 2020 19:53:10 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 Apr 2020 19:53:08 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GIrCqU58392786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2020 18:53:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E4604C050;
	Thu, 16 Apr 2020 18:53:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11D564C046;
	Thu, 16 Apr 2020 18:53:10 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.55.251])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2020 18:53:09 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH] libndctl: Fix buffer 'offset' calculation in do_cmd()
Date: Fri, 17 Apr 2020 00:22:23 +0530
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20041618-0028-0000-0000-000003F9797C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041618-0029-0000-0000-000024BF30BD
Message-Id: <20200416185223.48486-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_08:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 suspectscore=1 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160131
Message-ID-Hash: ASQWLAAMFWOAEMIPSANVFBPDKE7RY4MC
X-Message-ID-Hash: ASQWLAAMFWOAEMIPSANVFBPDKE7RY4MC
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ASQWLAAMFWOAEMIPSANVFBPDKE7RY4MC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The 'for' loop in do_cmd() that generates multiple ioctls to
libnvdimm assumes that each ioctl will result in transfer of
'iter->max_xfer' bytes. Hence after each successful iteration the
buffer 'offset' is incremented by 'iter->max_xfer'.

This is in contrast to similar implementation in libnvdimm kernel
function nvdimm_get_config_data() which increments the buffer offset
by 'cmd->in_length' thats the actual number of bytes transferred from
the dimm/bus control function.

The implementation in kernel function nvdimm_get_config_data() is more
accurate compared to one in do_cmd() as former doesn't assume that
config/label-area data size is in multiples of 'iter->max_xfer'.

Hence the patch updates do_cmd() to increment the buffer 'offset'
variable by 'cmd->get_xfer()' rather than 'iter->max_xfer' after each
iteration.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/libndctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index cda17ff32410..24fa67f0ccd0 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -3089,7 +3089,7 @@ NDCTL_EXPORT int ndctl_cmd_xlat_firmware_status(struct ndctl_cmd *cmd)
 static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
 {
 	int rc;
-	u32 offset;
+	u32 offset = 0;
 	const char *name, *sub_name = NULL;
 	struct ndctl_dimm *dimm = cmd->dimm;
 	struct ndctl_bus *bus = cmd_to_bus(cmd);
@@ -3116,7 +3116,7 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
 			return rc;
 	}
 
-	for (offset = 0; offset < iter->total_xfer; offset += iter->max_xfer) {
+	while (offset < iter->total_xfer) {
 		cmd->set_xfer(cmd, min(iter->total_xfer - offset,
 				iter->max_xfer));
 		cmd->set_offset(cmd, offset);
@@ -3136,6 +3136,8 @@ static int do_cmd(int fd, int ioctl_cmd, struct ndctl_cmd *cmd)
 			rc = offset + cmd->get_xfer(cmd) - rc;
 			break;
 		}
+
+		offset += cmd->get_xfer(cmd) - rc;
 	}
 
 	dbg(ctx, "bus: %d dimm: %#x cmd: %s%s%s total: %d max_xfer: %d status: %d fw: %d (%s)\n",
-- 
2.25.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
