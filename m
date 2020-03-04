Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2771795EE
	for <lists+linux-nvdimm@lfdr.de>; Wed,  4 Mar 2020 17:59:41 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A14D110FC3785;
	Wed,  4 Mar 2020 09:00:16 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.61; helo=us-smtp-delivery-1.mimecast.com; envelope-from=vgoyal@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com [205.139.110.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 28D1010FC36C7
	for <linux-nvdimm@lists.01.org>; Wed,  4 Mar 2020 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1583341158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iqwR/Wpp7+YcapyNYw3ecIiaOOqeTYQJudy3bqc6Q6c=;
	b=JhZ4cRV5VjhuOTNx4ZEd+byv6BuntFIIjNWKiQ5tm0S+tJsK5fLnYJkQUBDgb/ixxEcTcG
	/wVq9r+f8J8FZ/mQizZNGxKlYtNLIWbekjGJIXW2rHENyvW86vmqixsPwVR9eo5H/zcPG3
	4bpOwK8Rt1yzRLV48uMBEOogiotEv1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-LQKguxjYNzC_V2WCaTmSwg-1; Wed, 04 Mar 2020 11:59:14 -0500
X-MC-Unique: LQKguxjYNzC_V2WCaTmSwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A35A107ACCC;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 299E873897;
	Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
	id 85B52225817; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	virtio-fs@redhat.com,
	miklos@szeredi.hu
Subject: [PATCH 17/20] fuse,virtiofs: Maintain a list of busy elements
Date: Wed,  4 Mar 2020 11:58:42 -0500
Message-Id: <20200304165845.3081-18-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Message-ID-Hash: LQSK3PPLYMDVX6QUQXMT7U5S7LM3UTCV
X-Message-ID-Hash: LQSK3PPLYMDVX6QUQXMT7U5S7LM3UTCV
X-MailFrom: vgoyal@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: stefanha@redhat.com, dgilbert@redhat.com, mst@redhat.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LQSK3PPLYMDVX6QUQXMT7U5S7LM3UTCV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

This list will be used selecting fuse_dax_mapping to free when number of
free mappings drops below a threshold.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 22 ++++++++++++++++++++++
 fs/fuse/fuse_i.h |  8 ++++++++
 fs/fuse/inode.c  |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 619aff6b5f44..afabeb1acd50 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -215,6 +215,23 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	return dmap;
 }
 
+/* This assumes fc->lock is held */
+static void __dmap_remove_busy_list(struct fuse_conn *fc,
+				    struct fuse_dax_mapping *dmap)
+{
+	list_del_init(&dmap->busy_list);
+	WARN_ON(fc->nr_busy_ranges == 0);
+	fc->nr_busy_ranges--;
+}
+
+static void dmap_remove_busy_list(struct fuse_conn *fc,
+				  struct fuse_dax_mapping *dmap)
+{
+	spin_lock(&fc->lock);
+	__dmap_remove_busy_list(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
 /* This assumes fc->lock is held */
 static void __dmap_add_to_free_pool(struct fuse_conn *fc,
 				struct fuse_dax_mapping *dmap)
@@ -277,6 +294,10 @@ static int fuse_setup_one_mapping(struct inode *inode, loff_t offset,
 		/* Protected by fi->i_dmap_sem */
 		fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
 		fi->nr_dmaps++;
+		spin_lock(&fc->lock);
+		list_add_tail(&dmap->busy_list, &fc->busy_ranges);
+		fc->nr_busy_ranges++;
+		spin_unlock(&fc->lock);
 	}
 	return 0;
 }
@@ -346,6 +367,7 @@ static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
 	pr_debug("fuse: freeing memory range start=0x%llx end=0x%llx "
 		 "window_offset=0x%llx length=0x%llx\n", dmap->start,
 		 dmap->end, dmap->window_offset, dmap->length);
+	__dmap_remove_busy_list(fc, dmap);
 	dmap->start = dmap->end = 0;
 	__dmap_add_to_free_pool(fc, dmap);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3fea84411401..de213a7e1b0e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -85,6 +85,10 @@ struct fuse_dax_mapping {
 	/** End Position in file */
 	__u64 end;
 	__u64 __subtree_last;
+
+	/* Will connect in fc->busy_ranges to keep track busy memory */
+	struct list_head busy_list;
+
 	/** Position in DAX window */
 	u64 window_offset;
 
@@ -814,6 +818,10 @@ struct fuse_conn {
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
 
+	/* List of memory ranges which are busy */
+	unsigned long nr_busy_ranges;
+	struct list_head busy_ranges;
+
 	/*
 	 * DAX Window Free Ranges
 	 */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index abc881e6acb0..d4770e7fb7eb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -616,6 +616,8 @@ static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
 	/* Free All allocated elements */
 	list_for_each_entry_safe(range, temp, mem_list, list) {
 		list_del(&range->list);
+		if (!list_empty(&range->busy_list))
+			list_del(&range->busy_list);
 		kfree(range);
 	}
 }
@@ -660,6 +662,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 		 */
 		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
 		range->length = FUSE_DAX_MEM_RANGE_SZ;
+		INIT_LIST_HEAD(&range->busy_list);
 		list_add_tail(&range->list, &mem_ranges);
 	}
 
@@ -707,6 +710,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
+	INIT_LIST_HEAD(&fc->busy_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
-- 
2.20.1
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
