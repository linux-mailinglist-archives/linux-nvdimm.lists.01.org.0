Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3976826D9F2
	for <lists+linux-nvdimm@lfdr.de>; Thu, 17 Sep 2020 13:17:33 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7B60414E91576;
	Thu, 17 Sep 2020 04:17:31 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 27EC514E91576
	for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 04:17:28 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so1161894pgd.12
        for <linux-nvdimm@lists.01.org>; Thu, 17 Sep 2020 04:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZsYwoCWLsFDauGq7Mtp8VwaH5freNXofKdPDJlisvxU=;
        b=dwwHpHSGA59X/Lmd/y7j3BGmDIbvAT2RIWZy5HZdV2pABKgaMcLwP9EspJp32aWucp
         vSXlUiyufDUPV8HNxs2GzZMKSOFBo8YVgcfp8Lc5jEAt65wYcAXkAosjCvSljj3UJLcN
         xPH6s0Gzz0l/v3RZJBY1zqvkOpS3A45MQM5DS8ZYrHoEkBR8F/n116eCB3MOurdRmT7O
         Ht4WolcSufEH+RT4WyQih2iTVVmOPYwmMPfc3cr+8KxJiSbwGVBqf1KSBIaOJBQDyyFi
         9eXADcWPCcCNupa2zrPmSgMiu406X5ZmMnFJhuxNIIPZ01hG7GPa1q6fDNscV52hronv
         t4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZsYwoCWLsFDauGq7Mtp8VwaH5freNXofKdPDJlisvxU=;
        b=MJw6Fo3pq0mjbzSwre2SKZjpvHRBm/BMQTt7G0FFZjs1p1E+W19/jgmbx2X4j+IzzM
         AlZpa6wmIZ+IxuMC42/ChF6TiN593UxnFN+EWlEULd4NlNiHMKKxuGl6bSPX7Nhm7Fek
         dg9TSac+swzvUwPpPUumwJwkKH6gieclwHeRUeu0cKBY2EC2qdpq0ywPyo3OP2w1q0Y+
         i6WSBbvbDOVbGa5s/VjO6/FcWxXJJXsIaADcvKxNY48+J7iZ/R/F1mLQbCEFc97tMbQv
         cnBZu7i1sRsgRbSqwAw3NdvtG64R1A3/PFJHH1zG7ws+r4VSvIEznNlJGDjjDFreBJ3b
         Ix+g==
X-Gm-Message-State: AOAM530Zw4+WI42NUuiMUs2IXmcY2UGgtqklxZ4KwxcTzIETTZEbPYTe
	/vlqi0aGWylOE45aS9jmkV1kNYTSn9r+DG/I
X-Google-Smtp-Source: ABdhPJyyw0r5xG4BBTv0Y5/0iOToenIKuheV0D42gMlzXKzgLb2udVzoi1W8cxYaoSutrjJHdMZFXg==
X-Received: by 2002:a62:7b94:0:b029:142:2501:35e4 with SMTP id w142-20020a627b940000b0290142250135e4mr10890180pfc.68.1600341447310;
        Thu, 17 Sep 2020 04:17:27 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (218-166-2-49.dynamic-ip.hinet.net. [218.166.2.49])
        by smtp.googlemail.com with ESMTPSA id m21sm20317422pfo.13.2020.09.17.04.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:17:26 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH v3 1/1] dax: Fix stack overflow when mounting fsdax pmem device
Date: Thu, 17 Sep 2020 19:15:49 +0800
Message-Id: <20200917111549.6367-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: ACAIVRBDVYVB2JNGRMWOLBWO6D53EDA2
X-Message-ID-Hash: ACAIVRBDVYVB2JNGRMWOLBWO6D53EDA2
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Yi Zhang <yi.zhang@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Jan Kara <jack@suse.cz>, Adrian Huang <adrianhuang0701@gmail.com>, Adrian Huang <ahuang12@lenovo.com>, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ACAIVRBDVYVB2JNGRMWOLBWO6D53EDA2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Adrian Huang <ahuang12@lenovo.com>

When mounting fsdax pmem device, commit 6180bb446ab6 ("dax: fix
detection of dax support for non-persistent memory block devices")
introduces the stack overflow [1][2]. Here is the call path for
mounting ext4 file system:
  ext4_fill_super
    bdev_dax_supported
      __bdev_dax_supported
        dax_supported
          generic_fsdax_supported
            __generic_fsdax_supported
              bdev_dax_supported

The call path leads to the infinite calling loop, so we cannot
call bdev_dax_supported() in __generic_fsdax_supported(). The sanity
checking of the variable 'dax_dev' is moved prior to the two
bdev_dax_pgoff() checks [3][4].

[1] https://lore.kernel.org/linux-nvdimm/1420999447.1004543.1600055488770.JavaMail.zimbra@redhat.com/ 
[2] https://lore.kernel.org/linux-nvdimm/alpine.LRH.2.02.2009141131220.30651@file01.intranet.prod.int.rdu2.redhat.com/
[3] https://lore.kernel.org/linux-nvdimm/CA+RJvhxBHriCuJhm-D8NvJRe3h2MLM+ZMFgjeJjrRPerMRLvdg@mail.gmail.com/
[4] https://lore.kernel.org/linux-nvdimm/20200903160608.GU878166@iweiny-DESK2.sc.intel.com/

Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Coly Li <colyli@suse.de>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Pittman <jpittman@redhat.com>
---
Changelog:
v3:
    1. Add Reviewed-by from Jan
    2. Add Reported-by
    3. Replace lists.01.org with lore.kernel
v2:
    Remove the checking for the returned value '-EOPNOTSUPP' of
    dax_direct_access(). Jan has prepared a patch to address the
    issue in dm.
---
 drivers/dax/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e5767c83ea23..11d0541e6f8f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -85,6 +85,12 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
+	if (!dax_dev) {
+		pr_debug("%s: error: dax unsupported by block device\n",
+				bdevname(bdev, buf));
+		return false;
+	}
+
 	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
 	if (err) {
 		pr_info("%s: error: unaligned partition for dax\n",
@@ -100,12 +106,6 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
-		pr_debug("%s: error: dax unsupported by block device\n",
-				bdevname(bdev, buf));
-		return false;
-	}
-
 	id = dax_read_lock();
 	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
 	len2 = dax_direct_access(dax_dev, pgoff_end, 1, &end_kaddr, &end_pfn);
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
