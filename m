Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B94183E6
	for <lists+linux-nvdimm@lfdr.de>; Thu,  9 May 2019 04:48:08 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F10C82125ADD4;
	Wed,  8 May 2019 19:48:05 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: None (no SPF record) identity=mailfrom; client-ip=183.91.158.132;
 helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@cn.fujitsu.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
 by ml01.01.org (Postfix) with ESMTP id 417F421244A6A
 for <linux-nvdimm@lists.01.org>; Wed,  8 May 2019 19:48:03 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.60,448,1549900800"; d="scan'208";a="62198255"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 09 May 2019 10:47:59 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
 by cn.fujitsu.com (Postfix) with ESMTP id 3C54F4CDE919
 for <linux-nvdimm@lists.01.org>; Thu,  9 May 2019 10:40:43 +0800 (CST)
Received: from iridescent.g08.fujitsu.local (10.167.225.140) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 9 May 2019 10:40:45 +0800
From: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To: <linux-nvdimm@lists.01.org>
Subject: [PATCH] Documentation: nvdimm: Fix typo
Date: Thu, 9 May 2019 10:40:36 +0800
Message-ID: <20190509024036.7743-1-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
X-Originating-IP: [10.167.225.140]
X-yoursite-MailScanner-ID: 3C54F4CDE919.A75AC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Remove the extra 'we '.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 Documentation/nvdimm/nvdimm.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/nvdimm/nvdimm.txt b/Documentation/nvdimm/nvdimm.txt
index e894de69915a..a2013750bcf1 100644
--- a/Documentation/nvdimm/nvdimm.txt
+++ b/Documentation/nvdimm/nvdimm.txt
@@ -284,8 +284,8 @@ A bus has a 1:1 relationship with an NFIT.  The current expectation for
 ACPI based systems is that there is only ever one platform-global NFIT.
 That said, it is trivial to register multiple NFITs, the specification
 does not preclude it.  The infrastructure supports multiple busses and
-we we use this capability to test multiple NFIT configurations in the
-unit test.
+we use this capability to test multiple NFIT configurations in theunit
+test.
 
 LIBNVDIMM: control class device in /sys/class
 
-- 
2.17.0



_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
