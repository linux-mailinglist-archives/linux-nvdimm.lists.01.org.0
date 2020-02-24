Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86778169C2E
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:10:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C048410FC33F7;
	Sun, 23 Feb 2020 18:11:25 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::104a; helo=mail-pj1-x104a.google.com; envelope-from=3lzbtxgykdd4fijq0flttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E3F1010FC33F4
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:11:23 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m61so5445098pjb.1
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xXnVPSTtq6JKEca5i5uwLN/shdFSGa9fDblOik0nzOE=;
        b=ewQZZzHbAIm9IaVDu9F0bc2esO1BNMP2dV5Rp45y8mFa8Z0HBz43i3HohNjPmgKnZF
         iGvAM0Z71h7ZTE66msAdaRCfRpaOSuKti3gKQcx16Iza8AaubCFm30jx7F0Y8VJdz56P
         p5JifXyJlkxxvdhB0WTwuFfXVQ90hE8ZMGORE/RZCHHPnqei3atfgwfHGcNA3I1FZ18h
         0Iuvr5oHofTsZzrJmhJipc5xrmilXc5ctdxC6HQ5QgYDVHvMWu4d5abZXY/KvQjNxha7
         Hkur+YO1PRIZeqbJcGRVm8AwuZFnIei1lXZgQF++GRM57usyRdsHLq5QnO0h2KmhgnQA
         RitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xXnVPSTtq6JKEca5i5uwLN/shdFSGa9fDblOik0nzOE=;
        b=qY8SIoAafp99PnNekUbo6pFu/Q4dHVPoN+mqguyo1My5UXDEVFs1V+6rN6RWb1HRgr
         45XihXF7UuZwSmbqF7aNpOoNdoamIz8dGdJb7bVCeRAf4mU3IsQG4EmF00MzdPcw0I8I
         yzNJaIxuX+jxsMSlPQEzuCPQbxyVYmo/q2jhQzQyW9JutI1NErLJtMayuNzUlzjvH37f
         fBhxAmbO+wLAegnk1DFtcqExb+JDL4qTnxjmIh/3b2gmQ4RSDHI8wqaDg2dNtn1fAdVm
         9GRC0wo3yFWrw9SB2VIeaIv/JMcE8XtqkfaSwdkYU1ex+N9kDuhKVbkUIxvzldslgOwz
         qQ2w==
X-Gm-Message-State: APjAAAXwQXJhJCN2RsKxqv89f4A/d/3ccwXcRVKLf1Hu9df9f2+/1s0+
	gJ7TRjyEUVnbj3TlHU3TvgcJZ/QGyRw=
X-Google-Smtp-Source: APXvYqzh7LWx5FHfbXoqvdMOKLDRvpI9RTMgE9OYFl93HPIxPAzkWl5IGjaOk/mtBxp40jqIQkZIat3Is54=
X-Received: by 2002:a63:8743:: with SMTP id i64mr49147206pge.243.1582510231389;
 Sun, 23 Feb 2020 18:10:31 -0800 (PST)
Date: Sun, 23 Feb 2020 18:10:27 -0800
Message-Id: <20200224021029.142701-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 1/3] libnvdimm/of_pmem: factor out region registration
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: CKC6Z4HDDIMU34TXPAIBUC2PMTOZECKU
X-Message-ID-Hash: CKC6Z4HDDIMU34TXPAIBUC2PMTOZECKU
X-MailFrom: 3lzBTXgYKDD4fijq0flttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/CKC6Z4HDDIMU34TXPAIBUC2PMTOZECKU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
[v3: adelva: remove duplicate "From:"]
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
