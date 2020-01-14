Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ECD13A0BD
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 Jan 2020 06:41:16 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4CD2210097DF6;
	Mon, 13 Jan 2020 21:44:32 -0800 (PST)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com; envelope-from=santosh@fossix.org; receiver=<UNKNOWN> 
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 945BA10097F20
	for <linux-nvdimm@lists.01.org>; Mon, 13 Jan 2020 21:44:29 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g9so2567060plq.1
        for <linux-nvdimm@lists.01.org>; Mon, 13 Jan 2020 21:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fossix-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKz4FX5CF5RWtMIEJLlbOdwI95yp0yWq9uv4iA4TuLU=;
        b=E79D5MKrwB8ytDFFU947MiiZe0BxbTsP/xCDyiyxTC4SMe8qIkYZwzlXp+99jHU7HR
         0/xpP7GNn5wy8dK390kBS4JL6NTs7ixK67fnVEJmbWMqb3uNT83LpHiNqdWTelMI84JR
         CxDgBT70On7NH0fqcvJrL8vld0mgMZBY7LNt/7wi36Zm8JUh9z4Ihe8wEDUgXFKynZcs
         stLXH5J2RvcUdW5KoW7BAnkpYAXcio9dsxGlGtZ5LxvrY53uXO00jxVsCfWeeNH80q5o
         NqZ9tjEEz2KcQBU8WYPF6x6eL1BSztS1rnh5cX9Cru7qoJwCcIUgN8UO+2F7hGsH3SfZ
         VNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NKz4FX5CF5RWtMIEJLlbOdwI95yp0yWq9uv4iA4TuLU=;
        b=miqLDU0d0xl7GXpna1VmPcDFdmyS8zQLlRDCS26xJPVGNoi/eFxevnakeUUjASr+mr
         Qxxse5rwltt3M125H+dMngjd9GUe45lL/B61GZweBWthrEE7TNNX/VVX9Gjxi+pT8ULx
         +1M+BnrHSC+ilOsySvGiXF9YGmrN09uNDeTQpxK050bea6BRa5F1LLV6GGYd5Pm87UtX
         f1thnSpwzYTqB+eBKIlGpC0onyeAa/kz81oiJRik5BXSHj+zk/ZE0RoRLrTJD1BD9MtL
         NjI/OHAqNlUYz9UWFrB+DyA0vXtlcL6YzGSWxbxKMztLBvszROFK9ZlJSXMnMqxPgQT/
         pkGg==
X-Gm-Message-State: APjAAAW2gajB9clJW0RjrwN4WXPk33BiTqwpXCQJUOdNfurZ8uE5aYk9
	SojOiAxqo4R66ldecewdUb1ODnrgIQ8=
X-Google-Smtp-Source: APXvYqycgnki7UFJ3jjwmkel10iCKfOZ8TQS/dAebxiAVDps0qH3m89EMQIS7ttcg/4My2qHjOa70A==
X-Received: by 2002:a17:90a:c388:: with SMTP id h8mr26116319pjt.83.1578980470196;
        Mon, 13 Jan 2020 21:41:10 -0800 (PST)
Received: from santosiv.in.ibm.com ([129.41.84.75])
        by smtp.gmail.com with ESMTPSA id j9sm15983173pff.6.2020.01.13.21.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 21:41:09 -0800 (PST)
From: Santosh Sivaraj <santosh@fossix.org>
To: linux-nvdimm@lists.01.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] tools/test/nvdimm: Fix out of tree build
Date: Tue, 14 Jan 2020 11:10:51 +0530
Message-Id: <20200114054051.4115790-1-santosh@fossix.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Message-ID-Hash: T2PZQA75J7DKHQR7H3SFX5Q2HWTXQWOR
X-Message-ID-Hash: T2PZQA75J7DKHQR7H3SFX5Q2HWTXQWOR
X-MailFrom: santosh@fossix.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/T2PZQA75J7DKHQR7H3SFX5Q2HWTXQWOR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Out of tree build using

   make M=tools/test/nvdimm O=/tmp/build -C /tmp/build

fails with the following error

make: Entering directory '/tmp/build'
  CC [M]  tools/testing/nvdimm/test/nfit.o
linux/tools/testing/nvdimm/test/nfit.c:19:10: fatal error: nd-core.h: No such file or directory
   19 | #include <nd-core.h>
      |          ^~~~~~~~~~~
compilation terminated.

That is because the kbuild file uses $(src) which points to
tools/testing/nvdimm, $(srctree) correctly points to root of the linux
source tree.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 tools/testing/nvdimm/Kbuild      | 4 ++--
 tools/testing/nvdimm/test/Kbuild | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index 6aca8d5be159..0615fa3d9f7e 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -22,8 +22,8 @@ DRIVERS := ../../../drivers
 NVDIMM_SRC := $(DRIVERS)/nvdimm
 ACPI_SRC := $(DRIVERS)/acpi/nfit
 DAX_SRC := $(DRIVERS)/dax
-ccflags-y := -I$(src)/$(NVDIMM_SRC)/
-ccflags-y += -I$(src)/$(ACPI_SRC)/
+ccflags-y := -I$(srctree)/drivers/nvdimm/
+ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 
 obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
diff --git a/tools/testing/nvdimm/test/Kbuild b/tools/testing/nvdimm/test/Kbuild
index fb3c3d7cdb9b..75baebf8f4ba 100644
--- a/tools/testing/nvdimm/test/Kbuild
+++ b/tools/testing/nvdimm/test/Kbuild
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-ccflags-y := -I$(src)/../../../../drivers/nvdimm/
-ccflags-y += -I$(src)/../../../../drivers/acpi/nfit/
+ccflags-y := -I$(srctree)/drivers/nvdimm/
+ccflags-y += -I$(srctree)/drivers/acpi/nfit/
 
 obj-m += nfit_test.o
 obj-m += nfit_test_iomap.o
-- 
2.24.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
