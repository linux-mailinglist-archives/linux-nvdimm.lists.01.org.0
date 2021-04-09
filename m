Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C542735A3DA
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:45:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69409100EAB18;
	Fri,  9 Apr 2021 09:45:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C8BE100EAB19
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:45:26 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 387EAB10B;
	Fri,  9 Apr 2021 16:45:25 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 13/16] bcache: add sysfs interface register_nvdimm_meta to register NVDIMM meta device
Date: Sat, 10 Apr 2021 00:43:40 +0800
Message-Id: <20210409164343.56828-14-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: R4UWXUSS67AKDVLPAM3OZFFCQXBBNID3
X-Message-ID-Hash: R4UWXUSS67AKDVLPAM3OZFFCQXBBNID3
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/R4UWXUSS67AKDVLPAM3OZFFCQXBBNID3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds a sysfs interface register_nvdimm_meta to register
NVDIMM meta device. The sysfs interface file only shows up when
CONFIG_BCACHE_NVM_PAGES=y. Then a NVDIMM name space formatted by
bcache-tools can be registered into bcache by e.g.,
  echo /dev/pmem0 > /sys/fs/bcache/register_nvdimm_meta

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/super.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9640bfb85571..d95a9a3c2041 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2436,10 +2436,18 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 static ssize_t bch_pending_bdevs_cleanup(struct kobject *k,
 					 struct kobj_attribute *attr,
 					 const char *buffer, size_t size);
+#ifdef CONFIG_BCACHE_NVM_PAGES
+static ssize_t register_nvdimm_meta(struct kobject *k,
+				    struct kobj_attribute *attr,
+				    const char *buffer, size_t size);
+#endif
 
 kobj_attribute_write(register,		register_bcache);
 kobj_attribute_write(register_quiet,	register_bcache);
 kobj_attribute_write(pendings_cleanup,	bch_pending_bdevs_cleanup);
+#ifdef CONFIG_BCACHE_NVM_PAGES
+kobj_attribute_write(register_nvdimm_meta, register_nvdimm_meta);
+#endif
 
 static bool bch_is_open_backing(dev_t dev)
 {
@@ -2553,6 +2561,24 @@ static void register_device_async(struct async_reg_args *args)
 	queue_delayed_work(system_wq, &args->reg_work, 10);
 }
 
+#ifdef CONFIG_BCACHE_NVM_PAGES
+static ssize_t register_nvdimm_meta(struct kobject *k, struct kobj_attribute *attr,
+				    const char *buffer, size_t size)
+{
+	ssize_t ret = size;
+
+	struct bch_nvm_namespace *ns = bch_register_namespace(buffer);
+
+	if (IS_ERR(ns)) {
+		pr_err("register nvdimm namespace %s for meta device failed.\n",
+			buffer);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+#endif
+
 static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			       const char *buffer, size_t size)
 {
@@ -2888,6 +2914,9 @@ static int __init bcache_init(void)
 	static const struct attribute *files[] = {
 		&ksysfs_register.attr,
 		&ksysfs_register_quiet.attr,
+#ifdef CONFIG_BCACHE_NVM_PAGES
+		&ksysfs_register_nvdimm_meta.attr,
+#endif
 		&ksysfs_pendings_cleanup.attr,
 		NULL
 	};
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
