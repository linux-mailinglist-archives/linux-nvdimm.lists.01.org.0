Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D286D35A3BE
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:44:36 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 76CE7100EB349;
	Fri,  9 Apr 2021 09:44:35 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 78C9A100EB349
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:44:32 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 13398B124;
	Fri,  9 Apr 2021 16:44:31 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 06/16] bcache: get allocated pages from specific owner
Date: Sat, 10 Apr 2021 00:43:33 +0800
Message-Id: <20210409164343.56828-7-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: 2CITTNZBZXMEEPW4CNQRFU4KQNWSY4HW
X-Message-ID-Hash: 2CITTNZBZXMEEPW4CNQRFU4KQNWSY4HW
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2CITTNZBZXMEEPW4CNQRFU4KQNWSY4HW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Jianpeng Ma <jianpeng.ma@intel.com>

This patch implements bch_get_allocated_pages() of the buddy to be used to
get allocated pages from specific owner.

Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
Co-authored-by: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/nvm-pages.c | 6 ++++++
 drivers/md/bcache/nvm-pages.h | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/nvm-pages.c b/drivers/md/bcache/nvm-pages.c
index e576b4cb4850..2ba02091bccf 100644
--- a/drivers/md/bcache/nvm-pages.c
+++ b/drivers/md/bcache/nvm-pages.c
@@ -374,6 +374,12 @@ void *bch_nvm_alloc_pages(int order, const char *owner_uuid)
 }
 EXPORT_SYMBOL_GPL(bch_nvm_alloc_pages);
 
+struct bch_nvm_pages_owner_head *bch_get_allocated_pages(const char *owner_uuid)
+{
+	return find_owner_head(owner_uuid, false);
+}
+EXPORT_SYMBOL_GPL(bch_get_allocated_pages);
+
 static int init_owner_info(struct bch_nvm_namespace *ns)
 {
 	struct bch_owner_list_head *owner_list_head = ns->sb->owner_list_head;
diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
index 4ea831894583..87b1efc301c8 100644
--- a/drivers/md/bcache/nvm-pages.h
+++ b/drivers/md/bcache/nvm-pages.h
@@ -62,7 +62,7 @@ int bch_nvm_init(void);
 void bch_nvm_exit(void);
 void *bch_nvm_alloc_pages(int order, const char *owner_uuid);
 void bch_nvm_free_pages(void *addr, int order, const char *owner_uuid);
-
+struct bch_nvm_pages_owner_head *bch_get_allocated_pages(const char *owner_uuid);
 #else
 
 static inline struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
@@ -81,6 +81,11 @@ static inline void *bch_nvm_alloc_pages(int order, const char *owner_uuid)
 
 static inline void bch_nvm_free_pages(void *addr, int order, const char *owner_uuid) { }
 
+static inline struct bch_nvm_pages_owner_head *bch_get_allocated_pages(const char *owner_uuid)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_BCACHE_NVM_PAGES */
 
 #endif /* _BCACHE_NVM_PAGES_H */
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
