Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89EA336D47
	for <lists+linux-nvdimm@lfdr.de>; Thu, 11 Mar 2021 08:48:56 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3052A100F2257;
	Wed, 10 Mar 2021 23:48:54 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 71508100F2255
	for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso6400179pjb.4
        for <linux-nvdimm@lists.01.org>; Wed, 10 Mar 2021 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJyJaAot47MG4PJfNO9pFZfOa0ecfqouA9e2QJYVsEA=;
        b=kmpgBSqF9Su/0kICrfwjIRWT/Mk+5hjQgjmug9xNRa7yRlWcHoVz22Mxetr42aDlNk
         LAeDjwek7eYBhoOLkidLUVaDYr9LqYNfzwGLop4D0HmgO4q7jWlnGR4cVIQeNzMyadi2
         o6379Tl870Bp6Voc7CFu6nq2jtXM3ddvIQNnZBL6bfTp9T4b4uRF76hkdNhB2rtOlTAQ
         KYFp4Zv1G1dxsk9XZDqHaJFRkvSOHoH6uXX7dtY6ruxXb4h2dIuzurwQP7eOqLpgQ7Eh
         6bGJzb/YqOgDRg/6dp1eAI5VdspzuX5DOTbUBv5TANZNSBxlSY+f0JsaKNvw8IUJGOTb
         k1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJyJaAot47MG4PJfNO9pFZfOa0ecfqouA9e2QJYVsEA=;
        b=NkPifo5HmX9bjkNKQtLSsjz4kiNfkHnAaf/y57TDdMAEUDFMapWWineLqzr2HuVoDX
         pEv+qLMdftA6gPjieitcJ4I3rzK7y25JoPcIODaeJKpjMC4Ln81NwFGrS1PvRZbQCyZJ
         mJFzFh/Ht7NJVRmyEARAP5Uv+nDwXD7arO4F3geyiGIUNKKUIt8N1blYGvCPbUGxhKYO
         +XXIlokqTa8/sav9LPTp0Mia3iCrDyfEsInnVJqyIDaLtIXTakolQvjjzj1i5crIyAVt
         8PyN4E6pMv76bSvpQgs/PPAaFLpaFy7gmrJkalMapfNiWhxCrRPd/U/9Z3+UQ93lZSis
         ZQrg==
X-Gm-Message-State: AOAM530dLgBFJP0um6ZngpttBUswNp0Qi++oLw88pSVeIOpKmoNPFf0U
	yWKKobzO2MI2Q3/Uz0pwvhNevBC7F/heMw==
X-Google-Smtp-Source: ABdhPJzWSHlh1fktG0IoI+9L7+/sL6V9ukGX9fFb6ZhQxtam/7zIPotZwMp17efhijE8Lb8i4QBk1g==
X-Received: by 2002:a17:90a:ce92:: with SMTP id g18mr7816943pju.52.1615448931909;
        Wed, 10 Mar 2021 23:48:51 -0800 (PST)
Received: from localhost.localdomain ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id t13sm1528580pfe.161.2021.03.10.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 23:48:51 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl PATCH v3 3/4] papr: Add support to parse save_fail flag for dimm
Date: Thu, 11 Mar 2021 13:16:51 +0530
Message-Id: <20210311074652.2783560-3-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210311074652.2783560-1-santosh@fossix.org>
References: <20210311074652.2783560-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: XDFH3YKBQLPNSLSLS33EO4WPIKQLFLPZ
X-Message-ID-Hash: XDFH3YKBQLPNSLSLS33EO4WPIKQLFLPZ
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XDFH3YKBQLPNSLSLS33EO4WPIKQLFLPZ/>
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
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
