Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF0E2DB181
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Dec 2020 17:35:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F04B7100EBB63;
	Tue, 15 Dec 2020 08:35:38 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.126.135; helo=mout.kundenserver.de; envelope-from=info@metux.net; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69267100EBB62
	for <linux-nvdimm@lists.01.org>; Tue, 15 Dec 2020 08:35:36 -0800 (PST)
Received: from orion.localdomain ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MV5nC-1khxUR2Pry-00S7g0; Tue, 15 Dec 2020 17:35:33 +0100
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: nvdimm: cleanup include of badblocks.h
Date: Tue, 15 Dec 2020 17:35:31 +0100
Message-Id: <20201215163531.21446-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:C7RdFBnjmFHqPsYMQnbYptqJnihqF3lM+F8c1Rj8u97izGMi06n
 LPO+64P+SWA9AjJr6dNZEo1Exm8xE6N94RnT5Dk6YBU/Zs9iTATeYIgv35EDKx0OIdZmcRn
 Oth+iFy+vKqCOU5cqJtTUWN4jtjlXoHqXjGZ94JJohm+GD0G51T6cUEp7drVXSWnce7HzgM
 5oVUJCfsHcUlUz+vY9s+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LBv0BIoXoD0=:PQ5hFaHcfARRGdd5FulSAm
 C0YGQBk+HNECc0gAWzkQEFCBtEi5dnsO1W+diHjQgOBEpec/cVnNuSSwSDXDfwL81RC7xbJBg
 v6S1iQvws2b7X+V3uCDLQa+h+evDX7n3g/HCMvSiAEJZRchY+e66ZLW9mkRclHT2P1GB9fobh
 rsRjOYrmeOIMY3brz0z05NvkZyw7R3WDL0orl27wTSOS/bC1Rn6DIAHQgkaggE4HlA26Zza8Q
 clic7+H17ilkD4uRNUXMZFtxxVzCLVBui/nxni+j8b7FJAf3wR9HJ2GtLcPOU1adhWQyvQe+b
 oU4ghdYekMmq85WdNz90nMFJc/cb5dWdt0QQm9CTDejrXkJxtzfIl1yfuGF+gt16SKt4UHT0O
 TLWQKuMPFn78j3RMZQjE7CDgvAXI1/zB0HdyxTUtbxBGeJNh1ZHIACpJscUD+
Message-ID-Hash: XDN4SSYG77YB4HSZGQ4P7YN6KUVBE4R2
X-Message-ID-Hash: XDN4SSYG77YB4HSZGQ4P7YN6KUVBE4R2
X-MailFrom: info@metux.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XDN4SSYG77YB4HSZGQ4P7YN6KUVBE4R2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* drivers/nvdimm/core.c doesn't use anything from badblocks.h on its own,
  thus including it isn't needed. There's indeed indirect use, via funcs
  in nd.h, but this one already includes badblocks.h.

* drivers/nvdimm/claim.c calls stuff from badblocks.h and therefore should
  include it on its own (instead of relying any other header doing that)

* drivers/nvdimm/btt.h doesn't really need anything from badblocks.h and
  can easily live with a forward declaration of struct badblocks (just having
  pointers to it, but not dereferencing it anywhere)

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/nvdimm/btt.h   | 3 ++-
 drivers/nvdimm/claim.c | 1 +
 drivers/nvdimm/core.c  | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/btt.h b/drivers/nvdimm/btt.h
index 2e258bee7db2..aa53e0b769bd 100644
--- a/drivers/nvdimm/btt.h
+++ b/drivers/nvdimm/btt.h
@@ -7,7 +7,6 @@
 #ifndef _LINUX_BTT_H
 #define _LINUX_BTT_H
 
-#include <linux/badblocks.h>
 #include <linux/types.h>
 
 #define BTT_SIG_LEN 16
@@ -197,6 +196,8 @@ struct arena_info {
 	int log_index[2];
 };
 
+struct badblocks;
+
 /**
  * struct btt - handle for a BTT instance
  * @btt_disk:		Pointer to the gendisk for BTT device
diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 5a7c80053c62..030dbde6b088 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -4,6 +4,7 @@
  */
 #include <linux/device.h>
 #include <linux/sizes.h>
+#include <linux/badblocks.h>
 #include "nd-core.h"
 #include "pmem.h"
 #include "pfn.h"
diff --git a/drivers/nvdimm/core.c b/drivers/nvdimm/core.c
index c21ba0602029..7de592d7eff4 100644
--- a/drivers/nvdimm/core.c
+++ b/drivers/nvdimm/core.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2013-2015 Intel Corporation. All rights reserved.
  */
 #include <linux/libnvdimm.h>
-#include <linux/badblocks.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
 #include <linux/module.h>
-- 
2.11.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
