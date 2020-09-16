Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B341E26C356
	for <lists+linux-nvdimm@lfdr.de>; Wed, 16 Sep 2020 15:41:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0B36514518B71;
	Wed, 16 Sep 2020 06:41:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8275A14518B6F
	for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 06:41:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z18so1463844pfg.0
        for <linux-nvdimm@lists.01.org>; Wed, 16 Sep 2020 06:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F8CJqtm6/jJl5uVqduz0DCTddJOXqikVZORl1X672is=;
        b=ANYKLixQsM7C602K1WenDn9oBO78uHzH3rR/+nXqzAkWzaZb6sRrIsU4HjZ8WKo1eA
         lzIbYGnHfZ+a5ptNVp/9CS1ImKa8Z0RZJq15LAqu2Z7wzl0VLkX56KRIPhS75xEfP66g
         tA0XzBGAdkdc1lxLSuMrGPbLngxjVLArPPsx1klzdm1NX3mD5IwD37iaMYyVRWW2g/hJ
         q8x91Gy1DdGBhkx6PT0rSFqXo99fZA8P1q+Ct1hivTm3TRD2l2TiH6UizzYi5OsTTPeA
         aq0AZwew/y7tOlnyQeva5Y8P7XuyEPlYGI+lifnFCSrRk8bcD1ZkcHVQjUmpjXN/GvNO
         fLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F8CJqtm6/jJl5uVqduz0DCTddJOXqikVZORl1X672is=;
        b=QcuQwwb7UmI03hsS4uG2tjBc4LVpgBECiConNZywMTn3ZVstmtTghyX9s2+GfuQ0Ky
         5d2p3V3WJSHQj8OauBUkVspI1hLvAK0DBM8SXrdjk2yaym0uIY2r+5risRlgXzfjBIeV
         2foeIMxsVLcRZ0u/S7bClilMjqLtizAX57vx38/R2ML32FPvTgXoW3DlFkUoBz3bONvy
         Al/jZOvdxZDlUAzRFWNqs29MzBTGq+oMqiwXVgjK2dhrtJhTXQdfzbSpShDHVnfVV5cG
         b4Q6VehW5F+g2znsd4tjiH+K78PIAm0ocYdZC4n9gbVlwdb0rCOjglZXeQWhB+OwHzP5
         Q+ow==
X-Gm-Message-State: AOAM530iFyYxab82OWGyYE+BXdM9I87ndsm94+IGjdHQIfsdkB2HWIB+
	uc4CHeNoi3iXqBWR2DgXS8/T1BOdWdaQHy3w
X-Google-Smtp-Source: ABdhPJwz+vWUZa9HC0VyYk1WIpKAU6wxds982lrCeyBcNk5TaIGAxi5G4d+akZKtOz4UYqCVI0n8Ew==
X-Received: by 2002:a65:68c8:: with SMTP id k8mr2553222pgt.0.1600263691728;
        Wed, 16 Sep 2020 06:41:31 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (220-143-144-42.dynamic-ip.hinet.net. [220.143.144.42])
        by smtp.googlemail.com with ESMTPSA id h9sm16189067pfc.28.2020.09.16.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:41:31 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH v2 1/1] dax: Fix stack overflow when mounting fsdax pmem device
Date: Wed, 16 Sep 2020 21:39:23 +0800
Message-Id: <20200916133923.31-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: WSGFU74OXLCPCHR7H4GTVKWLSTZR2TOA
X-Message-ID-Hash: WSGFU74OXLCPCHR7H4GTVKWLSTZR2TOA
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Jan Kara <jack@suse.cz>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WSGFU74OXLCPCHR7H4GTVKWLSTZR2TOA/>
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

[1] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/
[2] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/
[3] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/
[4] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/

Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
Cc: Coly Li <colyli@suse.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Pittman <jpittman@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
v1->v2
* Remove the checking for the returned value '-EOPNOTSUPP' of
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
