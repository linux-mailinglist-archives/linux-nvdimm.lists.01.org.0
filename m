Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B488B37F2DD
	for <lists+linux-nvdimm@lfdr.de>; Thu, 13 May 2021 08:13:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8C09100EAB4D;
	Wed, 12 May 2021 23:13:09 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8FA67100EAB4C
	for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id l70so5654756pga.1
        for <linux-nvdimm@lists.01.org>; Wed, 12 May 2021 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMATeAaC5U+4603Cs/hY3PWfCR31dXQRgSVD/soPB5c=;
        b=K/CkRdqcfQ3u8k+APAV7iAzHMovWeuqZqm1ngTAWCmsIAu7guFbfQqyAde5n5LH0xR
         lJdAWkpglF34r2xYjaj462+sckUOQcGYXCT7RRzDTiDiAPs96+KdEEl9KHQ/7sJSWRmx
         mGa/kbxBndkLnDWllq/ONnUtneO/wMHP7V5j1CEgN3wyimZOe2BLOg/CaGsg9rYJZrka
         3yOqUEqbHRiyuioZE7+qh8l5zmT3JyHjYSlUW8fuZ4FUCBLo8Rk94YzUnwfz3m+fXGtp
         CVe6MIiDwJSlt0E82DUHGgkuWW/Mj3UjgtIUY9/4tvlTLdoca0BHKg2t5fncZFawZe55
         7dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMATeAaC5U+4603Cs/hY3PWfCR31dXQRgSVD/soPB5c=;
        b=jSXN4tcMgddcmKCF0QFym80WD39gRcX76v8l7+J36gPzSYvAT3smpoOm8YtCeWt8bo
         RO/sRgwW2GyiNLb3Mn6UoKrF7jUgItiFeoeZAv6W7tHtOWFGsAROdIaqqjn9OUzErYx1
         x/IWrlM2h1IAjaakJ+4y38f7cO6Ovx1+pSlVENKEeGKdH9kvuveEWjFZ881UNXqGESzJ
         NPspEZmR33HHCe4Y/um6HI5sXTiU3gZYzUXZOjuywlBmuN+PIDXadvbrMhXyhea95Ytq
         M+EYOWjUvi8CVaj0aqocOe5rU5BHBeAMDyWsJ7aiGj1XQRa4yLZDQRuwdz71WUg5krYL
         tNEg==
X-Gm-Message-State: AOAM532N9gS94aAl838tkwCgvp+DkGQg8tWmdI98yOhZ/svsN+UTnAO4
	d+90pvq62Ur3wSeLbWAp8v36jcL1zWIvRA==
X-Google-Smtp-Source: ABdhPJwEi1nVGk+Gkzd317x1xA9uW7M4K/NohdKAzdcjKfmZR+ZX9eNM6bKbSlgjEPsYJAdryXIB3Q==
X-Received: by 2002:a17:90a:fed:: with SMTP id 100mr44280018pjz.89.1620886387120;
        Wed, 12 May 2021 23:13:07 -0700 (PDT)
Received: from desktop.fossix.local ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id gf21sm1422351pjb.20.2021.05.12.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 23:13:06 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>
Subject: [ndctl V5 3/4] papr: Add support to parse save_fail flag for dimm
Date: Thu, 13 May 2021 11:42:17 +0530
Message-Id: <20210513061218.760322-3-santosh@fossix.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210513061218.760322-1-santosh@fossix.org>
References: <20210513061218.760322-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: Z5C2VTY76H46SNRSTBMSFXNRRPASKEJV
X-Message-ID-Hash: Z5C2VTY76H46SNRSTBMSFXNRRPASKEJV
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Shivaprasad G Bhat <sbhat@linux.ibm.com>, Harish Sriram <harish@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z5C2VTY76H46SNRSTBMSFXNRRPASKEJV/>
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
2.31.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
