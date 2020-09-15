Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E5C26A049
	for <lists+linux-nvdimm@lfdr.de>; Tue, 15 Sep 2020 09:58:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B54DF13B555AD;
	Tue, 15 Sep 2020 00:58:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com; envelope-from=adrianhuang0701@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CCCF8139F1654
	for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 00:58:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id o68so1486442pfg.2
        for <linux-nvdimm@lists.01.org>; Tue, 15 Sep 2020 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iwB0ggowT8cczHqL1ugYrdGX597SyXNgGzaHvB3ziPE=;
        b=rF62UQUXKgRvQobLYFre0WN8lTptjd810pNITPo8KBCVQwkqQhpymcz1/8+jiS7I9G
         l8UAH6DDinmByhEzMZbCZP41JIdFabc4+EOFfO1FkMJr7HkUm/FRakQgccVHJlvqT2Nq
         9WSvxSJA2HYxXqiJDQMZA1a82XMWXZSIhKzMvC0EWAi/HchC20aDl8SrwiBsHQ2oZpJ9
         ekHs4S1YAldFqY2cSZe4NzS8vngljwnyq5cD6enUc2ZIaHgro3bJS2jGBM6WzUI77iMz
         d9eRu+VKtCkgrauhBuWGhlHYwmcDRjLb4ecNskB7HGGE+i7DwrGwgeg0QCvDmRqYZeUf
         +gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iwB0ggowT8cczHqL1ugYrdGX597SyXNgGzaHvB3ziPE=;
        b=sKW9MlzzBQP4Pr+KTXok4RFmYjRa//Aj4ZfQXiuO2cIzpcVKEoEgtgk4P9BEVULR4h
         LJ/RXJVOjSAvTNtjLpRF/ntQQWTXuhNczKsdVQLPyjsTnP3rSPeuAtqpPFrq5rYpBgAP
         b+WIBs0T3GwyChA8Uct1f/vb9Iqxgc6C4QKUOuHU2tyC8XbeJh5UJpmDpQxv8OVZtImr
         UoypgKB2NtTLOrPKAmR3+68sjxmZKsEBqdJxLC+KNdlmtOLkZduJZnxy1LTk6tlSIDnV
         bG5rv9NClo9lykpqvyOBCcxlvLWss23B0NLCDf9dZQRcMAk6v8mB8foVe6KY59+xPme5
         20bg==
X-Gm-Message-State: AOAM530thYjzWc+Cdx66hyOiyHRFQ2V/zZwGSV0jJiY/tysW9u5OFyf1
	Ke3emr7H7NLfZ6T+EqQslFMSRnZtAGPTN8NR
X-Google-Smtp-Source: ABdhPJyCvswryKFBsp6zDdWz/6I0hBFF15bixQb+jHt4JOwcgSuJsspNTD+A/E46LEnmd2DZoVXdJA==
X-Received: by 2002:a62:1d51:0:b029:13e:d13d:a07f with SMTP id d78-20020a621d510000b029013ed13da07fmr16782219pfd.22.1600156712048;
        Tue, 15 Sep 2020 00:58:32 -0700 (PDT)
Received: from AHUANG12-1LT7M0.lenovo.com (220-143-144-42.dynamic-ip.hinet.net. [220.143.144.42])
        by smtp.googlemail.com with ESMTPSA id t15sm4990877pjq.3.2020.09.15.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:58:31 -0700 (PDT)
From: Adrian Huang <adrianhuang0701@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: [PATCH 1/1] dax: Fix stack overflow when mounting fsdax pmem device
Date: Tue, 15 Sep 2020 15:57:29 +0800
Message-Id: <20200915075729.12518-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.17.1
Message-ID-Hash: 2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2
X-Message-ID-Hash: 2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2
X-MailFrom: adrianhuang0701@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Adrian Huang <adrianhuang0701@gmail.com>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2JDBSE2WK75LSGCFEOY3RXRN3CNLBPB2/>
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

To fix the issue triggered by lvm2-testsuite (the issue that the
above-mentioned commit wants to fix), this patch does not print the
"error: dax access failed" message if the physical disk does not
support DAX (dax_dev is NULL). The detail info is described as follows:

  1. The dax_dev of the dm devices (dm-0, dm-1..) is always allocated
     in alloc_dev() [drivers/md/dm.c].
  2. When calling __generic_fsdax_supported() with dm-0 device, the
     call path is shown as follows (the physical disks of dm-0 do
     not support DAX):
        dax_direct_access (valid dax_dev with dm-0)
          dax_dev->ops->direct_access
            dm_dax_direct_access
              ti->type->direct_access
                linear_dax_direct_access (assume the target is linear)
                  dax_direct_access (dax_dev is NULLL with ram0, or sdaX)
  3. The call 'dax_direct_access()' in __generic_fsdax_supported() gets
     the returned value '-EOPNOTSUPP'.
  4. However, the message 'dm-3: error: dax access failed (-5)' is still
     printed for the dm target 'error' since io_err_dax_direct_access()
     always returns the status '-EIO'. Cc' device mapper maintainers to
     see if they have concerns.

[1] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/BULZHRILK7N2WS2JVISNF2QZNRQK6JU4/
[2] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/thread/OOZGFY3RNQGTGJJCH52YXCSYIDXMOPXO/
[3] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SMQW2LY3QHPXOAW76RKNSCGG3QJFO7HT/
[4] https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7E2X6UGX5RQ2ISGYNAF66VLY5BKBFI4M/

Fixes: 6180bb446ab6 ("dax: fix detection of dax support for non-persistent memory block devices")
Cc: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Pittman <jpittman@redhat.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 drivers/dax/super.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e5767c83ea23..fb151417ec10 100644
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
@@ -100,19 +106,22 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
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
 
 	if (len < 1 || len2 < 1) {
-		pr_info("%s: error: dax access failed (%ld)\n",
+		/*
+		 * Only print the real error message: do not need to print
+		 * the message for the underlying raw disk (physical disk)
+		 * that does not support DAX (dax_dev = NULL). This case
+		 * is observed when physical disks are configured by
+		 * lvm2 (device mapper).
+		 */
+		if (len != -EOPNOTSUPP && len2 != -EOPNOTSUPP) {
+			pr_info("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len < 1 ? len : len2);
+		}
 		dax_read_unlock(id);
 		return false;
 	}
-- 
2.17.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
