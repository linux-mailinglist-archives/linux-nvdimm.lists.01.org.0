Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D7E285787
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 23D5F158AFE8D;
	Tue,  6 Oct 2020 21:23:32 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 93218158AFE86
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p11so356162pld.5
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2jawmy9m8mGudIyMIRSabZxFA56ZmnT7YOuDoL4vaI=;
        b=TLodmtUmSCfZVZ+zt8ja5tyzSGiiY7zCH3/Wu4vIDVDvNZU09SN1XtnKAharG56dgX
         cMZG9MZDB/gyduaIti/SOmzJXcj1FXCqZ/KGhs2FP6AtiPJfLzqWvTie/xSbZjmwV7y5
         xJZYt/G+aodplA9zvSv40UJJFNd4q+BfPQRq/tqbbHwEjnt3NOGasUtu3ddlAkbli1t+
         ihcR0/M4cJGlsvkSo436w8Hftnwvem+/wTVn1aPZmTPZ9yRJiT3LRK6D+noOW9ZLS+wC
         98Fje0RIHT72QEFTGOQ2e4b6IldYfDFsiNXGVOMHayDYhk3OMmLpdNVyQCCRE+aCJsPH
         Pq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2jawmy9m8mGudIyMIRSabZxFA56ZmnT7YOuDoL4vaI=;
        b=Lrg2V8XpPdtkMfS7vpff9dKDmf7CW53Xf4rKrZDXCp9qHTxvPEfCOptxFDNFpoZRh9
         B4hGUSoUi1NWTTXvm8hVkWsCn1nozZ/EQKKurB727t2NNOfoUqr6rRoDDVNRNO6chjtV
         /UmFbxWl3S+Zv0CqvdlH1gKMpLHf9xxC79/19pIW9U6DGxBTcFcfz2/oyS/5cql8U+VK
         8Nst/4AuIC+pHeGpLOe7q6BMnpp+ynKI5LD+D7XDgyqUMKSPMkF8q0UxG+X3OU676ywK
         5vQHV8/ItyiWqjZWy87brk7oEzTpJjHaGMufP57gj5mQhxQztq3Dh1pTrTGlwp+EMWKa
         594A==
X-Gm-Message-State: AOAM533VWM6Flrj1JNGdGbseSoMMCXLQ9z5ZxTg3uMl9pUI1ozrZ1JqH
	lB8aQBz25igeTGxCd561nFxAZVs3Y5a2vA==
X-Google-Smtp-Source: ABdhPJwnk64UBb9uS4TXmgedMgHWJaPvobC4+LjgBBbQ1I/ypFvp+MA2FEiN1NHbyGfSueEgItldZw==
X-Received: by 2002:a17:90a:fd97:: with SMTP id cx23mr1191844pjb.3.1602044606367;
        Tue, 06 Oct 2020 21:23:26 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:25 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 1/9] libndctl: test enablement for non-nfit devices
Date: Wed,  7 Oct 2020 09:52:48 +0530
Message-Id: <20201007042256.1110626-1-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006010013.848302-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: LPUKUCYSTUCRPAZHPYIPTWSL2N6XBTJZ
X-Message-ID-Hash: LPUKUCYSTUCRPAZHPYIPTWSL2N6XBTJZ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LPUKUCYSTUCRPAZHPYIPTWSL2N6XBTJZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add attributes to generic dimms that are independent of platforms like the
test dimms.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 952192c..852cb4d 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1619,6 +1619,53 @@ static int add_nfit_dimm(struct ndctl_dimm *dimm, const char *dimm_base)
 	free(path);
 	return rc;
 }
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
 
 static void *add_dimm(void *parent, int id, const char *dimm_base)
 {
@@ -1694,6 +1741,10 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	} else
 		parse_dimm_flags(dimm, buf);
 
+	/* add the available dimm attributes, the platform can override or add
+	 * additional attributes later */
+	populate_dimm_attributes(dimm, dimm_base);
+
 	/* Check if the given dimm supports nfit */
 	if (ndctl_bus_has_nfit(bus)) {
 		dimm->formats = formats;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
