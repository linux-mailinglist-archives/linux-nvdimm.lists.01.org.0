Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496F169C30
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:10:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EDE9410FC3404;
	Sun, 23 Feb 2020 18:11:30 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::44a; helo=mail-pf1-x44a.google.com; envelope-from=3ndbtxgykdemfijq0flttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10D8A10FC3409
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:11:28 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z19so5651677pfn.18
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=em6XcUN6Sgd77WYEtwG8AuT1olj7PL/gGgbDqoXx92w=;
        b=E+uXnhSNXf534z3GjUH2lwNEjBXcWXn9RZ44ynGBLyGFBh6B4SCJ3rTdzfHM+o+Bno
         VxKLCAHwsdkWJHskFoD9Vkuqmf8sv3ORr03b21RmM6sK4B1dNgs7kHUsncaBgQsK20aP
         fSSiL3sHi6ZuSaLSU/ac+vt4cTkZWsOgFrQbnhYdCv8sXcHJm4YWmse1gk9vJvta74Pz
         CtGwlNEpDNXJrKiIYC7aOyrG6lp7JHG+ot6FFt32MXr6s5mwt6uR9xa3rNnYf88dZifz
         0PMFwNS6V8oJBOtSVNut319Ez0TbFHLd2ElURqTOriDU/ubyPYQu44SBgjdg9OpeV/wF
         pVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=em6XcUN6Sgd77WYEtwG8AuT1olj7PL/gGgbDqoXx92w=;
        b=ZDuToNx6nfvFZZxPzNt5SGsQakhgadR3k5p132Ye3VJGRgQIQVU9Je4bGjCe3PANLk
         8MHSG7TFw1rmS5soVNZOjXXsiz4hOkjbDT9p4QUIYfLAe+M0kQdopw4yWPosrzwaJ4j0
         bGCsC6SSGe3liZCk4JjnQqgBbwAejDayPyIigaePvSAAvqAsECu0tjEm0ybVowwu5MPs
         ca69guHC08Rtr12LCeqOvHHisgYUNsjioOL2XorN5x/iT91Bgw924Kn1XnZqEpr8RZH3
         LrtZFh3ijrnAL0rymSYLsGj5dq5bmfYyihy9Jk/EPb3UeR3tZmr1FOAo6eOZXDT3X/9O
         2Nkg==
X-Gm-Message-State: APjAAAXipQ/A2a8AAmQkqUJiOb8suU1j8aP5+kNTwUtV4GwvC6nMVBO+
	BzDRfhmQlGNd412VieNOn3zvjcrv0qE=
X-Google-Smtp-Source: APXvYqz6s2e3jF7ohEb8JyMCoEHwTugiFEQk/Az/WnyXRnhPy25meta77iWUNz38j1pNY9KX9r6A5JnI984=
X-Received: by 2002:a63:3407:: with SMTP id b7mr23541684pga.163.1582510236455;
 Sun, 23 Feb 2020 18:10:36 -0800 (PST)
Date: Sun, 23 Feb 2020 18:10:29 -0800
In-Reply-To: <20200224021029.142701-1-adelva@google.com>
Message-Id: <20200224021029.142701-3-adelva@google.com>
Mime-Version: 1.0
References: <20200224021029.142701-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 3/3] dt-bindings: pmem-region: Document memory-region
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: QFIC3X5H4QDKFIM7NYOUJRHNOWOH3ZSC
X-Message-ID-Hash: QFIC3X5H4QDKFIM7NYOUJRHNOWOH3ZSC
X-MailFrom: 3nDBTXgYKDEMfijq0flttlqj.htrqnsz2-s0inrrqnxyx.56.twl@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/QFIC3X5H4QDKFIM7NYOUJRHNOWOH3ZSC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Kenny Root <kroot@google.com>

Add documentation and example for memory-region in pmem.

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
[v3: adelva: remove duplicate "From:"]
 .../devicetree/bindings/pmem/pmem-region.txt  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
index 5cfa4f016a00..0ec87bd034e0 100644
--- a/Documentation/devicetree/bindings/pmem/pmem-region.txt
+++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
@@ -29,6 +29,18 @@ Required properties:
 		in a separate device node. Having multiple address ranges in a
 		node implies no special relationship between the two ranges.
 
+		This property may be replaced or supplemented with a
+		memory-region property. Only one of reg or memory-region
+		properties is required.
+
+	- memory-region:
+		Reference to the reserved memory node. The reserved memory
+		node should be defined as per the bindings in
+		reserved-memory.txt
+
+		This property may be replaced or supplemented with a reg
+		property. Only one of reg or memory-region is required.
+
 Optional properties:
 	- Any relevant NUMA assocativity properties for the target platform.
 
@@ -63,3 +75,20 @@ Examples:
 		volatile;
 	};
 
+
+	/*
+	 * This example uses a reserved-memory entry instead of
+	 * specifying the memory region directly in the node.
+	 */
+
+	reserved-memory {
+		pmem_1: pmem@5000 {
+			no-map;
+			reg = <0x00005000 0x00001000>;
+		};
+	};
+
+	pmem@1 {
+		compatible = "pmem-region";
+		memory-region = <&pmem_1>;
+	};
-- 
2.25.0.265.gbab2e86ba0-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
