Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAFE10D20
	for <lists+linux-nvdimm@lfdr.de>; Wed,  1 May 2019 21:18:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C4E22194EB7F;
	Wed,  1 May 2019 12:18:54 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::844; helo=mail-qt1-x844.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A73892122DDB1
 for <linux-nvdimm@lists.01.org>; Wed,  1 May 2019 12:18:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c13so1101810qtn.8
 for <linux-nvdimm@lists.01.org>; Wed, 01 May 2019 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=h5z1bbu8My60moCWezm7iQzfloAmd6aTxFKQXLUkDNyrqdYqTncDVWNt2X09qLxS3O
 XbNJsC/XnK1M4hHGHUsGpsWWJ1i66/0sC4pt//GILaeXj67jLKultNg/URuZLHxy9DUB
 n145ZqRuwWAPC05ewtKDW6T9fCTUIC1kV7gqHfS7NkOhqxEGKbdYX3L3QdBy8QG0TK+2
 p6Kiqtc4e3Q23gKMdpkbaVSUh5m4WX/FZssFEru/tThscoqK4pj6kyblkhFibSSTqHps
 jlV9ibZk/xaZpnwzsnlF3l2rW+yE2UD5A3zFgwhJCF3/xcOWS93XsJ8nIPrSkr14x6H6
 r4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=Jv3Sr0fUVqLMOI1h0gY2Z20VLI0paYile82GRVfU33w/KZGiPzZA/gTFoROKt9bBCk
 9apu2nE/LV6ef0t8MwsDwaCdptGaEIYnYklZWVnvQ3WEBysGEBsAtN+KMbQGSAqurzHq
 UZvuE98WJSY5JJOgQmWF1lqVGti1oYHwcNYIhGZLnXr1pyFdvimRd2OuBasSbaE6HzqK
 J5byxQi+D7rayuxBuqZEiQeOyDlq1A855KThJU25ZE1OKpIf6D+wF72mx8kfdg/vWjW7
 mPH/aRfEtfdY8/iY3YyihTSjwsEpdpKsUg1/fRc9ZQxKDNRLobZ6O09cueXUJ4tD5kB3
 9few==
X-Gm-Message-State: APjAAAVLVzxbEgi+kQ62KT6Yrce4Yigw23L1PuxwZnTGYD+cVkFSCOJj
 IdkFSI0GuhzaIUvFbtgWN8P/lg==
X-Google-Smtp-Source: APXvYqzlA1gs8NVCmNdnzWYF++bUyEWeUdXTHpCbd3dCNNP+aZRzqljBcQRUhKZSNsgRGIhKd6+NhA==
X-Received: by 2002:ac8:1c82:: with SMTP id f2mr8326722qtl.68.1556738330592;
 Wed, 01 May 2019 12:18:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id x47sm12610946qth.68.2019.05.01.12.18.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 May 2019 12:18:49 -0700 (PDT)
From: Pavel Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-nvdimm@lists.01.org, akpm@linux-foundation.org, mhocko@suse.com,
 dave.hansen@linux.intel.com, dan.j.williams@intel.com,
 keith.busch@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 zwisler@kernel.org, thomas.lendacky@amd.com, ying.huang@intel.com,
 fengguang.wu@intel.com, bp@suse.de, bhelgaas@google.com,
 baiyaowei@cmss.chinamobile.com, tiwai@suse.de, jglisse@redhat.com,
 david@redhat.com
Subject: [v4 1/2] device-dax: fix memory and resource leak if hotplug fails
Date: Wed,  1 May 2019 15:18:45 -0400
Message-Id: <20190501191846.12634-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190501191846.12634-1-pasha.tatashin@soleen.com>
References: <20190501191846.12634-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
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

When add_memory() function fails, the resource and the memory should be
freed.

Fixes: c221c0b0308f ("device-dax: "Hotplug" persistent memory for use like normal RAM")

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
---
 drivers/dax/kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a02318c6d28a..4c0131857133 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -66,8 +66,11 @@ int dev_dax_kmem_probe(struct device *dev)
 	new_res->name = dev_name(dev);
 
 	rc = add_memory(numa_node, new_res->start, resource_size(new_res));
-	if (rc)
+	if (rc) {
+		release_resource(new_res);
+		kfree(new_res);
 		return rc;
+	}
 
 	return 0;
 }
-- 
2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
