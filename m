Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F0271F51
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 11:53:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DE10F143FE21F;
	Mon, 21 Sep 2020 02:53:48 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CB0F9143FE21E;
	Mon, 21 Sep 2020 02:53:44 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 53D91AD83;
	Mon, 21 Sep 2020 09:54:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 076491E12E1; Mon, 21 Sep 2020 11:53:43 +0200 (CEST)
Date: Mon, 21 Sep 2020 11:53:43 +0200
From: Jan Kara <jack@suse.cz>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-nvdimm:libnvdimm-fixes 2/3] drivers/dax/super.c:325:6:
 error: redefinition of 'dax_supported'
Message-ID: <20200921095342.GD5862@quack2.suse.cz>
References: <202009210706.QnE7d195%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <202009210706.QnE7d195%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: FEN3OLII7AOWHQ275WC3L2BIBCXW2D2Z
X-Message-ID-Hash: FEN3OLII7AOWHQ275WC3L2BIBCXW2D2Z
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Jan Kara <jack@suse.cz>, kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/FEN3OLII7AOWHQ275WC3L2BIBCXW2D2Z/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 21-09-20 07:12:11, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git libnvdimm-fixes
> head:   d4c5da5049ac27c6ef8f6f98548c3a1ade352d25
> commit: e2ec5128254518cae320d5dc631b71b94160f663 [2/3] dm: Call proper helper to determine dax support
> config: x86_64-randconfig-a011-20200920 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f4e554180962aa6bc93678898b6933ea712bde50)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout e2ec5128254518cae320d5dc631b71b94160f663
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/dax/super.c:325:6: error: redefinition of 'dax_supported'
>    bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
>         ^
>    include/linux/dax.h:162:20: note: previous definition is here
>    static inline bool dax_supported(struct dax_device *dax_dev,
>                       ^
>    drivers/dax/super.c:451:6: warning: no previous prototype for function 'run_dax' [-Wmissing-prototypes]
>    void run_dax(struct dax_device *dax_dev)
>         ^
>    drivers/dax/super.c:451:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    void run_dax(struct dax_device *dax_dev)
>    ^
>    static 
>    1 warning and 1 error generated.

Attached patch should fix the build error.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--XF85m9dhOBO43t/C
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-dax-Fix-compilation-for-CONFIG_DAX-CONFIG_FS_DAX.patch"

From c48c9d1ee41ca17561dfd7ec5247b5afc527d40e Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 21 Sep 2020 11:33:23 +0200
Subject: [PATCH] dax: Fix compilation for CONFIG_DAX && !CONFIG_FS_DAX

dax_supported() is defined whenever CONFIG_DAX is enabled. So dummy
implementation should be defined only in !CONFIG_DAX case, not in
!CONFIG_FS_DAX case.

Fixes: e2ec51282545 ("dm: Call proper helper to determine dax support")
Cc: <stable@vger.kernel.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/dax.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 497031392e0a..43b39ab9de1a 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -58,6 +58,8 @@ static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 	__set_dax_synchronous(dax_dev);
 }
+bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
+		int blocksize, sector_t start, sector_t len);
 /*
  * Check if given mapping is supported by the file / underlying device.
  */
@@ -104,6 +106,12 @@ static inline bool dax_synchronous(struct dax_device *dax_dev)
 static inline void set_dax_synchronous(struct dax_device *dax_dev)
 {
 }
+static inline bool dax_supported(struct dax_device *dax_dev,
+		struct block_device *bdev, int blocksize, sector_t start,
+		sector_t len)
+{
+	return false;
+}
 static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 				struct dax_device *dax_dev)
 {
@@ -130,8 +138,6 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return __generic_fsdax_supported(dax_dev, bdev, blocksize, start,
 			sectors);
 }
-bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
-		int blocksize, sector_t start, sector_t len);
 
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
@@ -159,13 +165,6 @@ static inline bool generic_fsdax_supported(struct dax_device *dax_dev,
 	return false;
 }
 
-static inline bool dax_supported(struct dax_device *dax_dev,
-		struct block_device *bdev, int blocksize, sector_t start,
-		sector_t len)
-{
-	return false;
-}
-
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
-- 
2.16.4


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

--XF85m9dhOBO43t/C--
