Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1688E2A387D
	for <lists+linux-nvdimm@lfdr.de>; Tue,  3 Nov 2020 02:19:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5B4EC1631FAF1;
	Mon,  2 Nov 2020 17:19:35 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=sashal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A46F51631FAE5
	for <linux-nvdimm@lists.01.org>; Mon,  2 Nov 2020 17:19:22 -0800 (PST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 2B1D4222B9;
	Tue,  3 Nov 2020 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366362;
	bh=Y4pk0+NtOTsiLWykNqOh9dUwM35ghrHdAdWuyBg1o/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEcTlAaEG7NdrnvRteNZcgGm3xw6uRhTyCn4UqjT9jaNOnAZrkhf9H7G+2VlFnqOd
	 e+pGIdFODpJhrrD8T1D17jHj2oA+Ab6/VASkitZsbVKgu5Ed2gTdZrRI0TjunHJ2x/
	 dvggI7YFDRl4c/wPE85Ro40CnYN+DYdrcoJ//lUU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 31/35] ACPI: NFIT: Fix comparison to '-ENXIO'
Date: Mon,  2 Nov 2020 20:18:36 -0500
Message-Id: <20201103011840.182814-31-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011840.182814-1-sashal@kernel.org>
References: <20201103011840.182814-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Message-ID-Hash: YXJDTDZDFIG7EMQ4HLAFJ6SD4PUS5WE4
X-Message-ID-Hash: YXJDTDZDFIG7EMQ4HLAFJ6SD4PUS5WE4
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Zhang Qilong <zhangqilong3@huawei.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YXJDTDZDFIG7EMQ4HLAFJ6SD4PUS5WE4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit 85f971b65a692b68181438e099b946cc06ed499b ]

Initial value of rc is '-ENXIO', and we should
use the initial value to check it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 26dd208a0d636..103ae7401f957 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
 					le16_to_cpu(nfit_dcr->dcr->code));
 			break;
 		}
-		if (rc != ENXIO)
+		if (rc != -ENXIO)
 			break;
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
-- 
2.27.0
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
