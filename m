Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C8165C24
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:52:00 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 525CC10FC35B7;
	Thu, 20 Feb 2020 02:52:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D18B310FC35B0
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:50:50 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAnYEj021110
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:49:57 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubv29st-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:49:57 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:49:55 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
	by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:49:54 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAnqMP40042980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:49:52 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C73BAA404D;
	Thu, 20 Feb 2020 10:49:52 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCD8DA4040;
	Thu, 20 Feb 2020 10:49:49 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:49:49 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 2/8] libndctl: Introduce a new dimm-ops dimm_init() & dimm_uninit()
Date: Thu, 20 Feb 2020 16:19:22 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0008-0000-0000-00000354B665
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0009-0000-0000-00004A75C5EB
Message-Id: <20200220104928.198625-3-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_03:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=853 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002200080
Message-ID-Hash: RHDUOJA5GKOVETKIW4G4R2QIIESXFCAA
X-Message-ID-Hash: RHDUOJA5GKOVETKIW4G4R2QIIESXFCAA
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RHDUOJA5GKOVETKIW4G4R2QIIESXFCAA/>
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

Unfortunately currently in libnvdimm there is no easiy way to implement
this. Even if this data is some how store in an overloaded field of
'struct ndctl_dimm', managing its lifetime is a challenge.

To solve this problem this patch proposes a new member 'struct
ndctl_dimm.dimm_user_data' to store per-dimm data thats specific to a
dimm-provider. Also two new dimm-ops namely dimm_init() &
dimm_uninit() are introduced that can be used to manage the lifetime
of this per-dimm data.

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
 ndctl/lib/libndctl.c | 13 ++++++++++++-
 ndctl/lib/private.h  |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 38ddfea6dbc0..a5f5fdac9f48 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -596,6 +596,10 @@ static void free_dimm(struct ndctl_dimm *dimm)
 {
 	if (!dimm)
 		return;
+	/* If needed call the dimm uninitialization function */
+	if (dimm->ops && dimm->ops->dimm_uninit)
+		dimm->ops->dimm_uninit(dimm);
+
 	free(dimm->unique_id);
 	free(dimm->dimm_buf);
 	free(dimm->dimm_path);
@@ -1596,8 +1600,15 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 		dimm->ops = msft_dimm_ops;
 	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
 		dimm->ops = hyperv_dimm_ops;
- out:
+
+	/* Call the dimm initialization function if needed */
+	if (!rc && dimm->ops && dimm->ops->dimm_init)
+		rc = dimm->ops->dimm_init(dimm);
+
+out:
 	if (rc) {
+		/* Ensure dimm_uninit() is not called during free_dimm() */
+		dimm->ops = NULL;
 		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
 		goto err_read;
 	}
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 1f6a01c55377..fb7fa47f1f37 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -98,6 +98,7 @@ struct ndctl_dimm {
 	} flags;
 	int locked;
 	int aliased;
+	void *dimm_user_data;
 	struct list_node list;
 	int formats;
 	int format[0];
@@ -340,6 +341,10 @@ struct ndctl_dimm_ops {
 	struct ndctl_cmd *(*new_ack_shutdown_count)(struct ndctl_dimm *);
 	int (*fw_update_supported)(struct ndctl_dimm *);
 	int (*xlat_firmware_status)(struct ndctl_cmd *);
+	/* Called just after dimm is initialized and probed */
+	int (*dimm_init)(struct ndctl_dimm *);
+	/* Called just before struct ndctl_dimm is de-allocated */
+	void (*dimm_uninit)(struct ndctl_dimm *);
 };
 
 struct ndctl_dimm_ops * const intel_dimm_ops;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
