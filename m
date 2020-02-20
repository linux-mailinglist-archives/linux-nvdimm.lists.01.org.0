Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C81165C2C
	for <lists+linux-nvdimm@lfdr.de>; Thu, 20 Feb 2020 11:52:49 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D7EA910FC3602;
	Thu, 20 Feb 2020 02:53:40 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2C0B010097E1D
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 02:51:25 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01KAoW4c190795
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2y92xe8fk9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Thu, 20 Feb 2020 05:50:30 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <vaibhav@linux.ibm.com>;
	Thu, 20 Feb 2020 10:50:00 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 20 Feb 2020 10:49:57 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01KAnuYu31785048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2020 10:49:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE00A404D;
	Thu, 20 Feb 2020 10:49:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45A7DA4051;
	Thu, 20 Feb 2020 10:49:53 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.199.53.128])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2020 10:49:53 +0000 (GMT)
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH 3/8] libncdtl: Add initial support for NVDIMM_FAMILY_PAPR_SCM dimm family
Date: Thu, 20 Feb 2020 16:19:23 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220104928.198625-1-vaibhav@linux.ibm.com>
References: <20200220104928.198625-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 20022010-0012-0000-0000-0000038891B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022010-0013-0000-0000-000021C52814
Message-Id: <20200220104928.198625-4-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_03:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200079
Message-ID-Hash: OWZGXKLKWLFXB76A2PUWOPTKLM2RZJD7
X-Message-ID-Hash: OWZGXKLKWLFXB76A2PUWOPTKLM2RZJD7
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Alastair D'Silva <alastair@au1.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OWZGXKLKWLFXB76A2PUWOPTKLM2RZJD7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The patch-set adds necessary scaffolding in libndctl for dimms that
support papr_scm specification[1]. Since there can be platforms that
support Open-Firmware[2] but not the papr_scm specification, hence the
changes proposed first add support for probing if the dimm bus
supports Open-Firmware. This is done via querying for sysfs attribute
'of_node' in dimm device sysfs directory. If available newly
introduced member 'struct ndctl_bus.has_of_node' is set.

During the probe of the dimm and execution of add_dimm(), the newly
introduced add_of_pmem_dimm() is called if dimm bus reports supports
Open-Firmware.

Function add_of_pmem_dimm() queries the 'compatible' device tree
attribute and based on its value assign NVDIMM_FAMILY_PAPR_SCM to the
dimm command family. In future based on the contents of 'compatible'
attribute more of_pmem dimm families can be queried.

Presently the dimm-ops implementation for NVDIMM_FAMILY_PAPR_SCM is
available in global variable 'papr_scm_dimm_ops' which is a NULL
pointer. Subsequent patches will provide a working dimm-ops
implementation pointed to by 'papr_scm_dimm_ops'.

References:
[1] : https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=58b278f568f0509497e2df7310bfd719156a60d1
[2] : https://en.wikipedia.org/wiki/Open_Firmware

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 ndctl/lib/libndctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 ndctl/lib/private.h  |  2 ++
 ndctl/libndctl.h     |  1 +
 ndctl/ndctl.h        |  1 +
 4 files changed, 46 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index a5f5fdac9f48..650406d27512 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -858,6 +858,12 @@ static void *add_bus(void *parent, int id, const char *ctl_base)
 		bus->revision = strtoul(buf, NULL, 0);
 	}
 
+	sprintf(path, "%s/device/of_node/compatible", ctl_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		bus->has_of_node = 0;
+	else
+		bus->has_of_node = 1;
+
 	sprintf(path, "%s/device/nfit/dsm_mask", ctl_base);
 	if (sysfs_read_attr(ctx, path, buf) < 0)
 		bus->nfit_dsm_mask = 0;
@@ -966,6 +972,10 @@ NDCTL_EXPORT int ndctl_bus_has_nfit(struct ndctl_bus *bus)
 	return bus->has_nfit;
 }
 
