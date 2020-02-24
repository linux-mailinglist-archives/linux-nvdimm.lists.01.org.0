Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0157E169C1F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:08:22 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E0C810FC33E8;
	Sun, 23 Feb 2020 18:09:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3etbtxgykdlywzahrwckkcha.ykihejqt-jrzeiiheopo.wx.knc@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7776710FC33E7
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:09:10 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id 36so4283279plc.12
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TTWq2HAMIWzKgBL7Xe45vNa7b1DEMoXXBFSs7M828Vo=;
        b=kJZgCePMmoxwA2xDEAPwUZmHtat6929L1+S4W8sNm4SjPsz1lNFd5rhvU8L0yzXAP4
         rcE6/ANzHRN09BnKZ9+yl1v5Ku5Ihl8A5hZbFNQVCoxh+iX5Y4vDOxxl7C3y0ifWWGME
         AVgAOmvnqo68lf+lsCTX64xV8O+AvAKhDjxAL/msdLzlmpNdY6HK8y+OvqgWKL6qdKkR
         8YoVFcIkWHgF2nltRXaDDfOzN4wAaD4It2dEXMPIGxUuQ/CK/RKWtQ9FIsCBSAcgLCuO
         yzpHLAWXUwxyFSCa3jOj+4rYUCFJT+H7nKnOoe/v2D1tLLPcn3nJuTq0QEKzvQCy2JBb
         O5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TTWq2HAMIWzKgBL7Xe45vNa7b1DEMoXXBFSs7M828Vo=;
        b=bJf611sAGOMLEh1uxFRQRT5xi/7TS6PapKZkOYWcuHt75Hod3D+Et2DLDqR68Wz0g3
         UAPHo5icVVi2A5yUEbnhKUk21lrNFmLcTCjBfnpFE1218kRuzs1ZxLzCOUprI3k+ZiS+
         24s+V544P846nPUDkbxOHeIyLGwavo7uAImSTcGshHqqm3Mnffn8TPPKEO83UTkHNQlg
         d5elXuUCxWb2Y1GX9j/m9d622NspLJhx42DEIQFiCpwMoBoPRxB62BqeSnMyveX7xBEw
         FsXchNnAX7s9oKWMf4jx9ZRwUbsDcLn9EMTD480X9xKuOp3rKwRNOb9XP2QVAJYaBc47
         scww==
X-Gm-Message-State: APjAAAX5vw3FF63OAWnx8U+MO7f7u8gvfkqTyClqa/FBIR1kYXX4ZHY6
	kXVAPM4GmWF7aIFhQ1ZlBRjmxkS7vVA=
X-Google-Smtp-Source: APXvYqy3+lHEJgJYcJNPNBHbt3vzQS08gQtp0v+NV+Un3Tbvyi8fw9vGD/+7qqprOjXR7zGnFnF9cUYziBY=
X-Received: by 2002:a63:3407:: with SMTP id b7mr23534176pga.163.1582510097904;
 Sun, 23 Feb 2020 18:08:17 -0800 (PST)
Date: Sun, 23 Feb 2020 18:08:13 -0800
Message-Id: <20200224020815.139570-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 1/3] libnvdimm/of_pmem: factor out region registration
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: 4M7OW776GNONSFS7OY27LTWEWU7LP35M
X-Message-ID-Hash: 4M7OW776GNONSFS7OY27LTWEWU7LP35M
X-MailFrom: 3ETBTXgYKDLYWZahrWckkcha.Ykihejqt-jrZeiiheopo.wx.knc@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4M7OW776GNONSFS7OY27LTWEWU7LP35M/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Kenny Root <kroot@google.com>

From: Kenny Root <kroot@google.com>

Factor out region registration for 'reg' node. A follow-up change will
use of_pmem_register_region() to handle memory-region nodes too.

Signed-off-by: Kenny Root <kroot@google.com>
Signed-off-by: Alistair Delva <adelva@google.com>
Reviewed-by: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: devicetree@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: kernel-team@android.com
---
 drivers/nvdimm/of_pmem.c | 60 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 8224d1431ea9..fdf54494e8c9 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -14,6 +14,39 @@ struct of_pmem_private {
 	struct nvdimm_bus *bus;
 };
 
+static void of_pmem_register_region(struct platform_device *pdev,
+				    struct nvdimm_bus *bus,
+				    struct device_node *np,
+				    struct resource *res, bool is_volatile)
+{
+	struct nd_region_desc ndr_desc;
+	struct nd_region *region;
+
+	/*
+	 * NB: libnvdimm copies the data from ndr_desc into it's own
+	 * structures so passing a stack pointer is fine.
+	 */
+	memset(&ndr_desc, 0, sizeof(ndr_desc));
+	ndr_desc.numa_node = dev_to_node(&pdev->dev);
+	ndr_desc.target_node = ndr_desc.numa_node;
+	ndr_desc.res = res;
+	ndr_desc.of_node = np;
+	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
+
+	if (is_volatile)
+		region = nvdimm_volatile_region_create(bus, &ndr_desc);
+	else
+		region = nvdimm_pmem_region_create(bus, &ndr_desc);
+
+	if (!region)
+		dev_warn(&pdev->dev,
+			 "Unable to register region %pR from %pOF\n",
+			 ndr_desc.res, np);
+	else
+		dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
+			ndr_desc.res, np);
+}
+
 static int of_pmem_region_probe(struct platform_device *pdev)
 {
 	struct of_pmem_private *priv;
@@ -46,31 +79,8 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 			is_volatile ? "volatile" : "non-volatile",  np);
 
 	for (i = 0; i < pdev->num_resources; i++) {
-		struct nd_region_desc ndr_desc;
-		struct nd_region *region;
-
-		/*
-		 * NB: libnvdimm copies the data from ndr_desc into it's own
-		 * structures so passing a stack pointer is fine.
-		 */
-		memset(&ndr_desc, 0, sizeof(ndr_desc));
-		ndr_desc.numa_node = dev_to_node(&pdev->dev);
-		ndr_desc.target_node = ndr_desc.numa_node;
-		ndr_desc.res = &pdev->resource[i];
-		ndr_desc.of_node = np;
-		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
-
-		if (is_volatile)
-			region = nvdimm_volatile_region_create(bus, &ndr_desc);
-		else
-			region = nvdimm_pmem_region_create(bus, &ndr_desc);
-
-		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
-		else
-			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
+					is_volatile);
 	}
 
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
