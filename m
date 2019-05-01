Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8610581
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 May 2019 08:42:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 31C262121AA06;
	Tue, 30 Apr 2019 23:42:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=nishadkamdar@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 80E62212017E7
 for <linux-nvdimm@lists.01.org>; Tue, 30 Apr 2019 23:42:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u17so4269595pfn.7
 for <linux-nvdimm@lists.01.org>; Tue, 30 Apr 2019 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=JsEmKkv5N9dvLUrbidM9wSUlAe5nAnboBrCBffm62Oo=;
 b=cwL3PtqtIkyYXoJT8odJ4izToz0VBot3Jm0mH9awQEBSbg1neNxRnFwh69nPWQIIU9
 OdnBFc6HA9635L6JCd7SgGIXGR6FKmL/7sO4BqDh0P/UaoaF+FFA3dRSUBIlS4iOno3Y
 6+Se5F8lLsaEheXKR0qTOXC727tJuyvgt5NUz1UZEL31cbZItaTzFHuUw0UMY6kI1Xi4
 JfsTy9tGNmOKxBAHKrPYZn/aphnf4y0tR8uQIB0cqqCF/R16SWDz7PbPXNvPGRiMIffA
 Cmis7AMgaST3fUN0AzleS+JKzMpseqENAuj9usG0m93dD6ufvhU0A+k4wAOXpejBdiBV
 yEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=JsEmKkv5N9dvLUrbidM9wSUlAe5nAnboBrCBffm62Oo=;
 b=mSVlUAdm6ielzZiaDSx5d45EnqTXLSe3kNGdwQeqrx/ReIfGyISbVPQyVMzFADXdyG
 Vu+gBSTCjv7Y+Mye5inDRnCNgn3VXwflgaSIuqbwmKld7QFPEV+XepUKIl8dIST3I8Ar
 twDz3x8icM4p5EXrjKGdRFHaVG79Hy5neY8XhfxQCTyuW1yVJidR2Av1ecLPslhu1W/9
 yjo4qOeIL+jJEt23iRkWzXCAsYeO5H+I2IILGBj1rzjudwdFrmxwH7eEQSdS5PzCj+Wo
 6+a1DqR1/YOWlOTwDmFDY+++xq1KzXpNw7VSjopz9KgNc7Sy6k/z9qtSyu2pYzj331mx
 mAMA==
X-Gm-Message-State: APjAAAXfvzAhhpRPhy/8QfK9plIdwuyaFpRK39zg62G1q6QWR4Yddcwv
 VjOUgl4Wf3H/kO1TB90RhkM=
X-Google-Smtp-Source: APXvYqzzg8hCBN/xO+owS00ws0DIIRdvdI1vRuQPYNc5wNzisAaB1v4Ael0P4vq8O2PlbTqQSZrnTw==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr22819697pfm.214.1556692941512; 
 Tue, 30 Apr 2019 23:42:21 -0700 (PDT)
Received: from nishad ([106.51.235.3])
 by smtp.gmail.com with ESMTPSA id b144sm15434921pfb.68.2019.04.30.23.42.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 30 Apr 2019 23:42:20 -0700 (PDT)
Date: Wed, 1 May 2019 12:12:13 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Keith Busch <keith.busch@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Subject: [PATCH] acpi/nfit: Use the correct style for SPDX License Identifier
Message-ID: <20190501064209.GA4716@nishad>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: linux-nvdimm@lists.01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

This patch corrects the SPDX License Identifier style
in drivers/acpi/nfit/intel.h. For C header files
Documentation/process/license-rules.rst mandates C-like comments
(opposed to C source files where C++ style should be used)

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/acpi/nfit/intel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/intel.h b/drivers/acpi/nfit/intel.h
index 0aca682ab9d7..8f5461c1dd9d 100644
--- a/drivers/acpi/nfit/intel.h
+++ b/drivers/acpi/nfit/intel.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright(c) 2018 Intel Corporation. All rights reserved.
  * Intel specific definitions for NVDIMM Firmware Interface Table - NFIT
-- 
2.17.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
