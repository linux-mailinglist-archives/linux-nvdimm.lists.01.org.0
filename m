Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335281CB65
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 17:08:44 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D6A62125F1E2;
	Tue, 14 May 2019 08:08:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::843; helo=mail-qt1-x843.google.com;
 envelope-from=cai@lca.pw; receiver=linux-nvdimm@lists.01.org 
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B44852122CA9A
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 08:08:40 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id a17so18131771qth.3
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7kZvhpKITp7GpY2UYW4YcAvoZ7pH6PjHdqS7w9gr3cw=;
 b=FuNs4AlL6ZoplYtEJAQPOUNR/irdssflBkI+WQYPo1k/Wp9qb40VYJ1S/iMw+nVr0Z
 4W4KadJrj7s3iAuyCBi8kLa3aqKQxyjzYo7fAC8lYvsILAF4pYUFEVOvOOhlTV4tyOG8
 JSmJJuF+v9bt7JN7AIJ7VGwKBNTBusf8T15Nwptam76/E/bo8Vlk4vb5QhKdKqRMpced
 Ke2C12ECJhs+pKHO4zwcieQTkqMX58OBTmeeO7l1iAcqgKYimyU921AyV77UcNGmNsfn
 Y5kfuxZg6vtXDRNqV7zxGzPkon5jAyrfhclfTkPWY0mMc7p7B0eCrm0cRmZ/7CiNimR7
 wczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7kZvhpKITp7GpY2UYW4YcAvoZ7pH6PjHdqS7w9gr3cw=;
 b=iIApwQjlmDbFVdisfVI9T+7Yau7W+AU3O5NUdzgmIWAyTN7+4riNL1LCA3bMReWTbE
 Aj6lQFy0WfEqEf5nKGOiocIAxvMRBXThyXky+IhkWLMH/Vikyl+aIJA6N8Kkuz0EkuSC
 XhohIRolNk3u+DJBtxQz3xB2fmAfL91LPdUbHPg4JIJVZdb0R0tOnlgLkX3PbvorZUIJ
 rNh/zR4CKiAHdKPEweyzk6ua5MbUEKyJpZ9MHEq28EnM+Iw7ZumiD++6dJKvaGI3i3Q0
 xWt7PMhridkeQM3obYhmUNAYdGBA/GgUhdnFo9gIwigpFIJ2K/3Xtqg26OT2Wusg451b
 EuPA==
X-Gm-Message-State: APjAAAXS+daK9CcVUbHkhNCXMhyXSLZ5rVT7AnsZw0cp+Ku/DxomR4oD
 GlDcgT0BHIocVhfSlIu9FhhU7A==
X-Google-Smtp-Source: APXvYqyJLWdC5h+BGz6LDsPy3eLEj1lu0rQj66IlbHa/gB1z6dYmdFdVXyCb+ij3Jws+g//usPep4g==
X-Received: by 2002:ac8:2924:: with SMTP id y33mr29791366qty.212.1557846519358; 
 Tue, 14 May 2019 08:08:39 -0700 (PDT)
Received: from ovpn-120-85.rdu2.redhat.com
 (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
 by smtp.gmail.com with ESMTPSA id b19sm8577242qkk.51.2019.05.14.08.08.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 May 2019 08:08:38 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: akpm@linux-foundation.org
Subject: [RESEND PATCH] nvdimm: fix some compilation warnings
Date: Tue, 14 May 2019 11:07:35 -0400
Message-Id: <20190514150735.39625-1-cai@lca.pw>
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 Qian Cai <cai@lca.pw>
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

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
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
