Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0743AB283
	for <lists+linux-nvdimm@lfdr.de>; Sat, 27 Apr 2019 05:19:55 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D05CF21A02937;
	Fri, 26 Apr 2019 20:19:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::741; helo=mail-qk1-x741.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A1235211FB8A6
 for <linux-nvdimm@lists.01.org>; Fri, 26 Apr 2019 20:19:50 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f125so3097096qke.6
 for <linux-nvdimm@lists.01.org>; Fri, 26 Apr 2019 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OGtSkbrfqyBgtc4rP22xBZIRFEyicKx1tiObNiky77o=;
 b=J/U3Jr4XTmDoTCfwjj+FuI8FhH3qpuq+DSKEb2NW/Zokzz/0oK76BaLNNr7a49D+Oc
 zTv9hRlSoJ1nWizLTiPq6QZOgJv0TMTcwzgKiKX09+5vSHSlSDqN0WBlM4I3PVX2/NDq
 5Ewni8LqnIg4ODj1AjBCRm4+JQXCPhWmwg1gevEXj7K8iwYUn4IT2nj9pQUiuCFPpoa2
 KqfXwPU2r72Nxl/ySPBOoIRWjF5GFyVCGvnHd90XgB4SQOCkGTJvHWn4fRrAHRcx/Wmw
 H45JwXpsaQ4nZW5PadgHmOrsYNe5T/cTKYPxaV6iuLAxKhR28RDPwM+ZRyoeGjys1Hl/
 cO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OGtSkbrfqyBgtc4rP22xBZIRFEyicKx1tiObNiky77o=;
 b=Gp8owqaFONxNDQbgHTPtspa/kld3te8oBS4+FBk54m50+n2B2UE0AKHko2dkgekrcY
 N038CJB+QLcjpal3DSAygx5YkdNKAHTDCYERsfUcvqmtat5aYVp2pgWy2JANhDA+f08r
 vvTVk9UJwNIE+HV+fOJGHzURX2OY49da55/XtOtiMTwi09SVA+FLdifLCAWX1J7WJJBA
 fdnBW9CqzP08M5DtI+SAIjwcEOCwLcOb3RhCXdnULZGF0ub02Udc94Jc7H3MP1SWVIVn
 S2CVXq8hbceKgxbv0muoEzwp0R0cvHS7hr7fcbkwsA22uO1c1gco1FPanqE/KC5Adib3
 hfzw==
X-Gm-Message-State: APjAAAVBp8QRWi9IbFGnOqPD7mT3lsI0m54q2WJ3py9vJGxoSCpSlNAu
 AJ7vOFjb6MV94JNYKiL+6xyMtA==
X-Google-Smtp-Source: APXvYqxynUMrBPzOVGDq1hikUPyqFmBF4yXkxtPoiNxcYWHUu/4MY+kMUFIf6Qm0G99pR4jVmckSlw==
X-Received: by 2002:a05:620a:34b:: with SMTP id
 t11mr26134494qkm.279.1556335189081; 
 Fri, 26 Apr 2019 20:19:49 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id s55sm16478685qte.17.2019.04.26.20.19.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Apr 2019 20:19:48 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
 keith.busch@intel.com, ira.weiny@intel.com
Subject: [PATCH] nvdimm: fix some compilation warnings
Date: Fri, 26 Apr 2019 23:19:34 -0400
Message-Id: <20190427031934.94947-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
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
Cc: Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
 linux-nvdimm@lists.01.org
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

The commit d9b83c756953 ("libnvdimm, btt: rework error clearing") left
an unused variable.
drivers/nvdimm/btt.c: In function 'btt_read_pg':
drivers/nvdimm/btt.c:1272:8: warning: variable 'rc' set but not used
[-Wunused-but-set-variable]

Last, some places abuse "/**" which is only reserved for the kernel-doc.
drivers/nvdimm/bus.c:648: warning: cannot understand function prototype:
'struct attribute_group nd_device_attribute_group = '
drivers/nvdimm/bus.c:677: warning: cannot understand function prototype:
'struct attribute_group nd_numa_attribute_group = '

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/nvdimm/btt.c   | 6 ++----
 drivers/nvdimm/bus.c   | 4 ++--
 drivers/nvdimm/label.c | 2 ++
 drivers/nvdimm/label.h | 2 --
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 4671776f5623..9f02a99cfac0 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1269,11 +1269,9 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
 
 		ret = btt_data_read(arena, page, off, postmap, cur_len);
 		if (ret) {
-			int rc;
-
 			/* Media error - set the e_flag */
-			rc = btt_map_write(arena, premap, postmap, 0, 1,
-				NVDIMM_IO_ATOMIC);
+			btt_map_write(arena, premap, postmap, 0, 1,
+				      NVDIMM_IO_ATOMIC);
 			goto out_rtt;
 		}
 
diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 7ff684159f29..2eb6a6cfe9e4 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -642,7 +642,7 @@ static struct attribute *nd_device_attributes[] = {
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
index f3d753d3169c..02a51b7775e1 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -25,6 +25,8 @@ static guid_t nvdimm_btt2_guid;
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
2.20.1 (Apple Git-117)

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
