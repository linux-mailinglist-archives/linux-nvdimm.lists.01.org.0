Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D961E8AEE
	for <lists+linux-nvdimm@lfdr.de>; Sat, 30 May 2020 00:06:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 97300100EAB5B;
	Fri, 29 May 2020 15:02:10 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AF5DE100EAB5B
	for <linux-nvdimm@lists.01.org>; Fri, 29 May 2020 15:02:08 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TM3bqh028026;
	Fri, 29 May 2020 18:06:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1w74vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:33 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04TM57uT034557;
	Fri, 29 May 2020 18:06:33 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 31as1w74va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 18:06:33 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04TM5iYK018906;
	Fri, 29 May 2020 22:06:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf94qwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2020 22:06:30 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04TM5D6856689018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2020 22:05:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07384A4040;
	Fri, 29 May 2020 22:06:28 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959EDA404D;
	Fri, 29 May 2020 22:06:24 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.199.34.115])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Fri, 29 May 2020 22:06:24 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Sat, 30 May 2020 03:36:23 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v5 3/6] libndctl: Introduce new dimm-ops dimm_init() & dimm_uninit()
Date: Sat, 30 May 2020 03:35:57 +0530
Message-Id: <20200529220600.225320-4-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529220600.225320-1-vaibhav@linux.ibm.com>
References: <20200529220600.225320-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_13:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=3 mlxscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290159
Message-ID-Hash: 3X3PA5TOTGEA6ZW6A2AHMR7RCOOBDBIF
X-Message-ID-Hash: 3X3PA5TOTGEA6ZW6A2AHMR7RCOOBDBIF
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3X3PA5TOTGEA6ZW6A2AHMR7RCOOBDBIF/>
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

v4..v5:
* None

v3..v4:
* None

v2..v3:
* None

v1..v2:
* Changed the patch order
---
 ndctl/lib/libndctl.c | 11 +++++++++++
 ndctl/lib/private.h  |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index a52c2e208fbe..8d226abf7495 100644
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
 	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR)
 		dimm->ops = papr_dimm_ops;
 
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
index d90236b1f98b..d0188a97d673 100644
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
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
