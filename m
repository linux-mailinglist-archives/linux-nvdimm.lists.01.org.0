Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD21325AB8
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Feb 2021 01:21:35 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38BD8100EAB78;
	Thu, 25 Feb 2021 16:21:34 -0800 (PST)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=ruansy.fnst@fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id DDD82100EAB7B
	for <linux-nvdimm@lists.01.org>; Thu, 25 Feb 2021 16:21:31 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800";
   d="scan'208";a="104882844"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Feb 2021 08:21:30 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id C518C4CE76F6;
	Fri, 26 Feb 2021 08:21:28 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 26 Feb 2021 08:21:19 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 26 Feb 2021 08:21:18 +0800
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v2 07/10] iomap: Introduce iomap_apply2() for operations on two files
Date: Fri, 26 Feb 2021 08:20:27 +0800
Message-ID: <20210226002030.653855-8-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-yoursite-MailScanner-ID: C518C4CE76F6.A4A06
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 2YZOC6VQP3H37EIHUKBBMEV524RYYWBO
X-Message-ID-Hash: 2YZOC6VQP3H37EIHUKBBMEV524RYYWBO
X-MailFrom: ruansy.fnst@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2YZOC6VQP3H37EIHUKBBMEV524RYYWBO/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Some operations, such as comparing a range of data in two files under
fsdax mode, requires nested iomap_open()/iomap_end() on two file.  Thus,
we introduce iomap_apply2() to accept arguments from two files and
iomap_actor2_t for actions on two files.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/iomap/apply.c      | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/iomap.h |  7 +++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 26ab6563181f..fd2f8bde5791 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -97,3 +97,54 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 
 	return written ? written : ret;
 }
+
+loff_t
+iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2, loff_t pos2,
+		loff_t length, unsigned int flags, const struct iomap_ops *ops,
+		void *data, iomap_actor2_t actor)
+{
+	struct iomap smap = { .type = IOMAP_HOLE };
+	struct iomap dmap = { .type = IOMAP_HOLE };
+	loff_t written = 0, ret;
+
+	ret = ops->iomap_begin(ino1, pos1, length, 0, &smap, NULL);
+	if (ret)
+		goto out_src;
+	if (WARN_ON(smap.offset > pos1)) {
+		written = -EIO;
+		goto out_src;
+	}
+	if (WARN_ON(smap.length == 0)) {
+		written = -EIO;
+		goto out_src;
+	}
+
+	ret = ops->iomap_begin(ino2, pos2, length, 0, &dmap, NULL);
+	if (ret)
+		goto out_dest;
+	if (WARN_ON(dmap.offset > pos2)) {
+		written = -EIO;
+		goto out_dest;
+	}
+	if (WARN_ON(dmap.length == 0)) {
+		written = -EIO;
+		goto out_dest;
+	}
+
+	/* make sure extent length of two file is equal */
+	if (WARN_ON(smap.length != dmap.length)) {
+		written = -EIO;
+		goto out_dest;
+	}
+
+	written = actor(ino1, pos1, ino2, pos2, length, data, &smap, &dmap);
+
+out_dest:
+	if (ops->iomap_end)
+		ret = ops->iomap_end(ino2, pos2, length, 0, 0, &dmap);
+out_src:
+	if (ops->iomap_end)
+		ret = ops->iomap_end(ino1, pos1, length, 0, 0, &smap);
+
+	return ret;
+}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5bd3cac4df9c..913f98897a77 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -148,10 +148,15 @@ struct iomap_ops {
  */
 typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
 		void *data, struct iomap *iomap, struct iomap *srcmap);
-
+typedef loff_t (*iomap_actor2_t)(struct inode *ino1, loff_t pos1,
+		struct inode *ino2, loff_t pos2, loff_t len, void *data,
+		struct iomap *smap, struct iomap *dmap);
 loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
 		unsigned flags, const struct iomap_ops *ops, void *data,
 		iomap_actor_t actor);
+loff_t iomap_apply2(struct inode *ino1, loff_t pos1, struct inode *ino2,
+		loff_t pos2, loff_t length, unsigned int flags,
+		const struct iomap_ops *ops, void *data, iomap_actor2_t actor);
 
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
-- 
2.30.1


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
