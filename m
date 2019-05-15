Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A011FA71
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:27:38 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9219E212657B5;
	Wed, 15 May 2019 12:27:35 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 828742126578B
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:32 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8022EC0703C6;
 Wed, 15 May 2019 19:27:32 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6AF419C71;
 Wed, 15 May 2019 19:27:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 5C4D322063D; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 01/30] fuse: delete dentry if timeout is zero
Date: Wed, 15 May 2019 15:26:46 -0400
Message-Id: <20190515192715.18000-2-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 15 May 2019 19:27:32 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: swhiteho@redhat.com, dgilbert@redhat.com, stefanha@redhat.com,
 miklos@szeredi.hu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Miklos Szeredi <mszeredi@redhat.com>

Don't hold onto dentry in lru list if need to re-lookup it anyway at next
access.

More advanced version of this patch would periodically flush out dentries
from the lru which have gone stale.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index dd0f64f7bc06..fd8636e67ae9 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -29,12 +29,26 @@ union fuse_dentry {
 	struct rcu_head rcu;
 };
 
-static inline void fuse_dentry_settime(struct dentry *entry, u64 time)
+static void fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
-	((union fuse_dentry *) entry->d_fsdata)->time = time;
+	/*
+	 * Mess with DCACHE_OP_DELETE because dput() will be faster without it.
+	 *  Don't care about races, either way it's just an optimization
+	 */
+	if ((time && (dentry->d_flags & DCACHE_OP_DELETE)) ||
+	    (!time && !(dentry->d_flags & DCACHE_OP_DELETE))) {
+		spin_lock(&dentry->d_lock);
+		if (time)
+			dentry->d_flags &= ~DCACHE_OP_DELETE;
+		else
+			dentry->d_flags |= DCACHE_OP_DELETE;
+		spin_unlock(&dentry->d_lock);
+	}
+
+	((union fuse_dentry *) dentry->d_fsdata)->time = time;
 }
 
-static inline u64 fuse_dentry_time(struct dentry *entry)
+static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
@@ -255,8 +269,14 @@ static void fuse_dentry_release(struct dentry *dentry)
 	kfree_rcu(fd, rcu);
 }
 
+static int fuse_dentry_delete(const struct dentry *dentry)
+{
+	return time_before64(fuse_dentry_time(dentry), get_jiffies_64());
+}
+
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
+	.d_delete	= fuse_dentry_delete,
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 };
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
