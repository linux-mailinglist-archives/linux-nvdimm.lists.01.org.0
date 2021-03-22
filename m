Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BC344013
	for <lists+linux-nvdimm@lfdr.de>; Mon, 22 Mar 2021 12:45:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6221A100EBB6F;
	Mon, 22 Mar 2021 04:45:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=arnd@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BC9DC100EBB6C
	for <linux-nvdimm@lists.01.org>; Mon, 22 Mar 2021 04:45:19 -0700 (PDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 945126198D;
	Mon, 22 Mar 2021 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1616413518;
	bh=liwkJr++xOmGVh9TPdenTt5K01dJM4oOTKgZCRao8aE=;
	h=From:To:Cc:Subject:Date:From;
	b=kbYalYvBeuLzPrVLtbx44T1v/8Z+M7nARJqzUOvEZS21sWRUC+xT2rbuhnUHSyV/h
	 G7NJO4+Wut5U+8JT8eTSvosRajsGXhrJ/vlWqESbNQSIn8qVFXebo9AwV3LLlaE5J6
	 4/ebt+CABMqJJmpigDR20TD5DnkL1Nuvg9UqlUTV9ji3n4rC5fU7IXesHPBhvK2rN9
	 zl2IIWE5DEV6+pwzMsrRMm1Xg1yIjiAfvlVdnuo/uTZGRDq5dUUNUiGFVxlcICymrO
	 Pys3xfKwfKBTuyy/6Ra8mqke1DWkKRVQqP3V0Bni0wlL6sOi/0izhgbF8kjWPdFebC
	 USNdtP74Gsd0A==
From: Arnd Bergmann <arnd@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: [PATCH] dax: avoid -Wempty-body warnings
Date: Mon, 22 Mar 2021 12:44:58 +0100
Message-Id: <20210322114514.3490752-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Message-ID-Hash: 6S5CWQGIRMIZ7IJ4NZEOFDM4BSKIPTC3
X-Message-ID-Hash: 6S5CWQGIRMIZ7IJ4NZEOFDM4BSKIPTC3
X-MailFrom: arnd@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Joao Martins <joao.m.martins@oracle.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Zhen Lei <thunder.leizhen@huawei.com>, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/6S5CWQGIRMIZ7IJ4NZEOFDM4BSKIPTC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an empty body in an else statement:

drivers/dax/bus.c: In function 'do_id_store':
drivers/dax/bus.c:94:48: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
   94 |                         /* nothing to remove */;
      |                                                ^
drivers/dax/bus.c:99:43: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
   99 |                 /* dax_id already added */;
      |                                           ^

In both of these cases, the 'else' exists only to have a place to
add a comment, but that comment doesn't really explain that much
either, so the easiest way to shut up that warning is to just
remove the else.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dax/bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 452e85ae87a8..5aee26e1bbd6 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -90,13 +90,11 @@ static ssize_t do_id_store(struct device_driver *drv, const char *buf,
 				list_add(&dax_id->list, &dax_drv->ids);
 			} else
 				rc = -ENOMEM;
-		} else
-			/* nothing to remove */;
+		}
 	} else if (action == ID_REMOVE) {
 		list_del(&dax_id->list);
 		kfree(dax_id);
-	} else
-		/* dax_id already added */;
+	}
 	mutex_unlock(&dax_bus_lock);
 
 	if (rc < 0)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
