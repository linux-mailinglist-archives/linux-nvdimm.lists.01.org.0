Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3B1E377F
	for <lists+linux-nvdimm@lfdr.de>; Wed, 27 May 2020 06:48:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A99871225F25F;
	Tue, 26 May 2020 21:44:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 633201225F261
	for <linux-nvdimm@lists.01.org>; Tue, 26 May 2020 21:44:18 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04R4V8jp086713;
	Wed, 27 May 2020 00:48:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com with ESMTP id 316wysdqwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:23 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04R4jbce133350;
	Wed, 27 May 2020 00:48:23 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 316wysdqvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 00:48:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04R4jKmY022370;
	Wed, 27 May 2020 04:48:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
	by ppma04ams.nl.ibm.com with ESMTP id 316uf8y5pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2020 04:48:21 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04R4mI4f43581822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2020 04:48:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00F3A4057;
	Wed, 27 May 2020 04:48:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C298EA4053;
	Wed, 27 May 2020 04:48:12 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.121.50])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
	Wed, 27 May 2020 04:48:12 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Wed, 27 May 2020 10:18:10 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org
Subject: [ndctl PATCH v4 1/6] libndctl: Refactor out add_dimm() to handle NFIT specific init
Date: Wed, 27 May 2020 10:17:32 +0530
Message-Id: <20200527044737.40615-2-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527044737.40615-1-vaibhav@linux.ibm.com>
References: <20200527044737.40615-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_04:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=3 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005270028
Message-ID-Hash: 6D4IMLUQOLWEXB7FMWSSNSOCIGT7UDEL
X-Message-ID-Hash: 6D4IMLUQOLWEXB7FMWSSNSOCIGT7UDEL
X-MailFrom: vaibhav@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Vaibhav Jain <vaibhav@linux.ibm.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6D4IMLUQOLWEXB7FMWSSNSOCIGT7UDEL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Presently add_dimm() only probes dimms that support NFIT/ACPI. Hence
this patch refactors this functionality into two functions namely
add_dimm() and add_nfit_dimm(). Function add_dimm() performs
allocation and common 'struct ndctl_dimm' initialization and depending
on whether the dimm-bus supports NIFT, calls add_nfit_dimm(). Once
the probe is completed based on the value of 'ndctl_dimm.cmd_family'
appropriate dimm-ops are assigned to the dimm.

In case dimm-bus is of unknown type or doesn't support NFIT the
initialization still continues, with no dimm-ops assigned to the
'struct ndctl_dimm' there-by limiting the functionality available.

This patch shouldn't introduce any behavioral change.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog:

v3..v4:
* None

v2..v3:
* None

