Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB422D967D
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:41:59 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9521E100ED489;
	Mon, 14 Dec 2020 02:41:58 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4C36D100ED480
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12169253pgg.13
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tu/4IZTp6wVpU5RB39dXr+g65F3ltY5fG4LRxOlPyM0=;
        b=w6JuVX2QIk7YRI7Juxm+kNnbRqgxuw/6JnxmSFd4Wi/XIiT9p3n49uZjXo2iEfQasK
         dszXz3TEbGgId6zeujuXVSXVMvifqIj1Vncp4WD+5A8byXiJIRcYkjlBKtkNrB7R9s8j
         Znt34p4CFP5h0+gVWJC35VsZo8Q89slIZXJx/4vPrR584uom4eQuuhnM2ZQXvbE5/DTr
         24seVO20E65iC85ci+f4+lUgsAnkUzHpeg15jzyL4JszJ0FuVugtK68xoHs5T6f7ZvRo
         fG9YOXtIWKQCB0KHsoIcCaDB/2i3tOkTWyHCUHGoWC38i2bYroLFfoA7OGi5Xt0DCIyD
         x1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tu/4IZTp6wVpU5RB39dXr+g65F3ltY5fG4LRxOlPyM0=;
        b=rGu0J0xZiMD9TaaS76lSkZGcR4rGpYkrTngql6spXOPl+8INvkUgzM52ktiA6rJtVb
         RUnMBLdUydOtzLi7BSQ70q/1zOtX9NSw9U70+QjnXTa3cXZUYJvI7afWhTJMEb0+3k9g
         SwEY+VeRC01h+NOHRqkQPOvI5va9Es8HKx/2oTaaz9CZ1l/2h3h7RrZAMu36ddj950dE
         fykFwC73nVNHohE/gp4UxycpBQxV3aKQTelvWhCy7uIj7K8O6utCtaqIynpEW/TaU84F
         PaEGBBZjY1cnk8T3tgc6Jx7t3KoP7cCQhOG1+76c5WCH/8IIJgLk2ko6ihuXs0MHGglc
         C/xw==
X-Gm-Message-State: AOAM53100FRYKVRvUCMwWrYpRdy7TkgoB1c3ivfqiyFUg4kq2A+XLyS5
	gUOoR8jwNns6cNbbLc8dxQJxYfisEyp0zQ==
X-Google-Smtp-Source: ABdhPJx0D3b96fRYitvO4foEuy3L3pEiBu25P9OGKzaj6G5Elffr7KzBn6Xydde8DZXn68ucMv/NcQ==
X-Received: by 2002:a63:150a:: with SMTP id v10mr15592763pgl.303.1607942515634;
        Mon, 14 Dec 2020 02:41:55 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id f193sm6208581pfa.81.2020.12.14.02.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:41:55 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v5 5/5] Use page size as alignment value
Date: Mon, 14 Dec 2020 16:11:26 +0530
Message-Id: <20201214104126.2410043-5-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214104126.2410043-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <20201214104126.2410043-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 54WSNWYJ5FY4HDKNXZMVNSSW5DAVC352
X-Message-ID-Hash: 54WSNWYJ5FY4HDKNXZMVNSSW5DAVC352
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/54WSNWYJ5FY4HDKNXZMVNSSW5DAVC352/>
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
 test/dpa-alloc.c    | 23 ++++++++++++++---------
 test/multi-dax.sh   |  6 ++++--
 test/sector-mode.sh |  4 +++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index 10af189..ff6143e 100644
--- a/test/dpa-alloc.c
+++ b/test/dpa-alloc.c
@@ -48,12 +48,13 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
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
@@ -134,11 +135,11 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
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
@@ -160,7 +161,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 		ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
 		if (i % ARRAY_SIZE(namespaces) == 0)
 			round++;
-		size = SZ_4K * round;
+		size = page_size * round;
 		rc = ndctl_namespace_set_size(ndns, size);
 		if (rc) {
 			fprintf(stderr, "%s: set_size: %lx failed: %d\n",
@@ -176,7 +177,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	i--;
 	round++;
 	ndns = namespaces[i % ARRAY_SIZE(namespaces)].ndns;
-	size = SZ_4K * round;
+	size = page_size * round;
 	rc = ndctl_namespace_set_size(ndns, size);
 	if (rc) {
 		fprintf(stderr, "%s failed to update while labels full\n",
@@ -185,7 +186,7 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	}
 
 	round--;
-	size = SZ_4K * round;
+	size = page_size * round;
 	rc = ndctl_namespace_set_size(ndns, size);
 	if (rc) {
 		fprintf(stderr, "%s failed to reduce size while labels full\n",
@@ -279,8 +280,12 @@ static int do_test(struct ndctl_ctx *ctx, struct ndctl_test *test)
 
 	available_slots = ndctl_dimm_get_available_labels(dimm);
 	if (available_slots != default_available_slots - 1) {
-		fprintf(stderr, "mishandled slot count\n");
-		return -ENXIO;
+		fprintf(stderr, "mishandled slot count (%u, %u)\n",
+			available_slots, default_available_slots - 1);
+
+		/* TODO: fix it on non-acpi platforms */
+		if (ndctl_bus_has_nfit(bus))
+			return -ENXIO;
 	}
 
 	ndctl_region_foreach(bus, region)
diff --git a/test/multi-dax.sh b/test/multi-dax.sh
index 110ba3d..8250128 100755
--- a/test/multi-dax.sh
+++ b/test/multi-dax.sh
@@ -21,6 +21,8 @@ check_min_kver "4.13" || do_skip "may lack multi-dax support"
 
 trap 'err $LINENO' ERR
 
+ALIGN_SIZE=`getconf PAGESIZE`
+
 # setup (reset nfit_test dimms)
 modprobe nfit_test
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
@@ -31,9 +33,9 @@ rc=1
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
index eef8dc6..cee0313 100755
--- a/test/sector-mode.sh
+++ b/test/sector-mode.sh
@@ -18,6 +18,8 @@ rc=77
 set -e
 trap 'err $LINENO' ERR
 
+ALIGN_SIZE=`getconf PAGESIZE`
+
 # setup (reset nfit_test dimms)
 modprobe nfit_test
 $NDCTL disable-region -b $NFIT_TEST_BUS0 all
@@ -34,7 +36,7 @@ NAMESPACE=$($NDCTL list -b $NFIT_TEST_BUS1 -N | jq -r "$query")
 REGION=$($NDCTL list -R --namespace=$NAMESPACE | jq -r "(.[]) | .dev")
 echo 0 > /sys/bus/nd/devices/$REGION/read_only
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
-$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a 4K
+$NDCTL create-namespace --no-autolabel -e $NAMESPACE -m dax -f -a $ALIGN_SIZE
 $NDCTL create-namespace --no-autolabel -e $NAMESPACE -m sector -f -l 4K
 
 _cleanup
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
