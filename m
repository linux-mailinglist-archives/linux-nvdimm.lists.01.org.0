Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAB3222B38
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 Jul 2020 20:47:52 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F2E1811078324;
	Thu, 16 Jul 2020 11:47:50 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 815F011571BF7
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 11:47:48 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIb2sO145393;
	Thu, 16 Jul 2020 18:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=WpfOXvX7LXsNP4LILznAi2fO63aacseY0ywwvmou1xI=;
 b=FPTP54iIJtsrTVwzTBYipn+QxZEQQj37OfFEV4FKIJ0jjrt6BYXDxf/mxzmWtTVISpnb
 T/2A+Z9h5X5z93poZ8UuxHYYOd3jCpP8k9F0bi9D4jYTHlmTNV3PFDZjpUdi08DfKg+w
 OwI8JobweB4fyzmqiNRtMrNmyaTrR5eV4SKovclLXcGfCQqdoBGk3PjMi57Q4mXL1mS8
 cgbN4GuoKe8ah3YNvRc8CSw0Zwsz1bT/GwIlwuoO8+CMMAwDA2/WXaY6geftzx7gajQI
 v2w6Ld5VQmkRf4yVProJvEwdOjSi+mX/1sonZrmNfXha3Nw15JQZjARATaDWnRjW+YXZ 3Q==
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
	by aserp2120.oracle.com with ESMTP id 3275cmk6kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2020 18:47:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
	by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIclST189117;
	Thu, 16 Jul 2020 18:47:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3030.oracle.com with ESMTP id 327qc3yawp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jul 2020 18:47:45 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06GIlirE007494;
	Thu, 16 Jul 2020 18:47:45 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Thu, 16 Jul 2020 11:47:44 -0700
From: Joao Martins <joao.m.martins@oracle.com>
To: linux-nvdimm@lists.01.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v1 7/8] libdaxctl: add daxctl_dev_set_mapping()
Date: Thu, 16 Jul 2020 19:47:06 +0100
Message-Id: <20200716184707.23018-8-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200716184707.23018-1-joao.m.martins@oracle.com>
References: <20200716184707.23018-1-joao.m.martins@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160131
Message-ID-Hash: 6OB2557GSKZRRU7A5CBP3YSTL3ZEKZQU
X-Message-ID-Hash: 6OB2557GSKZRRU7A5CBP3YSTL3ZEKZQU
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6OB2557GSKZRRU7A5CBP3YSTL3ZEKZQU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This API adds the ability to manually pick a range within the region
device.  Such routine allows for a admin to restore the mappings of a
device after kexec. This is specially useful for hmem dynamic devdax
which do not persistent ranges allocation through say a e.g. namespace
label storage area. It also allows an userspace application to pick
it's own ranges, should it want to avoid relying on kernel's policy.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 daxctl/lib/libdaxctl.c   | 27 +++++++++++++++++++++++++++
 daxctl/lib/libdaxctl.sym |  1 +
 daxctl/libdaxctl.h       |  2 ++
 3 files changed, 30 insertions(+)

diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
index 506cf4b93236..3992ae733b16 100644
--- a/daxctl/lib/libdaxctl.c
+++ b/daxctl/lib/libdaxctl.c
@@ -1121,6 +1121,33 @@ DAXCTL_EXPORT int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long ali
 	return 0;
 }
 
+DAXCTL_EXPORT int daxctl_dev_set_mapping(struct daxctl_dev *dev,
+					unsigned long long start,
+					unsigned long long end)
+{
+	struct daxctl_ctx *ctx = daxctl_dev_get_ctx(dev);
+	unsigned long long size = end - start + 1;
+	char buf[SYSFS_ATTR_SIZE];
+	char *path = dev->dev_buf;
+	int len = dev->buf_len;
+
+	if (snprintf(path, len, "%s/mapping", dev->dev_path) >= len) {
+		err(ctx, "%s: buffer too small!\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+
+	sprintf(buf, "%#llx-%#llx\n", start, end);
+	if (sysfs_write_attr(ctx, path, buf) < 0) {
+		err(ctx, "%s: failed to set mapping\n",
+				daxctl_dev_get_devname(dev));
+		return -ENXIO;
+	}
+	dev->size += size;
+
+	return 0;
+}
+
 DAXCTL_EXPORT int daxctl_dev_get_target_node(struct daxctl_dev *dev)
 {
 	return dev->target_node;
diff --git a/daxctl/lib/libdaxctl.sym b/daxctl/lib/libdaxctl.sym
index 08362b683678..a4e16848494b 100644
--- a/daxctl/lib/libdaxctl.sym
+++ b/daxctl/lib/libdaxctl.sym
@@ -89,4 +89,5 @@ global:
 	daxctl_mapping_get_end;
 	daxctl_mapping_get_offset;
 	daxctl_mapping_get_size;
+	daxctl_dev_set_mapping;
 } LIBDAXCTL_7;
diff --git a/daxctl/libdaxctl.h b/daxctl/libdaxctl.h
index f94a72fed85b..09439c16d6df 100644
--- a/daxctl/libdaxctl.h
+++ b/daxctl/libdaxctl.h
@@ -73,6 +73,8 @@ unsigned long long daxctl_dev_get_size(struct daxctl_dev *dev);
 int daxctl_dev_set_size(struct daxctl_dev *dev, unsigned long long size);
 unsigned long daxctl_dev_get_align(struct daxctl_dev *dev);
 int daxctl_dev_set_align(struct daxctl_dev *dev, unsigned long align);
+int daxctl_dev_set_mapping(struct daxctl_dev *dev, unsigned long long start,
+			unsigned long long end);
 struct daxctl_ctx *daxctl_dev_get_ctx(struct daxctl_dev *dev);
 int daxctl_dev_is_enabled(struct daxctl_dev *dev);
 int daxctl_dev_disable(struct daxctl_dev *dev);
-- 
1.8.3.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
