Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87FF1A045
	for <lists+linux-nvdimm@lfdr.de>; Fri, 10 May 2019 17:33:32 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D0C8E21268FB6;
	Fri, 10 May 2019 08:33:30 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2001:41d0:602:dbe::8; helo=tartarus.angband.pl;
 envelope-from=kilobyte@angband.pl; receiver=linux-nvdimm@lists.01.org 
Received: from tartarus.angband.pl (tartarus.angband.pl
 [IPv6:2001:41d0:602:dbe::8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 0DF342122CA87
 for <linux-nvdimm@lists.01.org>; Fri, 10 May 2019 08:33:27 -0700 (PDT)
Received: from [2a02:a31c:853f:a300::4] (helo=valinor.angband.pl)
 by tartarus.angband.pl with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <kilobyte@angband.pl>)
 id 1hP7WH-0000MM-Hp; Fri, 10 May 2019 17:33:11 +0200
Received: from kilobyte by valinor.angband.pl with local (Exim 4.92)
 (envelope-from <kilobyte@valinor.angband.pl>)
 id 1hP7Vh-0006Qk-Qj; Fri, 10 May 2019 17:32:33 +0200
From: Adam Borowski <kilobyte@angband.pl>
To: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.de>,
 linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
 willy@infradead.org, hch@lst.de, darrick.wong@oracle.com, dsterba@suse.cz,
 nborisov@suse.com, linux-nvdimm@lists.01.org
Date: Fri, 10 May 2019 17:32:22 +0200
Message-Id: <20190510153222.24665-1-kilobyte@angband.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429172649.8288-13-rgoldwyn@suse.de>
References: <20190429172649.8288-13-rgoldwyn@suse.de>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:a31c:853f:a300::4
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on tartarus.angband.pl
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=8.0 tests=BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no languages=en
Subject: [PATCH for-goldwyn] btrfs: disallow MAP_SYNC outside of DAX mounts
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
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
Cc: Adam Borowski <kilobyte@angband.pl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Even if allocation is done synchronously, data would be lost except on
actual pmem.  Explicit msync()s don't need MAP_SYNC, and don't require
a sync per page.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
MAP_SYNC can't be allowed unconditionally, as cacheline flushes don't help
guarantee persistency in page cache.  This fixes an error in my earlier
patch "btrfs: allow MAP_SYNC mmap" -- you'd probably want to amend that.


 fs/btrfs/file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 362a9cf9dcb2..0bc5428037ba 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2233,6 +2233,13 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 	if (!IS_DAX(inode) && !mapping->a_ops->readpage)
 		return -ENOEXEC;
 
+	/*
+	 * Normal operation of btrfs is pretty much an antithesis of MAP_SYNC;
+	 * supporting it outside DAX is pointless.
+	 */
+	if (!IS_DAX(inode) && (vma->vm_flags & VM_SYNC))
+		return -EOPNOTSUPP;
+
 	file_accessed(filp);
 	if (IS_DAX(inode))
 		vma->vm_ops = &btrfs_dax_vm_ops;
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
