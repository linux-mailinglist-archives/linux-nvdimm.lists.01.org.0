Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCE8336D48
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 08:48:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 45628100F2262;
	Wed, 10 Mar 2021 23:48:58 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 696CA100F225F
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:55 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8655927pjc.2
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/02gceZ1C0cKDMZLMP47TLUCBsj2Ofi71U1k6wsKoE=;
        b=fxRd38LLh52gOvdvKxCvxSVrhgYAAMW0uljTpuLcMJI16zB6CW5gnuzn7oAwB5crOg
         1yJ/kczVZUQR9NFSg6dJIYsGDCVMs1r1cXsrXkvngfHm18BYb3FhAdJB7a9Oyq3qOzhE
         5ERswLCF0f8Pl7IlGYOI2y/k9E0x/ZOG6zDC5uvH9cflUs6Af2hhuqNh1t1m5DAKjFuj
         NhM0lNd1R3cPpAmj+v13j6n8Erl7kny7Kz0+uvU4OEl//PH+SxnC/JGbVNHfCR63+Lyn
         bHZyvWnRs7dYdeQK+GeH+LPUAcwFDxOTnN97OPsocuCTOfpBHZwVRLbgvDw246X6sNQB
         vgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/02gceZ1C0cKDMZLMP47TLUCBsj2Ofi71U1k6wsKoE=;
        b=EKXZWfgsyVoFBUMFjs6zXS42DsCarErXcitwx5z0BqZOKGh1+d3x9yhxgqecBeWZTM
         I16StwT5dahZJ/TllAXedQFiTVnx1DNeSZ7KB2eZOAQbeSLRkgGG7X7ajoDSUb4LhNde
         Iw9f607kxcS5/K6dqsLvUVhA0DxcwteRN/IdCwUhnice1W/9Er60Fdk2Gwa8Rz0riLdu
         6cRdcLDyBW3JodZ3R7tTQhS6RoVcgN1Z48XoJ23/1gsZGNnPTtQ73TXBbMc6zEgvsXKr
         RwBk36ad3aLNLjjqjRVDM8cHVVq8DxSbO38I8ehKpSNJDBV9502t7d+j9WXxuFXzq7NI
         fAOw==
X-Gm-Message-State: AOAM531A1YSEVZqCRfmWf+6XPWpQxENw3NLbgABk+1w78QEI1RB8K7pn
	YxNbgNKZz49v+q13wQTJ4QS1r8Mr6QYsOw==
X-Google-Smtp-Source: ABdhPJxM4vTJpu5uJFoIZjTQL8CgZpSGMuhXxJFfpBGbiT3d8xur54Cv9th2C84q/9S/EG1yUas0HA==
X-Received: by 2002:a17:902:8c97:b029:e2:8c58:153f with SMTP id t23-20020a1709028c97b02900e28c58153fmr6904755plo.79.1615448934494;
        Wed, 10 Mar 2021 23:48:54 -0800 (PST)
Received: from localhost.localdomain ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t13sm1528580pfe.161.2021.03.10.23.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:48:54 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH v3 4/4] Use page size as alignment value
Date: Thu, 11 Mar 2021 13:16:52 +0530
Message-Id: <20210311074652.2783560-4-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311074652.2783560-1-santosh@fossix.org>
References: <20210311074652.2783560-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: K7UTQVUT2MKKJOLY5P4BK7CKKEEVQ6NA
X-Message-ID-Hash: K7UTQVUT2MKKJOLY5P4BK7CKKEEVQ6NA
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/K7UTQVUT2MKKJOLY5P4BK7CKKEEVQ6NA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The alignment sizes passed to ndctl in the tests are all hardcoded to 4k,
the default page size on x86. Change those to the default page size on that
architecture (sysconf/getconf). No functional changes otherwise.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/dpa-alloc.c    | 15 ++++++++-------
 test/multi-dax.sh   |  6 ++++--
 test/sector-mode.sh |  4 +++-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 0b3bb7a..59185cf 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -38,12 +38,13 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	struct ndctl_region *region, *blk_region = NULL;
 	struct ndctl_namespace *ndns;
 	struct ndctl_dimm *dimm;
