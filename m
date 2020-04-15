Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCC1A9CA8
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 Apr 2020 13:37:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 136C91010630E;
	Wed, 15 Apr 2020 04:37:46 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 72B601010630D
	for <linux-nvdimm@lists.01.org>; Wed, 15 Apr 2020 04:37:43 -0700 (PDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id F318820768;
	Wed, 15 Apr 2020 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586950633;
	bh=O9zMXw7EVV/7T8D8FIM99Vc76xzMBdRqHU46kaUojBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYpIsVMNBA/ASHTyM8jh6UYh5W1dkPKOhw7p6nDAUCQTpiSnJcYHAEHgoP7cEveem
	 Se2qx0TynC4V/o84rm2HVnd4IojxQs1eAYVCONT+I0JpSJqhVMqW++mtTxktgkmeNK
	 gJ+Vhp5HPfyt/xYqdn3VJVcC/sZObbB6KEqIH1QY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 124/129] libnvdimm: Out of bounds read in __nd_ioctl()
Date: Wed, 15 Apr 2020 07:34:39 -0400
Message-Id: <20200415113445.11881-124-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: BJYGYJTRH4PQMVKZT226E6T5BJBS6O74
X-Message-ID-Hash: BJYGYJTRH4PQMVKZT226E6T5BJBS6O74
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Dan Carpenter <dan.carpenter@oracle.com>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BJYGYJTRH4PQMVKZT226E6T5BJBS6O74/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f84afbdd3a9e5e10633695677b95422572f920dc ]

The "cmd" comes from the user and it can be up to 255.  It it's more
than the number of bits in long, it results out of bounds read when we
check test_bit(cmd, &cmd_mask).  The highest valid value for "cmd" is
ND_CMD_CALL (10) so I added a compare against that.

Fixes: 62232e45f4a2 ("libnvdimm: control (ioctl) messages for nvdimm_bus and nvdimm devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200225162055.amtosfy7m35aivxg@kili.mountain
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/bus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index a8b5159685699..09087c38fabdc 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -1042,8 +1042,10 @@ static int __nd_ioctl(struct nvdimm_bus *nvdimm_bus, struct nvdimm *nvdimm,
 			return -EFAULT;
 	}
 
-	if (!desc || (desc->out_num + desc->in_num == 0) ||
-			!test_bit(cmd, &cmd_mask))
+	if (!desc ||
+	    (desc->out_num + desc->in_num == 0) ||
+	    cmd > ND_CMD_CALL ||
+	    !test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
 
 	/* fail write commands (when read-only) */
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
