Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C8B2E055B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 22 Dec 2020 05:25:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 264D3100EBB6C;
	Mon, 21 Dec 2020 20:25:40 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6CEBA100EBB63
	for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:25:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so6773908plk.5
        for <linux-nvdimm@lists.01.org>; Mon, 21 Dec 2020 20:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UR0b9Vx28pxId35Bjzuwmw6gST+9eGp900CHGI46k94=;
        b=MAzvK0w+tjZ/LSy7cqytALy5xzOBYK2IeWMLJ2kKwnN1VF8bfyMAmokk0AYrF+bDPB
         1jPB00wzhe0gI4+0wCgjUQnAQYmms0MNxRVxa8KpbdF8+EnqOWNrWEGqvKI8fnAtFZdI
         D4rUo0C+KBFWYPaFAIueGK2bkv1vs6vpv9IJjwvTlNUNVSQiUIAqDw1tDRO/Su8ww0Mq
         rQ3YmneOFV6sQEqiEV94gTC0nROr85LNLEbU6Q83Yx3DYGfp6PISvrz//1c+hDxs5Ny7
         GkMJVhlwJhgC3zic0JQeGC6Ser4fd1i6im2F3LvdJeOrJUPvtOsm0KZ6wdN92qctkAM5
         5miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UR0b9Vx28pxId35Bjzuwmw6gST+9eGp900CHGI46k94=;
        b=PlA9Ji3wNyyAMwBVuREI+rL4mn5tkP6wXxwdUZDpRwmBi1ZgnmIFnTu6whOqPsFf5M
         etsn/AD7uWcaQ0hxiTLQnrFBJl2bnIOxgLcIU5y1MILYjiUvxCUbLCZgN6kuvptN0/Nr
         vxKdgbj+47xxh0dCSktWctvLKJMVKQju8kte4g+8rAhnk6kaxIhLPNjzwkdoNGmy+RmP
         I3W9OeCoHGNods6fwvJ9pX++D5O/eIUEC9hBWx30Zf0czbn+jxg+xEIAbReaCfjLBl9R
         hItDW8YM394E4k8PGXLx7mjZLtFmZ2Q5rjyNRqtZ7RM25x3tpurtRiwdRAYn5/8NW9mh
         6Z2g==
X-Gm-Message-State: AOAM531ziRKaBsNsU4PAaySWfkKRQNgBcsTC5zZaR+rIYentTxjuk/aW
	klZunQLAnCBax2InQAwMZwa7Lqfv+tAW/A==
X-Google-Smtp-Source: ABdhPJxsH9fOt01gUalGEpVNetn6lpD9AqjRGMYauu/jJ/moh62NArjCBX2fLNj8HmQu8wHHaOmvvw==
X-Received: by 2002:a17:902:6b0a:b029:dc:31af:8dc3 with SMTP id o10-20020a1709026b0ab02900dc31af8dc3mr16095874plk.41.1608611137924;
        Mon, 21 Dec 2020 20:25:37 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id z13sm17765992pjt.45.2020.12.21.20.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 20:25:37 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [ndctl 3/5] papr: Add support to parse save_fail flag for dimm
Date: Tue, 22 Dec 2020 09:55:14 +0530
Message-Id: <20201222042516.2984348-3-santosh@fossix.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222042516.2984348-1-santosh@fossix.org>
References: <20201222042240.2983755-1-santosh@fossix.org>
 <20201222042516.2984348-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: LWPNX24QT77ARPC4N34SBXEO5GTGYONF
X-Message-ID-Hash: LWPNX24QT77ARPC4N34SBXEO5GTGYONF
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LWPNX24QT77ARPC4N34SBXEO5GTGYONF/>
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
