Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0629520C60
	for <lists+linux-nvdimm@lfdr.de>; Thu, 16 May 2019 18:05:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 135C021268F99;
	Thu, 16 May 2019 09:05:45 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 8B2B0212604F3
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 09:05:42 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id a64so2596324qkg.5
 for <linux-nvdimm@lists.01.org>; Thu, 16 May 2019 09:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=zAUITjpKKLROuX37hMbdqPFlWmaHToD076fNZLb8xfM=;
 b=paTihldvOejMhzU/pjmy6cxi8/gHfncg9BvJEgw2jZdu7GTTbC6dOi2N34C/kPD+Xe
 llzWo0lUVN5/gH0xigfPAuVxfctO5acb6uM491mjwy+kalcRZrNptGYgtffAGrQm9xKD
 z7cMdKXJJ63VeJ7S62XKUCWg+IJtnA/MuoC0yG1jQRxUMfjTvjsouU6GeU1UhoLOpUy4
 O6jaxq5Vx3jRm2UgvJs0jhTxt1tfjYW5uy/RR5+JF5zvEl0wMsgK+PEzcCVYX5Ml6OgS
 CWMiUYVZvGJpz30FdN/Uvc6ui0RhJyX+CoWvDh4wvgFBWaqBSYRetGUz7xlHg0r4k5NR
 ODlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=zAUITjpKKLROuX37hMbdqPFlWmaHToD076fNZLb8xfM=;
 b=FPKYAFKSrUio1XcZz19AHNmNbTnGAXvkCg3rzSPYQESYROcD7ucjl27P0nhHSbJg02
 CxkyuVKZQTX/hOk7ZnygB7Tkqf0K0RQ7K3qSHgRu6CTd7PvXYz14AE2LBIuNEGij260d
 lFNF6jRrZu7uf5zKG3UkG8VRhrsTAEsAV5+DiuI8SXGPNWbXO/McVCSSGfE0Jmu3CWQG
 XxOU8EJzT0ipJfYW9pfI5EetEV4S1Zqbwx8k9sl5vgjejhdyg+W74bDu5P8n/hH2HFfE
 yMk9Rob1t6ZrytMmv5ya2GgZSYHlPkpDB7BayISIKTl+RllWX/vA76S0U+jo01ilP6z0
 ifjg==
X-Gm-Message-State: APjAAAX7TtreyprtZzao4WluvzBGpou1DnQ1yE57Nez2S+iRqcM/XwaF
 4Dk9R71cx480AKBcVGHpbU4h0g==
X-Google-Smtp-Source: APXvYqw/JHD28fUlPb8lI2g8to9VAAo+dI6jsWFcrAF1ACiFIBSxV5uVdFEIpYrHZwfcWMG0OgWwTw==
X-Received: by 2002:a37:684a:: with SMTP id d71mr13791295qkc.25.1558022741627; 
 Thu, 16 May 2019 09:05:41 -0700 (PDT)
Received: from qcai.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id z29sm2569186qkg.19.2019.05.16.09.05.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 May 2019 09:05:40 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: dan.j.williams@intel.com
Subject: [PATCH] nvdimm: fix compilation warnings with W=1
Date: Thu, 16 May 2019 12:04:53 -0400
Message-Id: <1558022693-9631-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Several places (dimm_devs.c, core.c etc) include label.h but only
label.c uses NSINDEX_SIGNATURE, so move its definition to label.c
instead.

In file included from drivers/nvdimm/dimm_devs.c:23:
drivers/nvdimm/label.h:41:19: warning: 'NSINDEX_SIGNATURE' defined but
not used [-Wunused-const-variable=]

Also, some places abuse "/**" which is only reserved for the kernel-doc.

drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
'struct attribute_group nd_device_attribute_group = '
drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
'struct attribute_group nd_numa_attribute_group = '

Those are just some member assignments for the "struct attribute_group"
instances and it can't be expressed in the kernel-doc.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/nvdimm/bus.c   | 4 ++--
 drivers/nvdimm/label.c | 2 ++
 drivers/nvdimm/label.h | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7ff684159f29..2eb6a6cfe9e4 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -642,7 +642,7 @@ static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
 	NULL,
 };
 
-/**
+/*
  * nd_device_attribute_group - generic attributes for all devices on an nd bus
  */
 struct attribute_group nd_device_attribute_group = {
@@ -671,7 +671,7 @@ static umode_t nd_numa_attr_visible(struct kobject *kobj, struct attribute *a,
 	return a->mode;
 }
 
-/**
+/*
  * nd_numa_attribute_group - NUMA attributes for all devices on an nd bus
  */
 struct attribute_group nd_numa_attribute_group = {
diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index 2030805aa216..edf278067e72 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -25,6 +25,8 @@
 static guid_t nvdimm_pfn_guid;
 static guid_t nvdimm_dax_guid;
 
+static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
+
 static u32 best_seq(u32 a, u32 b)
 {
 	a &= NSINDEX_SEQ_MASK;
diff --git a/drivers/nvdimm/label.h b/drivers/nvdimm/label.h
index e9a2ad3c2150..4bb7add39580 100644
--- a/drivers/nvdimm/label.h
+++ b/drivers/nvdimm/label.h
@@ -38,8 +38,6 @@ enum {
 	ND_NSINDEX_INIT = 0x1,
 };
 
-static const char NSINDEX_SIGNATURE[] = "NAMESPACE_INDEX\0";
-
 /**
  * struct nd_namespace_index - label set superblock
  * @sig: NAMESPACE_INDEX\0
-- 
1.8.3.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
