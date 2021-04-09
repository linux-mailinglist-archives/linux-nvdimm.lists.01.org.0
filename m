Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE2B35A3C2
	for <lists+linux-nvdimm@lfdr.de>; Fri,  9 Apr 2021 18:44:43 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9EBF3100EAB0B;
	Fri,  9 Apr 2021 09:44:41 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 14214100EAB09
	for <linux-nvdimm@lists.01.org>; Fri,  9 Apr 2021 09:44:39 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id A4053AE6D;
	Fri,  9 Apr 2021 16:44:37 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Subject: [PATCH v7 07/16] bcache: nvm-pages fixes for bcache integration testing
Date: Sat, 10 Apr 2021 00:43:34 +0800
Message-Id: <20210409164343.56828-8-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210409164343.56828-1-colyli@suse.de>
References: <20210409164343.56828-1-colyli@suse.de>
MIME-Version: 1.0
Message-ID-Hash: ZW4UP42SXLWTJOKRZTGESPFUK7VCYFXG
X-Message-ID-Hash: ZW4UP42SXLWTJOKRZTGESPFUK7VCYFXG
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-nvdimm@lists.01.org, axboe@kernel.dk, jianpeng.ma@intel.com, qiaowei.ren@intel.com, hare@suse.com, jack@suse.cz, Coly Li <colyli@suse.de>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZW4UP42SXLWTJOKRZTGESPFUK7VCYFXG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

There are two minor fixes in nvm-pages code, which can be added in next
nvm-pages series. Then I can drop this patch.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Jianpeng Ma <jianpeng.ma@intel.com>
Cc: Qiaowei Ren <qiaowei.ren@intel.com>
---
 drivers/md/bcache/nvm-pages.c | 29 +++++++++++++++++++++--------
 drivers/md/bcache/nvm-pages.h |  1 +
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/nvm-pages.c b/drivers/md/bcache/nvm-pages.c
index 2ba02091bccf..c3ab396a45fa 100644
--- a/drivers/md/bcache/nvm-pages.c
+++ b/drivers/md/bcache/nvm-pages.c
@@ -73,24 +73,32 @@ static inline void remove_owner_space(struct bch_nvm_namespace *ns,
 static struct bch_nvm_pages_owner_head *find_owner_head(const char *owner_uuid, bool create)
 {
 	struct bch_owner_list_head *owner_list_head = only_set->owner_list_head;
+	struct bch_nvm_pages_owner_head *owner_head = NULL;
 	int i;
 
+	if (owner_list_head == NULL)
+		goto out;
+
 	for (i = 0; i < only_set->owner_list_used; i++) {
-		if (!memcmp(owner_uuid, owner_list_head->heads[i].uuid, 16))
-			return &(owner_list_head->heads[i]);
+		if (!memcmp(owner_uuid, owner_list_head->heads[i].uuid, 16)) {
+			owner_head = &(owner_list_head->heads[i]);
+			break;
+		}
 	}
 
-	if (create) {
+	if (!owner_head && create) {
 		int used = only_set->owner_list_used;
 
-		BUG_ON(only_set->owner_list_size == used);
-		memcpy(owner_list_head->heads[used].uuid, owner_uuid, 16);
+		BUG_ON((used > 0) && (only_set->owner_list_size == used));
+		memcpy_flushcache(owner_list_head->heads[used].uuid, owner_uuid, 16);
 		only_set->owner_list_used++;
 
 		owner_list_head->used++;
-		return &(owner_list_head->heads[used]);
-	} else
-		return NULL;
+		owner_head = &(owner_list_head->heads[used]);
+	}
+
+out:
+	return owner_head;
 }
 
 static struct bch_nvm_pgalloc_recs *find_empty_pgalloc_recs(void)
@@ -324,6 +332,10 @@ void *bch_nvm_alloc_pages(int order, const char *owner_uuid)
 
 	mutex_lock(&only_set->lock);
 	owner_head = find_owner_head(owner_uuid, true);
+	if (!owner_head) {
+		pr_err("can't find bch_nvm_pgalloc_recs by(uuid=%s)\n", owner_uuid);
+		goto unlock;
+	}
 
 	for (j = 0; j < only_set->total_namespaces_nr; j++) {
 		struct bch_nvm_namespace *ns = only_set->nss[j];
@@ -369,6 +381,7 @@ void *bch_nvm_alloc_pages(int order, const char *owner_uuid)
 		}
 	}
 
+unlock:
 	mutex_unlock(&only_set->lock);
 	return kaddr;
 }
diff --git a/drivers/md/bcache/nvm-pages.h b/drivers/md/bcache/nvm-pages.h
index 87b1efc301c8..b8a5cd0890d3 100644
--- a/drivers/md/bcache/nvm-pages.h
+++ b/drivers/md/bcache/nvm-pages.h
@@ -66,6 +66,7 @@ struct bch_nvm_pages_owner_head *bch_get_allocated_pages(const char *owner_uuid)
 #else
 
 static inline struct bch_nvm_namespace *bch_register_namespace(const char *dev_path)
+{
 	return NULL;
 }
 static inline int bch_nvm_init(void)
-- 
2.26.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
