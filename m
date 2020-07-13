Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A643521DB3E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 13 Jul 2020 18:09:08 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 798B1118128FC;
	Mon, 13 Jul 2020 09:09:07 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E8AFB118128FC
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jul 2020 09:09:05 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG2rT5153758;
	Mon, 13 Jul 2020 16:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=DSaZ5xiy1IGYoySsmTYVslGcVar1nxmLVGY9gmsigYk=;
 b=reK1eDdctPNpqtMbzm6fU1OTnNxuetsuEjudV3Cy/NfEg8RGGssRHXpp9gFcDKrmu1DM
 2myo0iDM2+62PER7Gjj8CRjfrsFnSm5J88T/zDmMtQr/j0eTO8l+RcyyPLRcXQ8ADIZZ
 5IVmkv7LoFW4zy9vwaY6yFrSnZ/JlC9zjtZX+n6F71aSRK0dLCSkCMYKzuzFGxkT27n5
 SaKScyvMqnVjE2K8rab0UJ1XzdQvd1iIibT/DMx/GkeZS4ohVArP1osy7iRNpizfolav
 nsoGTM733I4Tey/k8IJICYAEnGypg1ZizXVOV3Esv9HoPoSjFlMTQFIV/JbWEpgHfzdU Bg==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by userp2120.oracle.com with ESMTP id 32762n7v31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2020 16:09:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06DG4b1c008161;
	Mon, 13 Jul 2020 16:09:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 327qbvu20k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2020 16:09:03 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06DG93xa012084;
	Mon, 13 Jul 2020 16:09:03 GMT
Received: from paddy.uk.oracle.com (/10.175.167.147)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 13 Jul 2020 09:09:02 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2 06/10] libdaxctl: add daxctl_region_create_dev()
Date: Mon, 13 Jul 2020 17:08:33 +0100
Message-Id: <20200713160837.13774-7-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200713160837.13774-1-joao.m.martins@oracle.com>
References: <20200713160837.13774-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9681 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=1 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130119
Message-ID-Hash: OQKKRLE5MZHDCECNWCDGEW3OXXGWY5IT
X-Message-ID-Hash: OQKKRLE5MZHDCECNWCDGEW3OXXGWY5IT
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/OQKKRLE5MZHDCECNWCDGEW3OXXGWY5IT/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add an API to create an empty seed device.

This sysfs attribute is only writeable for a dynamic
dax device such as the one exported by hmem.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 daxctl/lib/libdaxctl.c   | 26 ++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  1 +
 3 files changed, 28 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 00d5f7fe61ad..d17ff7a02bad 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -583,6 +583,32 @@ DAXCTL_EXPORT unsigned long long daxctl_region_get_available_size(
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_region_create_dev(struct daxctl_region *region)
+{
+	struct daxctl_ctx *ctx = daxctl_region_get_ctx(region);
+	char *path = region->region_buf;
+	int rc, len = region->buf_len;
+	char *num_devices;
+
+	if (snprintf(path, len, "%s/%s/create", region->region_path, attrs) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_region_get_devname(region));
+		return -EFAULT;
+	}
+
+	if (asprintf(&num_devices, "%d", 1) < 0) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_region_get_devname(region));
+		return -EFAULT;
+	}
+
+	rc = sysfs_write_attr(ctx, path, num_devices);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 DAXCTL_EXPORT struct daxctl_dev *daxctl_region_get_dev_seed(
 		struct daxctl_region *region)
 {
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index d8b4137c76b7..26987ba021ab 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -79,4 +79,5 @@ global:
 LIBDAXCTL_8 {
 global:
 	daxctl_dev_set_size;
+	daxctl_region_create_dev;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index e3d482743cc6..a579ddd1d43c 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -56,6 +56,7 @@ unsigned long daxctl_region_get_align(struct daxctl_region *region);
 const char *daxctl_region_get_devname(struct daxctl_region *region);
 const char *daxctl_region_get_path(struct daxctl_region *region);
 
+int daxctl_region_create_dev(struct daxctl_region *region);
 struct daxctl_dev *daxctl_region_get_dev_seed(struct daxctl_region *region);
 
 struct daxctl_dev;
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
