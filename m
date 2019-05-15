Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FA1FA94
	for <lists+linux-nvdimm@lfdr.de>; Wed, 15 May 2019 21:28:13 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73A4C2125ADFF;
	Wed, 15 May 2019 12:27:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=vgoyal@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 28974212794B0
 for <linux-nvdimm@lists.01.org>; Wed, 15 May 2019 12:27:35 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A70A3C05000D;
 Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C986060BF7;
 Wed, 15 May 2019 19:27:29 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 619CF2237E8; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From: Vivek Goyal <vgoyal@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
Date: Wed, 15 May 2019 15:26:47 -0400
Message-Id: <20190515192715.18000-3-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
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

If fuse daemon is started with cache=never, fuse falls back to direct IO.
In that write path we don't call file_remove_privs() and that means setuid
bit is not cleared if unpriviliged user writes to a file with setuid bit set.

pjdfstest chmod test 12.t tests this and fails.

Fix this by calling fuse_remove_privs() even for direct I/O path.

I tested this as follows.

- Run fuse example pasthrough fs.

  $ passthrough_ll /mnt/pasthrough-mnt -o default_permissions,allow_other,cache=never
  $ mkdir /mnt/pasthrough-mnt/testdir
  $ cd /mnt/pasthrough-mnt/testdir
  $ prove -rv pjdfstests/tests/chmod/12.t

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 06096b60f1df..5baf07fd2876 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1456,14 +1456,18 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Don't allow parallel writes to the same file */
 	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
-	if (res > 0) {
-		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
-			res = fuse_direct_IO(iocb, from);
-		} else {
-			res = fuse_direct_io(&io, from, &iocb->ki_pos,
-					     FUSE_DIO_WRITE);
-		}
+	if (res <= 0)
+		goto out;
+
+	res = file_remove_privs(iocb->ki_filp);
+	if (res)
+		goto out;
+	if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
+		res = fuse_direct_IO(iocb, from);
+	} else {
+		res = fuse_direct_io(&io, from, &iocb->ki_pos, FUSE_DIO_WRITE);
 	}
+out:
 	fuse_invalidate_attr(inode);
 	if (res > 0)
 		fuse_write_update_size(inode, iocb->ki_pos);
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
