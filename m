Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE7218576
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 Jul 2020 13:04:09 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1D9B5110F2E12;
	Wed,  8 Jul 2020 04:04:08 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 816D3110E5FDC
	for <linux-nvdimm@lists.01.org>; Wed,  8 Jul 2020 04:04:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so1036181pjb.1
        for <linux-nvdimm@lists.01.org>; Wed, 08 Jul 2020 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwAfytvZIH3aCQajOLWA71Tkle4RddoyjqGapiOw19w=;
        b=Lo9fKvuAsNJ1EyjdE0WX5eo+8jXZ6QPRYET64IGtnJbyQ0SlLgaDy3eX21iTtZR9eL
         3Z55QSPn3A9z4wCMp582MV3rxVQOkV85Y1hFQ0lQjcBm+3oAyPbI52MKFuSY5QuAioLN
         7wPS+WnKNQK6Ix9VZupBa9at8aGs7W+L9X1GAL+RrOxu8uz26NL5K7XrkBQ3DsVsWKno
         Q55MAIM8d1Pc9SV0X3vI9H2WEbS2+Y/HvcjDbhAqVH9Lxgs/8GDK7bGSui8xWt79sXiR
         Vgp1JnH9FSq5pyr7/cuE7n9lDnSkLbtjYVpoYsQjnBg8wHRAb9bg3c5Sfham/4vK+Rzx
         JcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iwAfytvZIH3aCQajOLWA71Tkle4RddoyjqGapiOw19w=;
        b=oGl6BOPyKWF/+gMT9LWFafG0avQcEbU7NjO5og2x29G99vQwZG0YMaua5Fm82gW02T
         ePzxoyjrUPLSfkKPZTeCbNhWK+TTFSVwfFJ8ReNjYGj0KBxjEhsmjSOT/y3DryMzkrx2
         8uPLUdcyc2BXmpWBO+X+y0Y7BPOmGhlWVOggtfDAlEXx4SRW1gZl2/wk45mlNukjXNjC
         1rUIcOjpFhGXvZPSM44BsfRzUHqwKT8qIw33rZg2kJHgB41+kQoxoIZIVuvrlKi3CtTF
         vcjT5CSkD7EQLL6/BEaaaPalCWgTAg8RCPtaSfipk1x6p8R3IarSF6+ZeWNKI74GXJGI
         yr9w==
X-Gm-Message-State: AOAM533aNxeXhaNX3Db3TBfMSKTN4jQF5onOWE7fzvMGpU4KvuFCQP7+
	fSRn9mnSuiZRv4abCoquu4+r+4li3OA=
X-Google-Smtp-Source: ABdhPJyiY7dd/HbfMIgtFkQhM3syLQPYgklDbWd+yRwgRKTbskJs9kY/bdI+7jr7qusXztQhkNX82A==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr14847824pls.38.1594206243726;
        Wed, 08 Jul 2020 04:04:03 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id u14sm26738672pfk.211.2020.07.08.04.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:04:02 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl v2] infoblock: Set the default alignment to the platform alignment
Date: Wed,  8 Jul 2020 16:33:06 +0530
Message-Id: <20200708110306.279976-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: ZEFHBBZLXPR5FLA4H26JTMSDJV7I7TVE
X-Message-ID-Hash: ZEFHBBZLXPR5FLA4H26JTMSDJV7I7TVE
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZEFHBBZLXPR5FLA4H26JTMSDJV7I7TVE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The default alignment for write-infoblock command is set to 2M. Change
that to use the platform's supported alignment or PAGE_SIZE. The first
supported alignment is taken as the default.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/namespace.c | 69 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 13 deletions(-)

