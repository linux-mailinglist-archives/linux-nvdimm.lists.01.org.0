Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0951951C4
	for <lists+linux-nvdimm@lfdr.de>; Fri, 27 Mar 2020 08:12:34 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2116E10FC3BB2;
	Fri, 27 Mar 2020 00:13:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id 12D3210FC3614
	for <linux-nvdimm@lists.01.org>; Fri, 27 Mar 2020 00:13:12 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id EB93C2DC682E;
	Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585293141;
	bh=vpE3Z7AWSr9my143HyVtO4yHV91rl8rmhtd6A3TKrQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToWrV+3ZvZNUE2ymKS5AQKjdsoM8VnN0qS7Mcg9YpzMua6UKfnzZyjTa2CjCdkbAx
	 KA4DnOTootSPbswhgz91nw0o0biwbDxGGtU0moHxcS4X33+W5cUSY031Xl/IrjDcZd
	 k3akP1KgKpgAFMucLlxQ3QSayVxS+wFdH5r/CbdTgtEm2Lm0kz0rlKGVn2QnbTTmUY
	 UkMI0q1W76+Cvy4N74Irk+FktDx/FAGYFcmEmjYiX7Nqu9M/8R0gPLHdVNTj3r5m56
	 z8ExH4vvUt4YZDpKoUykg9YeTGV2GWmofs8LL315gf708HqmzIocIMebbvWxygke/J
	 32agGl9J6xWPkVtSWxa+am6KzeJxoO0/g4PK3Ng2KA76AixIloAhpOJc7kNPGwysHV
	 T7Z+WgI/ICr/00Hx0uOy+52nbSf4jEphgh3ufk7wZnG00NaTJJ565EWv8n93D9nR/C
	 8gE9SepGUhdH3IliID4vYmthn4YIuB85FAXfMAQ6NpMPmma20AplulMTz4Potr3Qw/
	 krKKVXInJ8PzHdWHNiOFeLBHEa011pvUyKeZs2wdc6f8SoFaBDJl2Fl1zKiU3R5MjB
	 e4zLtL+yqH7gkqhY5wwcPBO/0Knua2Y3YlppmvVOY4DDN5PsenvhIhiww1FHkOXtoP
	 NiMUvB+XldjBvNPEI3v1PTTo=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ak045934;
	Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 11/25] powerpc: Enable the OpenCAPI Persistent Memory driver for powernv_defconfig
Date: Fri, 27 Mar 2020 18:11:48 +1100
Message-Id: <20200327071202.2159885-12-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:17 +1100 (AEDT)
Message-ID-Hash: 4WTEAWCSDIX7AN3MINYCHBJZ2PHLX37P
X-Message-ID-Hash: 4WTEAWCSDIX7AN3MINYCHBJZ2PHLX37P
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4WTEAWCSDIX7AN3MINYCHBJZ2PHLX37P/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch enables the OpenCAPI Persistent Memory driver, as well
as DAX support, for the 'powernv' defconfig.

DAX is not a strict requirement for the functioning of the driver, but it
is likely that a user will want to create a DAX device on top of their
persistent memory device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/configs/powernv_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 71749377d164..921d77bbd3d2 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -348,3 +348,8 @@ CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=m
 CONFIG_VHOST_NET=m
 CONFIG_PRINTK_TIME=y
+CONFIG_ZONE_DEVICE=y
+CONFIG_OCXL_PMEM=m
+CONFIG_DEV_DAX=m
+CONFIG_DEV_DAX_PMEM=m
+CONFIG_FS_DAX=y
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
