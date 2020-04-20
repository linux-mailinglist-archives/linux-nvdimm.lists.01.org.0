Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BAE1B0385
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Apr 2020 09:56:55 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 989B1100A0274;
	Mon, 20 Apr 2020 00:56:51 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 83BC4100A026D
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 00:56:24 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K7WWL7196249
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:56:26 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 30gcbe5kcv-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Mon, 20 Apr 2020 03:56:26 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Mon, 20 Apr 2020 08:55:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 20 Apr 2020 08:55:47 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K7uIsd56426744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2020 07:56:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE21911C050;
	Mon, 20 Apr 2020 07:56:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFD111C058;
	Mon, 20 Apr 2020 07:56:15 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.35.142])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2020 07:56:15 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v2 3/6] libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
Date: Mon, 20 Apr 2020 13:25:53 +0530
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200420075556.272174-1-vaibhav@linux.ibm.com>
References: <20200420075556.272174-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20042007-0008-0000-0000-00000373EFD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042007-0009-0000-0000-00004A95B0E9
Message-Id: <20200420075556.272174-4-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_02:2020-04-17,2020-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 suspectscore=3 malwarescore=0 spamscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004200067
Message-ID-Hash: LO45TV3F77VEPZJLAYALSGBQMEZ6CBVS
X-Message-ID-Hash: LO45TV3F77VEPZJLAYALSGBQMEZ6CBVS
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LO45TV3F77VEPZJLAYALSGBQMEZ6CBVS/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are scenarios when a dimm-provider need to allocate some
per-dimm data that can be quickly retrieved. This data can be used to
cache data that spans multiple 'struct ndctl_cmd' submissions.

Unfortunately currently in libnvdimm there is no easy way to implement
this. Even if this data is some how stored in some field of 'struct
ndctl_dimm', managing its lifetime is a challenge.

To solve this problem, the patch proposes a new member 'struct
ndctl_dimm.dimm_user_data' to store per-dimm data interpretation of
which is specific to a dimm-provider. Also two new dimm-ops namely
dimm_init() & dimm_uninit() are introduced that can be used to manage
the lifetime of this per-dimm data.

Semantics
=========
int (*dimm_init)(struct ndctl_dimm *):

This callback will be called just after dimm-probe inside add_dimm()
is completed. Dimm-providers should use this callback to allocate
per-dimm data and assign it to 'struct ndctl_dimm.dimm_user_data'
member. In case this function returns an error, dimm initialization is
halted and errors out.

void (*dimm_uninit)(struct ndctl_dimm *):

This callback will be called during free_dimm() and is only called if
previous call to 'dimm_ops->dimm_init()' had reported no
error. Dimm-providers should use this callback to unallocate and
cleanup 'dimm_user_data'.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v1..v2:
* Changed the patch order
---
 ndctl/lib/libndctl.c | 11 +++++++++++
 ndctl/lib/private.h  |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 60dad8e56f5a..cda17ff32410 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -598,6 +598,11 @@ static void free_dimm(struct ndctl_dimm *dimm)
 {
 	if (!dimm)
 		return;
+
+	/* If needed call the dimm uninitialization function */
+	if (dimm->ops && dimm->ops->dimm_uninit)
+		dimm->ops->dimm_uninit(dimm);
+
 	free(dimm->unique_id);
 	free(dimm->dimm_buf);
 	free(dimm->dimm_path);
@@ -1714,8 +1719,14 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR_SCM)
 		dimm->ops = papr_scm_dimm_ops;
 
+	/* Call the dimm initialization function if needed */
+	if (!rc && dimm->ops && dimm->ops->dimm_init)
+		rc = dimm->ops->dimm_init(dimm);
+
  out:
 	if (rc) {
+		/* Ensure dimm_uninit() is not called during free_dimm() */
+		dimm->ops = NULL;
 		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
 		goto err_read;
 	}
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 05c703ed71b4..679e359a1070 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -99,6 +99,7 @@ struct ndctl_dimm {
 	} flags;
 	int locked;
 	int aliased;
+	void *dimm_user_data;
 	struct list_node list;
 	int formats;
 	int format[0];
@@ -347,6 +348,10 @@ struct ndctl_dimm_ops {
 	int (*fw_update_supported)(struct ndctl_dimm *);
 	int (*xlat_firmware_status)(struct ndctl_cmd *);
 	u32 (*get_firmware_status)(struct ndctl_cmd *);
+	/* Called just after dimm is initialized and probed */
+	int (*dimm_init)(struct ndctl_dimm *);
+	/* Called just before struct ndctl_dimm is de-allocated */
+	void (*dimm_uninit)(struct ndctl_dimm *);
 };
 
 extern struct ndctl_dimm_ops * const intel_dimm_ops;
-- 
2.25.3
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
