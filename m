Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41117169145
	for <lists+linux-nvdimm@lfdr.de>; Sat, 22 Feb 2020 19:30:20 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A1A091007A82E;
	Sat, 22 Feb 2020 10:31:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f49; helo=mail-qv1-xf49.google.com; envelope-from=3nxnrxgykdfo256dn28gg8d6.4gedafmp-fn5aeedaklk.st.gj8@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id EA49D1007B1FC
	for <linux-nvdimm@lists.01.org>; Sat, 22 Feb 2020 10:31:07 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id g6so3663943qvp.0
        for <linux-nvdimm@lists.01.org>; Sat, 22 Feb 2020 10:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1SCGFJcdT57UM9g569dFzCXIAoXI2cL9T0Egcs4At5A=;
        b=rbOWC4VRcR9Ei8+SP5+fapjsG7JlPOKlvg+6qkAOKcy6S/PxZg8y9o8/iIVVyJzQkW
         9ip7Q7kYYyXMXXXHv88LopTajfUnbdYyt5OkA+tLHFSAE90ujIrBQjaMBXPPp3jSfvC/
         DVzVECbEepl/OuWA/FGV1dp5oEP9g6coMxU0VY7VWgdnJigkNDeJpwObPa47iOzjo3at
         qMKV56vuAatorqaL/0c60rV+QnIljtSwi795S+MLa3Y7gsohW1qCnzUjKct0OM33VHCm
         PxSouKW+/VhINbMOOj1hyCHu3RxI4zYU7SmlVsv+iSMtdW/a8qWiRR6aBgUJXOg8kr/B
         yTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1SCGFJcdT57UM9g569dFzCXIAoXI2cL9T0Egcs4At5A=;
        b=n0nJnuFaSDSmiRotkP9Dd8KMmzgZ1GmNWFQ5j32ZEALb45UWboMaSaBvBGAH5XdHxM
         xzlzIBRqN8Q0lZv0HLTdDpY6EiiTioSBe0HPb4ZX8QCNQVUkc5emz8E9L9vs6uZ+Oluf
         hwq7htH+Ldp8WItjhYSePe0PEAABMgMF+iCTTcV4GTjygKeRCs9n7pj3Brg8+lTtbmIJ
         tFTrwpe+4lg25IFk6vMNWLkof2KnXQK6G3m1ERR0z/Yk6xV7A1pZHDpA8BD3hjaDrw+1
         +vGhCUMbtwpHM5iNlni2T/8WMzCISZyP6uLXptF2iVGM70p43j4t2LgAKlX1VLQhwQGA
         BjJg==
X-Gm-Message-State: APjAAAUX7fezOp43oDCCTPqys7KLUBQJSsPVYWzVpjydX4hT/84ztzPw
	prPzqHo0JU1PeXlrzD/4eznxzw5LRUA=
X-Google-Smtp-Source: APXvYqyI0nbEkK8t5PqjH2XUeMtXnlvIm2qcZEUezASmjw62vNPGTkH8/bD15V7Jh7dUFdFSRS3DMwUqrcY=
X-Received: by 2002:ac8:835:: with SMTP id u50mr38957444qth.15.1582396213599;
 Sat, 22 Feb 2020 10:30:13 -0800 (PST)
Date: Sat, 22 Feb 2020 10:30:09 -0800
Message-Id: <20200222183010.197844-1-adelva@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: 3EM2JAO24TNUV4CFLLRVANDNZX26FXHW
X-Message-ID-Hash: 3EM2JAO24TNUV4CFLLRVANDNZX26FXHW
X-MailFrom: 3NXNRXgYKDFo256DN28GG8D6.4GEDAFMP-FN5AEEDAKLK.ST.GJ8@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3EM2JAO24TNUV4CFLLRVANDNZX26FXHW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Kenny Root <kroot@google.com>

Add support for parsing the 'memory-region' DT property in addition to
the 'reg' DT property. This enables use cases where the pmem region is
not in I/O address space or dedicated memory (e.g. a bootloader
carveout).

Signed-off-by: Kenny Root <kroot@google.com>
Signed-off-by: Alistair Delva <adelva@google.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: devicetree@vger.kernel.org
Cc: linux-nvdimm@lists.01.org
Cc: kernel-team@android.com
---
 drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
index 8224d1431ea9..a68e44fb0041 100644
--- a/drivers/nvdimm/of_pmem.c
+++ b/drivers/nvdimm/of_pmem.c
@@ -14,13 +14,47 @@ struct of_pmem_private {
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
-	struct device_node *np;
+	struct device_node *mrp, *np;
 	struct nvdimm_bus *bus;
+	struct resource res;
 	bool is_volatile;
-	int i;
+	int i, ret;
 
 	np = dev_of_node(&pdev->dev);
 	if (!np)
@@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
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
+		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
+					is_volatile);
+	}
 
-		if (!region)
-			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
-					ndr_desc.res, np);
+	i = 0;
+	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
+		ret = of_address_to_resource(mr_np, 0, &res);
+		if (ret)
+			dev_warn(
+				&pdev->dev,
+				"Unable to acquire memory-region from %pOF: %d\n",
+				mr_np, ret);
 		else
-			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
-					ndr_desc.res, np);
+			of_pmem_register_region(pdev, bus, np, &res,
+						is_volatile);
+		of_node_put(mr_np);
 	}
 
 	return 0;
-- 
2.25.0.265.gbab2e86ba0-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
