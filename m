Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E525C614
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 18:05:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D3BEC139F60EA;
	Thu,  3 Sep 2020 09:05:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 14DE5139F60E7
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 09:05:00 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A43C1B04F;
	Thu,  3 Sep 2020 16:04:59 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-nvdimm@lists.01.org
Subject: [PATCH v3] dax: fix for do not print error message for non-persistent memory block device
Date: Fri,  4 Sep 2020 00:04:48 +0800
Message-Id: <20200903160448.19394-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: THUYE6SDNVVBJDWN2WSGMAEU6SUKQSM2
X-Message-ID-Hash: THUYE6SDNVVBJDWN2WSGMAEU6SUKQSM2
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: dm-devel@redhat.com, Coly Li <colyli@suse.de>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Jan Kara <jack@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/THUYE6SDNVVBJDWN2WSGMAEU6SUKQSM2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

When calling __generic_fsdax_supported(), a dax-unsupported device may
not have dax_dev as NULL, e.g. the dax related code block is not enabled
by Kconfig.

Therefore in __generic_fsdax_supported(), to check whether a device
supports DAX or not, the following order should be performed,
- If dax_dev pointer is NULL, it means the device driver explicitly
  announce it doesn't support DAX. Then it is OK to directly return
  false from __generic_fsdax_supported().
- If dax_dev pointer is NOT NULL, it might be because the driver doesn't
  support DAX and not explicitly initialize related data structure. Then
  bdev_dax_supported() should be called for further check.

IMHO if device driver desn't explicitly set its dax_dev pointer to NULL,
this is not a bug. Calling bdev_dax_supported() makes sure they can be
recognized as dax-unsupported eventually.

This patch does the following change for the above purpose,
    -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
    +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {


Fixes: c2affe920b0e ("dax: do not print error message for non-persistent memory block device")
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-and-Tested-by: Adrian Huang <ahuang12@lenovo.com>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jan Kara <jack@suse.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
---
Changelog:
v3: add more Reviewed-by from Mike Snitzer and Pankaj Gupta.
v2: add Reviewed-and-Tested-by from Adrian Huang.
v1: initial version.

 drivers/dax/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 32642634c1bb..e5767c83ea23 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -100,7 +100,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 		return false;
 	}
 
-	if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
+	if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {
 		pr_debug("%s: error: dax unsupported by block device\n",
 				bdevname(bdev, buf));
 		return false;
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
