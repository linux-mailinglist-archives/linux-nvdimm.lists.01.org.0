Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D604169C2F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:10:38 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D6D0F10FC33FD;
	Sun, 23 Feb 2020 18:11:28 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::64a; helo=mail-pl1-x64a.google.com; envelope-from=3mtbtxgykdeacfgnxciqqing.eqonkpwz-pxfkoonkuvu.23.qti@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1BD3910FC33FF
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:11:26 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id q24so4295632pls.6
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U9x1EVLhqUbvxZ1MWzxoNmpwHOpemfs+Xxa6i1IJDww=;
        b=OEZCOSfqHyCH0n82I//mUildBSBEUUWtDcYiq5Oo5rR6qwCUGmKPZzbMBisxmcQAbs
         TwUoh4G1YcGAerITwUuZ71yplkGbaMvFWpjDhsl44azfyp7P/KC4RBOS12hgxQY8jm8M
         ldIXaMtQFvHvaRURHKQJFJiIDj0VeJ4hObpDLPxHCrY4fTUWKMlQ2GNmcvZ8TYBqHV9C
         VILHHGsrHmqLJFAja4WXRD36IvuFwZ9qn2f1/Ybes/BbOLiEuQ7gbF3HMSYDNIZzN2Wl
         0+OLRiZL+3uLGxhSCLaFIvMWKj4va4dyktRr9Xz0/bsQkUhkikLjtVzf/ATL1C/LX4K+
         hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U9x1EVLhqUbvxZ1MWzxoNmpwHOpemfs+Xxa6i1IJDww=;
        b=pmZQosJhy603LbyyrwS+CWniv4uACnXYDmCYtw9a0kG6l6NNOmADCYixTZBg89qmpd
         4T1LOzW55pmBBGfW30TnOUOcMAMRMAXEHZR0+2BAiwhu4vMnPPgAkeAVl1FkMfvjpikI
         eQwlDBLuVmyJ97puwufgW2ImXNnqai63kxbEg2S6qjvc41dsocBmH5oGVHbuqSVC37vT
         pzBUdZmPHl3i/Qkf929p8rsibDzSTCmSA7JiWLWV+hIq75ALITp32F622zORdtFsLTkx
         A8g5XoSkwPz3acF0B8TTvs7mRU5NSz5NNID3ZQvGnBDLBzQ55IWRD3iInG2Xz92aJPwm
         6wog==
X-Gm-Message-State: APjAAAVdNmD3kDsEAdv9kx4+M02orLeq7z+PF6/lgCsIeWKV9GIGvgrF
	uw2fxOklSjyIbvg3T3Wiwrqa0j+sxeg=
X-Google-Smtp-Source: APXvYqyTwjxCwbxReORBQcuv6XOeQhdEylhMml37cUwzX0Kd3xXx05FTdjuoUaIZYSsoX4pIMCxjPJwMRp0=
X-Received: by 2002:a63:2e42:: with SMTP id u63mr49471649pgu.137.1582510233602;
 Sun, 23 Feb 2020 18:10:33 -0800 (PST)
Date: Sun, 23 Feb 2020 18:10:28 -0800
In-Reply-To: <20200224021029.142701-1-adelva@google.com>
Message-Id: <20200224021029.142701-2-adelva@google.com>
Mime-Version: 1.0
References: <20200224021029.142701-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 2/3] libnvdimm/of_pmem: handle memory-region in DT
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: WQEDQZ6RSQW65BZQ52YAIZUYIWUMN4ZE
X-Message-ID-Hash: WQEDQZ6RSQW65BZQ52YAIZUYIWUMN4ZE
X-MailFrom: 3mTBTXgYKDEAcfgnxciqqing.eqonkpwz-pxfkoonkuvu.23.qti@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WQEDQZ6RSQW65BZQ52YAIZUYIWUMN4ZE/>
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
