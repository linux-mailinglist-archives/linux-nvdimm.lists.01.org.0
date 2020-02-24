Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2BB169C22
	for <lists+linux-nvdimm@lfdr.de>; Mon, 24 Feb 2020 03:08:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77B6D10FC33E8;
	Sun, 23 Feb 2020 18:09:19 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::a49; helo=mail-vk1-xa49.google.com; envelope-from=3fzbtxgykdlwcfgnxciqqing.eqonkpwz-pxfkoonkuvu.23.qti@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-vk1-xa49.google.com (mail-vk1-xa49.google.com [IPv6:2607:f8b0:4864:20::a49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D477010FC33F7
	for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:09:16 -0800 (PST)
Received: by mail-vk1-xa49.google.com with SMTP id z24so3886273vkn.0
        for <linux-nvdimm@lists.01.org>; Sun, 23 Feb 2020 18:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tfMKf34rzYmaH8xdI4hD1ENek/gjKmpNdihWWrIkihY=;
        b=dl3xLDMmDQHWYwGTPecBMrhl8cp1ubi79/y4uC7zvxw13x5kxR0hIrdzcb6mpDjnIR
         akn7tFOCzC75LJ2U9XJBX1yKrH60zz44P5XPslfmv7fJWnv+CjXCSxIC9H0Qj+eap13U
         b1797Qo5mdforvpT4UbfBeE3Kwe7zvdlEFiny/xDlpedod7j01y2vCVM9O1Wdm+DQDdY
         DdqUI16njA1pwpu3TGvZTWuiHMHMU4z/1vto4Gwv59MGXnZwoueBJu8V1lHvMMEwWG63
         3p9DXJ3CcgM+sXeYNC/XM9jp86gtz5/p+nNxrhXAKSgazBzSfBhHDwhZwBGiPwrwNWVE
         ydSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tfMKf34rzYmaH8xdI4hD1ENek/gjKmpNdihWWrIkihY=;
        b=KjiUF+YWjSYngqf3XXu9Jx8wTF4T5Md5IEVe+DKWy5o+Ud4pkR1DODOYMe21a69kIk
         Dx7OmPiu4ny8zXJ+fkVbgd9ukB693vsgeL0rfx6sJrkjNhC5Z2FB1oCLKaeRA7dz9YXw
         paQ8OA91Jhe/0U8J9sXcm5mM1WCEWAtzEK79SnsY3Bg4B0PuUSA+QwJHNkXA2Ywo+rKw
         OMr5MaVNRK8MKDtS79s8YfavE3bg+nlix+k2QjVJqPTl4brQe/Czo2/SNWwQkuGlFun8
         R5DWFZwaGl21M0OGFEaM5vHfvM5mjEepMqvltB56SD/Ed/zbDvzjssQQUaQJvIhemSCs
         mi8A==
X-Gm-Message-State: APjAAAUIz4YWKQOVAvKZYOf4tujGgLeeknkBepNgxfDMv3M2Re5/LBL0
	jaG/GPkUTPdE4AmIAy9uCIIw3bOeEEo=
X-Google-Smtp-Source: APXvYqwTsPEqq0vSJALIwRT24gVR2Zsdll9IQ6yQ0KfZKKmTVDr8mHQmzYKgR5Kxy/Fg4GEAIXU4VmCCVXc=
X-Received: by 2002:a67:89c4:: with SMTP id l187mr24451432vsd.31.1582510103411;
 Sun, 23 Feb 2020 18:08:23 -0800 (PST)
Date: Sun, 23 Feb 2020 18:08:15 -0800
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
Message-Id: <20200224020815.139570-3-adelva@google.com>
Mime-Version: 1.0
References: <20200224020815.139570-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 3/3] dt-bindings: pmem-region: Document memory-region
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: EM45V2YENLEYBZUE6MLQ5FFY6COZ4QIQ
X-Message-ID-Hash: EM45V2YENLEYBZUE6MLQ5FFY6COZ4QIQ
X-MailFrom: 3FzBTXgYKDLwcfgnxciqqing.eqonkpwz-pxfkoonkuvu.23.qti@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EM45V2YENLEYBZUE6MLQ5FFY6COZ4QIQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Kenny Root <kroot@google.com>

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
