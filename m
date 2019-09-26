Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A40BEAE2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 05:31:07 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40E0F21967BC5;
	Wed, 25 Sep 2019 20:33:10 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=taeho1224@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F13322010B848
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 20:33:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id z12so655830pgp.9
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 20:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=6ZAkreEHB/lqlL9aDOyiHcVgk+KB9MY8IQI5aLNve74=;
 b=tbR/W/kwYXbJoypDoQTRZSgSwbGpwKAnFDJcjsyzR9Kc+PpZmidxLtezMCeUdiZdTT
 C9KfviPoEHpQBqU4KZMraWUM+0c1aQiMnMdoCMUpCkQewBhlSplUKHTFHu7dnm1Za59J
 iXQLQz4JhDlzzq54MxvK1QQloB08u5TkcT8RQUD95Ze+FhmH/ek9cFk3yWDAh4O2fy2B
 x/6Q8QOr8bzLVrJtrTHEFzaEYtdFirYmVa1MVVcrMi86K5nzPmg1GQoze+jxqyrOpJUj
 uzoHDzbVS71LoOzva68zTzENvv3Z44mjkTPQz41764zYGsl5c5mQJW6jXJ4rJ+sXpjqW
 /90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6ZAkreEHB/lqlL9aDOyiHcVgk+KB9MY8IQI5aLNve74=;
 b=igON/GPy8m+JB+RJCknSlWOetz9e2wfdTV8IfLnizsF22Vzm7jc0x4rBVaWP9Chx92
 2Nb2A3xlRr6hjPg/Dwbj86Xqmyn4WE5Kq0tDbbPb6UPwHImcQ6M9M5U4W72ja0IOavS1
 JlYH5+Utyq5w1QF5zytqonSGODMM9XWhJtY/OS8159RC3EI5+qoQbocw3tGFS+jYUzp1
 elb61be2o3ww0e36riZPM2FWzP7L3fJZ4vCBaS5ADiyGIh1SfCMIcASOhZe6vdvzp7hE
 9fI3WDtmjARG4ew+ngmxjyil756D21Rqee/C0rUlBB8DQOLi3OJq09QARMYF54GmClXM
 xFzg==
X-Gm-Message-State: APjAAAWTOuMKLlHrj6XC3J26j/3S0gvm/jwZIX/COgvWM2up1fEntVPm
 32XqRAbwn+md+itX/i9dltPMMwNN
X-Google-Smtp-Source: APXvYqy+BcgkIjb9R5sYpPi5zzDF76Tg8Q+uBKVq7TUpzF4hadb8ULOOacODyR4ag709y5UoJS92bA==
X-Received: by 2002:a63:f342:: with SMTP id t2mr1226449pgj.194.1569468659330; 
 Wed, 25 Sep 2019 20:30:59 -0700 (PDT)
Received: from localhost.localdomain ([143.248.231.190])
 by smtp.gmail.com with ESMTPSA id 193sm495381pfc.59.2019.09.25.20.30.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 25 Sep 2019 20:30:58 -0700 (PDT)
From: Taeho Hwang <taeho1224@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH] pmem: emulating usable memory as persistent memory
Date: Thu, 26 Sep 2019 12:30:53 +0900
Message-Id: <1569468653-3489-1-git-send-email-taeho1224@gmail.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patch checks whether the specified memory (memmap) is
userable or not. This patch prevents non-existing memory
from being emulated as persistent memory.
If non-existing memory is specified by memmap without
this patch, struct nd_namespace_io and struct pmem_device
will have invalid values.

Signed-off-by: Taeho Hwang <taeho1224@gmail.com>
---
 arch/x86/kernel/e820.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 76dd605..ba9115d 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -178,9 +178,63 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
 	table->nr_entries++;
 }
 
+static void __init __e820__range_add_pram(struct e820_table *table, u64 start,
+					  u64 size)
+{
+	int nr_entries = table->nr_entries;
+	int new_nr_entries = nr_entries;
+	u64 range_start, range_end;
+	u64 end = start + size;
+	bool flag;
+	int i;
+
+	if (nr_entries >= ARRAY_SIZE(table->entries)) {
+		pr_err("too many entries; ignoring [mem %#010llx-%#010llx]\n",
+		       start, start + size - 1);
+		return;
+	}
+
+	for (i = 0; i < nr_entries; i++) {
+		if (table->entries[i].type != E820_TYPE_RESERVED_KERN &&
+				table->entries[i].type != E820_TYPE_RAM)
+			continue;
+
+		range_start = table->entries[i].addr;
+		range_end = table->entries[i].addr + table->entries[i].size;
+		flag = false;
+		if (range_start <= start && start < range_end) {
+			table->entries[new_nr_entries].addr = start;
+			if (end <= range_end)
+				table->entries[new_nr_entries].size = size;
+			else
+				table->entries[new_nr_entries].size =
+					range_end - start;
+			flag = true;
+		} else if (range_start < end && end <= range_end) {
+			table->entries[new_nr_entries].addr = range_start;
+			table->entries[new_nr_entries].size = end - range_end;
+			flag = true;
+		} else if (start <= range_start && range_end <= end) {
+			table->entries[new_nr_entries].addr = range_start;
+			table->entries[new_nr_entries].size =
+				range_end - range_start;
+			flag = true;
+		}
+		if (flag) {
+			table->entries[new_nr_entries].type = E820_TYPE_PRAM;
+			if (++new_nr_entries >= ARRAY_SIZE(table->entries))
+				break;
+		}
+	}
+	table->nr_entries = new_nr_entries;
+}
+
 void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 {
-	__e820__range_add(e820_table, start, size, type);
+	if (type == E820_TYPE_PRAM || type == E820_TYPE_PMEM)
+		__e820__range_add_pram(e820_table, start, size);
+	else
+		__e820__range_add(e820_table, start, size, type);
 }
 
 static void __init e820_print_type(enum e820_type type)
-- 
2.7.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
