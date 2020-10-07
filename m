Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E02285789
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 843EF158AFE91;
	Tue,  6 Oct 2020 21:23:42 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B284E158AFE8F
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:38 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 144so606562pfb.4
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhEnhhaAIXMwZicdW7v3DAVixzNb/bzFvAjbmO8Ldlc=;
        b=ZyG/FsK7jYdEUH6ZDounHhX65Qo0mAy06pVa2jzc+gGX1eRlQF7LQ/ZhKr4bY/FKem
         wzaWRDQF6Doxzj1gXG9WCjjOKDGmRC9RD+2OeNezZgN61YAmMG/qSIk6L3u+ycIwajW/
         5YfkNxDtusemsbQHZOI61wwg+ZcNm76BXOEQqV3JFj55VnYuymnyz563drDK8w9EnmA0
         sPWBuyqh9KhQN851vTIdNevkDg6tjA/NPNIEgjtrUKPL49S0mPIYhM7XHLsoQy6n62va
         70+Nx8iRTwFhA6mwmMpHnrm6oawLv399FXKWG3q7hExPq8KYNW7Fe3UaCm4iAFrsPQxt
         BRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhEnhhaAIXMwZicdW7v3DAVixzNb/bzFvAjbmO8Ldlc=;
        b=poiY6Q1SR/7kuVIHdxnYzPsiCVDZygc/jfObhz2t9oIYZ1EHZNsSlKp3PKAllpkeR2
         ikiKKrYgHJUoPgYYR1naGzyXQD4qEEOJVtv+u2fZHiJm2ZJAXlF5zjWEDoT3VLk9S46r
         QhaeWOpBKr/BzpSkma55aBDeGUxtkIJKoi2jbh8gFoZ2sRHZSoQAa3K/QblNAeP7Y7dx
         WAWeGMpLPPpPlUinD9SuXSMCxdcX2xEDuYaZgikR57lTSUWvhALXUIM8VZZ/7tCQofCM
         PKwguTjZk2V+saGTu8sSObXKlIx4i/hEk/Qm5bFWViGgKJkHBde/wYZV9YS1561LL3b7
         qGSA==
X-Gm-Message-State: AOAM532SHagjlape3VUAHk719NZdxT+Ye64Z/KX12g9uw34KtAqZKbUs
	2nalQ8BFEPcI0EVImqjA+RIeQassD2gRdg==
X-Google-Smtp-Source: ABdhPJzeCjlxYI6dZq/ZYWLFL30GJVtNc2AgErLY3+wO4y7MsPziP77nNY85TkYbcQtVkMY0d9FdJQ==
X-Received: by 2002:a63:cd51:: with SMTP id a17mr1379348pgj.167.1602044618147;
        Tue, 06 Oct 2020 21:23:38 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:37 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 3/9] test/libndctl: Don't compare phys-id if no-interleave support
Date: Wed,  7 Oct 2020 09:52:50 +0530
Message-Id: <20201007042256.1110626-3-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: U6G335G3SRBCCVYOMC42743JQXVPZHAF
X-Message-ID-Hash: U6G335G3SRBCCVYOMC42743JQXVPZHAF
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U6G335G3SRBCCVYOMC42743JQXVPZHAF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The tests expect some regions to have the same physical id, but that
will not be the case if there is no interleave support.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 994e0fa..d508948 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2484,7 +2484,8 @@ static int check_dimms(struct ndctl_bus *bus, struct dimm *dimms, int n,
 			return -ENXIO;
 		}
 
-		if (ndctl_dimm_get_phys_id(dimm) != dimms[i].phys_id) {
+		if (ndctl_bus_has_nfit(bus) &&
+		    ndctl_dimm_get_phys_id(dimm) != dimms[i].phys_id) {
 			fprintf(stderr, "dimm%d expected phys_id: %d got: %d\n",
 					i, dimms[i].phys_id,
 					ndctl_dimm_get_phys_id(dimm));
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