v2: Get the 'write-infoblock all' path right [Ira]

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0550580..8aa5a42 100644
--- a/ndctl/namespace.c
+++ b/ndctl/namespace.c
@@ -175,7 +175,7 @@ OPT_STRING('m', "mode", &param.mode, "operation-mode", \
 OPT_STRING('s', "size", &param.size, "size", \
 	"override the image size to instantiate the infoblock"), \
 OPT_STRING('a', "align", &param.align, "align", \
-	"specify the expected physical alignment (default: 2M)"), \
+	"specify the expected physical alignment"), \
 OPT_STRING('u', "uuid", &param.uuid, "uuid", \
 	"specify the uuid for the infoblock (default: autogenerate)"), \
 OPT_STRING('M', "map", &param.map, "memmap-location", \
@@ -325,23 +325,15 @@ static int set_defaults(enum device_action action)
 					sysconf(_SC_PAGE_SIZE));
 			rc = -EINVAL;
 		}
-	} else if (action == ACTION_WRITE_INFOBLOCK)
-		param.align = "2M";
+	}
 
 	if (param.size) {
 		unsigned long long size = parse_size64(param.size);
-		unsigned long long align = parse_size64(param.align);
 
 		if (size == ULLONG_MAX) {
 			error("failed to parse namespace size '%s'\n",
 					param.size);
 			rc = -EINVAL;
-		} else if (action == ACTION_WRITE_INFOBLOCK
-				&& align < ULLONG_MAX
-				&& !IS_ALIGNED(size, align)) {
-			error("--size=%s not aligned to %s\n", param.size,
-					param.align);
-			rc = -EINVAL;
 		}
 	}
 
@@ -1982,6 +1974,23 @@ out:
 	return rc;
 }
 
+static unsigned long ndctl_get_default_alignment(struct ndctl_namespace *ndns)
+{
+	unsigned long long align = 0;
+	struct ndctl_dax *dax = ndctl_namespace_get_dax(ndns);
+	struct ndctl_pfn *pfn = ndctl_namespace_get_pfn(ndns);
+
+	if (ndctl_namespace_get_mode(ndns) == NDCTL_NS_MODE_FSDAX && pfn)
+		align = ndctl_pfn_get_supported_alignment(pfn, 1);
+	else if (ndctl_namespace_get_mode(ndns) == NDCTL_NS_MODE_DEVDAX && dax)
+		align = ndctl_dax_get_supported_alignment(dax, 1);
+
+	if (!align)
+		align =  sysconf(_SC_PAGE_SIZE);
+
+	return align;
+}
+
 static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
 		struct read_infoblock_ctx *ri_ctx, int write)
 {
@@ -2013,9 +2022,40 @@ static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
 	}
 
 	sprintf(path, "/dev/%s", ndctl_namespace_get_block_device(ndns));
-	if (write)
-		rc = file_write_infoblock(path);
-	else
+	if (write) {
+		unsigned long long align;
+		bool align_provided = true;
+
+		if (!param.align) {
+			align = ndctl_get_default_alignment(ndns);
+
+			if (asprintf((char **)&param.align, "%llu", align) < 0) {
+				rc = -EINVAL;
+				goto out;
+			}
+			align_provided = false;
+		}
+
+		if (param.size) {
+			unsigned long long size = parse_size64(param.size);
+			align = parse_size64(param.align);
+
+			if (align < ULLONG_MAX && !IS_ALIGNED(size, align)) {
+				error("--size=%s not aligned to %s\n", param.size,
+					param.align);
+
+				rc = -EINVAL;
+			}
+		}
+
+		if (!rc)
+			rc = file_write_infoblock(path);
+
+		if (!align_provided) {
+			free((char *)param.align);
+			param.align = NULL;
+		}
+	} else
 		rc = file_read_infoblock(path, ndns, ri_ctx);
 	param.parent_uuid = save;
 out:
@@ -2060,6 +2100,9 @@ static int do_xaction_namespace(const char *namespace,
 	}
 
 	if (action == ACTION_WRITE_INFOBLOCK && !namespace) {
+		if (!param.align)
+			param.align = "2M";
+
 		rc = file_write_infoblock(param.outfile);
 		if (rc >= 0)
 			(*processed)++;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
