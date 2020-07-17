Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B6223150
	for <lists+linux-nvdimm@lfdr.de>; Fri, 17 Jul 2020 04:52:37 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 75E0911DD49DA;
	Thu, 16 Jul 2020 19:52:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id E97A111DC8C80
	for <linux-nvdimm@lists.01.org>; Thu, 16 Jul 2020 19:52:32 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 0B461B17F;
	Fri, 17 Jul 2020 02:52:35 +0000 (UTC)
From: Coly Li <colyli@suse.de>
Subject: [RESEND] [PATCH v2] dax: print error message by pr_info() in
 __generic_fsdax_supported()
To: dan.j.williams@intel.com, linux-nvdimm@lists.01.org
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <9e4e6445-9d57-3b7f-6a2a-ddad750ef11c@suse.de>
Date: Fri, 17 Jul 2020 10:52:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-US
Message-ID-Hash: Z2DRQQ673ZZ3EMLFKKRI5N42TWLB34UH
X-Message-ID-Hash: Z2DRQQ673ZZ3EMLFKKRI5N42TWLB34UH
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Coly Li <colyli@suse.de>, Michal Suchanek <msuchanek@suse.com>, Jan Kara <jack@suse.com>, Anthony Iliopoulos <ailiopoulos@suse.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/Z2DRQQ673ZZ3EMLFKKRI5N42TWLB34UH/>
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

The above information is quite confusing. Because definiately the pmem0
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
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Anthony Iliopoulos <ailiopoulos@suse.com>
---
Changelog:
v2: Add reviewed-by from Jan Kara
v1: initial version.

 drivers/dax/super.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 8e32345be0f7..de0d02ec0347 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -80,14 +80,14 @@ bool __generic_fsdax_supported(struct dax_device
*dax_dev,
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
@@ -106,7 +106,7 @@ bool __generic_fsdax_supported(struct dax_device
*dax_dev,
 	dax_read_unlock(id);
  	if (len < 1 || len2 < 1) {
-		pr_debug("%s: error: dax access failed (%ld)\n",
+		pr_info("%s: error: dax access failed (%ld)\n",
 				bdevname(bdev, buf), len < 1 ? len : len2);
 		return false;
 	}
@@ -139,7 +139,7 @@ bool __generic_fsdax_supported(struct dax_device
*dax_dev,
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
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
