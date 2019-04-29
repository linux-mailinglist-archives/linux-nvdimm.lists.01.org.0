Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1458E8E5
	for <lists+linux-nvdimm@lfdr.de>; Mon, 29 Apr 2019 19:27:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8E8DF2121797B;
	Mon, 29 Apr 2019 10:27:46 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=rgoldwyn@suse.de;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 3FD9D2121797B
 for <linux-nvdimm@lists.01.org>; Mon, 29 Apr 2019 10:27:44 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id D4DE0AEA1;
 Mon, 29 Apr 2019 17:27:42 +0000 (UTC)
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/18] btrfs: trace functions for btrfs_iomap_begin/end
Date: Mon, 29 Apr 2019 12:26:49 -0500
Message-Id: <20190429172649.8288-19-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190429172649.8288-1-rgoldwyn@suse.de>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
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
Cc: kilobyte@angband.pl, jack@suse.cz, darrick.wong@oracle.com,
 nborisov@suse.com, linux-nvdimm@lists.01.org, david@fromorbit.com,
 dsterba@suse.cz, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 hch@lst.de, Goldwyn Rodrigues <rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is for debug purposes only and can be skipped.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/dax.c               |  3 +++
 include/trace/events/btrfs.h | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
index 20ec2ec49c68..3fee28f5a199 100644
--- a/fs/btrfs/dax.c
+++ b/fs/btrfs/dax.c
@@ -104,6 +104,8 @@ static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
 	u64 srcblk = 0;
 	loff_t diff;
 
+	trace_btrfs_iomap_begin(inode, pos, length, flags);
+
 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
 
 	iomap->type = IOMAP_MAPPED;
@@ -164,6 +166,7 @@ static int btrfs_iomap_end(struct inode *inode, loff_t pos,
 {
 	struct btrfs_iomap *bi = iomap->private;
 	u64 wend;
+	trace_btrfs_iomap_end(inode, pos, length, written, flags);
 
 	if (!bi)
 		return 0;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ab1cc33adbac..8779e5789a7c 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1850,6 +1850,62 @@ DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
 	TP_ARGS(bg_cache)
 );
 
+TRACE_EVENT(btrfs_iomap_begin,
+
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t length, int flags),
+
+	TP_ARGS(inode, pos, length, flags),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	ino		)
+		__field(	u64,	pos		)
+		__field(	u64,	length		)
+		__field(	int,    flags		)
+	),
+
+	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+		__entry->ino		= btrfs_ino(BTRFS_I(inode));
+		__entry->pos		= pos;
+		__entry->length		= length;
+		__entry->flags		= flags;
+	),
+
+	TP_printk_btrfs("ino=%llu pos=%llu len=%llu flags=0x%x",
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->length,
+		  __entry->flags)
+);
+
+TRACE_EVENT(btrfs_iomap_end,
+
+	TP_PROTO(const struct inode *inode, loff_t pos, loff_t length, loff_t written, int flags),
+
+	TP_ARGS(inode, pos, length, written, flags),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	ino		)
+		__field(	u64,	pos		)
+		__field(	u64,	length		)
+		__field(	u64,	written		)
+		__field(	int,    flags		)
+	),
+
+	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
+		__entry->ino		= btrfs_ino(BTRFS_I(inode));
+		__entry->pos		= pos;
+		__entry->length		= length;
+		__entry->written		= written;
+		__entry->flags		= flags;
+	),
+
+	TP_printk_btrfs("ino=%llu pos=%llu len=%llu written=%llu flags=0x%x",
+		  __entry->ino,
+		  __entry->pos,
+		  __entry->length,
+		  __entry->written,
+		  __entry->flags)
+);
 #endif /* _TRACE_BTRFS_H */
 
 /* This part must be outside protection */
-- 
2.16.4

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
