Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A87728578D
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 049FA158AFE8F;
	Tue,  6 Oct 2020 21:23:53 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 29536158AFE8F
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t23so2260725pji.0
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A57BdxZ2R/8g9Y2oturJ8VTMeu4OZfT/rdT9T5kDCb0=;
        b=qGyRDemE3wM6hG+Kzh3XyjLixMOBlL76+lul4T/pPnWRZGZNUkv7Y7fOaAMzDUh7bQ
         4mUHvjTmWAuHFjqbf+2uPLak07V75rBaIiUXgWhMGjiqANdsqrjX38IZI+pCTk7Ghcsc
         KplAabm1LYLms0rFmNWpittOM2j+1Rz1gchdZijZUa+e2nphJCi+HY1N/E7PmyNdi3G2
         trxBTCLPlnBXJLkEruFNUeZAElmwzkGSK0/01bSJ01C4b2m3JZft8p9T/3A88Fn2nJPW
         OdcEGC/XyYe0x0W2trQ7iHPGRDgQkRpE8KITyLgUouvLOqZX0wQKnBzTnaxVi5e+58dM
         vxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A57BdxZ2R/8g9Y2oturJ8VTMeu4OZfT/rdT9T5kDCb0=;
        b=PvKzsyPs6VSYyBkZs6yueJYgvC9RDeCMQxbuEI3dzktnWeXogHjTCOl7dz/CPBpLFn
         VQMGVVnxaMdODWOEMm41W1qyLa0OBWk3MOHkbs4625WFPuUeglG1aixqkkzolmRbhmOU
         MtiPVI7pyOk19SG4+9ebETvkuLuBTWfZm3S9amuATUikZmoXM0Nsmsw+abPfL0lxnSnC
         UheJuMDIlhPAwWRvdc+SSI+sYv2tvd0Gn5ofIM2tbXi2MS8PstZyhsPaG9ifmYUleZMZ
         dJyPa7oDThaXcceBw7KZZgNSeZ+rRJe1a3eYCkUQOIXreyLWewHFGI8qXMA5CUGeQXgp
         FHcA==
X-Gm-Message-State: AOAM5316WbFToH1HtCnYVKEUTIt/mTU3t8yEKhuxhGk43rdNpq/J+zYx
	itTlQkBSvG5B59gCKjPXtTyjqftZzMqO4Q==
X-Google-Smtp-Source: ABdhPJz066wkTIbISeJTcXX1rgnAOag1kKZQzAoy8exCZXNHfj67SK4+rZvnq10aozNDJ8gnnUYCWw==
X-Received: by 2002:a17:90b:19c4:: with SMTP id nm4mr1157209pjb.133.1602044629426;
        Tue, 06 Oct 2020 21:23:49 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:48 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 7/9] test/libndctl: Don't check for error flags on non-nfit dimms
Date: Wed,  7 Oct 2020 09:52:54 +0530
Message-Id: <20201007042256.1110626-7-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: EQPC4FXOPHHMA6ZBWDZY5GPZPWAIST75
X-Message-ID-Hash: EQPC4FXOPHHMA6ZBWDZY5GPZPWAIST75
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EQPC4FXOPHHMA6ZBWDZY5GPZPWAIST75/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 61 +++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index aaa72dc..ae87807 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -575,7 +575,8 @@ static int check_regions(struct ndctl_bus *bus, struct region *regions, int n,
 					ndctl_region_get_type_name(region));
 			return -ENXIO;
 		}
