Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78498382742
	for <lists+linux-nvdimm@lfdr.de>; Mon, 17 May 2021 10:43:19 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CC5E5100EB839;
	Mon, 17 May 2021 01:43:17 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 42540100EC1C8
	for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ot16so1331501pjb.3
        for <linux-nvdimm@lists.01.org>; Mon, 17 May 2021 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3J5lKob28bJl2K0gYsep9D81oU4lCi4shni5QfNiTk8=;
        b=xF5RcQEf6LaJG/ChhvFtefOXRfF5CFQWu7mK/3mkja4dH2theABON3qTrnkUWu45WH
         ZCzn+1aYWIAbSyklbFft+1MY+QdImlcdVzZrDO9qZhZ3KVozjspDpgPOfCadIkcwLCFI
         IeRucpvUw3h/Oed40jvIaZ5+qnRSTvPvRaoUhGaml3UZfNnwRKw7slzsj7iY7QudXAzm
         XHOu1hSIgsdlKK1rQdQOMSmhjomLCG4UJ5rshaY0tHrbLWBjg3SVI+9Vgvp0Hx+R6J1u
         0lRF2+X3aT6qwBbiHejffTSN7luDBabxdGCurf+64OWk9nsNVDmtbf80Ft1S7NBbv+dJ
         VB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3J5lKob28bJl2K0gYsep9D81oU4lCi4shni5QfNiTk8=;
        b=gwSrrvOavWnRPy+8J0SoqZHR5d9I58LxEdGh0WUno6Bc22r7INqpo1m5DlQfZPGXf2
         lFLKRjWDVQdqAbiSiJkoo8yUK6u3zavp5Ps5YgueNUuuYcs+XCsNl/rPQfQcbRYmovdT
         sDq6sOSQB50zSYDpWysURhGlBffoCypZaZFBMp9ytmeQTeSeBzLUq0db3fTxR7iUYhzG
         ltlrjZZ25PSloiWLO86y5IDapnR9MZt/v/JkUPwao/8Fi0TdeECFlczaCKZ12rlaDaHB
         DfPTqdtb4r5nR6jvc8Gb1YNm1ALiHMunxCVFivHex8h1bryHNa2/oJj95VhMqi2gdqx8
         0NwQ==
X-Gm-Message-State: AOAM530wSxGSGVOG/jmimvJZCxzTjczB4VkiLO121DCATsIcgbz4ITtw
	7w7Rj1MDWVUgGop2aqGCpcNyNBnn5SQEKg==
X-Google-Smtp-Source: ABdhPJy6QNRBhwgxewXLCUOACNR49ElfXsd60RF4zludD7DWGq9CcJ9xKuxebUJ2zKH5FIBnySGBPQ==
X-Received: by 2002:a17:902:d718:b029:ee:cf89:57ea with SMTP id w24-20020a170902d718b02900eecf8957eamr60268329ply.3.1621240995712;
        Mon, 17 May 2021 01:43:15 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id z24sm2715254pfk.150.2021.05.17.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 01:43:15 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl v2 1/4] libndctl: Rename dimm property nfit_dsm_mask for generic use
Date: Mon, 17 May 2021 14:12:56 +0530
Message-Id: <20210517084259.181236-1-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Message-ID-Hash: D4TTNXOPW53737ZGQOLQUYAUFG4HAWU3
X-Message-ID-Hash: D4TTNXOPW53737ZGQOLQUYAUFG4HAWU3
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D4TTNXOPW53737ZGQOLQUYAUFG4HAWU3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>

The dimm specific dsm masks can be used by different platforms.
Rename it to dsm_mask to avoid confusion.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
---
 ndctl/lib/libndctl.c | 4 ++--
 ndctl/lib/private.h  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Resending both the SMART test and error injection patches as one series. Will be
easier for review and testing.

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index bf0968c..a148438 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -1728,7 +1728,7 @@ static int populate_dimm_attributes(struct ndctl_dimm *dimm,
 
 	sprintf(path, "%s/%s/dsm_mask", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
-		dimm->nfit_dsm_mask = strtoul(buf, NULL, 0);
+		dimm->dsm_mask = strtoul(buf, NULL, 0);
 
 	sprintf(path, "%s/%s/format", dimm_base, bus_prefix);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
@@ -1821,7 +1821,7 @@ static void *add_dimm(void *parent, int id, const char *dimm_base)
 	dimm->manufacturing_date = -1;
 	dimm->manufacturing_location = -1;
 	dimm->cmd_family = -1;
-	dimm->nfit_dsm_mask = ULONG_MAX;
+	dimm->dsm_mask = ULONG_MAX;
 	for (i = 0; i < formats; i++)
 		dimm->format[i] = -1;
 
diff --git a/ndctl/lib/private.h b/ndctl/lib/private.h
index 8f4510e..53fae0f 100644
--- a/ndctl/lib/private.h
+++ b/ndctl/lib/private.h
@@ -68,7 +68,7 @@ struct ndctl_dimm {
 	unsigned char manufacturing_location;
 	unsigned long cmd_family;
 	unsigned long cmd_mask;
-	unsigned long nfit_dsm_mask;
+	unsigned long dsm_mask;
 	long long dirty_shutdown;
 	enum ndctl_fwa_state fwa_state;
 	enum ndctl_fwa_result fwa_result;
@@ -105,9 +105,9 @@ enum dsm_support {
 
 static inline enum dsm_support test_dimm_dsm(struct ndctl_dimm *dimm, int fn)
 {
-	if (dimm->nfit_dsm_mask == ULONG_MAX) {
+	if (dimm->dsm_mask == ULONG_MAX) {
 		return DIMM_DSM_UNKNOWN;
-	} else if (dimm->nfit_dsm_mask & (1 << fn))
+	} else if (dimm->dsm_mask & (1 << fn))
 		return DIMM_DSM_SUPPORTED;
 	return DIMM_DSM_UNSUPPORTED;
 }
-- 
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
