Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDFD34BA70
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Mar 2021 04:10:28 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8D73100EBBDD;
	Sat, 27 Mar 2021 19:10:24 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 352D1100EBBC4
	for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 19:10:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so4282050pjb.0
        for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 19:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSE0olNjoRqAUXPQrpmXcufxL8VpJmvBThhgw81t5vY=;
        b=b/MBwmK6WeJpirKN+paa68xVl9TNMyaXt9UAELpek5N1ujy+S+XPbuUAwmn9oaRjoV
         UcWdLD62fQilzefqAL9xangMKPPAEecESyTO1t2yZ8UhdWJ+kU91z84ZHRq1PbeJSFbU
         F/wkHKpF9Awp4LyzGEtoMIY0F5MQF1Bg6MJksuUv4PjFmt6mvY0S1+CM8hUOTSX99/+O
         9l7EpeQVSyzcDfaowF/a4meQ0PH84zQI0aU2lSyx5q5cYn796ftZEENqG0JB6vKzx4Ya
         gPBOEuJJhQ1Cp4wu1PDgdYiRgRSD/c/E6UiMjnltqmyyeOa/VE3GHVSlcHYJhfVa6rYO
         fvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSE0olNjoRqAUXPQrpmXcufxL8VpJmvBThhgw81t5vY=;
        b=CpnNuGgSgKgBPL1eDJEK4VaWLh4Gv6Rrnj/O46bvCiq1hwdU0Qyw/TjV/Nu7HDGeBu
         WxlNkuDZw4Y65wniuxkkcXGf2qcNtKSsNmdHsIZbPirllsH4sTCGuJ9G9FAdz1OBA/Wi
         9xIPdNax3gf6ZX0VZ2HviXfQzmN5rAF0UVE9sG7Oi71Nrj3XcAxABOziS+F1sRv1CaBZ
         r4E5wFXa5hCaBYwzs7tCGmE4ejOX6D4BKXzaOarKVDxaKnDSFz7PvJGoN09DwbXqZ4oT
         SZ+gLIuu/3t7Uo1JvixQ4V+VILjVVq1sBKl2jCJz9CEfFz1xygGPI0Zv5xg44TcS3AML
         esOA==
X-Gm-Message-State: AOAM531su743zL9QyovZyIhz58laUVtTsGqWcUUdMmVhSf4xpIPUhKx6
	YSEFyGX0CXtIYqwiul4B1LdJrGlawipZ7w==
X-Google-Smtp-Source: ABdhPJyOzaCL1k1xd0qiJi4fauCx00GMFs4sLtRPxsiN+8p4Qo88OBpSKgaMV3Uqe8xESe45co/uKA==
X-Received: by 2002:a17:90a:a103:: with SMTP id s3mr20650411pjp.158.1616897420297;
        Sat, 27 Mar 2021 19:10:20 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gb1sm11754148pjb.21.2021.03.27.19.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:10:20 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 4/4] Use page size as alignment value
Date: Sun, 28 Mar 2021 07:40:01 +0530
Message-Id: <20210328021001.2340251-4-santosh@fossix.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328021001.2340251-1-santosh@fossix.org>
References: <20210328021001.2340251-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 64R7M5JJ4URBXVLWQT7TFZBHWBKOBLBT
X-Message-ID-Hash: 64R7M5JJ4URBXVLWQT7TFZBHWBKOBLBT
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/64R7M5JJ4URBXVLWQT7TFZBHWBKOBLBT/>
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
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
