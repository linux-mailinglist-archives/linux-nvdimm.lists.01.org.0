Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062063EDB
	for <lists+linux-nvdimm@lfdr.de>; Wed, 10 Jul 2019 03:16:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4D02D212B2060;
	Tue,  9 Jul 2019 18:16:53 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0A2AC212B0FFE
 for <linux-nvdimm@lists.01.org>; Tue,  9 Jul 2019 18:16:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m14so616347qka.10
 for <linux-nvdimm@lists.01.org>; Tue, 09 Jul 2019 18:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tyS5k/4QJCxPGcV91OLPh8wYVhK9QVlUZJPQN7ARXzo=;
 b=oIRaXzcBKN21PrMZxpFfBUUbAE7wF/UfbZoNG2Bo81kTMfH1jkYTY98GTIENUsItos
 V/WX4vpB1ciXEijN9rOhXuZxWeYIPcAwTN7nY6AcOWXL/QBUJIZ3udoI5EgSSrYP/v6Z
 n5zMxjMJN0LyV1nPiAgnF9KWNaXCjsqQ1RA2g69lzwit3bTSsd3CTb+ZpP8Yt1JHTAk+
 7mMvv1dHPucOHLPxqVU9EeLk6XkScChSXpj10FLFNDhUBRW4PeMiFSAEMN4izsN74QLv
 hSem2wQeYJr4YYe7fdf7Rk+3Py/i9ot4l52CQSRsBrhnyLj311qazIkAWg8uhCACaTgT
 L9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tyS5k/4QJCxPGcV91OLPh8wYVhK9QVlUZJPQN7ARXzo=;
 b=sjusLzpglaqM1My8wV/ZpuB/4XEcpDnMYgpcSB44D7MnD54hEzT/Hfvhd+GxJVKpUL
 QTcyU7Fjs8pxC5ye8JjiyJ14vYXPRlRBFR8oT6G+LseQcdIfOdHOYdyBPx2qwSlLAW/S
 9HfbQoRPG5W+aNMlW9V57MF+T7pXKcPqmgDdf0VribAlane49PbiZNo/nTbkPhGRLFw4
 J3JHbzfVPx9hhOAAFxMQO+rn0EMMMbDFlVYq1xje4J/lMktHMueeKIJbSvvNXGyZpwPr
 C8XYAhE6wJmSIPbD5udb/cC69pvIM9EXvB7+aFJckfCSX1mNuBpPFOD4L3DSTRwuqiez
 lN9w==
X-Gm-Message-State: APjAAAWFa81vT9wZ7dtJFN79oROMx/WCdKYTy0o/zp0WWAGQNcqpUB9S
 jCnDgBJwdDDrsbTVG8ZUZJtB1Q==
X-Google-Smtp-Source: APXvYqzSbKGKdJu9YdO8wNTJ5v/G3QEIGSQCvwnfWWheykUuMY8FrLDyWCW6hyyPO85S9nAUTrUtAw==
X-Received: by 2002:a37:bac2:: with SMTP id
 k185mr20774793qkf.211.1562721411119; 
 Tue, 09 Jul 2019 18:16:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net.
 [73.69.118.222])
 by smtp.gmail.com with ESMTPSA id u7sm260057qta.82.2019.07.09.18.16.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 18:16:50 -0700 (PDT)
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
Subject: [v7 1/3] device-dax: fix memory and resource leak if hotplug fails
Date: Tue,  9 Jul 2019 21:16:45 -0400
Message-Id: <20190710011647.10944-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710011647.10944-1-pasha.tatashin@soleen.com>
References: <20190710011647.10944-1-pasha.tatashin@soleen.com>
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
2.22.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
