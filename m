Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153363696B
	for <lists+linux-nvdimm@lfdr.de>; Thu,  6 Jun 2019 03:45:25 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE1E921290D2C;
	Wed,  5 Jun 2019 18:45:23 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=192.55.52.93; helo=mga11.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id F0B9F2128DD5C
 for <linux-nvdimm@lists.01.org>; Wed,  5 Jun 2019 18:45:21 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 18:45:21 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:20 -0700
From: ira.weiny@intel.com
To: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
 Dave Chinner <david@fromorbit.com>
Subject: [PATCH RFC 07/10] fs/ext4: Fail truncate if pages are GUP pinned
Date: Wed,  5 Jun 2019 18:45:40 -0700
Message-Id: <20190606014544.8339-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
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
Cc: linux-nvdimm@lists.01.org, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-xfs@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

From: Ira Weiny <ira.weiny@intel.com>

If pages are actively gup pinned fail the truncate operation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 75f543f384e4..1ded83ec08c0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4250,6 +4250,9 @@ int ext4_break_layouts(struct inode *inode, loff_t offset, loff_t len)
 		if (!page)
 			return 0;
 
+		if (page_gup_pinned(page))
+			return -ETXTBSY;
+
 		error = ___wait_var_event(&page->_refcount,
 				atomic_read(&page->_refcount) == 1,
 				TASK_INTERRUPTIBLE, 0, 0,
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
