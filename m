Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B6285788
	for <lists+linux-nvdimm@lfdr.de>; Wed,  7 Oct 2020 06:23:38 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B07B158AFE94;
	Tue,  6 Oct 2020 21:23:37 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EFECB158AFE93
	for <linux-nvdimm@lists.01.org>; Tue,  6 Oct 2020 21:23:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c6so349397plr.9
        for <linux-nvdimm@lists.01.org>; Tue, 06 Oct 2020 21:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1EIyaD3Viq6ih5367pnJJGLoqnJ6AoXmmqtV85gsaY=;
        b=PrR+YAsRo8kStd46W20//R2XdhqfonwMde3m6o9GbiAp7uhBNs0FZWCT9z1Efo0FYE
         dmu3RNIv5y5UbUJX/9XtISCaDQBg25rr8v8nxLlCzAyH0ZE6o9TZP9Dce/FReHLDYMxb
         7Vr43emP2XqKtGQxAtiFffaDDIb/nREtTePjl8IBNnqVVjcG4ioxgqNaHB33rP0P148j
         0ovzuCXWGl89zN07HRIy43m+e0S3SFhqWSWm6/9lXWuEZgdJsBNdfuvKIHdGbRmU33ZJ
         i+vtkFm68+S1NsurQ45TO+kd+kd4piXw0yLU3HnG2JdVOvQ/yqY06cxvnRAziE5qf9/K
         aRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1EIyaD3Viq6ih5367pnJJGLoqnJ6AoXmmqtV85gsaY=;
        b=AV+mj+/W5OphfWFWlgSSgcc7VqBQdAqc37o8RPe1wrlnGuXkUkDvLlTCfBXBNtd3sj
         /eTIvEUTGpyZPP7rKkR9r8q7ZjkjYP/XaqiDtvzY5Q+piM2qf8UWIJ3ggTI9d+/Ke8pV
         whTbnSVA/EYjtYnWA271Uc26elh6YkAr/nXOMauTQ1ZyEOeUphuykDrkbiMpGiebaQ8n
         1USivGlzolm94FJ5vGeybwPFvk+5q2RK0QUKSq794ffuQ7xk1DnZuCAmV//7uXgpKy1N
         XJV3LCvMFA06DH5ltaN1XTZZ9itb/NoTDlYyhKrMUnnEHC1PJn0rWDJT7lNbu0AWAjeI
         knMA==
X-Gm-Message-State: AOAM533kc2buQy9wtf3Y2oY9/a1XV0ADygzUtWokdxUk5Wt2170aFOwv
	LDYmbweOYFCv1riUwKWf+ozeL2aEr15uWA==
X-Google-Smtp-Source: ABdhPJwMStTso1IqcWni+T6unOtIQMyU2pb7lOihKQQ1vVWkncNq6b6R7ZDOvAc2y2w4jwjMx/pXxg==
X-Received: by 2002:a17:90a:a606:: with SMTP id c6mr1192387pjq.15.1602044615392;
        Tue, 06 Oct 2020 21:23:35 -0700 (PDT)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t186sm844499pgc.49.2020.10.06.21.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 21:23:34 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH RFC ndctl 2/9] test/core: Don't fail is nfit module is missing
Date: Wed,  7 Oct 2020 09:52:49 +0530
Message-Id: <20201007042256.1110626-2-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007042256.1110626-1-santosh@fossix.org>
References: <20201006010013.848302-1-santosh@fossix.org>
 <20201007042256.1110626-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: PTCVAC35VASUWP6VT3VXNWN5IC43GT65
X-Message-ID-Hash: PTCVAC35VASUWP6VT3VXNWN5IC43GT65
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PTCVAC35VASUWP6VT3VXNWN5IC43GT65/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This will happen in platforms that don't have ACPI support.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/test/core.c b/test/core.c
index 5118d86..e3e93ff 100644
--- a/test/core.c
+++ b/test/core.c
@@ -195,6 +195,11 @@ retry:
 
 		path = kmod_module_get_path(*mod);
 		if (!path) {
+			/* For non-nfit platforms it's ok if nfit module is
+			 * missing */
+			if (strcmp(name, "nfit") == 0)
+				continue;
+
 			log_err(&log_ctx, "%s.ko: failed to get path\n", name);
 			break;
 		}
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
