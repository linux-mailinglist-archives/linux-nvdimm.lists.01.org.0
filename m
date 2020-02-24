Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF29169C21
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:08:24 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 62D6C10FC33F4;
	Sun, 23 Feb 2020 18:09:15 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::649; helo=mail-pl1-x649.google.com; envelope-from=3fdbtxgykdlkzcdkuzfnnfkd.bnlkhmtw-muchllkhrsr.z0.nqf@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3E76D10FC33F3
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:09:13 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id q24so4293233pls.6
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=e5neKRQE0Ylu70uQVNqG6CPXmoPxHODfaRvH7F2C0Pw=;
        b=YHiXmus/EnjFAU6PeaWn5LwpzUc7PCFQI/d8yZl9grAa0B/xUi4r5vcOTDITCKIMoW
         makG0khPu6K/gEZosHvwYEmmd5qMT4sL+7dMkWgIbSHv/wa0qLv74DkUKsqsYKrbEmFq
         cz+79KiVOwo1hux6wHBTXNldhNPIpnpM0JKH8Hbaz7ocFT6PA43kqynKv4cGs9BnsHRT
         3KjHFvgTMpihahJNCJ4GKPSuHch2mMMIGfseexNT7auHTeecCgYy6TSRwVT0jr0rUP13
         8HcCPaDMPQPjZWzW/E6ZqvaP2GHWTPhtfMdx/01vxbjrzu9CsFbz6zPZr/Mps6xv0QQc
         x+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e5neKRQE0Ylu70uQVNqG6CPXmoPxHODfaRvH7F2C0Pw=;
        b=lE+Z5E6CaJG7MM8/qnNV3MBRh404nLE9uvulxYWa7pqvYkMBff6U2pqxLcmvb4+cau
         CanwrQU68q3BGQL/XVgvIa6VxEwis6CRuj+tc8SADK9dqx+VkLZVcI9hz4Iflv1SXS1t
         KbAR1mGxStV6EZzp9k+/uSrRwgtgrMm9gp/tt+XHDp4H5+C2E8qm47VgqaTD7L7DslO3
         k0ITH3yHrQO1L0kBj+5eZjYeP8t5jii6zi5JXhEqQi1tkJzuu0dTgZb4jrk7d71FuWYT
         q/UUGdwu0cKYvrBHibA51yCc1VtZFRvIiYoZMvR7fIQ95GisR1iGa7bfSSV+VTjjNZ7I
         uczg==
X-Gm-Message-State: APjAAAXdTolpLWUGZgRWE+pSg5EmvRFCQnSLZMjHiQ0D9eportmxtuyY
	4W2LwTtHQkmkLPtTk2ZB/r6qHOlBJXo=
X-Google-Smtp-Source: APXvYqxYYdZX9abJhfwReiJ8C0V/zBLnRqxvKYMmDdPec8/r7k35sA3GrzCBR2B2f8BSFH0cnrJqWNBQpbc=
X-Received: by 2002:a63:8b41:: with SMTP id j62mr2267520pge.18.1582510100578;
 Sun, 23 Feb 2020 18:08:20 -0800 (PST)
Date: Sun, 23 Feb 2020 18:08:14 -0800
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
Message-Id: <20200224020815.139570-2-adelva@google.com>
Mime-Version: 1.0
References: <20200224020815.139570-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 2/3] libnvdimm/of_pmem: handle memory-region in DT
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: I5P6AKVK57EUTAOB5TXU7WB2WQEKE4O6
X-Message-ID-Hash: I5P6AKVK57EUTAOB5TXU7WB2WQEKE4O6
X-MailFrom: 3FDBTXgYKDLkZcdkuZfnnfkd.bnlkhmtw-muchllkhrsr.z0.nqf@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/I5P6AKVK57EUTAOB5TXU7WB2WQEKE4O6/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Kenny Root <kroot@google.com>

From: Kenny Root <kroot@google.com>

Add support for parsing the 'memory-region' DT property in addition to
the 'reg' DT property. This enables use cases where the pmem region is
not in I/O address space or dedicated memory (e.g. a bootloader
carveout).

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
 drivers/nvdimm/of_pmem.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index fdf54494e8c9..cff47cc5fc4a 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -49,11 +49,12 @@ static void of_pmem_register_region(struct platform_device *pdev,
 
 static int of_pmem_region_probe(struct platform_device *pdev)
 {
+	struct device_node *mr_np, *np;
 	struct of_pmem_private *priv;
-	struct device_node *np;
 	struct nvdimm_bus *bus;
+	struct resource res;
 	bool is_volatile;
-	int i;
+	int i, ret;
 
 	np = dev_of_node(&pdev->dev);
 	if (!np)
@@ -83,6 +84,21 @@ static int of_pmem_region_probe(struct platform_device *pdev)
 					is_volatile);
 	}
 
+	i = 0;
+	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
+		ret = of_address_to_resource(mr_np, 0, &res);
+		if (ret) {
+			dev_warn(
+				&pdev->dev,
+				"Unable to acquire memory-region from %pOF: %d\n",
+				mr_np, ret);
+		} else {
+			of_pmem_register_region(pdev, bus, np, &res,
+						is_volatile);
+		}
+		of_node_put(mr_np);
+	}
+
 	return 0;
 }
 
-- 
2.25.0.265.gbab2e86ba0-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
