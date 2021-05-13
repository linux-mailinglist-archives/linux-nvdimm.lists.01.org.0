Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CC37F2DE
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 08:13:35 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D8CEC100EAB48;
	Wed, 12 May 2021 23:13:32 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 91977100F2257
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id b3so13811367plg.11
        for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GaySowKDRoeaBobshdWuwMR/EGY+Ux4n273LdfQ4dY=;
        b=pxpRP8TlU9fs707q5bL8nd630G8PriP2T97U5uyzQ8RiwRVebVN8qU4KPq/DSLiw0f
         sA8yyz7J1AaMI2MeWRO4GzqmBEk1exFihZF97Vf2o0CPBHjsUJReWuewp/WRxGsDDN38
         vtmSh0AImEgMwYiDPlgbOk6mKdKiPETFP9btjhNG3knzW45prA20xaiM83i4t/opw/wi
         Eup4fASLDgcEOMi3sO2Ovl6h5lVX2OlDsgf9DJh9KBfLBlsP94Yfzgv5zZFsE6IDabTt
         IlMqz54OotPozxAur/vXBd86Dv4ecS3CldSYiIVEr+ng6UGx6OT5LYEqud0ZjrluXoDv
         7T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GaySowKDRoeaBobshdWuwMR/EGY+Ux4n273LdfQ4dY=;
        b=ugxmZMNxyVzWJe0LGc7kjX2o1cqhvMhUCdCjk/GJrwVc+IorKTW5J9bSaMOD+N6hil
         fUG7NBMNF1EGilgom0DhGow3mweGil1YbyXh0UVfI7hSzvOhAIKaibBIn1ZXtg5bHQiK
         PlvDM7Di/P+Hr5n/84LY23EcsTb864oHtw0sy+yIDN/tA0HrsgB/jgrfAlrK4bCbkHvi
         0xYA9pW2OAjb3vQpGkITgvRFopiayRFRjEe9tQqjiUDuLXP3/fQjJEyIe84o1iPD9ryA
         lpCjMv942VKCzTVglzAJ4cAsbhEih8EhSYhnkrSda6Ya6bSxb5fUnkoNcM1ogR4KSjI7
         D6hA==
X-Gm-Message-State: AOAM530BKOeGc/ZeFVQJZVrZSj16nzRzuNVYeOperCyIS8+WfDprN6XQ
	RNZGsTJqU1AFHeLL8LaPROw37bzLb6EEPQ==
X-Google-Smtp-Source: ABdhPJyqA2afRvk9kEbXXLVfanx5++nl7BGfs7cLPCJY/JM/vjRzxd/Cz68+DfD50CoSSgSBHbk4xg==
X-Received: by 2002:a17:902:b285:b029:ef:9419:b91c with SMTP id u5-20020a170902b285b02900ef9419b91cmr3405520plr.21.1620886409772;
        Wed, 12 May 2021 23:13:29 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gf21sm1422351pjb.20.2021.05.12.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:13:29 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl V5 4/4] Use page size as alignment value
Date: Thu, 13 May 2021 11:42:18 +0530
Message-Id: <20210513061218.760322-4-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513061218.760322-1-santosh@fossix.org>
References: <20210513061218.760322-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: KIFHFYTEIQNEQMVWCMXJZMJLJZU5BLS2
X-Message-ID-Hash: KIFHFYTEIQNEQMVWCMXJZMJLJZU5BLS2
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KIFHFYTEIQNEQMVWCMXJZMJLJZU5BLS2/>
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
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
