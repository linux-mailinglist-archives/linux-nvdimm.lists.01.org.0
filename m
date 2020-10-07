Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED828578A
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AB131158AFE90;
	Tue,  6 Oct 2020 21:23:43 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1041; helo=mail-pj1-x1041.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7A6E8158AFE86
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:41 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so402887pjb.5
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQhiVKTIyE8nRMrghaDZN3AyGnnYMnLm1Fw5PU90TwE=;
        b=sDW+MGPkBH7MMEmQ8jjQfbO0XlQIyTP8imSClKmGmxPx04YCPpYzcuELSKmfwy+1RN
         gqNH0AGToz8sC0VVH/jTpAF/8t8FD4AyKQ66tfkhI+QkPjmR+YIc9ltBSVzhPzY9BUrX
         Jh3Wq8/VbXjlZ5I/muhmBEsEcFJxjJfcPs47nrBdNH9YTvNvS7zbCu+4XEaJTLhOce+g
         OcBaNfmD189fwIRvN/dkQ0mvI/hfazX1TIrOQYyl+tRlvhwoCoP2ZKxrk5ZMLAy71nOg
         BBVn/Yci3TbxaPQPxs3eCMiF0JnpelrcwN2avi4YU0Q07hkVx17KpWwiGcMhRFXpXFEn
         uVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQhiVKTIyE8nRMrghaDZN3AyGnnYMnLm1Fw5PU90TwE=;
        b=GBxfh7E8MYdY0AkmeFAIXC/84bWgakHd06knqw8mGGjCT68T4N2t5vMonixmayxoK1
         cyKbH4H4DYBXRUvNT5rRnxUEARQo1Bx/1Os3CJIbHcbV0a52L06AEHhcoUW0rrFK+z2R
         jM34LlwCOTAgQod6NKFWeG25g5IoNcWPdl+X0hEEf53s0XXfiLb3BH3ggyqG4FpNFALF
         nRDX0gFF6s/x/PVSOfCMSx8Kfs3fP0IHd6fEPQJ+uEk4nI1zEISnzKO+QQ4J8psW4DpK
         8iT2gQV+OZraB1+P+gvSCrnbWMfkQvlL7lW7/lYNV85/2jpal8ws511B6Ipm5Z3Gjatv
         IsJw==
X-Gm-Message-State: AOAM530lpjqfGPUrBuCw9JBkUZBK+bhakcg1eilWTwz0gRS4wYisSMbW
	g2Eqtmk5h8UjKaBK6BB11LeijlG9Sl2Asg==
X-Google-Smtp-Source: ABdhPJxsQ4s6ksi4Ij+Nvw0hxM7lKq9dSb70xIcFzNmMXCiHwyhUva90SGBBcmcjCyAI1YotlSaEGA==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr1199108pjq.93.1602044620930;
        Tue, 06 Oct 2020 21:23:40 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:40 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 4/9] test/libndctl: search by handle instead of range index
Date: Wed,  7 Oct 2020 09:52:51 +0530
Message-Id: <20201007042256.1110626-4-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 6LDIPKW7PARSNQP52GVEXMI5TE2JJZ5W
X-Message-ID-Hash: 6LDIPKW7PARSNQP52GVEXMI5TE2JJZ5W
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6LDIPKW7PARSNQP52GVEXMI5TE2JJZ5W/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When there is no-interleave support, there is no range index.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index d508948..1a5a267 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -495,6 +495,26 @@ static struct ndctl_region *get_pmem_region_by_range_index(struct ndctl_bus *bus
 	return NULL;
 }
 
+static struct ndctl_region *get_pmem_region_by_dimm_handle(struct ndctl_bus *bus,
+		unsigned int handle)
+{
+	struct ndctl_region *region;
+
+	ndctl_region_foreach(bus, region) {
+		struct ndctl_mapping *map;
+
+		if (ndctl_region_get_type(region) != ND_DEVICE_REGION_PMEM)
+			continue;
+		ndctl_mapping_foreach(region, map) {
+			struct ndctl_dimm *dimm = ndctl_mapping_get_dimm(map);
+
+			if (ndctl_dimm_get_handle(dimm) == handle)
+				return region;
+		}
+	}
+	return NULL;
+}
+
 static struct ndctl_region *get_blk_region_by_dimm_handle(struct ndctl_bus *bus,
 		unsigned int handle)
 {
@@ -532,8 +552,12 @@ static int check_regions(struct ndctl_bus *bus, struct region *regions, int n,
 		struct ndctl_interleave_set *iset;
 		char devname[50];
 
-		if (strcmp(regions[i].type, "pmem") == 0)
-			region = get_pmem_region_by_range_index(bus, regions[i].range_index);
+		if (strcmp(regions[i].type, "pmem") == 0) {
+			if (ndctl_bus_has_nfit(bus))
+				region = get_pmem_region_by_range_index(bus, regions[i].range_index);
+			else
+				region = get_pmem_region_by_dimm_handle(bus, regions[i].handle);
+		}
 		else
 			region = get_blk_region_by_dimm_handle(bus, regions[i].handle);
 
@@ -2668,6 +2692,10 @@ static int do_test1(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 10, 0)))
 		dimms1[0].handle = DIMM_HANDLE(1, 0, 0, 0, 0);
 
+	if (!ndctl_bus_has_nfit(bus))
+		regions1[0].handle = DIMM_HANDLE(1, 0, 0, 0, 0);
+
+
 	rc = check_dimms(bus, dimms1, ARRAY_SIZE(dimms1), 0, 0, test);
 	if (rc)
 		return rc;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
