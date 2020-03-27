Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3119F19740F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 07:52:53 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5BDF310FC36CB;
	Sun, 29 Mar 2020 22:53:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id DFED110FC363F
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 22:53:38 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id BB2D52DC6849;
	Mon, 30 Mar 2020 16:52:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547566;
	bh=usgtpWwfPqN3Po8Erc64Din9rr6Mrn4qoxSsihnBfcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bMbioP7EtdRIN7Psu7rzMUpwa2C/X6QC4z279/qrlgZqOuYGPlOwaH67cXt1O9uFN
	 yOjDqQ7nMQ+tvZeiC3hFYQ7HkNgHSBbyXfOcwjqnoGGaTF/NmFZa/cZdks4yFx1rMN
	 SY8i1g6ylE1zIvnQ4+BlwncOv6lIg8IPtu7wxpS04cV44QA+KZi2iMEu6bwkTuOfof
	 Y49t6MWeq96LBdLMYXjaSmO54h9U3i1fSUQp5vBqUJ19SIAdr2sm6OAW6Z1Qkuv20U
	 7r9tsLXd/jVSP2tx5O3YbfGLhX60JbQU/5G2VTu+b3ndMWAb430Gz2hu8VpwC6JFRp
	 0ESQ++Zwi1ehD6oM/g89XDPAa1J5Rnn890kEAlVRB7y46BhGvxZbPZ4Vw9AkNpJsHB
	 cMV5R2mdHXLLQgCpbDHpG6zziIq/nLlkrhCrNCg5beqdPmiTucYeBODFIHKReDK02p
	 +bTsSrqanwYTuozWj8TiV9BtUYmI6YnNsfpXcEHcUATwh7NBNKNuNIDiN2vKdHC56v
	 3MJRPUnWhYZg6Q2eB5TAj14uimXz9l5Y0LlG1MynoP2X+JYl/o4p5ZmKb9I2wE1J6z
	 /JOLdd+DdJwF1YHIa2bnFcs514YF3C+C5vK1g2b0TyRT23PrKcfcG1qzvflCD9DxrC
	 nzuS2Tu74wUp1I8IUt9lKT1M=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4B0045934;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 25/25] MAINTAINERS: Add myself & nvdimm/ocxl to ocxl
Date: Fri, 27 Mar 2020 18:12:02 +1100
Message-Id: <20200327071202.2159885-26-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
Message-ID-Hash: BSQ7XGRCDX3Y673OUNCVAIDBF45XXMMJ
X-Message-ID-Hash: BSQ7XGRCDX3Y673OUNCVAIDBF45XXMMJ
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BSQ7XGRCDX3Y673OUNCVAIDBF45XXMMJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The OpenCAPI Persistent Memory driver will be maintained as part ofi
the ppc tree.

I'm also adding myself as an author of the driver & contributor to
the generic ocxl driver.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8670989ec91..3fb9a9f576a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12064,13 +12064,16 @@ F:	tools/objtool/
 OCXL (Open Coherent Accelerator Processor Interface OpenCAPI) DRIVER
 M:	Frederic Barrat <fbarrat@linux.ibm.com>
 M:	Andrew Donnellan <ajd@linux.ibm.com>
+M:	Alastair D'Silva <alastair@d-silva.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/ocxl.c
+F:	arch/powerpc/platforms/powernv/pmem/*
 F:	arch/powerpc/include/asm/pnv-ocxl.h
 F:	drivers/misc/ocxl/
 F:	include/misc/ocxl*
 F:	include/uapi/misc/ocxl.h
+F:	include/uapi/nvdimm/ocxl-pmem.h
 F:	Documentation/userspace-api/accelerators/ocxl.rst
 
 OMAP AUDIO SUPPORT
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