+NDCTL_EXPORT int ndctl_bus_has_of_node(struct ndctl_bus *bus)
+{
+	return bus->has_of_node;
+}
 /**
  * ndctl_bus_get_major - nd bus character device major number
  * @bus: ndctl_bus instance returned from ndctl_bus_get_{first|next}
@@ -1405,6 +1415,34 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
+static int add_of_pmem_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
+{
+	int rc = -ENODEV;
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+
+	dbg(ctx, "Probing of_pmem dimm %d at %s\n", dimm->id, dimm_base);
+
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "%s/../of_node/compatible", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto out;
+
+
+	dbg(ctx, "Compatible of_pmem dimm %d at %s\n", dimm->id, buf);
+	if (strcmp(buf, "ibm,pmemory") == 0) {
+		dimm->cmd_family = NVDIMM_FAMILY_PAPR_SCM;
+		rc = 0;
+		goto out;
+	}
+out:
+	free(path);
+	return rc;
+}
+
 static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 {
 	int i, rc = -1;
@@ -1583,6 +1621,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	if (ndctl_bus_has_nfit(bus)) {
 		dimm->formats = formats;
 		rc = add_nfit_dimm(dimm, dimm_base);
+	} else if (ndctl_bus_has_of_node(bus)) {
+		rc = add_of_pmem_dimm(dimm, dimm_base);
 	}
 
 	if (rc == -ENODEV) {
@@ -1600,6 +1640,8 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 		dimm->ops = msft_dimm_ops;
 	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
 		dimm->ops = hyperv_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_PAPR_SCM)
+		dimm->ops = papr_scm_dimm_ops;
 
 	/* Call the dimm initialization function if needed */
 	if (!rc && dimm->ops && dimm->ops->dimm_init)
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index fb7fa47f1f37..16754eda7634 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -167,6 +167,7 @@ struct ndctl_bus {
 	int dimms_init;
 	int regions_init;
 	int has_nfit;
+	int has_of_node;
 	char *bus_path;
 	char *bus_buf;
 	size_t buf_len;
@@ -351,6 +352,7 @@ struct ndctl_dimm_ops * const intel_dimm_ops;
 struct ndctl_dimm_ops * const hpe1_dimm_ops;
 struct ndctl_dimm_ops * const msft_dimm_ops;
 struct ndctl_dimm_ops * const hyperv_dimm_ops;
+struct ndctl_dimm_ops * const papr_scm_dimm_ops;
 
 static inline struct ndctl_bus *cmd_to_bus(struct ndctl_cmd *cmd)
 {
diff --git a/ndctl/libndctl.h b/ndctl/libndctl.h
index 9a53049e7f61..32202654885a 100644
--- a/ndctl/libndctl.h
+++ b/ndctl/libndctl.h
@@ -119,6 +119,7 @@ struct ndctl_bus *ndctl_bus_get_next(struct ndctl_bus *bus);
              bus = ndctl_bus_get_next(bus))
 struct ndctl_ctx *ndctl_bus_get_ctx(struct ndctl_bus *bus);
 int ndctl_bus_has_nfit(struct ndctl_bus *bus);
+int ndctl_bus_has_of_node(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_major(struct ndctl_bus *bus);
 unsigned int ndctl_bus_get_minor(struct ndctl_bus *bus);
 const char *ndctl_bus_get_devname(struct ndctl_bus *bus);
diff --git a/ndctl/ndctl.h b/ndctl/ndctl.h
index 008f81cdeb9f..426708e1fd9b 100644
--- a/ndctl/ndctl.h
+++ b/ndctl/ndctl.h
@@ -263,6 +263,7 @@ struct nd_cmd_pkg {
 #define NVDIMM_FAMILY_HPE2 2
 #define NVDIMM_FAMILY_MSFT 3
 #define NVDIMM_FAMILY_HYPERV 4
+#define NVDIMM_FAMILY_PAPR_SCM 5
 
 #define ND_IOCTL_CALL			_IOWR(ND_IOCTL, ND_CMD_CALL,\
 					struct nd_cmd_pkg)
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