-	unsigned long size;
+	unsigned long size, page_size;
 	struct ndctl_bus *bus;
 	char uuid_str[40];
 	int round;
 	int rc;
 
+	page_size = sysconf(_SC_PAGESIZE);
 	/* disable nfit_test.1, not used in this test */
 	bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER1);
 	if (!bus)
@@ -124,11 +125,11 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 			return rc;
 		}
 		ndctl_namespace_disable_invalidate(ndns);
-		rc = ndctl_namespace_set_size(ndns, SZ_4K);
+		rc = ndctl_namespace_set_size(ndns, page_size);
 		if (rc) {
-			fprintf(stderr, "failed to init %s to size: %d\n",
+			fprintf(stderr, "failed to init %s to size: %lu\n",
 					ndctl_namespace_get_devname(ndns),
-					SZ_4K);
+					page_size);
 			return rc;
 		}
 		namespaces[i].ndns = ndns;
@@ -150,7 +151,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 		ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
 		if (i % ARRAY_SIZE(namespaces) == 0)
 			round++;
-		size = SZ_4K * round;
+		size = page_size * round;
 		rc = ndctl_namespace_set_size(ndns, size);
 		if (rc) {
 			fprintf(stderr, "%s: set_size: %lx failed: %d\n",
@@ -166,7 +167,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	i--;
 	round++;
 	ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
-	size = SZ_4K * round;
+	size = page_size * round;
 	rc = ndctl_namespace_set_size(ndns, size);
 	if (rc) {
 		fprintf(stderr, "%s failed to update while labels full\n",
@@ -175,7 +176,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	}
 
 	round--;
-	size = SZ_4K * round;
+	size = page_size * round;
 	rc = ndctl_namespace_set_size(ndns, size);
 	if (rc) {
 		fprintf(stderr, "%s failed to reduce size while labels full\n",
diff --git a/test/multi-dax.sh b/test/multi-dax.sh
index e932569..9451ed0 100755
--- a/test/multi-dax.sh
+++ b/test/multi-dax.sh
@@ -12,6 +12,8 @@ check_min_kver "4.13" || do_skip "may lack multi-dax support"
 
 trap 'err $LINENO' ERR
 
+ALIGN_SIZE=`getconf PAGESIZE`
+
 # setup (reset nfit_test dimms)
 modprobe nfit_test
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
@@ -22,9 +24,9 @@ rc=1
 query=". | sort_by(.available_size) | reverse | .[0].dev"
 region=$($NDCTL list -b $NFIT_TEST_BUS0 -t pmem -Ri | jq -r "$query")
 
-json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
+json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a $ALIGN_SIZE -s 16M)
 chardev1=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
-json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a 4096 -s 16M)
+json=$($NDCTL create-namespace -b $NFIT_TEST_BUS0 -r $region -t pmem -m devdax -a $ALIGN_SIZE -s 16M)
 chardev2=$(echo $json | jq ". | select(.mode == \"devdax\") | .daxregion.devices[0].chardev")
 
 _cleanup
diff --git a/test/sector-mode.sh b/test/sector-mode.sh
index dd7013e..d03c0ca 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -9,6 +9,8 @@ rc=77
 set -e
 trap 'err $LINENO' ERR
 
+ALIGN_SIZE=`getconf PAGESIZE`
+
 # setup (reset nfit_test dimms)
 modprobe nfit_test
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
@@ -25,7 +27,7 @@ NAMESPACE=$($NDCTL list -b $NFIT_TEST_BUS1 -N | jq -r "$query")
 REGION=$($NDCTL list -R --namespace=$NAMESPACE | jq -r "(.[]) | .dev")
 echo 0 > /sys/bus/nd/devices/$REGION/read_only
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
-$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a 4K
+$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a $ALIGN_SIZE
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
 
 _cleanup
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
