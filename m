Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BD31951C3
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 08:12:32 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 091E310FC3BAE;
	Fri, 27 Mar 2020 00:13:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id DA7EC10FC36EE
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 00:13:11 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 5E12D2DC67FE;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585293141;
	bh=bEfzXRR0cTBf+yBtWTvEdtXlD5xDUP18rOvIDgiLves=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gd3j0DuoeTtlWmyHUBUazlQ1VFusMIA9aMaYhizfgDpSKt92Sy7qNXsG96bPw/XxL
	 9QhMWe73iJYRcKatLqQyH20jrk2zgVkqk6EZ71FermuqUedtDX+/a0Nl0KdpTvyQGX
	 TI7AMhz5XxEnv3yAqHVIW9qqxXNSXJloUqB4fVEgjJLPiAyElMs9/sGcUgkKv9wRiT
	 pVzWhJmqwR4it0c5Jr1sRPCU+d7RO8j9kbV60yXlW6plmXpocT8DiJaRVac54Kl5bx
	 iykZ94QQC1lJiJhk6vSgbqe3hvFn4jc4B7ggDCo3TAcwMB0jDRWxoQ9t48F2xrqoxc
	 Uc7oM3knlUNd38QNUCVGzKSnmF0yYLUaLZOpbB6nKsaWWmft6E6+3oQTcHtQjB8Ja/
	 f9bmXSMg7fOd70wY0ezYnuB6dFA38AdcPEhax50weTdofK/DbxqRRk+Nn/8pWP3THe
	 yfQFCXqYYY7dSVktejI9B3aDo17PWhaE3+ZCC1FDLqmXe9TesqrQPPeQ8B/8Lnk3jm
	 +jdLoxFPBf78IBZA6+JcRjRAKDCxDsrWUAW8qhRPf595Us6aILG5DUC852KzjPL4me
	 SGVCPNuhRq371astBd/3M8cq2ByQeoJvs2+NtXwgbRW4GSgBLQwfL719g3fE041XB8
	 93xnLU1sO4dAMbvZvsnBeSS8=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ah045934;
	Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 08/25] ocxl: Emit a log message showing how much LPC memory was detected
Date: Fri, 27 Mar 2020 18:11:45 +1100
Message-Id: <20200327071202.2159885-9-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
Message-ID-Hash: U3DGGMOIJDBO3HATEQV3IXSMQMB6HHXX
X-Message-ID-Hash: U3DGGMOIJDBO3HATEQV3IXSMQMB6HHXX
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U3DGGMOIJDBO3HATEQV3IXSMQMB6HHXX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch emits a message showing how much LPC memory & special purpose
memory was detected on an OCXL device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 drivers/misc/ocxl/config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index a62e3d7db2bf..69cca341d446 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -568,6 +568,10 @@ static int read_afu_lpc_memory_info(struct pci_dev *dev,
 		afu->special_purpose_mem_size =
 			total_mem_size - lpc_mem_size;
 	}
+
+	dev_info(&dev->dev, "Probed LPC memory of %#llx bytes and special purpose memory of %#llx bytes\n",
+		 afu->lpc_mem_size, afu->special_purpose_mem_size);
+
 	return 0;
 }
 
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