-		if (ndctl_region_get_interleave_ways(region) != regions[i].interleave_ways) {
+		if (ndctl_bus_has_nfit(bus) &&
+		    ndctl_region_get_interleave_ways(region) != regions[i].interleave_ways) {
 			fprintf(stderr, "%s: expected interleave_ways: %d got: %d\n",
 					devname, regions[i].interleave_ways,
 					ndctl_region_get_interleave_ways(region));
@@ -2516,20 +2517,21 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 			return -ENXIO;
 		}
 
-		if (ndctl_dimm_has_errors(dimm) != !!dimms[i].flags) {
-			fprintf(stderr, "bus: %s dimm%d %s expected%s errors\n",
+		if (ndctl_bus_has_nfit(bus)) {
+			if (ndctl_dimm_has_errors(dimm) != !!dimms[i].flags) {
+				fprintf(stderr, "bus: %s dimm%d %s expected%s errors\n",
 					ndctl_bus_get_provider(bus), i,
 					ndctl_dimm_get_devname(dimm),
 					dimms[i].flags ? "" : " no");
-			return -ENXIO;
-		}
+				return -ENXIO;
+			}
 
-		if (ndctl_dimm_failed_save(dimm) != dimms[i].f_save
-				|| ndctl_dimm_failed_arm(dimm) != dimms[i].f_arm
-				|| ndctl_dimm_failed_restore(dimm) != dimms[i].f_restore
-				|| ndctl_dimm_smart_pending(dimm) != dimms[i].f_smart
-				|| ndctl_dimm_failed_flush(dimm) != dimms[i].f_flush) {
-			fprintf(stderr, "expected: %s%s%s%s%sgot: %s%s%s%s%s\n",
+			if (ndctl_dimm_failed_save(dimm) != dimms[i].f_save
+			    || ndctl_dimm_failed_arm(dimm) != dimms[i].f_arm
+			    || ndctl_dimm_failed_restore(dimm) != dimms[i].f_restore
+			    || ndctl_dimm_smart_pending(dimm) != dimms[i].f_smart
+			    || ndctl_dimm_failed_flush(dimm) != dimms[i].f_flush) {
+				fprintf(stderr, "expected: %s%s%s%s%sgot: %s%s%s%s%s\n",
 					dimms[i].f_save ? "save_fail " : "",
 					dimms[i].f_arm ? "not_armed " : "",
 					dimms[i].f_restore ? "restore_fail " : "",
@@ -2540,24 +2542,25 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 					ndctl_dimm_failed_restore(dimm) ? "restore_fail " : "",
 					ndctl_dimm_smart_pending(dimm) ? "smart_event " : "",
 					ndctl_dimm_failed_flush(dimm) ? "flush_fail " : "");
-			return -ENXIO;
-		}
+				return -ENXIO;
+			}
 
-		if (ndctl_test_attempt(test, KERNEL_VERSION(4, 7, 0)) &&
-		    ndctl_bus_has_nfit(bus)) {
-			if (ndctl_dimm_get_formats(dimm) != dimms[i].formats) {
-				fprintf(stderr, "dimm%d expected formats: %d got: %d\n",
+			if (ndctl_test_attempt(test, KERNEL_VERSION(4, 7, 0))) {
+				if (ndctl_dimm_get_formats(dimm) != dimms[i].formats) {
+					fprintf(stderr, "dimm%d expected formats: %d got: %d\n",
 						i, dimms[i].formats,
 						ndctl_dimm_get_formats(dimm));
-				return -ENXIO;
-			}
-			for (j = 0; j < dimms[i].formats; j++) {
-				if (ndctl_dimm_get_formatN(dimm, j) != dimms[i].format[j]) {
-					fprintf(stderr,
-						"dimm%d expected format[%d]: %d got: %d\n",
+					return -ENXIO;
+				}
+				for (j = 0; j < dimms[i].formats; j++) {
+					if (ndctl_dimm_get_formatN(dimm, j) !=
+					    dimms[i].format[j]) {
+						fprintf(stderr,
+							"dimm%d expected format[%d]: %d got: %d\n",
 							i, j, dimms[i].format[j],
 							ndctl_dimm_get_formatN(dimm, j));
-					return -ENXIO;
+						return -ENXIO;
+					}
 				}
 			}
 		}
@@ -2623,6 +2626,7 @@ static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	struct ndctl_bus *bus = ndctl_bus_get_by_provider(ctx, NFIT_PROVIDER0);
 	struct ndctl_region *region;
 	struct ndctl_dimm *dimm;
+	unsigned num_regions = ARRAY_SIZE(regions0);
 	int rc;
 
 	if (!bus)
@@ -2658,22 +2662,25 @@ static int do_test0(struct ndctl_ctx *ctx, struct ndctl_test *test)
 				* ndctl_region_get_interleave_ways(region));
 	}
 
+	if (!ndctl_bus_has_nfit(bus))
+		num_regions = 1;
+
 	/* pfn and dax tests require vmalloc-enabled nfit_test */
 	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
-		rc = check_regions(bus, regions0, ARRAY_SIZE(regions0), DAX);
+		rc = check_regions(bus, regions0, num_regions, DAX);
 		if (rc)
 			return rc;
 		reset_bus(bus);
 	}
 
 	if (ndctl_test_attempt(test, KERNEL_VERSION(4, 8, 0))) {
-		rc = check_regions(bus, regions0, ARRAY_SIZE(regions0), PFN);
+		rc = check_regions(bus, regions0, num_regions, PFN);
 		if (rc)
 			return rc;
 		reset_bus(bus);
 	}
 
-	return check_regions(bus, regions0, ARRAY_SIZE(regions0), BTT);
+	return check_regions(bus, regions0, num_regions, BTT);
 }
 
 static int do_test1(struct ndctl_ctx *ctx, struct ndctl_test *test)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
