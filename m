Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE87B5A4C
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Sep 2019 06:23:11 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E4CE021A07093;
	Tue, 17 Sep 2019 21:22:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=natechancellor@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 4CF5821A07A82
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 21:22:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y19so5326535wrd.3
 for <linux-nvdimm@lists.01.org>; Tue, 17 Sep 2019 21:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rIq1JW2tJfg0PLRUSRfWmLD8aLaxDS+5OXqW5mJJ9Ks=;
 b=fRTMoTPj0TY3IwpoEkLUTYo895YGKUjTwvCKWHbiP8HcHOZ2h2ukSQou4QFkChl9lQ
 gtpSK/+spGlce6w9CW6cLFbWC6alnYhM4bAwzF/dwFSEEaFZSJpO7acxUVnEhjYNmFej
 IjQhel4fxJU78vDmVkabsvbgh4SyqZRYQ7QXHdi/OYrVsN6k3odmuxkZXaYPaFQi1D0X
 6bEz+C725Dk/h5smiBjDCFNxQyfxebQj5jYeQXRWt2MSrLDoLevqn+MgzbwgVbO2/6p2
 7VqlNknsWZr3jGKSjEXDNJ+iH9S6EmVOiXi3wgeiz/SWpkk33ip8WCt3LLP2URK2FLN5
 AXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rIq1JW2tJfg0PLRUSRfWmLD8aLaxDS+5OXqW5mJJ9Ks=;
 b=bBPLt94quOJvz6r6Mq47Y1Osl0XVzQwLHXRBhtu91M3TuUJys4IDbmFSA/1tXMPytB
 5aOBkPhjw7JbitxhKxS5AeZ/9OuAAvhSumU97hMEcME+MJaopSYcLG82un6E5P9bSLNI
 CXzSqvDMJPyGUa8Jo41X4zTwqgEC3J4vHvxYJpdKtpuhEQ8F6DMWrp21tPkTg2601krH
 peFN7JVcGApxUCDPsPOnuSGG0efnX753c2EzfaUVjkzajYm+8IM2M3yBRys1nCo+FFj0
 OuDPNFagYigK+wWCN0ajT0jyCVZFxzbHqp52xeFigcT9ZRsFaWl3Ck+J/YUISVgQFmyK
 bh4g==
X-Gm-Message-State: APjAAAXgMk3u/LVO+DGzhIs8c2+ZwwrXpawgPMK/5pyvX7kU84XCzh1Q
 sDLPKkX25OHSHDtEdj+8V0Q=
X-Google-Smtp-Source: APXvYqxmmEkIqD0/D/VTb3sYHmywgdZ2V8y+kabvMCfN2nD9OEBNHZNyZSUL+o0wBNWiQzizYbi7RA==
X-Received: by 2002:adf:f502:: with SMTP id q2mr1179861wro.186.1568780586216; 
 Tue, 17 Sep 2019 21:23:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
 by smtp.gmail.com with ESMTPSA id b184sm1025464wmg.47.2019.09.17.21.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 21:23:05 -0700 (PDT)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
Date: Tue, 17 Sep 2019 21:21:49 -0700
Message-Id: <20190918042148.77553-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
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
Cc: clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>,
 Jason Gunthorpe <jgg@mellanox.com>, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
compile checks"), clang warns:

In file included from
../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
warning: redefinition of typedef 'acpi_handle' is a C11 feature
[-Wtypedef-redefinition]
typedef void *acpi_handle;
              ^
../include/acpi/actypes.h:424:15: note: previous definition is here
typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
              ^
1 warning generated.

The include chain:

iomap.c ->
    linux/acpi.h ->
        acpi/acpi.h ->
            acpi/actypes.h
    nfit_test.h

Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
remove both the typedef and the forward declaration of acpi_object.

Link: https://github.com/ClangBuiltLinux/linux/issues/660
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I know that every maintainer has their own thing with the number of
includes in each header file; this issue can be solved in a various
number of ways, I went with the smallest diff stat. Please solve it in a
different way if you see fit :)

 tools/testing/nvdimm/test/nfit_test.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index 448d686da8b1..0bf5640f1f07 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -4,6 +4,7 @@
  */
 #ifndef __NFIT_TEST_H__
 #define __NFIT_TEST_H__
+#include <linux/acpi.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
 #include <linux/ioport.h>
@@ -202,9 +203,6 @@ struct nd_intel_lss {
 	__u32 status;
 } __packed;
 
-union acpi_object;
-typedef void *acpi_handle;
-
 typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
 typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
 		 const guid_t *guid, u64 rev, u64 func,
-- 
2.23.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
