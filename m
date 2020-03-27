Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE76197410
	for <lists+linux-nvdimm@lfdr.de>; Mon, 30 Mar 2020 07:52:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 712B210FC36DF;
	Sun, 29 Mar 2020 22:53:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=66.55.73.32; helo=ushosting.nmnhosting.com; envelope-from=alastair@d-silva.org; receiver=<UNKNOWN> 
Received: from ushosting.nmnhosting.com (ushosting.nmnhosting.com [66.55.73.32])
	by ml01.01.org (Postfix) with ESMTP id EB14E10FC36CD
	for <linux-nvdimm@lists.01.org>; Sun, 29 Mar 2020 22:53:42 -0700 (PDT)
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
	by ushosting.nmnhosting.com (Postfix) with ESMTPS id 277FA2DC684C;
	Mon, 30 Mar 2020 16:52:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
	s=201810a; t=1585547567;
	bh=/c0sygyGptvZJ7mjxJ2I2ERy9RY2BO4lgAUmGcAOvOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMjl+0uXIk2WsRYFK7QMnoeZwiXtbQvngMc30HklM7M/UaYiwbRU0QE9+G/GnjCpF
	 6TnIi2bluBUjI33oB/IGG++wI53XGTIwCq5K0VlcVhmAbh8fhf/pZM4Ced6P4QxUan
	 4mCoqUpqEQuPXCesRSY06c5qvKiv1LsP8cfIca3WUYgQYOJ/q/s8LwSNJX9HBkkIhn
	 gDlQa2bD02tm9GPOYMeF42o7Bj/XBxnHbDvb+sZWgfzyMO+XkIa7CR1jZ4i6HRAFM+
	 YbdnR295TH0kUDCjW5WeNmhPseRb1h1xcrGkr1E7ZJs7ZsylKwzALmMvOAhH9LL5vq
	 3sSEcN0wjhm82H8oqQYmkz6pFE9Ngz7Yk7lRcCnGpzQVRWYRpVTksaPYJsbD/6F8t2
	 MetLhu1IrJSl7OBndz4jJBgg6mmUQXdE5qPmzLqjrTwMXPbnNkvRn55MI0MKPAsiA2
	 v3UhZHqDsS3yj8k9ftzhbgmpM9o3tilShHFLuLa6EEPGAyGhkC0JmK4UJSSU4vuBsl
	 DAAPAo9W0AH+Quua6imoMGuoYzJ2F3ro6L2zDSZSLZw6BC3GtyzRpLXvgZ5C/FjG+f
	 tIZ+HRu9YYQm06ECg8BUrm41v1jxxG21JM4D7E34KQMuRdIJeivVBNTbxAwVDV35Ax
	 wfbVKJDpJWOjuCjbEN7nnoZA=
Received: from localhost.lan ([10.0.1.179])
	by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Au045934;
	Fri, 27 Mar 2020 18:12:19 +1100 (AEDT)
	(envelope-from alastair@d-silva.org)
From: "Alastair D'Silva" <alastair@d-silva.org>
To: alastair@d-silva.org
Subject: [PATCH v4 21/25] nvdimm/ocxl: Implement the heartbeat command
Date: Fri, 27 Mar 2020 18:11:58 +1100
Message-Id: <20200327071202.2159885-22-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:19 +1100 (AEDT)
Message-ID-Hash: 2HW65I34VO4LRQW64BM7GGN6FSAJG3IL
X-Message-ID-Hash: 2HW65I34VO4LRQW64BM7GGN6FSAJG3IL
X-MailFrom: alastair@d-silva.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.r
 u>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2HW65I34VO4LRQW64BM7GGN6FSAJG3IL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

The heartbeat admin command is a simple admin command that exercises
the communication mechanisms within the controller.

This patch issues a heartbeat command to the card during init to ensure
we can communicate with the card's controller.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 drivers/nvdimm/ocxl/main.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index a4315472683c..2fbe3f2f77d9 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -272,6 +272,30 @@ static int setup_command_metadata(struct ocxlpmem *ocxlpmem)
 	return 0;
 }
 
+/**
+ * heartbeat() - Issue a heartbeat command to the controller
+ * @ocxlpmem: the device metadata
+ * Return: 0 if the controller responded correctly, negative on error
+ */
+static int heartbeat(struct ocxlpmem *ocxlpmem)
+{
+	int rc;
+
+	mutex_lock(&ocxlpmem->admin_command.lock);
+
+	rc = admin_command_execute(ocxlpmem, ADMIN_COMMAND_HEARTBEAT);
+	if (rc < 0)
+		goto out;
+	if (rc != STATUS_SUCCESS)
+		warn_status(ocxlpmem, "Unexpected status from heartbeat", rc);
+
+	(void)admin_response_handled(ocxlpmem);
+
+out:
+	mutex_unlock(&ocxlpmem->admin_command.lock);
+	return rc;
+}
+
 /**
  * allocate_minor() - Allocate a minor number to use for an OpenCAPI pmem device
  * @ocxlpmem: the device metadata
@@ -1460,6 +1484,12 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err;
 	}
 
+	rc = heartbeat(ocxlpmem);
+	if (rc) {
+		dev_err(&pdev->dev, "Heartbeat failed\n");
+		goto err;
+	}
+
 	elapsed = 0;
 	timeout = ocxlpmem->readiness_timeout +
 		  ocxlpmem->memory_available_timeout;
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
