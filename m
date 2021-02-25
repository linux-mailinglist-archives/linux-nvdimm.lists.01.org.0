Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08358324A6D
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 07:13:19 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9F240100F2243;
	Wed, 24 Feb 2021 22:13:17 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1CF3E100F2243
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:15 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q204so1869402pfq.10
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BvIuIKkdW9j0AHuyohk7gLtOKcKtkr3zFaTFC3boKqc=;
        b=nafdjHrjCc3xu9uG6bfqimsiIz4dcBkLWl5q+HyGQ8ILkmg8J5yWJtE26uJs4XIWXM
         M3WWFtQK3egtukZSPwgGrZvofGwg5UginpCcNzNteNFRdRF8LiGpznj3dauZlJGjNOD5
         EUdcNaiezSxgEcO4VVds21gezzNpwdc4+HFaGQ/j1R0x0DBImqH7DLLIeIZ30aGtFs6B
         awxs9Ui6fj3Qyb9Pko+JI3JK5NHmPoToUN/COi8FXRzQtkvJse+qbqSECjjquK3/Mn3V
         av1R25QcPH/33iO1hQ0e4zZfS+FPy1vmjNJR3oF16My0jOZ00c/Y7QAT4aOVtSv2XuVl
         Oqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BvIuIKkdW9j0AHuyohk7gLtOKcKtkr3zFaTFC3boKqc=;
        b=gNP7xi9QV9pDMCmpn9qnFGVTs9nPELR95TdV2rm9uDD8uAM5w1E1/SB0/T0mzmhXSM
         0sX0XEuBCMBIizyXlwX8XtrCEy85kk/Lj18HvITXkMKpOx7gFs5jyK1VpOcqMzfY4GGl
         o0hQv4fge2CHYnqeaf7NhH6l2PqZcJ9Aa1yTOvYJMU7K8dzvhd6/0wDgq90TW+y8YkkM
         hKYHjcisnPiBs39od1S3Urdhz0VylYPdSTUDDvXWCUCPvJPD0sT6Z0L7vJTejUXFcvDN
         22SrScUzozf8ZyKRUb2M44PnqbUKdlmQQ5+bTMa9GJ2BIuARlOE2nvfqSWjWDGQpiwiN
         G8Kg==
X-Gm-Message-State: AOAM530TFmQRmmNhBfv22MOBvOMWduWSRURqFAavZiykIwgFqPqAxbCQ
	llmiVL4vsp8YbT71QvXV/NqV/s9wZfTUbQ==
X-Google-Smtp-Source: ABdhPJz1Npcns3TO68e9726TMU4BR235ylkfOz4bTeRptXW1A9szgL1CMXW0xFw3gZjUepF1WCbCLw==
X-Received: by 2002:aa7:94b7:0:b029:1ed:c7e8:d7f3 with SMTP id a23-20020aa794b70000b02901edc7e8d7f3mr1796917pfl.28.1614233594476;
        Wed, 24 Feb 2021 22:13:14 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d24sm4327803pfr.139.2021.02.24.22.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:13:14 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH v2 2/4] papr: Add support to parse save_fail flag for dimm
Date: Thu, 25 Feb 2021 11:43:01 +0530
Message-Id: <20210225061303.654267-2-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225061303.654267-1-santosh@fossix.org>
References: <20210225061303.654267-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: RF5MYFSLWVV64UCLJCA3X3WWWKORTFPL
X-Message-ID-Hash: RF5MYFSLWVV64UCLJCA3X3WWWKORTFPL
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RF5MYFSLWVV64UCLJCA3X3WWWKORTFPL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This will help in getting the dimm fail tests to run on papr family too.
Also add nvdimm_test compatibility string for recognizing the test module.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 ndctl/lib/libndctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ndctl/lib/libndctl.c b/ndctl/lib/libndctl.c
index 5f09628..3fb3aed 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -815,6 +815,8 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
 			dimm->flags.f_restore = 1;
 		else if (strcmp(start, "smart_notify") == 0)
 			dimm->flags.f_smart = 1;
+		else if (strcmp(start, "save_fail") == 0)
+			dimm->flags.f_save = 1;
 		start = end + 1;
 	}
 	if (end != start)
@@ -1044,7 +1046,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
 	if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
 		return 0;
 
-	return (strcmp(buf, "ibm,pmemory") == 0);
+	return (strcmp(buf, "ibm,pmemory") == 0 ||
+		strcmp(buf, "nvdimm_test") == 0);
 }
 
 /**
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
