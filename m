Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7161220E
	for <lists+linux-nvdimm@lfdr.de>; Thu,  2 May 2019 20:43:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 93DE921243BD8;
	Thu,  2 May 2019 11:43:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E7F332194D3B3
 for <linux-nvdimm@lists.01.org>; Thu,  2 May 2019 11:43:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n68so2147316qka.1
 for <linux-nvdimm@lists.01.org>; Thu, 02 May 2019 11:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=Ln6d07+pCYwbOjMFJVcdvs72qSgpRQCxY10mk5EhNLZCCmdMu75C3Wt5remthzgW67
 V4y5TmsCpIkhCATiM5w4PnSDvo+2ad76snqHZ1BlD/WCqdONPaNhAwrZFGW7OAb2V9sj
 evPR4Ort8jUgIJ58yqKrItZUPn32mS83xIUWpb8GYaC/nJNhKZfZFK2fc9lv+R9s3DTG
 rK2ZAUdIL3A7/jl4Mu2oUqA6qXaATfKDsG8ix3Umce3pVsoYEm7Xh9DaPp/mD9BhTRUD
 bFZMZj89CQS8F/ao/RoBvjb13qg+71zc3NWtzG51TmtvQZg+zD8u9n/dnSikt9j6kBv5
 Etsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=GuVuh15/JNZSQ2Qxxq81jov0+5A7kudydFM5dZkY2OWb00Ev+ICtEooEwnIAvizNtt
 LtHeF3PabtSPPe4WEzL8m4vTopA8RBZvPuwrHlz+Mdsxf7z0m+c83fRyfaYLTWD0eEh8
 oWRUvDnU2APx6G98LM0zKus61K1rKvbQv5XcD6WxXaApyK7uFlV5+/BRa/ezc6/uCpXQ
 vJVu/nkD0E0sjLgG33uwruUsyCUnCVrs2G4QZwFcAIsCqOyfB+6/M3U3P/it3NbesEdw
 cn37k8HqarxQ+zo/8fJ/BgcMA/tTgfC0OBjYJ1L37OXifkAS/wlxlqQ3YirQRsDFDd6r
 NyZA==
X-Gm-Message-State: APjAAAVgjkzw1H4Sn1JRqjfr7UbngwjzTI8t4/rj0s3FlbJd0iSi87j/
 kDM/WaYJiC1wrtpJzxmNWD/lZw==
X-Google-Smtp-Source: APXvYqwuy9FOxLCdwhhUyWDJtB7mrIu4/W4cCEop6zwbua1nKA58RqCKUegUOS0f+XcEcCAv92SrIA==
X-Received: by 2002:a37:4247:: with SMTP id p68mr2794611qka.89.1556822622604; 
 Thu, 02 May 2019 11:43:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id 8sm25355751qtr.32.2019.05.02.11.43.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2019 11:43:40 -0700 (PDT)
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
Subject: [v5 1/3] device-dax: fix memory and resource leak if hotplug fails
Date: Thu,  2 May 2019 14:43:35 -0400
Message-Id: <20190502184337.20538-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502184337.20538-1-pasha.tatashin@soleen.com>
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
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
