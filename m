Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33D197416
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 07:53:10 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7AF9A10FC378A;
	Sun, 29 Mar 2020 22:53:59 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 55F9010FC378A
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 22:53:57 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id AF2322DC685E;
	Mon, 30 Mar 2020 16:52:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547572;
	bh=DG24uTFgm3ncmUTPxNdi4/JJAgeS8enEWAzD03RxOZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXqe6QDqrC9mr09B5wF/29o0TTisxmFcpb5xQh1cZb3/AR1YXvRJoY3sx1z5LcBrJ
	 t+zJPG4Xc2mBEfI9YJ7ZlVHEqpnEIjgtG+oJxMMcOxiWX5uzkfFNWyD8/6zjasfBTB
	 rqVrg2JP746Asy6Z/qaq9NMnTrtWQVnCkBaPFUTOag7RLSOQ+9ZtmG2HohPm8pWRHB
	 SfhVnebyKrHl4UmR+bvyFhsVxhMHGgcIY7wtxBko3oFk4oPb63fkDyyLz5sSLjH2qY
	 aTAC1kB9J2U44M2VoXiD8s9EsJGtTe8Fk/lfb3T6+EGaPceKk9iT6/jkKMukuv4Skj
	 6/6s6vgnQWdmcMo5HODCL7TUdBesiiHnc2KpFVyZPTgZ6BNryXNj+mmuNJdV4HLtlr
	 P3w8SP9EHHAq4QIMmgJXJfzAtLXITdqEcvLHiO7YX1AhrZqRQRzFTrYNI5c//gmrqg
	 is5EJ/rlAXvxvbSgXvQ3fkGOdaje6XLIU1B/fA0oWC0K4UzVpxsgeva6a891KuU/qT
	 5v1DJFbFVYhn/OiuiOgTT+XCkQnZ3c1Vs7td9zkVBOOqt56O61tzdqtWQdGqlJTOIw
	 spFT5kwK2XD1UnFYSz49rNfHBpGn5H4Ezzhmxgd/eUnWxy+gjeNaS8tPjgnmay81N5
	 9azCa0l7R+D6MSdd46z0bfig=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Al045934;
	Fri, 27 Mar 2020 18:12:17 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 12/25] nvdimm/ocxl: Add register addresses & status values to the header
Date: Fri, 27 Mar 2020 18:11:49 +1100
Message-Id: <20200327071202.2159885-13-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:17 +1100 (AEDT)
Message-ID-Hash: VIVGRC3AGWX4MWFASSCISHVCEZLTWZJ2
X-Message-ID-Hash: VIVGRC3AGWX4MWFASSCISHVCEZLTWZJ2
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VIVGRC3AGWX4MWFASSCISHVCEZLTWZJ2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

These values have been taken from the device specifications.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/ocxlpmem.h | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/nvdimm/ocxl/ocxlpmem.h b/drivers/nvdimm/ocxl/ocxlpmem.h
index 03fe7a264281..322387873b4b 100644
--- a/drivers/nvdimm/ocxl/ocxlpmem.h
+++ b/drivers/nvdimm/ocxl/ocxlpmem.h
@@ -8,6 +8,79 @@
 
 #define LABEL_AREA_SIZE	BIT_ULL(PA_SECTION_SHIFT)
 
