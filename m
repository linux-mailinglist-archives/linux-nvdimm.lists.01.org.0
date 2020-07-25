Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C311622D8AA
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jul 2020 18:25:07 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 872D912532439;
	Sat, 25 Jul 2020 09:25:00 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6274312532438
	for <linux-nvdimm@lists.01.org>; Sat, 25 Jul 2020 09:24:58 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 86B24AC2D;
	Sat, 25 Jul 2020 16:25:05 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: dan.j.williams@intel.com,
	linux-nvdimm@lists.01.org
Subject: [PATCH v3] dax: print error message by pr_info() in __generic_fsdax_supported()
Date: Sun, 26 Jul 2020 00:24:50 +0800
Message-Id: <20200725162450.95999-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Message-ID-Hash: HDNVCMBSRNZJIZYJW3YMJFJUP6GC76WN
X-Message-ID-Hash: HDNVCMBSRNZJIZYJW3YMJFJUP6GC76WN
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: msuchanek@suse.com, ailiopoulos@suse.com, Coly Li <colyli@suse.de>, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HDNVCMBSRNZJIZYJW3YMJFJUP6GC76WN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

In struct dax_operations, the callback routine dax_supported() returns
a bool type result. For false return value, the caller has no idea
whether the device does not support dax at all, or it is just some mis-
configuration issue.

An example is formatting an Ext4 file system on pmem device on top of
a NVDIMM namespace by,
 # mkfs.ext4 /dev/pmem0
If the fs block size does not match kernel space memory page size (which
is possible on non-x86 platform), mount this Ext4 file system will fail,
  # mount -o dax /dev/pmem0 /mnt
  mount: /mnt: wrong fs type, bad option, bad superblock on /dev/pmem0,
  missing codepage or helper program, or other error.
And from the dmesg output there is only the following information,
  [  307.853148] EXT4-fs (pmem0): DAX unsupported by block device.

The above information is quite confusing. Because definitely the pmem0
device supports dax operation, and the super block is consistent as how
it was created by mkfs.ext4.

Indeed the failure is from __generic_fsdax_supported() by the following
code piece,
        if (blocksize != PAGE_SIZE) {
               pr_debug("%s: error: unsupported blocksize for dax\n",
                                bdevname(bdev, buf));
                return false;
        }
It is because the Ext4 block size is 4KB and kernel page size is 8KB or
16KB.

It is not simple to make dax_supported() from struct dax_operations
or __generic_fsdax_supported() to return exact failure type right now.
So the simplest fix is to use pr_info() to print all the error messages
inside __generic_fsdax_supported(). Then users may find informative clue
from the kernel message at least.

Message printed by pr_debug() is very easy to be ignored by users. This
patch prints error message by pr_info() in __generic_fsdax_supported(),
when then mount fails, following lines can be found from dmesg output,
 [ 2705.500885] pmem0: error: unsupported blocksize for dax
 [ 2705.500888] EXT4-fs (pmem0): DAX unsupported by block device.
Now the users may have idea the mount failure is from pmem driver for
unsupported block size.

Reported-by: Michal Suchanek <msuchanek@suse.com>
Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Jan Kara <jack@suse.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anthony Iliopoulos <ailiopoulos@suse.com>
---
Changelog:
v3: Fix a typo in commit log, add reviewed-by from Ira Weiny and
    Pankaj Gupta.
v2: Add reviewed-by from Jan Kara
v1: initial version.

 drivers/dax/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..de0d02ec0347 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -80,14 +80,14 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	int err, id;
 
 	if (blocksize != PAGE_SIZE) {
-		pr_debug("%s: error: unsupported blocksize for dax\n",
+		pr_info("%s: error: unsupported blocksize for dax\n",
 				bdevname(bdev, buf));
 		return false;
 	}
 
 	err = bdev_dax_pgoff(bdev, start, PAGE_SIZE, &pgoff);
 	if (err) {
-		pr_debug("%s: error: unaligned partition for dax\n",
+		pr_info("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
 		return false;
 	}
@@ -95,7 +95,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	last_page = PFN_DOWN((start + sectors - 1) * 512) * PAGE_SIZE / 512;
 	err = bdev_dax_pgoff(bdev, last_page, PAGE_SIZE, &pgoff_end);
 	if (err) {
-		pr_debug("%s: error: unaligned partition for dax\n",
+		pr_info("%s: error: unaligned partition for dax\n",
 				bdevname(bdev, buf));
 		return false;
 	}
@@ -106,7 +106,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	dax_read_unlock(id);
 
 	if (len < 1 || len2 < 1) {
-		pr_debug("%s: error: dax access failed (%ld)\n",
+		pr_info("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len < 1 ? len : len2);
 		return false;
 	}
@@ -139,7 +139,7 @@ bool __generic_fsdax_supported(struct dax_device *dax_dev,
 	}
 
 	if (!dax_enabled) {
-		pr_debug("%s: error: dax support not enabled\n",
+		pr_info("%s: error: dax support not enabled\n",
 				bdevname(bdev, buf));
 		return false;
 	}
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
