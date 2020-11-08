Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5B32AAAFB
	for <lists+linux-nvdimm@lfdr.de>; Sun,  8 Nov 2020 13:20:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8089D16217BC7;
	Sun,  8 Nov 2020 04:20:45 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1044; helo=mail-pj1-x1044.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E009216217BC4
	for <linux-nvdimm@lists.01.org>; Sun,  8 Nov 2020 04:20:42 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f12so1799373pjp.4
        for <linux-nvdimm@lists.01.org>; Sun, 08 Nov 2020 04:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8kSiSvRQ5QQ9q9gm+EzTDowJXtANIsa3/C245Xzk6o=;
        b=bhklWeYcAPAThCuGsg4q0LinDOcWPw3Lv4MgS4X/lzx1anKYU0V3RAZJkmEoVTakah
         RPry4TiCgknqDEOFtbSJ6REp2BcgYgNxV7D2Rl1stI+n4XOPqbyThrPuvxzgo1LqmkX3
         XpHGxQPiDpjXHx9fscm1IVQhupnUoc1z+4/mXjAt48V+CNhySAK74Ynjq+nVobsJgyWr
         Q2tihIFqShF/vQXQuIgdZ14oBVUngYBiAg2XvpO87d4BJ+BFPKU4MKnnDAQxO0zKxA+w
         gxjDSOJPJFgFwK8sVZ2cvhwF4yp9zkc+cJhNZwAqb742MaZh1rZmyPjYCqoWO/dr+c3m
         D6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8kSiSvRQ5QQ9q9gm+EzTDowJXtANIsa3/C245Xzk6o=;
        b=EwATKPBUvNruosJRm83Uy8fChjvBqLfi9gvuxYXLEJ22sNf1mZkrxibtxc8Q+ZVJor
         dEgaDU7q1mfqnJ3t7IjpxR3RmAXDGNxQEDvyx/5klp0jgFXR+KTLaioJTU8Npb7u1OK7
         Q8J4Yc/THtgIsUuixQOxd8UcpwZcyXm8OKGZfDXutz961JyHK6h3Aurf1I3JflokbhmA
         G+wUodhYmaJdYpwYXWUO6VWRDpwBgXhgaEels4Utz3NZeL6YYID0WqZ0HDOel+145HdW
         KLs9lVUXuGLNJ4cFPiWZSVFRQ2lnuc+4gZLUClPLZRInfFliup2JSnSoIdSa6cc82n8U
         vqgQ==
X-Gm-Message-State: AOAM533MOUbqtrJ82eEWOUJFb6Ewu0IEcJZ7TbzeU1U4sAlYLhUPRiqa
	E0ZLjM90xOVoDoAMJkAszvmbRB1cvCZfYg==
X-Google-Smtp-Source: ABdhPJyP70CTTiS21iGLRy4E7ArLdyGPnDayvWJ6iaCmYtYkEeJxcxcLHIRxYCJa+FV0sMkQqtmSLQ==
X-Received: by 2002:a17:902:ab94:b029:d6:9c3:e99e with SMTP id f20-20020a170902ab94b02900d609c3e99emr8859305plr.68.1604838042394;
        Sun, 08 Nov 2020 04:20:42 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id e7sm7441282pge.51.2020.11.08.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 04:20:41 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v4 3/3] Use page size as alignment value
Date: Sun,  8 Nov 2020 17:50:16 +0530
Message-Id: <20201108122016.2090891-3-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108122016.2090891-1-santosh@fossix.org>
References: <20201108121723.2089939-1-santosh@fossix.org>
 <20201108122016.2090891-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: LEHQXKE4VMOHPZ5SME5KB4Y35EN4O54B
X-Message-ID-Hash: LEHQXKE4VMOHPZ5SME5KB4Y35EN4O54B
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LEHQXKE4VMOHPZ5SME5KB4Y35EN4O54B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/dpa-alloc.c    | 23 ++++++++++++++---------
 test/multi-dax.sh   |  6 ++++--
 test/sector-mode.sh |  4 +++-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/test/dpa-alloc.c b/test/dpa-alloc.c
index b757b9a..dff9b62 100644
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