+#define GLOBAL_MMIO_CHI		0x000
+#define GLOBAL_MMIO_CHIC	0x008
+#define GLOBAL_MMIO_CHIE	0x010
+#define GLOBAL_MMIO_CHIEC	0x018
+#define GLOBAL_MMIO_HCI		0x020
+#define GLOBAL_MMIO_HCIC	0x028
+#define GLOBAL_MMIO_IMA0_OHP	0x040
+#define GLOBAL_MMIO_IMA0_CFP	0x048
+#define GLOBAL_MMIO_IMA1_OHP	0x050
+#define GLOBAL_MMIO_IMA1_CFP	0x058
+#define GLOBAL_MMIO_ACMA_CREQO	0x100
+#define GLOBAL_MMIO_ACMA_CRSPO	0x104
+#define GLOBAL_MMIO_ACMA_CDBO	0x108
+#define GLOBAL_MMIO_ACMA_CDBS	0x10c
+#define GLOBAL_MMIO_NSCMA_CREQO	0x120
+#define GLOBAL_MMIO_NSCMA_CRSPO	0x124
+#define GLOBAL_MMIO_NSCMA_CDBO	0x128
+#define GLOBAL_MMIO_NSCMA_CDBS	0x12c
+#define GLOBAL_MMIO_CSTS	0x140
+#define GLOBAL_MMIO_FWVER	0x148
+#define GLOBAL_MMIO_CCAP0	0x160
+#define GLOBAL_MMIO_CCAP1	0x168
+
+#define GLOBAL_MMIO_CHI_ACRA	BIT_ULL(0)
+#define GLOBAL_MMIO_CHI_NSCRA	BIT_ULL(1)
+#define GLOBAL_MMIO_CHI_CRDY	BIT_ULL(4)
+#define GLOBAL_MMIO_CHI_CFFS	BIT_ULL(5)
+#define GLOBAL_MMIO_CHI_MA	BIT_ULL(6)
+#define GLOBAL_MMIO_CHI_ELA	BIT_ULL(7)
+#define GLOBAL_MMIO_CHI_CDA	BIT_ULL(8)
+#define GLOBAL_MMIO_CHI_CHFS	BIT_ULL(9)
+
+#define GLOBAL_MMIO_CHI_ALL	(GLOBAL_MMIO_CHI_ACRA | \
+				 GLOBAL_MMIO_CHI_NSCRA | \
+				 GLOBAL_MMIO_CHI_CRDY | \
+				 GLOBAL_MMIO_CHI_CFFS | \
+				 GLOBAL_MMIO_CHI_MA | \
+				 GLOBAL_MMIO_CHI_ELA | \
+				 GLOBAL_MMIO_CHI_CDA | \
+				 GLOBAL_MMIO_CHI_CHFS)
+
+#define GLOBAL_MMIO_HCI_ACRW				BIT_ULL(0) // ACRW
+#define GLOBAL_MMIO_HCI_NSCRW				BIT_ULL(1) // NSCRW
+#define GLOBAL_MMIO_HCI_AFU_RESET			BIT_ULL(2) // AR
+#define GLOBAL_MMIO_HCI_FW_DEBUG			BIT_ULL(3) // FDE
+#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP			BIT_ULL(4) // CD
+#define GLOBAL_MMIO_HCI_CONTROLLER_DUMP_COLLECTED	BIT_ULL(5) // CDC
+#define GLOBAL_MMIO_HCI_REQ_HEALTH_PERF			BIT_ULL(6) // CHPD
+
+#define ADMIN_COMMAND_HEARTBEAT		0x00u
+#define ADMIN_COMMAND_SHUTDOWN		0x01u
+#define ADMIN_COMMAND_FW_UPDATE		0x02u
+#define ADMIN_COMMAND_FW_DEBUG		0x03u
+#define ADMIN_COMMAND_ERRLOG		0x04u
+#define ADMIN_COMMAND_SMART		0x05u
+#define ADMIN_COMMAND_CONTROLLER_STATS	0x06u
+#define ADMIN_COMMAND_CONTROLLER_DUMP	0x07u
+#define ADMIN_COMMAND_CMD_CAPS		0x08u
+#define ADMIN_COMMAND_MAX		0x08u
+
+#define STATUS_SUCCESS		0x00
+#define STATUS_MEM_UNAVAILABLE	0x20
+#define STATUS_BLOCKED_BG_TASK	0x21
+#define STATUS_BAD_OPCODE	0x50
+#define STATUS_BAD_REQUEST_PARM	0x51
+#define STATUS_BAD_DATA_PARM	0x52
+#define STATUS_DEBUG_BLOCKED	0x70
+#define STATUS_FAIL		0xFF
+
+#define STATUS_FW_UPDATE_BLOCKED STATUS_BLOCKED_BG_TASK
+#define STATUS_FW_ARG_INVALID	STATUS_BAD_REQUEST_PARM
+#define STATUS_FW_INVALID	STATUS_BAD_DATA_PARM
+
 struct ocxlpmem {
 	struct device dev;
 	struct pci_dev *pdev;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
