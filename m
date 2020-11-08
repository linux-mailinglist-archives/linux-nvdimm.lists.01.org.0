Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BB62AAAF9
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 13:20:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 518AB16217BC3;
	Sun,  8 Nov 2020 04:20:39 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 38A2516217BBF
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 04:20:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id t22so3185441plr.9
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 04:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQwLZLKD6HocBPS2DbKc32lGl6dpSfyr192+yp3q1yI=;
        b=BPKRyQK7/Ajm46jxa84FoWiLwFxhuq0HVrr1xr17ZXzdEh4zxR7IjdU6fTtyre5GoN
         hYfcUBqwL3s955dVIpsXQEnSxHXn9EEywtqnB5SdlbcCyBW3pF7i4WZTU1vtzBFwnHTN
         9Vlg9jIwTTgBSOPeQZx3cbsFqr72XycSc/GKM1cjylu1c3JHyxNHWXRD3lpxlCent59m
         rHyIoWfoUNcWUkiB+to0zaT3WFAicNQsveibAQssC50DugHwxqKUhDgjQy2mINeLZ430
         SHJh4YASQnRqfvgiI5ZkfZEo+d1GPUIWkc1IyYo1ImmTb2q1acLs9ESxqqE/xKhVVMig
         XRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQwLZLKD6HocBPS2DbKc32lGl6dpSfyr192+yp3q1yI=;
        b=GIVFHwSHFbnFv0JBIf7GXkETodhcpVCjZcuvWC4bHN9CUfLjNv7vOAs7Btth8NvtMo
         +CnQZH+NzSNS32h5snaHJeFMk9Z4jpfc2VZLSftkBDt0/1VfyY1CUrmPIh4XEmH1iHSl
         LTIXt9YaDZhtEotiK3yUR+7Sx8CA+UNl0nwhLdZHL7uqJTGnzmCDV3LFpHeFZrPnzaFK
         heyWIgxl1ZArayBfUJ6RB1S3G+HmlO9JTuA8hROobN9ThaXBiMlRZfHrK+/FSziwb8+n
         muOdHlqGyolMQQ46mXb7V3Uod5dFAQmS1mWu4NhQosTCzNKqoXCQN0wcGLENlLLcxSX8
         M61Q==
X-Gm-Message-State: AOAM533Lq0J2ys3vkzwlL6u9JQ/mBQ/UrLHmx81S9ESdxN+LBeu7SeDX
	swRuInG12bn3ijM0PkBlxPoR5kiEqXy9QQ==
X-Google-Smtp-Source: ABdhPJzvNeZr0wbguDMgeJbhYaEDijiLmENu4P+AqwJbrztpnltAeu+x7R1R+IWQrt9h/zjgH9r6Dg==
X-Received: by 2002:a17:90a:34cd:: with SMTP id m13mr8172653pjf.201.1604838035697;
        Sun, 08 Nov 2020 04:20:35 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id e7sm7441282pge.51.2020.11.08.04.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 04:20:35 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v4 1/3] libndctl: test enablement for non-nfit devices
Date: Sun,  8 Nov 2020 17:50:14 +0530
Message-Id: <20201108122016.2090891-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108121723.2089939-1-santosh@fossix.org>
References: <20201108121723.2089939-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: UCS46F62YSEZZIWKQ6WQA2Y2GUWKSDHA
X-Message-ID-Hash: UCS46F62YSEZZIWKQ6WQA2Y2GUWKSDHA
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UCS46F62YSEZZIWKQ6WQA2Y2GUWKSDHA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Don't fail is nfit module is missing, this will happen in
platforms that don't have ACPI support. Add attributes to
PAPR dimm family that are independent of platforms like the
test dimms.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 test/core.c          |  6 +++++
 2 files changed, 58 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index ad521d3..d1f8e4e 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1655,6 +1655,54 @@ static int ndctl_bind(struct ndctl_ctx *ctx, struct kmod_module *module,
 static int ndctl_unbind(struct ndctl_ctx *ctx, const char *devpath);
 static struct kmod_module *to_module(struct ndctl_ctx *ctx, const char *alias);
 
+static void populate_dimm_attributes(struct ndctl_dimm *dimm,
+				     const char *dimm_base)
+{
+	char buf[SYSFS_ATTR_SIZE];
+	struct ndctl_ctx *ctx = dimm->bus->ctx;
+	char *path = calloc(1, strlen(dimm_base) + 100);
+
+	sprintf(path, "%s/phys_id", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	dimm->phys_id = strtoul(buf, NULL, 0);
+
+	sprintf(path, "%s/handle", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	dimm->handle = strtoul(buf, NULL, 0);
+
+	sprintf(path, "%s/vendor", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dimm->vendor_id = strtoul(buf, NULL, 0);
+
+	sprintf(path, "%s/id", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0) {
+		unsigned int b[9];
+
+		dimm->unique_id = strdup(buf);
+		if (!dimm->unique_id)
+			goto err_read;
+		if (sscanf(dimm->unique_id, "%02x%02x-%02x-%02x%02x-%02x%02x%02x%02x",
+					&b[0], &b[1], &b[2], &b[3], &b[4],
+					&b[5], &b[6], &b[7], &b[8]) == 9) {
+			dimm->manufacturing_date = b[3] << 8 | b[4];
+			dimm->manufacturing_location = b[2];
+		}
+	}
+	sprintf(path, "%s/subsystem_vendor", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dimm->subsystem_vendor_id = strtoul(buf, NULL, 0);
+
+
+	sprintf(path, "%s/dirty_shutdown", dimm_base);
+	if (sysfs_read_attr(ctx, path, buf) == 0)
+		dimm->dirty_shutdown = strtoll(buf, NULL, 0);
+
+err_read:
+	free(path);
+}
+
 static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 {
 	int rc = -ENODEV;
@@ -1685,6 +1733,10 @@ static int add_papr_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 		rc = 0;
 	}
 
+	/* add the available dimm attributes, the platform can override or add
+	 * additional attributes later */
+	populate_dimm_attributes(dimm, dimm_base);
+
 	free(path);
 	return rc;
 }
diff --git a/test/core.c b/test/core.c
index 5118d86..0fd1011 100644
--- a/test/core.c
+++ b/test/core.c
@@ -195,6 +195,12 @@ retry:
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			/* For non-nfit platforms it's ok if nfit module is
+			 * missing */
+			if (strcmp(name, "nfit") == 0 ||
+			    strcmp(name, "nd_e820") == 0)
+				continue;
+
 			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
 			break;
 		}
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
