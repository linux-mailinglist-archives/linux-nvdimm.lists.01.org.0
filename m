Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7987216336
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 Jul 2020 02:57:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EAEDA1107E169;
	Mon,  6 Jul 2020 17:57:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5673D11075BCF
	for <linux-nvdimm@lists.01.org>; Mon,  6 Jul 2020 17:57:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l6so14433459pjq.1
        for <linux-nvdimm@lists.01.org>; Mon, 06 Jul 2020 17:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qVlv451nr86cMyeANpd21SSFv00C3l5EajJUsc6fBA=;
        b=lgQYrqaKVxNf0glJh1q13xE+RkWs4vp/wgiXO6RZfa9SGjpVsry+P6M2sLDfBEjsh7
         JookpmmwCT2xSQJ+Oq6D+XQ/3kdzhg5QhgPN0gzFXOUZ8JBIotVHGjKp11O2pzXfyVTx
         g913ZUNcYl9wCC9J2jA5O/eLlISyeCEF9DSSZzrizRmnVm8MRCrdeNlgrEm9qjgsBqgu
         4Ty6xzTv57iPu6gI0KDtec03WXWYYvJ3Ogu0lbnNYCYrxgR0FDKNjHxfAOOgW8oB2Ju0
         QJNixv9wS5ADJbzdnr9UStJ9g4jW0GOy8dl6hgXH8KdiuTWqm+NfwDVgFjN+pRB94OVj
         tEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qVlv451nr86cMyeANpd21SSFv00C3l5EajJUsc6fBA=;
        b=egbiphWusXt3QQSF9Jmc1mRBPsWCycdT2uBozvPaNHOuTzricQ3aw+AkUxqm8qpFK7
         kF+1Axhl6UUSOrfm7Wusbq1+rqG7pu5IwMiYoeA5CG1c+DFBWiNqGkwRQzbSfJa0OGEI
         8YQ45E90hQdkuNjhNmg78LhbDBFPK2kU3+k6t5Vo61yzajCs/hgi0GAgfHa1J9MR9ZTO
         tPm4Ubvh2tRD9MqMheJqzoggwHnZAvIDam4r1xRkuJQ7XItNchmTm8EtlFY56eEQ60WO
         4GIraSIziTjBQ1EZbi7IagQvHof3eL1EmnoN2u/63Aw8iOaMPQw2z4Vx/bZI1n8uOTmC
         Rt9g==
X-Gm-Message-State: AOAM533ky9nO/vvgEACEEbdTJkeEk1YsRxQnLMq1ObUc3nvW2ZlB4MRe
	ZEK0ofvFXOdtSM4Q6m2zbnudKzefc4Y=
X-Google-Smtp-Source: ABdhPJw9GvZ5YH3VR+lBgKk6wOVvRt80QAr8F3+MBUf+eWQZQ0D9gg3/XQPmPkoa53V8c8pjeKxUOg==
X-Received: by 2002:a17:90b:1045:: with SMTP id gq5mr1725266pjb.30.1594083430245;
        Mon, 06 Jul 2020 17:57:10 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([203.223.190.240])
        by smtp.gmail.com with ESMTPSA id w1sm20696634pfq.53.2020.07.06.17.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 17:57:09 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH ndctl] infoblock: Set the default alignment to the platform alignment
Date: Tue,  7 Jul 2020 06:26:41 +0530
Message-Id: <20200707005641.3936295-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: DI5DOZXYHBKHHHETQYVDNPUS3SGXXHHC
X-Message-ID-Hash: DI5DOZXYHBKHHHETQYVDNPUS3SGXXHHC
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DI5DOZXYHBKHHHETQYVDNPUS3SGXXHHC/>
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
 ndctl/namespace.c | 56 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/ndctl/namespace.c b/ndctl/namespace.c
index 0550580..4f056b7 100644
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
@@ -1992,12 +2001,36 @@ static int namespace_rw_infoblock(struct ndctl_namespace *ndns,
 	const char *save;
 	const char *cmd = write ? "write-infoblock" : "read-infoblock";
 	const char *devname = ndctl_namespace_get_devname(ndns);
+	unsigned long long align;
 
 	if (ndctl_namespace_is_active(ndns)) {
 		pr_verbose("%s: %s enabled, must be disabled\n", cmd, devname);
 		return -EBUSY;
 	}
 
+	if (write) {
+		if (!param.align) {
+			align = ndctl_get_default_alignment(ndns);
+
+			if (asprintf((char **)&param.align, "%llu", align) < 0) {
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+
+		if (param.size) {
+			unsigned long long size = parse_size64(param.size);
+			align = parse_size64(param.align);
+
+			if (align < ULLONG_MAX && !IS_ALIGNED(size, align)) {
+				error("--size=%s not aligned to %s\n", param.size,
+				      param.align);
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
 	ndctl_namespace_set_raw_mode(ndns, 1);
 	rc = ndctl_namespace_enable(ndns);
 	if (rc < 0) {
@@ -2060,6 +2093,9 @@ static int do_xaction_namespace(const char *namespace,
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
