Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB834BA6F
	for <lists+linux-nvdimm@lfdr.de>; Sun, 28 Mar 2021 04:10:24 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7F2FD100EBBCE;
	Sat, 27 Mar 2021 19:10:20 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65BAE100ED4A2
	for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 19:10:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q5so7496601pfh.10
        for <linux-nvdimm@lists.01.org>; Sat, 27 Mar 2021 19:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHy0HCSsdjzHPMQIH/8nG6HvMn0OJPybxvznNn6+fVo=;
        b=GBG5z94JZ0PmbCmlcq7e4AmOFSMtnp8kwcvH1xiLpsdAyRmw/G4bPyFjuPHZE5o0jr
         U3Mxbd3d+rhXdO6PC7cB5OL/Xpbtg9g0GUF7UQHxtXNYXUp6Zcoj5l1IhyNhY+Vh25Lg
         TZS5EJGeZUVA62tNwVHPSyefsHlGXLlCKWla/i2CQSiyinG5PIzuD4CMw/+tIXVxDWAL
         I1cm9ljk6dGHoW+4GRfZINqE1QWn+ywDmZfevQWPtxb6ae7npPt2iG5yC8ITZscUabyH
         Bc6aAQVkjc/asgLSbhbasKwPrT/B8bLbJetmJUeso4z44RI2hJuEQSHUm/3YGUJhsEAB
         beMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHy0HCSsdjzHPMQIH/8nG6HvMn0OJPybxvznNn6+fVo=;
        b=f782Emc9+rkYvdI9ZqHF+hZkTHycLr0iVQlMkx2P1/fYtOn8RH1gzUrcaMS0z0xhFu
         Xs95+sCi2etrPY9B7dn1ftd3+2STvI0siPM4pzX8DUfoHib49yep8WtcyWuRU63YroyD
         yybCNv+6i07R2vHY2uYbH8D2qoPa00v/QGNxihZ0Pf4M/3Cz/cCH35RJ+cYhjHTkwCv0
         8t5CdTxVZGdXaDTAScflYSN+9cJ3gXaJL1JPpaUZHpd7SjnxuF2JYNq/TMevCb+dkZtS
         A2zCP/hj1Y7mp5oP9r2M2w7a7nSXpMJQGSso1VMYYHUdAhtNhLjfaPU2PPw5isOwi6qE
         f33Q==
X-Gm-Message-State: AOAM530sPNpadOnzSG83lTH0gXelLH3BuPvdXd2npN/Pm567+skpyCmv
	tj30pEJfzy/CpmG0b0x9opfvpRP0ShROfg==
X-Google-Smtp-Source: ABdhPJxk64KiEAowC2cOIWzIi0p+NV9EksImIKze1/kYjPaCAWmh1WZEHWFaOOBviw45WnrYuyfo7A==
X-Received: by 2002:a63:5c23:: with SMTP id q35mr18632767pgb.418.1616897417640;
        Sat, 27 Mar 2021 19:10:17 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gb1sm11754148pjb.21.2021.03.27.19.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 19:10:17 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 3/4] papr: Add support to parse save_fail flag for dimm
Date: Sun, 28 Mar 2021 07:40:00 +0530
Message-Id: <20210328021001.2340251-3-santosh@fossix.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210328021001.2340251-1-santosh@fossix.org>
References: <20210328021001.2340251-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: 7KOXOOCGKMDXJRHOFUJUKWDST2LCQEVT
X-Message-ID-Hash: 7KOXOOCGKMDXJRHOFUJUKWDST2LCQEVT
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7KOXOOCGKMDXJRHOFUJUKWDST2LCQEVT/>
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
index 26b9317..dd1a5fc 100644
--- a/ndctl/lib/libndctl.c
+++ b/ndctl/lib/libndctl.c
@@ -805,6 +805,8 @@ static void parse_papr_flags(struct ndctl_dimm *dimm, char *flags)
 			dimm->flags.f_restore = 1;
 		else if (strcmp(start, "smart_notify") == 0)
 			dimm->flags.f_smart = 1;
+		else if (strcmp(start, "save_fail") == 0)
+			dimm->flags.f_save = 1;
 		start = end + 1;
 	}
 	if (end != start)
@@ -1035,7 +1037,8 @@ NDCTL_EXPORT int ndctl_bus_is_papr_scm(struct ndctl_bus *bus)
 	if (sysfs_read_attr(bus->ctx, bus->bus_buf, buf) < 0)
 		return 0;
 
-	return (strcmp(buf, "ibm,pmemory") == 0);
+	return (strcmp(buf, "ibm,pmemory") == 0 ||
+		strcmp(buf, "nvdimm_test") == 0);
 }
 
 /**
-- 
2.30.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