v1..v2:
* None
---
 ndctl/lib/libndctl.c | 193 +++++++++++++++++++++++++------------------
 1 file changed, 112 insertions(+), 81 deletions(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ee737cbbfe3e..d76dbf7e17de 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1441,82 +1441,15 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
-static void *add_dimm(void *parent, int id, const char *dimm_base)
+static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 {
-	int formats, i;
-	struct ndctl_dimm *dimm;
+	int i, rc = -1;
 	char buf[SYSFS_ATTR_SIZE];
-	struct ndctl_bus *bus = parent;
-	struct ndctl_ctx *ctx = bus->ctx;
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
 	char *path = calloc(1, strlen(dimm_base) + 100);
 
 	if (!path)
-		return NULL;
-
-	sprintf(path, "%s/nfit/formats", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		formats = 1;
-	else
-		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
-
-	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
-	if (!dimm)
-		goto err_dimm;
-	dimm->bus = bus;
-	dimm->id = id;
-
-	sprintf(path, "%s/dev", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	if (sscanf(buf, "%d:%d", &dimm->major, &dimm->minor) != 2)
-		goto err_read;
-
-	sprintf(path, "%s/commands", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	dimm->cmd_mask = parse_commands(buf, 1);
-
-	dimm->dimm_buf = calloc(1, strlen(dimm_base) + 50);
-	if (!dimm->dimm_buf)
-		goto err_read;
-	dimm->buf_len = strlen(dimm_base) + 50;
-
-	dimm->dimm_path = strdup(dimm_base);
-	if (!dimm->dimm_path)
-		goto err_read;
-
-	sprintf(path, "%s/modalias", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0)
-		goto err_read;
-	dimm->module = to_module(ctx, buf);
-
-	dimm->handle = -1;
-	dimm->phys_id = -1;
-	dimm->serial = -1;
-	dimm->vendor_id = -1;
-	dimm->device_id = -1;
-	dimm->revision_id = -1;
-	dimm->health_eventfd = -1;
-	dimm->dirty_shutdown = -ENOENT;
-	dimm->subsystem_vendor_id = -1;
-	dimm->subsystem_device_id = -1;
-	dimm->subsystem_revision_id = -1;
-	dimm->manufacturing_date = -1;
-	dimm->manufacturing_location = -1;
-	dimm->cmd_family = -1;
-	dimm->nfit_dsm_mask = ULONG_MAX;
-	for (i = 0; i < formats; i++)
-		dimm->format[i] = -1;
-
-	sprintf(path, "%s/flags", dimm_base);
-	if (sysfs_read_attr(ctx, path, buf) < 0) {
-		dimm->locked = -1;
-		dimm->aliased = -1;
-	} else
-		parse_dimm_flags(dimm, buf);
-
-	if (!ndctl_bus_has_nfit(bus))
-		goto out;
+		return -1;
 
 	/*
 	 * 'unique_id' may not be available on older kernels, so don't
@@ -1582,24 +1515,15 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	sprintf(path, "%s/nfit/family", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->cmd_family = strtoul(buf, NULL, 0);
-	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
-		dimm->ops = intel_dimm_ops;
-	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
-		dimm->ops = hpe1_dimm_ops;
-	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
-		dimm->ops = msft_dimm_ops;
-	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
-		dimm->ops = hyperv_dimm_ops;
 
 	sprintf(path, "%s/nfit/dsm_mask", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->nfit_dsm_mask = strtoul(buf, NULL, 0);
 
-	dimm->formats = formats;
 	sprintf(path, "%s/nfit/format", dimm_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		dimm->format[0] = strtoul(buf, NULL, 0);
-	for (i = 1; i < formats; i++) {
+	for (i = 1; i < dimm->formats; i++) {
 		sprintf(path, "%s/nfit/format%d", dimm_base, i);
 		if (sysfs_read_attr(ctx, path, buf) == 0)
 			dimm->format[i] = strtoul(buf, NULL, 0);
@@ -1610,7 +1534,114 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 		parse_nfit_mem_flags(dimm, buf);
 
 	dimm->health_eventfd = open(path, O_RDONLY|O_CLOEXEC);
+	rc = 0;
+ err_read:
+
+	free(path);
+	return rc;
+}
+
+static void *add_dimm(void *parent, int id, const char *dimm_base)
+{
+	int formats, i, rc = -ENODEV;
+	struct ndctl_dimm *dimm = NULL;
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_bus *bus = parent;
+	struct ndctl_ctx *ctx = bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+
+	if (!path)
+		return NULL;
+
+	sprintf(path, "%s/nfit/formats", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		formats = 1;
+	else
+		formats = clamp(strtoul(buf, NULL, 0), 1UL, 2UL);
+
+	dimm = calloc(1, sizeof(*dimm) + sizeof(int) * formats);
+	if (!dimm)
+		goto err_dimm;
+	dimm->bus = bus;
+	dimm->id = id;
+
+	sprintf(path, "%s/dev", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	if (sscanf(buf, "%d:%d", &dimm->major, &dimm->minor) != 2)
+		goto err_read;
+
+	sprintf(path, "%s/commands", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	dimm->cmd_mask = parse_commands(buf, 1);
+
+	dimm->dimm_buf = calloc(1, strlen(dimm_base) + 50);
+	if (!dimm->dimm_buf)
+		goto err_read;
+	dimm->buf_len = strlen(dimm_base) + 50;
+
+	dimm->dimm_path = strdup(dimm_base);
+	if (!dimm->dimm_path)
+		goto err_read;
+
+	sprintf(path, "%s/modalias", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	dimm->module = to_module(ctx, buf);
+
+	dimm->handle = -1;
+	dimm->phys_id = -1;
+	dimm->serial = -1;
+	dimm->vendor_id = -1;
+	dimm->device_id = -1;
+	dimm->revision_id = -1;
+	dimm->health_eventfd = -1;
+	dimm->dirty_shutdown = -ENOENT;
+	dimm->subsystem_vendor_id = -1;
+	dimm->subsystem_device_id = -1;
+	dimm->subsystem_revision_id = -1;
+	dimm->manufacturing_date = -1;
+	dimm->manufacturing_location = -1;
+	dimm->cmd_family = -1;
+	dimm->nfit_dsm_mask = ULONG_MAX;
+	for (i = 0; i < formats; i++)
+		dimm->format[i] = -1;
+
+	sprintf(path, "%s/flags", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0) {
+		dimm->locked = -1;
+		dimm->aliased = -1;
+	} else
+		parse_dimm_flags(dimm, buf);
+
+	/* Check if the given dimm supports nfit */
+	if (ndctl_bus_has_nfit(bus)) {
+		dimm->formats = formats;
+		rc = add_nfit_dimm(dimm, dimm_base);
+	}
+
+	if (rc == -ENODEV) {
+		/* Unprobed dimm with no family */
+		rc = 0;
+		goto out;
+	}
+
+	/* Assign dimm-ops based on command family */
+	if (dimm->cmd_family == NVDIMM_FAMILY_INTEL)
+		dimm->ops = intel_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_HPE1)
+		dimm->ops = hpe1_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_MSFT)
+		dimm->ops = msft_dimm_ops;
+	if (dimm->cmd_family == NVDIMM_FAMILY_HYPERV)
+		dimm->ops = hyperv_dimm_ops;
  out:
+	if (rc) {
+		err(ctx, "Unable to probe dimm:%d. Err:%d\n", id, rc);
+		goto err_read;
+	}
+
 	list_add(&bus->dimms, &dimm->list);
 	free(path);
 
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
