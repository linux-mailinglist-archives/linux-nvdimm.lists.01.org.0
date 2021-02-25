Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09251324A6E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 25 Feb 2021 07:13:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BA14B100F224F;
	Wed, 24 Feb 2021 22:13:21 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9F3C3100F224F
	for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z7so2621309plk.7
        for <linux-nvdimm@lists.01.org>; Wed, 24 Feb 2021 22:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Vgl9Y4OYOa6q+Jg6IebbG7CPmzxNl71ZksxhDAHmug=;
        b=F2MvFHKYJx1fBqiqDqfWBJYYT7nvrPfyvBt/a95xDdDI+Z0NY6suIZOTsoSafk47lk
         p95LYVIjRCfARy5ppEWIJtRAuNAHNq65/keL6qlHv9xICOAhC3jIeefxG/0IVzFNBYo+
         EOWoHLQr9JSYZkDJUjJmWIe0AvSvGILIHkU6X8tR/K9W3qK+ibRx88fvuxPzq8hdgrDP
         YqvFgUQUYBYqm/n2q8y0vQx3KRRG3bGYBBlAynbErLjS6UfH5CD7TrmEQ+7w6Xsvu01g
         kYktrfVL/XtBeu1Shr/BoG7k5H9rjMOeL3tcJFhIVSLf/cta9DF4coGBJYkwjGbZNLjn
         is5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Vgl9Y4OYOa6q+Jg6IebbG7CPmzxNl71ZksxhDAHmug=;
        b=lXFUH1oPAg8abiMG3ynCun/J8hEwddNdP5xQQMKe1yxMNMpMvEt17Cg9gf55Pc+YxN
         v+XHVpcNJcy/lExX7FY7rn2QKcCf1ZrBZ111hqfTMpwhLIgDD9SZSimKCDTPwnl0scFA
         5ro8zkGPKLQU57Q+XCVVExaw+gPpcWS1VZOSky5eVtKbSVqLvGn0blwJMp7jykjCZSj+
         aSLv38O79szSusnDIVp1KWNQnpatZB2UDOk5CzGWfs9aczzn172jm5+4K2Us5LEZkh23
         yi6dbNQ8qPwYXMbkU82HAm6QSymDswUUMtJtkCsZbfRfZERgD8dZKZnVLzDMlRK3sniB
         wEZw==
X-Gm-Message-State: AOAM531Sq4twxN7L1L+25a6YEQORW0eJERQctOtYEVHK2U/tc3DB84Sh
	AR8O2A2qi8P9KzYyZDweVVNylsdNEhWKyg==
X-Google-Smtp-Source: ABdhPJzzGG8Npg6O1AkThj1UHEvsRpbeMufmRjCJgvQzAaLoYakBGK3RHxeF70XKXx6/0cOrMq2ZWQ==
X-Received: by 2002:a17:903:188:b029:e3:dd4b:f6c1 with SMTP id z8-20020a1709030188b02900e3dd4bf6c1mr1472866plg.81.1614233598937;
        Wed, 24 Feb 2021 22:13:18 -0800 (PST)
Received: from santosiv.in.ibm.com.com ([103.21.79.4])
        by smtp.gmail.com with ESMTPSA id d24sm4327803pfr.139.2021.02.24.22.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 22:13:18 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: Linux NVDIMM <linux-nvdimm@lists.01.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Vaibhav Jain <vaibhav@linux.ibm.com>,
	Shivaprasad G Bhat <sbhat@linux.ibm.com>,
	Harish Sriram <harish@linux.ibm.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH v2 3/4] test/libndctl: skip SMART tests on non-nfit devices
Date: Thu, 25 Feb 2021 11:43:02 +0530
Message-Id: <20210225061303.654267-3-santosh@fossix.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225061303.654267-1-santosh@fossix.org>
References: <20210225061303.654267-1-santosh@fossix.org>
MIME-Version: 1.0
Message-ID-Hash: G3AK2NUAKD5YXYTTHPCWQCNL3CR3UC7T
X-Message-ID-Hash: G3AK2NUAKD5YXYTTHPCWQCNL3CR3UC7T
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G3AK2NUAKD5YXYTTHPCWQCNL3CR3UC7T/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This is just a temporary check till the new module has SMART capabilities
emulated.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 test/libndctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/libndctl.c b/test/libndctl.c
index 5043ae0..001f78a 100644
--- a/test/libndctl.c
+++ b/test/libndctl.c
@@ -2427,7 +2427,8 @@ static int check_commands(struct ndctl_bus *bus, struct ndctl_dimm *dimm,
 	 * The kernel did not start emulating v1.2 namespace spec smart data
 	 * until 4.9.
 	 */
-	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0)))
+	if (!ndctl_test_attempt(test, KERNEL_VERSION(4, 9, 0))
+	    || !ndctl_bus_has_nfit(bus))
 		dimm_commands &= ~((1 << ND_CMD_SMART)
 				| (1 << ND_CMD_SMART_THRESHOLD));
 
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
