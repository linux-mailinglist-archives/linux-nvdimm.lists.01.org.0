Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921781075C0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 22 Nov 2019 17:26:52 +0100 (CET)
Received: from ml01.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE8E710113300;
	Fri, 22 Nov 2019 08:27:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=kbusch@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 12B4F100DC407
	for <linux-nvdimm@lists.01.org>; Fri, 22 Nov 2019 08:27:15 -0800 (PST)
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 4225120714;
	Fri, 22 Nov 2019 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574440009;
	bh=DIxdwg3Q5937m62sq6bdtmPqNpGSKduCcyt14x3ZejI=;
	h=From:To:Cc:Subject:Date:From;
	b=WFu9VFNEBUyw++fPmfe99RwthqQluul39Ie48FhPg7+Dd1/FppjZ77CUKP0/7FjpR
	 bxONmnSuEWjbS3QhXl6n4M0WAZwL53AUF/tRIRbYppTcCIQqxT05jonuvMGV6GFnxy
	 FI5dF0rndwSfdJcs0RcLZAAK46EqLlei6T0vvfa8=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvdimm@lists.01.org
Subject: [PATCH] MAINTAINERS: Remove Keith from NVDIMM maintainers
Date: Sat, 23 Nov 2019 01:26:44 +0900
Message-Id: <20191122162644.27078-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Message-ID-Hash: NYUIC4JFQFKE4RXAP6KYYDGQP3U334IJ
X-Message-ID-Hash: NYUIC4JFQFKE4RXAP6KYYDGQP3U334IJ
X-MailFrom: kbusch@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Keith Busch <kbusch@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NYUIC4JFQFKE4RXAP6KYYDGQP3U334IJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

I no longer work in this capacity for the NVDIMM or DAX subsystems.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 064333607feb..b6ab2f9d977e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4878,7 +4878,6 @@ F:	include/trace/events/fs_dax.h
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
-M:	Keith Busch <keith.busch@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-nvdimm@lists.01.org
 S:	Supported
@@ -9338,7 +9337,6 @@ LIBNVDIMM: NON-VOLATILE MEMORY DEVICE SUBSYSTEM
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
-M:	Keith Busch <keith.busch@intel.com>
 M:	Ira Weiny <ira.weiny@intel.com>
 L:	linux-nvdimm@lists.01.org
 Q:	https://patchwork.kernel.org/project/linux-nvdimm/list/
-- 
2.21.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
