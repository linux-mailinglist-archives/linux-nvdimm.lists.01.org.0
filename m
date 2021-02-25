Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B8324A6F
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 07:13:26 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D2B25100F2252;
	Wed, 24 Feb 2021 22:13:24 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::433; helo=mail-pf1-x433.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 73C5D100F2251
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:22 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t29so2905594pfg.11
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxLCdkplDyvMu3gLpnfnAF7R65b6IFXac/smsmfloRo=;
        b=m23CY318Fy5Nz0GsvfauZ3kt8cZk8q2JSMr5cEHLFJhfxHjhj2w5HGRRt6oUWn2Hfj
         zRVAkahdJeT03K0gI8dwKJ04SaIwztpOC6ZnpIv5LA1qWC0oHXh0ucD38RxuvY+l5WHR
         vDIN4+v7cO/vX1tJzf+enx0DzkwbRLKD9MYkMnuY8xpxCKQ2l/9YZC1JAgOeUfMF8tIX
         D2wBexpqV6nbhZ7fkxhll8ejcR/vbNmY46eLugKbG2fof4Ih+y79PqJwy780wghl1VsL
         LBC/GMG7vI8mNtwqM5AJXlv8v4oDdk8CmWX9Yp97SaM4DFwWmDShZVowj7qICQmdplCK
         5v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxLCdkplDyvMu3gLpnfnAF7R65b6IFXac/smsmfloRo=;
        b=tOHUceg4Gqi8d04gYLpKgpoWPeh1pfuUnDzm/d6FGueXwyFGjsP9eyBtYckhc9o/Ra
         T+SIiQj+0GTXgliuuiKWyIjSDMShPZs/Lr+JrADNNNK5YvZ15U6yDosxbjYAn6CcdEiS
         e1fy/BUoCjJA2W6wCOx3mjqs2jnmtdX1L/x/QOEiscmJlkGww2OtT/HUamEPjgotsnlz
         zk4FIio7dL0rsdeYGN9wG0+DXqPmG2yHeXk+FZ1hkDqIQGGWaiDfjpurElGHJrtGNJr5
         IssaALAG5MWNAdcEaANlzhjVF8sNiBho9/HZ9z3LejbU86QbZVn1FcRujfsTx4ZIkVQ4
         ZiEg==
X-Gm-Message-State: AOAM531DGqBwW/GbPswbvx4mbJOvA4IpkpfyGjR9Pt97YDwbm5JcCIQp
	+gqWVj4TK0IuspGKyouX07ZIP1raNfM66Q==
X-Google-Smtp-Source: ABdhPJxgaCMKIebt3Toe/F2HAjYDUJqlbv7VK2OwsNt6w+5XR8G1NFqTxIWdhp8sfjWpGZjlVl89NA==
X-Received: by 2002:a63:5c1e:: with SMTP id q30mr1528671pgb.259.1614233601734;
        Wed, 24 Feb 2021 22:13:21 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d24sm4327803pfr.139.2021.02.24.22.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:13:21 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH v2 4/4] Use page size as alignment value
Date: Thu, 25 Feb 2021 11:43:03 +0530
Message-Id: <20210225061303.654267-4-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225061303.654267-1-santosh@fossix.org>
References: <20210225061303.654267-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 2CMXGUZGZVLFWRXKCS6U6U77IGVRRSGK
X-Message-ID-Hash: 2CMXGUZGZVLFWRXKCS6U6U77IGVRRSGK
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CMXGUZGZVLFWRXKCS6U6U77IGVRRSGK/>
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
index 10af189..ef3a1a9 100644
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
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
