Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB421FEE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 May 2019 23:54:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B7BA92126CFB7;
	Fri, 17 May 2019 14:54:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::841; helo=mail-qt1-x841.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id CBEAB212604F2
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:43 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id f24so9718482qtk.11
 for <linux-nvdimm@lists.01.org>; Fri, 17 May 2019 14:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=MAG7Kwt56YLXgGpHlSwF6peeLCFWoe9w9yw1/4MNfZedRugiM5L9tJph4Z0qIqbysQ
 MQa00cOfj0ilwkOa8A4nZtTqACZDP70GVXMoFcppyNW6lFn1r8367ZG5q+tQtiGSR5mv
 QW2I+pdoS9IGt4WkV3+HceuXhZGG1MyYkpAD57R+twSBkhOqG+AEgv14CPl/X5joRCH/
 4Fu0gWVewSN9wTffe2BpgeBjoHryPvlUQAiajnV/yBfZ8fLU4J6TKSjKSAJu+0zFO3CM
 DYCy9YBFL8fXrbOMGGU+IeIiyzKMEGD2okiZG3r35R7oCY0l5vm2B9D5QUI1zTTygD27
 nSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=154pK5P8ksWbhOO3IYrUyqpSsi0GfqRRa2gpHRslqUk=;
 b=ZpdNy480Oo28oy8bpdweOOK+Gwl9gFQ7HvML/q9OmH/XW3ByW8NR94heVeVgARY/jZ
 qZflgwmDcbEHuvHZODeY4g02pgGg9HogKUZxLu+8wL1BXxuYpvBVOekX8kaL6u6URUsc
 RoLDaTPhB8NHlewI1kBRrHa25NnKU1qH41d8DLBV651YfxKWtrcVVszlsgzKsgUlvrUr
 Q4N/O3cl3HD817bdqVOo8gzjwE43riQg18jemw9gNRHuy+k1FgWuJEJ2g4yIhoc6W+Y/
 HD8DNt8DD+isCdfnEFy+NTUEvN7fONSRbkDVo+6N6pvlPeJhxF73TnWcM614GOrkpzzA
 XDOg==
X-Gm-Message-State: APjAAAUe/9vUTAWOpkLx1vx27JO3JzWZzlqfzqyLhPsecQQe4lnIUt9Q
 FCVyyjTVF51R1qI3/BLdMrGFAw==
X-Google-Smtp-Source: APXvYqzgOTJEZbvtrTHUCsU4W9MY9QwY+/vt23cg4Q1By0cu8+zJHQ1zc5/kIujRbiw57m5j08mTsQ==
X-Received: by 2002:aed:35c4:: with SMTP id d4mr50747244qte.311.1558130082975; 
 Fri, 17 May 2019 14:54:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id n36sm6599813qtk.9.2019.05.17.14.54.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 17 May 2019 14:54:42 -0700 (PDT)
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
Subject: [v6 1/3] device-dax: fix memory and resource leak if hotplug fails
Date: Fri, 17 May 2019 17:54:36 -0400
Message-Id: <20190517215438.6487-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517215438.6487-1-pasha.tatashin@soleen.com>
References: <20190517215438.6487-1-pasha.tatashin@soleen.com>
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
