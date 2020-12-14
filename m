Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D3C2D967B
	for <lists+linux-nvdimm@lfdr.de>; Mon, 14 Dec 2020 11:41:51 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63BE8100ED487;
	Mon, 14 Dec 2020 02:41:50 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1043; helo=mail-pj1-x1043.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 252F4100EF276
	for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:48 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id lb18so6064879pjb.5
        for <linux-nvdimm@lists.01.org>; Mon, 14 Dec 2020 02:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR0b9Vx28pxId35Bjzuwmw6gST+9eGp900CHGI46k94=;
        b=XsaAITlpYWAD+wFREpsCijrzqzYOm7wu4FqeTTjNmkKZnGoye3E2gSTv8hsxrdRw14
         wgZ4I7YYGkyxvdXs15vzRzbh7oFgm3PQWriGeejBYU85pltjLIwfRoACESeaC4TIuu+Q
         jnLtPtzFYU/PbcCsafbe/HHMAEvFvKpzR/5RBvp3L8+WvVSECxCjXTVRa09h/xcTggpA
         nIH+5mcbf8tE5SqPle5Gt70ArIXDy5sH22JLDSU8uzG+qaPrAHjVXONzQwU2j6ZX/fMZ
         LOFz9Bpf4jUYdcXYM69YlZXSXOsGQG8ZiFjH+ecJWYNOBlpfd+OxyiyapBzRPq4Y6W4f
         Hdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR0b9Vx28pxId35Bjzuwmw6gST+9eGp900CHGI46k94=;
        b=prVH7b9WA6Q/VhOW+yz5Zy+bUE0x6q5mbMyFEFPjK9Hq86UgHfHNf19o485wlvSPml
         Ex0dudp/yLj2cJvoozhf9srov2jJQsIXu7ySgprA1smsQAVXLD0TUOCm1xTMPmYwuooE
         Avyc6Wo5NkyqvX8Ia22XjweUtj4MKbet8LjsO3NfGBeTaZvEZLdLuddzBcfGymUP4iuq
         7Y+S0//ZWQO96HfgrCJ9i+PsSKk1Q/GbuSOxWVx2TPpWKTdnQXXE+5rz0xm6gREecoem
         CB3MK0IKNoKigq4eo/KRkX3XzwPDQ/yd5+AE0lDTHV6GO00jrXif2ZejthgbNP8XjM+D
         CGhQ==
X-Gm-Message-State: AOAM5320vBaHo6v+ucLNe3JX8GOvx73IhnYW0M6oV1La8fT/UaQc9awu
	zgONWZ7vrzHUWECHsdT51G00YAtXZvx1WA==
X-Google-Smtp-Source: ABdhPJzYG+ShTYYDtjZEONr+/O53uO4ibrqsFvyRU0NIz6+Ip7fTup/Il4eJccBZzSphdOjN6BLI5Q==
X-Received: by 2002:a17:90a:2b88:: with SMTP id u8mr7926738pjd.161.1607942507590;
        Mon, 14 Dec 2020 02:41:47 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id f193sm6208581pfa.81.2020.12.14.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 02:41:47 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl RFC v5 3/5] papr: Add support to parse save_fail flag for dimm
Date: Mon, 14 Dec 2020 16:11:24 +0530
Message-Id: <20201214104126.2410043-3-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214104126.2410043-1-santosh@fossix.org>
References: <20201214103859.2409175-1-santosh@fossix.org>
 <20201214104126.2410043-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: NYZUDOFVXKRHFYWEBTGE3HTCRFZ5Y6JN
X-Message-ID-Hash: NYZUDOFVXKRHFYWEBTGE3HTCRFZ5Y6JN
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NYZUDOFVXKRHFYWEBTGE3HTCRFZ5Y6JN/>
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
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
