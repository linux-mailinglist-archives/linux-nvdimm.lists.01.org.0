Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61814169146
	for <lists+linux-nvdimm@lfdr.de>; Sat, 22 Feb 2020 19:30:21 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B531010FC3192;
	Sat, 22 Feb 2020 10:31:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::54a; helo=mail-pg1-x54a.google.com; envelope-from=3ohnrxgykdf0589gq5bjjbg9.7jhgdips-iq8dhhgdnon.vw.jmb@flex--adelva.bounces.google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C787A1007B1FC
	for <linux-nvdimm@lists.01.org>; Sat, 22 Feb 2020 10:31:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l17so3160488pgh.21
        for <linux-nvdimm@lists.01.org>; Sat, 22 Feb 2020 10:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LqkliWMqkbYqRIuupuOLJ6kzkCRKDL/XTv8pUZxzvKQ=;
        b=PgQzLg8qKzkyhPyxTmoaNbnjNiSyl7EAdKe9zlgr7TFwxMb8ScYriPIQUviohO4BSk
         nUR9tkQzOmQFjuXA1r1vnn/cKgcN9herEGiD+8RcQ5/kjryJFb1QCWQB68vGKhtmmgH/
         sDAHhKQrgYrgoL3KjmL3XDRC4b/vmMsjwr48xg6ZF82kNigCID53t8L0ht6mg+ro4qoc
         /WfCokur3PuPbHVzNIO3SE6niOinINt9R1b06lNInZVj1C5XUBd+v9ygMq3wQe/e/6p8
         8E+UZTx4ZMxQKRikHlAw/aYtrrZSsf7C++C1js0gybHMgS+8OWKW7jMi9NcWaOXrRPaX
         3bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LqkliWMqkbYqRIuupuOLJ6kzkCRKDL/XTv8pUZxzvKQ=;
        b=pvz+qSpVlxtMYcpdCLHIh6qkVqhhhhrh2tDqRUL+ngTxbnZOn0n1yUolDaLz/kg9+P
         7s1I5Vq5m5sJONxJJ2+P/dj7CFvX9Sa2vNoxOUeg96koZTRPtEOSFIKTnVp2ktFNoxXs
         4ulxwTBVuDsnpWP2qmUMiBywgRKoIgWNrk5f8FvShVJbmOftkgAZC7+H9KVrIHP2Qxlb
         jh19gymSu9FwtIZoLejNGtJUan8iJ46JqyUWIFOO0mhkoUA9Pqx2RJZiAY0UhqKhXObf
         y/UFFC68AdeWQ/1LkyMTe9Si4+fha2wq8ZtobdEvEJkMa0/q0BYyeRQpCBwhBS74P//B
         EXZA==
X-Gm-Message-State: APjAAAXZ36CGnKb3IVhnKL+W4Z0cJwrnw/aY4VzJhKR22HHBXezIcx30
	l/JqDsOFCTwoTQKXENOTdybaI6NRqCw=
X-Google-Smtp-Source: APXvYqzQdQgHQ6fWCJuIXWIAgYGxlrY2CrH849Fe3I+ATdbmceKERzMpxkHMUK63twO0nuNjfUKmQrh7v4U=
X-Received: by 2002:a63:120f:: with SMTP id h15mr46221489pgl.235.1582396216132;
 Sat, 22 Feb 2020 10:30:16 -0800 (PST)
Date: Sat, 22 Feb 2020 10:30:10 -0800
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
Message-Id: <20200222183010.197844-2-adelva@google.com>
Mime-Version: 1.0
References: <20200222183010.197844-1-adelva@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 2/2] dt-bindings: pmem-region: Document memory-region
From: Alistair Delva <adelva@google.com>
To: linux-kernel@vger.kernel.org
Message-ID-Hash: N6E7KE2LUNQMI7Y3YNPE24FU4XCBMOSQ
X-Message-ID-Hash: N6E7KE2LUNQMI7Y3YNPE24FU4XCBMOSQ
X-MailFrom: 3OHNRXgYKDF0589GQ5BJJBG9.7JHGDIPS-IQ8DHHGDNON.VW.JMB@flex--adelva.bounces.google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Kenny Root <kroot@google.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N6E7KE2LUNQMI7Y3YNPE24FU4XCBMOSQ/>
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
 .../devicetree/bindings/pmem/pmem-region.txt  | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
index 5cfa4f016a00..851ffa71967e 100644
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
 
@@ -63,3 +75,21 @@ Examples:
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
+
-- 
2.25.0.265.gbab2e86ba0-goog
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
