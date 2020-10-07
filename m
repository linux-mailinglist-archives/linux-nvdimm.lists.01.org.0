Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EA28578E
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 30A8D158AFE9B;
	Tue,  6 Oct 2020 21:23:56 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B3CC3158AFE8F
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h2so343493pll.11
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bEQQpPBhKYIjumWhlp6ZL4duPY0RyBSbAwtayqOsAY=;
        b=I0K+GgCQ8ojEnFaHmzbVijZBvd4+dcbD5fWcgZlIeogAyx30jKKFvKX1wZR61hLxZB
         Wccn8/H35bvtVENI+XBZkyep/6wIXUYzy8Z6qFLt+bf56InglDBLuKN8wszUPUebJr+2
         4orU5YUDd1/mQf/xofkuYFK6Si6gVEZ0Dtz+F5A8KI6kx9E/4esINTStfGJiSL7K3eOm
         dI6peeATt2IARevGQUdeYfX3FaAvvH8/djEuJvuaXcqr6MdfCm0QnjCbBE/wuqLnmrwL
         7e49CgE7m4nvr68V9MA2G6+n/kDTVl5J3ueNVV5A4ZCW76XWWAcdlEZApzC0eYgPY4iz
         u0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bEQQpPBhKYIjumWhlp6ZL4duPY0RyBSbAwtayqOsAY=;
        b=tB020kRViSb4/fN2lYY3f0B/ZypewQ/Cj70g3tLgIphOrX3lz6/atPTCZzNdPHCw6N
         VVbv7LBO1gb2rbY94sRv3nHeet3muTaa8e26RcSfVUGKutlxdo0cSeaxtG1TXNIk+/R9
         e7+TchppAD/No9YX8MQ4HdyuTuuNXiYlHPPyW/qaLAj9brVHMtgpH8qpTYecLxpMgIrL
         pupUHG10auvKw3SjKP4x++vNiPbVVlzXNd8TM2v8W881f4lu+g571/VSwFkM/LQTG8Zm
         Dh50Enc/WySy+M+WWIPQVdu2ef5+NJZuQKs6Ec19ho29Up4whbBDYVmXZ1Ih2TjWTR7s
         JpHQ==
X-Gm-Message-State: AOAM532lkWYXQ/y4L9u3drsVbvoQguhfdByKJUUJTcrjeaWoy4S76RdV
	dZnB3/qq4wG8jGrnoO30xLfnsu7Ns9PZWg==
X-Google-Smtp-Source: ABdhPJx918HpsgyHOdosFjAVu5iJ4dT3bO6jqeq5z75/fk5i/Du0ZLugAeEjmbqUVTZfuA4pTQQa3g==
X-Received: by 2002:a17:90a:cb05:: with SMTP id z5mr1263320pjt.92.1602044632206;
        Tue, 06 Oct 2020 21:23:52 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:51 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 8/9] test/multi-pmem: fix for no-interleave support
Date: Wed,  7 Oct 2020 09:52:55 +0530
Message-Id: <20201007042256.1110626-8-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: YSZUWLRNK6U2Y5MXIXKZJ2IA3ZPYNNAV
X-Message-ID-Hash: YSZUWLRNK6U2Y5MXIXKZJ2IA3ZPYNNAV
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YSZUWLRNK6U2Y5MXIXKZJ2IA3ZPYNNAV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/multi-pmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/multi-pmem.c b/test/multi-pmem.c
index 668662c..ef4fec0 100644
--- a/test/multi-pmem.c
+++ b/test/multi-pmem.c
@@ -208,6 +208,14 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
 			break;
 	}
 
+	/* FIXME: the above expects the a blk region to be available on the
+	 * previously identified dimm, which won't if we don't have interleaved
+	 * support
+	 */
+
+	if (!region)
+		goto no_interleave;
+
 	blk_avail_orig = ndctl_region_get_available_size(region);
 	for (i = 1; i < NUM_NAMESPACES - 1; i++) {
 		ndns = namespaces[i];
@@ -239,6 +247,7 @@ static int do_multi_pmem(struct ndctl_ctx *ctx, struct ndctl_test *test)
 	if (check_deleted(target, devname, test) != 0)
 		return -ENXIO;
 
+no_interleave:
 	ndctl_bus_foreach(ctx, bus) {
 		if (strncmp(ndctl_bus_get_provider(bus), "nfit_test", 9) != 0)
 			continue;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
